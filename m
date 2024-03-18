Return-Path: <linux-kernel+bounces-106383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B1B87EDB5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A5C281EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A9054BE1;
	Mon, 18 Mar 2024 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EtVCRhMU"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C616E53394
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710779947; cv=none; b=ZmQSe/bsd7zHrYi1zzIJmK29tY/82dxREk28zY4O3aWluPR9Pff/IrYbT+xk75MxEmJs/+LMD0qNzsHV0QJRWIihQLPJpExC21uxbFwXSvf0CvFRRvpfAnzUM1WtT4I9CuQLvnoZzC4Z0aBxFLIKWc/NwN0RJCqeerfj6nVp+yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710779947; c=relaxed/simple;
	bh=4NAA95X70MYFGS3j8mtOCQqU+sM9czp1zd7c8cbv+7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXBE8d7C34BQY06q+AWqIFAJZfLUHEQC0DNT2IXQbZlNUmiJq/1ZUpWQrTTOzoOUbXi20Fg9OfaW5mMY3LnCH1XTqGGVg/SUNfn1n30/JWUJ0y1SNmZS3RQrM2IQyVf9MoW5nzLO3jtESmuQ9/Cl8hb/UaYe2YRn/vhf5d2Gtkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=EtVCRhMU; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B9AA5B1;
	Mon, 18 Mar 2024 17:38:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710779917;
	bh=4NAA95X70MYFGS3j8mtOCQqU+sM9czp1zd7c8cbv+7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EtVCRhMUOayXa87KnMhvz4FJmAGYKRgYYsaQp2OUnY+xsxq4sySy16to6xwOaKzjq
	 WLmlRqpHbOBCOo2uykeSuPBBKmgUIS4baGMX24Cla64r62veGZqkB+YvqT0jxVFfiy
	 BNx9G/WRd+kkMruQm/DFC6oroyMfBGzLgtthP+jQ=
Date: Mon, 18 Mar 2024 18:39:01 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
	linux-kernel@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/6] drm: zynqmp_dp: Downgrade log level for aux retries
 message
Message-ID: <20240318163901.GH13682@pendragon.ideasonboard.com>
References: <20240315230916.1759060-1-sean.anderson@linux.dev>
 <20240315230916.1759060-2-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240315230916.1759060-2-sean.anderson@linux.dev>

Hi Sean,

Thank you for the patch.

On Fri, Mar 15, 2024 at 07:09:11PM -0400, Sean Anderson wrote:
> Enable this message for verbose debugging only as it is otherwise
> printed after every AUX message, quickly filling the log buffer.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>  drivers/gpu/drm/xlnx/zynqmp_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index a0606fab0e22..98a32e6a0459 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -1006,7 +1006,7 @@ zynqmp_dp_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg)
>  					       msg->buffer, msg->size,
>  					       &msg->reply);
>  		if (!ret) {
> -			dev_dbg(dp->dev, "aux %d retries\n", i);
> +			dev_vdbg(dp->dev, "aux %d retries\n", i);

I didn't know about dev_vdbg(). I suppose this makes sense,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  			return msg->size;
>  		}
>  

-- 
Regards,

Laurent Pinchart

