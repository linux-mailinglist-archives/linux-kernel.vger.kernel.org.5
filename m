Return-Path: <linux-kernel+bounces-85354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CFC86B4AB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F151C22B97
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B616EEFE;
	Wed, 28 Feb 2024 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lgbztTkG"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74496EEE1
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137346; cv=none; b=jiutgrTqxUBwTdHGn113eesBvIRJS0LbRlhprp+1bnq/2i/CjChVPVBkK0rro2iZrCy2/xJ38xJpxjSbOfONqynV3GQ4qa3UfkbgI+i70bayjLaNfbXsNvY7MFaFQGCiVj96XEHdMUmrKwXx7r9a0lUceAa45ramjriAw6GCqCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137346; c=relaxed/simple;
	bh=/3zDOS2PejvTm0xV78aQExrLl1BoCDLR7sm/RYS9aU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4I4gHGd7jMOmBpuuhZPHf9bm3nwq+7OyPNwkT+xXqxzRHemMVUkCxdsql4Prv1qyAEitwIVrcp51zpwfxDE/RoBfbdYd2rx/ZxZowPGILMmpgUEcZ4qX3HjzMFXLmyo8RuFvCeFO8VrjopTdLsioJkJZ4s9+RUNOoZ/4L2oZzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=lgbztTkG; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C86496B3;
	Wed, 28 Feb 2024 17:22:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709137330;
	bh=/3zDOS2PejvTm0xV78aQExrLl1BoCDLR7sm/RYS9aU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lgbztTkGoUfv9hR8sP0de8pZbHV8zgzqNLgzwcLeXuzKGUCAZtbrDLWDLbDcxItVb
	 e2PtaJwF00ogqLWm9f6jS4V+DBz/Q4hq9Wywj/LHPgN2eIWxAn0+1nf/EzCRz2n6pj
	 4PUdWySeVm86re+/9+nBTi00iw8P2sWZiD5KQz0A=
Date: Wed, 28 Feb 2024 18:22:24 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Rohit Visavalia <rohit.visavalia@amd.com>
Cc: gregkh@linuxfoundation.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, michal.simek@amd.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: xlnx: dp: Reset DisplayPort IP
Message-ID: <20240228162224.GG9863@pendragon.ideasonboard.com>
References: <20240216124043.1226713-1-rohit.visavalia@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240216124043.1226713-1-rohit.visavalia@amd.com>

Hello Rohit,

Thank you for the patch.

On Fri, Feb 16, 2024 at 04:40:43AM -0800, Rohit Visavalia wrote:
> Assert DisplayPort reset signal before deasserting,
> it is to clear out any registers programmed before booting kernel.
> 
> Signed-off-by: Rohit Visavalia <rohit.visavalia@amd.com>
> ---
>  drivers/gpu/drm/xlnx/zynqmp_dp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index 1846c4971fd8..5a40aa1d4283 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -1714,6 +1714,10 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub)
>  		goto err_free;
>  	}
>  
> +	ret = zynqmp_dp_reset(dp, true);
> +	if (ret < 0)
> +		return ret;
> +

This looks fine to me, so

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

However, looking at zynqmp_dp_reset(), we have

static int zynqmp_dp_reset(struct zynqmp_dp *dp, bool assert)
{
	unsigned long timeout;

	if (assert)
		reset_control_assert(dp->reset);
	else
		reset_control_deassert(dp->reset);

	/* Wait for the (de)assert to complete. */
	timeout = jiffies + msecs_to_jiffies(RST_TIMEOUT_MS);
	while (!time_after_eq(jiffies, timeout)) {
		bool status = !!reset_control_status(dp->reset);

		if (assert == status)
			return 0;

		cpu_relax();
	}

	dev_err(dp->dev, "reset %s timeout\n", assert ? "assert" : "deassert");
	return -ETIMEDOUT;
}

That doesn't seem quite right. Aren't reset_control_assert() and
reset_control_deassert() supposed to be synchronous ? If so there should
be no need to wait, and if there's a need to wait, it could be a bug in
the reset controller driver. This should be fixed, and then the code in
probe could be replaced with a call to reset_control_reset().

>  	ret = zynqmp_dp_reset(dp, false);
>  	if (ret < 0)
>  		goto err_free;

-- 
Regards,

Laurent Pinchart

