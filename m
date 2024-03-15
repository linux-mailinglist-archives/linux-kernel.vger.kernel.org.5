Return-Path: <linux-kernel+bounces-104190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 477FC87CA78
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07033282F74
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEF3179BC;
	Fri, 15 Mar 2024 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBdseELT"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030FA13AC5;
	Fri, 15 Mar 2024 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710494081; cv=none; b=fnrfVtHqvjCb4UcNVKQsAWEvYF0lg3Zi63wOFFRXGQeqMNMhtQmN0TspylGdAjdlZv2BRC5RnFefJzOBYXvzoRyP1BmJiCMhbbIJdGuueVbOsDtTvy08VkakMFzOVydnWH6pMSP1DDr5GiURWNgZABFwoabeY6oUeqZy3NCsUDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710494081; c=relaxed/simple;
	bh=UsJgKbEx0AKH4pAVybDI3SH53hz+4clcfF4q3S14ZMA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jf2iRK6Km3v7ZExLENU3kQSuu4DC+P1wpjBhJMLVn8bon4it4YAZ1d5ezljXdyEEvcFj+V5M+mNQZLiR91u10cyqkcPsZZorNaTwECvMcD2ZcAmXlvoehDR8G2fonHBWFEUfZuPEU+bGQL4TA6Lco03HxKylouVhiS4MjekXpTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBdseELT; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso24027501fa.2;
        Fri, 15 Mar 2024 02:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710494078; x=1711098878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kdhg2x3t8Nf/uv6nbcx14LUHcWP8lBLkCrAgVBOR3+8=;
        b=VBdseELTJq+R0fUmhkj8cs6NfGuFz93eDsRx6H4vqdYT96yHoRSLetBTnPTyn0pPwB
         avlo5UUbkWnN2zPRYINsdzlz2nck/1iqkyisyCtxu5GB+7sA7niCEf5/vdEAscpujti6
         f3A/1fkjH9ZnqKQZz3IySaSHQ63D2Vr7bUt+opHYsB8AyHyw9RHYIOjsiXs4QqrBXvdN
         r5yX8uHBcW4GB07fXDyb6+k+KP4r5B5kYu9z0AfGaVOOqqbhEZ1MUQLJJd8ULjkXWM+B
         3CWKAzZhFqtwyhOflmJGl3jj915KfaFjVlL1bsB6rcY69VcHh9bWoYTYLDUh7+SMJCFY
         a41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710494078; x=1711098878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kdhg2x3t8Nf/uv6nbcx14LUHcWP8lBLkCrAgVBOR3+8=;
        b=SAVhM8KFrPzSwqvzgg2PcSmWGXqbSkO02dA1ZljgdO/vr5+pYO/8W1/ZIB7QXyxKbc
         s/BZO+H5/N6xbvyEtsWHNKaagwxebkhanbWsqPjEcuOksjyKGfN5NaiTMSqs1YQW6y3x
         DglQOiAqTBZ/RC4guCGMmObVPXYIohI/byXv81XgmOP0QiCZ2gk6qe0TOL0PMW4bIPYz
         QcfZautjPJ2buk/SrQNvdsV7WzNyW3XsC0WvdGrFbf4wDqXoYEwBt4CYeM4lXX/Xl59H
         30JDDSvixB4pQK448RONIp34a4vnONMBuXS8AX7bWB4yVU6V6ZY5fniPSGHpmeDrV2qb
         jpQg==
X-Forwarded-Encrypted: i=1; AJvYcCVb2OoQzRuaamSZCi9SodvoyEKEY8rsttuDEVi7gcqAIRVUDFz9P1nEJ5/bRLFqu19TyRONa8qGZ+7G8BfpoAl6xSO3Y692zAUqBnZtu/XmPLPWNLtMLE8qUyw3I0RGNy/lZYBfD/zt
X-Gm-Message-State: AOJu0YyySt8B2q06mW7TNAsVHqaQGccomsVluhuFwX+9R3Yj3VRKfpkG
	VBBVpyI+MD1fLFxssSAjTHaWzML23nSDbBbWCHLhVtDvrpY+8W06
X-Google-Smtp-Source: AGHT+IFkANNGzB0Gt1dRmpu4/6570ZhiIh3q/3WxPkx8sXXzRwN27f8fcui1dezilc/yejo7Yqxf+g==
X-Received: by 2002:a2e:b611:0:b0:2d4:251f:c151 with SMTP id r17-20020a2eb611000000b002d4251fc151mr1655141ljn.46.1710494077935;
        Fri, 15 Mar 2024 02:14:37 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f5-20020adffcc5000000b0033e7b05edf3sm2710694wrs.44.2024.03.15.02.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 02:14:37 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: accel: adxl367: Remove second semicolon
Date: Fri, 15 Mar 2024 09:14:36 +0000
Message-Id: <20240315091436.2430227-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a statement with two semicolons. Remove the second one, it
is redundant.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iio/accel/adxl367.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 210228affb80..5cf4828a5eb5 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -621,7 +621,7 @@ static int _adxl367_set_odr(struct adxl367_state *st, enum adxl367_odr odr)
 static int adxl367_set_odr(struct iio_dev *indio_dev, enum adxl367_odr odr)
 {
 	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-		struct adxl367_state *st = iio_priv(indio_dev);;
+		struct adxl367_state *st = iio_priv(indio_dev);
 		int ret;
 
 		guard(mutex)(&st->lock);
-- 
2.39.2


