Return-Path: <linux-kernel+bounces-96518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1807875D6F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825B41F22787
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8DD2E832;
	Fri,  8 Mar 2024 05:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f29GFOs3"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F2A2F26
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 05:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709874633; cv=none; b=ozX3zQLkNVZBsJ++OOltHOD2iLBQtafeMgA/o/O1xN19GsSUHBAY/SrzfwPA1B+2jfG6QljHAmGX5bRWT4RER6ipgT6OyKzXfAT53/YpW01zcli2srkJaYCsDCdYCGtRjQAs8X2aGrsfTPr2mt8ZSG6Nfj7ZhvxpvHC+2FrOQO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709874633; c=relaxed/simple;
	bh=/wBaA+A3IhznHWZDqOy4W5V3epars38Dd+UFQPRmiQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7tAcLjBUZb5z8nnPh2pBGBPkP/f0GOlzLusbaNnerwjZ/BFDrbYPzbzX6nYaiWaA+pwcpIDyE6PVB6sk4YKa8DDuN4q8n+rbPiJn5L3FIOCDx1w1ZJ6+UK4uRIIs1O6Af3TC4NnutpL4KPgbclQco9NUrhdptSFfScbb56MaxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f29GFOs3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=xIY2hE+i3b9V6ZuohaD3aLGrUTWHPeMVhT8BwAXe6WE=; b=f29GFOs3B5p9vujZW3rD1Jgg+5
	KWixlE7Qx8YqalG+mmlwhetGbe87cRM2T7YIERSr6+UkmViPQibs0OdXgArxrb2uobZA0aOfz1InI
	8zSKb5MvbwCk78YegiVg4hUnrvBxUgGfOJkiOaNaiHHstTzkc+ee4UQSkOtxhP+p+v6PpEHDdNdWM
	Me0vvcUW1oz59BumEPAXKtUKhJlglV9OY0dmfojaMIytwVxV2oKapGKD+uecjFp2c69/ZEBm42rVq
	78U0pwhB2G31Fkze7F+6CfPPnfs+BoBn4+S68ldcwhpGR8IkkfZ9zIwDZwTU6L2v2zntOsDGuhAEs
	gRytmqNQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riSV1-00000007ox5-1afW;
	Fri, 08 Mar 2024 05:10:27 +0000
Message-ID: <9199ed28-ba15-4d50-b8a6-7f6a32aeb3bb@infradead.org>
Date: Thu, 7 Mar 2024 21:10:23 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Removed vcpi field description to fix kernel doc warning
Content-Language: en-US
To: R SUNDAR <prosunofficial@gmail.com>, airlied@gmail.com, daniel@ffwll.ch,
 lyude@redhat.com, imre.deak@intel.com, jani.nikula@intel.com,
 mripard@kernel.org, ville.syrjala@linux.intel.com, Wayne.Lin@amd.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240308025152.17297-1-prosunofficial@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240308025152.17297-1-prosunofficial@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/7/24 18:51, R SUNDAR wrote:
> For linux-next repo
> 
> /include/drm/display/drm_dp_mst_helper.h:156: warning: Excess struct member 'vcpi' description in 'drm_dp_mst_port'
> 
> Signed-off-by: R SUNDAR <prosunofficial@gmail.com>

or
https://lore.kernel.org/lkml/20240106032321.28596-1-rdunlap@infradead.org/

but I would be happy to see either of them merged.

Thanks.

> ---
>  include/drm/display/drm_dp_mst_helper.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
> index 9b19d8bd520a..3ae88a383a41 100644
> --- a/include/drm/display/drm_dp_mst_helper.h
> +++ b/include/drm/display/drm_dp_mst_helper.h
> @@ -83,7 +83,6 @@ struct drm_dp_mst_branch;
>   * @passthrough_aux: parent aux to which DSC pass-through requests should be
>   * sent, only set if DSC pass-through is possible.
>   * @parent: branch device parent of this port
> - * @vcpi: Virtual Channel Payload info for this port.
>   * @connector: DRM connector this port is connected to. Protected by
>   * &drm_dp_mst_topology_mgr.base.lock.
>   * @mgr: topology manager this port lives under.

-- 
#Randy

