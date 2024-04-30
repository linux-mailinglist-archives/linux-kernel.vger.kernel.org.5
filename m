Return-Path: <linux-kernel+bounces-163969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FAD8B76AD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0CD1F23269
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD54171679;
	Tue, 30 Apr 2024 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ID2zm2bR"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCA413D29F;
	Tue, 30 Apr 2024 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714482818; cv=none; b=eJ9TChuSLUKG1vLpyBPkantqizwmthrbM+d0HqMQxJmWWZ8QSh5VStHKRTddRDtdVIum5zvT9fy9T/4wdfJQqrT0YeOs4OPPPOYYNOzi4cNcEkHtwcJkt87L3IHNsUywp1lPaSnDts75e3neABWYM6d8k9ud1qXU5hiHqYUhXYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714482818; c=relaxed/simple;
	bh=kLTT8PdSPjqEUj/DINVj3Czn5fUgObf6p+tw6LndT3g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cy7h4jXJsHa9M1OYYvWCxI6Wm+jomfOBPoM2Ajb7wONk2h6bXlPidK+Xl8u5Wt9fy+1feNZd0p/msZNrth45FKdIyXj/QJ6z3KI8/KOmXHZ8GVDiyMVupk6DH4CJ/D7ZXLe9/1oeRlT0ACKhtCW0ozEVVV3OyX+seT1MjVGJNOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ID2zm2bR; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2db17e8767cso66649791fa.3;
        Tue, 30 Apr 2024 06:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714482815; x=1715087615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lEiQCh8/vM164hKtCV0cZlzJ7+O6D+BB5JWCNOESyBM=;
        b=ID2zm2bRfoTcnbCajTS/0HcSUWYOP7ndj/NIEtLmBz7FurFc86kzigE9nPdVJepDF0
         pisRfGQpzraTL3Q6ILOJB4yLywGTSHuXAcd+X2wbzOtfahrLPV3b3HNkgBNZPGAR6Lca
         MNQ6Q/uvVMTevNtl9RONbjsv8iyHQd6uBvONDqUUXq/TtN7QAveiRrnOZ4mLMgEEok/S
         8d47pP00GnHaMuEhrqEIdob89t6sIoBnOhFWTUcL9wdblN+SRAbLRhRIfWyTkFLbPeLy
         YuXfsm8/ZSUBvQFd87j66WRGRidwPv2a+7nLIysTG+85U1DG3aCMlnCpiHdyh4dMGrT4
         lsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714482815; x=1715087615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lEiQCh8/vM164hKtCV0cZlzJ7+O6D+BB5JWCNOESyBM=;
        b=vbfA3W52McY8SicmPJUrH5E85QY0ttGPTAC4Jl8azRBEwxXJFA8t3tNb9KmAFPw95U
         F06yCUtDxfc1XvO1ZyZg+alGM2oXDcDyK8/UNwpw8q5NoQBUuLxT1sN97zw7Hu2/3FWT
         HxIyItGadIuSqgmmB3Tp4WgXhOUCaO4meYrDh8wGf2Rod8tbAekRJl/fv/QtB0KbOSz8
         Dm6Ez2p6dojcxXMFcWO2eKprJQqxnF6hhwPaP+RK0gwiExkNrxs1A7fPzYsp2kW4IsQS
         tox9xsIxVT37wHIcVoE+mtIU6o2NQ+v8Uvw/OBTb+lrDM/3hoAO34GeQu64nbpf9OkOD
         2uiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTUsAvL1uRI2q3oLBb715mKGrt0O2KmvYqpcWH1c/vTLkiWGJLIcS3DQv0SQ4ubdMCu8g7bmUKJp/kcenDQ4kqe4ypxW9j0RPXvuHBaKhxlkcIGfC196c15N4POs25gmH0HSdI7D1S
X-Gm-Message-State: AOJu0YxFLr9McarBIpbbgEUDRhE7lO7oMlo+Fi6gHCzM9W6iCz+XvYxg
	X+GLrkjOmgYrE4K5SiRYVy9w5kClHykMfffy8d/B/r9sbLN5zRsO
X-Google-Smtp-Source: AGHT+IHSQ1phnYo2moNmnJNL94VwDtHV0Egi0VDLViK0e8Oi8fWuCIp0D4JhX5mU7RyqiM+pa52ceA==
X-Received: by 2002:a05:651c:1182:b0:2d5:9703:263f with SMTP id w2-20020a05651c118200b002d59703263fmr1603754ljo.44.1714482815133;
        Tue, 30 Apr 2024 06:13:35 -0700 (PDT)
Received: from mfe-desktop.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.googlemail.com with ESMTPSA id z10-20020a05600c220a00b0041bef325c4esm6404235wml.1.2024.04.30.06.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 06:13:34 -0700 (PDT)
From: marc.ferland@gmail.com
X-Google-Original-From: marc.ferland@sonatest.com
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marc Ferland <marc.ferland@sonatest.com>
Subject: [PATCH] iio: dac: ad5592r: fix temperature scale
Date: Tue, 30 Apr 2024 09:13:30 -0400
Message-Id: <20240430131330.1555849-1-marc.ferland@sonatest.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Marc Ferland <marc.ferland@sonatest.com>

For temperature readings, the remainder is returned as nano Celsius
_but_ we mark it as IIO_VAL_INT_PLUS_MICRO. This results in incorrect
temperature reporting through hwmon for example. I have a board here
which reports the following when running 'sensors':

iio_hwmon-isa-0000
Adapter: ISA adapter
temp1:        +93.3°C

With the patch applied, it returns the correct temperature:

iio_hwmon-isa-0000
Adapter: ISA adapter
temp1:        +30.5°C

Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>
---
 drivers/iio/dac/ad5592r-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index 076bc9ecfb49..4763402dbcd6 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -415,7 +415,7 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
 			s64 tmp = *val * (3767897513LL / 25LL);
 			*val = div_s64_rem(tmp, 1000000000LL, val2);
 
-			return IIO_VAL_INT_PLUS_MICRO;
+			return IIO_VAL_INT_PLUS_NANO;
 		}
 
 		mutex_lock(&st->lock);

base-commit: 98369dccd2f8e16bf4c6621053af7aa4821dcf8e
-- 
2.34.1


