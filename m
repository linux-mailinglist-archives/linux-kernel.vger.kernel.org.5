Return-Path: <linux-kernel+bounces-8291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8E481B506
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21BA1C24AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DBC6D1D2;
	Thu, 21 Dec 2023 11:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvJajrgg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82031DA3B;
	Thu, 21 Dec 2023 11:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40b5155e154so8234395e9.3;
        Thu, 21 Dec 2023 03:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703158736; x=1703763536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ndaSlkvh45M6cdbia79pW32BAoAnDR6IcsszsFXraNI=;
        b=hvJajrggi2kR57VXmmqdV33vRm3RpiUkW+nVcrN5ppsYdr7udcS2tnErs/ivM1QDvO
         QJE+fyohfsz/8wF4ZNgIEQt+iAiMuMbVOsGVKf9lcelSkX1p8earvcEtUyVzJh2AAE6g
         qYWJ+IXQU89ii6ALTbeSYEIKLVBiYwTNJh8Ib7VUTGOOU9BMkGmhOg/YtHZrTbSj9ZHx
         H0CeOqmKUUpjABUXB+D6f/XnwbtC09YgFpDJlov/Om9g69lvAW2+dxnyWobAEYiqrevQ
         syB6vJeZv7Yet68AHYw+sHH9JgZ4i9IdSaovS7wfIA03OsyY4KY3PMi6jIhj88Sm9r8g
         w25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703158736; x=1703763536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndaSlkvh45M6cdbia79pW32BAoAnDR6IcsszsFXraNI=;
        b=q6X5ydvg6RNFErwFm+Bo60DSoD6xclr6Yya3HT9JU3m1cE1iwU77QdEDhELsrG7FzL
         fXli7MpqarbZbOoQG0SMIV5AURGMY/vNeXo6HEN167/b4t1e7KxYei/OdxvrwvEk3Kgf
         Yw2Kq3XKykDRU9LcS0+P/qQi3gz+1HWCbXo+WWZ0L89gtfLv22y67czjMSUZOaResWal
         nubbOqmTaXzf4gIueiHabR7zqPPjh0ozdrrkFaqNklcZqQt6+HqS8aBSxL0xlWcA/m6V
         JXinm563+xi9oUPrWQ6OWEMpE502k2FR8y7pxngo2rzJeOZeRVFMd3giQmNpogncxsAZ
         E5oQ==
X-Gm-Message-State: AOJu0YyKzDaLX5PhH591Cup1jLBaCO+KoBItl43A2sHDAJK1iAHBIWdQ
	sQOOssMDiDKATVprGxBkRjE=
X-Google-Smtp-Source: AGHT+IHt/ynOdcwYDFyVhJ2boSEvKE7bNxXIZSpeeBuBDR/JHlB8UoKn83SMB+MoSFVewJenNJMDLg==
X-Received: by 2002:a05:600c:4e10:b0:40d:1b4e:fcdc with SMTP id b16-20020a05600c4e1000b0040d1b4efcdcmr638765wmq.24.1703158735538;
        Thu, 21 Dec 2023 03:38:55 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([213.157.161.11])
        by smtp.gmail.com with ESMTPSA id fl25-20020a05600c0b9900b0040b3e26872dsm10940404wmb.8.2023.12.21.03.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 03:38:55 -0800 (PST)
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
Subject: [PATCH 0/3] Add support for LTC6373
Date: Thu, 21 Dec 2023 13:38:37 +0200
Message-ID: <20231221113842.25957-1-mitrutzceclan@gmail.com>
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

Dumitru Ceclan (3):
  dt-bindings: iio: hmc425a: add entry for LTC6373
  iio: amplifiers: hmc425a: move conversion logic
  iio: amplifiers: hmc425a: add support for LTC6373 Instrumentation
    Amplifier

 .../bindings/iio/amplifiers/adi,hmc425a.yaml  |  16 ++
 drivers/iio/amplifiers/hmc425a.c              | 178 +++++++++++++-----
 2 files changed, 149 insertions(+), 45 deletions(-)

-- 
2.42.0


