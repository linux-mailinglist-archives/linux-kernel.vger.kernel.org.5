Return-Path: <linux-kernel+bounces-82334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 002CA8682F5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94CE91F26EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360691E880;
	Mon, 26 Feb 2024 21:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMlCQEeD"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16871CA91;
	Mon, 26 Feb 2024 21:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982761; cv=none; b=AsIeqtcPDjPgWvHgGqnqntgfxmfui2knn/jISpKUVpnm6IOnnzX1Hll80CF7cwTN28fSVaN7AUB7SSc9PFJ5nRLzW74u6i9SNEjNVK8axZ4qbl+9wQFGCL77vfE5GPuik7Bfi5izquCC1sn4wbn70YRIPUOqUDhyBsJ0sIsSAZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982761; c=relaxed/simple;
	bh=Zs2gDuZA5ZODfpEp9+C4m2HVDRB1eKQpO4m4StbVvVo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pREosLqyZZLgYtZX2YoAFiZp73GFJ2jyxd2bohgIL5NzqwZJ7baYKYBhF3Bqel5tDs6b5717MMLpP43DlPAUsOnYQu4reydeNTJmLilZFgXersbAtybVGP7jOMN1N1bSoNSLZRcLBluGucTFGCY7F1DkELUFh5ye2kHtQwMun6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMlCQEeD; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a28a6cef709so549400666b.1;
        Mon, 26 Feb 2024 13:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708982758; x=1709587558; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=taG28Ml2TAcZMSyfmZnFNJIh7ibCQOUX3TCA8bLk/iw=;
        b=GMlCQEeD/dm7vb99fpvJcy96/IsKFCGUWKOOaMrOZjv+MsRgZLbVWBSTYHcl5szNNm
         wMrVqhM2nU26wPLD5e2NQYWOK3hBoknbi3RqFV/iQDOzwS58iP8B+2IlgLMv+rtIa1ri
         cbBmMY2V4NQbypUkh9N3giM8ytCG06TVjz8V9mganhrwajJTH2WdUZo2Ss+jYXZ/M6QI
         V290v7Q1alYFoOeox18VjnzV1y6nbnX08+yBOxNRAodfIcaiVMZMLfAyp25DS4S9VwR5
         tijkR7BLxdHF74qhC3jXFV+XrEjoggamQzOA6FPcG5/bHpVbVBLy8qw15Fg5bifq5Dbe
         HWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708982758; x=1709587558;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=taG28Ml2TAcZMSyfmZnFNJIh7ibCQOUX3TCA8bLk/iw=;
        b=LStJHE45zDYG1t+PK0NNZI0nmWE7bEEIw0w4WbAggtYs/bupv2aK422koqlUNKU7k/
         5y3Hdzg0YqLNVPPToCwwOI8dnSWzWoG/gZ+YWxLjkQa0b8dYXmxMOaKYKqVqonrcIcxy
         7KXZ+J9KG+4CoW1Atsz7O8qep7ONEiw5ryWvZuIS4P4Odh+bcm6jGsrfzbOSBBcSoL3V
         I9KRX6AvQ1tCv+Jytw6qh8M0fG2YSDkIMJmNsLthr1ZNAqLO3HHFttfITr6U37xToXaR
         yoK0pprn0njyZ6IGp81VslXFEuwj5eAjW2CKZs9GXENAqbiP42NYTYCGqT/kZwvXvQ/u
         qtzw==
X-Forwarded-Encrypted: i=1; AJvYcCUbRi8ytDTr9fjqYgfbjV/l29SSu3d2A2qV8SsjBBf1B//EK64Y0nY1PbxeERV342ygLG+FRsoKzRWeHRLWZJjcc5FuPzmgeOslhUAulR5bht5QBBiF9Nli4BkovKRu98tBzex+W8JYBGyeaSLufU+za/SJ0bx+2SJxyXSqzVfvXAHJIw==
X-Gm-Message-State: AOJu0Yz8sBN18h5O0UqOMbcMoNrw1toN4fo8CLENBVkvyHXQ7nptHVW6
	1HMb2e5u42cnhaaDI6e6F295XBVZVhB0jZDelysmB/klehKMhbhyXxQ/NyHlFETpzw==
