Return-Path: <linux-kernel+bounces-163501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E58E8B6C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C46A2836C8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3D757302;
	Tue, 30 Apr 2024 07:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MS+/3cno"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620C6405F8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714463495; cv=none; b=SQ/tZN2e4R6w9P5iezySm0iV2hxHutKhIa1Qyc/m9zzsnc9W48+og9x6xE0zkCu+NYQKx9QTTT0eqS8jqd3YR52NYBoOqpkNHmLWShfk5ZZYLEcxgHENKqV0Nuc7BQEK0akDuxWUSX0BuTobqXEfiQAOFajNJWMCyciCty2ZT4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714463495; c=relaxed/simple;
	bh=Klt3S7xZdueUFKS1wHESrOilkdR+oLUPuosQlgJLtQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I7a3lQNJWEzORuDVlpJfKFUClOXFjcdEd9uHOlB2Kbowhk19VpWZ+BTxAyzHxCKobmRZGCYSRON2rn+B4bqkM2oA6ulCR3hW2E9AhlFTVLgvGoTiNVVnB0GTEwHtNVuS29rIEvPZx7W+KHTbt23pMc5xp6It4euLw5g6tf9r+aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MS+/3cno; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43ab8e0f435so7745171cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714463493; x=1715068293; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dyrqsw7hfapafht5q6ARwJmOBtyDG2HfDsUwyULf8rA=;
        b=MS+/3cno0/pf5WnMUBO7mL6WZuNvK3C/r4FwzdttZcebGs0rTXO1HI3DcSgYMgWG6g
         sbnGNHmkoxjfukAooBSOK0GgyCgTwJxNx5Lcn9b5No1A22LU4B5rLwfS5kQPXl0SZLpW
         bKbh40nAGBuYHktm1BBa0y1c4XNBvw/4Idgks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714463493; x=1715068293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyrqsw7hfapafht5q6ARwJmOBtyDG2HfDsUwyULf8rA=;
        b=OHfhebk0IsB0PavNb3/FpBdgxKmrdLk8Hj+1A+n5IcHExJ9GtxAy1KxDKdO+b0T58h
         bs+Vc1kMwQ3Eg2s1+2t+FPAtZGPFLEKWW7nRSFkXvC2zvTomi/YCu/TV12wBOXgPzgZP
         /BtI001dxOwW+t0H9SM7Dc+dWxpVjpJKXrrg2ws+y5vR9VmTGp33UOEjd6608AFohQ9b
         CE1Q56hqYexlC29jSx0GO6Lc2WwTx5YtTHPsyjrHLlXcv1+wwnz2mUxKSdPtMq/xd6zW
         F0LQaQcXq6d7jy84dMJ5c4QEzKEJ6SzHdvymgfygXto6qKWL0QZHuTkQK/srma0LFfZQ
         Ebzw==
X-Forwarded-Encrypted: i=1; AJvYcCWI3KQCwbQCLjBEO9UkuNZx3DTOGnZijgwB9qpAeOoZjscoQXNJyprrQOD/7DJ/7cycPAXTDd3v4vM7WQAyOdS5uYzTprfFAwWxxGq4
X-Gm-Message-State: AOJu0YzQ1IYB/OWC/4SW9Cw85HEzcTDFxdRgxmeEBwpTTP/66HXZAWoi
	Lp4vT2IPTElGFrBTjBp6HJHGKrZyTnKRRV+1Q5PGXsPFjo70eO3NZhV1vvWHLg==
X-Google-Smtp-Source: AGHT+IECfMNRuKAOBTGNP1xzyMsseRJw3Hkb0lRny7MABhW2k54/n2V9s46e7u1H3Xer9VaXIy6adA==
X-Received: by 2002:a05:622a:4d2:b0:43b:c4:4188 with SMTP id q18-20020a05622a04d200b0043b00c44188mr4041838qtx.41.1714463493327;
        Tue, 30 Apr 2024 00:51:33 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id z11-20020a05622a124b00b00437b4048972sm10634547qtx.18.2024.04.30.00.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 00:51:32 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 30 Apr 2024 07:51:27 +0000
Subject: [PATCH 2/3] media: bcm2835-unicam: Do not print error when irq not
 found
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-fix-broad-v1-2-cf3b81bf97ff@chromium.org>
References: <20240430-fix-broad-v1-0-cf3b81bf97ff@chromium.org>
In-Reply-To: <20240430-fix-broad-v1-0-cf3b81bf97ff@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hans Verkuil <hverkuil@xs4all.nl>, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

platform_get_irq() already prints an error for us.

Fixes cocci:
drivers/media/platform/broadcom/bcm2835-unicam.c:2664:2-9: line 2664 is redundant because platform_get_irq() already prints an error

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/broadcom/bcm2835-unicam.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/broadcom/bcm2835-unicam.c b/drivers/media/platform/broadcom/bcm2835-unicam.c
index 2a3a27ac70ba..b2b23d24da19 100644
--- a/drivers/media/platform/broadcom/bcm2835-unicam.c
+++ b/drivers/media/platform/broadcom/bcm2835-unicam.c
@@ -2661,7 +2661,6 @@ static int unicam_probe(struct platform_device *pdev)
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "No IRQ resource\n");
 		if (ret != -EPROBE_DEFER)
 			ret = -EINVAL;
 		goto err_unicam_put;

-- 
2.44.0.769.g3c40516874-goog


