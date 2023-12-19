Return-Path: <linux-kernel+bounces-5305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 711AA818932
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E4B1F2257F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A70C1B277;
	Tue, 19 Dec 2023 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQhXfUlx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37AC1D537;
	Tue, 19 Dec 2023 14:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9777CC433C8;
	Tue, 19 Dec 2023 14:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702994487;
	bh=Of90bXPWvWIJcSSTGRpqse+Dc7C4yWxoYgzgKtTzOVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MQhXfUlxR27mAfOf8l+AxfWd/8dCSZI7CW8TVSJApczezIL1y87Fl09aTG3Xl41Vc
	 XM26NdyNCiAQwpCkmPxOpH6luLutSJTfZ5OupP9MKmMYBYnCmAZQezTIhJp2rnrfxg
	 VUfdnLHd2jrJpsy6Gsspbz0Y/zhkHKVGnileoIwRGwwNCz3iCn7e7uZ3cMAT9fLfED
	 GxmFf+rFd8EFoKM+6BQFI19qNsPQ0PY5trZYcu/yWaCStGomZU5flHrqKXyUBFoneK
	 wNMFOLFO2RW4uZzFykjjhbCqfyRsdfwycZICLJkrge2ofR7M6GjvXYRPtyJbin5ULV
	 qeIaZZ6P89R4Q==
Date: Tue, 19 Dec 2023 14:01:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Sunil Vaghela <sunil.vaghela@softnautics.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	michal.simek@amd.com, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ASoC: xilinx: Embed IEC958 sample rate val to channel
 status register
Message-ID: <1d354ce4-b85c-495a-b54d-48a443736a52@sirena.org.uk>
References: <20231219122955.104696-1-sunil.vaghela@softnautics.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S1xAJ6+8APP9T7Xt"
Content-Disposition: inline
In-Reply-To: <20231219122955.104696-1-sunil.vaghela@softnautics.com>
X-Cookie: The bigger the theory the better.


--S1xAJ6+8APP9T7Xt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 05:59:55PM +0530, Sunil Vaghela wrote:
> As per IEC 60958 specification, bits 24 to 27 of channel status register
> indicates audio sample frequency. If these bits are not set, audio
> analyzer always shows 44.1KHz sample rate, irrespective of any sample
> rate audio is being played.

This breaks an x86 allmodconfig build:

/build/stage/linux/sound/soc/xilinx/xlnx_formatter_pcm.c: In function =E2=
=80=98xlnx_form
atter_pcm_hw_params=E2=80=99:
/build/stage/linux/sound/soc/xilinx/xlnx_formatter_pcm.c:572:26: error: =E2=
=80=98struct=20
xlnx_pcm_drv_data=E2=80=99 has no member named =E2=80=98nodes=E2=80=99
  572 |         if ((strstr(adata->nodes[XLNX_PLAYBACK]->name, "hdmi")) ||
      |                          ^~
/build/stage/linux/sound/soc/xilinx/xlnx_formatter_pcm.c:572:34: error: =E2=
=80=98XLNX_PL
AYBACK=E2=80=99 undeclared (first use in this function)
  572 |         if ((strstr(adata->nodes[XLNX_PLAYBACK]->name, "hdmi")) ||
      |                                  ^~~~~~~~~~~~~
/build/stage/linux/sound/soc/xilinx/xlnx_formatter_pcm.c:572:34: note: each=
 unde
clared identifier is reported only once for each function it appears in
/build/stage/linux/sound/soc/xilinx/xlnx_formatter_pcm.c:573:26: error: =E2=
=80=98struct xlnx_pcm_drv_data=E2=80=99 has no member named =E2=80=98nodes=
=E2=80=99
  573 |             (strstr(adata->nodes[XLNX_PLAYBACK]->name, "dp"))) {
      |                          ^~


--S1xAJ6+8APP9T7Xt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWBojEACgkQJNaLcl1U
h9B8Ogf8Cb7kJlLz26orPkw1+GxIfV7z4ldm1+SiBDb4WeCGFeLjWvEl43d2htvo
cOeiFCAJ7lW53fbItO+7XJ0IIFzHrewOzakPluGW9TyNPS4jZmI/Q3WjA3u5VA3d
MrjqAwYwd6Qs2dB4y4s/auznELoeoB4xjzD9rSCxcXSFJjojYuMk3XP0yEF7L5HT
QnAb8ZkO4BF/rWThqnHf7J4EUnQAZT6M7md3m+6KNPmk0DbcX8ibOUGHYGkXTqH2
JO8MCJ//A+weYiUtW6TKxstwVw2expzaQkeV4E0CbQcSy8miRBVKnjOwGhpkPoSS
YmZauVWbvMB5Et6axhGwdUasrVsDHg==
=Fm2+
-----END PGP SIGNATURE-----

--S1xAJ6+8APP9T7Xt--

