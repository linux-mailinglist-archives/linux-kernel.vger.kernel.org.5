Return-Path: <linux-kernel+bounces-129462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D972896B21
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEB311F26A2B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67851350CC;
	Wed,  3 Apr 2024 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AQbymm3+"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D7B1350D0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138111; cv=none; b=L5dRDw6lSr0OwdDBK1hbP1z+vTW3TDotGusVu0zVR/u54dowfbD/r06s4nDRKAtZqF9UA8CW9jsd60NcQ5fwH8CwthioUTOG4pIac5br/m8B9elMnBEk1SHEEmMXQo0JGcOjzvFWVQ5npl6DC7XkBUGorGj+O6srJ3H7GmC8GV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138111; c=relaxed/simple;
	bh=XhIoISbb6jkXxx7mCbSQi1uT0uQRKzY+oGNhBdb0ouA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWlnVRR1C+I+6NkKBXC+YfbiCGXXXmzbd/foq3OjfnMUVVj3eEqYtSSdrty/XdsNoQi+SrE2FrR60Pct0l87gDW5Dzm0w7DYM+VWj6+Ngn8MbpTjaw0+I/7bzDKD77/9VgJYEXuzM3UFA4JO6GkHquydebih7PmDPtg2GiB7ZrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AQbymm3+; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56c404da0ebso8946490a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 02:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712138108; x=1712742908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LwshzO3TQu4dUqZI02YeauZwBjbBVz3srjF4haSFM6I=;
        b=AQbymm3+97qPnNqNDpBPgPvQIZ/7sK5FQnOHiLVMKBOZ6xeI7PDXBjYYKJgrgYIeTO
         FHDkWYqVbLdD6oryk6t+xY+C9uq21MM4l3IvPX7AU8Ld/LaeszVPEBSSk4vNTktVlItJ
         JqfZ/4nfEANZZhqyqo7Y44A/xJozIohOvNHZQ8PtIRv2uKrbD+pD+Xhce4okVmlA8ufl
         P8bq3gfdMuOEBNq0lODIIw3SVrbn49TObu+B95AjxSIdDWs1r1na1muqAUoWnuOUREyO
         QiNLDWWh4AYIHSaLpQJ9rxPI5DKiqmVyLtrWgeCq91AHsBRRw+rQC+buehBG/8llOF/F
         aO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712138108; x=1712742908;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwshzO3TQu4dUqZI02YeauZwBjbBVz3srjF4haSFM6I=;
        b=U+Yc7EDgCBKybVUa4Mvyd+EItnVUxSZKz/oErGNdfpf9YiY0Lwc8z3oRGUEM7AbED/
         /iSzKeu5xGm7awDM+eKzl9K9vrGtsq2NlbdJb8UPdxjvJHMqBCNTQm1ivrjmhsslIxI4
         UBcUEVmDvD1k++5xFTwPSWOnMRkNEgMo6E96JWpkk5kzSI+zod+ksy9EIpKG5R3p1mMm
         0IhOdfY4BJpRjqzeC0l811Zcvt0Xr5uXqQk1rgOm0CYGan9z8KHql8ui/bwnNwtWysZS
         7gSyK4g07EH/3++gaoqMnNZDmY/ybmfEWXyk4j78cS0G3L9TfsVjREBQunefFXG4LJqM
         W8PA==
X-Forwarded-Encrypted: i=1; AJvYcCVwO11a+kjd1v3AbRtjrJ4Er+SxT5CudSQRraHddD1HDnT/uVjWahGOMHgKtHu1n3WOz0jmY4apLbxxM6HSpINya4YOZe0C7e00imxp
X-Gm-Message-State: AOJu0YzYZvgLJnAKOPu1vHdRO7bGmPlNQ3k4+8NbA8eOvGKwbrV4Vsjq
	Fxszs7ezi+SIuT6hcPoqrFapgZa7jhgtWXjfHXuQDJqMdrkLWdnUun+/cvG0YBA=
X-Google-Smtp-Source: AGHT+IE18ppznA1IOkAq3MPxNHqMgIB/7rvjOKGki2vrOOXMspoNFfdmE3n52z0EJXKBE04hz7qy2g==
X-Received: by 2002:a17:907:94c5:b0:a46:cea5:5e7e with SMTP id dn5-20020a17090794c500b00a46cea55e7emr12926687ejc.52.1712138108403;
        Wed, 03 Apr 2024 02:55:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id dp12-20020a170906c14c00b00a473a1fe089sm7589683ejc.1.2024.04.03.02.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 02:55:07 -0700 (PDT)
Message-ID: <e9aefdcd-5ee7-4b19-847e-5fb3d95cf46c@linaro.org>
Date: Wed, 3 Apr 2024 11:55:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/34] iio: ad5755: hook up of_device_id lookup to
 platform driver
To: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-17-arnd@kernel.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240403080702.3509288-17-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/04/2024 10:06, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When the driver is built-in, 'make W=1' warns about an unused
> ID table:
> 
> drivers/iio/dac/ad5755.c:866:34: error: 'ad5755_of_match' defined but not used [-Werror=unused-const-variable=]
>   866 | static const struct of_device_id ad5755_of_match[] = {
> 
> While the data is duplicated in the spi_device_id, it's common
> to use the actual OF compatible strings in the driver.
> 
> Since there are no in-tree users of plain platform devices, the
> spi_device_id table could actually be dropped entirely with this.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/iio/dac/ad5755.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
> index 404865e35460..5c1e7f428c25 100644
> --- a/drivers/iio/dac/ad5755.c
> +++ b/drivers/iio/dac/ad5755.c
> @@ -876,6 +876,7 @@ MODULE_DEVICE_TABLE(of, ad5755_of_match);
>  static struct spi_driver ad5755_driver = {
>  	.driver = {
>  		.name = "ad5755",
> +		.of_match_table = ad5755_of_match,

I was working on this as well and have a bit bigger solution, following
Jonathan's preference (I think):

https://lore.kernel.org/all/20240226192555.14aa178e@jic23-huawei/

I need to send v3, somehow I missed his comments.

Jonathan,
Do you want me to still work on this according to your comments (which I
missed, I am sorry).

Best regards,
Krzysztof


