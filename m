Return-Path: <linux-kernel+bounces-122075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 191C988F18D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD761C2821F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29810154425;
	Wed, 27 Mar 2024 22:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ/3BWWP"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE68153BF7;
	Wed, 27 Mar 2024 22:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711577016; cv=none; b=bvZx8uHSWnkq4nnm55cbTaDJq9fKlQ6vkA1G8uqSxBV/kaN58ViOf9V1vX0d93AeWFnZhFb+JdaCOgwyeI2fiZqBo7V68vM6SF2qzD7Vizs/bQepSsRvpgN1OD0w55Bpd8KedowNyPzJWCZTDZVdHGpQnl8U0FOw8HfdCvgDogk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711577016; c=relaxed/simple;
	bh=OdF1MGZMNlv3XNfDd+dK925bO7Jcx2+rplfpJ+pgwtc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y6zapVgDvO6z0F4qTSb0dQXe0OUTp43qoASUXAZY1pmIcRclkCJqWZmnX75dHilpPno8Slvc8bZF3ieVIh5aLCCoKJaA7XQ/ejxKGYReo8DVRTjISpJmzgNBxMDe8kE4m/Eef1Zp3pjfOgZjeS4WB6bm3TsEpCS+547lKluscRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJ/3BWWP; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56c1922096cso386601a12.0;
        Wed, 27 Mar 2024 15:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711577013; x=1712181813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTkRBQi6KC4mObgrDnv5cmdmaNePeAri5R/Sg4/Hu/M=;
        b=DJ/3BWWPRijuKHtLBUW/TyiwMVuhWq7oyJu1qiPM4TICkN9iY7UpG39HKiHwOcfpZa
         CIHSSIU+l9iIVV+MeIPuPNQvh82+aEw1z3/8doRnDGke69AAinMX0Epa51VwiGKBMr9Q
         eHoosezX13hTdzPJ07dBTbNhT4kExzRiBd7f6/lN/OtO2wJFBy479GkTTBKkdXT3X+SF
         zo+Fc3/yH3iTF6PHNRbzLK/VMEn0V/iDBEgqoQoJRwSD7no3deCy0BqLBkGk3AfQPFqo
         fZyao3E1lPoJoMGmOrcZ3YyjxCXnMNfPlLBW/+3uwaMzDX/Acb4v6OmvK5jE8mPa0WXR
         LI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711577013; x=1712181813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTkRBQi6KC4mObgrDnv5cmdmaNePeAri5R/Sg4/Hu/M=;
        b=b2ixysL6rUap2hHOGlYfisg4hCJuLVEFhKmQV4Jz+jSrvDOfC8kM4aTPkyqupNGEmM
         oAhmDX5kFAPGZvTbPgNw2tg0jiBC4cxlK6QL7zzPz4UhocsxhsivZENahsCmt77lnxqU
         VwVLvZCicYKA9xck5MxauB63eEC4asqsu9gJMXnGAxeo7W0SKAJEQW8ZG26JDOnjeHG0
         tlf4j4pC47dHTqIWSwktM4LjCvdJRRbcuE6pPWcAcKjuRt/XQFmD8z1kxJFmUfbgteP7
         6NtPiK/MhRTiWxVf9d7BvH6xgO2bU6NeYBcQuFMcVo6nJKdbfi104MQ/joqwMgBcwP9Y
         +wKg==
X-Forwarded-Encrypted: i=1; AJvYcCWdPeBn0hiZoq4yv0ML7QvrDh1cntbrzu7gQm+VhNxdP0wjsrku2AXcirZ6R94YO1Q5J7qF3958jK/wlEaqYJWhEyrTZNxH4SAIV6B6cduHKIjNIuFLRr+Dd9uW50lv765mWLF5PgUGoA==
X-Gm-Message-State: AOJu0Yz1Ic1l0XxfXIJPpflWrcbhUmENnKmGT+tDiSI5m9wG2rlw/Z1F
	GN7BP6fphigkXxcTj6cQkfYb+AGYsmVqPHiQddRrpns+aFdYK262
X-Google-Smtp-Source: AGHT+IF687NANk3Y+bTB/64XhWyRfSBRATI+WjlDWL3zY8D+ssAq5/01zkBJ3eirlnMa0X6PPlKVyA==
X-Received: by 2002:a50:9f2c:0:b0:566:18ba:6b80 with SMTP id b41-20020a509f2c000000b0056618ba6b80mr779675edf.31.1711577013041;
        Wed, 27 Mar 2024 15:03:33 -0700 (PDT)
Received: from 51a0132e405f.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id f25-20020a056402161900b0056bc0c44f02sm59151edv.96.2024.03.27.15.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 15:03:32 -0700 (PDT)
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
Subject: [PATCH v5 4/7] dt-bindings: iio: accel: adxl345: Add spi-3wire
Date: Wed, 27 Mar 2024 22:03:17 +0000
Message-Id: <20240327220320.15509-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240327220320.15509-1-l.rubusch@gmail.com>
References: <20240327220320.15509-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add spi-3wire because the device allows to be configured for spi 3-wire
communication.

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