X-Google-Smtp-Source: AGHT+IHCmJodJVJGy5ohDz/9VB3pKpiJeOM4I9HC+dMMors/n1EoY9aOiUkoSF0Dh8rW1fD8+CO+0g==
X-Received: by 2002:a17:906:3789:b0:a3f:1b3a:1289 with SMTP id n9-20020a170906378900b00a3f1b3a1289mr5636079ejc.59.1708982757776;
        Mon, 26 Feb 2024 13:25:57 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-06e1-5ae1-dc32-d149.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:6e1:5ae1:dc32:d149])
        by smtp.gmail.com with ESMTPSA id uz28-20020a170907119c00b00a3df13a4fe0sm122386ejb.15.2024.02.26.13.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:25:57 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/3] iio: humidity: hdc3020: add power and reset
 management
Date: Mon, 26 Feb 2024 22:25:54 +0100
Message-Id: <20240226-hdc3020-pm-v2-0-cec6766086e8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOIB3WUC/03MSwrCMBSF4a2UOzaSh5jGkfuQDtLk2lwwbUkkK
 CV7NxYHDv8D59sgYyLMcOk2SFgo0zK3kIcOXLDzhIx8a5BcnrgUmgXvFJecrZEJrU2vPCpnR2i
 HNeGdXjt2G1oHys8lvXe7iO/6Y9r9jymCceZ7PHM/ojZorlO09Di6JcJQa/0AeOm3WqQAAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Li peiyu <579lpy@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708982756; l=1913;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=Zs2gDuZA5ZODfpEp9+C4m2HVDRB1eKQpO4m4StbVvVo=;
 b=b9JYg0PtSqOYll/eubQcIYUX8ad1VIa8WWC+FVhSeWubJPsCXkd3seZvBlQJrINVi59YDU+TH
 GNSRugvd9ZkCrpYMUdntxCVs0A+wphyaI74t43d84WTG8JrCw5pTNFl
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

This series adds power management for the hdc3020 humidity and
temperature sensor as well as control over the reset signal the device
provides.

The hdc3020 carries out measurements automatically, which is not
necessary in low-power modes. Furthermore, if the low-power
configuration turns off the device, proper initialization is required to
account for the setup times and initial status register value.

This device provides an active low reset signal that must be handled if
connected. This signal can be used by the driver to keep the device
under minimal power consumption during low-power modes if the power
supply stays active.

This series uses char-misc-next as basis to include the last additions
to the driver to handle events [1] as well as the fix to include the
entries in the Makefile and Kconfig files [2].

[1] https://lore.kernel.org/linux-iio/20240214085350.19382-1-dima.fedrau@gmail.com/
[2] https://lore.kernel.org/linux-iio/20240121135123.71506-1-jic23@kernel.org/

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- Trigger power off sequence if the power on sequence fails.
- Check return value of hdc3020_power_on() in the probe.
- Remove type casting for void pointer.
- Link to v1: https://lore.kernel.org/r/20240220-hdc3020-pm-v1-0-d8e60dbe79e9@gmail.com

---
Javier Carrasco (3):
      iio: humidity: hdc3020: add power management
      dt-bindings: iio: humidity: hdc3020: add reset-gpios
      iio: humidity: hdc3020: add reset management

 .../bindings/iio/humidity/ti,hdc3020.yaml          |   5 +
 drivers/iio/humidity/hdc3020.c                     | 105 +++++++++++++++++----
 2 files changed, 94 insertions(+), 16 deletions(-)
---
base-commit: d4551c189d6e6a3fcf7f625bd4b273e770fad35a
change-id: 20240217-hdc3020-pm-177983de3cab

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


