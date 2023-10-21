Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD2B7D2068
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 01:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjJUXNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 19:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjJUXNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 19:13:14 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA4110E6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 16:12:58 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31f71b25a99so1393542f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 16:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697929977; x=1698534777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amjkysvwGLDMqQy/BiqSp0BajkmyMximPs7WeghdDP8=;
        b=Vq9xzjuobKr5c0n73r5RHo/MavdItckh4TsNWKOiZtQk93k4bD/j5dQRsgVRwlB2jF
         /kqiDRKnarUTSBSG6bmz0OuXjZhnE3uT7tfog15pMXR0Mm1OyCt/NfTCp9Wr94qz/HiO
         BlkjCriDmoTg+kSzMdvxM19/Ptk5OGnpmc4UVkYNeSRID6yWdqorVUmVOP0B1VBUFgJy
         /bVk9YgPdFBATJoNktQ4fsguaFlEmmyAecq6rlDMIzd2A10ZIMzwp8O34Sy5gEFX2M6L
         9CKB8Wsjzb6lEDcrKUDP6BDRqjk8VpiK7K76wVLc3nnDoMzG2THtY/FcY1PaUIJqjflW
         8GsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697929977; x=1698534777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amjkysvwGLDMqQy/BiqSp0BajkmyMximPs7WeghdDP8=;
        b=AyVPKeQe8VPeLQiv9E8NUY0Wf5DSJ/cnc93CijQ9ptV0l4w9z/fTFh+Bqy+ktMCxAq
         yg5Qym8vSCfS0NcC+Jeggtpl78FvBbW/fi96D1r9YiqyhRSH5D+ZYI0jh84irP+KCAPK
         LKM6eBchvtYG8Fa7ri3dMtVV4sDVuFoF07MKvvwEt+wYZj8SnIzQEHnt7Z9EacxkMUQ1
         JjcDfqbWuCNS8vXVrMmxoHkY7ahSeGpOoP/3ijJI+F6WbksHdan+2oNq1Bh8bogdzWPk
         5n3Jst0xyCnKlLENxB0HvXGwEHMBWOK8Q+KLeij+R9f+b2DnLvhqwUf55OwJ233S8vm0
         3xTg==
X-Gm-Message-State: AOJu0Yxe0hng0fdXLHcET9rAgazOjkLAxOw+ZUTpPB4BuJ94xp1e5aKc
        oGrsWmK8KmRXu+vuCrnMAqKIar40Kni+tAMM
X-Google-Smtp-Source: AGHT+IF388wDyEcE44JY0oqc4aiVNscTJNQza6DDdkdC9cj3Y1sX7vvjrj6sCaTLdYDZdpuaze36Mw==
X-Received: by 2002:adf:f30e:0:b0:32d:a98c:aa1f with SMTP id i14-20020adff30e000000b0032da98caa1fmr3648237wro.1.1697929977124;
        Sat, 21 Oct 2023 16:12:57 -0700 (PDT)
Received: from gilbert-PC ([105.113.89.119])
        by smtp.gmail.com with ESMTPSA id w15-20020a5d608f000000b0032dbf32bd56sm4505098wrt.37.2023.10.21.16.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 16:12:56 -0700 (PDT)
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gilbert Adikankwu <gilbertadikankwu@gmail.com>
Subject: [PATCH 5/5] staging: vt6655: Rename variable byEIFS
Date:   Sun, 22 Oct 2023 00:12:31 +0100
Message-Id: <4428aa96453516b6706b1a834c46e3f6e70b5828.1697927812.git.gilbertadikankwu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1697927812.git.gilbertadikankwu@gmail.com>
References: <cover.1697927812.git.gilbertadikankwu@gmail.com>
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

Remove byte Type encoding "by" from variable name and replace camelcase
with snakecase.

Fix checkpatch.pl error:
	CHECK: Avoid CamelCase: <byEIFS>

Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
---
 drivers/staging/vt6655/card.c   | 6 +++---
 drivers/staging/vt6655/device.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 9c8648ea96be..079fd01c6780 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -250,9 +250,9 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 		priv->difs = difs;
 		iowrite8(priv->difs, priv->port_offset + MAC_REG_DIFS);
 	}
-	if (priv->byEIFS != C_EIFS) {
-		priv->byEIFS = C_EIFS;
-		iowrite8(priv->byEIFS, priv->port_offset + MAC_REG_EIFS);
+	if (priv->eifs != C_EIFS) {
+		priv->eifs = C_EIFS;
+		iowrite8(priv->eifs, priv->port_offset + MAC_REG_EIFS);
 	}
 	if (priv->slot != slot) {
 		priv->slot = slot;
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 264bb056c80c..7773b19a5788 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -183,7 +183,7 @@ struct vnt_private {
 	/* PHY parameter */
 	unsigned char sifs;
 	unsigned char difs;
-	unsigned char byEIFS;
+	unsigned char eifs;
 	unsigned char slot;
 	unsigned char cw_max_min;
 
-- 
2.34.1

