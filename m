Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575917E0E90
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 10:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjKDJRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 05:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjKDJQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 05:16:52 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152AF1BF
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 02:16:28 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc5b705769so25607095ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 02:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699089387; x=1699694187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SLNQXwvsmuV3fVIiwVg4eaHyhonWOyCC10q8MYVA8E8=;
        b=MtMgam8o+3y23wLubmu2Met3dmmSp5k1T27AY9yRvH6jq1d3c8n4pwEixLB5n8dvUb
         8RIvBiEopV8pdyatqcjHSDOzDEY4LleRDBBs3j4aG3rz3/PJNlIJ3QX9twdwSEs6tjpL
         9JAC7UeVje7kw+KwhWC+E0aeg+I+uLajEH3XZgvOHRJMZVQm69oUdDkuxj07qNRDgcdU
         Gda7zCT9dbtxOQNj5suysj4Cr6n17vAY3uR7SpFTotFjFgLWD9UEM+aWIwm7wP94M/0j
         tRhbVQw7bmzy1GtL76RMW8tcAFvMJ9InMVbRX9C7TgF+TIqPjM2HNRx1m0yzo9h+3yET
         JUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699089387; x=1699694187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SLNQXwvsmuV3fVIiwVg4eaHyhonWOyCC10q8MYVA8E8=;
        b=g6t2dBXJXYKHNjXAidqslFjieiBPkEyL2wAxmwMyLyv/4vrA18uTKRU0FVlBt8MRBV
         uPeEq2ycwjDijwV3lqP3T4wdddUV0s7fTc561v4w51Gf3EH3P2B6z10fgjhtucaiRMZ/
         nzr9Jwy3d7VabqgtFDU3EcSEIrS3cF3ghOAsKJqXbjy0qC20ee+5Oah6QFA8hVUU8+SF
         892R/Mhdqasn6OOCIpIHZ6L3eryxQXbN0MxPSdhjwzszFZSujjxCunndQjjn+ufGFq3w
         tOivr144wDf4oSOArpdY6HZuHQFUs+FRiR5QFNPYzoOzIF8PstQE/CtbVQBSRRPPPhic
         QWfA==
X-Gm-Message-State: AOJu0Yw8HZKdSM4amRwmOfEm0H1N7bcaEG+o1+/N49VYskgAdi/6gc3E
        XWy717GzoI1Wt1xDsGyZsaNRwA==
X-Google-Smtp-Source: AGHT+IHbBh3J3IRfyxckxOWlsKX9sadU7+kPzJ+J9v34NvpVCI+Bhzyj9lMKHXCD1k0j5ZNgkIMKOQ==
X-Received: by 2002:a17:902:f213:b0:1bc:6c8:cded with SMTP id m19-20020a170902f21300b001bc06c8cdedmr22211228plc.67.1699089387534;
        Sat, 04 Nov 2023 02:16:27 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b001cc54202429sm2585127plh.288.2023.11.04.02.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 02:16:27 -0700 (PDT)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     vgupta@kernel.org, bcain@quicinc.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        geert@linux-m68k.org, andi.shyti@linux.intel.com, mingo@kernel.org,
        palmer@rivosinc.com, andrzej.hajda@intel.com, arnd@arndb.de,
        peterz@infradead.orgm, mhiramat@kernel.org
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mattwu@163.com,
        linux@roeck-us.ne, "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v2 0/4] locking/atomic: arch_cmpxchg[64]_local undefined
Date:   Sat,  4 Nov 2023 17:16:11 +0800
Message-Id: <20231104091615.4884-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series implement arch_cmpxchg[64]_local for arc,
openrisc and hexagon.

For architectures that support native cmpxchg, we'd like to
implement arch_cmpxchg[64]_local with the native variants of
supported data size. If not, the generci_cmpxchg[64]_local
will be used.

wuqiang.matt (4):
  locking/atomic: arc: data size checking in arch_cmpxchg
  locking/atomic: arc: arch_cmpxchg[64]_local undefined
  locking/atomic: openrisc: arch_cmpxchg[64]_local undefined
  locking/atomic: hexagon: arch_cmpxchg[64]_local undefined

 arch/arc/include/asm/cmpxchg.h      | 40 ++++++++++++++++++----
 arch/hexagon/include/asm/cmpxchg.h  | 51 ++++++++++++++++++++++++++++-
 arch/openrisc/include/asm/cmpxchg.h |  6 ++++
 3 files changed, 90 insertions(+), 7 deletions(-)

-- 
2.40.1

