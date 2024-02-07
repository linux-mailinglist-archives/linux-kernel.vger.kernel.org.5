Return-Path: <linux-kernel+bounces-56083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD0384C5BD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FDE286F39
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D3F1F958;
	Wed,  7 Feb 2024 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwSixjM+"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0609B1F944;
	Wed,  7 Feb 2024 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707292087; cv=none; b=ETEyy3J2RuqHc5p6enyZm/5/X15nN3IOIZdg7t4KIku1Ckmr1Tww79inc41tCGx9X4Kzo7vWn87HwLJmPT5nQuywZgxHkubKHzyDlMecgWwpmQx9Osli1EBiKeGcfGss3KNEgQIvLOfV3+UIUhlIVIZFvnSm6acHc1x1fnlO29I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707292087; c=relaxed/simple;
	bh=MG1uf8bYLbQHWO/CpHsHnq0NKvoI1wjQGurUoWjydK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EVGGV0tZELXBGfgzYP6pLcKGOuay8raLLkFYM3YONqHJ2tliNqQ0P6lAsUH8yfcFYGnuMRhscMGDc4+PiiPzIi1nu76jIe4a0E4T2LuQtpEMSRvChTVXaXhUkjGLlnfiRfDcCYeWa2+AkLk+WpblCTFgmeuz3M8GR5Nt/+m0G68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwSixjM+; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cf3a095ba6so2866641fa.2;
        Tue, 06 Feb 2024 23:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707292084; x=1707896884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E1qXyLTJ+bcxE7eUtS47rjoOv4Eby6s9nWs9bn0qlJw=;
        b=KwSixjM+Nl7iP0QIbkcd5U4QLgzljU/SH+aros8vDPCRk5KTx4DdwSZgsa0iDQFxMA
         7TsSRjZCHrGE40Ook30dajPnxTnLv9xzUVgwKUdsk5Pqj/5NCN8wmfu4LoS5gghKrHdh
         +Ib7I0J0BsKxCZjMT47Q0+eqx5xU4hyUJDHNijsnFwLzyNDvVt9008bT/1id4wbmxjjq
         agsxIufbRSf4UxIJ8hfayxe0Ac6/MDN/oaX+m1qm7V2D54vNnS14e9hvSROXvJp4O73l
         pK7CAlI6v3Mw03zYprM8RD/qh1PB2JYcVI6KxzF+rbf5tLUbsfTaoWIXbQdOgGN33mfZ
         3USA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707292084; x=1707896884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E1qXyLTJ+bcxE7eUtS47rjoOv4Eby6s9nWs9bn0qlJw=;
        b=nYNlkFZTdkToVGhMFlcKhONkT2ic5YONpGQVD3rfQUjAGCdg+oSXSU6Hns1RP9DA1t
         765rDa2pbdbDnxvU2JlOuOLz3C02CUI4GgKQxNUPRD404Akv7yeMBb76TsxjMiARpSdU
         4sA3Ud9UzB8XVb+rjOUhxKNssJkuwcNKVlIRnsEiQSJ8uNJ/sNMWuL138lkxTbbAtXuN
         oN7luSu5Hf7isb6Oyy8R4wdiT96ErpCEnR4gy4D3YAoF5CmYw1I/rsCJI25nkoZsEfr+
         36khSuNcSImknUTUA6coCfwhxA55dc9Qzl+bgRqvbc9+Y17sUrmgNo6DJMhmstGg/VAt
         4vlw==
X-Forwarded-Encrypted: i=1; AJvYcCWGSNme//na/FYQfIvNpj2JRkPHDT4re8WwwHALhCLkICUrbxpqHXdqZ1S2FYxHZDBo5ZlikvYXG+yMR4ll5w3lv+UcHAT2Bfhmb0rzi07iYw51ruoD1+65iChnl/LI6jSq3k/gUXv6
X-Gm-Message-State: AOJu0YwaR1IUJ9jFde4GJJwY8/VMm0TdW8QzjJGiWnaRq6j9YGg9TiO5
	YTH5WK8rpikW+ZBmfwYw76UmPAph8qS094ybE7jVI4VPNB+Us8Jw
X-Google-Smtp-Source: AGHT+IFkPYJpF7raSG7O9jEXzX/hDIO4QIZu9sfH8+tTF8d+piC/53idO1L5hLKEAXay7R2Ym3PA9w==
X-Received: by 2002:a2e:b5c6:0:b0:2d0:af09:e3dd with SMTP id g6-20020a2eb5c6000000b002d0af09e3ddmr3118056ljn.52.1707292083786;
        Tue, 06 Feb 2024 23:48:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVThcWmbnI4yPjFrdMEuOEOFMevhwgc8H8bd/IEnZg+VEIOob14gjKpXe8ALxWh3UcUShE7LJpwP+pd2eR3WbeHo72g9kzMWHk3DX2oe/bu3ev6kdslYC9WKoGe/8F5wWmJF1ToowNfhOluLgB1XaiBucsniEqsIZRvBPEDqD0urQrOUbRBCK8l5F46k1wjLSxf/Ht/Cy7QBxtFci6URMnHfnaZXPBg7ufvrN07oNrhejItWal65lDd9V1Ymf43YL5vSrpwiwot/Xqpcz5uljgM
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id f3-20020a05640214c300b00560556fe9b7sm378558edx.78.2024.02.06.23.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 23:48:03 -0800 (PST)
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
Subject: [PATCH v3 0/3] iio: humidity: hdc3020: add threshold events support
Date: Wed,  7 Feb 2024 08:47:50 +0100
Message-Id: <20240207074758.4138724-1-dima.fedrau@gmail.com>
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

Dimitri Fedrau (3):
  iio: humidity: hdc3020: drop u8 register pairs
  dt-bindings: iio: humidity: hdc3020: add interrupt bindings in example
  iio: humidity: hdc3020: add threshold events support

 .../bindings/iio/humidity/ti,hdc3020.yaml     |   2 +
 drivers/iio/humidity/hdc3020.c                | 443 ++++++++++++------
 2 files changed, 309 insertions(+), 136 deletions(-)

-- 
2.39.2


