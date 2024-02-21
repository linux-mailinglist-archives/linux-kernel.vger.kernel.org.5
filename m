Return-Path: <linux-kernel+bounces-75566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D534D85EB2D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F282B25293
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE73128373;
	Wed, 21 Feb 2024 21:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJuNH3Y4"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8AF1272CB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708551925; cv=none; b=UMJSX8Qc1nJfRJImzIL4bulakQJIdtCeE6TxKZv7A49I7GnyHAT61wx+APf6ky7/LJJsdW72e8Vz7/zrnHFVyM8NIZIOBzzR0YbBwOW5XwRYk3s74jkeAwUOtjZVEErW4fHIA9mD70jVd9xRH+vf+DDK19EIRnyYLyw9853yxT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708551925; c=relaxed/simple;
	bh=uyFsV9OUDeqhejULZAuA/MVq4g8588CDjo+WwYteZ8k=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDBarnYdRNU2apzYM3pqv67aNaezLnSDY3R51jOlAkYJ7NSVLmsMmPw29gVBzzs/P1DDdJbR/5u/zwfH1nsqDIeudIM4Gb1EjHoH2/Nvu6EO3WAlZTZphCpQX025tAVVj2oFZXuqZ291tnm9QFwLD5l08McKJ98Mrfufeth/hFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJuNH3Y4; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33d1f3144c4so771734f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708551922; x=1709156722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P120Wp5N7NPu3zWjz/hKIW84Ut+CiTr8TgaGF61U464=;
        b=hJuNH3Y4OM/j2HXMxtbpPudHcYNpSfGRG8/XtacJ3cSXXBfkZ0IfgH4UNVvwVqu6pU
         0OHCGMoPG/h8wMD/JxlHCWZvrGoBVPwnu13RDXOn1yy12bIg/6eBvU17wxvHY0P67kzV
         3mIzFnkjJCBXhCl7PHbo/NBSSrmI39yZg6oS1GCAF7GSvkBfz1rZHcs1YQWWVXWqVGB2
         AuHBXywDOvW5L5Le+bjld4/slWzVPUPGAG/zDU72H0pLanIkLcvXDWOYzjKK5aI1irkV
         mgo8702raqAQNfeF3Xna3UJ3UDMiskCEq0NnR+c5Q/2p70IYh93BteepqVMLaELozlzE
         8xDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708551922; x=1709156722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P120Wp5N7NPu3zWjz/hKIW84Ut+CiTr8TgaGF61U464=;
        b=N5gGLnsBc8ZJc95yDIIddn4vtgEJe5zjtCla3m2EDxXSTHHkd8+6anFJw//epFPswT
         t8qZNdzqoS+WIs7VZsnMhX04f1VrhBOkZH13uK3cOCNS9oKsEMGGGzeYkeMVFxozG589
         VL2qqBQ9N4zXRihosrpsp6e+Z1af0dT8GdluKD5dA+JGxqszbgSgG7Wk7rvDGxkyD2Sq
         XbXJaVImykyypJQrE5JhRHGLq37RcgBNPAjuTSkHIFmmAQ2p3wxapm54BG6+L+ZrhfSQ
         yn+1Na4cFveNf2tiut8rexrqsCw1NN3L16LfA8ya4nFdUJJhTBIofiaStdv2QM8mDcaw
         UXYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX94wKVSqX6j2Dz1VgOCzPS0wyZAKSVwcZDKOMHt23dD0J5lpMuSzPG08GhYpkzKKmkyN9t37VJ2bu4/UFfmTxHiaP/qi/wz4J7HJQ1
X-Gm-Message-State: AOJu0Yw/mzMz4c+Xcxk2J5XAkkJLRRMb0MMg4umNFCZrnwImkAa8Dc6V
	0fxCiLAtYinfNXusvxjUJoDZBZ0Yqq42ZvaNtMaiCptYv0BioVbV
X-Google-Smtp-Source: AGHT+IHjl/e2sn9am30SC6heh5b5qeWaBducd+4Te85MAi+P5SZiRbE0nvRbho+29F/68YRjJg2yjw==
X-Received: by 2002:a05:600c:1d24:b0:412:db0:4471 with SMTP id l36-20020a05600c1d2400b004120db04471mr436136wms.0.1708551921981;
        Wed, 21 Feb 2024 13:45:21 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c230d00b00411d640085csm19129971wmo.43.2024.02.21.13.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:45:19 -0800 (PST)
Date: Wed, 21 Feb 2024 22:45:17 +0100
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] staging: rtl8192e: Remove variables bIsQosData and
 RxIs40MHzPacket
Message-ID: <7a8b579fd3d377fa961fe71e37fe4afa22f2a3b9.1708461563.git.philipp.g.hortmann@gmail.com>
References: <cover.1708461563.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1708461563.git.philipp.g.hortmann@gmail.com>

Remove unused variables bIsQosData and RxIs40MHzPacket as they are set
and never evaluated.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 --
 drivers/staging/rtl8192e/rtllib.h              | 2 --
 drivers/staging/rtl8192e/rtllib_rx.c           | 3 ---
 3 files changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index aeff01e921e4..ad453a94b5c7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1671,8 +1671,6 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 	stats->TimeStampLow = pDrvInfo->TSFL;
 	stats->TimeStampHigh = rtl92e_readl(dev, TSFR + 4);
 
-	stats->RxIs40MHzPacket = pDrvInfo->BW;
-
 	_rtl92e_translate_rx_signal_stats(dev, skb, stats, pdesc, pDrvInfo);
 	skb_trim(skb, skb->len - S_CRC_LEN);
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 1949fad401d0..943a16ead903 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -487,14 +487,12 @@ struct rtllib_rx_stats {
 	u16 Decrypted:1;
 	u32 TimeStampLow;
 	u32 TimeStampHigh;
-	bool bIsQosData;
 
 	u8    RxDrvInfoSize;
 	u8    RxBufShift;
 	bool  bIsAMPDU;
 	bool  bFirstMPDU;
 	bool  bContainHTC;
-	bool  RxIs40MHzPacket;
 	u32   RxPWDBAll;
 	u8    RxMIMOSignalStrength[4];
 	s8    RxMIMOSignalQuality[2];
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 29bdaff4cbab..1e4956fc6754 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -865,9 +865,6 @@ static size_t rtllib_rx_get_hdrlen(struct rtllib_device *ieee,
 		rx_stats->bContainHTC = true;
 	}
 
-	if (RTLLIB_QOS_HAS_SEQ(fc))
-		rx_stats->bIsQosData = true;
-
 	return hdrlen;
 }
 
-- 
2.43.2


