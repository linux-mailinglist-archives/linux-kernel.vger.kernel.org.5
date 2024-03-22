Return-Path: <linux-kernel+bounces-111241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE1D886997
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509EC1C2156F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A1424A0D;
	Fri, 22 Mar 2024 09:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFOMEHjq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C8A20DDB;
	Fri, 22 Mar 2024 09:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100683; cv=none; b=EwCfi8bHOjzBcVyouC0dYxcbAhbn/wRD5BV0sbauGgjm27H2Cy7vsMYAUXPFnlgYaGlOiZLet0VJffZqojwYX9UKNjVEe+WCham83jqs/ek7lu7JFoGV+8C3y2c8cQq6cCRIKd+lU+dfzAnjn1f66AU36mThS/SrjBstWfr4+s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100683; c=relaxed/simple;
	bh=OZqpPoXf8aJkADsczKIGarXC5e1A9XxkW7dY7qOHVMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nt4OdrU5Q1S6zKB0RPo4uTpLFfRVxr07XqFeByy0+piIWvwnFDnHLsxeX0q2w857O5qcRcEzRriMQsozNKK4ZN5M2Uc3ChiKj+7HjhFV1IqKUzzxp/q0b/Db2yFl+cJSRq73QjpNPWaDghZkJ24Wbl0JUuYdwhe6iFN5d6+/TH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFOMEHjq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5231C433C7;
	Fri, 22 Mar 2024 09:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711100683;
	bh=OZqpPoXf8aJkADsczKIGarXC5e1A9XxkW7dY7qOHVMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fFOMEHjq54SRHxeKXjaSwOAZiHZy1xazKROl3fzTVMwCy37ptelwATh3bQJhVFt8S
	 VXHm6L3eP+NlzF3AVZ4SN2F+UbUQ9PRtVf30kIi0TVuzTai9QCAZWrTDk9x+tP6Kt/
	 DDvt6u3Vo2Wk9aDWCvbekfveX+io31HME0FBWdjDRJxKghyestGVFmDuIl2pkysgzQ
	 5wst5bO6ogoyvM+RYK6KBUzw+RRXFryVHUtKgJ2JrssN3wc7rDAW2EJBP1uZaazgD0
	 itLs5cjY9aeGCqjOLxraqgGThcR9cPhiCPV2RxNukKfqv3wAClgERfFsKHBwKW77cv
	 AZiI3rJrTq/lg==
Date: Fri, 22 Mar 2024 10:44:40 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Michal Simek <michal.simek@amd.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v3 7/9] drm/atomic-helper: Add select_output_bus_format
 callback
Message-ID: <20240322-passionate-lyrebird-of-trust-819718@houat>
References: <20240321-dp-live-fmt-v3-0-d5090d796b7e@amd.com>
 <20240321-dp-live-fmt-v3-7-d5090d796b7e@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ycce5r5gilwxfcpp"
Content-Disposition: inline
In-Reply-To: <20240321-dp-live-fmt-v3-7-d5090d796b7e@amd.com>


--ycce5r5gilwxfcpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 21, 2024 at 01:43:45PM -0700, Anatoliy Klymenko wrote:
> diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
> index 2dafc39a27cb..f2e12a3c4e5f 100644
> --- a/drivers/gpu/drm/drm_crtc_helper.c
> +++ b/drivers/gpu/drm/drm_crtc_helper.c
> @@ -1055,3 +1055,39 @@ int drm_helper_force_disable_all(struct drm_device *dev)
>  	return ret;
>  }
>  EXPORT_SYMBOL(drm_helper_force_disable_all);
> +
> +/**
> + * drm_helper_crtc_select_output_bus_format - Select output media bus format
> + * @crtc: The CRTC to query
> + * @crtc_state: The new CRTC state
> + * @supported_fmts: List of media bus format options to pick from
> + * @num_supported_fmts: Number of media bus formats in @supported_fmts list
> + *
> + * Encoder drivers may call this helper to give the connected CRTC a chance to
> + * select compatible or preffered media bus format to use over the CRTC encoder
> + * link. Encoders should provide list of supported input MEDIA_BUS_FMT_* for
> + * CRTC to pick from. CRTC driver is expected to select preferred media bus
> + * format from the list and, once enabled, generate the signal accordingly.
> + *
> + * Returns:
> + * Selected preferred media bus format or 0 if CRTC does not support any from
> + * @supported_fmts list.
> + */
> +u32 drm_helper_crtc_select_output_bus_format(struct drm_crtc *crtc,
> +					     struct drm_crtc_state *crtc_state,
> +					     const u32 *supported_fmts,
> +					     unsigned int num_supported_fmts)
> +{
> +	if (!crtc || !supported_fmts || !num_supported_fmts)
> +		return 0;
> +
> +	if (!crtc->helper_private ||
> +	    !crtc->helper_private->select_output_bus_format)
> +		return supported_fmts[0];
> +
> +	return crtc->helper_private->select_output_bus_format(crtc,
> +							crtc_state,
> +							supported_fmts,
> +							num_supported_fmts);
> +}

Again, the output of that selection must be found in the CRTC state,
otherwise CRTCs have no way to know which have been selected.

Maxime

--ycce5r5gilwxfcpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZf1TBwAKCRDj7w1vZxhR
xZGhAPsFZUpxcGfjLfAI6mcBYPDnCRhbOkvpKYaxj2+CXYWFeQD/W04VlpRLf4Fw
17ZdokR9h0XPytwkCVdQft75epzqgQY=
=VFYJ
-----END PGP SIGNATURE-----

--ycce5r5gilwxfcpp--

