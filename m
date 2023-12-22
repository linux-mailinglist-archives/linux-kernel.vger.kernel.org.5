Return-Path: <linux-kernel+bounces-9549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC3981C760
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2933A1C22EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8035BF9D6;
	Fri, 22 Dec 2023 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRktAxtP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6915BDF55
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703237821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0rE+6SqYmdQ/CRPQV0bbXUUkHoWDG8BiCqsyya24uec=;
	b=NRktAxtPB8N//xeecBQM7XbQ3Gsms/S4ixweqUQgW6OC/PFBkL89DSM90cbbHybbYmV+vS
	a1HWpmvA0n9EhbpJJ55F3+TWtxfRIOYMYl0ByF3YJxVIqMRdxftrsxuSvor8TbcRIP+rKD
	fO09gqBvyWwbdLxhUcpb0788d40fRlc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-wmgBWaQ0MT-cmbe7pZnFKQ-1; Fri, 22 Dec 2023 04:36:59 -0500
X-MC-Unique: wmgBWaQ0MT-cmbe7pZnFKQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40d44d9dae3so4460655e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 01:36:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703237818; x=1703842618;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0rE+6SqYmdQ/CRPQV0bbXUUkHoWDG8BiCqsyya24uec=;
        b=MKYZt4Ixz34Rl15QgnKMJ5WA9vaUx04hYNRH/N/jld0l8iKQWwDECrrMS+tcZK9EUf
         flg3TBPyfcGmOwD5nggTIw0YZm/VEUsovQ+YWVn5QVyE0MiscTH9oyIY0NI+wwDNg4Ve
         JdxUZcbal8/XW4pjs2u16ZL2BfK5xgnUFxoMvXpru5IofBW8G94nHflLQUQxtLT2H/0d
         fW/HWPlmZRH7Od0uX7ti0ZBcCwjGZOnxun2ltZ8aTYfhzfRJo97YbGsD3S/ya4g1qkjy
         cDt4jdmqA5FilQMcSCycf0w9SoMAyFnh0YTZbsPClP65Qx0H9vo6BvoyfayWnDaHJTLT
         ix/g==
X-Gm-Message-State: AOJu0YwWyijLFrUmdHDcW+Ub6WNagxMcKBaBMkHc6HSa4S3uGEVKTMW+
	cuKnWAk6lks32A8CFAPo9UPEyrpWHo/OIQ1NDJZ24KF0xiFAiGJqzKySDdsfaIP38lC1MBwnFMg
	NtbEtPucK21Kn3m5X21q25ZZy4LzjVJLY
X-Received: by 2002:a05:600c:3583:b0:40d:2dd8:9308 with SMTP id p3-20020a05600c358300b0040d2dd89308mr552526wmq.142.1703237818267;
        Fri, 22 Dec 2023 01:36:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECzHuOIWaFBlkppPB6Nj0W46ZDmLz/rglzaycn8jOElInECwnxTZnHavxqH0t2LiMt4tvbyw==
X-Received: by 2002:a05:600c:3583:b0:40d:2dd8:9308 with SMTP id p3-20020a05600c358300b0040d2dd89308mr552512wmq.142.1703237817912;
        Fri, 22 Dec 2023 01:36:57 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b0040b48690c49sm6267412wms.6.2023.12.22.01.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 01:36:57 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Maxime Ripard
 <mripard@kernel.org>, Peter Robinson <pbrobinson@gmail.com>, Rob Herring
 <robh@kernel.org>, Conor Dooley <conor@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 4/4] drm/ssd130x: Add support for the SSD133x OLED
 controller family
In-Reply-To: <01cc7bd1-25d8-43ad-a305-05fcc81bfd22@redhat.com>
References: <20231219203416.2299702-1-javierm@redhat.com>
 <20231219203416.2299702-5-javierm@redhat.com>
 <01cc7bd1-25d8-43ad-a305-05fcc81bfd22@redhat.com>
Date: Fri, 22 Dec 2023 10:36:56 +0100
Message-ID: <87y1dm4lzb.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jocelyn Falempe <jfalempe@redhat.com> writes:

Hello Jocelyn,

Thanks a lot for your review!

> On 19/12/2023 21:34, Javier Martinez Canillas wrote:
>> The Solomon SSD133x controllers (such as the SSD1331) are used by RGB dot
>> matrix OLED panels, add a modesetting pipeline to support the chip family.
>> 
>> The SSD133x controllers support 256 (8-bit) and 65k (16-bit) color depths
>> but only the former is implemented for now. This is because the 256 color
>> depth format matches a fourcc code already present in DRM (RGB8), but the
>> 65k pixel format does not match the existing RG16 fourcc code format.
>> 
>> Instead of a R:G:B 5:6:5, the controller expects the 16-bit pixels to be
>> R:G:B 6:5:6, and so a new fourcc needs to be added to support this format.
>
> small typo here, R:G:B 6:5:6 => that's 17 bits
>

Oh, tanks for pointing that out.

It seems to be a typo in the SSD1331 controller datasheet itself:

https://cdn-shop.adafruit.com/datasheets/SSD1331_1.2.pdf

"Each pixel has 16-bit data. Three sub-pixels for color A, B and C have 6
bits, 5 bits and 6 bits respectively."

I blindly copied what the datasheet said without relizing that it was 17
bits indeed!

So looking again at "Table 9 - Data bus usage under different bus width
and color depth mode" in the datasheet shared above, it seems the format
has the same sub-pixel layout than DRM_FORMAT_RGB565. But I tested with
that format and the colors were off, and the same for DRM_FORMAT_BGR565.

Now, even when only using 256 colors the images are pretty decent as you
can see in https://fosstodon.org/@javierm/111591985174504541

I'll reword the commit message and drop the comment about that RGB format
and explain that only DRM_FORMAT_RGB332 is supported for now.

> other than that, it looks good to me, feel free to add:
> Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


