Return-Path: <linux-kernel+bounces-88162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A03F286DE0B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41235B2533E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B07B6A356;
	Fri,  1 Mar 2024 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqGGa5EU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57D66A33F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284785; cv=none; b=MWlsNA5qnbTR+nH4TbPiOyV7olMU5znohjDEvgskeMqX1cv4xYN31+2dTlQjUDDVG5egjyjKoIvAz0SdSMSRGSW9IZ9tBK244m1jB16WJ57GsFQv2B+LmsR/5uQwTLB4aDgl/MhyDLkB3OEfnXZf0ZNYfGOyDAYrfBA8nrtPCD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284785; c=relaxed/simple;
	bh=JqsVIGDlCP1wu/pwYjBj+DhvFfWoXCVCb65NYnp1sO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rP+MSTv5D30LqC0DvFGdLMd3dkv6Nxo/nQHhBgQEUh/Y2voWjgpnB/Tb5atoxjcoHDB3NVao0V1GikQvp46PQaj9yMDSQY9GLcvhYhAU+0XO9uHOjTaa+Mxa+7MDIuYyFdYA+3/DFmH2+GyMMOsLNXJo1C8TMjlazVHOHO/Xgfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqGGa5EU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16522C433F1;
	Fri,  1 Mar 2024 09:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709284785;
	bh=JqsVIGDlCP1wu/pwYjBj+DhvFfWoXCVCb65NYnp1sO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bqGGa5EUE0/3CibnOgppDLmpuYqEQPjTBEImGJd7cTJvuHSrR5AHjykaMbDMUnf13
	 tsHdbyXJs8qt3WWB29PhJY3qpddr/0HewC1/GIGUutQG0PLZw8JVi4JdddjRh/6HEt
	 IECxRiDvK9A02dYiYs4GvLZxE8Adi9D6jgUby9BXd/QwGB2fl6GncOt0BDertQ5YEY
	 AhCeKKj4lIfYY6bhhtoGYRhq/d8ZtBj3gWAEjJg9WmoRog5HwVfkSfjT/noECTJjSF
	 LyFDVSxDhTjypqeHIcTGnYsUYw7BF7yuz279ydc3h8LxcixJRFPR8M6B4kVTL6IuoT
	 9uLNTuV1jt+pg==
Date: Fri, 1 Mar 2024 09:19:38 +0000
From: Lee Jones <lee@kernel.org>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: sam@ravnborg.org, bbrezillon@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hari.PrasathGE@microchip.com,
	Balamanikandan.Gunasundar@microchip.com,
	Durai.ManickamKR@microchip.com, Nayabbasha.Sayed@microchip.com,
	Dharma.B@microchip.com, Varshini.Rajendran@microchip.com,
	Balakrishnan.S@microchip.com, Charan.Pedumuru@microchip.com
Subject: Re: [PATCH v9 2/8] drm: atmel-hlcdc: Define XLCDC specific registers
Message-ID: <20240301091938.GB1688857@google.com>
References: <20240301052534.38651-1-manikandan.m@microchip.com>
 <20240301052534.38651-3-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240301052534.38651-3-manikandan.m@microchip.com>

On Fri, 01 Mar 2024, Manikandan Muralidharan wrote:

> From: Durai Manickam KR <durai.manickamkr@microchip.com>
> 
> The register address of the XLCDC IP used in SAM9X7 SoC family
> are different from the previous HLCDC. Defining those address
> space with valid macros.
> 
> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
> [manikandan.m@microchip.com: Remove unused macro definitions]
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h | 42 ++++++++++++++++++++

>  include/linux/mfd/atmel-hlcdc.h              | 10 +++++

Acked-by: Lee Jones <lee@kernel.org>

>  2 files changed, 52 insertions(+)

-- 
Lee Jones [李琼斯]

