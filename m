Return-Path: <linux-kernel+bounces-142747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6108A2FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E8FBB213B4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6194184A41;
	Fri, 12 Apr 2024 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLlUvI1E"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178095914E;
	Fri, 12 Apr 2024 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929332; cv=none; b=Wi9rMdhO4JLRJwOHb6aZuF44h/RRLJolQ3aj/P1GwI2ZY7I2xG5/jnLzVyFDoLT1eiZIeNDAfG/97qjriozKk3Axsa3J21SicNp6MufpAWpM6mCZx19/th4nBkCQpzx346WmvKLVkKN/G0LDw4bg9kr+yv9O/m+vKlKOwmnLHEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929332; c=relaxed/simple;
	bh=xfhdUWr+FK3ehEq4BJSMZt6PGr4ulOUSnBROKlcRrFg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KZbc02B5XUt/wLWCXVnvEctrHMq62uBLw3EuLHUdzAPQqbbd5VFqFogm0j6Jo7j7ayW2vObybRv2U4TnbE+MSGf5TcrC+JUfdCUEoL1P3jG9S5nDzr8mBN7ZBEmhcqGFQA/5fSM9kLPYDhMu/Aq33xuh6QOOIRoUVJrnofEv06I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLlUvI1E; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712929331; x=1744465331;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xfhdUWr+FK3ehEq4BJSMZt6PGr4ulOUSnBROKlcRrFg=;
  b=gLlUvI1Eeq6xmIWCIwoW01+qdcInd1XPskzz2/Y/11hRY4FAozQUV7jL
   5yetN10C3/TQKRNCJyYxb3IEdamj3YyOfWkDEACilsbz/30NqJPFu+v5G
   jco0w0tKX2vTZZOv3tqRaXGHGbCWqpP4K9txpGbj95V9dfR7opG/OFebV
   PWs3Y83BFjzY+9L3Uy5O399Tjc+JlL+/u0SITnOIRcPrwHzV44bAj+HR6
   4l1YnIXHK0rtg2TpkXsiXerJNgDEoS0zanKLCCBRaJtO/tnHh8NkNdDMJ
   T03znNOEoqMa2EXGowUyoZ3QkcC9ejAo5xiYarY1JYB8N3vwpDGX8Pu1N
   g==;
X-CSE-ConnectionGUID: BTShjTvcQBO5Z2sAJvlYxQ==
X-CSE-MsgGUID: CgIM26wNQAKA874tcgIbvQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8938566"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="8938566"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 06:42:08 -0700
X-CSE-ConnectionGUID: dex42KcgRSyWJZm0NznP4w==
X-CSE-MsgGUID: IOloDzXJQCSWDfkvDwtNsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="58663577"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 06:42:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 12 Apr 2024 16:42:01 +0300 (EEST)
To: Mark Pearson <mpearson-lenovo@squebb.ca>
cc: Mark Pearson <markpearson@lenovo.com>, Hans de Goede <hdegoede@redhat.com>, 
    "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] platform/x86: think-lmi: Convert container_of()
 macros to static inline
In-Reply-To: <212159e6-66b5-45d3-bce8-d6fde43370fe@app.fastmail.com>
Message-ID: <3bbac14a-23fd-33f3-a55c-1dde0c81bc29@linux.intel.com>
References: <20240412130903.2836-1-ilpo.jarvinen@linux.intel.com> <212159e6-66b5-45d3-bce8-d6fde43370fe@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-449063926-1712929321=:1014"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-449063926-1712929321=:1014
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 12 Apr 2024, Mark Pearson wrote:

> Thanks Ilpo,
>=20
> On Fri, Apr 12, 2024, at 9:09 AM, Ilpo J=C3=A4rvinen wrote:
> > The macros to_tlmi_pwd_setting() and to_tlmi_attr_setting() are fragile
> > because they expect the variable name to be 'kobj', otherwise the build
> > will fail because container_of()'s 3rd parameter (member) is taken from
> > the parameter given to the macro.
> >
> > While at it, move them into a more logical place.
> >
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/platform/x86/think-lmi.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/platform/x86/think-lmi.c=20
> > b/drivers/platform/x86/think-lmi.c
> > index 9345316b45db..0f2264bb7577 100644
> > --- a/drivers/platform/x86/think-lmi.c
> > +++ b/drivers/platform/x86/think-lmi.c
> > @@ -175,9 +175,6 @@ MODULE_PARM_DESC(debug_support, "Enable debug=20
> > command support");
> >  #define TLMI_SMP_PWD BIT(6) /* System Management */
> >  #define TLMI_CERT    BIT(7) /* Certificate Based */
> >=20
> > -#define to_tlmi_pwd_setting(kobj)  container_of(kobj, struct=20
> > tlmi_pwd_setting, kobj)
> > -#define to_tlmi_attr_setting(kobj)  container_of(kobj, struct=20
> > tlmi_attr_setting, kobj)
> > -
> >  static const struct tlmi_err_codes tlmi_errs[] =3D {
> >  =09{"Success", 0},
> >  =09{"Not Supported", -EOPNOTSUPP},
> > @@ -198,6 +195,16 @@ static struct think_lmi tlmi_priv;
> >  static const struct class *fw_attr_class;
> >  static DEFINE_MUTEX(tlmi_mutex);
> >=20
> > +static inline struct tlmi_pwd_setting *to_tlmi_pwd_setting(struct=20
> > kobject *kobj)
> > +{
> > +=09return container_of(kobj, struct tlmi_pwd_setting, kobj);
> > +}
> > +
> > +static inline struct tlmi_attr_setting *to_tlmi_attr_setting(struct=20
> > kobject *kobj)
> > +{
> > +=09return container_of(kobj, struct tlmi_attr_setting, kobj);
> > +}
> > +
> >  /* Convert BIOS WMI error string to suitable error code */
> >  static int tlmi_errstr_to_err(const char *errstr)
> >  {
> > --=20
> > 2.39.2
>=20
> Looks good to me. Let me know if you want this tested on Lenovo HW and=20
> I'll do a build with this in - but it looks very uncontroversial :)=20
>=20
> Reviewed-by Mark Pearson <mpearson-lenovo@squebbb.ca>

Yes, pretty uncontroversial so probably not worth the effort to test on=20
HW. The compile done by lkp is good enough to capture stupid mistakes=20
(which it already passed here internally before I even sent these out).

--=20
 i.

--8323328-449063926-1712929321=:1014--

