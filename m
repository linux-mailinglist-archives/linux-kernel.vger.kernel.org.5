Return-Path: <linux-kernel+bounces-107529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246CA87FDB5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1363B22B11
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B3D5A4C7;
	Tue, 19 Mar 2024 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NfZOqev7"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A52056B7F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710852151; cv=none; b=Oh3EWO0xugjqXFta0IOKOO1m/qHrjPwl0gpWXRqbwyOrIagGkRHweu3/wyrtKbM0QBedNxq62KKq7BzvpmBx8sqpeSWzG20xOST9lQvmW3DfpU3Lmr59n39GbvConAM/qQUGHvu/07O017RaIrMsDBKhrQ/1z4K7GQ7iKa3GqI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710852151; c=relaxed/simple;
	bh=VwTqLRrw8UyvGBzeCJ+IMnGZEL6ICI6/WzUnSNK09gI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUZiKt/H73zoPMEHtTARJUaiyACeIFawtLxqgxAC0P051UjSKAHlrhZ1/e01C37e0F4hvrq1VZT4ZtnW97fIUbfNHOeDWwWVSbQAfUu8XiQq/0dAy/+qGN76bVwjqwqgz+/Y1Wpuvsz1T7xYnUb3Rvc2ZVkd0/ODm8IqIall90k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NfZOqev7; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56899d9bf52so7083181a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 05:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710852148; x=1711456948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aTCcKrDyZV/VE20k5CxghomHj3uJ8QFCRB9EkJC2C6M=;
        b=NfZOqev7NxBSGMiAtQE02zY+U9yfeeyPjOm6wpSYZ+rpjDMHf8M62q20nDUhFbs/OW
         hWZj7ApVtKgjfC/3yIxDyo57VVRPLMoviZsvjQd7qBKnw16MPKLClKVAyOwi6Bm9eXHj
         0M8zLKhDLVfwRnTVdgw2iCC3vQKuDLGQGefZHnKgCD7Xe01chXT3JC5bdIyvyQLQZsqv
         lMf29QS/5tapBb+07g+EoilAGFY3zdpm7owRRgkuo1B+Eeksz920Lv5uplkqvb514xzT
         wEic5nZSumIK9h4GQW5Qe0NgQJNPuBNfOGynVKj+nIGZU7JEeW2B1EgP1IVmtoihNdFV
         L/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710852148; x=1711456948;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTCcKrDyZV/VE20k5CxghomHj3uJ8QFCRB9EkJC2C6M=;
        b=P6ZWp1lyXKEQx2Vm1wjITowmHfqbjbp8eKOrmEusZ2GLhKKBoL399KpdtYiu5jiAuM
         czIJZn1TnFLSWVD0q+VzmeOCi5JXV+lbM5iDnsEcLHJ2VexMY79IrIiACJ60YPzD0RrN
         8WP9bViSWTxWEaQ0yRcOqpXgRQFEvnDksDJaG0V2g9Obh7N+jbA2f1fl6l0co4Eq6Itb
         96fCMSHLUjTkoQfPeOHKUKtGq60S5vEHrfGFyWEqnQou+MrxTLcJ38eDiaFUoZmuwbi0
         HT0EHzqUeZrrCKZIV9rgaNgj9vU32242wyo7CMUu1VrSnkcI78QZUJGV4ah8OK3cBg7D
         3EXA==
X-Forwarded-Encrypted: i=1; AJvYcCW+DZvlNvcOzyBFUaXf4y4VR2jSDQBa3KX8E0fOKWzFKVbiJKIRHfGdFxwswHTBOrYoJpmHt3fC/UFsFj/8hRX0iifd49tYqGUM4EQc
X-Gm-Message-State: AOJu0Yy4p9dyHNki0gClHA1rL9xeuEhb/qbE1E6ZhG5Uc17SrmjVzu3F
	guqaYVMS9avXMnbEGnh0HAu7qQvpIKWGdpPPBb8jLWyLtUaXKlcSXCybe9YYRtw=
X-Google-Smtp-Source: AGHT+IHcG/0AcklTyrIjXvHAHx/CFXgKd5Zd8KREBD0avXzjH7Ps2xKivaQv32xOCsJiS8g0t4Fq7g==
X-Received: by 2002:a17:906:794:b0:a46:da57:6ee4 with SMTP id l20-20020a170906079400b00a46da576ee4mr1535310ejc.73.1710852148534;
        Tue, 19 Mar 2024 05:42:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id ml16-20020a170906cc1000b00a4666866d02sm6060270ejb.97.2024.03.19.05.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 05:42:28 -0700 (PDT)
Message-ID: <b43f6dd8-221d-40b1-bbc9-d5f778fe1954@linaro.org>
Date: Tue, 19 Mar 2024 13:42:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: iesy: add support for iesy PX30 SoM OSM-S
To: Dominik Poggel <pog@iesy.com>, robh+dt@kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Tianling Shen <cnsztl@gmail.com>, Chris Morgan <macromorgan@hotmail.com>,
 Ondrej Jirman <megi@xff.cz>, Andy Yan <andyshrk@163.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240319095411.4112296-1-pog@iesy.com>
 <20240319095411.4112296-2-pog@iesy.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240319095411.4112296-2-pog@iesy.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 10:54, Dominik Poggel wrote:
> This adds support for the iesy SoM px30-iesy-osm-sf and the matching
> evalboard px30-iesy-eva-mi V2.XX.
> 
> Signed-off-by: Dominik Poggel <pog@iesy.com>


> +
> +	/* BB138a: MAX9867ETJ+ audio codec */
> +	max9867-sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "rockchip,max9867-codec";
> +		simple-audio-card,format = "i2s";
> +
> +		simple-audio-card,widgets =
> +			"Speaker", "Jack",
> +			"Microphone", "Mic";
> +		simple-audio-card,routing =
> +			"Jack", "LOUT",
> +			"Jack", "ROUT",
> +			"Mic", "DMICL",
> +			"Mic", "DMICR";
> +
> +		simple-audio-card,frame-master = <&cpudai>;
> +		simple-audio-card,bitclock-master = <&cpudai>;
> +
> +		status = "okay";

One more: Drop it. The same applies in all other places when not needed.

Best regards,
Krzysztof


