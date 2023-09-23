Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8B17AC235
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 15:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjIWNOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 09:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjIWNOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 09:14:49 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99F3199;
        Sat, 23 Sep 2023 06:14:38 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c008d8fd07so60244531fa.1;
        Sat, 23 Sep 2023 06:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695474877; x=1696079677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2O84Olrgji0dplUaih9FZ5HqCL+isSXoo5opIqSD9tk=;
        b=aeXcKcUqqFOfRLigQsDSTBXW0Kd+wFNKu94poy2Cng8QPnE1Ff5Y3e8D7QLob4tjC/
         o4Zr3xi8BlnGRQobm35bsst6U80U7G5EqINOvXYmm7c4vsAnf3OUORRk/PId+wiKfNRB
         J/AXswpfzHiXcWfUECtE7dRS7b47139bDBBWsJJ05nMFVFSvU6K7SUE2isaV3INTTZwI
         6S6VJY2hGqfVQVsPeImsRFMBP42ZqQQzKm04FL0MaliM4+0G9bUbvYxf2VDk8JcS1Ldp
         JcpKwvwwSCD6BgCZ6CteQpiVFI3aoOCuLtSw5g0L/AwElg8TFzaksu5oCmC5i50OQ6Tx
         Jrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695474877; x=1696079677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2O84Olrgji0dplUaih9FZ5HqCL+isSXoo5opIqSD9tk=;
        b=N7at0p4kQcpDOLedV+im4VNQGDVsWUPegNEyjQCPFUPDZGLOBIrm+3Uxp8yWhWJEIR
         ZGqXQdffSKogQPCsrEvOYnl9mepfZiYk7MfI0BlX2AW7cC1udOiXDeciBVvFyqDULV3j
         reNy1RLwh014nKSkUM1WVLcWxpqSeisahS4PbqmKWty1REo6L+xl3kAb8QUJT4nkOf+/
         +XMbY79Rlej0Spo/lF0yKVr7D0yFCXnsjb/DaK880EcpQvbYowIaghltG51ZndkKVtqH
         g/EbUZScYjeffdMSTqV2YqeD5bbbeqDR4ATiBdHzpDVyq0LhEYwvhmfvnmPCDv48+cqm
         S9aA==
X-Gm-Message-State: AOJu0YxBePsnFcJ7JJPeEvJ5R81FmDJ8FcXngGxb7+YeeyXaztOIv2qV
        o75Y7+Eu7FCCOjwpUXSE8n1rgMw1QVY=
X-Google-Smtp-Source: AGHT+IHg+zM0GJOc24XFRIaA7ONZWbhpFwyDvcz8TPb20uWJE2B2ifW0ySLiYIjSPTbF9PFcXykb7w==
X-Received: by 2002:a05:6512:238f:b0:503:1992:4d63 with SMTP id c15-20020a056512238f00b0050319924d63mr2295747lfv.19.1695474876726;
        Sat, 23 Sep 2023 06:14:36 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id m1-20020ac24281000000b004ff96c09b47sm1080847lfh.260.2023.09.23.06.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 06:14:36 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] MPM pin mappings for MSM8226 and MSM8974
Date:   Sat, 23 Sep 2023 16:14:30 +0300
Message-Id: <20230923131432.21721-1-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the MPM wakeirq mappings for MSM8226 and MSM8974.

Changes in v2:
  - Add missing entry to MSM8226 mapping
  - Add Reviewed-by tag to MSM8974 patch

Matti Lehtimäki (2):
  pinctrl: qcom: msm8226: Add MPM pin mappings
  pinctrl: qcom: msm8974: Add MPM pin mappings

 drivers/pinctrl/qcom/pinctrl-msm8226.c | 12 ++++++++++++
 drivers/pinctrl/qcom/pinctrl-msm8x74.c | 12 ++++++++++++
 2 files changed, 24 insertions(+)

-- 
2.39.2

