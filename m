Return-Path: <linux-kernel+bounces-75565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 156C685EB2C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460251C24328
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069BB1272C6;
	Wed, 21 Feb 2024 21:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fY4GTApz"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CB2127B57
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708551916; cv=none; b=UctUrHj6kW11GHoXZeL7uRKPYNxuukRxWRm8pvFVBJB2i8U6Il4IFtx7Qg7tZBjPB1yg2TXH+wYF+4im4HxjyaMq9hl+ocO5tQv2ARIGk6C6Bp1BdRd45XaY/UMB+O6xE4837e1a2pRaytGt+27i/6wRxvYQplptLCKHcAP05bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708551916; c=relaxed/simple;
	bh=j2nhoqg50QyBMIaEdxLOEspW9uEChcSl5BxeXCTb40w=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXiAoXVpC701k8E0TUk58PROer8e42JwVFCfSM/BQ0b2a54Vev1kdJG72VeLgMl+UzdLdxmwML0lFoWVv+jUgA30WFsWB+ZlaVc14BbJ43AXyx4CXZWdMd6EIpYq3gZJFJ5Xiwrg53kCe6puC+mIlvFT+3PsbAyA1ZLl6ikaLAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fY4GTApz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33ad9ec3ec2so1125603f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708551913; x=1709156713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rvrRKz3L1KRShWYrmUsdmRB21fpKWIj6Qz4Gvr6VMUI=;
        b=fY4GTApzNMdk8i2Q+ZhYf50Q+Z+6mtLYMKWeGeUsBRdUqFNfVEvOmIOLFbscXvJfpt
         F9Pf0kbWbItMxBXlFOBt+DJxItPVk5nK/np77k3B7WNWKJintFCc+Hn6Q+WvkYxXnLqC
         rJe2EonbPPOnreoLSIc1pWL+K6+WBjS3Vvv5nN591WQUvtZBEJlqBWESVAw/O3KtWrY/
         4Si/6gadXD2WWG6/F3oOOURj31BNpzdvwBQlge4jtEJl0TXWYoCMVuWy9fAPKbv0BmZ1
         s36u9Lz++xsKogGCIfiQOKGj5YUlA2SYAj+Z+G+31ZyeHNgE+RGLKSytl8fVNs97KMFz
         cN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708551913; x=1709156713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvrRKz3L1KRShWYrmUsdmRB21fpKWIj6Qz4Gvr6VMUI=;
        b=nmqmM20V6P8HQm7lsHGI9UQ+d5m6msXyV+W2WcBJ4dt70c4HGMnF+794Uqqv30BpUm
         CYcdOS8zMm4Rrdhg5Zdg0wxRaC7iaAVUyItP+bmROtO1Tktk6nMZvdrAmy2DlTbDj8FY
         zZ7grTy0XhMemSYXA6uUaSVd2vAqWeZzzyn+Zi3CbgMjJ4qEFx2iMa5JvBc3wauAa5Y6
         xCWmOdb08PJPxVVwZ6jVpOwnRr0+le3H9FH8wc58Ta4huebi5Ab99Ldmp6ErX0MbAP8a
         0g85byNsKOg2S5LpImiZdPjaxXGExutfiMrh5vpiLVstc79wgKlRimG4wsmvLJ1eww6c
         SUXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2dFtFhe0TuHZOMQ5c/HsVqWjFB2F0J0SguBpQbEzS8kCQH1zrlPi2LRRm7PiV4hKVE0C64yDSvpNo4hzmCGHS7yROWeV+8RiAuiRm
X-Gm-Message-State: AOJu0YxAJnt3YDlhQ3oz7IsoJkpMZFNHHCS21HKxR9/E4zqR1LpY7YQB
	vI4Mq5etzOr5OFwJPMr1nCapPJmtz0HelonhMnWR7Mwn3vlh4svH
X-Google-Smtp-Source: AGHT+IGM4OG1WMWSAdpQyceURSYXYW1tRC6lfrWUprHzleYBzKjZRhGguu9xdPZYyiB987XgSFV40w==
X-Received: by 2002:a05:6000:71b:b0:33d:32f7:c85 with SMTP id bs27-20020a056000071b00b0033d32f70c85mr8683666wrb.0.1708551913172;
        Wed, 21 Feb 2024 13:45:13 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id b7-20020adfe647000000b0033b406bc689sm18268940wrn.75.2024.02.21.13.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:45:10 -0800 (PST)
Date: Wed, 21 Feb 2024 22:45:07 +0100
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] staging: rtl8192e: Remove unused variable bShift
Message-ID: <ff505fd05683a59b02ac2e3da115718d8a22735b.1708461563.git.philipp.g.hortmann@gmail.com>
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

Remove unused variable bShift as it is set and never evaluated.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 4 ----
 drivers/staging/rtl8192e/rtllib.h              | 1 -
 2 files changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 59110da6c4f3..aeff01e921e4 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1649,7 +1649,6 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 		stats->bHwError |= 1;
 
 	if (stats->bHwError) {
-		stats->bShift = false;
 		return false;
 	}
 
@@ -1672,9 +1671,6 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 	stats->TimeStampLow = pDrvInfo->TSFL;
 	stats->TimeStampHigh = rtl92e_readl(dev, TSFR + 4);
 
-	if ((stats->RxBufShift + stats->RxDrvInfoSize) > 0)
-		stats->bShift = 1;
-
 	stats->RxIs40MHzPacket = pDrvInfo->BW;
 
 	_rtl92e_translate_rx_signal_stats(dev, skb, stats, pdesc, pDrvInfo);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index bc4479f7d089..1949fad401d0 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -487,7 +487,6 @@ struct rtllib_rx_stats {
 	u16 Decrypted:1;
 	u32 TimeStampLow;
 	u32 TimeStampHigh;
-	bool bShift;
 	bool bIsQosData;
 
 	u8    RxDrvInfoSize;
-- 
2.43.2


