Return-Path: <linux-kernel+bounces-3177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E30481686B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A113B1C22501
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31545107AB;
	Mon, 18 Dec 2023 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BoPwPr7i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5D210944
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702888953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aE81s+rpsMUIps3Hpsmx+/hY64xiBrpWlJ3caeLyXLg=;
	b=BoPwPr7i5I4NyCIwnsv2BNunSYTa4wedtRNL19JwlXpZ41KStRBR5PrznOFMk64adFZFb+
	cGmAE04BvCi5Nu+oDYfJQ2tds3aCGuA8fgWnWXjnNi8a+UOMpl8BkEfnDBwTdgQzGh8YLM
	tSYLoHmAK/bhiCNXegrT2/cTVeWsGfA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-AiqSIiaDMi27z0ocbURscA-1; Mon, 18 Dec 2023 03:42:31 -0500
X-MC-Unique: AiqSIiaDMi27z0ocbURscA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40c1d2b1559so21667795e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 00:42:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702888950; x=1703493750;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aE81s+rpsMUIps3Hpsmx+/hY64xiBrpWlJ3caeLyXLg=;
        b=nMNrz9ZEBIdsOecWVLZPe+nDehvN0Amjok8bSIkvuuYjoo08G7ErDWLwQodZh6Loi3
         fkXDVuJUBqxXWKGmLQd9MkoLN1gVHLsMw4Qc0RCzW9OFuTUiGUmqLPCck4MzrNUEi1nU
         izrKzjDNgfEQl6G7b1/CqlHMZHtd7LHW9UARsh7RTNLMfWbowN2x6a0iDwOVRE8o+S8i
         y4c2BDBEgukIZtkZYRi97Sh+In1ndcN9mDYIYC0EBOhGk3WErBPIngOsTy+1y6Y32Y7d
         V2KciQmgnn/t2fB2XbuB42brFL4m98XvDAXhX+2/yOwa7+nAtuLiIgBKT43d9thpcgn/
         kSsg==
X-Gm-Message-State: AOJu0YwxSs6+RO2ft5yWWEI8ZGJlFoGdM3Mp7tulJuwa7oJ0up++miQ6
	U8JsX23KjXMvkcpFQV+8kOITfX3bZ71wZy/0Kskb4jRGZ16PtvPspvQUUfHbJR5HhETdaYSI+oP
	g5CK7ndx8iHHRViO8lJG3DU94
X-Received: by 2002:a05:600c:480a:b0:40c:5971:615a with SMTP id i10-20020a05600c480a00b0040c5971615amr4700439wmo.13.1702888949864;
        Mon, 18 Dec 2023 00:42:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDbJozhTIyhGKsrROqfZ9kJ86y/4TSXjAJ9EZdeOE+d+zYkSPgYGAJdd9a/HPYX6i0fLLHDw==
X-Received: by 2002:a05:600c:480a:b0:40c:5971:615a with SMTP id i10-20020a05600c480a00b0040c5971615amr4700420wmo.13.1702888949543;
        Mon, 18 Dec 2023 00:42:29 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u9-20020a05600c19c900b0040d1746f672sm5439115wmq.14.2023.12.18.00.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 00:42:29 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Conor Dooley <conor@kernel.org>, Rob Herring
 <robh@kernel.org>, Peter Robinson <pbrobinson@gmail.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Conor Dooley <conor+dt@kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Rob Herring <robh+dt@kernel.org>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] dt-bindings: display: Add SSD133x OLED controllers
In-Reply-To: <3d1fb191-5ef2-4569-962f-1d727c1499c5@linaro.org>
References: <20231217100741.1943932-1-javierm@redhat.com>
 <20231217100741.1943932-2-javierm@redhat.com>
 <3d1fb191-5ef2-4569-962f-1d727c1499c5@linaro.org>
Date: Mon, 18 Dec 2023 09:42:28 +0100
Message-ID: <871qbjnbpn.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

Hello Krzysztof,

> On 17/12/2023 11:07, Javier Martinez Canillas wrote:
>>> +  - if:
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
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>
> Use 4 spaces for example indentation.
>

Sure, I'll change it in v2.

> Best regards,
> Krzysztof
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


