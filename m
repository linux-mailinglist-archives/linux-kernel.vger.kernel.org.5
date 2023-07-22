Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4475175DEC5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 23:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjGVV7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 17:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjGVV7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 17:59:21 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE981FDC
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:59:08 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-3461053677eso7673605ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690063147; x=1690667947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lauvryu8+RbX4F+Ht5xLHh2lskvh455ipXTKcGMOp/A=;
        b=WQJSAZS/QFZogRrUnNVVA4Z9HR/apIXr9heJJY8reym+lUluCZjVpVTvYFki2M9QAJ
         KJFn3q7jYm12JP5F8xFP+SP0DrbS97Me4lmKeQw2NhrifvGQFOdgUE264B6wWNfAF4Ee
         Zqrd16xQ28G+Jvavb+4GKMdfw4OWH8L9TYiRsrq9+ZnsLk+bLCSKPln6d5Uy2ZyPOGiN
         jwTwwyRthVmLWoiwCGK1YxHw5VbfmVF7HT56i8iSpTEv+oC5m+Grc4pYDPzeOArPEQfg
         87mZCVaI0+woAWOgdznYRYIhPDp85q0sJMIljnBM2/JZi3Oc4KNenR/wwLuD19d4ERKW
         o5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690063147; x=1690667947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lauvryu8+RbX4F+Ht5xLHh2lskvh455ipXTKcGMOp/A=;
        b=MeBS4y1vApuL8FGqyLffpdQpRkqX0rK7vpsLK3AHMa7JQdVoadTAkmi3C6h2BopoTQ
         /PRkaTjedeIKG/uBkynjVgFTDRS0s7PvJ+ifItbfgRfVwNkIDhV+qkjdIVZI5mWnZdnn
         sN2LvlMjaFWhAOzu9wzNSDCS2NXnYzSs7KNJUw5Skhgc7ksjy1soY7EYivSK4ymcgfqe
         npCIvBsFpCnE8njqdolwUHqm0z1QyGpFt55mIo3Pv48tPEb/W+Os/cld7QGOUpANzkEE
         HdwbI6kuhNzVJSNn1tLy0NAjzOZHJZbKhTv7LikQ3xI3pJG2dQ9gV/AYitv/Q1FZ85lv
         DQ/w==
X-Gm-Message-State: ABy/qLZycEUma0ILHArAh2f6UjUxB3/jUcjAmfAo1b8uRVc1D1SxGEh/
        z2WGfaMxFoLjNTGj0Oe3Ihc=
X-Google-Smtp-Source: APBJJlFY8mNC3x+dU1aVMbXuCuG6KD3ZhpnnpHXe/AP6NEOc3uvjMGtemh9v0CoGKhXWBfFPaYPYLg==
X-Received: by 2002:a05:6e02:1242:b0:348:9dd1:7963 with SMTP id j2-20020a056e02124200b003489dd17963mr1893489ilq.7.1690063147698;
        Sat, 22 Jul 2023 14:59:07 -0700 (PDT)
Received: from localhost.localdomain ([161.97.244.155])
        by smtp.gmail.com with ESMTPSA id g15-20020a926b0f000000b0034285721db5sm1923590ilc.4.2023.07.22.14.59.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Jul 2023 14:59:07 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
To:     franziska.naepelt@googlemail.com
Cc:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 7/9] staging: rtl8723bs: ioctl_linux: Fix alignment on open parenthesis
Date:   Sat, 22 Jul 2023 23:59:05 +0200
Message-Id: <20230722215905.4383-1-franziska.naepelt@googlemail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230722215330.4114-1-franziska.naepelt@googlemail.com>
References: <20230722215330.4114-1-franziska.naepelt@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch issue:
- CHECK: Alignment should match open parenthesis

Signed-off-by: Franziska Naepelt <franziska.naepelt@googlemail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index e4c5e249df98..88f560353df7 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -147,7 +147,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 					psta->ieee8021x_blocked = false;
 
 				if ((padapter->securitypriv.ndisencryptstatus == Ndis802_11Encryption2Enabled) ||
-						(padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled)) {
+				    (padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled)) {
 					psta->dot118021XPrivacy = padapter->securitypriv.dot11PrivacyAlgrthm;
 				}
 
@@ -200,7 +200,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 					pbcmc_sta->ieee8021x_blocked = false;
 
 				if ((padapter->securitypriv.ndisencryptstatus == Ndis802_11Encryption2Enabled) ||
-						(padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled)) {
+				    (padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled)) {
 					pbcmc_sta->dot118021XPrivacy = padapter->securitypriv.dot11PrivacyAlgrthm;
 				}
 			}
@@ -334,8 +334,8 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 
 	/* TKIP and AES disallow multicast packets until installing group key */
 	if (padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_ ||
-		padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_WTMIC_ ||
-		padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)
+	    padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_WTMIC_ ||
+	    padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)
 		/* WPS open need to enable multicast */
 		/*  check_fwstate(&padapter->mlmepriv, WIFI_UNDER_WPS) == true) */
 		rtw_hal_set_hwreg(padapter, HW_VAR_OFF_RCR_AM, null_addr);
-- 
2.39.2 (Apple Git-143)

