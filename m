Return-Path: <linux-kernel+bounces-20537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 263B7828057
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34C001C23ABC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19BD1E504;
	Tue,  9 Jan 2024 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYdhY58D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90122575A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 08:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704788283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P/n6bIUbxiGj6HkflcqkLH0/hS7ErA/FC9bHCDvM3UU=;
	b=BYdhY58DuHjmJ7Qk47tXkTk7z8igHZnFm7JT05zHRvq/1rZUStwwmrCq5c8o0MoZI9Iwd+
	GeZaV2LaeEB474EhUjWo/K5M7MvDrNW22H9103LcwBlkOUIDXcsRYvtbnmUOXwA/w2dtyt
	ZjIF9aKMjdmYrYsJO9onUPCWE4XhlRk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-HnDMuKvqMo6sTfENUogH0A-1; Tue, 09 Jan 2024 03:18:01 -0500
X-MC-Unique: HnDMuKvqMo6sTfENUogH0A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33693a2dae7so1557112f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 00:18:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704788280; x=1705393080;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/n6bIUbxiGj6HkflcqkLH0/hS7ErA/FC9bHCDvM3UU=;
        b=Rhkfk3lHC3RcJUXfiQUps+tjzBAJIUg/uRRdtZAcVWHkQ7y99Cy5M/cil6H0amKCVT
         SNt9egciNuHQBUTqzqcZ6FyacTjTK0dkpxdV/FiKG3eQHS2r2Vx4QxNixvxO9uebslR4
         Nmb8VlVcdPoIhjDazx/2xQtrJTm0rF24xGeE/zwOWET6Q3qlkq0GxOE1085xtEEnMQlI
         vF82fwZ3tAMAU8yB4zkeJPwEyUaxyDMJayZggI2sYOLpzHEjxQPkZiqwi7aL3y91NxV+
         EIHAkf66/W40hUDqQAKBa+jSHdtxVS4BQyrKvDKl5iCEtbVo3O39H/x7+W+reXVBIsRq
         240w==
X-Gm-Message-State: AOJu0YyUQLzUmVOhEBOgVKQb5fp6xqFNcsIGtwpSalPsSommKhYAu8xE
	Z/b5PpxA4T7oqAynfZ5a2+ETXDOLmv5bgoELfPBTuGNVTvIe4LUQsAd6sUtmyOjtAKOdjYGmt/N
	GPlUFGIsPL2z6Lo9cqMhauRspxfJbkQte
X-Received: by 2002:a05:600c:3b8d:b0:40e:5136:9c1b with SMTP id n13-20020a05600c3b8d00b0040e51369c1bmr141956wms.171.1704788280599;
        Tue, 09 Jan 2024 00:18:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFC/CVCQxxwutC14ngh1OLfN28XsPAOZa3F7Km+RhSKTaEmlH4ND2gHIL5o1B6PeT/ovdJFSg==
X-Received: by 2002:a05:600c:3b8d:b0:40e:5136:9c1b with SMTP id n13-20020a05600c3b8d00b0040e51369c1bmr141937wms.171.1704788280323;
        Tue, 09 Jan 2024 00:18:00 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c444a00b0040e486bc0dfsm5117272wmn.27.2024.01.09.00.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 00:18:00 -0800 (PST)
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
Subject: Re: [PATCH RFC v2 06/11] ARM: dts: AM33xx: Add device tree entry
 for SGX GPU
In-Reply-To: <20240108183302.255055-7-afd@ti.com>
References: <20240108183302.255055-1-afd@ti.com>
 <20240108183302.255055-7-afd@ti.com>
Date: Tue, 09 Jan 2024 09:17:59 +0100
Message-ID: <87le8yrkco.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Davis <afd@ti.com> writes:

> Add SGX GPU device entry to base AM33xx dtsi file.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


