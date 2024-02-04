Return-Path: <linux-kernel+bounces-51931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6370F84917C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED287282AD5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FD4BE5D;
	Sun,  4 Feb 2024 23:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beGsTce/"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CD679D8;
	Sun,  4 Feb 2024 23:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707088608; cv=none; b=gS/vStz3u9F8NClnaynFVdeSon1008L4IntG5hezjNQzNPP2vRHcs+wvdV5ehiFBhstygJXLB1Ha4NNkbq358vuMhh3qUbnaC8Q3z0uYzqhxD+BNhxwcvoz7qJe5DdLGxN6uNjajYUBY3tULgELhUrLYnk4CEzc9wFh9M9dr7pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707088608; c=relaxed/simple;
	bh=C9z1oCM0aoZrRkDJxd7jDlrFsjg7dFGVjJSKnwS/2Uw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=KwnJrfDxd9JxYNaKomA/Y8aH2rJ9J8LIUSHQE03yG5B2LjcCYQS7Eu49SeDW/+Vu0PEhYfopjNnmRQ+kFqEQk9FvGstjQXcDofWO/W32i7k7wL/H16cf5O5iJQwpIdmS7Bg4BmozlQkFruRwqqxZBN1hBviiLP0p1uhVJE0bikk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beGsTce/; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d09bdddfc9so13957761fa.2;
        Sun, 04 Feb 2024 15:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707088605; x=1707693405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5VGuwU7sRb6X3OaRcDA234b6ozpGj7s2IWLXVXNdas=;
        b=beGsTce/qlJnfFzNAt4j/VwFqIwKn1pGe//e3OpWzY9uNmYkUzWH940T4O/C6K5fE2
         TUL0udvDcb2w93NTuB6ofsiw1mj8y4w9M1KzjeXpoaUvb1pKYmYGM6Nm9eKcGz5xmqEq
         dDqyWAlkyyGct8rnE0rCafe3c3uBMod2CvfeC4dgDIGjI7q1w2cjmngedzmxTAPuRf17
         oANk64Mj4Ig0hfIfGOi977d5DYgmGnBNZZLGfyNiku1u+6g3c4ehy+yERV0d0v7uCowe
         jKNsmAvq1gELOH64XV/erQvdnTdbiv+o9eCTTyHRKcSU7u7ORqs37vXpp+/eDLTQq2D8
         EVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707088605; x=1707693405;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y5VGuwU7sRb6X3OaRcDA234b6ozpGj7s2IWLXVXNdas=;
        b=LMsGt68Ceygt44euu5/QByTVu14kDl7xlWABlHa0g+GmUBSkqOKURjYFNziAp6GXj4
         easO0SHbclWR3kIX5kJFsaV11EccUELcgBscIJ14sGoIun8Ab7q5jiv46J6bq8jcVVjR
         Q+QfqL0SntxedtMXCFhYTWFKHsEFYkcRote0Ht/PZgnNlPbfOT6I7RsE05qYZDFXYrnF
         AmyS1x7zkRzMxGYrBTaOkeGsIRBdWPaswKW0Q9EjuGAc99upAUsGUY4FYRilhEkm1CIn
         cLkgHYXZH0TVCMblXVoRie2WjVJZxI05+lSxMb9Pioe1STVZ3atDywjjxZMnbF47nFdA
         GUnw==
X-Gm-Message-State: AOJu0Yz65Ny0glNcKdqSdAdDx/46DKCjHWCd4sc1URqfdsZrTn7q9Mx6
	DSiacaNNqVbNgR6Bu+kCwdrl8Ay/WPfbs6yhkG8J429CXdhS2LCafF4jZ/Xd
X-Google-Smtp-Source: AGHT+IGuXT9bYE9gMIH7LN//FJs3Z0wankWaxPRTI9OA2HPcm1HgjgSW6SbdfyCYKAsb0V5zFMcl9Q==
X-Received: by 2002:a05:6512:481e:b0:511:495b:f83d with SMTP id eo30-20020a056512481e00b00511495bf83dmr2311389lfb.38.1707088604840;
        Sun, 04 Feb 2024 15:16:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWy4xJNlOKG8NbSFb7Ic0yPYvabi8Skm5y+9UnF0KSKE0YUXDNHcSkgSNIx5u5LMJlr8MiocdZ095wRYCBsd8p7C2nG6iK+wQUrsM+dtWU/UkP/szJN0P7UF7ICBJ36ZTa8e24kY5EpnXoW5OiU1A2jhBVms1wj0I2nLmXt2nH85BX58zvAZIzrwWt/k1OTpVBIWwOMxgxDjoxvP3DUBV4Q2kHEB4wt/Ei1rmEP4MZVvgGBNaiWzcH/H4zvBLa1//oFx6DvTrgiOVYx+dge69iHpHUE7xjP8e0fMY+wWpSDneaI83HJWGbDZj0=
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id vb9-20020a170907d04900b00a36814670cbsm3624216ejc.62.2024.02.04.15.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 15:16:44 -0800 (PST)
Message-ID: <5551846d-62cd-4b72-94f4-07541e726c37@gmail.com>
Date: Mon, 5 Feb 2024 00:16:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] arm64: dts: rockchip: rk3328: Drop interrupts property
 from pwm-rockchip nodes
To: heiko@sntech.de
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The binding doesn't define interrupts and adding such a definition was
refused because it's unclear how they should ever be used and the
relevant registers are outside the PWM range. So drop them fixing
several dtbs_check warnings.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index a73234b11ff1..b6f045069ee2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -488,7 +488,6 @@ pwm2: pwm@ff1b0020 {
 	pwm3: pwm@ff1b0030 {
 		compatible = "rockchip,rk3328-pwm";
 		reg = <0x0 0xff1b0030 0x0 0x10>;
-		interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
 		clock-names = "pwm", "pclk";
 		pinctrl-names = "default";
--
2.39.2


