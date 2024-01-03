Return-Path: <linux-kernel+bounces-15491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0143822CB2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F02D28428A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805FA18EC6;
	Wed,  3 Jan 2024 12:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ll0nXRNW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C0318EA9;
	Wed,  3 Jan 2024 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d60c49ee7so55100895e9.0;
        Wed, 03 Jan 2024 04:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704283745; x=1704888545; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pXf0lQyFwEwRNVQTGcX9YEs7f4KPo2gX1iJbkPDL704=;
        b=Ll0nXRNWKRBtxN7kfyIIA2YX6AWlRDzId2KkMYglKfpHLQlLPbuiYQI27RImlNpnMe
         UqkNI2POoefBrL0o1/rf/XK1Zm4kd5Tsygy6L9JX/moV1guxx9ti8HSH5IogYmb94Cyd
         A4EecN7pICkN4Na9YCHK7jqTkN1au94eatR6Y+wsNX8UL11Zw3T2qWD7B+gqBVQ7MDKI
         OfXQwPcfrGUQt9ZzxIay5llKF8pQFoDdcYc7/ua6Tchl+lRFyMmLRLsP6spnBDw4N5PX
         oVivzaRTiNCLMYp3+a8H4vFZSIRVUKjHt7jIiVRIBsbzNIdPtIN31SAYgDl6ADUeCs9Q
         UW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704283745; x=1704888545;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXf0lQyFwEwRNVQTGcX9YEs7f4KPo2gX1iJbkPDL704=;
        b=qNhWlWF3MTytxB8cWyDs1b4BekIj/2AnwTGNoinZT92G4BmyGlF0ORbJsxofEfbNhX
         GhyRNjXy6rL30BxSWqGgkrTeS4YvO5mzpK/F3Ki4K6gSY3L9GXaHrj+Ier5rZUEVVooa
         bzG3pMfHzTJ5Z+b+1y7ZVZs+BPluaMx+CBVt0dKYwYRDq4aW+c/uuPYReA1pKR1mwVS0
         x+pM2BJ0L5/nGKXTyCWjOeIKQXN/8ME2kGxiX12FZ2x88exY0qURFhPLMXz38qVJ1yPS
         wO3NE2lJCKNbiGFCZckDGVqbOqClsnDvSuV2fIM/PNxI7HGim0tS+ZIfTjg5pbvfXF5R
         k9qQ==
X-Gm-Message-State: AOJu0YzlmjE/vKG3iZcseqvCR03Y3aNzu1AcKLYGJa05vzgD16JWEFk7
	e5Vp5Km20NZjrzMQF11MUltrAHwtzXcBYIXu
X-Google-Smtp-Source: AGHT+IEjODK/jvta1d9aXyIzfRucwDyxX/6zTvaly0WtodRwxD1uG0bBRsVoT2t3rRyLJjeMesbAyg==
X-Received: by 2002:a05:600c:b4d:b0:40d:3c6e:6645 with SMTP id k13-20020a05600c0b4d00b0040d3c6e6645mr9668966wmr.188.1704283744838;
        Wed, 03 Jan 2024 04:09:04 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-1a90-a88c-d3fe-4285.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:1a90:a88c:d3fe:4285])
        by smtp.gmail.com with ESMTPSA id o28-20020a05600c511c00b0040b37f1079dsm2106443wms.29.2024.01.03.04.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 04:09:04 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/3] iio: light: add support for AMS AS7331
Date: Wed, 03 Jan 2024 13:08:50 +0100
Message-Id: <20240103-as7331-v2-0-6f0ad05e0482@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFJOlWUC/2WNQQ6CMBBFr0JmbU07FUpceQ/Doi0jTAKFtEo0p
 He3snX5Xn7e3yFRZEpwrXaItHHiJRTAUwV+tGEgwX1hQIlaIUphk9Faiba1WHsi1zQ9lLGziYS
 LNvixzMNrmopcIz34fdTvXeGR03OJn+NsUz/7192UkMJcame0R2Okvg2z5enslxm6nPMXkzMdo
 rEAAAA=
To: Christian Eggers <ceggers@arri.de>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704283743; l=2200;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=YRkmEanrsaNXmNoADEI1mKDu3qt68A9g4oqvAtqQ9FA=;
 b=Bu6tbLXWanEaPUsbnq/Xrz1CrkbJMgr1PTyvwlz4+gZzx/twP9xhomSY328DqJ3BtVsYInmDM
 jy+H2b5Zzo+DUl8Sw3PP+VUDnsZlwMYI3phwVUe3Rd3hYpNbCC6K0+r
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The AMS AS7331 UV light sensor measures three ultraviolet bands (UVA,
UVB and UVC, also known as deep UV or DUV) as well as temperature.

This device is practically identical to the AMS AS73211 XYZ True Color
sensor that is already supported by the iio subsystem, except for the
photodiodes used to aquire the desired light wavelengths.

In order to reuse code and reduce maintenance load, this series extends
the AS73211 driver to support the AS7331 as well.

Note that the UVA and UVB light modifiers have not been merged into the
mainline kernel yet, but they are already available in Greg's char-misc
git tree which can be found at
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The original device AS73211 supported by the driver could only be tested
briefly due to the lack of hardware. Instead, the i2c-stub module has
been used to make sure that the driver registers the iio device properly
and the attributes exported to sysfs are correct. Some basic register
assignments reported the expected intensity scales and in principle
nothing else should have been affected by the modifications in the code.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- as73211.c: Use IIO_VAL_FRACTIONAL to retrieve scales of AS73211.
- as73211.c: simplify device-specific data retrieval in probe function.
- as73211.c: minor coding-style fix (shorter line).
- Link to v1: https://lore.kernel.org/r/20231220-as7331-v1-0-745b73c27703@gmail.com

---
Javier Carrasco (3):
      iio: light: as73211: use IIO_VAL_FRACTIONAL for intensity scales
      dt-bindings: iio: light: as73211: add support for as7331
      iio: light: as73211: add support for as7331

 .../devicetree/bindings/iio/light/ams,as73211.yaml |   7 +-
 drivers/iio/light/Kconfig                          |   5 +-
 drivers/iio/light/as73211.c                        | 142 +++++++++++++++++----
 3 files changed, 123 insertions(+), 31 deletions(-)
---
base-commit: e9215fcca2561b208c78359110ee4009b454f761
change-id: 20231220-as7331-88a25ceeb66d

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


