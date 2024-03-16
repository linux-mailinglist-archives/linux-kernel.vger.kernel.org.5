Return-Path: <linux-kernel+bounces-105285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C8F87DB69
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 21:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 726AD1F20597
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 20:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34FC1C698;
	Sat, 16 Mar 2024 20:14:44 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FBE1C68A
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710620084; cv=none; b=RLABjwumfu1beU/LDnct1faEXLNsvaylo5H98Lt650Mb8qdBzyBBg1j/OlWmaNstTnaCE9zuY9lrYgLc7UnMwtsDOsZeTLQTUeR4N7/0/Gp7hVcbW/UMQdBfpd/05xAsUnwxO6e5HcIth9u4Qa8yhwGMmYZHwk1Gu0B+g/PJJqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710620084; c=relaxed/simple;
	bh=RauXkEzmN7SZO4F1m+jEV8VKhQgNgAvhOgY28JNq/wk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKSOD5eCrsKl4Mm9YuptakCrJwZIQjid9O+49BqnMIaVdZL5o5cXKVGHNwWyMXRKYaiDJZeyz3C6cN5Q1DYgKCe6klW+A65xjRE+SCN/H8xDVK1OXwr0//DAKqzdC+ThfEbw6ioMEEYmdC6tkQvQXz99LuErTsNtEtoQgMc8QRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id cf37add6-e3d1-11ee-abf4-005056bdd08f;
	Sat, 16 Mar 2024 22:14:36 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 16 Mar 2024 22:14:35 +0200
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Syunya Ohshio <syunya.ohshio@atmark-techno.com>,
	Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: industrialio-core: look for aliases to request
 device index
Message-ID: <ZfX9qyFUPwARjCVT@surfacebook.localdomain>
References: <20240228051254.3988329-1-dominique.martinet@atmark-techno.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240228051254.3988329-1-dominique.martinet@atmark-techno.com>

Wed, Feb 28, 2024 at 02:12:54PM +0900, Dominique Martinet kirjoitti:
> From: Syunya Ohshio <syunya.ohshio@atmark-techno.com>
> 
> When using dtb overlays it can be difficult to predict which iio device

DTB
IIO

> will get assigned what index, and there is no easy way to create
> symlinks for /sys nodes through udev so to simplify userspace code make
> it possible to request fixed indices for iio devices in device tree.

IIO

> 
> For platforms without device trees of_alias_get_id will just fail and

We refer to functions as func():
of_alias_get_id()

> ida_alloc_range will behave as ida_alloc currently does.

Ditto.

> For platforms with device trees, they can not set an alias, for example
> this would try to get 10 from the ida for the device corresponding to
> adc2:
> aliases {
>   iio10 = &adc2
> };

> To: Jonathan Cameron <jic23@kernel.org>
> Cc: Guido Günther <agx@sigxcpu.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Please, make sure you don't pollute commit message with these.
Either use specific --to and --cc when formating patch or move
them into comment block (after '---' line below).

> Signed-off-by: Syunya Ohshio <syunya.ohshio@atmark-techno.com>
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

..

> +#include <linux/of.h>

What about ACPI?
Please try avoid hard to use OF-specific code for the new features.

-- 
With Best Regards,
Andy Shevchenko



