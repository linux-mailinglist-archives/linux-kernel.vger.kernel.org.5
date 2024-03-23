Return-Path: <linux-kernel+bounces-112128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8324E8875FE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 01:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D566283F33
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4470624;
	Sat, 23 Mar 2024 00:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljfp-xyz.20230601.gappssmtp.com header.i=@ljfp-xyz.20230601.gappssmtp.com header.b="hjtp3NSD"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913AC37C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 00:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711153035; cv=none; b=L/CcJWPkhqFpy/2mIAO2xpxcs+aSnWRz+3YytQoL226S3DDPVMqUoEU9rGVkzvbaqeg6/RiDkMap0MCbbbDDrSsUEWwCZIRO0SRHXNJSxoPe6gOtZx9JTsoYchXnWbCuVY8lfwsgihYQqqEVvQeVph4gNCY8n6Dsh94cVO5ZJtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711153035; c=relaxed/simple;
	bh=0OMZcwDFr1Fjm7wwtKdnzOE9QDqpNrV2qZeBlfAl5KM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KHirHP5Pp6r7zljEOhv3HMAISAjUJdUfaT5V3lDshTCWpA8Cl0vfE1w+k6MadYt9ZhR1aw9XZ05WCU9Mkz3fnH+RfdmD//CB1hJgudZmoTVJYa0bul3Aiuju7FJXwiFId9sNNaUu4LKgaskXGdxmY3yuVHU7JO+4LFooK+Z97Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljfp.xyz; spf=pass smtp.mailfrom=ljfp.xyz; dkim=pass (2048-bit key) header.d=ljfp-xyz.20230601.gappssmtp.com header.i=@ljfp-xyz.20230601.gappssmtp.com header.b=hjtp3NSD; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljfp.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ljfp.xyz
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e703e0e5deso1882910b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ljfp-xyz.20230601.gappssmtp.com; s=20230601; t=1711153032; x=1711757832; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jtUcaHyseUXweyRYaiTqqu2kRbS7Ms0ptzh1c3Y3PjM=;
        b=hjtp3NSDKNOoSGKr9MkeiPLcoiPXhHYo7O0IznOZe1KpKbqxRJi38sXmqzaIGQVeUk
         DD9xXYcxK3AEWrvwfybuWRP1w8tK7ogthuokFo0u6kwaL83pHy6JBtuiM8Bl6/tIfj33
         NMLrg7bdn6r2iyFaC72DQqquhNbw9QDcjQHaCwhkr5fjyUCPiGk9UqGL65XcL26LQo8f
         asvo1JSNKcYOGvx5H87t+VTtusor4hZIZ46qCp2BAezhz+GFcgG63Ip34aDRFo1ddsAB
         vNA+xoWNsZbCRETVGcLcGLFsANz01VUnBR+IjzCzFaai0kWnf0KIryB3eGm+3PD3f7E1
         K5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711153032; x=1711757832;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jtUcaHyseUXweyRYaiTqqu2kRbS7Ms0ptzh1c3Y3PjM=;
        b=oI7HrDGd5Ace+pJfhQLrFQMGK7g3D/KgZNLqejPtYuv/cJQO14j7BRRhE5Qo7xo144
         Xf9ZMVpMIGeikT1i38Hs2YqgwAwCihQGN7YWDnihOFQmKHXfBqMMpdAScxf0uuClyYYG
         AzceKaY8e3oPoJ5ZY6qa3xGY5rjgusAUazVkzL3xUFwwNGg3162Mc8B9BoK1bRjOF0gn
         w3sN9kj9JxkVDrpdxAv4OnTtQmmJnDOCyThfuuKyzvVbDsB2ShsZ/2G/awZldjJvZ66N
         mKiGHM6yG7ANEI17XhoN/HEKfeKOVsAhvAmvfgKi5/g9BL/8xsxnsv8d871OP8by2VDf
         gtIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRwVTemeFcb3niclIWBtSRHx5vc2MAM8NRfS8MheQzVRu9BVvXuTVuzHASXoy/BwWGXfg1tO8Wchp3jDaai5znV/wOeep5Li1Nfwfh
