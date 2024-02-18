Return-Path: <linux-kernel+bounces-70489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA51C85988D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A76281BE3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44006F087;
	Sun, 18 Feb 2024 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="mTNVOFjm"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FDDE57E;
	Sun, 18 Feb 2024 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708280854; cv=none; b=cxBqwIduAUl10xuFw+yQRPd3YnOUXs+7O64I0qPJpi5xo2Xx6+ZxlzFa2pU5ExQUW1DL0phWjgNjsW3xsbthipCuHYyKHrhnmTAjXIdo8Uq8l43I3cOpP97nqqnmM67x3eshJ7LTJoV6sN8VG5O39IY0RR9psOn6abV6Vfcu8HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708280854; c=relaxed/simple;
	bh=TUthxYyUEHuO74Lh6HcqiWly+WRYc2MjeEeGfpBGnMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Of2lJvClYYvDhIY9IVLxCK4Fc9DmMD0WX97cUZZMFqmE0MAX8cpguPW70CELIePmN1rR5WSykrUeBpiWbA08DUUYZCS1JhDHPYyEcAdkmZl29AVXhtrYaCzuaixMfXL80s6YIg73APu3xRZgmPzJjqGb7+RHcrLklvKBkRfJ3qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=mTNVOFjm; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 56E37480;
	Sun, 18 Feb 2024 19:27:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708280843;
	bh=TUthxYyUEHuO74Lh6HcqiWly+WRYc2MjeEeGfpBGnMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mTNVOFjmPTAypEwrtMCf4mfuoFWGYhm/p+bkVdAGecv/ly5BRoiqNm2gVA12CKy/I
	 FMpmOcKcUrCFUrO98AjrdzKRVk3pL/emqygq5TSKt/pv2BXWy7gBsSeExIsYsUZ5i8
	 GJpekJ7kGDF2fGKXSCruj1okIbfcxIxDO25K+onw=
Date: Sun, 18 Feb 2024 20:27:33 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Paul Elder <paul.elder@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, kieran.bingham@ideasonboard.com,
	tomi.valkeinen@ideasonboard.com, umang.jain@ideasonboard.com,
	aford173@gmail.com, Dafna Hirschfeld <dafna@fastmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 06/12] media: rkisp1: Add version enum for i.MX8MP ISP
Message-ID: <20240218182733.GI7120@pendragon.ideasonboard.com>
References: <20240216095458.2919694-1-paul.elder@ideasonboard.com>
 <20240216095458.2919694-7-paul.elder@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240216095458.2919694-7-paul.elder@ideasonboard.com>

Hi Paul,

Thank you for the patch.

On Fri, Feb 16, 2024 at 06:54:52PM +0900, Paul Elder wrote:
> Add to the version enum an entry for the i.MX8MP ISP.
> 
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> ---
> New in v12:
> - split out from "media: rkisp1: Add match data for i.MX8MP ISP"
> - changed the version enum name
> ---
>  include/uapi/linux/rkisp1-config.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/uapi/linux/rkisp1-config.h b/include/uapi/linux/rkisp1-config.h
> index 730673ecc63d..2d1c448a6ab8 100644
> --- a/include/uapi/linux/rkisp1-config.h
> +++ b/include/uapi/linux/rkisp1-config.h
> @@ -179,12 +179,14 @@
>   * @RKISP1_V11: declared in the original vendor code, but not used
>   * @RKISP1_V12: used at least in rk3326 and px30
>   * @RKISP1_V13: used at least in rk1808
> + * @RKISP1_V_IMX8MP: used in at least imx8mp

We need to also update the comments that references version numbers in
the same file. I'll send a v12.1 as a reply.

>   */
>  enum rkisp1_cif_isp_version {
>  	RKISP1_V10 = 10,
>  	RKISP1_V11,
>  	RKISP1_V12,
>  	RKISP1_V13,
> +	RKISP1_V_IMX8MP,
>  };
>  
>  enum rkisp1_cif_isp_histogram_mode {

-- 
Regards,

Laurent Pinchart

