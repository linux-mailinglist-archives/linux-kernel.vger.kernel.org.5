Return-Path: <linux-kernel+bounces-144324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4638A44A2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B6DB21EA9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC65D1353E2;
	Sun, 14 Apr 2024 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I5YBCHBZ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35EC53363;
	Sun, 14 Apr 2024 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713119858; cv=none; b=PuzpS5VXkYVfMwR8znV4BnGkntBu81RuXIqfI6wbLeJGt41mre762CxfR3TeCfGaKTMq7FYy7lXAFFZzZHx5n7UoGFlvB1IFed3r7bxBhPx6pB36R2gKzRa5zlOiSFjWd6Uc0H3r8ypArN55ezwb7+cnaEi8U4rNFcaDQk3alIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713119858; c=relaxed/simple;
	bh=j+w4fKNpU6T4aF5Mgw+E1TM+E5nsSpnjLA9+Ti3MC78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YW0dtNgkvlabXGkEohyYqhX1xlD7W1NTNwqG7v6x+0jvchCudZ27JUP1+MfAHfcfxaTsXf3xX3NAY9+sPHjEBCDL3eeceuU/osXs/voIXrxse0oG8peVKbGd51wJLEC/nlH2hllu2RNqFJGXj6Ni6YS7PqQhmHBjPAqyfQ5Us3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I5YBCHBZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713119855;
	bh=j+w4fKNpU6T4aF5Mgw+E1TM+E5nsSpnjLA9+Ti3MC78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I5YBCHBZ/EUBkTOGjcoSw0qj3MxowkxRV8yVbzSLdsvh6mL64dfxGVnAtJPMmzKDw
	 q9MbzHd5a+9HZZtqNlO6nwHQgh0yN1yfn9YjrQsyLf61/3Sm75SfXF8Ur+OJ037ibF
	 nbRp0yi89f5y4xxPKVGNXXdq6gxUdCI3JDaZ0d2vPo4P0T6xlxDP9Pu39KUwlgib9D
	 EwfjvUssXYkp+59esgTwuUQD0GWM1Sm0ec+dMrKFmH/jegvzfDh8ltd7Jo3udZIp+F
	 Ah94KlTUcDIPLuN8K8ci8oKyn9TJAMnmz+qKytK2KAG0ZUSuEhnf+B9dhZnzPdriNu
	 Y3K3EnPSvTPzQ==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CA66437814A4;
	Sun, 14 Apr 2024 18:37:34 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 656A1106134A; Sun, 14 Apr 2024 20:37:25 +0200 (CEST)
Date: Sun, 14 Apr 2024 20:37:25 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, 
	ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de, mchehab@kernel.org, sfr@canb.auug.org.au
Subject: Re: [PATCH v5 2/2] dt-bindings: media: rockchip-vpu: Add rk3588
 vdpu121 compatible string
Message-ID: <yixa62wexs2334p4splrm7ps3ck6jwzm5apjsrrixvgi72lpds@326nldsvg7nw>
References: <20240413064608.788561-1-liujianfeng1994@gmail.com>
 <20240413064608.788561-3-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eab5rplsmu4hk3si"
Content-Disposition: inline
In-Reply-To: <20240413064608.788561-3-liujianfeng1994@gmail.com>


--eab5rplsmu4hk3si
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Apr 13, 2024 at 02:46:08PM +0800, Jianfeng Liu wrote:
> Add Hantro G1 VPU compatible string for RK3588.
> RK3588 has the same Hantro G1 ip as RK3568, which are both
> known as VDPU121 in TRM of RK3568 and RK3588.
>=20
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  Documentation/devicetree/bindings/media/rockchip-vpu.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml b/=
Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> index c57e1f488..4f667db91 100644
> --- a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> +++ b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> @@ -31,6 +31,9 @@ properties:
>        - items:
>            - const: rockchip,rk3228-vpu
>            - const: rockchip,rk3399-vpu
> +      - items:
> +          - const: rockchip,rk3588-vdpu121
> +          - const: rockchip,rk3568-vpu
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.34.1
>=20
>=20

--eab5rplsmu4hk3si
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYcImQACgkQ2O7X88g7
+poRKA/+KteRS0wlK8SQDVyHFdHTQnYvGGa05SYjADBfLtDGk+VS/gV/mcY31a+Q
bXEjlVfIammDm6Psp5GVvcUthBkUfo2Vjnvdv+uVeERo0SDrY2ATTdoXUdjxKmaG
XLLUybB9mYyFybFk+AbUYBikIgs86f3OL0rX/nSriP7p6imL9t/HQJ1lQCKDIqKo
HVw+VhqBizOQgx6BVdCgga4hyR0zGRZ8mQKsMbrVo08t4UOLac2oSsA1HR7uGHrj
Nm4uoAKjf8mU8I5VzpJqVquB7HfpOoz6T84kyLxTTMwpdckdh14UkAlBLWgS78Oj
LoYoXRS76gLo9EgIpGzu/CIc2O5q+cvB24qbmI61Z4BbwRQHCgNNwExW/00c77AJ
t409XUa7A65Sogki7woha9tCzdiprnVfXrzEyOrnXELIfKj5Z+Ygab/x/7R2vqLA
2YtCL3NtRmhPVBOzthEVohQFiB/mD6WQQoNBo2Bl7yQcsr1VhEkhzIoFIBrvS4J5
tJ1hPExlSFD3btUllmNtkDXnVGiqEXdi1D7kzpvZva/WnNhrG6Pb8gzi6z/mQhiM
JGI7tcIyXE1fjAuKasuQZUNeDIJ6pbkt4DtQb6bgKetlPp3dKe8IMDLCvvqzTBwz
9aXHEz9GImTaEvOIgeHZANmqRZ7RFWcpaulzfAXrrNAFgyPxa7Y=
=g+at
-----END PGP SIGNATURE-----

--eab5rplsmu4hk3si--

