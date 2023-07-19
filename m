Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE5F7595EE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 14:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjGSMxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 08:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGSMxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 08:53:00 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB92113;
        Wed, 19 Jul 2023 05:52:59 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-53482b44007so4246887a12.2;
        Wed, 19 Jul 2023 05:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689771179; x=1690375979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ORmNTDEPuiXr5MQMrZYwdQ/7w0rdL3GvI/IS1eUVHPg=;
        b=STQfUOWpSGSpXO1Q6TbQhkTDcLFeUCn98nbfQ2FhhgH1lqBvPJHN42SQe+E7rSfvo0
         FppTg/6RDfh+Xddkt8AiCpF3k0dNQgXorMpvIcjilKllwhd2W6xFcXbaRpuGqDVaNqcy
         +698JTQqgtcsqqN3Dhzm6mJBJvh47KBR4T0b2yNSRJaN3samAbhoqXnA4jdm2KPYutO+
         TN/CFmpFwiwf1J8XR4w0/dWlsot16sYS6av7XVCl4dN1/jKXQUODk+2BR6w8W8lboZD2
         8ZSddYQdZxp+8a2XvI1CoM8QeJ1xA9VjCHMZ5IlexAFdKGJmJah4Y6Lte5INtteQLRGo
         3paQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689771179; x=1690375979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORmNTDEPuiXr5MQMrZYwdQ/7w0rdL3GvI/IS1eUVHPg=;
        b=cVn38e9kLWtp3bSaFEs4gnSmD/xn9T6wECNZ6z+6Wf4HdTzQT5EJ9N+3kvpEnmlZ9L
         G7SWPzs5fKVbCh+Oj6jN+LwN3tSSHO1P0cSI+CYlTT/9Y/plX6DQwi5qnBv0vEFNTchP
         L2iTYCXSLQiECGRz0Ki4xnqAe4LWVKXtwp3L0QDYYy+W/qZBa33nb3Uv1pY3o8k7Mqqj
         KCCTF+nZH9cr3MW09gKmhqK4LPRP4uzgL7k6rAFlVdxTZxteOZnHYqfvFYBBAEn1uTbC
         LhfQqVw/lR9yDr5aJcGChXcTwswgg166lpqPtkJgiaY2kiBoFBEcwJiksLQUOPpeUmQA
         S7Kw==
X-Gm-Message-State: ABy/qLYL3DEGdyL4Ao7zhtHKYnkUuzLVffiTMoDtYUF4vopqJqpZLFDt
        VC4CupEP+qpOSr7xObKpaY8=
X-Google-Smtp-Source: APBJJlF4PdBUSDKfe+myk08P8+QIMkEBsCSpcYsT6Fs8z8+U+Kl1bYnKlxrPfHLADX4V7A1tCrzvKg==
X-Received: by 2002:a17:90b:360e:b0:263:f75b:c33f with SMTP id ml14-20020a17090b360e00b00263f75bc33fmr1593667pjb.45.1689771178638;
        Wed, 19 Jul 2023 05:52:58 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id lc14-20020a17090b158e00b002612150d958sm1146191pjb.16.2023.07.19.05.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 05:52:58 -0700 (PDT)
From:   Leon Hwang <hffilwlqm@gmail.com>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
        hffilwlqm@gmail.com, tangyeechou@gmail.com,
        kernel-patches-bot@fb.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH bpf-next v3 0/2] bpf, xdp: Add tracepoint to xdp attaching failure
Date:   Wed, 19 Jul 2023 20:52:30 +0800
Message-ID: <20230719125232.92607-1-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces a new tracepoint in bpf_xdp_link_attach(). By
this tracepoint, error message will be captured when error happens in
dev_xdp_attach(), e.g. invalid attaching flags.

Leon Hwang (2):
  bpf, xdp: Add tracepoint to xdp attaching failure
  selftests/bpf: Add testcase for xdp attaching failure tracepoint

 include/trace/events/xdp.h                    | 17 +++++
 net/core/dev.c                                |  5 +-
 .../selftests/bpf/prog_tests/xdp_attach.c     | 63 +++++++++++++++++++
 .../bpf/progs/test_xdp_attach_fail.c          | 51 +++++++++++++++
 4 files changed, 135 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c


base-commit: 0858a95ec7491a7a5bfca4be9736dba4ee38c461
-- 
2.41.0

