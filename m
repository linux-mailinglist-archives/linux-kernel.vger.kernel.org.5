Return-Path: <linux-kernel+bounces-143762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E1B8A3D1E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734D71C20BA2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6524597E;
	Sat, 13 Apr 2024 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPvgb2ff"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8851F94C;
	Sat, 13 Apr 2024 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713021150; cv=none; b=qvfhg0U509749nfCetmI+BCRnD7oMuaTxEr0pCTOlxf2/N5HqRZgOADo2+YhwxllwJQVnaT8om+TYoitV1qHl+2sREpB5GDSGgZpCda2z6atCFeb6b30FnRmgpi2n3WC7ebqZxzWdlQNE6ksqmnVPJ76RsV3VBe4DdYTehJ6o54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713021150; c=relaxed/simple;
	bh=3zj9RDcOuyamPrG3ZkY4JuSskanw31RnVyKucBkU/UU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lPiODjGSGUdnIxG2uCtjRBMRKrmTIKQEzNVcvU/u0+e64eS0v7VJVslQVBYJ099n5W1Qg7x3fFo6cxW+5ydl2yltbiCox0cWhlNIzVYyFUbyWcawjOGBBnwFJpOTZjlJf1FOjvK4lh/5UpX7F2tnevnxYB4Z2AaLXEe+XYheQ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPvgb2ff; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57013379e17so253071a12.0;
        Sat, 13 Apr 2024 08:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713021148; x=1713625948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tg55FqGfkkUgaQcwES0inJs1KvNgpswRsejMIHrF0t0=;
        b=PPvgb2ffh04p1KRNAcI6cqTbRMBklgJxl6fHwemVpcgP7dqlHvu8+hph5CPupnD7a7
         V58YK+AXYE4p01hD+SNNnD4etYzHN6Ag0bG8h7GaN5hQJp+B13NrnRwT94ACN6WY8RwY
         3UtSmFVBXLLe55FVhCdG4xLqaiD/On+UrAOhvm59t5VOfCt7mutq7pqLwd8PVePIUeiv
         TwXFGjAmgOuNuxBdy/42jHk9MJKFRspzYUGUe7A9CWplQfXwdUR5klMyWncxg694Vpge
         eipx/GG3SqMkq9dDam0r2H7VXVsZA+4lfDpl4hr1rkAY4AlpPm9/8hhGl1tPgBLqAIQP
         /itQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713021148; x=1713625948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tg55FqGfkkUgaQcwES0inJs1KvNgpswRsejMIHrF0t0=;
        b=RU7ild59KqGAJF5NjcUhNTbRH/OAetgd8zICQiuojVq7yl8tccneBdi9sEjzI6VR1X
         /AOQgR0Zhub4yz6dLVSbdk2cMwYU8fwZ6zHCEIm/nxxRL0jQFdCgHgLK+8piKz7mv2Be
         kS4paWkJs43pNQLav8B0xP+GnX3iL384rks58wmy/mRKuEv/I8iREDLYpbo4Od3HqeMQ
         UJoaPW+Ymrbxunqz72f63+bysWVEf15TTaAvnVM5HDpmFsq/zUr8CLRKITN+Il8prk8f
         e2/KJ2jW2Nj3byoVGvXdWmAILbLECRyhRDEjBGWLDjH6fGfXs+VmRtfJ1xuI/kKq/B9g
         /IZA==
X-Forwarded-Encrypted: i=1; AJvYcCXuUJvDWa1f9rN3gpDBta2/isoaqmJ7p8xTF9mMF6HGHYnJPmHSaITKOiuz5yfzU5aI0NVFL7EGvvOIsylUz4gvCeduWHibzRjyJaM9qrw6WjrQR6qyhw4pWcPc7tmMXqYSUuoy6lAb4Rlc7wYDcoXdpL4pI9O238L9E9/yFXbK+rNCcw==
X-Gm-Message-State: AOJu0YwhWxkD5fHBXAbADHDE85Rrrqfv1C9rkih3TtmJAxZaCPy4i61V
	ifDlBL5GUFIOx1zP9H9NY64IjUcydkJsHNFphzBm/C8MmcWcO6Cl
X-Google-Smtp-Source: AGHT+IFYklROFCG3uxrutpHYnGUG56+ETxq5tVwESiqqfFmfcZ+nTKlvh24iPGrzXpf1gsRAJELjNg==
X-Received: by 2002:a50:cd5d:0:b0:56e:2abd:d00f with SMTP id d29-20020a50cd5d000000b0056e2abdd00fmr4373898edj.18.1713021147596;
        Sat, 13 Apr 2024 08:12:27 -0700 (PDT)
Received: from spiri.. ([5.14.146.31])
        by smtp.gmail.com with ESMTPSA id w4-20020a056402128400b0056e2b351956sm2749883edv.22.2024.04.13.08.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 08:12:27 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alexandru.tachici@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	marcelo.schmitt@analog.com,
	bigunclemax@gmail.com,
	dlechner@baylibre.com,
	okan.sahin@analog.com,
	fr0st61te@gmail.com,
	alisa.roman@analog.com,
	marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com,
	liambeguin@gmail.com
Subject: [PATCH v5 0/5] iio: adc: ad7192: Add AD7194 support
Date: Sat, 13 Apr 2024 18:11:47 +0300
Message-Id: <20240413151152.165682-1-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear maintainers,

Thank you all for the feedback!

I am submitting the upgraded series of patches for the ad7192 driver.

Please consider applying in order.

Thank you!

v4 -> v5
  - add aincom supply as discussed previously
    https://lore.kernel.org/all/CAMknhBF5mAsN1c-194Qwa5oKmqKzef2khXnqA1cSdKpWHKWp0w@mail.gmail.com/#t
  - ad7194 differential channels are now dynamically configured in the
    devicetree

v3 -> v4
  - drop device properties patch, changes already applied to tree
  - change bindings and driver such that for AD7194 there are 16
    differential channels, by default set to AINx - AINCOM, which can be
    configured in devicetree however the user likes
  - corrected mistake regarding positive and negative channel macros:
    subtract 1 from the number corresponding to AIN input

v2 -> v3
  - add precursor patch to simply functions to only pass
    ad7192_state
  - add patch to replace custom attribute
  - bindings patch: correct use of allOf and some minor changes to
    the ad7194 example
  - add ad7194 patch:
    - use "ad7192 and similar"
    - ad7194 no longer needs attribute group
    - use callback function in chip_info to parse channels
    - move struct ad7192_chip_info
    - change position of parse functions
  - drop clock bindings patch

v1 -> v2
  - new commit with missing documentation for properties
  - add constraint for channels in binding
  - correct pattern for channels
  - correct commit message by adding "()" to functions
  - use in_range
  - use preferred structure in Kconfig

Kind regards,

Alisa-Dariana Roman (5):
  iio: adc: ad7192: Use standard attribute
  dt-bindings: iio: adc: ad7192: Add aincom supply
  iio: adc: ad7192: Add aincom supply
  dt-bindings: iio: adc: ad7192: Add AD7194 support
  iio: adc: ad7192: Add AD7194 support

 .../bindings/iio/adc/adi,ad7192.yaml          |  83 ++++++
 drivers/iio/adc/Kconfig                       |  11 +-
 drivers/iio/adc/ad7192.c                      | 258 ++++++++++++++----
 3 files changed, 299 insertions(+), 53 deletions(-)

-- 
2.34.1


