Return-Path: <linux-kernel+bounces-64892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850D385445F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405A628DB5C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EF079DE;
	Wed, 14 Feb 2024 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWiq7H9T"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3163BA33;
	Wed, 14 Feb 2024 08:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900838; cv=none; b=iyZYwQ2fPEjWAutGwXeM/y4q/4MeY31D/96CfflFlWI17MSAfHyJCdY+foTgGa/ybM9OiA/in21q8gJePPf6DbUEalgk0Qt5v4oqt5pBxrPB9cL2DjWdXaLu1RI6UH1hqm26nwLdMZNvInTkBQ8a052/m/xgB8NdVgBSwPOd7oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900838; c=relaxed/simple;
	bh=c7BE6X3Du3/ZeB3IwADX1S+nRspuCDaCx0b9Xn3C6RA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=axbTuJn4ifhb2siG8ypbpFxKOSL599w6djLaG7UdqYkwfhgFfCT4fMK2TISvqpnWYA9+xHJEFexq7fpqa+PCUNBr0UDapdvZXf7KpJgy6k1M3lfsp13UAROqFtFrRdSqtouFqy4LLGA/4IbSEAE0chWUrdeEMUUBO8W9P2zHcNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWiq7H9T; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5638aa9a5c2so148149a12.3;
        Wed, 14 Feb 2024 00:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707900835; x=1708505635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cRBk0De7Q6Ippic2gln+CvUaN+5hNRw48q9Kp9V/1ew=;
        b=LWiq7H9TZEYFJZbnQ/M2PGwI4AODoMt+RHqdgZsjo3j7Em2ARL7p9nykG/jCKZ3RZl
         HCWpf49XaMtwpLJ4LI+7Y8rqjacuV7RuI9q9v1WZrmz9MgrRzLbFL/YShj0GdbHpMQ6B
         p8RGP0JDezGZnR1Mh/6caYvvJ0/iL/ESX2pKEI2vtvrwRVv/usplwAbkBDPLS3D+F4T/
         tl75sJOQnaj1MZxGVQxme4AnunGtqGCeSQi5ErM5Kzbh6bjnDUVwzJHGCrlXcx9V1PZa
         DSiwcGf1R2UUuLS4b6pRFCXd+BNX2NCMH0zf9ElaeDpJOcqxpxHSzqCym4aOEPuIE9fa
         jx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707900835; x=1708505635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRBk0De7Q6Ippic2gln+CvUaN+5hNRw48q9Kp9V/1ew=;
        b=TgnT29cTIFtNiFuz6jRUeNxRZFdrkyIvwCfuAVoB5Gf/VUqJmwTQmp74Jq42nj+s+Q
         L4aVnh+JbIMqwyGqVSE9ucLz4hQZv78DlFOLgjNIoengFlMSSBO9kMC4cvE4dWBY8dVf
         SBExgLJQeYdjwkBEI+rc29XENIMHwlONhiVoO8s+6Gut7axSI/zoNX5Ubj47vFDY7BY1
         BrpC0kIXnaaMpV3IigdE9Sm4z6XonGQZg/c/wj4nzpwILrwhl/aEtxCMJ4Vws20HJ1Ln
         MdLonqn1lRpeAKve85X1f3z2k0WqQFUuPocF0z9A9kGezCKx/V9XFYDEC2xOTGSlz0Fz
         /Omw==
X-Forwarded-Encrypted: i=1; AJvYcCVMp0bl+dPzEKY1/9J/DIKkeA6Ws+cl+jQ8UIiLZsGg5JK9yFmsOIxkuj0xb9q+srG8k+r9gjQ8lpykvNAkaLVHUAFA6th8Yfo0OU9/FtqjWS+ItmRhRnifoKrto3wFDsgsW9bz1pJb
X-Gm-Message-State: AOJu0Yx3sTkNsH2wlc4BNn6vPKjE7UXCOSjxTV9PmO/IlkoxN+hgtU03
	snVvIm+jBEWumq8LmSOyW+o1ciYcIpjS65xC+2rxo99huYxxwhtpqsgxkR4p
X-Google-Smtp-Source: AGHT+IE9pP9aTUKBXUr8pgfGB4sc5gKO7gfVy7kqBTd3A1J7njr9wWYmPqUS1sD5bB+5HEpeNoYQDw==
X-Received: by 2002:a17:906:4898:b0:a3d:5b47:b0e6 with SMTP id v24-20020a170906489800b00a3d5b47b0e6mr327672ejq.54.1707900834879;
        Wed, 14 Feb 2024 00:53:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXlfB6ozl/fJ6Qwx8frtA6TlGw/eAlYmpV15C0Pta2t6D8P5iIBuqSfzYeyW0BGhi6BLVNa87eDxj9bxXk9bHUQTsEdhjkyaGz0bQ9emYJXOBO7cJ4tHRI2f4DIbjhUEPWYuBLZPRSUSBe8w+AuM7IAfexFX28QDK3XIuHBbBf7WmjFR1kr7LHlkrrau248z+6FOsmgIl0HZu1nC5YHbbNEje0/Wr3SPX/uaTXeXGPSsSjxQXIz6cqWgOR6iz8p3WR/lBM+xVfoQeN+A5iMIfLd
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id tj3-20020a170907c24300b00a3cf5450b28sm1617264ejc.189.2024.02.14.00.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 00:53:54 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Li peiyu <579lpy@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] iio: humidity: hdc3020: add threshold events support
Date: Wed, 14 Feb 2024 09:53:42 +0100
Message-Id: <20240214085350.19382-1-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on Fix:
a69eeaad093d "iio: humidity: hdc3020: fix temperature offset" in branch
fixes-togreg

Changes in V2:
  - Fix alphabetical order of includes(Christophe)
  - Fix typo: change varibale name "HDC3020_R_R_RH_THRESH_LOW_CLR" to
    HDC3020_R_T_RH_THRESH_LOW_CLR to match variable name pattern(Christophe)
  - Add constants HDC3020_MIN_TEMP and HDC3020_MAX_TEMP for min/max threshold
    inputs (Christophe)
  - Change HDC3020_MIN_TEMP to -40, as stated in the datasheet(Javier)

Changes in V3:
  - drop u8 register pairs and switch to 16bit defines(Jonathan)
  - create helper functions to avoid code duplication(Jonathan)
  - Add interrupt bindings in example
  - use the decimal part for setting thresholds(Javier)
  - use return in switch cases hdc3020_read_thresh(Jonathan)
  - fix interrupt handler:(Jonathan)
    - return IRQ_HANDLED when we get a read back failure
    - take the timestamp into a local variable
  - fix multiline comments(Jonathan)
  - use fixed value "hdc3020" instead of dev_id in probe
  - clear interrupt after registering the interrupt handler
  - remove interrupt polarity

Changes in V4:
  - fix commit message of patch "iio: humidity: hdc3020: switch to 16bit
    register defines". (Jonathan)
  - add missing include in bindings example. (Javier, Rob)
  - added copyright information

Dimitri Fedrau (3):
  iio: humidity: hdc3020: switch to 16bit register defines
  dt-bindings: iio: humidity: hdc3020: add interrupt bindings in example
  iio: humidity: hdc3020: add threshold events support

 .../bindings/iio/humidity/ti,hdc3020.yaml     |   3 +
 drivers/iio/humidity/hdc3020.c                | 445 ++++++++++++------
 2 files changed, 312 insertions(+), 136 deletions(-)

-- 
2.39.2


