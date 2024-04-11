Return-Path: <linux-kernel+bounces-140718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA1F8A1835
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103D91F24DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AF515E8C;
	Thu, 11 Apr 2024 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5aismU0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D661401B;
	Thu, 11 Apr 2024 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848085; cv=none; b=JtkC8UJ555A7ks7Sm7iIe6y0E9HXd7/V0UGCAYxVOl3jtQTnJJgiwuSGLj5FUkKIPZwXPhX/vp6sQ8lYlMqdBXVNGsbT2tLoK24vgGt+jEL9Gz93d7YiIp1MhR9kP+6c7giaaaOi1mbhYwvyosv+NWB4bl18MmuTfqA3Ha8sutA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848085; c=relaxed/simple;
	bh=LtKmInfvvXLuX9FjOPuZcypEVAmbMoQUI//+Js4u4jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mu5XAtkK5L8Nfsv7bbF5MPBPK6NeS2T14ymooIMjo+zPyBu6W1C+ST4RHvsdnc94AZK5khsEGYAbdI00Xg2PBiSp1zj8FQ1D9DBbx7bf1N4MQ+pyT4ZEIm/GpKzNJ0VFZ+GqUk8HA5lmE2NCZToyXqOHQsCTyOeeFO83LLpUviY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5aismU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B28C113CE;
	Thu, 11 Apr 2024 15:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712848085;
	bh=LtKmInfvvXLuX9FjOPuZcypEVAmbMoQUI//+Js4u4jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n5aismU0vXber0p51QIM8mdivnNrkHImcg300Uaw/WmMEWrp3KqD529jG5qdbqjjp
	 UG9ceR5/+wz/mILsqt2hVjHluUXe2Behelh8xKrt8HtD1zrL9DG/3BPcLEbnN499/y
	 ywksKJri2Ftmtokp+1y9617wCTkrzjz2KAqOYTWtyk0c4zBitJC7SjPBSfnbrAhOGe
	 RjbftPe8gc8X8eH1nZZp3FWzTTvAGegXY7wjGS3l54WIrAgWxD4pdj9/V7naqAhzzG
	 qMILzRQ5klHGUmJrYGgb1sl5Yrz/3progW69ozjN7MqI6KS7iBSQBaXyjVmeaKYWB0
	 hfVyuO6bR2krw==
Date: Thu, 11 Apr 2024 16:07:59 +0100
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-scsi@vger.kernel.org, alim.akhtar@samsung.com,
	avri.altman@wdc.com, bvanassche@acm.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	peter.wang@mediatek.com, chu.stanley@gmail.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, lgirdwood@gmail.com, broonie@kernel.org,
	matthias.bgg@gmail.com, stanley.chu@mediatek.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 6/8] dt-bindings: ufs: mediatek,ufs: Document MT8195
 compatible
Message-ID: <20240411-cost-subsiding-2b99ade956ee@spud>
References: <20240411114300.169055-1-angelogioacchino.delregno@collabora.com>
 <20240411114300.169055-7-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y+fy7khI6h2d52aa"
Content-Disposition: inline
In-Reply-To: <20240411114300.169055-7-angelogioacchino.delregno@collabora.com>


--Y+fy7khI6h2d52aa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 01:42:58PM +0200, AngeloGioacchino Del Regno wrote:
> Add the new mediatek,mt8195-ufshci string.
> This SoC's UFSHCI controller is compatible with MT8183.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--Y+fy7khI6h2d52aa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhf8zwAKCRB4tDGHoIJi
0tFHAPoCC8Edra9DDj9qJuyLaXU+Uk2JdEUGbsBA/PVWegEknQD/XQwlh9pqIMzw
ZUU44BE3klW5g2qrJHtbKf8NW+GnbQs=
=AFco
-----END PGP SIGNATURE-----

--Y+fy7khI6h2d52aa--

