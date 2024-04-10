Return-Path: <linux-kernel+bounces-138161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE9489ED7D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 021A4B21A35
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E2713D533;
	Wed, 10 Apr 2024 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZI01CTZq"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E660313D267
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712737442; cv=none; b=uqKMQpQfTJ913QTVomFY3B5eSiPd3tgcUkHBgGztoFgyOFQbuj+CwFVm3QSBM2y5i+0s1xVoDhX3jDiVAlQ6f94S/g4AbXe7yGwX0GOC1OKjSg3oOxyEATRk9VySxt9P7D0U3166rpi3qOV2JwbdqU20RaV4yrab+Kh8Ia+bMjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712737442; c=relaxed/simple;
	bh=EumlmUbgVFLKPplSSWjhel8lBwR32Ofh4EADYY/Z9C8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nH37wi9lxUVPvPZtY9f5oGaPvn5rtP8N+3Vc2uz9g7IfxJ7Dij/GVDb67v+LUrMLxbn3fOwbKLTDsJUTPVeZNcuPkJAX6hlBQp2m8LMDsdqJjheLcbDQ9DqVikon/fpe90vBH8yOEvWRBgMVU/+RPcoxXMd7JAshGzxIK219jHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZI01CTZq; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e477db7fbso5874517a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 01:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712737439; x=1713342239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CPSUZMqL/jT5W4hOiwjVwrvJ0udkLHPK4L0NohI+tMw=;
        b=ZI01CTZqLIBLtxuass1ktDmdIPl3sNYRw1cKbiIdJBQuovU0xtmYXL4QKLgQsFXBZh
         0ZKbTcTdPyppGbmY3hqe6y39KAK+Z43AtM8mFr7h/o//+0SC28PASruSsu8zvgLBrr/y
         irLyPGYd/xaLNl+Xph/TtfMyUqn6vMZ99hNRU3vhjyWUpW/yLvBaj3PbAg/jbDBy3fud
         dXgLC0hYfhftbK29ZQRP3B3ZJil/qdyZmaOxL0BTz3L5skFx8yF1srOziH2pOVRj9cd6
         BBqLasONj1MXCAlR2KoZAPkQ/SrzAiSaZ+EfQPsbJLNJbp9zNRsr4PRtUMl4n6O5u8bk
         DZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712737439; x=1713342239;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPSUZMqL/jT5W4hOiwjVwrvJ0udkLHPK4L0NohI+tMw=;
        b=frAQpQYtJJMWNcSI09FoS00SByMGh/pCV6LcmONtc5it0AFGcB2Np0bywS7+jGY+hK
         k1LpxoAZrWtSSj8k0lpwPsbMZCr79W8gG5pLeAfMA1/xC3WjXyVd15Le8tPSyLA1OQBv
         On8tFTxH2HURRDfZ2QOqxmkzXe+efai7SLW2/kK6KavnR50y2au1j4f62DZmZKHKJ1kq
         iYo8zRyT2kt9tspVAGqz3mhl2DnnmmuuAsVmHCtOyGl8gsllbM2WRby8e8MYUxyTy8XZ
         Xs07oIxDcu4mLRUpPPVwkVkn4laKAM911VSRg+o1V3CzlX4706edbUM1MkCL1GDKwKdl
         KP0w==
X-Forwarded-Encrypted: i=1; AJvYcCU0IiiNgyzc8QuuLpatU7zh3BhX+E8ZiTYbfl3+PdDaO3TNRICBjeU5qoXMJJcEY6H+ZvQq5BHn+Wre6t0ObyYdznyqrAfEp0EBMbY2
X-Gm-Message-State: AOJu0YygXFb1qU991QOUeEYk9AV1/fasxGKI+341ypkT+PebsJcQ2qoM
	zgP8FL7RSOhShBbwQTlhy/KtD/A6qslNrKqIE3FxRIzCxwoqxRbx0ASC4I3t3NxDax0shp239yP
	d
X-Google-Smtp-Source: AGHT+IFOamaMSYLoDQQl5mlTN4q2s30Ws1UmUdmwsgjPzCGoJ4TbEjA+VFoB1mirsY5I4CeSWVMOAg==
X-Received: by 2002:a50:a415:0:b0:56e:cde:8983 with SMTP id u21-20020a50a415000000b0056e0cde8983mr1258494edb.7.1712737439097;
        Wed, 10 Apr 2024 01:23:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id 12-20020a0564021f4c00b0056e62c8e3bcsm3232347edz.54.2024.04.10.01.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 01:23:58 -0700 (PDT)
Message-ID: <0eed83f0-5f5e-41b3-a66c-f46845ddc3a3@linaro.org>
Date: Wed, 10 Apr 2024 10:23:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] dt-bindings: display: panel: Add compatible for
 BOE nv110wum-l60
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>, sam@ravnborg.org,
 neil.armstrong@linaro.org, daniel@ffwll.ch, dianders@chromium.org,
 airlied@gmail.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240410071439.2152588-1-yangcong5@huaqin.corp-partner.google.com>
 <20240410071439.2152588-2-yangcong5@huaqin.corp-partner.google.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240410071439.2152588-2-yangcong5@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/04/2024 09:14, Cong Yang wrote:
> The BOE nv110wum-l60 is a 11.0" WUXGA TFT LCD panel, which fits in nicely
> with the existing panel-boe-tv101wum-nl6 driver. Hence, we add a new
> compatible with panel specific config.
> 
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml     | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> index 906ef62709b8..50351dd3d6e5 100644
> --- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> @@ -36,6 +36,8 @@ properties:
>        - starry,himax83102-j02
>          # STARRY ili9882t 10.51" WUXGA TFT LCD panel
>        - starry,ili9882t
> +        # Boe nv110wum-l60 11.0" WUXGA TFT LCD panel
> +      - boe,nv110wum-l60

Isn't the list ordered?

Best regards,
Krzysztof


