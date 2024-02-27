Return-Path: <linux-kernel+bounces-82560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AFD868660
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D9C28A24A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD6B54BEF;
	Tue, 27 Feb 2024 01:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyTP7MaY"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1508F54900;
	Tue, 27 Feb 2024 01:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998469; cv=none; b=H17s9G9I6nmLmfvZDK5qRss8JqJIUq20dgbI4c1We3ri62zdsvJVh8GGG+57Baa9TmaF5MK0w+wy9obHvBQAm/0GGxVL8tGqIyuLcv94CanUA0QIBTiNfencwXi0NfuNEEiqFsD6O1o22WT0VR+DIcXaiCVW1baD5DpzzHIWlM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998469; c=relaxed/simple;
	bh=4wNrfxiYKtY4M7WYePoTXsUe2Iy0vCdtu10ZMPGGq3Y=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OsAJ4FP0vq58X/CXOqGoP+Tz4UUnAaf08Zl7dVDrhj3+JoGCb8B2xlF0XQs426Bz6ATOQB4Q0FjEDl6jOQHfjtIZCOBmgI94RludKyVeVWS0bcQ07xJqUnxH3Lsii8as9aK23bd9QOSytTpNDJnA+Z4NohzgSQMGesCCVIipW5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyTP7MaY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dba177c596so23679445ad.0;
        Mon, 26 Feb 2024 17:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708998467; x=1709603267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hs0kTt521WxQulVTrFgJYAGsV52YNUczVxWl9CdT+ko=;
        b=SyTP7MaYsJDC74D58uDV7+hnvBrNhUvgaaiuz45IHoJ7A1wpI63gbf1rSUm7HwvDvO
         tvrdfwKZ1+U7COjfD0Ptf+muqNkMvwnGpIapufwlPGjO5QSF7fHzgLTLYkvPxPMM334o
         t+Z/lalOEl4grazG2wlQ4vn8DDPxire0XOhXAejHiUCf8DkbnSP69HD84nXrGjDM6is2
         fuQsa8EDAZsfY8QPoHtT9w1ohwADNYT/BJaRpwh5OGLsge9MzW8lm3iyKkSvIN/QUYQw
         ufrV48McYVDDA4Ze4B3R8zo07bbCu/6UN/YsIFdeu+hSKJfJNiDPoe/7fzapS1bMxpan
         behA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708998467; x=1709603267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hs0kTt521WxQulVTrFgJYAGsV52YNUczVxWl9CdT+ko=;
        b=Z45hERdjRL02nocw/O5qEq1a6Ll74aq1BE8ZJXvcs6Xiy9hALPgCXw/OwgE2hdE2fJ
         AdpQmggN14HZ2/m3l+0bsN+2E3mMNR3iQdsvTiMM+1bAAIzsiWhWo6tJ7Cc+iTswlVgv
         VIHT2DSCdjnxj0ZU4mVs9YOtjUC4D5V2/hsPS2hzRFvuDtYoa2eYxF+LIlnr4plJ/j01
         RZOH44r9uk9Wdnog5MBVtddRPEJxtaH7CWeAitCadOIZzJaj9FAOSW7ejgM2LvKwkw+1
         q1cx3MGZ5N6WAQewMGdeWEi76ETTFfR0PN8XVCaXbD/aX+Ob+0tQ45c1wCmgKKdka4cY
         hG3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkH9M6pSGdQpk68IkqncE6X1NqRqbAvl4w8EZPe7WphVBL2LIZ5TL/Rsr044GgCZcuSESZWJYKF3QtrpAsce09Y3ZSLJx54GF9uq/0NNHHtP2Xa7GtebK16+bWzqmNsgaqKcP6Wb6ZIw==
X-Gm-Message-State: AOJu0Yzj04LgB68yYD7w655Fo0iRWb2SXf5d8cpVkCIjF3U7CVtlWKje
	4xzFY9lFSXIXAg13EKsL2ryeF/bdCy/uJR5B7rWDmTCwJFM1HgGU
X-Google-Smtp-Source: AGHT+IGuCy8bpvvHRwtyY97TpNDqZJzgeQPnK+BX4u53CAN/uvQNpPDyoQQPZHSXZR3chccrAq0OwA==
X-Received: by 2002:a17:902:654f:b0:1dc:15f5:fde3 with SMTP id d15-20020a170902654f00b001dc15f5fde3mr8724505pln.4.1708998467634;
        Mon, 26 Feb 2024 17:47:47 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e381-af24-f369-7cbc-56bf-1d54.emome-ip6.hinet.net. [2001:b400:e381:af24:f369:7cbc:56bf:1d54])
        by smtp.gmail.com with ESMTPSA id kl14-20020a170903074e00b001db4b3769f6sm318893plb.280.2024.02.26.17.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 17:47:47 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/10] ARM: dts: aspeed: Harma: Add NIC Fru device
Date: Tue, 27 Feb 2024 09:47:17 +0800
Message-Id: <20240227014719.3037588-9-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240227014719.3037588-1-peteryin.openbmc@gmail.com>
References: <20240227014719.3037588-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MB NIC Device

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 7e98af5836cf..6e9e6e559838 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -207,6 +207,12 @@ temperature-sensor@4b {
 		compatible = "ti,tmp75";
 		reg = <0x4b>;
 	};
+
+	// MB NIC FRU
+	eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
 };
 
 &i2c2 {
-- 
2.25.1


