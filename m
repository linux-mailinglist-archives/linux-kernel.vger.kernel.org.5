Return-Path: <linux-kernel+bounces-22431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C9D829DA9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E43E4B263D1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EE44C3D7;
	Wed, 10 Jan 2024 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEOU32/W"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FFB4CB25;
	Wed, 10 Jan 2024 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so3915102f8f.1;
        Wed, 10 Jan 2024 07:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704901083; x=1705505883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eLo1+tlzXsv0snPTx2ZakE4Ci8K1VSRxrzwdPLiXE0g=;
        b=LEOU32/Wtf15PdAmS8Tydf1GpHfHd/4CAuLvTOUmQXcC8Sn+1d8HDhkoccd2GPfplP
         zhVhXfEM4bYIw+BCWPfqioi4WjoXTeWoiOEIVUNhbtQ5knHPEoLr/jIUruEmIwg6QxCZ
         ey+BIPoxFvfnTIp8Gw7x5BUGycs6WrdocuCjowsPxp6KAxt1J1J9+KjcFDhBn/dxvQ9f
         OftCwic+wgQHGv9mAbuer3NbZXUtWjjNwhiMDC4fyzPF7qFtw8FARb4qv3vnAV26Tb7i
         9xG2ORxx2bsEFw+mSF4PNVcb3AC833e8s4trqOhzEmsAGu9AIOo/fvjlzIMe8XEqUlQG
         FruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704901083; x=1705505883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLo1+tlzXsv0snPTx2ZakE4Ci8K1VSRxrzwdPLiXE0g=;
        b=rP/y61w9YnN9e8v6S5OrjSz/VcH2pm5ST8nU6SbR0L7hFw42zJf6MqnonACDyF7fwg
         /7eVvrqMYMJfn7O/tF/LLKTHG7gv3ueSpALW8Q0laf3p08sHExxCcdVYBWk+EYVgYnKc
         gTx8Ex97H3U8TA4PPcaZhQnqlYtVbuiR//x4con6MmH/X/xO/uUKbG1+vrDRfxSDx/S7
         aHmsAHZWn5NU1AJwDOeEcbdjv8GhuHYGdHbj8LNwIU2CvHZDWcRiYbHRrF59Ga60MpSe
         YWDgHx1gNIK68vmQ1ldZPd0+Ip4duvoGGiYzGB43Y603KvfVjqTIAx+nofsBfuiZp6BY
         dijg==
X-Gm-Message-State: AOJu0YwlRSUZx6ziFrqXRP7/mL+GFObE5JwS3/gRaroeWItz0fautMlo
	2eb7ozOqICUoSfEJn27qsXo=
X-Google-Smtp-Source: AGHT+IGA6xTWFMF+XXIgo7qvOQb7cQBN9pTRwG3FItgV6DUF1ct4ZidqcJEEGrSnyhsnoAbXgw7iOA==
X-Received: by 2002:adf:ef8c:0:b0:336:6e63:486d with SMTP id d12-20020adfef8c000000b003366e63486dmr769461wro.86.1704901082540;
        Wed, 10 Jan 2024 07:38:02 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([86.125.72.218])
        by smtp.gmail.com with ESMTPSA id e30-20020a5d595e000000b0033776a50472sm4179907wri.10.2024.01.10.07.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 07:38:01 -0800 (PST)
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
Subject: [PATCH v2 0/4] Add support for LTC6373
Date: Wed, 10 Jan 2024 17:37:08 +0200
Message-ID: <20240110153757.5754-1-mitrutzceclan@gmail.com>
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

Dumitru Ceclan (4):
  dt-bindings: iio: hmc425a: add conditional GPIO array size constraints
  dt-bindings: iio: hmc425a: add entry for LTC6373
  iio: amplifiers: hmc425a: move conversion logic
  iio: amplifiers: hmc425a: add support for LTC6373 Instrumentation
    Amplifier

 .../bindings/iio/amplifiers/adi,hmc425a.yaml  |  47 +++-
 drivers/iio/amplifiers/hmc425a.c              | 204 ++++++++++++++----
 2 files changed, 203 insertions(+), 48 deletions(-)

-- 
2.42.0


