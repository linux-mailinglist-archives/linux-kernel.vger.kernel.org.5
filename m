Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855037DC5F0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjJaFfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJaFfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:35:13 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010A6DF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:35:10 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc2fc281cdso19321175ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698730499; x=1699335299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chNs6Qc+1FG5MNRfJZOW4RScvr4v+fqdqp2PEyYmdAc=;
        b=Go1IDAI4XeBiYo45IOOvYNI6R9brQOQQ99lw0Rt4xUyx9ohdtVr+N4kttSyryxezNB
         P9xVTU/YcvlHmjWbaQl0NwK+c9+eTsPPwT4mDhKy8bI60H0dwZve9ttjP9rKYp3Iipj0
         5R3HlIDExxFNsaM7PV5yAPDenj2GDGqKnZJU53LaOXTokh49HjvjwB4+IwlVQIhQQR7M
         u5gCu5Cr/ITf1sMvKSlbMeJZF/yO3EZ3XHIPWYQovLClH8xSSczU6H5qTVvMMvTlUjp8
         WymTsryN93sVNSY3PySuOqBN2CBUx0H013BMs0sK1APwvBH+qpPBFljLVlBXWD3mCu1s
         ilSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698730499; x=1699335299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chNs6Qc+1FG5MNRfJZOW4RScvr4v+fqdqp2PEyYmdAc=;
        b=ph2B7u9oPLuAehoHQ7Fu/Ami9sW4JX2dQOTFaRPtPuDra3p46QgeIgFnWOtdVgbMBf
         8js0Oa+38Y8AcAEKmN5XAD8PezaV/weBMHLm8eL+su9hpv3DfbLfZKd+ZZssgmRVfDJ1
         chwr+LoXmYw8AocFkVhoEzwsvkKoVe2C4xf2MlE1/0lbWmhcx5Ksocw4xLtQMzARciKN
         yVj5WFq9ny5tkYbaWPuhGyhslMe3unRQBdHLmKqWg5aiBsXMoVMzSLbb214+bfEHq/0U
         mx+ubnk6f/dZC8YhXoPX+StGMu3z7iuUwnWd9fu8UzHxizoHs8nTtXYfW44kkhZr54LF
         a2aQ==
X-Gm-Message-State: AOJu0YzZ0un+heT2pBDLwfJJqpdbE/LfD/wJUlfaDarchkOGmwLcJm3K
        FrojXsiCKICfrwMr3nWdCck=
X-Google-Smtp-Source: AGHT+IFNGQ3+AMxG0ca79zSTJ/KrvclsNhqovQ/kVJHj73tDoYlvRBDp51qa+I4nnGMByS1WEcfAng==
X-Received: by 2002:a17:902:a510:b0:1bb:b855:db3c with SMTP id s16-20020a170902a51000b001bbb855db3cmr7369388plq.41.1698730499022;
        Mon, 30 Oct 2023 22:34:59 -0700 (PDT)
Received: from ubuntu.. ([122.182.231.82])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001c0a414695bsm422211pld.43.2023.10.30.22.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 22:34:58 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH 09/11] staging: vt6655: Type encoding info dropped from function name "CARDvSafeResetTx"
Date:   Tue, 31 Oct 2023 11:04:32 +0530
Message-Id: <785a163ab01555bd0a7ed87484d727560d22cd95.1698730318.git.opensource206@gmail.com>
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

function name "CARDvSafeResetTx" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/card.c        | 2 +-
 drivers/staging/vt6655/card.h        | 2 +-
 drivers/staging/vt6655/device_main.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 7980b93d2b1e..b249f22246b0 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -382,7 +382,7 @@ void card_radio_power_off(struct vnt_private *priv)
 	vt6655_mac_reg_bits_on(priv->port_offset, MAC_REG_GPIOCTL0, LED_ACTSET);  /* LED issue */
 }
 
-void CARDvSafeResetTx(struct vnt_private *priv)
+void card_safe_reset_tx(struct vnt_private *priv)
 {
 	unsigned int uu;
 	struct vnt_tx_desc *pCurrTD;
diff --git a/drivers/staging/vt6655/card.h b/drivers/staging/vt6655/card.h
index 5ca715b415e8..f52e42564e81 100644
--- a/drivers/staging/vt6655/card.h
+++ b/drivers/staging/vt6655/card.h
@@ -50,7 +50,7 @@ u64 vt6655_get_current_tsf(struct vnt_private *priv);
 u64 card_get_next_tbtt(u64 qwTSF, unsigned short beacon_interval);
 u64 card_get_tsf_offset(unsigned char rx_rate, u64 qwTSF1, u64 qwTSF2);
 unsigned char card_get_pkt_type(struct vnt_private *priv);
-void CARDvSafeResetTx(struct vnt_private *priv);
+void card_safe_reset_tx(struct vnt_private *priv);
 void CARDvSafeResetRx(struct vnt_private *priv);
 void card_radio_power_off(struct vnt_private *priv);
 bool card_set_phy_parameter(struct vnt_private *priv, u8 bb_type);
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 210c94312310..a1f3dc25ad0e 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -463,7 +463,7 @@ static void device_init_registers(struct vnt_private *priv)
 	/* reset Tx pointer */
 	CARDvSafeResetRx(priv);
 	/* reset Rx pointer */
-	CARDvSafeResetTx(priv);
+	card_safe_reset_tx(priv);
 
 	if (priv->local_id <= REV_ID_VT3253_A1)
 		vt6655_mac_reg_bits_on(priv->port_offset, MAC_REG_RCR, RCR_WPAERR);
-- 
2.34.1

