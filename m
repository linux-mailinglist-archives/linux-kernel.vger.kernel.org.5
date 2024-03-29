Return-Path: <linux-kernel+bounces-124113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CF9891266
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22342B22CD7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A4D37152;
	Fri, 29 Mar 2024 04:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UZbMpBAB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F762576F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 04:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711686927; cv=fail; b=W4iHcpyPX/gzDttDbnvWisybGAVtE4/+r1d/174HVsQmPpmNVpEj3xBN8W+WweL2trl3w6MrkAHekwP4b8QuFF0lILEnXTyIM6qz6oNmkpg0n5s6yOGqfSHlGwwJjFfZQDNAdLxMSjcW+AaYAzJL5BSouTYszZUj3VvGJA8ROug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711686927; c=relaxed/simple;
	bh=8fTY2EbgDP8eWt63+KfZNfZ7gtsvPtOafnDEGO0HwxM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mviWV2DwAc4h6IjCmRdXmVoJUmM3bRK81nqXMutwiPEgSV8Zav6G+yfua3mnoMtcq8Fbk4WxsbwVB6Ltr861DXFPjl28HyM+y+1VMqxd8lPz6sKFfb4cP0v0/e/rA1nTUFRg5o3OD1IJVMpjasgKqpzrMuIY4mkkGWPkJBd0S6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UZbMpBAB; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711686925; x=1743222925;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8fTY2EbgDP8eWt63+KfZNfZ7gtsvPtOafnDEGO0HwxM=;
  b=UZbMpBABTJsBTMgWNz7RZgcVZdmakj8Ko8xrd8La8rjype031FN7XuaS
   K6XBKgAhNoOybyMWPMUK2k4AWd5jzlmnTbpSeUhopTg8pxhWg1qZzSrMp
   nicurd+1HzAMplLP9JqkEuX7RtpluRreRHT5UoFPGB7ibk5PDKqSfwCJ3
   6dw8JLAyDgopCFBuvUuN7XdppCY4ZTX3oPD9XNVZwOe93G4R+m5YnZgkg
   YXppvbMsBqtXSZf7kwI1qbbj7xkO616L0KdA6wY7c7iGAVpX8r2szE8yF
   JB2Bh6epyTNC5Hx76ZJ1c9qhU43pEiQAT9tQblkZLcnI3fsi6CBIqChZU
   g==;
X-CSE-ConnectionGUID: 0EQXFv6LRZ2Im4L7vOJm/g==
X-CSE-MsgGUID: Uz+sXWQhStyOjdcXvvDg3g==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="32274992"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="32274992"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 21:35:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16901099"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 21:35:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 21:35:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 21:35:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 21:35:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjegHMx8v/kM3Ue/SwzB3L5PLKME9jxQ/B4PAbHpQOBxR/foxNn5ddtFdfEI7A/H3uLK6eBwiI2OW3wN1Gv4rmWjCHKFtaN3yCPrxJZ+E7bHnXGOHxYClfyqT1ZGP83AVV4SXi7GJj8fhpO8E7uTKn1jSm/vwUzIkGBGhaquZByxs3crBrRw0jF/I7g9zFtW0M9mE2/l+qKjH5b4fgCSKlnpCtkCcpgjR4FxYf9/c7A4qBSYfJpv56O2o1rbP+/mVB8sMiKZbBn3VPdvf2T0XZCJjkXRWgIF/uEhpq95244Loqmaztz3jMTFMkjDXkF2YK7ynLPhC1M3w0C9lNCBrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4+sVMDgduRy4xs3R2+bvVLtWACg/2w+j63WkwM+6TY=;
 b=fFQnxVnI8flBkBtDgorl7JDcyoBLzm5MklsWMSs/xJ34TdfrmCBilTiWBLybm8qR6qcVnDUHf58tWtK35Nb03ruvbQkvrieSV+d4+hb2TbUwd0PBHFAdg5/owhfWpRUX8zBCJ38gi2DdGvExozUZtIwYtRK/lMbrwQlTeBqkJXFIbRVD6/bVGQalS4HO6A2KVQxfdHw7rSd+7bTFJ2rPqFshLrSLvHvDEs+PlRfI1rWjhjH/MLA3/EU3R0AxAwjfQD/RRoxw/0NY/GK3ymEmGV0zJ7uBrTPusPbXxiBG3rb+xkM8h96fJNeEWqaJLcEESg3Q78OmWEFo5VQXPEgZPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7)
 by CY8PR11MB7059.namprd11.prod.outlook.com (2603:10b6:930:51::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 04:35:21 +0000
Received: from MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::8814:40fd:3adb:8de2]) by MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::8814:40fd:3adb:8de2%6]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 04:35:21 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>, Dominik Brodowski
	<linux@dominikbrodowski.net>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RESEND 1/1] mei: vsc: Unregister interrupt handler for
 system suspend
