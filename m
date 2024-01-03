Return-Path: <linux-kernel+bounces-15492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFF6822CB6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8032DB21EA4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D9119450;
	Wed,  3 Jan 2024 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNFPcH8B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4AA18EB2;
	Wed,  3 Jan 2024 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-336746c7b6dso9340934f8f.0;
        Wed, 03 Jan 2024 04:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704283746; x=1704888546; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3HxXaZqQGOpnmGmdiVei4YbOtWHqTHWlxdX/eXyYuxA=;
        b=GNFPcH8BNsh6qFKL898Mauk4dd/btqNl4RtnxI/lfoFP2t9/tOrn/UquHphO1f5is/
         qp/VXuYVogvUR1FWhI3LRr3izo9+xOhwo//xpoc0lNWf+NweZnkHJZW32ipoEfkX7l2n
         rleTeQ2RBDXedRjFMHzVj/JuJVbJLfqBCfcJ4hStkMcod45kLDWpi+EVk7sUbSPEl6wX
         e5csqD0ZpYd0hr1OazEiPRtRXJpOrYrIOLnx5b+Fg+hDaK5srSF4MfoIYL9el8FyVlRC
         kbG5btGkrDrwCDhjFNLdmm2CTleIVx9MTJ9N//WJ6QQhfZvn4PHP9YMmid2eNgK/F+T2
         jZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704283746; x=1704888546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HxXaZqQGOpnmGmdiVei4YbOtWHqTHWlxdX/eXyYuxA=;
        b=rlUvjBt9gOYVnVH41t3NXGVDJcte5vznjwzUuRw2NRsRS8xUyDaHv/E9EaUjmooYgk
         AQWR7mTRm3D4aiBXMcOpYjQUd2LW58nRiMugPRw8xeUOGDV0uzAYFtGDr8aPB+I3rnkc
         GbLlPvT2KjL0Yqb6HYqxiSLIxWLebpAbPxQqfOZgHezquIR+rT0YUwlWLqVN1fXNgVHL
         /17EFQOFRRJ7yolxPtbg/7XIsdv75GVSTuqiopzBiWGuCD6i8SiG2FmWBmxLryhGeG1G
         J4acpej2fzzgsjLVIksjrXXxr3OwEtGZ1ebpQ7jKsAcmTA2BieCwuG0AU7xvHza1pFDa
         qtQg==
X-Gm-Message-State: AOJu0YyXVVrknZACcqJ9VlC8ri/bK9bwVcvtulCk2bgfm+DAZpr5AG9G
	YDNnLDzOFqMoerM+NeqNAFjuhJjRbHOgCQSO
X-Google-Smtp-Source: AGHT+IG3GBletUEOZZSx/cadwXeccfqkXB012KQgAmdGLTcifJ3I1z/PUCovcZs7LJunQYqZde5REg==
X-Received: by 2002:a05:600c:ad3:b0:40d:80a2:d21b with SMTP id c19-20020a05600c0ad300b0040d80a2d21bmr3288057wmr.151.1704283746247;
        Wed, 03 Jan 2024 04:09:06 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-1a90-a88c-d3fe-4285.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:1a90:a88c:d3fe:4285])
        by smtp.gmail.com with ESMTPSA id o28-20020a05600c511c00b0040b37f1079dsm2106443wms.29.2024.01.03.04.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 04:09:05 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 03 Jan 2024 13:08:51 +0100
Subject: [PATCH v2 1/3] iio: light: as73211: use IIO_VAL_FRACTIONAL for
 intensity scales
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-as7331-v2-1-6f0ad05e0482@gmail.com>
References: <20240103-as7331-v2-0-6f0ad05e0482@gmail.com>
In-Reply-To: <20240103-as7331-v2-0-6f0ad05e0482@gmail.com>
To: Christian Eggers <ceggers@arri.de>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704283743; l=1689;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=1MU3giKWl0gPRroVrrkRwqryd8WZu7+Nv1DcBdlcyYE=;
 b=wYfGApcioFFsmZe4cBgXSFsR2MKOE6mwqP/rJLgi01qhG8GRJz6KyvTv1RXbwZN7T0KbxxdBR
 GinIZpVOOv5DpscHaAI1N1nl2j0EdCPbPdxI302hH5sWevexjpUTz1e
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The scale values associated to the light channels are calculated as a
division that can be better expressed as an IIO_VAL_FRACTIONAL type
instead of the current IIO_VAL_INT.

Note that the constant values used for the calculation were scaled up to
work with integers, turning the nW/cm^2 units from the datasheet into
nW/m^2, which would not be necessary with the IIO_VAL_FRACTIONAL type.
But to avoid issues from current users of the driver, the units must be
kept.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/as73211.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index ec97a3a46839..b4c6f389a292 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -356,25 +356,24 @@ static int as73211_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec cons
 			return IIO_VAL_INT_PLUS_MICRO;
 
 		case IIO_INTENSITY: {
-			unsigned int scale;
 
 			switch (chan->channel2) {
 			case IIO_MOD_X:
-				scale = AS73211_SCALE_X;
+				*val = AS73211_SCALE_X;
 				break;
 			case IIO_MOD_Y:
-				scale = AS73211_SCALE_Y;
+				*val = AS73211_SCALE_Y;
 				break;
 			case IIO_MOD_Z:
-				scale = AS73211_SCALE_Z;
+				*val = AS73211_SCALE_Z;
 				break;
 			default:
 				return -EINVAL;
 			}
-			scale /= as73211_gain(data);
-			scale /= as73211_integration_time_1024cyc(data);
-			*val = scale;
-			return IIO_VAL_INT;
+			*val2 = as73211_integration_time_1024cyc(data) *
+				as73211_gain(data);
+
+			return IIO_VAL_FRACTIONAL;
 
 		default:
 			return -EINVAL;

-- 
2.39.2


