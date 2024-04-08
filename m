Return-Path: <linux-kernel+bounces-135968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB7589CE52
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 865FDB23567
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D38149C5C;
	Mon,  8 Apr 2024 22:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DjyYts4d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C32A148833;
	Mon,  8 Apr 2024 22:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712614312; cv=none; b=lUIrwrEV2qqHdnFdJP8WUeEtYFoOdOO/MYdDJaXkOLnVGVgcedgsVN2G797UEzqxaRXaIWsjxurJWrJfncV1SX3vuPIE7xIZe+6vyNkWNV3LE58Dye70dtjjHQ0mS2gv6z7w95aLiVmaG8TgeZToi91uUbBhJ4i1WxGkUPWDK3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712614312; c=relaxed/simple;
	bh=6CaajjRMxU6ExyUiP+Js6IlPxZ2GuFI6Ls3pLbonWcE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FWrunVklkDB3eEOEyJBgDbNQZdx4g5bck8s8noq3lBuFiwETOKG5AU+WJ9F2z01H1H2IIyAGk1EIyOq3Abfe5/s98jJnLs1M94NbKzoKU0KbAOmiouU8FDCWfJM0QfIIAxOC7ncIuV7upnDzHa0skMWQ32CnUYQqzr6kRUsPgN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DjyYts4d; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712614310; x=1744150310;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=6CaajjRMxU6ExyUiP+Js6IlPxZ2GuFI6Ls3pLbonWcE=;
  b=DjyYts4dTbN1dK0Rnax6HOyeLfN7G+Ew1aohXwlrhFUmctOrAo2Vn6lZ
   OXorVh5CsO7Oq034tLedDnN/xbL1mzZKfmWeo6NVH4qn0tjhphkF4GoxC
   31uLdWebCxf3cSebH0aw9p6RXOALdLGk6p4XQ2mJXs/To96vEHg2YPyZy
   IfJBAwwfSlS6NYHurNxBUwLDVJOYxSqCXCsfRUWo/dmI2UR/tvSxo2+Nu
   6CRq0CcPZvv7oUs14nzDRzvbFMxubBsNttYgIg0wPKF9xAqck+zxjbT14
   sutmHKt2z7BwNpco3AZX5mdfO2U24Inr53ogLi496TgLDwmPjxetglR+H
   A==;
X-CSE-ConnectionGUID: PKfbBqHpRlSh7ziMjsFZUw==
X-CSE-MsgGUID: yUBsJBneTCyrPQBAR9EFjQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="19295153"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="19295153"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 15:11:49 -0700
X-CSE-ConnectionGUID: K12hbKsiTNO36vICOUR9Hw==
X-CSE-MsgGUID: blluMDKCSC+LZjBHiSH3xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="57483734"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 15:11:49 -0700
Received: from [10.54.75.156] (debox1-desk1.jf.intel.com [10.54.75.156])
	by linux.intel.com (Postfix) with ESMTP id 2D3FF20B573A;
	Mon,  8 Apr 2024 15:11:49 -0700 (PDT)
Message-ID: <41b41cfbd79d8f9d0a9dfd187710015021fae252.camel@linux.intel.com>
Subject: Re: [PATCH V3 8/9] platform/x86/intel/sdsi: Simplify ascii printing
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org,  LKML <linux-kernel@vger.kernel.org>,
 sathyanarayanan.kuppuswamy@linux.intel.com
Date: Mon, 08 Apr 2024 15:11:49 -0700
In-Reply-To: <6dd8b2c0-1c89-43f0-0426-df8d483a7b1e@linux.intel.com>
References: <20240405032507.2637311-1-david.e.box@linux.intel.com>
	 <20240405032507.2637311-9-david.e.box@linux.intel.com>
	 <6dd8b2c0-1c89-43f0-0426-df8d483a7b1e@linux.intel.com>
