Return-Path: <linux-kernel+bounces-23784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0862382B1B6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46C62B22943
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A064CB43;
	Thu, 11 Jan 2024 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b6JSv2M1"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E6A4C623
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so4751364f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704986728; x=1705591528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=evBY7G5meh2vgcdCD04AA8ujExPP16KlKzDgrJGrxTk=;
        b=b6JSv2M1hfS3jdAMhDkYoXX1nawC/L6Gpgm/YgOzlLeFYAzZO9iPvpGnjWc6oZEF2G
         dkAQzDrYrnEg7vQTIAxwx8GuKcFWj4fKLvFXFw7SDuta5mxrRjagd5MZ5mPA0ykB+M9G
         Bo7/D0aJTCLRRn+OQZ7e4af8318t3sXSWSHv4SBaGXqdPYhbcocSAWChbiRCO247qQvl
         v10AtzPXcZlYXtNBtGxN1jyYC+JYA4m5Iqm1i0LFlf3tC/BLeE6j1ETw/RNmPzenB/iS
         ICG2/Gy3+n0i3Q/JUf/kF4tyS2SPxD3FRP6/G8xuh1Ctk4g07Dz0qqOOP8gDKidNyGaW
         4/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704986728; x=1705591528;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=evBY7G5meh2vgcdCD04AA8ujExPP16KlKzDgrJGrxTk=;
        b=c4nwxFobwMnbBKDujVfDNxKy86lVjKN97JX2vraZWhqi5wZaqRVzZcFOZvsfRWJL7C
         5ZLWhdrL5dFqC15FkkYkO0t1LB61LIXtPY7IpJ2p2ofYQJ1I4GT7W6goWcjHL1z9JeME
         bbKLT0e3mVSu0YiCcKcBm/oanwRDMMgLJQ7q2EctS/V4NbRaHWYOmHD0jdZJ/cx4g+sp
         hJ1TnyDPm5X37NkUeS3Aa7OvKngzs1mAHBo4mEtMGDbLqTTn1FTqO2d5JZQ2v6yqwXr7
         sH7qp4h6mDYxjm9CWpYL5rndRa6mPPkwGjtcdchwTcFYg3l3a/GrjSKn4T/xtlWOzKPI
         S0vA==
X-Gm-Message-State: AOJu0Yz38dybzCS95XhejK5xDgUqZolXOTYg+EKNhm+1G7f07K25gLqD
	nThRzx/uIGAWKFxSSNyjHozSiB66vNVZeQ==
X-Google-Smtp-Source: AGHT+IFesYHsHdevt0age8LfkFxLnKkt6ZJll+ndYqVH4+HSaalewhELgBI2dUZmfL+p41qv8jcyyQ==
X-Received: by 2002:adf:f18d:0:b0:337:6539:2033 with SMTP id h13-20020adff18d000000b0033765392033mr866994wro.56.1704986728007;
        Thu, 11 Jan 2024 07:25:28 -0800 (PST)
Received: from [192.168.1.70] ([84.102.31.226])
        by smtp.gmail.com with ESMTPSA id d6-20020a056000114600b003366a9cb0d1sm1445502wrx.92.2024.01.11.07.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 07:25:27 -0800 (PST)
Message-ID: <78476abd-08a7-46a8-8ffc-425a311eee37@baylibre.com>
Date: Thu, 11 Jan 2024 16:25:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] arm64: dts: ti: k3-am62a7: Add MIT license along
 with GPL-2.0
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Pierre Gondois <pierre.gondois@arm.com>, Tony Lindgren <tony@atomide.com>
References: <20240110140903.4090946-1-nm@ti.com>
 <20240110140903.4090946-3-nm@ti.com>
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20240110140903.4090946-3-nm@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/10/24 15:08, Nishanth Menon wrote:
> Modify license to include dual licensing as GPL-2.0-only OR MIT
> license for SoC and TI evm device tree files. This allows for Linux
> kernel device tree to be used in other Operating System ecosystems
> such as Zephyr or FreeBSD.
>
> While at this, update the GPL-2.0 to be GPL-2.0-only to be in sync with
> latest SPDX conventions (GPL-2.0 is deprecated).
>
> While at this, update the TI copyright year to sync with current year to
> indicate license change (and add it at least for one file which was
> missing TI copyright).
>
> Cc: Julien Panis <jpanis@baylibre.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Pierre Gondois <pierre.gondois@arm.com>
> Cc: Tony Lindgren <tony@atomide.com>

Acked-by:Julien Panis <jpanis@baylibre.com>


