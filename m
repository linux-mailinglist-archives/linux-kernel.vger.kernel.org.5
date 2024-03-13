Return-Path: <linux-kernel+bounces-102251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 949AB87AFD0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B1F1F2DA8D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1277580607;
	Wed, 13 Mar 2024 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+mdC1Ut"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B992D7F7EB;
	Wed, 13 Mar 2024 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350304; cv=none; b=hS4mlWflHgJG7lH1iJvGgHT8KUnAfuVIcZ5BGDIcUO7pUfpzOfRrGUnAQFgbgMtzyp8AV6qr0ErHkaPJ5AmjtNq/gOrAl5qjyGGqsZAc7Cu+OejXPShJflq+erWpTV271nrzAvyYicLM9lzfAFpqffgVM8drhXZPstm/CTZnZUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350304; c=relaxed/simple;
	bh=37T5IfVlw03ED4EzOqmPCpS1RhbW/FzcsvsNaz03OVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBrxl14Ag8nHXZZndTlCTAiNPRB/9zt6Vrv6tv6G9ZymrJaW9aFF2qeSko4ztnjsmd3MxpOq9Ed9wtEV+uH2fq/6wBmmRaRwKsR9tdXIPKZXSvFQxFMekjroOhNoEBFYaonvTHw0UafaKfJvO8Y36Bx1+ESuK4PWOIW374n6sDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+mdC1Ut; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-413e61525c2so608115e9.2;
        Wed, 13 Mar 2024 10:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710350301; x=1710955101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FqFnJvYNw9zpN3h/cMtu8tZOEqGdp7v63hXLyZmhw0=;
        b=E+mdC1Utg1IFJudEClbHRJhDqQ2AI0BgJ5Izj/Uyz2kbqFXQRIZ2jnbfLC5MMhLVzI
         GYclWELlLaWpApYO0L5SobCfGbZ3rWmcbFR6/6eJ5xOtsN3gQI3xxOH+qPw7hWuRkjRK
         f7tyRnX0TmPUyygBfndxATZAWHyi1aO+1bWZV4weC5kamjNSZwIoHtyRA6bIK+q2IjRa
         ZtSM0Fh2WuMRpA7p7LGD4hfTOJ3WmZZ/+B4QsvB8bGnlukHy/3crv7VlVt8K79e0dVt6
         7wQ/q+pCjGQNVDS2oGETpx3j1K9lt8/wZHKnUivB7DMAnJG2EIHkwK3sdVjifCEsaKCR
         JRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710350301; x=1710955101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FqFnJvYNw9zpN3h/cMtu8tZOEqGdp7v63hXLyZmhw0=;
        b=eBJeDrPkIsFHpLo7Wo4rhDtc1tFfoY6mn1ELraNZwX00zVxOjqbAmd59A9B0/WwQBW
         DKjp/TcdeAa2pvlIchlQWFtLkcTpmAl8xflfrN/KOGGC3UIRjrt4WVIAVqiTt015V07a
         i1/u5lczh66xt4TrDdhJajwqh8Q3Nl7RqmsG90G2mfRNe9O+8UP1wOiVzPE/Imp4psuf
         MTY/dyXeJZlvr1O6yGbACvOi86991VSzRObs3T/tD9lAgU5FH/bp3HCjJjm85dwys9Fq
         zkvIuM9AESIbJHQWcNtyp327obGOIwjeplLPPscSwYQNw9CgzVDNxyeNC7zo/xmiJh5P
         zqhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvN2vPYERPvjTZS3wiL8SKHf2nnJJJkE1n7bj9m+kpzS+BIpFqojnMNQ/pK+mNfV3gbKzEvAmUHjeQthJBBUmKU9M2q73gmfB3pOQd
X-Gm-Message-State: AOJu0YyZVwHU0o3Y8fbYH2bNlpKm5ZQJk5v+l0zw3RrZFo1ooVs+Jc0L
	0rQQf5YgoRyCvpX2XQxM73W231jpg0qS2upqaq+dL8l0BGmV6Poc
X-Google-Smtp-Source: AGHT+IEtiPdYkCDAPHchHeFYhHC/s2/7awajXKKfjSyC4rnwNuj2Got/IRTSQQF8SJ0Qx5cyNnpxUg==
X-Received: by 2002:a05:600c:3d17:b0:413:e85c:e5ea with SMTP id bh23-20020a05600c3d1700b00413e85ce5eamr469639wmb.0.1710350300980;
        Wed, 13 Mar 2024 10:18:20 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600c4fcf00b004132ae838absm2833251wmq.43.2024.03.13.10.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:18:20 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andre Przywara <andre.przywara@arm.com>
Cc: devicetree@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
 Chris Morgan <macromorgan@hotmail.com>, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/4] mfd: axp20x: add support for AXP717 PMIC
Date: Wed, 13 Mar 2024 18:18:19 +0100
Message-ID: <2315501.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <20240310010211.28653-4-andre.przywara@arm.com>
References:
 <20240310010211.28653-1-andre.przywara@arm.com>
 <20240310010211.28653-4-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne nedelja, 10. marec 2024 ob 02:02:10 CET je Andre Przywara napisal(a):
> The AXP717a is a PMIC chip produced by X-Powers, it can be connected to
> an I2C or RSB bus.
> 
> It's a rather complete PMIC, with many regulators, interrupts, an ADC and
> battery charging functionality. It also offer USB type-C CC pin
> handling.
> 
> Describe the regmap and the MFD bits, along with the registers exposed
> via I2C or RSB. This covers the regulator, interrupts and power key
> devices for now.
> Advertise the device using the new compatible string.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



