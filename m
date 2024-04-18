Return-Path: <linux-kernel+bounces-150651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9012E8AA24C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68961C20D46
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D45E17AD71;
	Thu, 18 Apr 2024 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMJvnAkT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D3925778;
	Thu, 18 Apr 2024 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713466212; cv=none; b=NAdGAIsj+PhV3D8E/lIjAFRYTz6dUvUNLcV5nu8trOlwkbXGnRn/pe6BYwgk8YM6/NVgLksASmsEMyLBO5fxCQz78CDLnQ27dR6qdcvzosa0Kn0cJSkGHVURZpnji6/2raI+KDWw8gLP5zIcb4WK/qmEAOUFgem/QNjDG3y/PK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713466212; c=relaxed/simple;
	bh=IHnBOaI2U0StIBqc/5Uk8rORn8+7HNbrh1nEC9OGb4o=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ka/zVjUQFr7ZVCgiqxvmOhSwk3yOvsa/D80RFofON4P2dPGl9In9RA+Ao6kaf5R1IamL4g90tWcDXFe04Inp1sq71R6UTgZtdTo+/ODugFa/1p5wGXiYUVLYLAxnAr+ySbU5VTBW9PqR3SXnug7bhfiIYxW7tSHXYh034QnB71Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMJvnAkT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713466209; x=1745002209;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=IHnBOaI2U0StIBqc/5Uk8rORn8+7HNbrh1nEC9OGb4o=;
  b=SMJvnAkTTFgiSG+WyxLkPhs608nxCCRsFhWK4ZBnXPL3lCDuv88w0VE8
   CLbfdBz/BsVQ7mIi2aO68+pd63WAAH/GOWLawznyJkVCbXea56aZ93bmW
   RX1uuKb/oeVa3CjJx3k1qJ/qgK85h6W+bcelk7ezgDkADgZ4adLkLeeCF
   V10J5qUkaI042rb6TTnL5xm76kYfGhHuZLMSKA9M6Ieozm86dPptShNar
   XxWAI8ZwSUZuPUX1uLpDthpsqJNF5qbCLMAjeWfCDz6M9HEiS9R6R6rCL
   6c0tKjcQkO+zeU7VbW1K/H0WgNpRiKtfgOqHUZ8U8bm/pEXBhHaalUOE/
   w==;
X-CSE-ConnectionGUID: 98hPkIivQhG6rr8jpf4z2g==
X-CSE-MsgGUID: O6IOHv3HRK6PXzBhEAzv8w==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12828118"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="12828118"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 11:50:08 -0700
X-CSE-ConnectionGUID: FmK+L6rLQ1mIJoFBVI8bcQ==
X-CSE-MsgGUID: LaqPm/qLRxGMVWAAle7VPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23154191"
Received: from unknown (HELO localhost) ([10.245.247.37])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 11:50:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 18 Apr 2024 21:50:01 +0300 (EEST)
To: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    "Luke D . Jones" <luke@ljones.dev>
Subject: Re: [PATCH v1 1/1] platform/x86: asus-wmi: add support for vivobook
 fan profiles
In-Reply-To: <20240418181057.2688-2-mohamed.ghanmi@supcom.tn>
Message-ID: <772e3de4-4e42-474e-8a7f-75e592756053@linux.intel.com>
References: <20240418181057.2688-1-mohamed.ghanmi@supcom.tn> <20240418181057.2688-2-mohamed.ghanmi@supcom.tn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1091724370-1713466068=:986"
Content-ID: <b26a45ef-4e93-3195-e1bc-1456a1a7cc01@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1091724370-1713466068=:986
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <fa09e14c-8e07-1dd4-a33d-8cec3c7f03ee@linux.intel.com>

On Thu, 18 Apr 2024, Mohamed Ghanmi wrote:

> Add support for vivobook fan profiles wmi call on the ASUS VIVOBOOK
> to adjust power limits.
>=20
> These fan profiles have a different device id than the ROG series
> and different order. This reorders the existing modes and adds a new
> full speed mode available on these laptops.
>=20
> As part of keeping the patch clean the throttle_thermal_policy_available
> boolean stored in the driver struct is removed and
> throttle_thermal_policy_dev is used in place (as on init it is zeroed).
>=20
> Signed-off-by: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
> Co-developed-by: Luke D. Jones <luke@ljones.dev>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---

> @@ -3618,38 +3623,38 @@ static int asus_wmi_custom_fan_curve_init(struct =
asus_wmi *asus)
>  }
> =20
>  /* Throttle thermal policy *********************************************=
*******/
> -
> -static int throttle_thermal_policy_check_present(struct asus_wmi *asus)
> +static u8 throttle_thermal_policy_max_mode(struct asus_wmi *asus)
>  {
> -=09u32 result;
> -=09int err;
> -
> -=09asus->throttle_thermal_policy_available =3D false;
> -
> -=09err =3D asus_wmi_get_devstate(asus,
> -=09=09=09=09    ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
> -=09=09=09=09    &result);
> -=09if (err) {
> -=09=09if (err =3D=3D -ENODEV)
> -=09=09=09return 0;
> -=09=09return err;
> +=09if (asus->throttle_thermal_policy_dev =3D=3D ASUS_WMI_DEVID_THROTTLE_=
THERMAL_POLICY_VIVO) {
> +=09=09return ASUS_THROTTLE_THERMAL_POLICY_FULLSPEED;
> +=09} else {
> +=09=09return ASUS_THROTTLE_THERMAL_POLICY_SILENT;
>  =09}

Thanks for the update, braces are unnecessary here. Other than that, this=
=20
looks fine:

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

(This was not v1 any more, although the v1 was sent not by you but
Luke).


--=20
 i.
--8323328-1091724370-1713466068=:986--

