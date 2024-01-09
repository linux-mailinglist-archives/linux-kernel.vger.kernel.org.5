Return-Path: <linux-kernel+bounces-20534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70652828047
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE0EAB21F5C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3141413AF9;
	Tue,  9 Jan 2024 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8HwYFsv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5334725116
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 08:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704788226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/6SvGjQzgj0djYosTjxGA3G76aXlsR8fit+b2iceA4U=;
	b=a8HwYFsvJnmRziWRNBKFeulXtL8CV8CthtUUqC5VEMWdfO3HVjaKtT7TUG/OonuwTF0BDC
	BqEeDOhfWihYPsCNIF2PankvzvYGkTano+VvT9n+7X+ABh5ohkRrxk7Mt/AB8S9Ekh9PjR
	SRiJCufDidu+ian+NXNtYaswBab7sH0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-EXq9zsfkPK28MOzsMAzEvg-1; Tue, 09 Jan 2024 03:17:04 -0500
X-MC-Unique: EXq9zsfkPK28MOzsMAzEvg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2cceb983e83so22032851fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 00:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704788223; x=1705393023;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6SvGjQzgj0djYosTjxGA3G76aXlsR8fit+b2iceA4U=;
        b=hcQ5OgRQXVDq+wJ0Zj2KmIZUFKyCiUDnV68QOY+mbTffbhmCJuTs1WxBX0HrprJAeq
         wuJf1D7K6czGrn2Bs4T0nYq88ZzrjvG2fiqRUKImy8wFyDfmJGh3s1fqlHX2vaNrjpK/
         qep1zJ7yqSb7RtEYDMrfpINOqRmKKvf0GGrfWDy1QfbkZFtQ/UgN6gA+WXryjxv24C69
         lRc2SP3QWzq6J7nLOR0IirZ7+d8kzxPfibVOi7/RFOSwUJYb37Wnobv6R3UNPfDZqhN0
         HkQJ1jbgfX4D3nkwUBm+FVYje08cL0zU5Ez83zEJZNK7DCIqClXPrknWcLNcRuH7a7MB
         dv7w==
X-Gm-Message-State: AOJu0YzfAnulWh5ef/eAOlciSWKcpYxVJ6HB358T9eZ4U1En5MvSQpGd
	7Lc6MokmeAvTWZdcq41ui1DjcFIZ5GCRay8EKZaOsSpPN5uVqj52VD6Hltgl2ggYodHOYxCu6EX
	2onTtnrEQ3pP6MeXR6JcouDAulkK5OgWs
X-Received: by 2002:a05:651c:200c:b0:2cc:eefc:20af with SMTP id s12-20020a05651c200c00b002cceefc20afmr1754472ljo.52.1704788223505;
        Tue, 09 Jan 2024 00:17:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXdSt0D2TIsDyVPefhROVCDL4qYlTpdv/7GUBf8E3u81rzcgdNCvKFp8M1MVzEIK9FSzaftw==
X-Received: by 2002:a05:651c:200c:b0:2cc:eefc:20af with SMTP id s12-20020a05651c200c00b002cceefc20afmr1754447ljo.52.1704788223210;
        Tue, 09 Jan 2024 00:17:03 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l8-20020adfe9c8000000b003365951cef9sm1701196wrn.55.2024.01.09.00.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 00:17:02 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Andrew Davis <afd@ti.com>, Frank Binns <frank.binns@imgtec.com>, Donald
 Robson <donald.robson@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 "H .
 Nikolaus Schaller" <hns@goldelico.com>, Adam Ford <aford173@gmail.com>,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 =?utf-8?Q?Beno=C3=AEt?=
 Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero
 Kristo <kristo@kernel.org>, Paul Cercueil <paul@crapouillou.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, Andrew Davis
 <afd@ti.com>, linux-omap@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC v2 03/11] ARM: dts: omap3: Add device tree entry for
 SGX GPU
In-Reply-To: <20240108183302.255055-4-afd@ti.com>
References: <20240108183302.255055-1-afd@ti.com>
 <20240108183302.255055-4-afd@ti.com>
Date: Tue, 09 Jan 2024 09:17:02 +0100
Message-ID: <87ttnmrke9.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Davis <afd@ti.com> writes:

> Add SGX GPU device entries to base OMAP3 dtsi files.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


