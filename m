Return-Path: <linux-kernel+bounces-43193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489F8840F9F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35231F22BEC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B575915B10D;
	Mon, 29 Jan 2024 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHZDFLPg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBF015956E;
	Mon, 29 Jan 2024 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548472; cv=none; b=cE7nRyBJ+Dd2QgcrHgjDzA2fBiWV71zgEy+bRaxvmOwKU0yZ/zNpEzAvJPoVDLCyLeb3+iKIjVR7zg2G4j09OaMS2o95cxA9z6p92MhZXB28KBSndG62VPVsWfNWOyl9yVGR3MG/XxSj//Zm8UXgimINc/RnW69DJROL2FKZ6pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548472; c=relaxed/simple;
	bh=IY3+mOCEfpNRLEE5Yd9Y6ozPNm56tWYWYfMzj2fiZBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuvZJ1GFBzo1mtjwXcuuGZVbF3UnD94T8F5Mo/D+L2yiPVUQhIeTm9dKvhd+1edNiLQF8CseDOfE+8zvyhoX7jYgO7ZPvwArGM0kGhTv4qDtjH4P167mVKvgdKbaDcujDEDWWV6jcMGi0SC86IXofL+imlQrlmGCK3U0gjJghcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHZDFLPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37ED9C433C7;
	Mon, 29 Jan 2024 17:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706548471;
	bh=IY3+mOCEfpNRLEE5Yd9Y6ozPNm56tWYWYfMzj2fiZBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UHZDFLPgwQ0sr4CtIfiwyqL8cTMuyQS0zkhd8RPXtfFhv7BmwcM0bRhsZodkTxY0x
	 feEJFkNORnaL3pgf3bDFL4qyuKdTOAQUT/IwaGwM0HHTD5inHfVALZh1r6dTqFGu2U
	 eYy3JZ9y8ImdyPkGQjSMKIDdGFkbLH+JJ0m59f9qQGmhdTv09w1uoG9/52KcbW5zgc
	 iQA2yyhBOyrwRa7AY7U+WCPmQRBxmsFqifdEq6kiW+oTMMkMHxgM/DYd2xahOBJ/HI
	 W1wkQdgz/KKaGficJTTnCZEJf4gpsRsQ+/uDyaRiv/y4Lgh5DRIiM5EpVMZ+BQdqTe
	 FIoemojaaOPbg==
Date: Mon, 29 Jan 2024 17:14:24 +0000
From: Conor Dooley <conor@kernel.org>
To: Dharma.B@microchip.com
Cc: Conor.Dooley@microchip.com, sam@ravnborg.org, bbrezillon@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, Nicolas.Ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lee@kernel.org, thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
	Linux4Microchip@microchip.com
Subject: Re: [PATCH v3 3/3] dt-bindings: mfd: atmel,hlcdc: Convert to DT
 schema format
Message-ID: <20240129-dwindle-salvaging-1ae9da61c085@spud>
References: <20240119-character-mardi-43571d7fe7d5@wendy>
 <da60f9f3-f955-4a87-a020-5710185953c0@microchip.com>
 <20240122-stark-duress-2f59294dcf27@spud>
 <4906b7e2-0ddb-4d3c-a48b-e16278f2d649@microchip.com>
 <20240124-lend-emerald-1028fe65cc39@spud>
 <c3c30bf2-e7c2-4861-bfdf-519a7afde476@microchip.com>
 <20240125-proved-passage-7fa128f828db@wendy>
 <51da296d-a8a9-417a-8875-3b5e866a89a3@microchip.com>
 <20240126-uncommon-stout-dd3243e6b43f@spud>
 <e2080c19-a62b-4716-8de1-d3bdc299a49c@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O8JBIuMwLVxn+xwX"
Content-Disposition: inline
In-Reply-To: <e2080c19-a62b-4716-8de1-d3bdc299a49c@microchip.com>


--O8JBIuMwLVxn+xwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 03:41:22AM +0000, Dharma.B@microchip.com wrote:
> I will proceed with updating the clock names to include "lvds pll" and=20
> adjusting the clocks minitems to 3. Does this seem appropriate to you?
>=20
> Please let me know if there are any additional considerations or=20
> specific aspects that require attention.

That seems okay, thanks.

--O8JBIuMwLVxn+xwX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbfc8AAKCRB4tDGHoIJi
0pzyAPwOmSdqPU9+jAtNozvTctC+s8e/7JFYs7RiVScM6OBpCQEAsK+qKhVr8wPM
fDpDFMHLAEMRGod043qDO4TmwX3FfgA=
=/UpN
-----END PGP SIGNATURE-----

--O8JBIuMwLVxn+xwX--

