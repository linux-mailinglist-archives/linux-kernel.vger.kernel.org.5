Return-Path: <linux-kernel+bounces-32226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 504FF8358D7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65561F229F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 00:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CB536C;
	Mon, 22 Jan 2024 00:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8kyjonA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11E11FA1;
	Mon, 22 Jan 2024 00:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705881840; cv=none; b=ejpdWbkbley3Y0AnPrw5cBZywMk07ZfwxDorPncpL5F78goaGgoFzjNxpB+4PGDBRAXrL7GTtDFUYReq4OGA9QrT8FQaJC9j1hKVwbfY77r0ORHxssn3QcXS37CM/I9Vh2LxeLD6sCpSkOPHWVYhuObIFwyjmzs8/UvQwNDmoL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705881840; c=relaxed/simple;
	bh=7oDI1XO154l1iaa0RraSQw5ES7TxoMVaLBOvKr6NGIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMCcHpak7TP4gafOBUbvkw8ZLd0lDiWVcZkkM6Eamx3yT3DlFg5A0qM26b0PWogqD9BfwJpaOdIZ7Yez5grp9o7Dpl1CSKX2AAGPo7TdXHGcSVGrYdZ3/RpWT7A3cEUQp4jvj+xrWCC+0V9sBv6gQHJS/TXtXJSUQ1q8M7Asn14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8kyjonA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181DDC433C7;
	Mon, 22 Jan 2024 00:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705881840;
	bh=7oDI1XO154l1iaa0RraSQw5ES7TxoMVaLBOvKr6NGIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V8kyjonAFPfiubxozhOruWdoQ+UXUjbDUSLOYRIMizyMt/Y/BCZz5sbuvgDDM1qX9
	 CvMVvcUha21MNi25rvqb5XINYtoNHVzyNTi8rkYfd/bTLwbgJcnZDM5+9lKeYrAe8g
	 xgs7Pfv5KvD+eWAfBZ74aGZbLgUmkBXiD/0+WL9Zgq5TQQm07M18YfBSZbBgriDJK4
	 Ad3aH+qNe53hChAvwcQVkyF9ZCdLwInlX3wXe6lbUCLbrvhA4Axl0fn3ST/S10diAo
	 jlpAHKsB8UIF9EbZs6hPLOQ8LutAmlEvoGlivfAyn4JMreVapHTDWSlt0Z7CxmknB2
	 3Bir742GDmMrQ==
Date: Mon, 22 Jan 2024 00:03:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 2/4] ASoC: qcom: sc8280xp: limit speaker volumes
Message-ID: <d54d3640-49bf-4a2f-903b-4beeb0ebd56c@sirena.org.uk>
References: <20240119112420.7446-1-johan+linaro@kernel.org>
 <20240119112420.7446-3-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ddqYfjTpQJcp+t1u"
Content-Disposition: inline
In-Reply-To: <20240119112420.7446-3-johan+linaro@kernel.org>
X-Cookie: 1: No code table for op: ++post


--ddqYfjTpQJcp+t1u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 19, 2024 at 12:24:18PM +0100, Johan Hovold wrote:
> The UCM configuration for the Lenovo ThinkPad X13s has up until now
> been setting the speaker PA volume to the minimum -3 dB when enabling
> the speakers, but this does not prevent the user from increasing the
> volume further.

This doesn't apply against current code, please check and resend.

--ddqYfjTpQJcp+t1u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWtsOoACgkQJNaLcl1U
h9A6sAf+MNxmG+32Oty1qqRKXBZ5RVX6g9r56r3iFPMAmhMHoSZSvmXUvPk2aG29
7Oy3y1c5yFMKmSVNq5Oi8XzLAua0Prpx1ziOSwRCgQSdZ+DRjcgxnh3lfFjH4gJI
8GbfQuWO6XYIU0Poi972LR/dofiuSOkcU6SriIdmoUIdWaplFT/hK0b9LwFMejzD
7p8XuQw/G0JQgztd/KGtTr1S/UyqTKbcg5hK7ON4woYsSQKWCdKq+hqXx67tyTAv
4fiRWsQoRqtTeAw2PCt0xi3yT6aMfeciOiScaz1uZwmym3Hs8gQ1H4TSV/ee6ieu
nUHFZS8Xq3xiYmO7DN+Fnx/eYSi46Q==
=0JpU
-----END PGP SIGNATURE-----

--ddqYfjTpQJcp+t1u--