Thread-Topic: [PATCH RESEND 1/1] mei: vsc: Unregister interrupt handler for
 system suspend
Thread-Index: AQHaepKfMLIeIMH/HU2UeptXIGcJFbFOL00Q
Date: Fri, 29 Mar 2024 04:35:21 +0000
Message-ID: <MW5PR11MB5787724639DF1BE59CE0D62B8D3A2@MW5PR11MB5787.namprd11.prod.outlook.com>
References: <20240320064810.3265489-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20240320064810.3265489-1-sakari.ailus@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5787:EE_|CY8PR11MB7059:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c9HtSWxfMNzQiYaqqeEWrYsPLA97i0MPFNG7DD419fKAtBc5M1zn6kawa3BiAfuMhx1yMxaPCr2oznwUfayHnJIJIPwK5ou+qu3LsGoFYBDQxzp/hRZrrNhdTEGOuiOW4m4MAAOiN0ZVbv7mNofsKay7HttzOX9gtGLSrgwf/Bk7yKpGIELbZD4AtQlkJqjKcZCJHT9U6Amb1vYcfUXEBzhqlcGNE5F1qqCOKlbmd9ecZq3J7EYGGPTkPFmkxn+z4lcBLi1OqndvcsjJKuhUAXmpnRbPn9UgNX7AQxXYhUZY9li80Ns4WI7js+Ai1AyPIL88fPReoh15quuNAm9e8cxr26WHmMlLswJuLZWEHbiT5P0RDCAWXi4Pho1XFm/TeENf/pr6uVoYgGMoefO6hg1Y6y8hg+IXBINn5pvt/Mf43I0sW45cwWI9WOpQ6YdaB5oqX7qzVbSmQXwDT+xyG7yS+LhSkjGbJGYd+9tuFW10np81iaAEEq9fPWk1cm0ID59gyEeZdHKrz26cHFXgbKZfml+d4wu1sROE88O8GtfYLYxWDqUlAyJ7t7MtZgdygcXtgXwz9xUaIWOnaAmcqV8vQJh40jrIYUw+kViYt+Ro3/WVyHjQIjkMPo2tlZWgeUGey9OdfpBQFGAxHt3JrnX1mrMrv+E2rF/5d39CGEk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iJWfWmCFgwVjNCIYPrZv77zh/bYoZex9meECcmP2t1DEs5ra4aS1yJzAU0Sv?=
 =?us-ascii?Q?KzBJAKjZVplhCcE0TvlNVRd94zW2Nn1A9bW2qicR6xTH6A/24eQThM01Hzeh?=
 =?us-ascii?Q?AZR8r7pUBT5KFGIDHhP+AYW0tMqaayGvYpuA3GW7T891e6/Ksr1NNoLxB67s?=
 =?us-ascii?Q?/KBm0/Us/mFUrOMuOhwShta1Eln/TDXIsUscnrTkL02Ih+II2eIL9b9ENYsw?=
 =?us-ascii?Q?fAueIA/gu0NphCE8dZ803K+Xpve8JxdlwoWw68FgPqk1+SN8KJxMzPrmr4Ov?=
 =?us-ascii?Q?0NW40NP3Prg8C6+om3GmlHvbQctQRLZhPiR4jYeXNm3y3ARoIDa8egzuestI?=
 =?us-ascii?Q?jytIK/ffXIA9VQPf2wsWuHwR/U+2cVnhgp8VgP4VmINO1MH+s4dxmBVTc8Yh?=
 =?us-ascii?Q?GJttlfjc7QSdec0xvCLt570/tsgL1e6FmOhvhxj6xS3kAr1UPp8oA1FXeHUZ?=
 =?us-ascii?Q?exOMqErqWjH52EimvXkjZBmG4eA0lCQ4Yw1PTPG8t663vMyKyPiE1SxiN+bX?=
 =?us-ascii?Q?VaIlRxGOsDip0jNWSnhV5l6hTAPsvI8N4CwlafuAuE4OGKBk/zuJCoXJ/sdO?=
 =?us-ascii?Q?VXGB9rZbV1C8Kd+6QCttUQbKiuUALD2ZqaISgBFgMtGutKpOQmNuf2xMjP5H?=
 =?us-ascii?Q?XwuxAUyfYXZF1BV0KeXVHNltP9Vnx9LXANuJWNyFJtqrxg0dgaRoMBl6e9l0?=
 =?us-ascii?Q?dycC+DbJwYSUpNXprzaQXVt4Yh2KV4faXCbnm53z/L6O/pXrku9p4eNzdqxh?=
 =?us-ascii?Q?R59colky8qF9cgNXcc27S6FMsej9UqS4PY9fXjQ2gR1JdaNIIpgxFjzx51+C?=
 =?us-ascii?Q?8v0YTy4XZ+PXdsYrAvrmAZvsvPP7y4gXzaUhwFAx1v33BVwOSrXi5nMUas49?=
 =?us-ascii?Q?YBoS8BjLToF80y9/sAlcturFUj3G+jb9aQksSg+xXN7O8M7Lq7hNGoD4+8mN?=
 =?us-ascii?Q?hVnuuqLyhIlDJ/L33Qm49KrzcMTNTn6aIOrzxr4tQxpxCHv0vESVEnK8vt5H?=
 =?us-ascii?Q?FQsfmuiK31ih1KDqMON1HIn/HIJIdKWo13dtUOf6V9P7kRXJuvN2Q2FXRjEJ?=
 =?us-ascii?Q?akP9+OdVNhV6D7HEA9M3HlA3oVFJHVPbFGaiGJ8wBmPPdjsb8YIU3PkTj596?=
 =?us-ascii?Q?zCfXp492YNT1kKD70Hg7qoYhGNHYd2EyjrBw6ZZeUUt0VMp7P0UoLzcJaVm8?=
 =?us-ascii?Q?6Rrlq/2q9jZPQ98nn5OGHD4Oe4cPGDDLP8PcfFMdxofV3IUgtLAttfCqUPN8?=
 =?us-ascii?Q?JdZOJDYZckIXnJibNyL8IqIsuXv3YbCL8MLIPwfkUVwSBUP9p/sMrQPpPcmO?=
 =?us-ascii?Q?tA3dfwtKPlnU2Om+1ggksfRckACDVxF81zW03WaTYsqnq7LB/Z9+++nZn0gQ?=
 =?us-ascii?Q?jXdVtEwxM0jzgSE8d1NcR/KOXFEapuSBYvRrusTR9r3NmkynJ7MVyYmWzQt4?=
 =?us-ascii?Q?4HYieoPBGw0UBUpBMhuuOA+NlCoWJqgSb18c0VaO7ikevnjPv9E26v25J1i0?=
 =?us-ascii?Q?/Kxvup1h3QLEkxu168644+RrCDKkmQLISFnGytypD1tazfmS4M8H+luBJzNj?=
 =?us-ascii?Q?BbYmroIgfrltVt3iogqzUiNCKEsG1LicRd/4tZdU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2beb852-03aa-48fc-d89f-08dc4fa9a51b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 04:35:21.7572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +XHIoiYTf7w1vtruTjck4j1pRCGEya04OM3qwYTBCUhH++iRD2vRGLBeZGi/Vc+UKZZvhKUwR7691xDON0jC0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7059
