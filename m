Return-Path: <linux-kernel+bounces-112490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0726887A7B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 22:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9381D1F2194A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 21:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9931F5A119;
	Sat, 23 Mar 2024 21:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M93ttoP4"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876E94DA14;
	Sat, 23 Mar 2024 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711229722; cv=none; b=bwz5MrxFLpoOgwTZmRkmkiQTOPW9RDsV63bhK14dJUl245gzDg99V4H+EfJTmcftPRxlPbpdhI5bxhdNkEi112e4y/DwZES1f0LOrHzhGFsaPIAK0xjOJLa3+gsc68yRvbEMHlXjzDNharBWQsRpM15mMjhngupNn5gCQtGBVnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711229722; c=relaxed/simple;
	bh=TFXIj5mvfTZYZ+/AQvqgbwvAx8bC445BW1C69Qbt5uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5tOn0e2jlv7gqOLpo2Rm+R76Di96Mq9RxdN+CWElE3xC5HM2mhLjVDe0mfnlwlhrhVkkyBJqE/dbbejcSagembFBrHqLHlPwNgOyd74V2eCZHYLTXErLfs6DY3VhvgQQB93/j+v47b+GpsU86Ch62cZCr40OPui2CYbNCpggsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M93ttoP4; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-221ffba5c8bso2031050fac.1;
        Sat, 23 Mar 2024 14:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711229720; x=1711834520; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QroXftDALwHHBo/MBvbGld59w96AGtW6cgASiak20nw=;
        b=M93ttoP46YVuvOAJFJWVOcKebrd/YJNnoBYY+7hpGSSkFxmiOu0z5qiuLHS9wtsBNm
         9kNzwcgrzaRmgkHJKbymoNhlp1StDGPYHDVzsPfZIv4Ho5TwKHxK+gIy/glhEumbRhbA
         9MtzXepoPIop6iNwK+xhuDt9oKUn8pkI1+aoH+Im1d5MVF/fyUQkDPpJfpoMUhj1xkyb
         s5ifNv7aflzHcEdE8gfzqBt02wC/u7PVzkYu1EtHQrmCuEWVHcybuN28ej/d52aFmgbv
         IzAlNJwxEL6OwmmuUpBWkmZ1T5SE6vvxPEhYFzt7UJHdqLz11fomlCbQKoGMydYa3hRE
         lf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711229720; x=1711834520;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QroXftDALwHHBo/MBvbGld59w96AGtW6cgASiak20nw=;
        b=MsR8x0+h++IjuAzb3PB4j+kdY91W6cUa7uih8dUUFbCd0XC6oP5agbv0WjfvmhNCR6
         EnmlwuKJLomC5DUeVs45/Jrx+I2gqaa2rzlM5HQj6WDYPQn6pVb84Lw4FlN0urfIYIuO
         ZMK3jc5JXdwL3PYZXnpN7OpYKyOT1Ke+XOcAbMCjML2Pv3oj5p+bSmRVWThf9aVZ1tHz
         WEmT4jN1JZku73xW0rTA42epfS5Ye4CZvipbjiUTGhJoWwh736NSU5nqKD9s1N51Cd35
         fwaBln0TO0bxdlYJMSBoQD5FZ62dCj9JDwPFDwvcy88rAo9OpaYUt8wCDN0kx18n7iXG
         HicQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvoHQw4qJLa4YTJ3HOvDgbNnT/5CDv1UzHB4H2+Wl/FlUwpczrcqQaOoc0We+pydJpmEtj79mhzqiGjokhens9NKRmDeqcEZTKlzwSe6AZ2zbGwKHElVIrrV7dyshqjeXGmYfckdiifAy7QrTPR6WxrlCWG8fvVCFNkD6Q+RL11if75A==
X-Gm-Message-State: AOJu0YxtIw7Al7Ca5VhhPYGZI2IYsQ6LA3YW7zwiWLeMRVFrbkyTdEcj
	Cmjoqd4Q66rGsNJ9RoSKqUTu70GdL4sJR2SJtaz4pLT/0SSMEL2+
X-Google-Smtp-Source: AGHT+IG65g5LySY7bsvCW6f4G3I6il3q9sPRPEMKhe/b+cpW2rb2p7s1fSaP7LFoDzyzJXR2YJLvKA==
X-Received: by 2002:a05:6870:9714:b0:229:c291:bff8 with SMTP id n20-20020a056870971400b00229c291bff8mr3740190oaq.16.1711229720538;
        Sat, 23 Mar 2024 14:35:20 -0700 (PDT)
Received: from localhost ([2804:30c:1618:ed00:d152:440c:102b:144e])
        by smtp.gmail.com with ESMTPSA id p1-20020aa78601000000b006e697bd5285sm1770874pfn.203.2024.03.23.14.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 14:35:19 -0700 (PDT)
Date: Sat, 23 Mar 2024 18:35:48 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add AD4000
Message-ID: <Zf9LNPv16wsPsZA6@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1711131830.git.marcelo.schmitt@analog.com>
 <81665b5f0d37d593e6d299528de8d68da8574077.1711131830.git.marcelo.schmitt@analog.com>
 <20240323184454.201edbc3@jic23-huawei>
 <CAMknhBFRa-AwM3o-AdDDmPnwLAer8x=9TJNasSbY2bu5h9mMdQ@mail.gmail.com>
 <CAMknhBFZa4eQ1bbJQb+ESZdsbLh5xSBn+feMwmWbc58mT2UWPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMknhBFZa4eQ1bbJQb+ESZdsbLh5xSBn+feMwmWbc58mT2UWPA@mail.gmail.com>

On 03/23, David Lechner wrote:
> On Sat, Mar 23, 2024 at 3:18 PM David Lechner <dlechner@baylibre.com> wrote:
> 
> ...
> 
> > Here is what I would consider a reasonably complete binding for the
> > AD40XX chips (excluding ADAQ for now as I suggested).
> 
> I missed one...
> 
> I also think it makes sense for the High-Z mode selection to be a DT
> property since needing to enable it or disable it depends entirely on
> what is connected to the analog input pins.
> 
> ---
> 
>   adi,high-z-input:
>     type: boolean
>     description:
>       High-Z mode allows the amplifier and RC filter in front of the ADC to be
>       chosen based on the signal bandwidth of interest, rather than the settling
>       requirements of the switched capacitor SAR ADC inputs.

ok, will do the suggested changes, including provide AD and ADAQ in separate patches.

Thanks,
Marcelo

