Return-Path: <linux-kernel+bounces-161616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F788B4EB2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94A27B212BC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110C84176B;
	Sun, 28 Apr 2024 23:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="VZEjeAeZ"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09113A8EF
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 23:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714345278; cv=none; b=GD40nC4UyyXsgPExqFHjJvEb4nEPx5k6nx1D9GT3Yxm3zWkc4/zHh4XxwYpl5wVBIhna9BFyR7U+8sHqghFrjhYLJHRhT36p4+CkNt3cUtEg/DmbVki6k9cy/uPeGDTdjo922Igx+4QsGz3qjufu2JCQX095RnOCHtfI54hBkVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714345278; c=relaxed/simple;
	bh=tcWH6jcBnjgZvaH/IZAF8fYQa8PC+uCdhWLW0V2u5ZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sbSYvE9aYC7PQaoNq6UPsu+/05oWv7Bec3v64qu1SAC2UoSzMCmBFopKBl0fkeGgHXh8vnwi11bOGcD/c6w8n1d4B2DGvQsYaypbDPcRvIB+NsO4OLnywl5nckNcuxfIC2xF6IAp3qKnUj8GdS3JajZXopeUTkB81WCrTWkBiLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=VZEjeAeZ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2779503a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 16:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1714345276; x=1714950076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jukopXyGW/if/AOTjqH7jgQ+2Z4ukOtvPxegytlzAL8=;
        b=VZEjeAeZDEYrpZiKJxWkZXY9dnvIvaFjuXl5KO29DJKeFDkUVNu3N7lAHGt7mtnmKI
         WNfzsCJeIkT40vu/ucFWUz3szqvzYwRnB6Rom3gkZ/oWeKOBDiSbNB5FgRSrTIuZhaJb
         wWCuInmof8y05zsFeXgkjv0PjSQI5/7JP78v1WO+OznC0hFk7tAoHKAY+1/asKTki2yg
         nTojhtjdOxpsqS5Zqw4AtHSgUeg45+5uW+SsQ4dDTXfWVCEAGal604yYjEXmX4PD/Onq
         OZz4N3Y88voAhPWTWA6uD3UZFYXel8gHUvwwGKkCgCsx4lvNwSnjcRDnnJhbNXvRB/ui
         W3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714345276; x=1714950076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jukopXyGW/if/AOTjqH7jgQ+2Z4ukOtvPxegytlzAL8=;
        b=EduWY+fJjkNSzUnLCqNn4u72ygjB8e9ODqG013ZcOe5rx+k9eAMbkooI/W9dh0YG4h
         /5SFTLcODohcXCFoOcDvIC8W9y4VoTIqSSa5f+y8JiJh/ATiJznfErX6beUjiqzraZjJ
         e8A1pIlG1UMbuu8grrK1g99+7LUZbSyoNGe6RAIdDXcNvUypww0rKCUkYdarQY8BgRYd
         QWohkn6xdVw8jLRiX9PnEEZJ0kN96TFPEUQF3OY2K3E9O90qOWx19ZDZjPy+XEonVml/
         +nVV29vyHXVAuAlZmUNgDd33lIv2LXAm9HsbN1GZ5v2xwli5dDJ8pj7Sc/FOGirSPamD
         J7Ng==
X-Forwarded-Encrypted: i=1; AJvYcCW7HUngvhFRXZ/T93ID3eMXuuVFvhNIO+9IgCD0u9wETRlvx/f6eRV2GdrnV8DMgCdLthDUFovN36AM2x9+1N8xO79HXOQqoem2b4H+
X-Gm-Message-State: AOJu0YxaZRUqqcYQItPPDAvh2pP30RDJY70SL5XvFrwskUj5E4Bh9vIG
	yIiQTwf0CeNne2hJqoU7B2BkZ7tusWz73b87QdRYYFac/Wies1RiyfI2aWo/sLM=
X-Google-Smtp-Source: AGHT+IEbTAty5/F2PdbfAuuV59ubpH2+K4coOOGsHs+g0waYq9P8FsjAmzHWY2FoAwaDpaPhCJTP8A==
X-Received: by 2002:a17:90a:bb86:b0:2a5:8ff:9d1 with SMTP id v6-20020a17090abb8600b002a508ff09d1mr8902393pjr.14.1714345276149;
        Sun, 28 Apr 2024 16:01:16 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090aac1000b002a27132ac02sm17860864pjq.2.2024.04.28.16.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 16:01:15 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 10/18] Staging: rtl8192e: Rename variable GreenField
Date: Sun, 28 Apr 2024 16:00:58 -0700
Message-Id: <20240428230106.6548-11-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240428230106.6548-1-tdavies@darkphysics.net>
References: <20240428230106.6548-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable GreenField to green_field
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 008611e3aace..b9f50d195b13 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -27,7 +27,7 @@ struct ht_capab_ele {
 	u8	adv_coding:1;
 	u8	chl_width:1;
 	u8	mimo_pwr_save:2;
-	u8	GreenField:1;
+	u8	green_field:1;
 	u8	short_gi_20mhz:1;
 	u8	short_gi_40mhz:1;
 	u8	TxSTBC:1;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 3b1c6e24103e..cf3536fdefbd 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -258,7 +258,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 		cap_ele->chl_width = 1;
 
 	cap_ele->mimo_pwr_save		= 3;
-	cap_ele->GreenField		= 0;
+	cap_ele->green_field		= 0;
 	cap_ele->short_gi_20mhz		= 1;
 	cap_ele->short_gi_40mhz		= 1;
 
-- 
2.30.2


