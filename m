Return-Path: <linux-kernel+bounces-38390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A85A83BEB8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13FE128C201
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1A81CD09;
	Thu, 25 Jan 2024 10:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCE9+Nq6"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB41175BE;
	Thu, 25 Jan 2024 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178414; cv=none; b=c99mSdQSmZl+oEMvL8El4pqyL09OECICptsDuQjTx4qSJsVt4pAZ7306gsqa+csFdNlwcIFP+HvByeAD0W+O9HJLSkryGo/FRIWbaTcwq2DrCKXIDWlNQ9sLU2ZPYxQFPAqkpio+V4RhXoHmLnSQP2I1pT7ZuawDGm214nQqu2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178414; c=relaxed/simple;
	bh=0E0Dmg/X9JFI1Y7lS4dhetCkdveIh8ajKY+1iLi3QU4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XP+um/a1c3lHGnnjgJtDPw+FYCHoDaV6jdl6/21wPCdOrLd9Iw4bTUbXvLv55Y/LxbJcjpzQdhUt6p1F8fXbGskxLcs9nBScTZjw8uCpFxIlkLvIHToS/DiIw/+awcvsfbhYqk45mtOAZdCsCOyXt5egjXw9UJxPgNwNn18FINQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCE9+Nq6; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5100fd7f71dso2345992e87.1;
        Thu, 25 Jan 2024 02:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706178411; x=1706783211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=srddleVoD/RGZ2ZusIx3j1Qeck2mamgxihSPrAiJLrQ=;
        b=LCE9+Nq66UHCmh6uIagMd4VP6x37GDnO1AgfXxY5F+/8w0J9+bguPU2W/UmpKWzqKs
         2VGADudxYnDzj9SD4VU9gFrdVqUVlQt/ueFLl0gaF2ebJblaykFuv9pD0VgipQLdTiIZ
         D9X361In0H9iYezv07R46Bn8i50LlO4F/D4TvU8JSBAM5q7ZByeCUEzxHyx5wJisSKGO
         3ylvxdLrhj8gUIBE2Sz793JDuHpFdq2xgSoLyvanjRDRGGETd0caQZrWD+jyHWOBPNnF
         gvlSeqYODQFvALDKowdzKOTNGHgXsniLsTqc2KmvP6WmyrqRKMTJk7/JQnLLEZcs8yqM
         aoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706178411; x=1706783211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=srddleVoD/RGZ2ZusIx3j1Qeck2mamgxihSPrAiJLrQ=;
        b=OcsHi9NM1wvLuG5V4Ky69E/gt4SU9CV0iLUzoDQXhpC9645lgwc8GwZ3LDVGz6FoGx
         pKbVtgm8aCNFnrrONzR5djF5WqyNTUGGTqZsasqjEUAcC2m97nyN/YoI7z5s1Td1TM2z
         KCd7lKLTiqFEJ7TBWRqD6CBQCDIY2fJ8/Mj3Eyx/cPs3nYKaDeT1SbUwIWwD7pyRZq5F
         0tCHlCAEs9Cmc5Y9uwkFnUBeP15vX/HjyWc4r6wwIulozIOZ/Q/PGAH4QXlQ3ZIl0RBV
         7LvFE1EBEqaIZQGTuBPE7fm3GKtrsIFIvDrtu2LzFNCPZ8lERkwRXHx6pdiSIAwZEaKk
         lGSg==
X-Gm-Message-State: AOJu0YzettqhL9Ls/UnA1nCh5HQdPJtlod3TTPJkfuFY5NZw5AtTZBN+
	qWa/qoXYwCNcAzDRzaDnDw/HEXltFnut+b+7Yi4VonlpOQlnItIY
X-Google-Smtp-Source: AGHT+IFws4q6oOSgLHaQGbz2CrsBQhD9bLg4PqJpBhhxKRYtTN6JbqR4P7C6dMAF+gB3L7GSPxaKvQ==
X-Received: by 2002:a05:6512:2303:b0:510:1840:336c with SMTP id o3-20020a056512230300b005101840336cmr464330lfu.52.1706178410969;
        Thu, 25 Jan 2024 02:26:50 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id vx10-20020a170907a78a00b00a3162e76a6csm723461ejc.215.2024.01.25.02.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 02:26:50 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: humidity: hdc3020: fix temperature offset
Date: Thu, 25 Jan 2024 11:26:41 +0100
Message-Id: <20240125102641.3850938-1-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The temperature offset should be negative according to the datasheet.
Adding a minus to the existing offset results in correct temperature
calculations.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/iio/humidity/hdc3020.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index 4e3311170725..ed70415512f6 100644
--- a/drivers/iio/humidity/hdc3020.c
+++ b/drivers/iio/humidity/hdc3020.c
@@ -322,7 +322,7 @@ static int hdc3020_read_raw(struct iio_dev *indio_dev,
 		if (chan->type != IIO_TEMP)
 			return -EINVAL;
 
-		*val = 16852;
+		*val = -16852;
 		return IIO_VAL_INT;
 
 	default:
-- 
2.39.2


