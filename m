Return-Path: <linux-kernel+bounces-156652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 524CE8B0649
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 719FDB26512
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890F1158A29;
	Wed, 24 Apr 2024 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9g4xKEp"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F325158DBD;
	Wed, 24 Apr 2024 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713951749; cv=none; b=NeRJzxc99VsWe2IERmQ9EAphrwc9TBL8IYZMxBeQS3aLrYxKQOnt9BU9271GG2Nvn6pgpbOsWCTU2ttviV9Mb/h2OydwMITWOH6ccI6HnzeRflM+HqHDvDNqcsUB9Pzs6WC7S8GWGYjwk7QFGiBNpiM2kd/8mxlHvcjP4QZz/Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713951749; c=relaxed/simple;
	bh=54Ypi2YWKZZZ8mXiHCK6o59vKOH9tc6rq7rSTQM2KWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xad2HFObhgn1x06e4VODdjvphTdlJTehTdlaXyW9iqfRFR++uw5LpNtBUt0ozNHJTS/iN6HouZthxle+pVBKobsyfFfvSsjap2q3vwcjKVeC0uVuC7WrLa2EpE7uhURByNTOTNsmeDLhkaHtBBs/vBc6Kacqvy/2Xscfrw2yZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9g4xKEp; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3476dcd9c46so5055483f8f.0;
        Wed, 24 Apr 2024 02:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713951745; x=1714556545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hozz01DOL8TniYSNmk/0bph2Gyx1ufqAnTco042Ys5E=;
        b=C9g4xKEpl3IrbqxToTA/ro6l0iYiKNZ+BpxpPb/BZ8mIBUBdCkN8rkSXdZC3V8xYSG
         7pIgplcW+GKw5yfdpAUA/1W/I4cWMkKPvW+g32oz+6jUwinw0EuiRKuLVPcm7tXfp8t1
         4d7o+nVnQF5QNJ/1pLqPZijQrw/MvqfIUjT4+ZOQPOrCKwedP3IMufF0cJ3INsSzcn+3
         sVaCAlJUy0+oZK41HzFT1zKlqsWyc//p1EoGjqjwoMsncEqZdVjfDTZOkVahvm0bZaG4
         YKnCT25jIeky8R/E00aJzXlZSl+NQ/yl2QWY9oqTSrcdcVvund9EHdt9JepJdINS3phO
         bzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713951745; x=1714556545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hozz01DOL8TniYSNmk/0bph2Gyx1ufqAnTco042Ys5E=;
        b=pqy5afIsAvdhOO35Nx1jsiYzSpoMGCwAhIctaKJNDleKlp7A3gh/2YjTeNQr5F03El
         dzfUUBe0d2sB4aSeQ4Wlo+A9dT524HikFdS+gvqoNf0kE5ya6Cen9YqiXsOCLpu1j2Vl
         gZXGB9UAnVx6R3yDINYrUU9UapB3zRehAvc+uqDd9N4fTk+qJkwZEDGnfHxBq3EMD6hq
         mjXMIcJ7qrvbx7EDSrkmHMuXKOTw9jY1Ujfx8Hgy3kd6EKYW3OFUTqxcaAMd6Jtx5QuV
         XqZ7kgZc5yAEqRr54KTJUB6spwWINyPhNDXlVVhMlwvQsneOmED5NtVSbeaUFkHklzHj
         9laA==
X-Forwarded-Encrypted: i=1; AJvYcCWYsNJtHqlQcAaDv9RaOkH/frrKloAmgJgfxTXl5DaCP+JZQyCdpo4mR2L9RY6VAy2FHktnoX0BmRUWOSm3csN5bizGzp17FVNruORwZRFlAV/rKlhfbHfduFBf65jJxbF4hotn
X-Gm-Message-State: AOJu0YwVmp5tNcmp0+Z2jSFLP6/KJ0CxBOuGr0udZzOgWMvWwA5Fxp2u
	B8QocufyIzVI8JTk5HwCQBNrQV/EbQhftJyMG6CN3MTe3W4V5nbw/VLO9bgx
X-Google-Smtp-Source: AGHT+IFry4iQappguAVtadElpA1HZ/Ot1OseKqdtWnBdd6bsTbvInjhN53hmvfoIkjh3oOk9j3o3WA==
X-Received: by 2002:a5d:4892:0:b0:34a:4eac:2e43 with SMTP id g18-20020a5d4892000000b0034a4eac2e43mr1309158wrq.68.1713951744933;
        Wed, 24 Apr 2024 02:42:24 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:320d:e800:6acb:a317:3d30:4165])
        by smtp.gmail.com with ESMTPSA id a12-20020adfed0c000000b0034635bd6ba5sm16683339wro.92.2024.04.24.02.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 02:42:23 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
X-Google-Original-From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	corbet@lwn.net
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH 1/1] docs: iio: adis16475: fix device files tables
Date: Wed, 24 Apr 2024 12:41:52 +0300
Message-Id: <20240424094152.103667-2-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424094152.103667-1-ramona.gradinariu@analog.com>
References: <20240424094152.103667-1-ramona.gradinariu@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove in_accel_calibbias_x and in_anglvel_calibbias_x device files
description, as they do not exist and were added by mistake.
Add correct naming for in_accel_y_calibbias and in_anglvel_y_calibbias
device files and update their description.

Fixes: 8243b2877eef ("docs: iio: add documentation for adis16475 driver")
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
---
 Documentation/iio/adis16475.rst | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/Documentation/iio/adis16475.rst b/Documentation/iio/adis16475.rst
index 91cabb7d8d05..130f9e97cc17 100644
--- a/Documentation/iio/adis16475.rst
+++ b/Documentation/iio/adis16475.rst
@@ -66,11 +66,9 @@ specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
 +-------------------------------------------+----------------------------------------------------------+
 | in_accel_x_calibbias                      | Calibration offset for the X-axis accelerometer channel. |
 +-------------------------------------------+----------------------------------------------------------+
-| in_accel_calibbias_x                      | x-axis acceleration offset correction                    |
-+-------------------------------------------+----------------------------------------------------------+
 | in_accel_x_raw                            | Raw X-axis accelerometer channel value.                  |
 +-------------------------------------------+----------------------------------------------------------+
-| in_accel_calibbias_y                      | y-axis acceleration offset correction                    |
+| in_accel_y_calibbias                      | Calibration offset for the Y-axis accelerometer channel. |
 +-------------------------------------------+----------------------------------------------------------+
 | in_accel_y_raw                            | Raw Y-axis accelerometer channel value.                  |
 +-------------------------------------------+----------------------------------------------------------+
@@ -94,11 +92,9 @@ specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
 +---------------------------------------+------------------------------------------------------+
 | in_anglvel_x_calibbias                | Calibration offset for the X-axis gyroscope channel. |
 +---------------------------------------+------------------------------------------------------+
-| in_anglvel_calibbias_x                | x-axis gyroscope offset correction                   |
-+---------------------------------------+------------------------------------------------------+
 | in_anglvel_x_raw                      | Raw X-axis gyroscope channel value.                  |
 +---------------------------------------+------------------------------------------------------+
-| in_anglvel_calibbias_y                | y-axis gyroscope offset correction                   |
+| in_anglvel_y_calibbias                | Calibration offset for the Y-axis gyroscope channel. |
 +---------------------------------------+------------------------------------------------------+
 | in_anglvel_y_raw                      | Raw Y-axis gyroscope channel value.                  |
 +---------------------------------------+------------------------------------------------------+
-- 
2.34.1


