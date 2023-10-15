Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59837C98C9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 13:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjJOLRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 07:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOLRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 07:17:11 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81693C5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 04:17:08 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59b5484fbe6so44375467b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 04:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697368627; x=1697973427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DO6KnUO6Wq3OltHCFgApO607UOe9P9M+L1ytJhSq08E=;
        b=G+FNdxpGZSeknpzPtuA4WAQLFlgd460KlNVMRQ5HCxgMr03T/FCWxZwqgor9Zuj+71
         JvJsRT+PMQnWR0G++MurradwtGUxWn4cW35rmDpO8esHj1o4qZF71jruY4FDfi9wiJ9A
         syWEuR3vCcUPKqJeJ2PaKcRCrkIvnbNEJEYKMY9LPjCKVzBBFMruFykfwqu6m2cKs1g1
         bbrrDZZWSZ+ydxjRsbLfpnu8qeTOgTqzdIf0gYhi399+Lnvs0js+EgBJjtb4tjVQEpkL
         4YfXHqaBjUoFd0qV1VADNp8Z0y2bOXiKWTubRvOCjAi2+QRBODbpyrlnrP3BkliEoaAD
         apyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697368627; x=1697973427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DO6KnUO6Wq3OltHCFgApO607UOe9P9M+L1ytJhSq08E=;
        b=oyI+Oy8dDlPfxWVNiBlFesxrSij+0flU5I2cH6ehLDDTk+zMXPG/n0ZLLrkRN8T41z
         6DYQKC1X0HqPZPRAVikKehkK+3ozCYAkjYG6GhZtdUYrSON967qfXli0Mx1MrBc94Mu3
         jiXgK+NItTfv9DTlY/7UgJ2SYgnWDuzxiWb6uhsa2pwMNTqaLasqFcjvGWi2SDzitdLJ
         YGVRjK6gMUkCkNkdYvAPivbOnG0JJZVFZKcibOO/rRNmB6AGjSpYDStif0EdCvCOHwjo
         uR1a5WlP658m/ZIbiUj+N2nKKYeLCMdC2IH2XdW1hbjtOMgZndRmkuvKOyCI8NeBQTaN
         1xfQ==
X-Gm-Message-State: AOJu0YwXP6M8VarDuhr9GVgMppl+NNy12/viVATjKduBo4Wfit71YVEY
        U+LXINfzxkLyRQ78odQb2Y8=
X-Google-Smtp-Source: AGHT+IH0B8YHosoBm8Xz2MXZnwtWpdPuBdtqddsjOIrdfiC6lM/3CG/dVtxA3ypzEL4bqYeunPnytg==
X-Received: by 2002:a05:690c:ec5:b0:5a7:f002:4fe4 with SMTP id cs5-20020a05690c0ec500b005a7f0024fe4mr16228024ywb.23.1697368627653;
        Sun, 15 Oct 2023 04:17:07 -0700 (PDT)
Received: from gilbert-PC ([105.112.18.68])
        by smtp.gmail.com with ESMTPSA id i132-20020a81548a000000b005a7d9fca87dsm1294142ywb.107.2023.10.15.04.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 04:17:06 -0700 (PDT)
Date:   Sun, 15 Oct 2023 12:17:00 +0100
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] staging: rtl8192u: Align descendant arguments
Message-ID: <0d2b5585a914d50305d0d2bade3f8d615615f26b.1697367161.git.gilbertadikankwu@gmail.com>
References: <cover.1697367161.git.gilbertadikankwu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697367161.git.gilbertadikankwu@gmail.com>
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

