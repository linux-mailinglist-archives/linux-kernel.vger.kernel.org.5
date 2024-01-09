Return-Path: <linux-kernel+bounces-20539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE2E828061
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE11C1C21047
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F7E14AA9;
	Tue,  9 Jan 2024 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+meWEu4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C206E25769
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704788315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ncd94wXhhDxJblqZIyWiUNiDC2N6QYCqIvUVHIfpTbw=;
	b=J+meWEu4yVRAXtXnC9NxYhRq3MelAel47tVmWYVTW+uubRghMH2inwFTj04rhkT2tZtFYY
	HB7uJSFOu6yx1oyCvT8hCuyQfJSQwQ2KRCuXyooUsXecxeVYGE1s0oOOA8VfII/JSO/2At
	XTDZZyao/p0v8Ggf1X9fpEgbVs5J5G4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-BbDg0l1vPNOMF_9iOtfE9g-1; Tue, 09 Jan 2024 03:18:34 -0500
X-MC-Unique: BbDg0l1vPNOMF_9iOtfE9g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3368c707b03so1621282f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 00:18:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704788313; x=1705393113;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncd94wXhhDxJblqZIyWiUNiDC2N6QYCqIvUVHIfpTbw=;
        b=Ozo+AjPEO2a8Kl7HKIvo3i6UK2mTX8jJsE0OP9i79tR8icR9+XqbO09Zv5rbpmHdRG
         SYMTpFCqo9UM8o+prAqUXWobGGFrxhTx+b810ScJmRQu3YM/b2Olx37Yn7Ipq056inFX
         m2CS5FOKg64yhfuRoUjVmejVWuuvvBVdcUH0PPzXSllAQa5eUUjfskZh1HkO01stX7kk
         q03Slj74160frK0vuE8GYxc52JMGaSQUVQyXbTT520OolU3p8yKt42fxGr6MLQdwwLPe
         BU2hQDPPLLC6M93y4EWAEPuP1LjTJ7Q2VrCmULqclnQzM9Oz1SBhe+IWCngmxxrkkGAy
         /dmQ==
X-Gm-Message-State: AOJu0YwB2Z8QFVwnqN8aoe0ulP7LPE2MqpQ9JBlzsujANp9nBYMMnSkR
	ckbb7trTaSzWBJBiKO6BOjx0m+EWRhtCP4kmXwZ3hF0ORt88GnzPLWYXGhFGyS7R04l9GuEdc5I
	eF0uglhgvfQG0oJmZDhdSPi7vs3yCWt28
X-Received: by 2002:a5d:594e:0:b0:336:7bd3:9520 with SMTP id e14-20020a5d594e000000b003367bd39520mr368550wri.43.1704788313415;
        Tue, 09 Jan 2024 00:18:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFr2QE7CGw84chBFdWabSEnoMFo4EBSyeKmioKe2kWujoaALuS+Y7Lsnp8SKpon/RIw+U6z1g==
X-Received: by 2002:a5d:594e:0:b0:336:7bd3:9520 with SMTP id e14-20020a5d594e000000b003367bd39520mr368545wri.43.1704788313200;
        Tue, 09 Jan 2024 00:18:33 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d420a000000b0033719111458sm1704583wrq.36.2024.01.09.00.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 00:18:33 -0800 (PST)
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
Subject: Re: [PATCH RFC v2 08/11] ARM: dts: DRA7xx: Add device tree entry
 for SGX GPU
In-Reply-To: <20240108183302.255055-9-afd@ti.com>
References: <20240108183302.255055-1-afd@ti.com>
 <20240108183302.255055-9-afd@ti.com>
Date: Tue, 09 Jan 2024 09:18:32 +0100
Message-ID: <87frz6rkbr.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Davis <afd@ti.com> writes:

> Add SGX GPU device entry to base DRA7x dtsi file.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


