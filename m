Return-Path: <linux-kernel+bounces-75567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3183385EB2F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F471C20D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672B1127B4C;
	Wed, 21 Feb 2024 21:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QontN5p4"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1EA1272C6
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708551934; cv=none; b=mKtRkblIzVNmt4aWxiJ2UhsIgjXgU55wpzX9YG4DfzHg1sXmoAPz/kd8pUWT/FOBzR5hjgl7R2LAecXbvDaI38bdBudpp74eQY32u7gVJaI2huO7+e40q+ggUPXMieDzkuYZPpdgtGAfwB0frPvlunFRzpKNwFcuRK2LGJclBnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708551934; c=relaxed/simple;
	bh=yynCogJKz4vK6QoIxQeQJGbrjlvcF7Dq5sgNbtdLV1I=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omrZLQpEplPMli9AD2HTl55gYOhP81987k7NqcQFBz3xTatvVevkTi9rzSrT1CqPBz01HMJ7KottixiqZixV6tNKZq0l8j8IBWLKJev1hMys4gArfX7qBjIbsXXs/Y8MMcwigN+4rKVlEckV78IIHs5G/SzY2AfBCturYNVf24I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QontN5p4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41244a8ae12so5484075e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708551931; x=1709156731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t1izt9DsHPREI8xIfeW1na7p+o/foNbQZ862NtmipZc=;
        b=QontN5p4Jk7B/ifKeDAViNKoNQcxNsSenf3M0VEJQbuTWDxdqgY5Dc7n1Zz0G8V8pt
         07745Gs1ILwOBAXqWqTuwgmmwT2dF3nwnvR/OT2VGtHOpQduOQIVBptH2dfaYsf/xZzm
         3ewX6qaY+UwV8oM+u5dNI75mKvIUd5oovVziYV3cOSDdMizC5nKZ66B9qrltNGHrI+UA
         mnPRUfp4neAMfrdczoFmzcPEAN0tHM6lB+vVyiajV6qcOOyud5xTidAhYlJwz+JyB5pw
         lNJjYwGblhsZZz9V3W4RIbw2ZyEaVmZnijoF9v3/4nm7ca7sWXZpRtPaQ9N0Er2zXTrA
         jc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708551931; x=1709156731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1izt9DsHPREI8xIfeW1na7p+o/foNbQZ862NtmipZc=;
        b=noHGCClUmQSk9ATKOgQ+kxhbUhKraJUa9tZX9Vb6QBU9/0cg5w0q96qWJmw8jdr0bL
         bY5GFmU56Iqtll1b4fjDxJu0D83E8wtdppERvLhyk3pE8sicp75qCDraUTnOM+2VBeHW
         eXkvw1uvT2lLRXXPVnpP8ihnqOvz6gsZ06Pj7Iilmhkza8eK/VqKLVnisXbLzZiDlOwr
         BAX1XW1+1v8/puATzEERUivKiwroKhpC/B4QQvo0HVn0Z3lCHnWUMvsgvcjCP6K7K6w4
         PTS4Zpd6X1o2kr1LxRHR6YQv8GBI3N1U3CYHVVKpcBdmA1jtpc2Cj07gqu03iGQzPKDx
         u/qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfyuHyUIwFRaNb4dUHyP2ZR8eRux1xUNUb5bIElqs2TQKiay0fPTu91deQzKDbxZ7IjON/nC2mVgkVWGYwUV0OqJ3biTjmHZda86ZQ
X-Gm-Message-State: AOJu0YzhQ7jGvWIhnifTSSXIy7a8ORSqiHPOEVk63YTkLZuVGWAc/VWR
	IZG7NqHW2l+MgQjc1NCHxxejA9irrD+/LCu4X6MzC0uDnnNAEUzf
X-Google-Smtp-Source: AGHT+IFBTP2HG3PJeeuPLX9Pp7ya+f9Xmqw/XPQpqVsXdTMPqYqLgs1uXi+f8pstvyTwrYHc7GliXQ==
X-Received: by 2002:a05:600c:35d6:b0:412:6d65:b591 with SMTP id r22-20020a05600c35d600b004126d65b591mr4379095wmq.1.1708551931507;
        Wed, 21 Feb 2024 13:45:31 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c4ed100b0040ecdd672fasm19757629wmq.13.2024.02.21.13.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:45:29 -0800 (PST)
Date: Wed, 21 Feb 2024 22:45:27 +0100
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] staging: rtl8192e: Remove variables fraglength and
 packetlength
Message-ID: <cca48e6e3d4d32010699118d55fd82b1dbc6eda6.1708461563.git.philipp.g.hortmann@gmail.com>
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

Remove unused variables fraglength and packetlength as they are set and
never evaluated.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 3 ---
 drivers/staging/rtl8192e/rtllib.h              | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index ad453a94b5c7..07218edab746 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1674,9 +1674,6 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 	_rtl92e_translate_rx_signal_stats(dev, skb, stats, pdesc, pDrvInfo);
 	skb_trim(skb, skb->len - S_CRC_LEN);
 
-
-	stats->packetlength = stats->Length - 4;
-	stats->fraglength = stats->packetlength;
 	stats->fragoffset = 0;
 	stats->ntotalfrag = 1;
 	return true;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 943a16ead903..d764de9459e2 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -499,8 +499,6 @@ struct rtllib_rx_stats {
 	bool  bPacketMatchBSSID;
 	bool  bIsCCK;
 	bool  bPacketToSelf;
-	u16    packetlength;
-	u16    fraglength;
 	u16    fragoffset;
 	u16    ntotalfrag;
 	bool   bPacketBeacon;
-- 
2.43.2


