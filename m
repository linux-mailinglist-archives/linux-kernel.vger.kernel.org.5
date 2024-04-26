Return-Path: <linux-kernel+bounces-159431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A2F8B2E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E791C222B7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F191869;
	Fri, 26 Apr 2024 02:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVsdb2nP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537EE15CE;
	Fri, 26 Apr 2024 02:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714097345; cv=none; b=Yi2HDTbqKvbWNmObfQVm3ItrHMj3OsEG5MwfpT102D6JfkVWQy3+1mPJ+qDcx28pntB8lx9F9enWGHOUhjMi21xH9q6CDo2vpezQsNovU8GNeVj5PWlTQwpXAVUn/AwIjQTDEdNuqQ5KrcaEq6KV0OdoKrO72/PKYPMkDYHKJME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714097345; c=relaxed/simple;
	bh=RaA10gzFMijmnLpX8g9P+ahaM9BYGZVleDM/58q/EhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRBSa7jOCiNxYg7p2zox1bO0e1rekPtNX0+y9Yr5mRbZmrlPYAgpvyu/KRcYQxz5xRE8HjvRXbyhZaLGynLzquVbI1giLJcHMYf5sM1a5d/v7/8IAeOPvj4Us3Bujbhc8Qk3Qm1vDB0UeLPEKlpQeiuLRLQFtOmgC/0ZfYJ0SGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVsdb2nP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45104C113CC;
	Fri, 26 Apr 2024 02:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714097344;
	bh=RaA10gzFMijmnLpX8g9P+ahaM9BYGZVleDM/58q/EhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JVsdb2nPMfDxyvIzHLmteDnKiEF01zLtPHG60bPyJi14lcfrekjJIdv4rviopgziq
	 f0iwIqmT5LqyNbJr7wXsXe5Pbckki88bxtivP5UeNfxcq8UaNfO2nSlcw02lKvzHP9
	 0mNY2TW92W6SoVCwt6s3HFHJbiZkO/UUaXWr/CvMrIcqUGMGJ0OAxs2BJbMzXZObws
	 hPZPhtk7e+prjotitLx4w5GLRlPwFEkq3kbF5AE2sYfbeWK8ajRIPg+IEdt2HSGuZK
	 2v4dR1FonitOrteypMZxZAhOb1GqKkko5cWiN5dERTcZtUWz4eWA0obCk4rR1xm+ch
	 As3H90/Ve/qrg==
Date: Fri, 26 Apr 2024 11:09:00 +0900
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 01/14] ASoC: SOF: debug: Constify local snd_sof_dsp_ops
Message-ID: <ZisMvJORIdqttoeF@finisterre.sirena.org.uk>
References: <20240414-n-const-ops-var-v1-0-8f53ee5d981c@kernel.org>
 <20240414-n-const-ops-var-v1-1-8f53ee5d981c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QadR/dyrQjBKyfJ0"
Content-Disposition: inline
In-Reply-To: <20240414-n-const-ops-var-v1-1-8f53ee5d981c@kernel.org>
X-Cookie: Shut off engine before fueling.


--QadR/dyrQjBKyfJ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 14, 2024 at 08:47:26PM +0200, Krzysztof Kozlowski wrote:
> Constify the pointer to 'struct snd_sof_dsp_ops' to annotate that
> functioon does not modify pointed data.

This doesn't apply against current code, please check and resend.

--QadR/dyrQjBKyfJ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYrDLwACgkQJNaLcl1U
h9DmCgf/Y5wt+LDn+WCUAubCYsG6igwZ0t9A9OH+G1bZL3YYMTw23O8FNhzXs+gU
/ZERo2f/xG6D33AKJpYZqvLJ1ZYyQWBpf3SG2nPN3d3skuItL/M7/A9+yltV2j0Q
bAZcHvx5LaPgSjS7vR8wmPmdymeDM+Yoixm4DNuHSItaKuFQtC/bIRuFmRQQoCIn
AXYvoVLdQqkiHrTPsk6jrl/E4A3xmzCBWeUJ4CIW34jFPswHN5GWczALQocSW3g1
vbAQQ+uMxtXhXs9AUXN9oRU+ftl6/3tsYvjSjIt9lD79cgfO6G4dB0U5vDbwyfK0
ZsyFufHPFrLV62IvV+3WKWvRtjOi3w==
=c2S5
-----END PGP SIGNATURE-----

--QadR/dyrQjBKyfJ0--

