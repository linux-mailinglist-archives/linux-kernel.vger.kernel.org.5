Return-Path: <linux-kernel+bounces-80979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D952866E9B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E0A11F25D22
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC50B1D553;
	Mon, 26 Feb 2024 08:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dwtn0V0N"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6581B1CD2C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937621; cv=none; b=UFjjAhX8jPc2vxDVYblQNl3GqKDMR6jp6O9kMjKx2K12DY+OWZq2UmMAnM+aQrpwVFiWEeRBMkqNxE7SSJexqcRs9o5bCgqfv0HO7BdWDpcbslWrtOPi0tYsbHUwGEAl7jzOSYYUI/b9DSCOUrFXPsAQ+wP8t/d90+iwS8l7/Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937621; c=relaxed/simple;
	bh=miEm6btsrdHQIeRpSD8NDEZObb/Long0p1VUn7V4OPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWbI/yMh+fSEby7ALLiphw4adHwiPLWb/L3Y7F13EqE1QKP8vgDQGcOs/8Co+HGPDdrRt9HScQU77jv7UxOJeBP23bZ3gK5BA6wvb5pXfZBdUg5XGRRRtGlEhXRKLS1zarVbu0qIxtof9Ki9vD+slzJe+cyxoAHDBbvzQgmb2LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dwtn0V0N; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3e8c1e4aa7so254291166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 00:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708937618; x=1709542418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bHQ7jHKdG+MDwmW7kS/5z1xq3VefC7Loe1slCKwf0q8=;
        b=dwtn0V0NKwzx/sUI/lyN9EW2ISlE+7NfKYyuypbHIC2Qr0pg3ztekW0zdoyAKJX4vn
         GEtpWEyx/ASpQB6wS3e2sif8JR6IekgAfdd8iN/zabLRowip/yKw+L5yU9Wp0pzOaTxw
         pIBUVu3SgFP/v70Xw9bMJZA1FVHIKq6ycyzsHfF2S92pG5iHMpQTbUVPZ9OI04NZEZOm
         OmqgbeQecawswxooXmNn5f772qaLKtTFKST2uw+NCsTs0gxbdxixB9KxJXtC0ECqI5uS
         pXK20LweRibxBPmIH5WALpgGrLuR3Z4S5MQW5Mhovv7afosGmjtWSrx01BgMUPXXJIwc
         JsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708937618; x=1709542418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHQ7jHKdG+MDwmW7kS/5z1xq3VefC7Loe1slCKwf0q8=;
        b=Ni13QhB6QuAHRzzbWCL2z+AegaK35jFXPPtgayXuNtlcYkMAcYwHhfTRQHbP/F4TKr
         zXBFyF18QXJzWNqF/OKaDIGfS8F2mTUUXQOWQw/21l9Smx/VwF/L3gr9Th/ruHV3TuPy
         csoFK0YqWv49Wsw+3XQkUGUFW00drynI8V6kEQJg1cWLWJcXSuKM1djRLtsSvamKO2MY
         HfaG7ciMg0gAilBO2qzvgMmcv0H1Qe7BvNLo+tqXB+m4KuPiMcZdky4LU89UV9InBYia
         BSZdQjLhIwNK2Ejf0znz9ucZN4TW8UfE5urF9aaarUYEbdYuLCVx45n8ye0Kjlf9MWyT
         /SPA==
X-Forwarded-Encrypted: i=1; AJvYcCXwu2DC793NYh3mKctaG++Ns8TJcqe2WVfi8QZ2ynDevb14+rVb5X4QAyjWrCfxXG985dmJdYonjPeBpJf1VTXH6f7scssnmmsD35Mc
X-Gm-Message-State: AOJu0YwUCA55nRZLNyowllIBrZo/jlKmuJ+GDOyja3o5xoxJy1U5QryL
	Is0WMxPDuB7vSHEqkLDYCijoBmRSl5qAUjT7rxAOAxXP+NE2d9QR1qr6DDPbn6g=
X-Google-Smtp-Source: AGHT+IFy+cfEp+0Vwzv3Xmk4x476cj5LMncuXFcuxpkchPSoWaMXxiVwBZRPr9hLyqRy+3Xybx3Kjg==
X-Received: by 2002:a17:907:9902:b0:a3e:5726:c12 with SMTP id ka2-20020a170907990200b00a3e57260c12mr4363389ejc.37.1708937615031;
        Mon, 26 Feb 2024 00:53:35 -0800 (PST)
Received: from [192.168.2.173] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id qo3-20020a170907874300b00a3fcbd4eb2esm2204489ejc.1.2024.02.26.00.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 00:53:34 -0800 (PST)
Message-ID: <4d117770-6e0c-412f-ac1a-d9ba84b5b4ba@linaro.org>
Date: Mon, 26 Feb 2024 10:53:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: spi-nor: Add support for BoHong bh25q128as
Content-Language: en-US
To: Michael Walle <mwalle@kernel.org>,
 Christian Marangi <ansuelsmth@gmail.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 David Bauer <mail@david-bauer.net>
References: <20240220200325.19089-1-ansuelsmth@gmail.com>
 <f7c45e7b-993c-444b-8710-042da7512bbf@linaro.org>
 <65d9d08f.df0a0220.988bb.3177@mx.google.com>
 <CZEVS9033HET.1NPH0K6PQLR87@kernel.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CZEVS9033HET.1NPH0K6PQLR87@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26.02.2024 10:51, Michael Walle wrote:
> Hi,
> 
> On Sat Feb 24, 2024 at 12:18 PM CET, Christian Marangi wrote:
>> The user just tested this and It seems there is a problem in JEDEC id?
>>
>> [    0.726451] spi spi0.0: setup: ignoring unsupported mode bits a00
> 
> What SPI controller is used in this case?
> 
>> [    0.732850] spi-nor spi0.0: unrecognized JEDEC id bytes: 68 40 18 68 40 18
>> [    0.739725] spi-nor: probe of spi0.0 failed with error -2
> 
> And what kernel version is this? This should only happen if the SFDP
> header is wrong, but according to your dump, it is correct.
> 

I assume the test was done on an older kernel, where the identification
of the flash based on SFDP is not yet available.

