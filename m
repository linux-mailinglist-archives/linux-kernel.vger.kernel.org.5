Return-Path: <linux-kernel+bounces-2824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F401816275
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3DF6B21564
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B3F495CF;
	Sun, 17 Dec 2023 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHOHstT1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA1948CDC
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702848809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Umdjp5ksoy+JcwUTo/e1T9qvEs+1ox676Cz4ZgwJJjU=;
	b=SHOHstT1tamlcva9iBgqjuihlGiz37H5hrt2r+T1OMLTDFDnvv9l0w5Ux+OYtA3dw4r94P
	KXerQN5lkFJKLoT9JGl3CmdbuXoBwBi5LF/y8aLLfWjFawWzXr+Guq0r5tyIf1CHqpjwKk
	5CNr1dW/LrOnzhiULk5eCGyxH3zio5I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-LXd3UlW8OTSsCaHBAvSbkw-1; Sun, 17 Dec 2023 16:33:27 -0500
X-MC-Unique: LXd3UlW8OTSsCaHBAvSbkw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40c6397d9adso21900915e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 13:33:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702848806; x=1703453606;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Umdjp5ksoy+JcwUTo/e1T9qvEs+1ox676Cz4ZgwJJjU=;
        b=XYZcvLDF15ls+xGFBK2FGYUYbVLbmghaxeViqy18Jaf24hqRmRNCpDkTSEE5qMxTJl
         4JuFaGmGXUDceGvsYLNbD6ikMAoS9TrXe3Pf6NCFJiUWW8E3HPVnQN6o0k0q+t285U7m
         X/r9HKUQEffUQvfgVZZpXlW+MpUK5Y32152qfEugYCJ7vbKmcStaJu7oqNXHRulzYehp
         la2QDQYjpWRHP+sg8KPm8bO215SeUAcvgzSKrxf6d9i61CsQPvg4IBEznGbO1U5WnsjP
         J6d4qzSBbykcIreJOQEVtwAeapcRs2Dvzp+0Gfi8tYvNdfcY2/W/nDByYYxQVFbyxH0R
         Rw5w==
X-Gm-Message-State: AOJu0Yz1hyy7optbmXQqGgkHdfYk04EzoAZWc2Nf0A+dpGgwoxcUuLzv
	0P5CoEhOtG4SHbrvq6cShTEgaB3cMy8SqLoRG0ugBdRNnzNeq4L3ITgpT22HkdwRTcr+AsYQYwD
	Hy4ojYpyax12OgX0EOnaDZKyAx7ZE61I7
X-Received: by 2002:a05:600c:3403:b0:401:daf2:2735 with SMTP id y3-20020a05600c340300b00401daf22735mr8294556wmp.31.1702848805785;
        Sun, 17 Dec 2023 13:33:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElsMH/e3AuKVnouRvSQ1+tNGmbnVzX8Ok7/pjwFuDcho/tdFgjioZuOMxwPzVueDgH+cCPnQ==
X-Received: by 2002:a05:600c:3403:b0:401:daf2:2735 with SMTP id y3-20020a05600c340300b00401daf22735mr8294553wmp.31.1702848805410;
        Sun, 17 Dec 2023 13:33:25 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e12-20020a05600c4e4c00b0040b398f0585sm39872880wmq.9.2023.12.17.13.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 13:33:24 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, Thomas
 Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, Peter
 Robinson <pbrobinson@gmail.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Conor Dooley <conor+dt@kernel.org>, Daniel Vetter
 <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Rob Herring <robh+dt@kernel.org>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] dt-bindings: display: Add SSD133x OLED controllers
In-Reply-To: <20231217-bacteria-amusable-77efb05770a4@spud>
References: <20231217100741.1943932-1-javierm@redhat.com>
 <20231217100741.1943932-2-javierm@redhat.com>
 <20231217-bacteria-amusable-77efb05770a4@spud>
Date: Sun, 17 Dec 2023 22:33:24 +0100
Message-ID: <87fs00ms4b.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Conor Dooley <conor@kernel.org> writes:

Hello Connor,

> On Sun, Dec 17, 2023 at 11:07:03AM +0100, Javier Martinez Canillas wrote:

[...]

>> +properties:
>> +  compatible:
>> +    enum:
>> +      - solomon,ssd1331
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +allOf:
>> +  - $ref: solomon,ssd-common.yaml#
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: solomon,ssd1331
>> +    then:
>> +      properties:
>> +        width:
>> +          default: 96
>> +        height:
>> +          default: 64
>
> Do you envisage a rake of devices that are going to end up in this
> binding? Otherwise, why not unconditionally set the constraints?
>

Because these are only for the default width and height, there can be
panels using the same controller but that have a different resolution.

For example, there are panels using the SSD1306 controller that have
128x32 [0], 64x32 [1] or 128x64 [2] resolutions.

But answering your question, yes I think that more devices for this
SSD133x family are going to be added later. Looking at [3], there is
at least SSD1333 that has a different default resolutions (176x176).

I think that even the SSD135x family could be supported by the same
modsetting pipeline, but I need to get one to figure it out.

[0]: https://es.aliexpress.com/item/1005003648174074.html
[1]: https://www.buydisplay.com/white-0-49-inch-oled-display-64x32-iic-i2c-ssd1306-connector-fpc
[2]: https://es.aliexpress.com/item/1005001582340858.html?gatewayAdapt=glo2esp
[3]: https://www.solomon-systech.com/product-search/?technology=oled-display

> Cheers,
> Conor.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


