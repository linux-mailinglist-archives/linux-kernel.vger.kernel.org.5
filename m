Return-Path: <linux-kernel+bounces-39364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F2D83CF7C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C841C24A73
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F19E111B0;
	Thu, 25 Jan 2024 22:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kb0FYpEM"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587B4111AD;
	Thu, 25 Jan 2024 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706222138; cv=none; b=MNkIehPa/Xpkr0Jev41SdSL35YVFsA+y2iXkQaJDV0R8ooeD01vZe/TNHPHqLF2mhlucoYUDVL2ewuTYBLK9/gvnXCLcrAYILwiI8GeVoPFj1dh9Fb5rWdj0czaPVtEATJmsgpSonx9k5SEYCWBc9RbtINCjdVlCLRLXc0R2PTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706222138; c=relaxed/simple;
	bh=Uqv69FjQ+FATXs+N7RcNWXRmI484OnB4UG1WlGfNxug=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YcHZZRnkG9EMTi7Q9EUSAbLk6R7fBgUmtnupdIXDkSp2XNcgOVeGBahfeVsuZ+IuZ0DV2tTaYF/NGv+F3e/s6wDJWUqk6u4w+TLq7UMln1qleKIJYpz1q57iQ1dLbU6mg2sY2VAGEnjYcNFTX6hMlHoFWOIGWvl8RsQ2GrkVVNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kb0FYpEM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e60d74b81so10175635e9.1;
        Thu, 25 Jan 2024 14:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706222131; x=1706826931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRFVAtNzf6+PVhrJOOZpzvV4WQX0zR7X/ikLU7ZJTXs=;
        b=kb0FYpEM/L/l8XuT1At/qTKvyKfPOC7/7YuD3sIRbnYDjd00v84EcVn5kUTjwlXel0
         JLbipUn9Z+ymRrvmsZOzH5yIU9rULzHJgS8HRAHo5CSWMUK8kGYRbMiV9byY66pyVbDt
         OEIAdL8X01MD0bZiZHS1MDnsJkmi17s7I7XZUDXcnOwl3RIwvuEMu028V51Im4Kdlp5f
         0IVAzg499N7DHIdnlOazgS6ONMPeWoS/7spXP/O/jtbF/Xn5gHa/oS4cphP5cRn0ZUEO
         61NxBsvaKg4FEfZ8Xt5iQkKYFwzgEcGHxF2+crZbIv2j5MmmH05ptMRZxLnrmQeZONp/
         1Uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706222131; x=1706826931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZRFVAtNzf6+PVhrJOOZpzvV4WQX0zR7X/ikLU7ZJTXs=;
        b=FscNs0Stj5Jk3a5Vq8Kf8WMU+AWD7bMnPkBHOFNgQ/lRiz88SnyqhVWow3esIk2FRf
         vRXGiGbExhB4a2ak4okF89FMllt+Oy2oOHpGEmOegyWqLX3kTeZL5ZyO6ZWiYo918bg5
         yN7i5vQceyqLJd+EpdD25tQSsSL12GAdzm5IBDiRgkndp+DUce2SaVwkISxfLml6zoHF
         uVxyRFsxgRhsNGd4CH+Xk5hUHTTvDArBeZInUBh2CoL8Ri2dRuk2ngZIusuFAm0RhNQ0
         C0Dm1/lQde6jVbXpfGi9YWwFtlbk4gIWfhOoI5bREWcJpV5CTPinyRNVi/sbEfIMIEiP
         lsHQ==
X-Gm-Message-State: AOJu0Yw5ILfPtFZ5tJZrS4WZiHEUgUfnKEamgLhbK5z70vPeQHZDGLib
	qvHA7Li6NRQmjP4/ya7P7WlW2AKAEtLK2fG+OfmFRdbBZ84I2+Xf
X-Google-Smtp-Source: AGHT+IEU4r2sqDqmey0v+H7xvB+9ETTxcY4Ay3X1yHulwQjVliCKwdws7/3b5+P4uYgXtoL5iK92cw==
X-Received: by 2002:a05:600c:1f8d:b0:40e:53ef:d9f8 with SMTP id je13-20020a05600c1f8d00b0040e53efd9f8mr566290wmb.1.1706222131256;
        Thu, 25 Jan 2024 14:35:31 -0800 (PST)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:9829:5527:ea0f:1fac])
        by smtp.gmail.com with ESMTPSA id b19-20020a05600c4e1300b0040d8d11bf63sm40012wmq.41.2024.01.25.14.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 14:35:30 -0800 (PST)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ALSA: pcm: Add missing formats to formats list
Date: Thu, 25 Jan 2024 22:35:19 +0000
Message-Id: <20240125223522.1122765-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 4 missing formats to 'snd_pcm_format_names' array in order to be
able to get their names with 'snd_pcm_format_name' function.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 sound/core/pcm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index a09f0154e6a7..d0788126cbab 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -211,6 +211,10 @@ static const char * const snd_pcm_format_names[] = {
 	FORMAT(DSD_U32_LE),
 	FORMAT(DSD_U16_BE),
 	FORMAT(DSD_U32_BE),
+	FORMAT(S20_LE),
+	FORMAT(S20_BE),
+	FORMAT(U20_LE),
+	FORMAT(U20_BE),
 };
 
 /**
-- 
2.34.1


