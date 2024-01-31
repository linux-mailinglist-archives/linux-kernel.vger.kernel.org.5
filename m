Return-Path: <linux-kernel+bounces-46001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A1B843917
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8068B23463
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E31E5DF17;
	Wed, 31 Jan 2024 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TESHtNeB"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57275C5E5
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689804; cv=none; b=FO4BNjIAV30vnVY1hKJGI9CEUGBe6xwLZCHB0L8YLGH5EN7gQVPbIw8Mc5suy6v3+Q2UFsRPGJi0aGTB83PsR6NleD4jMgizr65ntTJApQOfuePg/4cpeQLocQICuEC3t9wsbQ624VThQHO33WbH37LNsvX3Hdm1xztzyMLYhF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689804; c=relaxed/simple;
	bh=MMgAnois95dMQZI8y+adGDKSoodHSzQYOg5nGSvs3UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOYRZG7HKpJ4QwpMim19VmwE0UNR7wJ/tObsEeCAzH74sDzMpO5USwZHDQj7CElgp7q1Q+bpu+jI96A/20GmF1/76Uw51UYwyzZy/2fK9EG5qQqa2uPZZrBX0Neadm6ZAO0D4dTFG/UIvE13E+ZjwqVePmR+8UUDAabs2tBiRY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TESHtNeB; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55f279dca99so3437162a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706689801; x=1707294601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ezcPCCIAe0fcA0KIIj48VIrjnao3+w50MLkr/bJwMCs=;
        b=TESHtNeB8l7t8PrLEJEzVDwgS6MS5AHTuZBKEnUl9MOlTg4H9tFQjXbEddlj7Hrz7W
         w5Ps4i1lfn3lIVnJqINKCeGNm3ySlJASdCBcuGSZDo5bQyd7jxyVCM3/q3yEDRcj06x1
         6XkpEYIdFOKfzvSRmnO3DM8bx+0SZLQDhtf/mp0kKcETDO0AoaJGdOd5/ejCfog2D69W
         G5XpWpVuVRkWtWr3Z96mBQzaSKZe9dv0+9xfC9xJfvRI9pw2TvNwSSKD3crV1GGRtMnK
         LgL0L5Vr2p332mpYlDXxvSF1xaEB5qlcamQLwqjS5I+Soy65KaAtLPyfMXatwYOHraaw
         UyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706689801; x=1707294601;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ezcPCCIAe0fcA0KIIj48VIrjnao3+w50MLkr/bJwMCs=;
        b=CLpumJ9z/izcjKC0TG1VLZNH70K5PYNkphVr7SSAnB+NHuYbcMqZ+ss/G4ZFYJqvex
         I4rChC9CbGRJE/G5xP+Spxke9vl7ZHq5hMq3w2DDtTXi1RPh+2Lq7/tPQnI4pYMq5Tv+
         F0dHTpbxWu8OkQsChSuXQBb3CWgEXtMo0PocwZZQUfZ/PXyygYzLOQijNvhEWE3OGwC7
         dmXG0OTUn3Yy3Y6C7Z50FtZ1jUc6qiCA1VN8ZS1acgk1fzJeMr8gH//SQbPn0h3ugHJ+
         9wc4yff58kMLiBpMfmDz1j8BYf0k3MY7/qADWq3/LA9wNTuYf72KYZH1fwcqspDZgLEz
         KKDA==
X-Gm-Message-State: AOJu0YwG2LSiZpyfrtU6JFxT6FxARAOzssNedaEHNWY0e0y2hS4vBkWi
	cuvfdE7pJO0OC4dY+znkUUYyXEr701ZjrHp0WlxPE2BXAEpB9V0vIshOge/lYDA=
X-Google-Smtp-Source: AGHT+IHJKU4f29LwgIJn6IbHoSiEI8ZefbDvhr8uqXmqOeWKXP1eA7yKFr+hrwRIERelJ5ZA4cMCmw==
X-Received: by 2002:aa7:cfc1:0:b0:55e:f4fb:66f6 with SMTP id r1-20020aa7cfc1000000b0055ef4fb66f6mr488284edy.18.1706689801145;
        Wed, 31 Jan 2024 00:30:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV2m+Fm1nP2/pXHPXGW4Q5TO8+LaL1AnNfLipe7KKQ/ixqtg6pZUunT1EJGtbYLE3h6BUuKAOe3AAyUYwsoyHlG1XWXsaVPbZ6wSr8uuzwKZXQMctWS+WhJBxE7gn3+r6vUix64pcIP9td3eNvgJvrefdvNnXqsErP8HtDBb2APi5PJvclY4mPvEBHuAv8niK6xyzYHUcH6RaWpafAcCjbeqcMBTMHsbTaEDgE8ORMLDsyTHbsVbHgJu6H+8KiGIxpTLRCck6jrjJusNm1gAa5AHwbxwvrVw2M9gz3z50GKoeFCrnpTwiHi3ym3oeXIxXlyEg9J75OkgTVjT5n2Dx/InP5U
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id x6-20020a056402414600b0055d36e6f1a7sm5442819eda.82.2024.01.31.00.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 00:30:00 -0800 (PST)
Message-ID: <1c855a34-8a0d-491e-bfd2-24635b41c86f@linaro.org>
Date: Wed, 31 Jan 2024 09:29:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: iio: afe: voltage-divider: Add
 io-channel-cells
Content-Language: en-US
To: Naresh Solanki <naresh.solanki@9elements.com>,
 Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: mazziesaccount@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240130115651.457800-1-naresh.solanki@9elements.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240130115651.457800-1-naresh.solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2024 12:56, Naresh Solanki wrote:
> voltage-divider is always an iio consumer at the same time it is
> optionally an iio provider.
> Hence add #io-channel-cells
> Also update example.
> 

Fix
wrapping
and
proper
sentences. Each sentence finishes with full stop.

..
>    output-ohms:
>      description:
>        Resistance Rout over which the output voltage is measured. See full-ohms.
> @@ -75,12 +82,17 @@ examples:
>              spi-max-frequency = <1000000>;
>          };
>      };
> -    sysv {
> +    p12v_vd: sysv {

No, drop label.

>          compatible = "voltage-divider";
>          io-channels = <&maxadc 1>;
> +        #io-channel-cells = <1>;
>  
>          /* Scale the system voltage by 22/222 to fit the ADC range. */
>          output-ohms = <22>;
>          full-ohms = <222>; /* 200 + 22 */
>      };
> +    iio-hwmon {
> +        compatible = "iio-hwmon";
> +        io-channels = <&p12v_vd 0>;

The same question as for v2. Drop unrelated example.

Also, remember about rule of posting only one version per day, so people
actually have some chance to look at your patch.

Best regards,
Krzysztof


