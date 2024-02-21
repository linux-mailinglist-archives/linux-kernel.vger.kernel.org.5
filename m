Return-Path: <linux-kernel+bounces-74432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3EE85D3FD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC1E285902
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348B33F9CF;
	Wed, 21 Feb 2024 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gl7xGfR/"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277ED3F9F0;
	Wed, 21 Feb 2024 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508511; cv=none; b=SRZczqBqcEuBFYkHxji/ofYC5+UaQEPYoETOXdRxLYQDQo2P0YPjQmJkcKxibsH7+EiR+YyfDYUqwrUjsY+U6/BCydSEfPJzkJ1nGw5FgWxxoOU3bg3hnvUzYw0wRHgPNJbaf3CBAGNnYrfnJuMryeeHiwNwxg4DlbwK+Tr1srU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508511; c=relaxed/simple;
	bh=ouKt5oYQx9iCd8JB+WoxBSFevVL5uuHVbtSaDULqbIk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rqrXmg7Q+SrfwqjaqG1alcsCXNknGcFL7t97bCPgBdC56Se4rca2B1/A2IYT/rJ3wZTCd0w0nRbbL4xB3gpD5V7/FW0mbGqYFWvVM0QAFjvYXucZH+k+prrXJelC74bnMBmG9lVjgqzGE+LEKAPg5dmiS/VXsEofyyjT5SIM/cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gl7xGfR/; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e4423b64acso2377625a34.2;
        Wed, 21 Feb 2024 01:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708508509; x=1709113309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02YQN9leMQs8Y5hO76LXmTuDvuIJ1BaLoEHOXqsFQkU=;
        b=gl7xGfR/2zwrJMO+p5Jw5Ho4PuBJfUG31bUpTp2upkioNiWcsvVhHxBpXI+PFA7/Ca
         FMuMd8diwZYWpRBz7RU6Rf7oJOukjxanh/1r0LWkJf3z/roqk4I6vz5NfOKr/Peq7fL3
         NK5pk9aFfXuL9Jmi696eaIwXfZrKYxOGfBZUbVUPQka3SatmYEGq0QpjxoaKBOJAqPpn
         OjVSDI0nVBxZrR2LBY3uq9EqkBHnoyuPXnCF+AjPnMdN0DEFxrsEkwdJTxPB31XxUxKS
         +6XRwPI0F+EUTwXZth2uvLGtGzGVKHrHhxqKi3s85EiSok2bTaWSeM5JPk2Q/5jpc0nO
         4qUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708508509; x=1709113309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02YQN9leMQs8Y5hO76LXmTuDvuIJ1BaLoEHOXqsFQkU=;
        b=KTvSboe5783D2yDKxgZdX3Z9CSMxK3EGJ9Ejf/vX9Nb/e9XTTeNGXbui8N2gIG7bxC
         H5nMjmLNQHk4BJDu4rDJeqUlL+k0y5187ok0yaalvUlTnNFpKZjq3zgTh24BBWbhpAY/
         nZ35WSOTiisPQG+gATHKhKwQdyyVjva1eCN0NCa8SsMHPNCqa7SmWl4mOsNh36ZIZ01V
         Jp75rS4J40rGluoIzX8TT7pI3AOg86Yt5+cbuFM0LMQX+VkrNDMkRQ3RtADGaj16j1ie
         RHdK2rK1oCDBVuKkecOfIpDQfFeCSKZdiRfv3/o/SLeeh2EFgsal/HbQZMfbFhVZfQBP
         xdug==
X-Forwarded-Encrypted: i=1; AJvYcCXCnFYyn9l3V6RUG6S78qASVVBi0jSZ0Andos00mzNkZa3fIXRXnZkpD3ycUtGPL0SCA6tIz4/NfHXt09LXbPVlbr840bEmm2Wl/s46EimrGy8/HArA+cULdfvGh7wXqym8TRp5IofhsQ==
X-Gm-Message-State: AOJu0YyzFAXtD9gs4i9Tvr/YuvyIUjICgx5Yz8CbNEVaIMnuUhl6grJ8
	pEycLIoft726uUPf3wyWa4feJIk2FeufSUvplS+mML7O29Ty3Bol
X-Google-Smtp-Source: AGHT+IGzABeCompCAg32fwPlToc/7w1feuY1z5aA994Hu9a3puthAAGIl3l5oO1Oh3zPZMFSO5rVFQ==
X-Received: by 2002:a05:6358:4883:b0:17b:5a95:9902 with SMTP id pe3-20020a056358488300b0017b5a959902mr1537315rwc.2.1708508509139;
        Wed, 21 Feb 2024 01:41:49 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id lm4-20020a056a003c8400b006e488553f09sm1645026pfb.81.2024.02.21.01.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 01:41:48 -0800 (PST)
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
Subject: [PATCH v3 8/9] ARM: dts: aspeed: Harma: Add NIC Fru device
Date: Wed, 21 Feb 2024 17:39:23 +0800
Message-Id: <20240221093925.2393604-9-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240221093925.2393604-1-peteryin.openbmc@gmail.com>
References: <20240221093925.2393604-1-peteryin.openbmc@gmail.com>
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
index 83da7e46bb42..d5c5c5b3ab4b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -207,6 +207,12 @@ tmp75@4b {
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