Autocrypt: addr=david.e.box@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQENBF2w2YABCACw5TpqmFTR6SgsrNqZE8ro1q2lUgVZda26qIi8GeHmVBmu572RfPydisEpCK246rYM5YY9XAps810ZxgFlLyBqpE/rxB4Dqvh04QePD6fQNui/QCSpyZ6j9F8zl0zutOjfNTIQBkcar28hazL9I8CGnnMko21QDl4pkrq1dgLSgl2r2N1a6LJ2l8lLnQ1NJgPAev4BWo4WAwH2rZ94aukzAlkFizjZXmB/6em+lhinTR9hUeXpTwcaAvmCHmrUMxeOyhx+csO1uAPUjxL7olj2J83dv297RrpjMkDyuUOv8EJlPjvVogJF1QOd5MlkWdj+6vnVDRfO8zUwm2pqg25DABEBAAG0KkRhdmlkIEUuIEJveCA8ZGF2aWQuZS5ib3hAbGludXguaW50ZWwuY29tPokBTgQTAQgAOBYhBBFoZ8DYRC+DyeuV6X7Mry1gl3p/BQJdsNmAAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH7Mry1gl3p/NusIAK9z1xnXphedgZMGNzifGUs2UUw/xNl91Q9qRaYGyNYATI6E7zBYmynsUL/4yNFnXK8P/I7WMffiLoMqmUvNp9pG6oYYj8ouvbCexS21jgw54I3m61M+wTokieRIO/GettVlCGhz7YHlHtGGqhzzWB3CGPSJMwsouDPvyFFE+28p5d2v9l6rXSb7T297Kh50VX9Ele8QEKngrG+Z/u2lr/bHEhvx24vI8ka22cuTaZvThYMwLTSC4kq9L9WgRv31JBSa1pcbcHLOCoUl0RaQwe6J8w9hN2uxCssHrrfhSA4YjxKNIIp3YH4IpvzuDR3AadYz1klFTnEOxIM7fvQ2iGu5AQ0EXbDZgAEIAPGbL3wvbYUDGMoBSN89GtiC6ybWo28JSiYIN5N9LhDTwfWROenkRvmTESaE5fAM24sh8S0h+F+eQ7j/E/RF3pM31gSovTKw0Pxk7GorK
	FSa25CWemxSV97zV8fVegGkgfZkBMLUId+AYCD1d2R+tndtgjrHtVq/AeN0N09xv/d3a+Xzc4ib/SQh9mM50ksqiDY70EDe8hgPddYH80jHJtXFVA7Ar1ew24TIBF2rxYZQJGLe+Mt2zAzxOYeQTCW7WumD/ZoyMm7bg46/2rtricKnpaACM7M0r7g+1gUBowFjF4gFqY0tbLVQEB/H5e9We/C2zLG9r5/Lt22dj7I8A6kAEQEAAYkBNgQYAQgAIBYhBBFoZ8DYRC+DyeuV6X7Mry1gl3p/BQJdsNmAAhsMAAoJEH7Mry1gl3p/Z/AH/Re8YwzY5I9ByPM56B3Vkrh8qihZjsF7/WB14Ygl0HFzKSkSMTJ+fvZv19bk3lPIQi5lUBuU5rNruDNowCsnvXr+sFxFyTbXw0AQXIsnX+EkMg/JO+/V/UszZiqZPkvHsQipCFVLod/3G/yig9RUO7A/1efRi0E1iJAa6qHrPqE/kJANbz/x+9wcx1VfFwraFXbdT/P2JeOcW/USW89wzMRmOo+AiBSnTI4xvb1s/TxSfoLZvtoj2MR+2PW1zBALWYUKHOzhfFKs3cMufwIIoQUPVqGVeH+u6Asun6ZpNRxdDONop+uEXHe6q6LzI/NnczqoZQLhM8d1XqokYax/IZ4=
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-08 at 20:22 +0300, Ilpo J=C3=A4rvinen wrote:
> On Thu, 4 Apr 2024, David E. Box wrote:
>=20
> > Use printf width specifier to set the display length of encoded feature
> > names.
> >=20
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > Reviewed-by: Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com>
> > ---
> >=20
> > V3 - Add FEAT_LEN #def
> >=20
> > V2 - Split of V1 patch 7
> >=20
> > =C2=A0tools/arch/x86/intel_sdsi/intel_sdsi.c | 13 ++++++-------
> > =C2=A01 file changed, 6 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c
> > b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> > index 45bc69e6718e..0c9670ba1f15 100644
> > --- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
> > +++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> > @@ -43,6 +43,7 @@
> > =C2=A0#define METER_CERT_MAX_SIZE	4096
> > =C2=A0#define STATE_MAX_NUM_LICENSES	16
> > =C2=A0#define STATE_MAX_NUM_IN_BUNDLE	(uint32_t)8
> > +#define FEAT_LEN		4
> > =C2=A0
> > =C2=A0#define __round_mask(x, y) ((__typeof__(x))((y) - 1))
> > =C2=A0#define round_up(x, y) ((((x) - 1) | __round_mask(x, y)) + 1)
> > @@ -409,11 +410,10 @@ static int sdsi_meter_cert_show(struct sdsi_dev *=
s)
> > =C2=A0
> > =C2=A0	printf("Number of Feature Counters:=C2=A0=C2=A0 %ld\n", BUNDLE_C=
OUNT(mc-
> > >bundle_length));
> > =C2=A0	while (count < BUNDLE_COUNT(mc->bundle_length)) {
> > -		char feature[5];
> > +		char feature[FEAT_LEN];
> > =C2=A0
> > -		feature[4] =3D '\0';
> > =C2=A0		get_feature(bec[count].encoding, feature);
> > -		printf("=C2=A0=C2=A0=C2=A0 %s:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 %d\n", feature,
> > bec[count].counter);
> > +		printf("=C2=A0=C2=A0=C2=A0 %.4s:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 %d\n", feature,
> > bec[count].counter);
> > =C2=A0		++count;
> > =C2=A0	}
> > =C2=A0
> > @@ -494,7 +494,7 @@ static int sdsi_state_cert_show(struct sdsi_dev *s)
> > =C2=A0			sizeof(*lki) +			// size of the
> > license key info
> > =C2=A0			offset;				// offset
> > to this blob content
> > =C2=A0		struct bundle_encoding *bundle =3D (void *)(lbc) +
> > sizeof(*lbc);
> > -		char feature[5];
> > +		char feature[FEAT_LEN];
> > =C2=A0		uint32_t i;
> > =C2=A0
> > =C2=A0		printf("=C2=A0=C2=A0=C2=A0=C2=A0 Blob %d:\n", count - 1);
> > @@ -507,11 +507,9 @@ static int sdsi_state_cert_show(struct sdsi_dev *s=
)
> > =C2=A0		printf("=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Blob revisio=
n ID:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 %u\n", lb=
c-
> > >rev_id);
> > =C2=A0		printf("=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Number of Fe=
atures:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 %u\n", lbc-
> > >num_bundles);
> > =C2=A0
> > -		feature[4] =3D '\0';
> > -
> > =C2=A0		for (i =3D 0; i < min(lbc->num_bundles,
> > STATE_MAX_NUM_IN_BUNDLE); i++) {
> > =C2=A0			get_feature(bundle[i].encoding, feature);
> > -			printf("=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Feature %d:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 %s\n",
> > i, feature);
> > +			printf("=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Feature %d:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
> > %.4s\n", i, feature);
> > =C2=A0		}
> > =C2=A0
> > =C2=A0		if (lbc->num_bundles > STATE_MAX_NUM_IN_BUNDLE)
> >=20
>=20
> Hi,
>=20
> After staring this for a while, I cannot get rid of the feeling that the=
=20
> removal of NUL termination is a step into wrong direction. But IMO,=20
> instead of the caller side, the NUL termination could be added inside=20
> get_feature().

Yeah, you're right. I'll make this change.

David
>=20


