Return-Path: <linux-kernel+bounces-140120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 763218A0BA0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7618D1C22D04
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4ACE143C51;
	Thu, 11 Apr 2024 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VFzRimod"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D671422CC;
	Thu, 11 Apr 2024 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712825535; cv=none; b=i5gzzWDOAqfTP5tbKFgs0lxVhZilvJyMdQPQU3t/Bz7qtaXNwoB0EUeHjgFUzXmgWjs7ZGCw1dg111yaOSYQ2qVRkm42jbL8iUvKE42X1lAm5EJxDQzA3GSrj007ikeWG1RubvAKvJRdVsSLXKyCtcCKyYTZ2qjeac6GkJr00yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712825535; c=relaxed/simple;
	bh=Lmp+/nQbro7M10fnzbwdyIkY7l8hkTvrz2rPgWvaS2s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IlR/wPO00ecOX2QzTqcBrW+9AIIf5ZCdam3VPUE/8a66Z+vpUOayQ0oXtW/jwAhlHqjw/utyxN9inew2Z/n2OERkmzVACqFuhyFvMjs5366FmNqwnpIgMIpkc+Cfmd5ZT4NEYQHLyXtqPtxbH4KMMPjIynhy/NlXaC89uhGXiiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VFzRimod; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712825533; x=1744361533;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Lmp+/nQbro7M10fnzbwdyIkY7l8hkTvrz2rPgWvaS2s=;
  b=VFzRimod6BP9kudbAmlTzcNXYX1w/aYa4TcpMdpghPlBASurbrLvWYqm
   03F0fohRADpW5G9PLvQIta40VKsZMadlFRrqGBaErCM/KREQXMLzDvvcL
   9pIqdSCC6SUmpa6SMwINF9A2geDg8LS5S4HFdJyrVsyF7bgsNrJxBaZ4w
   0E2PF0cxJnw88GyELC2W/8q61RpxZmASeo3H0kZo9u02mOJG2SYUCtDDO
   YTSWDKVkbxXBoOHD9waE4HKdtd9FTZ0QVh5OtB0EPArNWfSiwgviV2SIW
   zjveo6mLqkRR2XF4ijufYV/COB9vTZUL2I1IYaLOxlPyYH7iUAXB8Knf7
   A==;
X-CSE-ConnectionGUID: WYVkxo0MTJ6UZJZ3539stA==
X-CSE-MsgGUID: uNFeFnuNQdesrUfD/ja1nA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8386897"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8386897"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 01:52:13 -0700
X-CSE-ConnectionGUID: 5is+jPGDQE2tVNTNpf8inQ==
X-CSE-MsgGUID: gnVtjtZRQA60saBAH+BdEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="25318573"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.30])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 01:52:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Apr 2024 11:52:06 +0300 (EEST)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH V4 8/9] platform/x86/intel/sdsi: Simplify ascii
 printing
In-Reply-To: <20240411025856.2782476-9-david.e.box@linux.intel.com>
Message-ID: <77993eef-b896-7e75-93ba-a76f126b5fad@linux.intel.com>
References: <20240411025856.2782476-1-david.e.box@linux.intel.com> <20240411025856.2782476-9-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1072423584-1712825526=:1017"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1072423584-1712825526=:1017
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 10 Apr 2024, David E. Box wrote:

