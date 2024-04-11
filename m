Return-Path: <linux-kernel+bounces-140507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 784C88A158C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04799B26640
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B658A14EC58;
	Thu, 11 Apr 2024 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZvEDXoyV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFD014D432;
	Thu, 11 Apr 2024 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842187; cv=none; b=LaLnv7IzMhrlZwy2W8VDENiAOFoZsafShkNPKBP0cHxJa2/bcvvMXl54COaXvU5LebqYkiHp/JapfDGcLfF7maBuuivMegrFETUiaWzlYukyeGDXtwAFkFANT6ry8WGdPYM3IFI+7ShVW+il6prgjsjqLmCegU4iS0f0Lvr9jJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842187; c=relaxed/simple;
	bh=rlhUbue3Okuksf9A4eO6cufPxBHqURR74Vpnu3TJTRI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ily2m73d9dG8/y+0ELlSCOQL8YJRE19BDjnjnjqaDVKQwoPOr9XReSBjDCNCySSueWYz1SnJQj94YviGN0bJRIvbI15O2/ze+YBZQC/XgdosHn2FGiX0uYHpRr6PV7ToQX8CiP6MVhw7RNJ4zu5AdqgwsDX7XsXslI9myfn5bps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZvEDXoyV; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712842186; x=1744378186;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rlhUbue3Okuksf9A4eO6cufPxBHqURR74Vpnu3TJTRI=;
  b=ZvEDXoyVlFd4e48hXm3kADoYh5w3rM3VyZDF31zXmd9I0z5itb2oXajY
   lF87EbcjsEuIAWIcSbR0q0WwTONu6Q7Tl5qS46rDa1UMTJqK7Njiz/EcK
   NLwhJeTTqUoMyTIS//Lr4rC5UaOHqGKpHRqpj8dQOGsIgpg+LU7Kmu7FF
   4VEtZvshh2FCbpTSR6+P0CHtkmXNiuA0UZ1RM1MH806l+ERbUQCXr/I66
   +9PJLRHP9HhmZ1U9O+kDnQpt0FsmfObIwnBvejlPZ1ZhC4MLoPwMFTZ2+
   LuMWyhb23nGYG6kRUU8y3s9KpTj/3K++RX528tXVoJ4IEukO+cnn6Y99+
   Q==;
X-CSE-ConnectionGUID: +frMXBvuSO2t3TrBkdPw1g==
X-CSE-MsgGUID: 0fG1HeWARwOkBFwcjDBJSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="18958339"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="18958339"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 06:25:57 -0700
X-CSE-ConnectionGUID: 1l85Ri6bRUisX1ZFlaqEMA==
X-CSE-MsgGUID: iSdZOJNtSpC9k56ui8EMmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="20948262"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 06:25:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Apr 2024 16:25:50 +0300 (EEST)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH V4 8/9] platform/x86/intel/sdsi: Simplify ascii
 printing
In-Reply-To: <77993eef-b896-7e75-93ba-a76f126b5fad@linux.intel.com>
Message-ID: <626fd010-aa6e-2963-5860-658b6069e035@linux.intel.com>
References: <20240411025856.2782476-1-david.e.box@linux.intel.com> <20240411025856.2782476-9-david.e.box@linux.intel.com> <77993eef-b896-7e75-93ba-a76f126b5fad@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-326121552-1712841950=:1017"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-326121552-1712841950=:1017
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 11 Apr 2024, Ilpo J=E4rvinen wrote:

> On Wed, 10 Apr 2024, David E. Box wrote:
>=20
> > Add #define for feature length and move NUL assignment from callers to
> > get_feature().
> >=20
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> > ---
> > V4 - Move NUL assignment to get_feature() and increment FEAT_LEN.
> >=20
> > V3 - Add FEAT_LEN #def
> >=20
> > V2 - Split of V1 patch 7
> >=20
> >  tools/arch/x86/intel_sdsi/intel_sdsi.c | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/in=
tel_sdsi/intel_sdsi.c
> > index ba2a6b6645ae..301213370740 100644
> > --- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
> > +++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> > @@ -43,6 +43,7 @@
> >  #define METER_CERT_MAX_SIZE=094096
> >  #define STATE_MAX_NUM_LICENSES=0916
> >  #define STATE_MAX_NUM_IN_BUNDLE=09(uint32_t)8
> > +#define FEAT_LEN=09=095=09/* 4 plus NUL terminator */
> > =20
> >  #define __round_mask(x, y) ((__typeof__(x))((y) - 1))
> >  #define round_up(x, y) ((((x) - 1) | __round_mask(x, y)) + 1)
> > @@ -321,10 +322,11 @@ static char *content_type(uint32_t type)
> >  =09}
> >  }
> > =20
> > -static void get_feature(uint32_t encoding, char *feature)
> > +static void get_feature(uint32_t encoding, char feature[5])
> >  {
> >  =09char *name =3D (char *)&encoding;
> > =20
> > +=09feature[4] =3D '\0';
> >  =09feature[3] =3D name[0];
> >  =09feature[2] =3D name[1];
> >  =09feature[1] =3D name[2];
>=20
> Works, assuming none of the name bytes are 0.

Before somebody starts to wonder, while writing that, I thought this patch=
=20
was also about alignment (were <4 chars would have mattered), which was=20
just wrong recollection from my part and related to some other patch in=20
this series.

> Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-326121552-1712841950=:1017--

