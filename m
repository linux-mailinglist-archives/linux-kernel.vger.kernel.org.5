Return-Path: <linux-kernel+bounces-91618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEC487144A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC250B231FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0902374FD;
	Tue,  5 Mar 2024 03:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wTMaOrkX"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401F329CE9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 03:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709609415; cv=none; b=BuTLz4gVVzAAqty4cMU1dy1rmtQJgcvXFswG0E8R4BNdm7XrdL/jq9z6E8OmjlpADEOPo5xCbIUJZaBS3b7CTlQUiIhYDfGDykp27bkIhohzqfhm01eoK1plUMfTgjJemEAOD78i0hXJAIxSGyaAmIJmaNKNHfep4TFHLPgBtQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709609415; c=relaxed/simple;
	bh=x+8+K2qySjfkPk6lcfU2NdlBqQWp2ozhHbiL2ganmLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pbTfTfo4vBlds0abPuX2mjX7YmFinE8Ov13zSfzI1ZOfanJubV2D5cK6LZueBQn+euT0VGC2/2StFmaqdhowSZe03EoH+RbwDqRRU/3VT3xTbS7DXpcEl2lcanmyQxoyKZly3lw0p9uhL6/SFefOQTAPP/joHplPoH4BP0rUmnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wTMaOrkX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=QZ3W4z58IooHaAxA8YZpZxc7aOB5iVQu5qY45wja7mY=; b=wTMaOrkXj2P9HGABDzqJSFQ+uJ
	bMKQC/V5qTAwsuy5ogvT86+l1P+vT4kWzwSSXQv++yLRcuc6CCk4Df+dumNmdO7jiYBHUsk4Qh/g+
	CFnDBiQdTEA/UMVACn1l8uFq2cGvH1hrHR2X3EVxZIm2/lDYBvs3KmFJ/XKGPtVOHbqiWpTAcwlKX
	D4SMox0VZccZWUIDlAgUz+M3QwP/DJ38rSfTA3cUZTpWTsVeN9i3Z0d8YGx9I+59zFgF5TV51q39+
	eyfJe98Kvh2E4FPPuTLLm/ZX1IUALnGIVB2ETV+UaFvgXytctPZFqmlnhMRmAe4YbMSUzqvU6WUn3
	qk3ePa/Q==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhLVL-0000000BhjS-2FQP;
	Tue, 05 Mar 2024 03:30:11 +0000
Message-ID: <65928197-1a97-4606-bc68-867e8590c6f5@infradead.org>
Date: Mon, 4 Mar 2024 19:30:08 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Removed funcs field description for kernel doc warning.
Content-Language: en-US
To: R SUNDAR <prosunofficial@gmail.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240305024857.12783-1-prosunofficial@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240305024857.12783-1-prosunofficial@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 3/4/24 18:48, R SUNDAR wrote:
> /include/drm/drm_gem_vram_helper.h:185: warning: Excess struct member 'funcs' description in 'drm_vram_mm'
> 
> Signed-off-by: R SUNDAR <prosunofficial@gmail.com>

or
https://lore.kernel.org/lkml/20240204145348.56924-1-agarwala.kartik@gmail.com/
or
https://lore.kernel.org/lkml/20240106032957.1195-1-rdunlap@infradead.org/


but in any case I would like to see any one of these patches
merged. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  include/drm/drm_gem_vram_helper.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
> index e18429f09e53..c89c9bafeb44 100644
> --- a/include/drm/drm_gem_vram_helper.h
> +++ b/include/drm/drm_gem_vram_helper.h
> @@ -170,7 +170,6 @@ void drm_gem_vram_simple_display_pipe_cleanup_fb(
>   * @vram_base:	Base address of the managed video memory
>   * @vram_size:	Size of the managed video memory in bytes
>   * @bdev:	The TTM BO device.
> - * @funcs:	TTM BO functions
>   *
>   * The fields &struct drm_vram_mm.vram_base and
>   * &struct drm_vram_mm.vrm_size are managed by VRAM MM, but are

-- 
#Randy