X-OriginatorOrg: intel.com

> From: Sakari Ailus <sakari.ailus@linux.intel.com>
>
> Unregister the MEI VSC interrupt handler before system suspend and re-
> register it at system resume time. This mirrors implementation of other M=
EI
> devices.
>=20
> This patch fixes the bug that causes continuous stream of MEI VSC errors
> after system resume.

Hi Tomas,

Could you please help review this patch? Thanks

BR
Wentong
>=20
> Fixes: 386a766c4169 ("mei: Add MEI hardware support for IVSC device")
> Cc: stable@vger.kernel.org # for 6.8
> Reported-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/misc/mei/platform-vsc.c | 17 ++++++-
>  drivers/misc/mei/vsc-tp.c       | 84 +++++++++++++++++++++++----------
>  drivers/misc/mei/vsc-tp.h       |  3 ++
>  3 files changed, 78 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/misc/mei/platform-vsc.c b/drivers/misc/mei/platform-=
vsc.c
> index 8d303c6c0000..8db0fcf24e70 100644
> --- a/drivers/misc/mei/platform-vsc.c
> +++ b/drivers/misc/mei/platform-vsc.c
> @@ -402,25 +402,40 @@ static int mei_vsc_remove(struct platform_device
> *pdev)  static int mei_vsc_suspend(struct device *dev)  {
>  	struct mei_device *mei_dev =3D dev_get_drvdata(dev);
> +	struct mei_vsc_hw *hw =3D mei_dev_to_vsc_hw(mei_dev);
>=20
>  	mei_stop(mei_dev);
>=20
> +	mei_disable_interrupts(mei_dev);
> +
> +	vsc_tp_free_irq(hw->tp);
> +
>  	return 0;
>  }
>=20
>  static int mei_vsc_resume(struct device *dev)  {
>  	struct mei_device *mei_dev =3D dev_get_drvdata(dev);
> +	struct mei_vsc_hw *hw =3D mei_dev_to_vsc_hw(mei_dev);
>  	int ret;
>=20
> -	ret =3D mei_restart(mei_dev);
> +	ret =3D vsc_tp_request_irq(hw->tp);
>  	if (ret)
>  		return ret;
>=20
> +	ret =3D mei_restart(mei_dev);
> +	if (ret)
> +		goto err_free;
> +
>  	/* start timer if stopped in suspend */
>  	schedule_delayed_work(&mei_dev->timer_work, HZ);
>=20
>  	return 0;
> +
> +err_free:
> +	vsc_tp_free_irq(hw->tp);
> +
> +	return ret;
>  }
>=20
>  static DEFINE_SIMPLE_DEV_PM_OPS(mei_vsc_pm_ops, mei_vsc_suspend,
> mei_vsc_resume); diff --git a/drivers/misc/mei/vsc-tp.c
> b/drivers/misc/mei/vsc-tp.c index 03486bebae09..870c70ef3bb8 100644
> --- a/drivers/misc/mei/vsc-tp.c
> +++ b/drivers/misc/mei/vsc-tp.c
> @@ -94,6 +94,27 @@ static const struct acpi_gpio_mapping
> vsc_tp_acpi_gpios[] =3D {
>  	{}
>  };
>=20
> +static irqreturn_t vsc_tp_isr(int irq, void *data) {
> +	struct vsc_tp *tp =3D data;
> +
> +	atomic_inc(&tp->assert_cnt);
> +
> +	wake_up(&tp->xfer_wait);
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t vsc_tp_thread_isr(int irq, void *data) {
> +	struct vsc_tp *tp =3D data;
> +
> +	if (tp->event_notify)
> +		tp->event_notify(tp->event_notify_context);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  /* wakeup firmware and wait for response */  static int
> vsc_tp_wakeup_request(struct vsc_tp *tp)  { @@ -383,6 +404,37 @@ int
> vsc_tp_register_event_cb(struct vsc_tp *tp, vsc_tp_event_cb_t event_cb,  =
}
> EXPORT_SYMBOL_NS_GPL(vsc_tp_register_event_cb, VSC_TP);
>=20
> +/**
> + * vsc_tp_request_irq - request irq for vsc_tp device
> + * @tp: vsc_tp device handle
> + */
> +int vsc_tp_request_irq(struct vsc_tp *tp) {
> +	struct spi_device *spi =3D tp->spi;
> +	struct device *dev =3D &spi->dev;
> +	int ret;
> +
> +	irq_set_status_flags(spi->irq, IRQ_DISABLE_UNLAZY);
> +	ret =3D request_threaded_irq(spi->irq, vsc_tp_isr, vsc_tp_thread_isr,
> +				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +				   dev_name(dev), tp);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(vsc_tp_request_irq, VSC_TP);
> +
> +/**
> + * vsc_tp_free_irq - free irq for vsc_tp device
> + * @tp: vsc_tp device handle
> + */
> +void vsc_tp_free_irq(struct vsc_tp *tp) {
> +	free_irq(tp->spi->irq, tp);
> +}
> +EXPORT_SYMBOL_NS_GPL(vsc_tp_free_irq, VSC_TP);
> +
>  /**
>   * vsc_tp_intr_synchronize - synchronize vsc_tp interrupt
>   * @tp: vsc_tp device handle
> @@ -413,27 +465,6 @@ void vsc_tp_intr_disable(struct vsc_tp *tp)  }
> EXPORT_SYMBOL_NS_GPL(vsc_tp_intr_disable, VSC_TP);
>=20
> -static irqreturn_t vsc_tp_isr(int irq, void *data) -{
> -	struct vsc_tp *tp =3D data;
> -
> -	atomic_inc(&tp->assert_cnt);
> -
> -	wake_up(&tp->xfer_wait);
> -
> -	return IRQ_WAKE_THREAD;
> -}
> -
> -static irqreturn_t vsc_tp_thread_isr(int irq, void *data) -{
> -	struct vsc_tp *tp =3D data;
> -
> -	if (tp->event_notify)
> -		tp->event_notify(tp->event_notify_context);
> -
> -	return IRQ_HANDLED;
> -}
> -
>  static int vsc_tp_match_any(struct acpi_device *adev, void *data)  {
>  	struct acpi_device **__adev =3D data;
> @@ -485,10 +516,9 @@ static int vsc_tp_probe(struct spi_device *spi)
>  	tp->spi =3D spi;
>=20
>  	irq_set_status_flags(spi->irq, IRQ_DISABLE_UNLAZY);
> -	ret =3D devm_request_threaded_irq(dev, spi->irq, vsc_tp_isr,
> -					vsc_tp_thread_isr,
> -					IRQF_TRIGGER_FALLING |
> IRQF_ONESHOT,
> -					dev_name(dev), tp);
> +	ret =3D request_threaded_irq(spi->irq, vsc_tp_isr, vsc_tp_thread_isr,
> +				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +				   dev_name(dev), tp);
>  	if (ret)
>  		return ret;
>=20
> @@ -522,6 +552,8 @@ static int vsc_tp_probe(struct spi_device *spi)
>  err_destroy_lock:
>  	mutex_destroy(&tp->mutex);
>=20
> +	free_irq(spi->irq, tp);
> +
>  	return ret;
>  }
>=20
> @@ -532,6 +564,8 @@ static void vsc_tp_remove(struct spi_device *spi)
>  	platform_device_unregister(tp->pdev);
>=20
>  	mutex_destroy(&tp->mutex);
> +
> +	free_irq(spi->irq, tp);
>  }
>=20
>  static const struct acpi_device_id vsc_tp_acpi_ids[] =3D { diff --git
> a/drivers/misc/mei/vsc-tp.h b/drivers/misc/mei/vsc-tp.h index
> f9513ddc3e40..14ca195cbddc 100644
> --- a/drivers/misc/mei/vsc-tp.h
> +++ b/drivers/misc/mei/vsc-tp.h
> @@ -37,6 +37,9 @@ int vsc_tp_xfer(struct vsc_tp *tp, u8 cmd, const void
> *obuf, size_t olen,  int vsc_tp_register_event_cb(struct vsc_tp *tp,
> vsc_tp_event_cb_t event_cb,
>  			     void *context);
>=20
> +int vsc_tp_request_irq(struct vsc_tp *tp); void vsc_tp_free_irq(struct
> +vsc_tp *tp);
> +
>  void vsc_tp_intr_enable(struct vsc_tp *tp);  void vsc_tp_intr_disable(st=
ruct
> vsc_tp *tp);  void vsc_tp_intr_synchronize(struct vsc_tp *tp);
> --
> 2.39.2


