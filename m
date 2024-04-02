Return-Path: <linux-kernel+bounces-127888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C3589524A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9331F226B2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E236F69D31;
	Tue,  2 Apr 2024 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e7fkZB5N"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D676996E;
	Tue,  2 Apr 2024 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712059213; cv=none; b=rgfzLO63gyPzp5I8VlamDxem8UOzBGJhIwbbBAND0NDT3hZn9gGwefsw9KQvSiQK84NJUo8+v+VIAFr0NqW3QXCpkjIo4G91CBFWG6T6eBqjAguB7pttRMsMpUwv371WoddhB+CdF9zO4CXHjmWLet7NLgbtig7uL9uMILBlxaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712059213; c=relaxed/simple;
	bh=TihMgljaYWhrRL55MuklbfScnzu4gTRlCt/ctqEhRvU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WzmTX083BWl4ws63lgqRDIbZKb+v8zPKYGULaWksv8D02Cr79dTjTCdMqBEFuQcAnJKSp+FNhxrFP/bXVEjWO3+7X24qjYnAYU5qpD1urDfb7/W8ffpePU4yjTLhdGr7FxwlbZEQJGBRZe4I5EwXfW6aBYEN4tXL5yu+LStJZx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e7fkZB5N; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712059211; x=1743595211;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TihMgljaYWhrRL55MuklbfScnzu4gTRlCt/ctqEhRvU=;
  b=e7fkZB5NjWBGuH8okkQIiFX4vUamjw4tePSMWS7ZtoLy2ApbYDGR1deN
   tyZXXqsLP1r6/l50grYPIKxCsjd1qLwzkK5Uub4n2VQC+Qoqcm8Sk7nvc
   Am/uaI+AMfuFLOSmuzPh5Okg0MsG208GyjtbTpOIe8AX+NeL8bzLWbfvb
   V7nLWyEHB2DAftLYg/61ohK4ikc7Y71CzotUcPO1UaFqjAfhlVUHB0dwD
   wxj54obG3pdkrEotPIPcopMk8bQg2mH/iDhGhd8CUrTCpfxW2acGbKdX9
   HiQ0J+circb34TsfeAzWfcRjd8hwMljgGjH1i79bjEdqNomVKGEJ8ZteN
   A==;
X-CSE-ConnectionGUID: CxirSfzFQ6C5P3ylP8ZPFg==
X-CSE-MsgGUID: hqrGO+DuR8y1j57yCl6QKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="11044368"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="11044368"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 05:00:10 -0700
X-CSE-ConnectionGUID: JwktAXk0Q7OIz94r54PrFw==
X-CSE-MsgGUID: jx4iutLKR4qpiKbdT2sFCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="22762281"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.23])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 05:00:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 2 Apr 2024 15:00:05 +0300 (EEST)
To: =?ISO-8859-15?Q?Bernhard_Rosenkr=E4nzer?= <bero@baylibre.com>
cc: platform-driver-x86@vger.kernel.org, jlee@suse.com, 
    Hans de Goede <hdegoede@redhat.com>, onenowy@gmail.com, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: acer-wmi: Add support for Acer PH18-71
In-Reply-To: <20240329152800.29393-1-bero@baylibre.com>
Message-ID: <4edff788-8a2a-ac94-f299-7d613a1c360b@linux.intel.com>
References: <20240329152800.29393-1-bero@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1863880464-1712059205=:1019"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1863880464-1712059205=:1019
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 29 Mar 2024, Bernhard Rosenkr=C3=A4nzer wrote:

> Add Acer Predator PH18-71 to acer_quirks with predator_v4
> to support mode button and fan speed sensor.
>=20
> Signed-off-by: Bernhard Rosenkr=C3=A4nzer <bero@baylibre.com>
> ---
>  drivers/platform/x86/acer-wmi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-=
wmi.c
> index ee2e164f86b9c..38c932df6446a 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -597,6 +597,15 @@ static const struct dmi_system_id acer_quirks[] __in=
itconst =3D {
>  =09=09},
>  =09=09.driver_data =3D &quirk_acer_predator_v4,
>  =09},
> +=09{
> +=09=09.callback =3D dmi_matched,
> +=09=09.ident =3D "Acer Predator PH18-71",
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "Predator PH18-71"),
> +=09=09},
> +=09=09.driver_data =3D &quirk_acer_predator_v4,
> +=09},
>  =09{
>  =09=09.callback =3D set_force_caps,
>  =09=09.ident =3D "Acer Aspire Switch 10E SW3-016",
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1863880464-1712059205=:1019--

