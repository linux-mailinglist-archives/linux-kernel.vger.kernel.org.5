Return-Path: <linux-kernel+bounces-40144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDEC83DB2B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08A71C2171F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4741B961;
	Fri, 26 Jan 2024 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9U7CUaJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB531B810;
	Fri, 26 Jan 2024 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706276994; cv=none; b=EaeOEBhWjxdKY7rB00hWKuMLfkYdtuAAtQ4Upq+jq7ts1NxauBSf5iDxSGosxTachNsb8e3FURjYSJuGeDhAbVmg/Uu0AaTDggwgrEcuqtRzRMY5Or0EiJOmcGQn+Qyd0ZW9ERzpb+Yutf4e6AUrbBzNqc23QdamCcHFUBk/gDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706276994; c=relaxed/simple;
	bh=CKsAW7aJdD99Zo2RUgNrfJmMx2i0/42SKzLnKWV7MEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDPQ/cjP8dJBpHxcG5GKNOVVvJdwSla75+i4RK1pLRPTs1IGvlReEmcPU++YSC1DF/Y4uE4EsPN8mgZgxxw6KstVgd6+g2AJioo63B0qHdgH4ue3uD9HS1Ah9Fg7+l4IFGlDQIA9CCvP50WgszLbFUxbS6VBEI0VJGXrpA3mQtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9U7CUaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00EEC433F1;
	Fri, 26 Jan 2024 13:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706276994;
	bh=CKsAW7aJdD99Zo2RUgNrfJmMx2i0/42SKzLnKWV7MEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D9U7CUaJIP4th5k2wTFcDqzX40tpeJGFRdrAnD6ABACLgC2Vo6DPngLBHLYC8T8Sf
	 ba/uOnXJ9LiKHcrdxkV0YkrUT1SlDZzWSVRLZiQ+C4t5kVkMmd1bwoLDqAr6xMgluC
	 /9TBLVWbD0tlkHL4wncXj5qtL8v9UytEJbGcfLCo4oM/qpsi+ubDdhUjd6Mn+1UEdJ
	 jF3o2vTuuVvQGWtufqT9qHMrP97EInCDcTnHZvbS9drBG2QP7Jz2AAvV79+eVVI3jQ
	 zpAz9f32Usa1s0IBiH8KaqVG3lNAErPzOs7n8IcgYCsOY8W4YaA+CceAclYjy1kEwC
	 t2AT/dQEB77mg==
Date: Fri, 26 Jan 2024 13:49:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Shenghao Ding <shenghao-ding@ti.com>, conor+dt@kernel.org,
	robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
	kevin-lu@ti.com, baojun.xu@ti.com, devicetree@vger.kernel.org,
	v-po@ti.com, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	mohit.chawla@ti.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
	soyer@irl.hu, jkhuang3@ti.com, tiwai@suse.de, pdjuandi@ti.com,
	j-mcpherson@ti.com, navada@ti.com
Subject: Re: [PATCH v2 4/4] ASoc: dt-bindings: PCM6240: Add initial DT binding
Message-ID: <f5357751-ed4d-49ad-9d65-199c49f4cbdf@sirena.org.uk>
References: <20240126035855.1785-1-shenghao-ding@ti.com>
 <20240126035855.1785-4-shenghao-ding@ti.com>
 <f7a2de19-55c5-4aa9-b0a8-632f22b6c147@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gUpTdPZmTowW/ENb"
Content-Disposition: inline
In-Reply-To: <f7a2de19-55c5-4aa9-b0a8-632f22b6c147@linaro.org>
X-Cookie: Excellent day to have a rotten day.


--gUpTdPZmTowW/ENb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 26, 2024 at 09:27:47AM +0100, Krzysztof Kozlowski wrote:
> On 26/01/2024 04:58, Shenghao Ding wrote:

> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - ti,pcm1690
> > +    then:
> > +      properties:
> > +        reg:
> > +          items:
> > +            minimum: 0x4c
> > +            maximum: 0x4f

> Nothing improved.

Shenghao explained what what this is doing - I'm not sure what the
actual problem is here?  It's an actual restriction on the values that
are valid.

--gUpTdPZmTowW/ENb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWzuHkACgkQJNaLcl1U
h9CMSQf/TLFEYtZNLviYAnC1MgIL8OEEkfUobbFx7KZqo6evDq8XXX/2P+Nf/bYh
N0w2mKTh4k6VLzYZyr4I/7lMCqPeXfV9Ej+svlHbZ3TIjsXt697uTehbq8FX02w7
+5QupGUzIOjthDNC9z9YZ28+SD7OQVyuNzV30exRaL7NH+ZKooNkw1lQKAZsUPTH
pWcTv9S1HZEGIXsbHnDhHeeHEu6R85KtiPTd+KvthKVRTITX9dwpFSeWnVvOJ8O2
jOEI45qOPd/rm3HT6XReogyghoMkTlFxF6VROHaZ61mFF9QodkVv2AYEFG5VdzMb
MRa+Gq3twKv2qD8lhyDrZXdmOTJnEw==
=xhiZ
-----END PGP SIGNATURE-----

--gUpTdPZmTowW/ENb--

