Return-Path: <linux-kernel+bounces-154718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C76AC8AE01C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6868D1F218DB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6220664CE9;
	Tue, 23 Apr 2024 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaucwfBB"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1021655E48;
	Tue, 23 Apr 2024 08:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861765; cv=none; b=Ru5OnmY2jQB/IJ0B3cDRAjrQLv2mmMqQZQAlfNk3sQRxHyLXsmA5eRIwzlDeVqPC9fTgUGQyaCl4rXkwXKC/FdHDfBJxTutVVJBZWgYHtFswQ6cZSlC1Ve7u+apNKEG2H91yUptdEkvJdU54I4d4SZKn3CXD6TxJozcQ0Eosz/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861765; c=relaxed/simple;
	bh=kWQlPAJNcD1y4ZVlQb05o47efzckJi7SO+NKuvm/BRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aFohUdiUEVEGyk091tDQRluASHXc6NlIPufSRBfB9N6s+ywJDxapYm2f1LdznPpDgkZ98K40T23gRXUVYtqQMXglhth2RSkFjlIRGiRyLpm+mjVSfD6ZO40U3xJX/gweDhRJYVUTD+259788HKZ6tRSljDUsIPpjb9zWeVCj3dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaucwfBB; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-346359c8785so4456602f8f.0;
        Tue, 23 Apr 2024 01:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713861762; x=1714466562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yh6tRQE9lZtbElirucPOKJE6dihjXQGvGMliXELOkAk=;
        b=XaucwfBBQk4T+SxvUK9CkxouElIkc4eUC46Fu2OlwMJrHO63Hv7VvgTj4h6MfIkllX
         JgXqkRpzv+8w7p+J3GLDwLchrmiiW32uU7M7X8eOJmp/ctqnA0bstY5amV6ssZyLhZ02
         swkv/2lb5BJGB4fKogziuOovMUrpU9uadsjOOuCIhzmmZlk3e+EDP55KWXkejq5rGZBv
         mkSeryg/LTc0mMdqp1uXZJf8lEMRtKZliX1YvDyiysWBzczvUWGcIWnYGWz1RkweEqy8
         mlSBNY3b5AJKHg5JFNkGR7GubP6r153bOOb99T6Iqrqk2Elw3rS2oQjtA0+fv/2219mh
         vlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713861762; x=1714466562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yh6tRQE9lZtbElirucPOKJE6dihjXQGvGMliXELOkAk=;
        b=vDw09JTI2VMmDnds1de/mFGyHyiEsSL3oFPO4wwLV+bIZO4WH9NiTo6fL8M2kFZVMn
         z1MEdBfkZD9wYE56hMZ8EB15BAMuaVR900/DAmCXVpV4+rs/q4SiSXfXhiPiWjLFsvPe
         qYFlNrc3h/1v1SGTUi06w5HkjySA5V8MwuBniSVAlvuwalhZEm3W89HHIijI+PL6eqZE
         RtuKeb57CG0sGYRcseMLFjyYHUzaCeCDfD697qoQr11mThbAvUD6qzSniJ3gMKfd756Y
         faWTgjtEfX+Z+WSnzKHAh7LsbWdaNbmgHY/nscl4ihgXNUjg56Kpn2eOKZ7q9jLlY7to
         tbVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEfB/HR5DETIk/2l2HxDU40U5pxaJ4GetSV3tS8mBLDRhVyJ7VsdNQuv79XXpiPf5mf/B9TujKfMfz0IJnfhdw3ho9c0mUAJfouUnHCRzu7M89T587C/M/zP8ysRMnQhnPQ5roUDaC3jSoxOB0eiHbQjc7KeIkgpVLKwznKrnzCw==
X-Gm-Message-State: AOJu0Yxf0BKHHZErcphkzzZBR/2+B4NGNoiJe+hXPV97afvGPzjmkfkD
	p5EoGPDS613w2qX0K8BGElGRiDHBWGVWOfrswumjJUOZJVNkkFZ9WSr5X7o/
X-Google-Smtp-Source: AGHT+IEYHLpIBj1SJpP4iXr8CMZUjLSlJbnWRW0HwfIgV+VO2YHCo0W4bRaKaZImbhqblUz7bFLjgg==
X-Received: by 2002:adf:e3cb:0:b0:343:772d:9349 with SMTP id k11-20020adfe3cb000000b00343772d9349mr8127935wrm.50.1713861761811;
        Tue, 23 Apr 2024 01:42:41 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:320d:e800:cce2:61fe:1efc:ce48])
        by smtp.gmail.com with ESMTPSA id a16-20020adffb90000000b0034af18ef68csm5989939wrr.5.2024.04.23.01.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 01:42:41 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
X-Google-Original-From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	corbet@lwn.net,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH 3/5] dt-bindings: iio: imu: Add docs for ADIS16545/47
Date: Tue, 23 Apr 2024 11:42:08 +0300
Message-Id: <20240423084210.191987-4-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423084210.191987-1-ramona.gradinariu@analog.com>
References: <20240423084210.191987-1-ramona.gradinariu@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update ADIS16480 existing documentation with documentation for
ADIS16545/47 devices.

Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
---
 .../devicetree/bindings/iio/imu/adi,adis16480.yaml          | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
index 56e0dc20f5e4..e3eec38897bf 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
@@ -23,6 +23,12 @@ properties:
       - adi,adis16497-1
       - adi,adis16497-2
       - adi,adis16497-3
+      - adi,adis16545-1
+      - adi,adis16545-2
+      - adi,adis16545-3
+      - adi,adis16547-1
+      - adi,adis16547-2
+      - adi,adis16547-3
 
   reg:
     maxItems: 1
-- 
2.34.1


