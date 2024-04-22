Return-Path: <linux-kernel+bounces-153660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E598AD145
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827D71F2327B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C5115357F;
	Mon, 22 Apr 2024 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYe8ZdHK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D728415351B;
	Mon, 22 Apr 2024 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801051; cv=none; b=blhvrP9mdkXLEbhl65OruMSMgiCLrF0WWjsCpN0k9msR/RL6kuBHm5kc14Y+X2wR53Otn7bitqjQQeD1Yvrgq4JmZxDTmhKN9gyE5EyXHMzv+1wRY3PZidYmHDIkrPRT53vm5ZPS6xG8Gnb/bcr3Y4FcLTwsQcFh9a71eKN4IbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801051; c=relaxed/simple;
	bh=wzD5FJqyLbvetXi2p0Mj7eEu1Rvd1yeTzfQasvtc1os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKk16yX5Uf3tFBe/tSzBryaAG++NdmGgmaMBVK/s/2tJGjpfb+ldiUqUD9DPLImHVggrDK/RP7mY10vvEjPat1Gm9/J9ieipoJ5IAv5Levxy24p9ucFkbACp1kfZWdu7PPxSXBvFoNR8zbXE4tkrImQ6A01GELPdWgXGYLWfNyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYe8ZdHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC42C113CC;
	Mon, 22 Apr 2024 15:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713801050;
	bh=wzD5FJqyLbvetXi2p0Mj7eEu1Rvd1yeTzfQasvtc1os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DYe8ZdHK0RmNCkmjV/DITUcuuGq81cN95EdnPQEicoYAfN+IFnn6VbLLJi/FS1gt/
	 gHA2uqN6tblylT/fJjbkfiprBcKrsPzusOhfHlWAyyfv4Cz5UuO3W83S8VYlRujMlF
	 N1ehMUwb0F4LkL1BoJqUl5MybdKDp6DX6qQjzlYf5nlI19j2ZSY9rPo5qxUArHdxqj
	 I688+E4bbUguTVr+edoCe3y5q0pZ9oqOQq+EsspiWE/QmHFcc3ETbYw6yfTHsTXWMI
	 59JLOAyTq+YoSorK7oTgb/oBTRKQTm9aw/fXPeAIeRxSrzD23mEcNYi32ffdHiao9L
	 KaeDXu4RFS+gA==
Date: Mon, 22 Apr 2024 16:50:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Parthiban.Veerasooran@microchip.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrew@lunn.ch, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 12/12] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Message-ID: <20240422-duty-skedaddle-37e21a76f3f2@spud>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-13-Parthiban.Veerasooran@microchip.com>
 <20240418-hypnosis-oblong-028c107e6c3f@spud>
 <a2c2d5ae-f709-42bf-9b60-c4428da4197d@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jHF5bh9/3sCMMvxg"
Content-Disposition: inline
In-Reply-To: <a2c2d5ae-f709-42bf-9b60-c4428da4197d@microchip.com>


--jHF5bh9/3sCMMvxg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 03:59:31AM +0000, Parthiban.Veerasooran@microchip.c=
om wrote:
> OK. If you agree with the above changes that you expected then I will=20
> add the tag in the next version with the proposed changes.

ye, they seem good, you can retain it.

--jHF5bh9/3sCMMvxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiaHUwAKCRB4tDGHoIJi
0qlQAQD+/Mk2cqJkGSomIBljWVHfvybJ1BbBqr8Zovd0f4H6lgEAk7HtayJGwyal
B2E5xye0s+uHC10UMcvElUPAu7nigA8=
=arr8
-----END PGP SIGNATURE-----

--jHF5bh9/3sCMMvxg--

