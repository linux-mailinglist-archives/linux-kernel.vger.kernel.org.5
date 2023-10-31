Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E7A7DC5F9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjJaFfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjJaFfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:35:24 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A4CF1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:35:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc0e78ec92so32328015ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698730485; x=1699335285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mN/MvU9MLPHLAEGw0iR4UGx3aKzLloZYmaIYA+TmX30=;
        b=bJVXSfszbot3TlfBfKGYywe2l8Nut41d1P88FqB2dnrrjW0n7W0cFC34KKixo3ftwb
         kghvGIB0Iut8bqBRCDARgRAs6N2jll/Ww71qvzbpmzXaE2u80hO4R7KT65MRG/sESCUL
         qZY2c8v1BbtaPWGBGL39s+s5EGv5tdteHgUio/HHxOcSx8KJVM3ySF1h5yjC1bEPEujn
         MSYOjkSx3G1r4XVZHmJbhs1SYasd7GCJhbDpOESd5sD7aoptdjByUVIIc1XvFoOxfBUW
         cc0Thz1L0JhyK3dVW+sDv0QV5o9kw3O4IO3VYuBYa9lZYiR6zhBpbLUdOxkWSPOoFup1
         BW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698730485; x=1699335285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mN/MvU9MLPHLAEGw0iR4UGx3aKzLloZYmaIYA+TmX30=;
        b=icLLwFCOHJvuOzRb8r5tUM1qtioYMnH2a8qZ7cb5iYiCsFGL4BSu/ux9F5rclh+o0H
         PtjKXmx1WBdXw0qIOj5cu7ktwYfmGy70puvNtKrYX6cNJCAoggMGPWQNEoMYvmAW1ynU
         K3172iKYoGpHjbcyn47pakqWNSX35KcG91q5YtheFR2EA8NDf0ZPexezOwBTLvZSFt0z
         mPWLOrhWgG7pDx5GsBIST92sIWGdyLdU1iBVvLFzYpBXmhXMMCgMvMcSDBF4yGeuNLVz
         SfbYoUTxMfHHDBoBwJqo7nM4ooQvo5m0WnQpJd2M8npJda5QiGd8L7GlrO/cA2Coow7t
         aEVw==
X-Gm-Message-State: AOJu0YwS+wpC1KYd0y8cvUgy+BL9N3H7ULawFqqzeUCRNjs3rXUHuPPe
        yIdJUFbdABnNXGKX3vU+3HO/bDQnc9w=
X-Google-Smtp-Source: AGHT+IGNYXvbnfinJUxW935i20mLBwO0UkAc3VIb1kvnGtS6KkaPW5o/jjGhhna8rM+wwtwAzFiGqA==
X-Received: by 2002:a17:902:d491:b0:1cc:50f6:7fcc with SMTP id c17-20020a170902d49100b001cc50f67fccmr4334454plg.55.1698730485502;
        Mon, 30 Oct 2023 22:34:45 -0700 (PDT)
Received: from ubuntu.. ([122.182.231.82])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001c0a414695bsm422211pld.43.2023.10.30.22.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 22:34:45 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH 02/11] staging: vt6655: Type encoding info dropped from variable name "qwTSFOffset"
Date:   Tue, 31 Oct 2023 11:04:25 +0530
Message-Id: <035b910c92233a7252a4b312e0cfe5adbcbbae79.1698730318.git.opensource206@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1698730318.git.opensource206@gmail.com>
References: <cover.1698730318.git.opensource206@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

variable name "qwTSFOffset" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/card.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 59a788b7e268..e0af14eb7cd4 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -291,17 +291,17 @@ bool card_update_tsf(struct vnt_private *priv, unsigned char rx_rate,
 		    u64 bss_timestamp)
 {
 	u64 local_tsf;
-	u64 qwTSFOffset = 0;
+	u64 tsf_offset = 0;
 
 	local_tsf = vt6655_get_current_tsf(priv);
 
 	if (bss_timestamp != local_tsf) {
-		qwTSFOffset = CARDqGetTSFOffset(rx_rate, bss_timestamp,
+		tsf_offset = CARDqGetTSFOffset(rx_rate, bss_timestamp,
 						local_tsf);
 		/* adjust TSF, HW's TSF add TSF Offset reg */
-		qwTSFOffset =  le64_to_cpu(qwTSFOffset);
-		iowrite32((u32)qwTSFOffset, priv->port_offset + MAC_REG_TSFOFST);
-		iowrite32((u32)(qwTSFOffset >> 32), priv->port_offset + MAC_REG_TSFOFST + 4);
+		tsf_offset =  le64_to_cpu(tsf_offset);
+		iowrite32((u32)tsf_offset, priv->port_offset + MAC_REG_TSFOFST);
+		iowrite32((u32)(tsf_offset >> 32), priv->port_offset + MAC_REG_TSFOFST + 4);
 		vt6655_mac_reg_bits_on(priv->port_offset, MAC_REG_TFTCTL, TFTCTL_TSFSYNCEN);
 	}
 	return true;
-- 
2.34.1

