Return-Path: <linux-kernel+bounces-3910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B845A817503
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88EE28910A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEBC3A1D0;
	Mon, 18 Dec 2023 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FmKuHFi3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2F73A1C7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702912518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HuaiH4rqzFFEALDPC43fTJimMBRbpfVpYg9fBcqQC3E=;
	b=FmKuHFi3+cKNlIX+cYGi65rAoRhjWHVhshVl6FtpmA8BimzxyE0RWishQTmm3Kw8D3Jdfv
	jF57FzxDSC4CsEvme/HmtoCWuVJor+5lZTJZdqrTp/YQ/dzkhcmzj0JXMkwAdBQcBXnH+v
	lSrmG4WlUjFaZVd+KCQ/o0nqmzSTIfA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-A3NHCe_RNjqur2n_xBsgjQ-1; Mon, 18 Dec 2023 10:15:16 -0500
X-MC-Unique: A3NHCe_RNjqur2n_xBsgjQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40c3cea4c19so29120525e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:15:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702912515; x=1703517315;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HuaiH4rqzFFEALDPC43fTJimMBRbpfVpYg9fBcqQC3E=;
        b=nwt6b2cVzsolv/g4lYQoyL0HnVdQwHib+AmH9VOaot8s7BKiskIKqSjkOYiLLDMonw
         Wupya1rh75/qVNihgylAIGagYS3M0peJX8zloHIi5pBnmHuu07OQOnmV3Xuo9QicBrvr
         i2WIZNBbax1q3tyL2MJT323JqvW78mk5Zp4QuPko0rHjdjvyT/pAxkCwzCLGN/SwMOqV
         levpb2VV0ni4okD0OrnyrWMvgs8NCqQf8K+ROHx1DxXGEXnrkZ1dhqaSbUauiOVqBVF6
         ZkaLT4Yh0r06+pwG/a7wzS9hpvzLs0mygzEbefJ84HR52RCvbTCnjlhQ/DyPPoPqMGlx
         pl+g==
X-Gm-Message-State: AOJu0YwSkkRSVIe8G0W0olZz8xPVLLkhpn69wdRnAqAI8mUUlV4vJYHm
	2ZoTFGdD4eFeIpbTrnroA/dQV7LUdUh3Gq0nSr5iuy0EkV15CmpBkvVH9PD67Owyx9O/nzW+Rd9
	cEw2e629VkJ3Jk5ZDvn3ueunH
X-Received: by 2002:a05:600c:3146:b0:40c:3e7c:9e45 with SMTP id h6-20020a05600c314600b0040c3e7c9e45mr7221898wmo.179.1702912515186;
        Mon, 18 Dec 2023 07:15:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH01NYRqs0cLPJmrbSp3Nv2uqyGIyLK81ZTxxjSLq4MH5WQAhaSsNI+INBXpQtGjJJeLQo86Q==
X-Received: by 2002:a05:600c:3146:b0:40c:3e7c:9e45 with SMTP id h6-20020a05600c314600b0040c3e7c9e45mr7221888wmo.179.1702912514806;
        Mon, 18 Dec 2023 07:15:14 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id a16-20020adffad0000000b003366fa08c2dsm41371wrs.83.2023.12.18.07.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:15:14 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Jocelyn Falempe <jfalempe@redhat.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Thomas Zimmermann <tzimmermann@suse.de>, Peter
 Robinson <pbrobinson@gmail.com>, Rob Herring <robh@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, David
 Airlie <airlied@gmail.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Rob Herring <robh+dt@kernel.org>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: Add SSD133x OLED controllers
In-Reply-To: <20231218-example-envision-b41ca8efa251@spud>
References: <20231218132045.2066576-1-javierm@redhat.com>
 <20231218132045.2066576-2-javierm@redhat.com>
 <20231218-example-envision-b41ca8efa251@spud>
Date: Mon, 18 Dec 2023 16:15:13 +0100
Message-ID: <87plz3leym.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Conor Dooley <conor@kernel.org> writes:

Hello Conor,

Thanks a lot for your feedback.

> On Mon, Dec 18, 2023 at 02:20:35PM +0100, Javier Martinez Canillas wrote:

[...]

>> +
>> +  - properties:
>> +      width:
>> +        default: 96
>> +      height:
>> +        default: 64
>
> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd133x.yaml b/Documentation/devicetree/bindings/display/solomon,ssd133x.yaml
> index 8feee9eef0fd..ffc939c782eb 100644
> --- a/Documentation/devicetree/bindings/display/solomon,ssd133x.yaml
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd133x.yaml
> @@ -9,24 +9,24 @@ title: Solomon SSD133x OLED Display Controllers
>  maintainers:
>    - Javier Martinez Canillas <javierm@redhat.com>
>  
> +allOf:
> +  - $ref: solomon,ssd-common.yaml#
> +
>  properties:
>    compatible:
>      enum:
>        - solomon,ssd1331
>  
> +  width:
> +    default: 96
> +
> +  height:
> +    default: 64
> +
>  required:
>    - compatible
>    - reg
>  
> -allOf:
> -  - $ref: solomon,ssd-common.yaml#
> -
> -  - properties:
> -      width:
> -        default: 96
> -      height:
> -        default: 64
> -
>  unevaluatedProperties: false
>  
>  examples:
>
> The properties stuff doesn't need to be in the allOf. Although, I took

Ok.

> the opportunity to look at ssd-common.yaml. How do the height/width here
> differ from the vendor prefixed versions in that file?

Oh! That is an error in the schema that I introduced when adding the
binding for the SSD132x family in commit 2d23e7d6bacb ("dt-bindings:
display: Add SSD132x OLED controllers"), and I just copied it to this
binding as well making the same mistake...

I'll fix that with a preparatory patch to use "solomon,{width,height}"
everywhere in v3 and also include your suggested changes for this patch.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


