Return-Path: <linux-kernel+bounces-122613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F297088FA65
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9418C2851A6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD35B5FBA2;
	Thu, 28 Mar 2024 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="O1wRiwex"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2097B54775;
	Thu, 28 Mar 2024 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615928; cv=none; b=VF20oD/I3tb//bNWpXQ9mS/YK/dmx/g/ouA3mD9yNeo0hwFwmF0n/dszXrhp7L43zXr3cb+v4Z5qxNASJnBOe6h36x00KN4ATFdSaFgELNUheKRPK3j/GLZFHEfrBywBhDkYaRgSiTtz7X5OErNyslpBBR7bApFyIUlIuPE+qBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615928; c=relaxed/simple;
	bh=5ywGdOE9cKl2/Ln19G2UleUNBEY31QHhmLsqIQZtQ/s=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=TzwD95ACg3dDbqgMEVchjlyr8B4ngpqYpsY+qe8ICeB4MxwN08QBoPgBXZv2U3XQi2DOiZNWy01NAaOcKtScU2q3eGdv3qMcfrMsZn01HrmzV4GqMoDQP6GTJdOgjSg7olQw8V0oi49SqLB9ZT3j4bY+E43+IQ8HGa7gZiI3bw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=O1wRiwex; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6859ED20;
	Thu, 28 Mar 2024 09:51:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711615891;
	bh=5ywGdOE9cKl2/Ln19G2UleUNBEY31QHhmLsqIQZtQ/s=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=O1wRiwex2lGpg7fJs0QaR9ij2vL3uYMs8IWFScSThC35qutOwuZRW95qQPk5fDce3
	 h3tRULXEIvXsIIJEPepqUXIog0TNgSb5/RKmAuBrwyuX28ws5+JvuJkxisuesqbm5f
	 BkgORPj5Gb4i3N7rVCPFW56cWPJnureukC6eUQGU=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0e658ecc-38d2-4d6f-b0cf-f5f3ec32c1b8@luigi311.com>
References: <20240327231710.53188-1-git@luigi311.com> <20240327231710.53188-18-git@luigi311.com> <20240327-ninth-tulip-77191ad10fdd@spud> <0e658ecc-38d2-4d6f-b0cf-f5f3ec32c1b8@luigi311.com>
Subject: Re: [PATCH 17/23] dt-bindings: media: imx258: Rename to include vendor prefix
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com, jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, sakari.ailus@linux.intel.com, devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
To: Conor Dooley <conor@kernel.org>, git@luigi311.com
Date: Thu, 28 Mar 2024 08:52:01 +0000
Message-ID: <171161592126.3072637.14564447281929105708@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting git@luigi311.com (2024-03-28 00:57:34)
> On 3/27/24 17:47, Conor Dooley wrote:
> > On Wed, Mar 27, 2024 at 05:17:03PM -0600, git@luigi311.com wrote:
> >> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> >>
> >> imx258.yaml doesn't include the vendor prefix of sony, so
> >> rename to add it.
> >> Update the id entry and MAINTAINERS to match.
> >>
> >> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> >> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > This is a v1 with my ack, something has gone awry here. It's also
> > missing your signoff. Did you pick up someone else's series?
>=20
> Yes, this is a continuation of Dave's work. I contacted him directly,
> and he mentioned that he is unable to submit a v2 any time soon and
> was open to someone else continuing it in his stead. This is my first
> time submitting a patch via a mailing list, so I'm not sure if I'm
> missing something, but I only added my sign off for anything that
> actually included work from my side and not just bringing his patch
> forward to this patch series.

Your cover letter states v2, but the individual patches do not.

Add the '-v2' (or, rather, next it will be '-v3') to git format-patch
when you save your series and it will add the version to each patch. You
can also add '-s' to that command I believe to add your SoB to each
patch.

--
Kieran

>=20
> >=20
> >> ---
> >>  .../bindings/media/i2c/{imx258.yaml =3D> sony,imx258.yaml}        | 2=
 +-
> >>  MAINTAINERS                                                     | 2 +-
> >>  2 files changed, 2 insertions(+), 2 deletions(-)
> >>  rename Documentation/devicetree/bindings/media/i2c/{imx258.yaml =3D> =
sony,imx258.yaml} (97%)
> >>
> >> diff --git a/Documentation/devicetree/bindings/media/i2c/imx258.yaml b=
/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> >> similarity index 97%
> >> rename from Documentation/devicetree/bindings/media/i2c/imx258.yaml
> >> rename to Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> >> index 80d24220baa0..bee61a443b23 100644
> >> --- a/Documentation/devicetree/bindings/media/i2c/imx258.yaml
> >> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> >> @@ -1,7 +1,7 @@
> >>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>  %YAML 1.2
> >>  ---
> >> -$id: http://devicetree.org/schemas/media/i2c/imx258.yaml#
> >> +$id: http://devicetree.org/schemas/media/i2c/sony,imx258.yaml#
> >>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >> =20
> >>  title: Sony IMX258 13 Mpixel CMOS Digital Image Sensor
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index aa3b947fb080..1f17f6734bf5 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -20464,7 +20464,7 @@ M:   Sakari Ailus <sakari.ailus@linux.intel.co=
m>
> >>  L:  linux-media@vger.kernel.org
> >>  S:  Maintained
> >>  T:  git git://linuxtv.org/media_tree.git
> >> -F:  Documentation/devicetree/bindings/media/i2c/imx258.yaml
> >> +F:  Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> >>  F:  drivers/media/i2c/imx258.c
> >> =20
> >>  SONY IMX274 SENSOR DRIVER
> >> --=20
> >> 2.42.0
> >>
>

