Return-Path: <linux-kernel+bounces-83067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49879868E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C21286292
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175691386D3;
	Tue, 27 Feb 2024 10:52:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BE61386B2
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031136; cv=none; b=huqwk/7OGORDc/+gzhLFQQwUfhwsM5LnVrp56XcReJLp03K+Pnncn3tZDhJ6+xwklB6DQ9LaBCCB8hLh1FVzadTgTRJQZEb8LFVKwDKC2DQ5R2mgQj5RPLNYaX/dYs3DlwKuD8ERwm3Be06x1tnmEu+EC+eXwsjnKrKqY0dF42A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031136; c=relaxed/simple;
	bh=xRRex4Qi0WZQQ6T01jIh2u/+oAWLUpko8So4AoPz76Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvE6XDI95mnIumr9vxeYnau1W2J+xaxwSym49t+YWetk3oL+zbE7SN5uniR62DEnZuUDXg986/ehVscUTI9qSdB1WxqdDcQBxlVcB8zCSLNfiGqqwi3DLl6SYhSB74ENMgEVez/dnov74Hqrw5LxVtjpNILbd7Q21vKfQ66xQ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92D79FEC
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:52:52 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 06AED3F6C4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:52:13 -0800 (PST)
Date: Tue, 27 Feb 2024 10:52:12 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Faiz Abbas <faiz.abbas@arm.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Subject: Re: [PATCH 0/3] Fixes for the komeda driver
Message-ID: <Zd2-3EawUuxv2k78@e110455-lin.cambridge.arm.com>
References: <20240219100915.192475-1-faiz.abbas@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240219100915.192475-1-faiz.abbas@arm.com>

Hi Faiz,

On Mon, Feb 19, 2024 at 03:39:12PM +0530, Faiz Abbas wrote:
> The following patches add fixes to the komeda DPU driver.
> 
> Patch 1 fixes an issue where the crtc always expects both pipelines to
> always have remote nodes populated.
> 
> Patch 2 is a cosmetic fix that ensures komeda does not print verbose
> pipeline information unless the entire pipeline is actually up.
> 
> Patch 3 adds a 40 bit DMA mask for each pipeline.

Sorry for the delay in replying, I was on holiday last week.

Patch series looks good, I will push it into drm-misc-next-fixes at the end
of the week.

Best regards,
Liviu


> 
> Amjad Ouled-Ameur (1):
>   drm/arm/komeda: update DMA mask to 40 bits
> 
> Faiz Abbas (2):
>   drm/arm/komeda: Fix komeda probe failing if there are no links in the
>     secondary pipeline
>   drm/arm/komeda: Move pipeline prints to after the entire pipeline has
>     been enabled
> 
>  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 45 ++++++++++++++-----
>  .../gpu/drm/arm/display/komeda/komeda_drv.c   |  4 ++
>  .../gpu/drm/arm/display/komeda/komeda_kms.h   |  1 +
>  .../drm/arm/display/komeda/komeda_pipeline.c  |  4 +-
>  4 files changed, 41 insertions(+), 13 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