X-Gm-Message-State: AOJu0Yw+eD6ptQzWm+0N7LqckkGjaj6pk7K93pXVJwk8xOsRxrxsHPdA
	2IFlNK1n0bObdfFAVC+AjvCxHHur6UzHH6N8lh/NNotd5/9OzWxAIsekQ7094/NyNlUSMtL9pkZ
	+P57abw==
X-Google-Smtp-Source: AGHT+IEulyMqJNDwt9n7rnNCCuupAErROONRLeyTl37B4SE9RBJwh5qXKcW3cENlPSAMXwEAA0oedA==
X-Received: by 2002:a05:6a00:2305:b0:6e8:acde:85c8 with SMTP id h5-20020a056a00230500b006e8acde85c8mr1436134pfh.8.1711153031810;
        Fri, 22 Mar 2024 17:17:11 -0700 (PDT)
Received: from pop-os ([181.165.36.123])
        by smtp.gmail.com with ESMTPSA id gr6-20020a056a004d0600b006ea7d877191sm345584pfb.2.2024.03.22.17.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 17:17:11 -0700 (PDT)
Date: Fri, 22 Mar 2024 21:17:09 -0300
From: Lautaro Javier Fernandez Pricco <ljfp@ljfp.xyz>
To: Larry Finger <Larry.Finger@lwfinger.net>,
	Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	outreachy <outreachy@lists.linux.dev>
Cc: linux-staging <linux-staging@lists.linux.dev>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] staging: rtl8712: Rename variable bw_40MHz_en
Message-ID: <Zf4fhSomoYzCE4gW@ljfp.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The bw_40MHz_en variable triggered an 'Avoid
CamelCase' warning from checkpatch.pl. This patch addresses said warning by
renaming the variable to bw_40mhz_en.

Reported by checkpatch:
CHECK: Avoid CamelCase: <bw_40MHz_en>

Signed-off-by: Lautaro Javier Fernandez Pricco <ljfp@ljfp.xyz>
---
 drivers/staging/rtl8712/hal_init.c        | 2 +-
 drivers/staging/rtl8712/rtl8712_hal.h     | 2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8712/hal_init.c b/drivers/staging/rtl8712/hal_init.c
index 1148075f0cd6..efea4f97488c 100644
--- a/drivers/staging/rtl8712/hal_init.c
+++ b/drivers/staging/rtl8712/hal_init.c
@@ -98,7 +98,7 @@ static void fill_fwpriv(struct _adapter *adapter, struct fw_priv *fwpriv)
 	/* todo: check if needs endian conversion */
 	fwpriv->hci_sel =  RTL8712_HCI_TYPE_72USB;
 	fwpriv->usb_ep_num = (u8)dvobj->nr_endpoint;
-	fwpriv->bw_40MHz_en = regpriv->cbw40_enable;
+	fwpriv->bw_40mhz_en = regpriv->cbw40_enable;
 	switch (regpriv->rf_config) {
 	case RTL8712_RF_1T1R:
 		fwpriv->rf_config = RTL8712_RFC_1T1R;
diff --git a/drivers/staging/rtl8712/rtl8712_hal.h b/drivers/staging/rtl8712/rtl8712_hal.h
index 66cc4645e2d1..3df687fce79d 100644
--- a/drivers/staging/rtl8712/rtl8712_hal.h
+++ b/drivers/staging/rtl8712/rtl8712_hal.h
@@ -85,7 +85,7 @@ struct fw_priv {   /*8-bytes alignment required*/
 	unsigned char rsvd025;
 	/*--- long word 3 ----*/
 	unsigned char qos_en;    /*1: QoS enable*/
-	unsigned char bw_40MHz_en;   /*1: 40MHz BW enable*/
+	unsigned char bw_40mhz_en;   /*1: 40MHz BW enable*/
 	unsigned char AMSDU2AMPDU_en;   /*1: 4181 convert AMSDU to AMPDU,
 					 * 0: disable
 					 */
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index bfb27f902753..0e5b07ad5a8f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2331,7 +2331,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 		}
 	}
 
-	/* to disable 40M Hz support while gd_bw_40MHz_en = 0 */
+	/* to disable 40 MHz support while gd_bw_40mhz_en = 0 */
 	if (channel > 14) {
 		if ((pregistrypriv->bw_mode & 0xf0) > 0)
 			cbw40_enable = 1;
-- 
2.34.1


