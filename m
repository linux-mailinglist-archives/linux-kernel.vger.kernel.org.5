Return-Path: <linux-kernel+bounces-89931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A5C86F770
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 23:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3996B20B5F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC26A7A733;
	Sun,  3 Mar 2024 22:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9r2KHlD"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A91A6CDAF;
	Sun,  3 Mar 2024 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709505304; cv=none; b=rC+4ujUPad4xDsti2DYhsbKPU8dX/Ais/DajWoEvuRedNA9XMA/t2LQcIzCU/fOpUDUvD7dj3DyED4OCW3ZPc7eYnT5psz9nqMCd0dd4mysTk1bA7PoGIlNrkFstNuTJigSlJUvV3DCoWvE2HFA2QmzWpGIDIxDu3vWrTawoSzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709505304; c=relaxed/simple;
	bh=DGQR7yTAjvJgIlGiMzFgGM447krkPjSSGe0AV90aCFI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sit2fFn2HxDoEAhWMCbSbsQTWA+LECq3rJQm1g+0nECZwRinrSmEWh/l3zk9BDQF/NKu+vwF6z7Ee2SsRkJK91gi0Ml2G41Z22tZwyks4bR5B3ywdoEuVcExUN/fxkGxCRQ2mx8d2Mm2L19Y2/Rh4ByELlbZlDz8RpsL+EkVHRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9r2KHlD; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so819480866b.0;
        Sun, 03 Mar 2024 14:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709505300; x=1710110100; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/tNlHdcdou4LPuSKHe0Zuh/h9dgjEfE6QEyEmebUH3A=;
        b=A9r2KHlDxTQ16/xABfYuNNvh6Zq/dg4OHfJHFxIfqW7e3QaoIqKqSOaQ5CYrxZIxLo
         geOmfbTG9qxko4Tth3B/ZDQVzzBYSjwwJW/Yg2S4sdtxLN2ARicQz172XQ0b7lkOEPHA
         /R7Uu8stao1ZTAEQmDBOa82420VD0qIlwqeFUKaDSclr6AKAPyVlgKk9B+/uePkxf4ve
         BAcpDWEbmIDLLcD/6i3KJFD2sKpFnoYmmdN2VTxvNaPvHw7cNhVqbECyp5xDnXP58pcM
         q0UMU0OgnxtbcvpzFbVlSeekp9xUVY0L6CKTZMS6ZUgzuZWQs1gEGIsDQmQkiR4O8UM7
         KcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709505300; x=1710110100;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/tNlHdcdou4LPuSKHe0Zuh/h9dgjEfE6QEyEmebUH3A=;
        b=rpeXVXnCHW1o+vciH0J1EFshw+nGpegB1kGSvYolPxlI4ei79OkwM1+qSsdH1gwAe5
         y98EIFzm9KukJp4+64Abp3KVIOym3pXBOw9ucbKFoajkL2iCuWxDUP0x+Jen3dCBb79N
         fuZSGzF04OLIFao8lwF5vSpC60ZcGvbJwIXubvqV+i97wHVtyNDwhRQ+8lXhduw6MDJ9
         PvWg76trBfIGN20uxz9J8SeZznqEjrEr/L0sNIxRUxV1+qN+uoRlppOm8dbNZKUERKn0
         nunUTnVrI8m2zf/k0w/DEXXgE08wzTcqhJBfKKHQ3Ts+6SGe4mevp3vhcxZb1ZI1PNcM
         qM4w==
X-Forwarded-Encrypted: i=1; AJvYcCVzuQpQiimdxC1ztrfS4AmkiIZMCJLmoEy1JA41Hlu4VHPn/FdXTmc17NEayyD6pyFJTzPw0aG+pdBvG1Lo+b9/VT7okYkJYiji30y/NMnja9tDza8SQtyCl6dIqYcDsGLDcd5nJeiU
X-Gm-Message-State: AOJu0Yz9DDsAO8NsGs9K8XnIU0OgZT6fvswGzjIhhS/AQHilTPQhpyG+
	JKR6t8KoVdXMlXN4wHgjji/L3a+/Shr3qG8VjQzTBxSxsu4F4iUasHBIX6gOR3H8Yw==
X-Google-Smtp-Source: AGHT+IHDSOPMhDudX8vHLLPYNLmHt9x+K+Vhf3qBfeu2wyfH+r48StL8lIgCZJM13j9WbaVRAc0ycg==
X-Received: by 2002:a17:906:c2d1:b0:a43:74fa:4f08 with SMTP id ch17-20020a170906c2d100b00a4374fa4f08mr6545593ejb.9.1709505300053;
        Sun, 03 Mar 2024 14:35:00 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b3d8-5b4b-5188-4373.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b3d8:5b4b:5188:4373])
        by smtp.gmail.com with ESMTPSA id v23-20020a170906565700b00a455ff77e7bsm82204ejr.88.2024.03.03.14.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 14:34:59 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/4] Drop casting to void in dev_set_drvdata
Date: Sun, 03 Mar 2024 23:34:38 +0100
Message-Id: <20240303-void_in_dev_set_drvdata-v1-0-ae39027d740b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP765GUC/x3MQQqAIBBG4avErBPMWmhXiRBp/mo2FhoSRHdPW
 n6L9x7KSIJMY/NQQpEsR6zo2oaWPcQNSriajDaD7nWvyiHsJXpG8RmX51Q4XEEZtkuA0xaDo1q
 fCavc/3ma3/cD4xEpa2kAAAA=
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michal Simek <michal.simek@amd.com>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709505298; l=1396;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=DGQR7yTAjvJgIlGiMzFgGM447krkPjSSGe0AV90aCFI=;
 b=AJ1cpYmZ0AZHVstvJ+M+lXezwyXXWXlb0rdJxX9HWXNJSCLixeSgYE/xz9vhpBcm7ZQTdBLhu
 dJbuK5EeZI7DKAU4sbZlLbVnW8UtHY0dLgmZKjIy0TpxQGZmCfPrHko
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The C standard specifies that there is no need to cast from a pointer to
void [1].

The vast majority of the users of dev_set_drvdata do not cast their
pointers to void, and the few that do so should be fixed before it
spreads by following bad examples (which I was about to do here [2]).

The very specific cases where the cast avoids warnings (e.g. droping
const) have been kept as they are.

[1] C Standard Committee: https://c0x.shape-of-code.com/6.3.2.3.html
[2] https://lore.kernel.org/linux-iio/20240226-hdc3020-pm-v2-0-cec6766086e8@gmail.com/T/#t

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (4):
      char: xilinx_hwicap: drop casting to void in dev_set_drvdata
      io: light: st_uvis25: drop casting to void in dev_set_drvdata
      iio: humidity: hts211: drop casting to void in dev_set_drvdata
      iio: imu: st_lsm6dsx: drop casting to void in dev_set_drvdata

 drivers/char/xilinx_hwicap/xilinx_hwicap.c   | 2 +-
 drivers/iio/humidity/hts221_core.c           | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
 drivers/iio/light/st_uvis25_core.c           | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
---
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
change-id: 20240303-void_in_dev_set_drvdata-2d8cae908e49

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