> Add #define for feature length and move NUL assignment from callers to
> get_feature().
>=20
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux=
=2Eintel.com>
> ---
> V4 - Move NUL assignment to get_feature() and increment FEAT_LEN.
>=20
> V3 - Add FEAT_LEN #def
>=20
> V2 - Split of V1 patch 7
>=20
>  tools/arch/x86/intel_sdsi/intel_sdsi.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/inte=
l_sdsi/intel_sdsi.c
> index ba2a6b6645ae..301213370740 100644
> --- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
> +++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> @@ -43,6 +43,7 @@
>  #define METER_CERT_MAX_SIZE=094096
>  #define STATE_MAX_NUM_LICENSES=0916
>  #define STATE_MAX_NUM_IN_BUNDLE=09(uint32_t)8
> +#define FEAT_LEN=09=095=09/* 4 plus NUL terminator */
> =20
>  #define __round_mask(x, y) ((__typeof__(x))((y) - 1))
>  #define round_up(x, y) ((((x) - 1) | __round_mask(x, y)) + 1)
> @@ -321,10 +322,11 @@ static char *content_type(uint32_t type)
>  =09}
>  }
> =20
> -static void get_feature(uint32_t encoding, char *feature)
> +static void get_feature(uint32_t encoding, char feature[5])
>  {
>  =09char *name =3D (char *)&encoding;
> =20
> +=09feature[4] =3D '\0';
>  =09feature[3] =3D name[0];
>  =09feature[2] =3D name[1];
>  =09feature[1] =3D name[2];

Works, assuming none of the name bytes are 0.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> @@ -339,7 +341,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  =09uint32_t count =3D 0;
>  =09FILE *cert_ptr;
>  =09int ret, size;
> -=09char name[4];
> +=09char name[FEAT_LEN];
> =20
>  =09ret =3D sdsi_update_registers(s);
>  =09if (ret)
> @@ -383,7 +385,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  =09printf("\n");
> =20
>  =09get_feature(mc->signature, name);
> -=09printf("Signature:                    %.4s\n", name);
> +=09printf("Signature:                    %s\n", name);
> =20
>  =09printf("Version:                      %d\n", mc->version);
>  =09printf("Count Unit:                   %dms\n", mc->counter_unit);
> @@ -391,7 +393,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  =09printf("Feature Bundle Length:        %d\n", mc->bundle_length);
> =20
>  =09get_feature(mc->mmrc_encoding, name);
> -=09printf("MMRC encoding:                %.4s\n", name);
> +=09printf("MMRC encoding:                %s\n", name);
> =20
>  =09printf("MMRC counter:                 %d\n", mc->mmrc_counter);
>  =09if (mc->bundle_length % METER_BUNDLE_SIZE) {
> @@ -409,9 +411,8 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
> =20
>  =09printf("Number of Feature Counters:   %ld\n", BUNDLE_COUNT(mc->bundle=
_length));
>  =09while (count < BUNDLE_COUNT(mc->bundle_length)) {
> -=09=09char feature[5];
> +=09=09char feature[FEAT_LEN];
> =20
> -=09=09feature[4] =3D '\0';
>  =09=09get_feature(bec[count].encoding, feature);
>  =09=09printf("    %s:          %d\n", feature, bec[count].counter);
>  =09=09++count;
> @@ -494,7 +495,7 @@ static int sdsi_state_cert_show(struct sdsi_dev *s)
>  =09=09=09sizeof(*lki) +=09=09=09// size of the license key info
>  =09=09=09offset;=09=09=09=09// offset to this blob content
>  =09=09struct bundle_encoding *bundle =3D (void *)(lbc) + sizeof(*lbc);
> -=09=09char feature[5];
> +=09=09char feature[FEAT_LEN];
>  =09=09uint32_t i;
> =20
>  =09=09printf("     Blob %d:\n", count - 1);
> @@ -507,8 +508,6 @@ static int sdsi_state_cert_show(struct sdsi_dev *s)
>  =09=09printf("        Blob revision ID:           %u\n", lbc->rev_id);
>  =09=09printf("        Number of Features:         %u\n", lbc->num_bundle=
s);
> =20
> -=09=09feature[4] =3D '\0';
> -
>  =09=09for (i =3D 0; i < min(lbc->num_bundles, STATE_MAX_NUM_IN_BUNDLE); =
i++) {
>  =09=09=09get_feature(bundle[i].encoding, feature);
>  =09=09=09printf("                 Feature %d:         %s\n", i, feature)=
;

--8323328-1072423584-1712825526=:1017--

