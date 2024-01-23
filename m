Return-Path: <linux-kernel+bounces-36089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A70BC839B6E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 478ABB26D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25F741742;
	Tue, 23 Jan 2024 21:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0ZO0/zTn"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ADC2114
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046639; cv=none; b=erNYnfKgaXCumYJhNUqgH5SEHqW0QY+vrfpQzHxhzT09WP1GkZIG8iy3KAX/1kPnKHLVeFcSX+83Aejvipi82+jCzblBDyw7qulyjTM3iSUjinVkOdVXQSSPY4e75BZ30RNr89IPngXv103VpfOFYZhovB92Hy1V6AMniIwTFQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046639; c=relaxed/simple;
	bh=qjSzwxfvEw8P0/KSwYPerGQtyn2kLF/crHyHSJzwEIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m166LQUd93BxpkIaxb8gMsycrmRUxlgiBAAIaOLv+hhEEs0diKg56kviBurhEZu8QOKAdssKjeLhudX4EpMCtyTLlafPidA7iYDs6SF+uUz6gnGgq4aU9vrs2xNBtuywj6XPTqErLmMSIsAD/WSJWPhNr5j0li/8hEMHi7beHhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0ZO0/zTn; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bb53e20a43so3448214b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706046635; x=1706651435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2KeetDUGZXNfbQyMYC9x9HpMR6XYRC4AqSuY7y18XGE=;
        b=0ZO0/zTnoiUqti6H++caZPk2HudH5pLUulXRCkqzyccnnI/erSJOFdO8FN1YwSz85J
         JE+M6Tu+v4LWqY3qgzdtXoZazPGKlS4Mj6YUhLHLZE9/YTD/2kMc939R4+Zlhd5nfCly
         2y6VpifJa7BrctggaqyKhKhWqDgZZIUw295X5gk5a0lsmQ4tvYfk44XQxnZtMhzSqW/h
         Zoc7HV07eFzS0n7OzCKKASdjDPnrmr0CcipMsoeOPyDQdV+M2Z30urz7JCw4rt+i0L4o
         rykLFgeMPECipQBJkt6I3o1bDL2dtbwssN/i8iVNo2G2p81yF0UTlBCI7Mu40DRFEgvR
         60Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046635; x=1706651435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2KeetDUGZXNfbQyMYC9x9HpMR6XYRC4AqSuY7y18XGE=;
        b=UDJpMG7yJlbOzzfJOdgmCBgoCgUvWOiazIBhUnR/+IwiJbS2E3DRVKkvkX07KaoLeZ
         eV9mj6dnPnd4uHBiVr9Ipn5kfIIEdooweoJJhFWjY5DY1Xl1KgC0oPHSey5iyYY0CqjG
         7S/HH++AhpEXUtk6VTn4x/eNWQWtgkWPf5oALeCQx/wFTwAXrhpePXROcT+9HL9YV2JX
         Gb7mRTFeJ6LzUCIv1PyyHatww+SlvHSjfGQusb1NoyebqT8E1fBhsYA3Zen+BL/ZSHyV
         EckaFbnBItooOmkd8irsouhnrgh/rZZ+WObt4RkCsnApY/CeuLfWJZBRtWxXSgXWzVPD
         CCyQ==
X-Gm-Message-State: AOJu0YwYVgoJ2wPjliuUUnTzp9ad1Ml+/uyjswrBHBGdoxQ791UkHim2
	FiDO8wcWFRZqAI0WSGYBCnW1GCIdzwXOrvL1UCz+E0WOwqgG6SaWlBzp+jWTVeU=
X-Google-Smtp-Source: AGHT+IH/IBzjbEkOgMNR0RXGP17zvIYmL7mFmyhAdke+NpxILeoqSLlWH9H6Ei2p/Tu6m4bc71o6LA==
X-Received: by 2002:a05:6808:1496:b0:3bd:cdc3:ad4 with SMTP id e22-20020a056808149600b003bdcdc30ad4mr389626oiw.15.1706046635145;
        Tue, 23 Jan 2024 13:50:35 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id k10-20020a056808068a00b003bda3125e3csm1956290oig.48.2024.01.23.13.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:50:34 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>
Subject: [PATCH] spi: consolidate setting message->spi
Date: Tue, 23 Jan 2024 15:49:46 -0600
Message-ID: <20240123214946.2616786-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, __spi_sync() and __spi_async() set message->spi to the spi
device independently after calling __spi_validate(). __spi_validate()
also would conditionally set this if it needed to split the message
since it wasn't set yet.

Since both __spi_sync() and __spi_async() call __spi_validate(), we can
consolidate this into only setting message->spi once (unconditionally)
in __spi_validate(). This will also save any future callers of
__spi_validate() from also needing to set message->spi.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index bc3d7c0ce6b4..7a70ef47cdf6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4059,6 +4059,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 	if (list_empty(&message->transfers))
 		return -EINVAL;
 
+	message->spi = spi;
+
 	/*
 	 * If an SPI controller does not support toggling the CS line on each
 	 * transfer (indicated by the SPI_CS_WORD flag) or we are using a GPIO
@@ -4071,9 +4073,6 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 		size_t maxsize = BITS_TO_BYTES(spi->bits_per_word);
 		int ret;
 
-		/* spi_split_transfers_maxsize() requires message->spi */
-		message->spi = spi;
-
 		ret = spi_split_transfers_maxsize(ctlr, message, maxsize,
 						  GFP_KERNEL);
 		if (ret)
@@ -4210,8 +4209,6 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
 	if (!ctlr->transfer)
 		return -ENOTSUPP;
 
-	message->spi = spi;
-
 	SPI_STATISTICS_INCREMENT_FIELD(ctlr->pcpu_statistics, spi_async);
 	SPI_STATISTICS_INCREMENT_FIELD(spi->pcpu_statistics, spi_async);
 
@@ -4391,8 +4388,6 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 	if (status != 0)
 		return status;
 
-	message->spi = spi;
-
 	SPI_STATISTICS_INCREMENT_FIELD(ctlr->pcpu_statistics, spi_sync);
 	SPI_STATISTICS_INCREMENT_FIELD(spi->pcpu_statistics, spi_sync);
 
-- 
2.43.0


