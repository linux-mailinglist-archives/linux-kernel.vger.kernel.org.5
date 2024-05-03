Return-Path: <linux-kernel+bounces-168426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 190FA8BB873
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0D61C212F5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1553584FDA;
	Fri,  3 May 2024 23:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgNVtoTM"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA84B50297;
	Fri,  3 May 2024 23:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714779965; cv=none; b=pwCIzWF5JV9UOQ+zCQv3elg+T+MR8ty7WvygUqGxn7Ysn8WNk8sPyanQ2uarYLuZe1+msSs6dxJUCoGY6lsx/b64MokY6aTY6Jf8scDZVCCB2ooZKWB4xVG0e/krmnqDU/YRgwTNNdqpnbJMoKYX+KkYoTotXR6VMXK4v6Cs+0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714779965; c=relaxed/simple;
	bh=5K0UI727ZGH1My2g+t7Ps9iz2NzNhaFP6vQrhdlsX0U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RHBik1mfE/SeXba805bB+vOAomHInqZ3AncvTwctTAURqdj+kiMHcTu0q6Y+0nsGrrlvIxqDxwRQId3Fu955dEe92YRqc6Bdq1ar/4anWdvbuqGpg7PpIkjye2ry7nRZdQ/orhv2gjHe8SFTdJmQJyJ9U1WCXOJyzZtAkmO4o4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgNVtoTM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41b782405d5so2439815e9.2;
        Fri, 03 May 2024 16:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714779962; x=1715384762; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qAc6sj8C7qiSk0zYfab9+Z9vgRlgyh/FLkZdDSR9ImY=;
        b=jgNVtoTMFyJvz0sYJB2c04dPOLItfDzndvYtsgqelwDBAZ7GZWC6lxq/gm9/LeWsNM
         xCi4fqHaVZiAHY8eIFsHO8J3+jyihPHiHol3DB5S0+bWVGwVPKo1ipslK7/HxG+fTeFd
         0ZX/Mnw3K8I0SDTm31Cq5H63NjeND6AjY4Wb5X7gnYCGXtEcAIK/mRxpyieLJF4ihJZn
         keXva7vOJh69PffjaWSDZwEsQAWAFkgQW3EKjgvx/+UWD7wgUJ+D/9czOM0b9CSoRbSN
         Ad4DiBAfVf9oln2PNBPblMONqjBgkFN7CEj0tzmyIIBEyvIqfuzGjzfEpVjX/1nbxmju
         uQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714779962; x=1715384762;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qAc6sj8C7qiSk0zYfab9+Z9vgRlgyh/FLkZdDSR9ImY=;
        b=cGkPDhxka08+r82ibi564F3tIgLc9fsQvKrt+H0jgIBIsem/2R8vvKPx+wZhkqSJpt
         mzRQ4QMUZCyu3tAg5/7EM2OH6VaQnlwNbHSqsDjA5jb93arw+Mf3uPIdMmKAQV64DYV1
         c+hzG/kfoBD75YPh+eHdxi0N2BKxRVV5GlbaDyGC0bH+OksRFLGBMbvbC9fSXVHNdiHs
         10QWgC3SNNjpwWEVSXJXPlTIgnFMD0qLv2z+pT8VjWquUiDgU/eGpLuK0IRXsaeaTaH+
         I7x4Xg0NtvtPVyr4ckLtvWdzBZiQtZAt0oFyasCfMVm494ahN06W55XVNjasthtlgrgn
         nRkA==
X-Forwarded-Encrypted: i=1; AJvYcCUYxfBPfT9Cu96q6s7kC/H8rc4UyTG9DS3FfKsGM8f1hgN9N55y992WJha6fJOpgcn8gOAUSVuXWdhAhAdfkLNNNcii+SJKGQ4gUV9YgoqahqhXpOf9ODYi4xA9BC03kl/K20VUVRwKYA==
X-Gm-Message-State: AOJu0Yz5i/ES5Dx94ikGGYihDTT/jc1fPdKsVyIBGcjqelgjOPmlgBkK
	TNo4L7khM9wRclfO2XMJGgMzeY6QOC/J7vC2POf1+LcPinX9NoAy1GrRhS+5
X-Google-Smtp-Source: AGHT+IGy3137sokK8+4RRzfMjrOaGtkf4D6NWgGo6Ft/8SgtIDqJH4gYc9vWcb7l6xSr9iFC9ZjCDQ==
X-Received: by 2002:a05:600c:4593:b0:41b:d85c:d3e2 with SMTP id r19-20020a05600c459300b0041bd85cd3e2mr3942192wmo.38.1714779962077;
        Fri, 03 May 2024 16:46:02 -0700 (PDT)
Received: from [192.168.1.130] (BC24954B.unconfigured.pool.telekom.hu. [188.36.149.75])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d6106000000b0034d743eb8dfsm4819405wrt.29.2024.05.03.16.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 16:46:01 -0700 (PDT)
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>
Subject: [PATCH 0/2] Add support for bosch bmi120
Date: Sat, 04 May 2024 01:45:23 +0200
Message-Id: <20240504-bmi120-v1-0-478470a85058@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABR3NWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUwMT3aTcTEMjA90U42QLi5TkJGMDc2MloOKCotS0zAqwQdGxtbUA0yU
 zAVgAAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>, 
 Danila Tikhonov <danila@jiaxyga.com>
X-Mailer: b4 0.13.0

Add support for bosch bmi120. 
BMI120 is an energy-efficient version of BMI160. Despite having a different
CHIPID value, this variant seems to be fully compatible with BMI160.
It could be find in many phones like xiaomi-vince or xiaomi-tissot.

Signed-off-by: Barnabás Czémán <trabarni@gmail.com>
---
Danila Tikhonov (2):
      iio: imu: bmi160: add support for bmi120
      dt-bindings: iio: imu: bmi160: add bmi120

 .../devicetree/bindings/iio/imu/bosch,bmi160.yaml  |  4 +++-
 drivers/iio/imu/bmi160/bmi160_core.c               | 24 ++++++++++++++++++----
 drivers/iio/imu/bmi160/bmi160_i2c.c                |  3 +++
 drivers/iio/imu/bmi160/bmi160_spi.c                |  3 +++
 4 files changed, 29 insertions(+), 5 deletions(-)
---
base-commit: 9221b2819b8a4196eecf5476d66201be60fbcf29
change-id: 20240504-bmi120-d3c88dcb3073

Best regards,
-- 
Barnabás Czémán <trabarni@gmail.com>


