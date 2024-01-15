Return-Path: <linux-kernel+bounces-26027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDBF82DA17
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6EC1F226EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1485C171C1;
	Mon, 15 Jan 2024 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gkj39+VR"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1EE171A5;
	Mon, 15 Jan 2024 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3367a304091so7644600f8f.3;
        Mon, 15 Jan 2024 05:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705325427; x=1705930227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xXAyTkPgi/LVAuSe9DIKDZ0plA+MwiDw05+7Nb+Yhrs=;
        b=Gkj39+VR16LQRbrxd9n8WaJYGYC/IBbkchMrwOvkyO/uGANwNd7RTnsKA8UKMdwjps
         NvJAt3wezyq7aYf4V5Kx0NM4eXScBU0fAtM1b4Y1U68nv6QAq29KMkpB4eCjorYDVAHw
         KAZFPQbr93jXvLNHCAyxAcv7opa+hV8/lWqVlFOGVLL5+A8Jb0BHyv1LANgh2QsQ/DXk
         uSBInn3F2oB2C/TFiaeEX3ZegqafApucsbZysVKzrHWgAi4A5wrhk0XInDmoxKvc9LwJ
         9g7xM/c9htJVbR7mhTUpZfGk+nU9/A8v9kRedO2W9xIa5Y3a8C/s4LZA8oHPQHY+0J0O
         92RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705325427; x=1705930227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXAyTkPgi/LVAuSe9DIKDZ0plA+MwiDw05+7Nb+Yhrs=;
        b=PzpoGjAjJKRugK18lyufrhVVUPPSvBSmms6QZl7N27zmgD8ailgHUjZ/qSdo3O97c9
         iDFcKqsvlEMduATGAQbteIb8/3OhaNHgFlzw0qB3fQRIqVgNzibWbqTRSNya8JtGOozv
         XVBKeLbFw0Dgz8SKsN++BDXxjABEkl/ry8U29HWQz2STyiV9680Aq1ivsF/fODraIWjp
         qK/1gu8rymEaJtO7PLt0JdpV7dUwZw4PVF7XVVgEvrLXY9n4n98ohHDch8WF6T3hZ6Tw
         4HrtDbkJNHPqCrarUAWfYpZsoXYpXi4A6ngWxztznKd1769+OTLasvgZrWZsWK224Yu1
         rVfg==
X-Gm-Message-State: AOJu0Yxhc6hBe5XR1VeKeNZ0CrUxVUTMtGLcwFNmu1r3E8i8bQ+h6wSs
	1zSEwdgHNpGu4ZPilxFXRjM=
X-Google-Smtp-Source: AGHT+IF9VcIyikkkiy5A7Z1NhhlPnCldtAtbeM5PatT8545LTWaGQ9Ih3D8V9+gsX+fSUeCCu0mZJg==
X-Received: by 2002:a5d:6b8e:0:b0:337:6529:431f with SMTP id n14-20020a5d6b8e000000b003376529431fmr2105840wrx.3.1705325426688;
        Mon, 15 Jan 2024 05:30:26 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id i6-20020adfb646000000b003378d89737fsm11566669wre.46.2024.01.15.05.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 05:30:26 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: 
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH v3 0/5] Add support for LTC6373
Date: Mon, 15 Jan 2024 15:30:13 +0200
Message-ID: <20240115133023.3465-1-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the LTC6373 Instrumentation Amplifier within
the existing HMC425A driver.

The LTC6373 is a silicon, 3-bit Fully-Differential digital instrumentation
amplifier that supports the following programmable gains (Vout/Vin):
 G = 0.25, 0.5, 1, 2, 4, 8, 16 + Shutdown.
The programmable interface consists of 3 digitally controled inputs.

V2->V3
 - Use return instead of break in *_gain_dB_to_code()
 - Add new line before return in *_code_to_gain_dB()
 - Match parameter alignment for added _powerdown functions
 - Add precursor patch for using pointers in the match table
 - Add chip_info attributes: has_powerdown and powerdown_val
 - Change probe logic to use has_powerdown for default powerdown state
 - Added 'Fixes' tag to commit message of 'add conditional GPIO array...' 
V1->V2
 Driver:
 - Fix chip info table indent
 - Remove enable attribute
 - Add ext_info powerdown attribute
 - Enable by default powerdown attribute
 - Set default gain after disabling powerdown to min value
 Binding:
 - Fix conditional checking of GPIO array size for LTC6373
 - Add precursor commit for correctly checking gpio size depending upon compatible

Dumitru Ceclan (5):
  dt-bindings: iio: hmc425a: add conditional GPIO array size constraints
  dt-bindings: iio: hmc425a: add entry for LTC6373
  iio: amplifiers: hmc425a: move conversion logic
  iio: amplifiers: hmc425a: use pointers in match table
  iio: amplifiers: hmc425a: add support for LTC6373 Instrumentation
    Amplifier

 .../bindings/iio/amplifiers/adi,hmc425a.yaml  |  47 +++-
 drivers/iio/amplifiers/hmc425a.c              | 253 +++++++++++++-----
 2 files changed, 236 insertions(+), 64 deletions(-)

-- 
2.42.0


