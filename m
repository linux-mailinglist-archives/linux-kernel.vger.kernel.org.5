Return-Path: <linux-kernel+bounces-56085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9BF84C5C3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2A99B25819
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAD0200DE;
	Wed,  7 Feb 2024 07:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEHqKUui"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC1F200BE;
	Wed,  7 Feb 2024 07:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707292103; cv=none; b=ghnEhjw0gurHhOb7gT2Frr47oEpxbXncJZztP23GJkOjcJxEfwVNrzqiAjleZSeu3+xGv9ueOQi2hKj1btQ/dlEk70t7L4ybTHNtjwNt9NNFoCLmbvn2StIKeeOH3UrcCd97knDyrbo77o0IngngoTBT7tjq8qCmFgjMfZzWHS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707292103; c=relaxed/simple;
	bh=x7RYFZgF8p8yYlj3hW4foez5Qk5bNgM8KWOElGUvSY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZCLzzG4Nv7o/DgKrTouVHzOWdeK6yR2X2eNHJULVRIaXy4vGMI7p4L7umUpFEaBnEMf3NbcElW1Q248BgSCVZ7SzFBgcVCkUCDeq9VjF/ZzFHqLyO8KprrfLXRBqnYnkQeTLyo0DVkbZ0SDAmUcTyM9LkOgj7jw4+PrpLujRFYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEHqKUui; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-558f523c072so366738a12.2;
        Tue, 06 Feb 2024 23:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707292100; x=1707896900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xitMhwIt3E5bq9TjfFsv6xg93Rx5FdrkBR3fyr75HRA=;
        b=MEHqKUuiyligy+7tsq/s5yJvCGnNBiUrONhvj6IMcxcXjAHThb6oeDLbIguvTdAZjp
         ZsHI8C1UvL4GI80baEAQI/6UvtGn5VUjBDJsSAIu7V+1nX6w0QMimJZhDprlwrpsmFOA
         OdHwd2X9ssFzos/B1Yo+9rGJBK7317dc1dQaqOZIHNchDk41GDMRyP5B+hLpFuSUxd+G
         /ZWNy5sBk/YE3Apj2SUR+K533w2e6RxcT3nldHSH9rMFLuI6ic9C1084NI5L6AntJ35/
         sBhUHEpaZ+BEU5GQb+jwUkDJV6RCr080BHsG03lHs3xF0X5togG70tfCG86w86Pz4Lvc
         zbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707292100; x=1707896900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xitMhwIt3E5bq9TjfFsv6xg93Rx5FdrkBR3fyr75HRA=;
        b=VSy2cqM37TIr4Kb9747EX6TjJZklfVmopQZlD42HpXCbpOJpUe48GpwiJp8p2o83FY
         W6/EpPONsGLn82zH6N8v3sUc5MhvoC3nBPb8f0ef+TZzjcHsU3BxTc4i32WNW3+4PUNj
         njbKkyhHrF4LJdHabzM65RGrv+UFf6fVxxMc4Yl5TvH7ckgd1N7XwrOdQWoZrxpUkDNI
         gO7xf2f3XgtGpn+dFfD2PmnHXh5WyAc/3wxUvQUPwsHzZrMBb6F0MGOFFhYB0kbkixyH
         v9fSR+xG5EFE4OY+49uUJE9HygGa+/CBxIMvFpfaDD6jrwSVNpmo337l/f8JZGYJ6gyD
         Ccbw==
X-Gm-Message-State: AOJu0Yz17yMNeEmyYKdo+szQK9MQ+jfB1h43khDCytOYZIsehH9/VKQf
	o34GBePDNNbIUd191C1eLBH41+XTwXlBSqUCqcIye2DFMdn9dHIA
X-Google-Smtp-Source: AGHT+IHSwMkLSaWEMXTVWxxw/4kOVMeNPuuahJdG9ibi2bWD6Ei2cfidwlanGw5dUvIwjGmeP+4PIg==
X-Received: by 2002:aa7:da91:0:b0:55f:e493:33b4 with SMTP id q17-20020aa7da91000000b0055fe49333b4mr3609676eds.15.1707292100181;
        Tue, 06 Feb 2024 23:48:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWjnckqiPFIzsDO4KdVyuANUmEW0Z+2O+6+GQ/q4WzQvuvcxxymirYpqwlJFuYGWYWxQHUxY+YwUtK9Pmu5L/f4nuZHdCaM+CDN0C2jA7kXELXJJSmzjr1NRDYk2Daw/PGWhR1wrt+BFpjtEUuhfvzmK+SQ3uKNH4mQ6MUxoq4vPhKQM8LaSsNn4PQ9CUMS+JmweZdpFj/4BQJEWZKf81NjM8b4XlbcbpWofDOF8UTLTLpwYWDUl4GPV62b4Ip7cz9+9IizbAaHPAVePWyhNTFe+SLkW+3yWepnI7i/KnKitZz7QVkqby87l/R1aXwjuI36I3skyXwJn/EFWe+PQY9fXsoTnydwJ3zBsF4n6nfWWwToVlXenG8+svfn+U37GN/5wPIncq2UhZDstoPYSOBHgD3UwPQRKlY=
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id f3-20020a05640214c300b00560556fe9b7sm378558edx.78.2024.02.06.23.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 23:48:19 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Li peiyu <579lpy@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: iio: humidity: hdc3020: add interrupt bindings in example
Date: Wed,  7 Feb 2024 08:47:52 +0100
Message-Id: <20240207074758.4138724-3-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207074758.4138724-1-dima.fedrau@gmail.com>
References: <20240207074758.4138724-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add interrupt bindings in example.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
index 7f6d0f9edc75..5b3f9670fa52 100644
--- a/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
+++ b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
@@ -51,5 +51,7 @@ examples:
             compatible = "ti,hdc3021", "ti,hdc3020";
             reg = <0x47>;
             vdd-supply = <&vcc_3v3>;
+            interrupt-parent = <&gpio3>;
+            interrupts = <23 IRQ_TYPE_EDGE_RISING>;
         };
     };
-- 
2.39.2


