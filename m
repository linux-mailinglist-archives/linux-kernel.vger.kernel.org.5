Return-Path: <linux-kernel+bounces-26060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EB482DAAB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463041F21B4B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D3F17BA4;
	Mon, 15 Jan 2024 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jv/XJUbq"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0D917748;
	Mon, 15 Jan 2024 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e76109cdeso12298365e9.0;
        Mon, 15 Jan 2024 05:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705326862; x=1705931662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yiHT1cqvrc0trw3bxSP5/rwExxYg33Rrd3Fl5ENDp88=;
        b=jv/XJUbqGWgMk7xVbxtlA9Q2BzWZs+9svvl7/ML0bi4wHGT/KAR0DyOcsVdyspbiA1
         OrdhqzrUC30D9qKWLqxpigSjTeb8yJda759A5EvhTIcltA8Jxgz7ann5FEQP/UWsr79/
         IZT7/W2gaxXfcl0+5CGCfqDe5crd6eOYzcfkvYmZpjbhzfY50it/g+xMx9FpNm/HHHtD
         P+Iyqxi2Hg/OBSnGm91D/ZbMN81iRK7db7KluEqsjP8QbziKYsrvinEzcA8TVehYqhK6
         P2aKZpnoZOCAl7NZHCOa+gpYXPnS5twgSpWzf/ykagM9pAj5HCQ2j435BuFwXOnKit9R
         MV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705326862; x=1705931662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yiHT1cqvrc0trw3bxSP5/rwExxYg33Rrd3Fl5ENDp88=;
        b=g67UoXjcoOgrbypInRz57QkIHRdFKRKrOuGd6/YM6T6coCgj+QNkR5N1s4ObtpWQb2
         TT2+MiQe0Uh64ZcR3+i5ZtycrOXQeGE27lFOUXoG5MWg3QDkNTy3CVX7atkVO9cj753J
         ScEsDMEjhW1DZEsCZfUWZ9Vbn4JOA/RF5EDGM4ZeEx5RcMjjNWyJyETmJHI3nLq/KvOd
         Y4CoRBvoNsrbsYMFkGKPWca29gs3P6YxiDPpkaiREkOzBkqIw7qMpT06FCd23V/nAD7e
         SJTc5YKzWIxygZp1EvL7MuVPWHvoYRc9u6HWuOuRN84hdrD43igqnHbDi6IFowanMCsW
         7DAQ==
X-Gm-Message-State: AOJu0YypbyjKmLPaRyv+mZObXOPGqIQ3g48YX97vorExbfB2+ycMoTdA
	STuAvnEzzaAedOu66IK5fFE=
X-Google-Smtp-Source: AGHT+IFdCzleycxmTWk9VzFQCjTv4P4gSvEEiHtuXuJg62O291JhiccUWky/aKK9jJXabhiE/lFytA==
X-Received: by 2002:a05:600c:4fcd:b0:40e:3bbe:265d with SMTP id o13-20020a05600c4fcd00b0040e3bbe265dmr3169515wmq.118.1705326861566;
        Mon, 15 Jan 2024 05:54:21 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c458a00b0040e6efeac9esm7979651wmo.48.2024.01.15.05.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 05:54:21 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: 
Cc: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	andy@kernel.org,
	linux-gpio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	ChiaEn Wu <chiaen_wu@richtek.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	=?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Haibo Chen <haibo.chen@nxp.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH 0/2] Add support for additional AD717X models
Date: Mon, 15 Jan 2024 15:53:03 +0200
Message-ID: <20240115135416.10595-1-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the Analog Devices AD7172-2, AD7175-8,
 AD7177-2 ADCs within the AD7173 driver.

 Datasheets:
 https://www.analog.com/media/en/technical-documentation/data-sheets/AD7172-4.pdf
 https://www.analog.com/media/en/technical-documentation/data-sheets/AD7175-8.pdf
 https://www.analog.com/media/en/technical-documentation/data-sheets/AD7177-2.pdf

Dumitru Ceclan (2):
  dt-bindings: adc: ad7173: add support for additional models
  iio: adc: ad7173: add support for additional models

 .../bindings/iio/adc/adi,ad7173.yaml          | 50 +++++++++++-
 drivers/iio/adc/ad7173.c                      | 76 +++++++++++++++++--
 2 files changed, 115 insertions(+), 11 deletions(-)

-- 
2.42.0


