Return-Path: <linux-kernel+bounces-39924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BB683D776
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F34F1F23721
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BBD208D9;
	Fri, 26 Jan 2024 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Nv7Wk/SZ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB72020306;
	Fri, 26 Jan 2024 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261355; cv=none; b=MBvx/QwOXvEwvoQ715aLWPyh1Q3nVTRTA43AiWuUCLBae+6cmWnbSRFQna7PeNlLsI4t6QJehUffQo07v4Awh4FLMGTW6w96K3xi70/L3n4gQhf4hqdiYzT5VGtadYTmJOl/U7ZdTXShJR5pTLP5RN304fN0wnC9KbMT9r53ICc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261355; c=relaxed/simple;
	bh=nKBYb8AiFMDEoSH6ix/SA0rKwkG4+NOIJo8+mqHka+k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqZR1tbMhe7JpDlVRMSd3cLRR/Edq9tz2Xi9Eij1G6r5eH5CpQW4S6TA1bb9fjPysfNgwQgtD6kkHzQsuU0lDnehZjAJGOB+bxTLvWlYusgq/wXDmpGsMDPsFYSl7dBLNoG/QEuc3SL2KRAGcorByanQt9xCwqhpQuaV2udqEgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Nv7Wk/SZ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706261353; x=1737797353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nKBYb8AiFMDEoSH6ix/SA0rKwkG4+NOIJo8+mqHka+k=;
  b=Nv7Wk/SZ4OeUG5/lgtmtkdY/nZ56KmNhG7L+ZXrRrMlVUjUhFM0STYk1
   RgHG6IHf4xtQpXkqpcTtIPwMsMygvZ/kUMvt+Vxwjf4+hYCc6d2Xa44Rq
   f9euWSVT/jR16ZGvaK5HnoLghe9FA5Ebm0ffN6v+kUlO5Sjm4yQfzFbAv
   LYOdEpK7aqEO236Oc7y9eO8SoNmffFbdOFXVUvuO5d+50d5unhznFggtd
   UTU/R9hZRcNK8f9wNYTl2LG3wSskKogwvN8cVarYcf/uoSl8rttlW+BsY
   YEOoopVpcVKWqpWE/xyQJm2PjlRLtvdk6fKthNM4XC7QSGD/NZOEymoY3
   w==;
X-CSE-ConnectionGUID: DXk/349nTLGQJU8P3BOkdw==
X-CSE-MsgGUID: uxq0XLC8Q4qT3IJ/CM0bvA==
X-IronPort-AV: E=Sophos;i="6.05,216,1701154800"; 
   d="asc'?scan'208";a="15343956"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jan 2024 02:29:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 02:28:30 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 26 Jan 2024 02:28:27 -0700
Date: Fri, 26 Jan 2024 09:27:50 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Conor Dooley <conor@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <chunfeng.yun@mediatek.com>,
	<gregkh@linuxfoundation.org>, <conor+dt@kernel.org>,
	<matthias.bgg@gmail.com>, <linux@roeck-us.net>,
	<heikki.krogerus@linux.intel.com>, <cy_huang@richtek.com>,
	<linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: mt6360-tcpc: Drop
 interrupt-names
Message-ID: <20240126-shut-gusto-1da71fd410be@wendy>
References: <20240119094105.98312-1-angelogioacchino.delregno@collabora.com>
 <20240119-eldest-discharge-e2d3812be0a9@spud>
 <12b7b339-498b-45c1-bc5e-05e07660aefa@collabora.com>
 <20240123-procurer-jumbo-ebbec485505d@spud>
 <4fdbc3d8-3d44-4c2c-aae6-daa0b431e1c9@collabora.com>
 <dc9773aa-690f-47b5-b60a-a79c1e2dbaf2@linaro.org>
 <abbc1135-6d32-421a-baea-123a9f761362@collabora.com>
 <20240125-disdain-delivery-ff3bf246bbe1@spud>
 <20240125-elective-sermon-32dc2cba79be@spud>
 <27070454-09e6-422b-95f0-5d674735426b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7Cd24lZZUOXWuHuK"
Content-Disposition: inline
In-Reply-To: <27070454-09e6-422b-95f0-5d674735426b@collabora.com>

--7Cd24lZZUOXWuHuK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 10:15:54AM +0100, AngeloGioacchino Del Regno wrote:
> > | required:
> > |   - compatible
> > |   - interrupts
> > |   - interrupt-names
> >=20
> > It looks like it is a required property after all!
>=20
> Apparently my brain's binding had
>=20
> required:
>   - blindness
>=20
> :-P
>=20
> Yeah, I have no idea why I didn't see that, sorry!

Possibly because your patch never removed it from required in the first
place, if you only looked back at that, and not the binding (or Rob's
bot's report), I can see how you could miss it.

--7Cd24lZZUOXWuHuK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbN7CAAKCRB4tDGHoIJi
0s1AAP99lEEN3Rs36ZLVjjD7+MTaVanX2HF/Wf0i0gDwQVdu0gEAnmQlWcC9h9ni
yidZUPY+ZpGMidClS9ob3KGIc+iQ3AA=
=3mBr
-----END PGP SIGNATURE-----

--7Cd24lZZUOXWuHuK--

