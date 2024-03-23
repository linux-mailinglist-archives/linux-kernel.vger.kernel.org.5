Return-Path: <linux-kernel+bounces-112457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB729887A17
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 20:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD460B21336
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 19:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0205859147;
	Sat, 23 Mar 2024 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYGj3MjQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC244E1C4;
	Sat, 23 Mar 2024 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711220891; cv=none; b=j1q723jb71rVwRiwTYsCrwYTpJk+/INFevNU/sND20624IpvDUss/BX6WvTkSage9q8fFJ01Huvpvz6cSlAkIs+zuc4XexMymxzkf4FXpd+1BjOVZFdOBPl5Y/CfhLTz7/VrSYdInCjMporfwq3I26dBCSxL8ewOBuigsbu11qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711220891; c=relaxed/simple;
	bh=9+sQO6Zyazf3riHAPr4vw0wfA2CTMxeeqFat8In/BUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fALujtLUF0jwveFURXQ+LvXPGexJvhzv0XohL3mWua9sFBxxCAuJf7eQ/gCDCEXVqmQjGVXKKuRiuuUAqpOPN+jRxmw3AvWti/dpvvNDc8xzg/DQTV4MVxk6JsMFR9meij5M5JoQ9tVAwgf6JSCELdpqJCLYIS4t8mOSS/zoQwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYGj3MjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE15C433C7;
	Sat, 23 Mar 2024 19:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711220890;
	bh=9+sQO6Zyazf3riHAPr4vw0wfA2CTMxeeqFat8In/BUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZYGj3MjQ8L+ziQ43RKGtutkhb+qszI4YtjRXG5l2kQ6elGdn5A992hi3tuVRtt+3C
	 DE86Amtg0TbggEFZfqUNSdEMQPiaTVRr8Hdlo7hSzuJ4TjyTHoychCuKOieoBQytKD
	 sB4qd3fOrtb153vcs1V3slc19OLe7xXlDWFPx+suildW95BS+tWER1ao7B+/bnSfB1
	 U8oZ7Vdnx+viv0HJyryrin35TqF+H0qALo4AkiOtOPuAhRS2oaw69rPKSJiJs6/l+f
	 t15sYcoN3eEBIan1sxuWTqVSqG8c45Qy17nrHzuWS9Efl3LJyYInADtoeaS227xC5M
	 2AvNHlTgPA3NA==
Date: Sat, 23 Mar 2024 19:08:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v3 8/9] dt-bindings: xlnx: Add VTC and TPG bindings
Message-ID: <20240323-kennel-mousiness-f8fc12777cf9@spud>
References: <20240321-dp-live-fmt-v3-0-d5090d796b7e@amd.com>
 <20240321-dp-live-fmt-v3-8-d5090d796b7e@amd.com>
 <a82d525c-737a-4ac4-9d71-e88f4ba69ea1@linaro.org>
 <20240322-absence-endurable-dee8a25643b7@spud>
 <4439d51f-072a-4b0f-a6e4-b95192eac83b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="APHpANq/M0OjDKgl"
Content-Disposition: inline
In-Reply-To: <4439d51f-072a-4b0f-a6e4-b95192eac83b@linaro.org>


--APHpANq/M0OjDKgl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 11:22:22AM +0100, Krzysztof Kozlowski wrote:
> On 22/03/2024 19:05, Conor Dooley wrote:
> > On Fri, Mar 22, 2024 at 06:59:18AM +0100, Krzysztof Kozlowski wrote:
> >> On 21/03/2024 21:43, Anatoliy Klymenko wrote:
> >>> diff --git a/include/dt-bindings/media/media-bus-format.h b/include/d=
t-bindings/media/media-bus-format.h
> >>> new file mode 100644
> >>> index 000000000000..60fc6e11dabc
> >>> --- /dev/null
> >>> +++ b/include/dt-bindings/media/media-bus-format.h
> >>> @@ -0,0 +1,177 @@
> >>> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> >>> +/*
> >>> + * Media Bus API header
> >>> + *
> >>> + * Copyright (C) 2009, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> >>> + *
> >>> + * This program is free software; you can redistribute it and/or mod=
ify
> >>> + * it under the terms of the GNU General Public License version 2 as
> >>> + * published by the Free Software Foundation.
> >>
> >> That's not true. Your SPDX tells something entirely different.
> >>
> >> Anyway, you did not explain why you need to copy anything anywhere.
> >=20
> > I assume by "copy anything anywhere" you mean "why did you copy a linux
> > uapi header into the bindings?
>=20
> Yes, I trimmed context too much.
>=20
> The reasoning of copying some UAPI and claiming it is a binding was:
> "Copy media-bus-formats.h into dt-bindings/media to suplement TPG DT node=
=2E"
> so as seen *there is no reason*.
>=20

> Commit msg should explain why we are doing things.

Oh for sure. I was just wondering if you were complaining about the UAPI
header or if that comment was about the copyright notice. If it had been
the latter I was gonna point out the former :)

--APHpANq/M0OjDKgl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZf8okwAKCRB4tDGHoIJi
0uqqAP9b69AYr5D7FhDNnL/D8l5mnPP/f42epRSDhGpCwvmQwAD+P/S/aI8e14av
MPfETCx+sejBWrcfF0p6HK7BDCtvTAg=
=4lmD
-----END PGP SIGNATURE-----

--APHpANq/M0OjDKgl--

