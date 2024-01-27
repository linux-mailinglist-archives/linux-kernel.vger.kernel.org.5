Return-Path: <linux-kernel+bounces-41386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C9683EFE6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 21:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F711C21685
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A232E648;
	Sat, 27 Jan 2024 20:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEcSyy0R"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539A52EB0A;
	Sat, 27 Jan 2024 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706385751; cv=none; b=r9sNoBGMXhCTRPI/p66o9+BI4uxES1XgnYH5fWpiF/Hw8d8mre8TDTV3uNvDwKz+TnIS/XymWsnrxVZqeI/mHZh/Qp0Odl9gSbfQtS7sP4yhlwrzxbffqHJB7vvtgfhuB9LzfdOJnmqExgHdmt69Ch/K1AvPOP3a5JskLpTEpi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706385751; c=relaxed/simple;
	bh=pyVigDj7XXFmAYV8yaSMV6NWrtFthJpHm91q/W6OcRo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sfVhNNwLJZbHV3ddbhgsr5kJ0zFWMmlfqTCc0kqsXxCN1VgkJo3nJEKgNvYmSlHBj/HzH11gBGW7nM06lMTIEIv4KoGKGghGV5N8UyvCriphPF1SF5NQYbld4QvICXKX15W6PYNOiiOB2sxMwG/Or4jsi013BjBXm+F17J1hGn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEcSyy0R; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33ae3cc8a6aso606050f8f.2;
        Sat, 27 Jan 2024 12:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706385748; x=1706990548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JDAwcXby0TIXFi0hTAuv1aAUwkqAC2wW0u4vJQk0oic=;
        b=ZEcSyy0RL46NmWUuc5SGm+HtGO/UBcgEbKOSVfJQUlU66szJKhfuCDy5yIlo3UU2zN
         T/vy3jW05rVfIrMo4iKqKfXoyrL7um/ZucUYniftNJGQlZyofSz8dsFtll3J5ju6Ehvw
         l97OSbPrIuW2CLuF9BUrQu8Qoxc3p4Ro5MfWenkCcGtsxEv+CuJAnIHJ/pdejEV2r9FJ
         7vm+sgy52ixtKjrEPRvq/6/QiloNmZ7VW92LH5J747zr/DMMWM0Z4ZGnc0Pb3vYWJA3/
         Y2QOjfcftlkhRCymp7hZilrH1joCqFTCFE8LW41Jf0G/jqpaYfCS0Mckh4+vAMpCHtNU
         bEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706385748; x=1706990548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JDAwcXby0TIXFi0hTAuv1aAUwkqAC2wW0u4vJQk0oic=;
        b=k2i0CCMO7KfcuLn5lzsKdcrkarEOiPRwCzn8UM2PgiT8M3dtSDCJr3vAAADyG2JDNn
         2aNn0GDxYYioImjgNv0K6PoQIh9vJZ2X56Ve/vOSl1N5HtDi2TN0ptmC8rSszaUBH/pV
         CQrK/2z5G7n1Dw7fHb0j3dD469S0AVOeNq/B3wjAEbOhv9VkB/c2bgkCPXWLNa6azX7N
         YuD853c1Y2+IHJJKUjnCCmEgrUm5Ur/KdDWGm+H45g4bWSveOFT996oRZc0opcr7crwY
         GfaTC03ZrXUG6Nbi1OKOqS3uSKjemtcwTZ46gBYgOudqGuih6kUdJVaIoTZohOxoiQ1Z
         HZaA==
X-Gm-Message-State: AOJu0YyDdZR5PwFgtYuPRqciV/wQcCkJ8QRVMYVgtVpbj0DRgXAum97E
	BZsTNAU0JtY3ygYGGXxnWCsS2WtCsaNNl2/AFdtDwPuTKceIs1b8vBjxi9YnU8Jr2Q==
X-Google-Smtp-Source: AGHT+IHj/W32xTt5pBJFaatFt3rlQWmznS8tGCjfXuhrPD2S/Nu0YgS3eaTqQ9sZ623hdiDnVGSydw==
X-Received: by 2002:a5d:4e0a:0:b0:337:b02a:3f6b with SMTP id p10-20020a5d4e0a000000b00337b02a3f6bmr1635534wrt.48.1706385747833;
        Sat, 27 Jan 2024 12:02:27 -0800 (PST)
Received: from AT01MCL012.. (2a02-8389-41cf-e200-4080-59f1-b398-a889.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:4080:59f1:b398:a889])
        by smtp.gmail.com with ESMTPSA id ds8-20020a0564021cc800b0055c9280dc51sm1909340edb.14.2024.01.27.12.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 12:02:27 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH RESEND] iio: move LIGHT_UVA and LIGHT_UVB to the end of iio_modifier
Date: Sat, 27 Jan 2024 21:02:08 +0100
Message-Id: <20240127200208.185815-1-javier.carrasco.cruz@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new modifiers should have added to the end of the enum, so they do
not affect the existing entries.

No modifiers were added since then, so they can be moved safely to the
end of the list.

Move IIO_MOD_LIGHT_UVA and IIO_MOD_LIGHT_UVB to the end of iio_modifier.

Fixes: b89710bd215e ("iio: add modifiers for A and B ultraviolet light")
Suggested-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 include/uapi/linux/iio/types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 5060963707b1..f2e0b2d50e6b 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -91,8 +91,6 @@ enum iio_modifier {
 	IIO_MOD_CO2,
 	IIO_MOD_VOC,
 	IIO_MOD_LIGHT_UV,
-	IIO_MOD_LIGHT_UVA,
-	IIO_MOD_LIGHT_UVB,
 	IIO_MOD_LIGHT_DUV,
 	IIO_MOD_PM1,
 	IIO_MOD_PM2P5,
@@ -107,6 +105,8 @@ enum iio_modifier {
 	IIO_MOD_PITCH,
 	IIO_MOD_YAW,
 	IIO_MOD_ROLL,
+	IIO_MOD_LIGHT_UVA,
+	IIO_MOD_LIGHT_UVB,
 };
 
 enum iio_event_type {
-- 
2.39.2


