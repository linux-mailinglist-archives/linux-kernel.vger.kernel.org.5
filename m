Return-Path: <linux-kernel+bounces-24894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F6682C456
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07851C21E5F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD1417C91;
	Fri, 12 Jan 2024 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwcx.xyz header.i=@stwcx.xyz header.b="WPTnOeXo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="adG3xgjH"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595731B5B0;
	Fri, 12 Jan 2024 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stwcx.xyz
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 428B65C00D7;
	Fri, 12 Jan 2024 12:10:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 12 Jan 2024 12:10:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1705079416; x=1705165816; bh=6t9tkHSHY0
	3J3FJd9VFP7fSE46+e9q4X4t4jYGLhC3Q=; b=WPTnOeXoYjLYVs5TSmIhrTx9tp
	Z3j9Q/S4yjDv/8jKxMlAxVDcikUCNLSjvCCfeX1QoX0IAEbrv4ZqUpwH7byGLL1y
	a8Guyf772wObpVIrbi+r9yBNrSasrVnyXKJwuxwUtoxbH781iHr+wJnhu/NTMsDP
	vA1ij0w9MZnUFfNpPZCpz79AauQTHuwiDxVNTbdij2vahghB1hj/oLzncwGv6Nsw
	RgUKv6BGxiHv9f2ir8ltl2E9eUJyECQKIVUBm1fUE1z1lFzfLEqQZ960kXADmca3
	gzdypK7+6vxwrdgKG6EKWVHtKIF/lodO6nGhSSji/muC8G3tnIwUyAb+TyGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1705079416; x=1705165816; bh=6t9tkHSHY03J3FJd9VFP7fSE46+e
	9q4X4t4jYGLhC3Q=; b=adG3xgjHU+Zjq6dqlMpf7yCJqjpwCKFBhv41EmkbPggR
	wohabNOSGESi3mYp4Qsicyvjk0pS65dxe+6HzSE2TolZBK5zc+wXa/2WuS1Elv2z
	/vqIoTBCYxgmRiUSYJkG04i5R+FUaOc9a+Sb9hm4zbjvqo0QzL701YZVgxvM7qXQ
	J2yIyqn52g3iDYAO9pUKUgNizFFgnBVdSOyo77GH8O9j4Vng911ZDlmn4RxLfKE+
	Ai5Jf1EN8/6fE3seiJZOoQOq8R4uGOAfduwFAckz6GlzXgl1EB4IJl+XzEor+nk/
	JjIVJhbV+Rjb9yxfDAWU/9KoxtXUr+MfgDs9lISjzw==
X-ME-Sender: <xms:d3KhZfstFkN7X1IA857DWtw1JlXpfiMSPlpbmpMraqH1w75zvKmhvA>
    <xme:d3KhZQcyG9PzOZGHNGQ2hwuFqYpWX0NTBL83-wXpaVFjrj_KW_CnUE21ojzm7F_fl
    uEk4bj4U3kU4EKXWeY>
X-ME-Received: <xmr:d3KhZSzvWnlN2t3L2_jK-hTas8uTwfGqWDIcDV343neRjwZGXkmX8Vghwao4c_HX1uiBvCSEYbysIj8Rlh7SGfqgO3-O1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeihedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredt
    tddvnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghkse
    hsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpeejgfdtleelvdeftdeggefffeeu
    feevgeejkeelgeeujeevveeufeeigfeivdejjeenucffohhmrghinhepkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    phgrthhrihgtkhesshhtfigtgidrgiihii
X-ME-Proxy: <xmx:d3KhZePJDEgfoJmJufJl8Xz6hXIMbKmQRGgssl-nfva_u79pZpBk1w>
    <xmx:d3KhZf-rW17pZ5jddg3UseSpgjunX8JWp_0uT77yuAYosc623hHSsA>
    <xmx:d3KhZeXxibud9-I5IMn5PMjPnuNym9EuzIHtg4p5n9CAo2g-x2_n9w>
    <xmx:eHKhZVdPwRpUaVJ4Zy5b5jBvacDK6gY7TWpjeeeCr4vY1EtUljRWKA>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jan 2024 12:10:15 -0500 (EST)
Date: Fri, 12 Jan 2024 11:10:13 -0600
From: Patrick Williams <patrick@stwcx.xyz>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: nuvoton: add Facebook Yosemite
 4 board
Message-ID: <ZaFydbPxbeczo97t@heinlein.vulture-banana.ts.net>
References: <20240112013654.1424451-1-Delphine_CC_Chiu@wiwynn.com>
 <20240112013654.1424451-2-Delphine_CC_Chiu@wiwynn.com>
 <8efef092-e70f-46c0-a60a-e62e676d6eb2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BTi6Ed7Pg45XEs67"
Content-Disposition: inline
In-Reply-To: <8efef092-e70f-46c0-a60a-e62e676d6eb2@linaro.org>


--BTi6Ed7Pg45XEs67
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 08:10:25AM +0100, Krzysztof Kozlowski wrote:
> On 12/01/2024 02:36, Delphine CC Chiu wrote:
> > Document the new compatibles used on Facebook Yosemite 4.
>=20
> There is Yosemite4 board already supported. What is this for?
> https://lore.kernel.org/all/20240109072053.3980855-5-Delphine_CC_Chiu@wiw=
ynn.com/

Yosemite4 is a server chassis which is managed by a BMC.  The BMC is on
a pluggable module card.  Typically we've used Aspeed chips for this,
but we are building an alternative BMC module using Nuvoton BMC chips.

We will end up with two different BMC chips / images that could be
managing the same server hardware.  Since the Aspeed and Nuvoton chips
are different there are unfortunately 2 device trees (one for each chip).

Please let us know if there is a better way to document this.

--=20
Patrick Williams

--BTi6Ed7Pg45XEs67
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmWhcnQACgkQqwNHzC0A
wRkQaBAAqf3Cbix/1kqF/Yn78RxWyYIoNtMi91/NKi5MBZfL7oJmTHrlgnaORp8d
G5DFSOGTcK5GU1yqFE6iu1YY2MdPVSFCF55AuH/zfydj+cbkBGxfGH9YlBZ25mYN
wfxME7Vdkf9Cm3B1awU8w86LKv1EuwRDTVhp545gzKqi0niQrpBK/crkWEq6vnhL
q2yooPh4vq/8ygX5IFcuRjxUi/o0b4fHRJ37p43b49njEGpIRB6+wYn/4i32JzS0
LZYPa8fSvOHX7DOuNBHo/sFA6fiD7f8AV37dZXWefL36q1ThhGLas3+Pqnf5/VtL
dOcAP5BV81xY6eCMh1neaJI2bcrgbzEJrh1Y5yF4vEbE+vgeG/dp9YZ7bjzyO3lB
Bk0TXyDStgOJVEDFijFrKCOiOWNr8u5QKpooHixKTj7u6gqRMXj7jl0DP0Sn/6Nv
SzFFM+RVG8M72XYMb+1wvAfFB52sxWwVVGRSJSK5H4SCXcDWzQ01UVEEOn8MBRuJ
jAQMp8a4HGTzKfjMtlqhaJB5cdmfjNtTNJGs5tYy7pK9ZCDTO7VZ2H8aTmlAgaWz
n6NDWZV4ZtkgYJbqzGcZp0r0lCNrvrFTGTGcIp6miwpQwLGG2TrWj2Cg/whuEwzb
cTbTDgLw+yclJpACfAoYJsXJ7QgiLw06FMJRXNDZHspkaCsHpdI=
=emjY
-----END PGP SIGNATURE-----

--BTi6Ed7Pg45XEs67--

