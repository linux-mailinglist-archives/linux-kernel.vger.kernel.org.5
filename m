Return-Path: <linux-kernel+bounces-127010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512B18945B6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C13F2824B0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B324D535D9;
	Mon,  1 Apr 2024 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8so7tOF"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F4055C0A;
	Mon,  1 Apr 2024 19:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000963; cv=none; b=Y8B0Nz25Qe9AkhXtuz6psIJbUB6Rc+jvwBVvCIo3HrEDaR0wyyA3av5M+PF0Q1StDmLbyp4C2L1O2Emq735PVThO13oWcn3cZCEWo7SmxfrH2p/h71f4PjbfJXvCwcG9fbHxUia/g/edq5GbKSiyvZldKnzIYN+xpqU51ERBerQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000963; c=relaxed/simple;
	bh=V55YgCvLSpqkfe7ySR+HVIoEjCLAZ+Tf3byG4H1tlRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KK2F43fRUXX7XWQ6uJ5PrtfMr6+eJLhOqOfzEv8xHn0hMf9bLz9nZ+liDJotsW8NQ75UkKrmVYKWRcT5YovmaD/WERgFzXiXHHcMclQSURnj2z3PXbM6odpz3/lxM5ACVpRTCZ7Yt2pUoWRIhOM0ZOizFEsEI4H0W9cqeHBclZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8so7tOF; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513d23be0b6so4771817e87.0;
        Mon, 01 Apr 2024 12:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712000959; x=1712605759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hfn3S64P658pp7FgLTURlhXPNN360y6ZzooV24q6Qx4=;
        b=O8so7tOF/YhXn//WIxDyLqEglOdeXlN3Zf19cy5R7YM6Msjoo6PMallCdj52rS3efu
         lD0z3oud94K+jOuGuFgCFEJs10qVS4V3XMID8woGakXhsRW/Jq4pXL4eVDi/AfF94plk
         7z47tDYbN9f4/CCrp4eN7m73MR79MPR1rKOhCTXDwKRqh2Cj7yJKzZS6IUOCkIPyyWo1
         pnPyCjCgDtyrwHX7n/RPrZzI/hIbzc4dglP2FJuw39dbcsFRN75PZZsG6MN7WAwRhplN
         MBaeEm2IU5Wzli11EfEzeuvILLeP56Wll4dcdI+ROnZyMGGhv07YXgUcPcRwGNJF49fd
         01bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712000959; x=1712605759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hfn3S64P658pp7FgLTURlhXPNN360y6ZzooV24q6Qx4=;
        b=Zlvnq8gCeo+NRnNtYLVSMnZjpxKxys9Oy5jXWyB+FITjJF7u1ycaqcOSDyoWFgez7l
         ce4wc8krwsIFmwOsQJfmHzFlF6EuXrghh7nKJ9cBT0lSv6BP3jPGr6w9oPunvj+c5BJW
         QxKAjtwMEFAqeWWhlQKwEL7Kk0eDP4jGDF9wc8EyGd7K1Nfve0gJ9phxGqUujieAyYDL
         r0hT1/t1yHQOBGKPig0kEERbFcM4pVPDqtXjFhu4Kem+JOYKTVl9DOzPEjUyydcFiyiW
         fjqBRjNX2UrEfrnV6gwC4iSItPLj1blwtM+8htjvCj3rFelvyn2AQKV4FscVQkJYf6rY
         3mRA==
X-Forwarded-Encrypted: i=1; AJvYcCVnarc7JvGZDTneM9a/ugXB2hTkzvJY4ofBPRZey1AXUwPONKOCGfRwypCNIoazh/k3PFML3epvc5b4ZS26zOGyW0w/dlEvlwnEZKZQO4vepeCUtRBmnihW8vkWWTCr5gBmdqhP/+2FkA==
X-Gm-Message-State: AOJu0YwZUlZT/MR6PGbwYo7Kmjgjc8eWcj3KMkzdXuiUo7pfUiTOepNo
	hOl3uNYZon5GlavPhM4NMK1adUnwtnSOgKcj/4lifevzHbuz6t8oFL0vkv6NSXE=
X-Google-Smtp-Source: AGHT+IFtijRXGN094bF1bWf9vIA2wpxxin9Ex1YOy4Y4KcIcvK0hO1+wav25QFbOjFC7ckEjXELvTw==
X-Received: by 2002:a05:6512:3e12:b0:515:d19b:babc with SMTP id i18-20020a0565123e1200b00515d19bbabcmr10107767lfv.68.1712000959442;
        Mon, 01 Apr 2024 12:49:19 -0700 (PDT)
Received: from 13a4f82a8f12.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id dn21-20020a17090794d500b00a4588098c5esm5540575ejc.132.2024.04.01.12.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 12:49:19 -0700 (PDT)
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
	l.rubusch@gmail.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 4/8] dt-bindings: iio: accel: adxl345: Add spi-3wire
Date: Mon,  1 Apr 2024 19:49:02 +0000
Message-Id: <20240401194906.56810-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240401194906.56810-1-l.rubusch@gmail.com>
References: <20240401194906.56810-1-l.rubusch@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


