Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FDA7C98CF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 13:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjJOL2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 07:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjJOL16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 07:27:58 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F93D9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 04:27:57 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a7cc03dee5so44265247b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 04:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697369276; x=1697974076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DO6KnUO6Wq3OltHCFgApO607UOe9P9M+L1ytJhSq08E=;
        b=iKJmgyCu5v1FjtsSTvMiyWIZMqAO8Z0VWfyUCj1nxmwwUlexpNL8MB5JXAGG3idpJ/
         7lSIaItVrFQSB1bKGZSllMhhIEQginECFjl7r7yrpWiJmnalqJKJythAUCBL3Ah/Qr9f
         LV7mSEe2Do8jWKThr/o8a2w88KaJl8mjreifqXXwoWjQ9o+msM04/hPuAGP5gfAaS8BF
         PglZuqVlzmN55LtdM7ZPE3oqJHTV6Rk/TZnnVu0QBq4owQbd25FzClSYIX8AfACCFrUH
         evYIwZ2aXghsGaJHrmgo6taNPlgx5d5MBXcmJSemrnsj23r49+ZC68aWCAiB4/GchKl+
         bulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697369276; x=1697974076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DO6KnUO6Wq3OltHCFgApO607UOe9P9M+L1ytJhSq08E=;
        b=RWnzLnqBwj4XhMi/j9vDQZLLMuyZ6Fp00O6xxipFjR2+U+8Kty6R7C4QlzJ/lbKiCJ
         u1xJBB4hxkf9e6Rw0L0SGGwmNNKHASsOEUaeXaZwl5MCA70aUv5XWoBrEyPJRlx862s0
         ZuEfywtTyxHnrSBOw3QrI1tzEpdATpDDzMtlB1gkVgbazCR4Q9bOWrKd2foD6vntE72L
         AF3roUZAZ2DeWU57SwfRYn6/hbVR1hZ/oYA84ZFJMOKiESQHxuVOd7DH6RtTuPU6Tywc
         1GWL+YP95seT916INnOMzUeVWwTQRVBtgRvoQ1mDiHarjfuUQfyl5I0Fic6PAi5kUvVN
         eoPg==
X-Gm-Message-State: AOJu0YzP0xrnilbs3jfjnWrowVU0JUIcwrr2UYa+E5zmWtAZJ0fG5hAf
        5juZZg6oK2UQ2KGSjybJmWw=
X-Google-Smtp-Source: AGHT+IEIMdX1ahZf9tXa89MB2N1rmLKvrFYHzhd+Do9bTNptfqAKUMTZd31vaqofKmFdYQcylRFW5Q==
X-Received: by 2002:a81:4326:0:b0:5a7:ab56:e081 with SMTP id q38-20020a814326000000b005a7ab56e081mr17808636ywa.19.1697369276231;
        Sun, 15 Oct 2023 04:27:56 -0700 (PDT)
Received: from gilbert-PC ([105.112.18.68])
        by smtp.gmail.com with ESMTPSA id w132-20020a0dd48a000000b005928ba6806dsm1318177ywd.97.2023.10.15.04.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 04:27:55 -0700 (PDT)
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gilbert Adikankwu <gilbertadikankwu@gmail.com>
Subject: [PATCH 2/6] staging: rtl8192u: Align descendant arguments
Date:   Sun, 15 Oct 2023 12:24:48 +0100
Message-Id: <0d2b5585a914d50305d0d2bade3f8d615615f26b.1697367161.git.gilbertadikankwu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1697367161.git.gilbertadikankwu@gmail.com>
References: <cover.1697367161.git.gilbertadikankwu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align descendant arguments to the open parenthesis as per the "Linux
Kernel coding style" in Documentation/process/coding-style.rst

Mute the following checkpatch error:

CHECK: Alignment should match open parenthesis

Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
---
 drivers/staging/rtl8192u/r8190_rtl8256.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8190_rtl8256.c b/drivers/staging/rtl8192u/r8190_rtl8256.c
index 54747fda552f..a81e88894e01 100644
--- a/drivers/staging/rtl8192u/r8190_rtl8256.c
+++ b/drivers/staging/rtl8192u/r8190_rtl8256.c
@@ -46,17 +46,17 @@ void phy_set_rf8256_bandwidth(struct net_device *dev, enum ht_channel_width Band
 				    priv->card_8192_version == VERSION_819XU_B) {
 					/* 8256 D-cut, E-cut, xiong: consider it later! */
 					rtl8192_phy_SetRFReg(dev,
-						(enum rf90_radio_path_e)eRFPath,
-						0x0b, bMask12Bits, 0x100); /* phy para:1ba */
+							     (enum rf90_radio_path_e)eRFPath,
+							     0x0b, bMask12Bits, 0x100); /* phy para:1ba */
 					rtl8192_phy_SetRFReg(dev,
-						(enum rf90_radio_path_e)eRFPath,
-						0x2c, bMask12Bits, 0x3d7);
+							     (enum rf90_radio_path_e)eRFPath,
+							     0x2c, bMask12Bits, 0x3d7);
 					rtl8192_phy_SetRFReg(dev,
-						(enum rf90_radio_path_e)eRFPath,
-						0x0e, bMask12Bits, 0x021);
+							     (enum rf90_radio_path_e)eRFPath,
+							     0x0e, bMask12Bits, 0x021);
 					rtl8192_phy_SetRFReg(dev,
-						(enum rf90_radio_path_e)eRFPath,
-						0x14, bMask12Bits, 0x5ab);
+							     (enum rf90_radio_path_e)eRFPath,
+							     0x14, bMask12Bits, 0x5ab);
 				} else {
 					RT_TRACE(COMP_ERR, "%s(): unknown hardware version\n", __func__);
 					}
-- 
2.34.1

