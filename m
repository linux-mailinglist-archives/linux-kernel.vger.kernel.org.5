Return-Path: <linux-kernel+bounces-117377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B200888AD92
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 253A9B40D92
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1B8839E0;
	Mon, 25 Mar 2024 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMfvY0IB"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0E181AC4;
	Mon, 25 Mar 2024 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380893; cv=none; b=CtpexqmNbmOvjYa57tFiJ7mFihHdyu+kaRWBGv4Flh4M9l0RD2vFv00dtyohWtqNfduZzHPMt91sMf5i27PvIK6KS1ZsXHzlM5Vo1tFIKNxidXkrnj9PVvoLfojPwmssOLm3UavZF4sSAMpQZB8AlrCskIw9iKpBeV76yzp+3qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380893; c=relaxed/simple;
	bh=pToit27TqLaZTZVIWd9WSIUZ1i+05Dk9aFS/Q3bfuoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i/1QDDpIy1d6/yzNrZ45jkj713rVtTogIgZAHtskwhleSRDvF7VviuTC2Afbem6eitDXaQ3x9lLTM+e8GlPIXlC+pmVZLZkWKYSChHryXquhMhSixCOst1+cLrC0ZesCHrHD2cP+CL2XpE37aBCsLH6a74QZM5QR6O8aHNFwXhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMfvY0IB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a466a27d30aso557010666b.1;
        Mon, 25 Mar 2024 08:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711380890; x=1711985690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xtVnBwEs4bYQsVbe2uhOnHxLXkyj8rDngprTSIhtgU=;
        b=eMfvY0IBXWmz8zimMaxR1LOGGQSHYU8vqPQM7xqxq+MGLtxHTzGw095QnoWZBvD/+S
         LXYh18U7Yj2L3GsUpejNhxZiB6LB/hF2lK6MdIRO7nDNZHfqxml+IEEmrEIITYaMwjqO
         dy7uQKuJdCxV0g4QKct2yuqzokOAy7fyYCTSJdJnrMvtv9GR0MFAEDm9vF0YbNc2DoIJ
         NNfMX0XpMVwOXTOKMNP7q3T5+StjbCLiUXQiDkxBBwyGcbOV2vHbyIpAUmbEGIpfLlyP
         yrhnWhpooZOJnxxp3h0fFaoI1Xc2iQeXY+ChbCNFZc1nQwIOhdJPI6B5d97EBjJNyBWm
         2TEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711380890; x=1711985690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xtVnBwEs4bYQsVbe2uhOnHxLXkyj8rDngprTSIhtgU=;
        b=pMW6O05X2yWQrAUGQU4LmK9XDYNBCup2sl21E40wjvG67vH+1YrNAmbOafv/0G4GKt
         Midp36nvmjeQ0v6e/TMLC8AKcdnHGRpdLOF+//HcRveoYxAcNuNcea81AdBbvG1BkBmt
         t3+7AyHS1S2OyC+2ZqjODHBWTLnZ6Ly+Om5upFuGzbCXp5l1ypvkud3kSOkKUKpoPTYG
         rhX0Uq8zSPu7QIQsYMXEYnen0x9d1JBoocKCfv54EgR03sE7rnwA4i5vrKe9Abi2ae+G
         RkehTxw/i52CYJGqKtraX0zVuqRF/CqeB8Poc4SithnK4zVzMf4wXIn5bzChZMyZF+7K
         2IZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL4pd1mZ+YMk5e/YDszFw1HAUsJHBmubdDAlAYrNNHarwX6w4gJ7DVV4QyWIOouyIZu/jTlLAbJ4kJOPOEpMUNfUy/nuByGV/V/Y+0X47sEZ3HpMtCuGRVf4D4YMuyzciQZ1zcwKXhqA==
X-Gm-Message-State: AOJu0YyGu0fY2DeZMK9/+b8W1cOY2rdWsrao1vmnj8Dpdo+GBkZV2jbY
	zdK2wegVmSoqjFeunX87jIb6AN5T2J8LSHougMd29mDpFhGvkRht1J5qdZe+WdE=
X-Google-Smtp-Source: AGHT+IGVUmFgkxgq//pLm6j5DJT/mQLd/o7s+zZL7Jq37avlN98P/S2K7jEw101TfUx3ozVEe5v5kQ==
X-Received: by 2002:a17:906:811:b0:a46:22fc:74d3 with SMTP id e17-20020a170906081100b00a4622fc74d3mr4734839ejd.72.1711380890424;
        Mon, 25 Mar 2024 08:34:50 -0700 (PDT)
Received: from 764c7355c69b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090626cd00b00a45200fe2b5sm3142382ejc.224.2024.03.25.08.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 08:34:50 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v4 4/7] dt-bindings: iio: accel: adxl345: Add spi-3wire
Date: Mon, 25 Mar 2024 15:33:53 +0000
Message-Id: <20240325153356.46112-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240325153356.46112-1-l.rubusch@gmail.com>
References: <20240325153356.46112-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add spi-3wire because the driver optionally supports spi-3wire.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
index 07cacc3f6..280ed479e 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -32,6 +32,8 @@ properties:
 
   spi-cpol: true
 
+  spi-3wire: true
+
   interrupts:
     maxItems: 1
 
-- 
2.25.1


