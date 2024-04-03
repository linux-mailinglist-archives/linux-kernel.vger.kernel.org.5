Return-Path: <linux-kernel+bounces-129697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F41EE896E96
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A801B28937E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8E414388E;
	Wed,  3 Apr 2024 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RuejeMgu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C7C1420A3;
	Wed,  3 Apr 2024 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712145667; cv=fail; b=Z39cct1k5DlAYUHtZC7iWc1Hz3ZgMdh+umNKHrv1lg5Lurd2MWWjEhmd20jmz5gKyrRk3Kv9ID9Za71MHd9A/v5vSzKKeab3SV1bK4ckGVGe3srZ38DoxtxA1L01xM3I3MiTSK4Ey6bIIeHvXAMDOwSWUGk+BJMueghJgGEfh7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712145667; c=relaxed/simple;
	bh=xmKVCwCY0FOy1Ux8kZsI8lvyiHAYKMxLsanpw51szv0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XBMSg6PgWbnJNm5tWLDVZu7XML6cLvckmMmdY9VwxiiLUw0qOi2cUhHnYVVzVuBo5MzwRDpOulnpdHIPNk9HBkfl+RhPrKztc1nLbaxWNhizFP4utu/UV8mFP4uYatJCUAmxLP5ljIElGUvHi01cbII67bI8pqqzVQyL5V6BTjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RuejeMgu; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712145662; x=1743681662;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xmKVCwCY0FOy1Ux8kZsI8lvyiHAYKMxLsanpw51szv0=;
  b=RuejeMgu9YY9aysqtZwhUG8mCsPFu/P3DhzBTK3PotFprDt2Aqh48UfY
   OstRS06Gn35QYZkrl0Xk9fgeVNh/hOxblSQTiUgJugIVcRVr9RMXYHblU
   DKl48vdZL3Sg/kNQ5nz33piOItamAlUzzEhv6+SyPJ2jFpuTlbLWzzDhy
   fhezHnGGUoQvUsay2DXlAhb0O3Prh3e+gBgocuOeospuE2Zk+2WKSBecR
   474d/gjFhcqL1Z908EovIQ/ot7F/2trxFgsnzJ/Goc1H9bT6xuhWTFiFb
   4a/yP2hWHjqWlAkzLYNbRiT+YiLzfrzbKw39TwGCV7umNtF5m3//TlypX
   w==;
X-CSE-ConnectionGUID: WGrg3Xk1TFibItgXFvbDqQ==
X-CSE-MsgGUID: wzK0trqdQxub0DOX8lfbAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7273522"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7273522"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 05:01:02 -0700
X-CSE-ConnectionGUID: ZZsSYgk6Tseoi3LcCXXrvQ==
X-CSE-MsgGUID: Vo6BH6MNSRuE4l+TCl8Y2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18465897"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Apr 2024 05:01:01 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 05:01:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 05:01:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 05:01:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 05:01:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQ0vjOzK+CV7SKDEHCGsX0BfpXRoFT/7T6im8Gqvo+fK1qIh/LFeMB0eMw4pPDHiDJcasvK7UaIilyI2BNtY+jYPAHb7WxMyrp9Q/1BEacHD3fM0Kvv4sGpXQkZAgVCVilZsiYiS6TpvRhW9qvF467V4OgxkJhWBIlIxwBL/nTqKSPW1KFjaDa7XmJMUaZ2P6LsztkpudGd8S17HAOVRY9YZL2IA5wCQUdK8AuJTJTZoXRIdyoqoGsyuVX1znQyupoD3RDOPfR7bN2ojx6p2zieIGv+UnSVu3OXOFRL0M7avVx8VHjRIFH5GHqYOXSuAbL4l1VorZninL22nKQpd1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wA6zJ5mtrIbwm0IaeI08rD8jREZtM+dzY21erPy10ag=;
 b=DfCMSXyzCpF4DAwhtdoz0CMNjjlrKGOUkP4ZIVomWbOEC2A3Og3YnVbM0qgL2ayOravS9yNW6sIYI5ekRg4DX6MLVdW0EiGeuLoBXA3D9zjvad1EK+ardYCZ3oKGo0sV27We0z2aYA88lvqJjsDqQ6m5h/MqGAUuoyOetEL/SyNY06VONsQvILEbJlM6c6BwG6ZDnp9pXBHzWraEgLgYYqqtragPyLZfhT/LaVJpLFH4PEbe6zahUtumYYcnV7EwQae3VUadMBXEZKU2Ycf3LGwW8l+UoINPxzN/PNblghd6/6Ny5n2mB54O4KfdnjQ+IUNCxIQum5Q/pX9IS63INA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by DM4PR11MB7182.namprd11.prod.outlook.com (2603:10b6:8:112::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 3 Apr
 2024 12:00:58 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::5144:aca9:5cd9:42bf]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::5144:aca9:5cd9:42bf%3]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 12:00:57 +0000
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: "Wu, Wentong" <wentong.wu@intel.com>, "sakari.ailus@linux.intel.com"
	<sakari.ailus@linux.intel.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yao, Hao"
	<hao.yao@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>
Subject: RE: [PATCH v2 2/2] mei: vsc: Unregister interrupt handler for system
 suspend
Thread-Topic: [PATCH v2 2/2] mei: vsc: Unregister interrupt handler for system
 suspend
Thread-Index: AQHahYLR0U1myVo8H0mYSlHoWp0IkLFWcgWw
Date: Wed, 3 Apr 2024 12:00:57 +0000
Message-ID: <PH7PR11MB76053ECD0313E42CED467542E53D2@PH7PR11MB7605.namprd11.prod.outlook.com>
References: <20240403051341.3534650-1-wentong.wu@intel.com>
 <20240403051341.3534650-2-wentong.wu@intel.com>
In-Reply-To: <20240403051341.3534650-2-wentong.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7605:EE_|DM4PR11MB7182:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oFwPNadPlTNXrdduDLsO0axJWktmLiRfUMN57vpEHGhQu3GtBEdbqOOf90HH6C2opA7pW1pOGddlfRC3OTMbMqUAfVQu3UG76n4bLWJ9ZpAv01xdYYnMJzcgZQJ2XAuVgdwRjnAYEXqp5IJccaYXrd1L01jvsGcvJ3z4+A5DBpNzS7AL/rwdKxhkR/DuQgLv+ta6NHYlEwIYGll0/gXgo5EJ0HTsO9col68t4tJHi4tukWNKIfva99lcglLM0VlRscoR7bKM9Xijbc4aeI7UJQ4mu98Z5B0cd9vNU4/i8iyoymNF81widwrW8SLXKHwA3tOhcWwQkDIRXyWmrfExCkrfMqFTtLTHX3C03aNBYR0YTTOSSnyQ9V5bwTXRFQcBPSlNYjqzzEAB+xkStJ+7zvfsK6/FS0C2vE/TO47TUmIqeAeIFowNiggtom++/BuS6NxjeJHPI91p3U8Kon5y65h4qemVKKA7gWtNYjjKmn3+Txf1ep2/zCJVX0E9jdBvgVW/QQetMZUdZ6xcO3bPNHP8Ap5KMilu0U/B6W2+gQqWrPiWqSRQFDpKo58XV3AmGFF67wQmFsRmL0Eg8y4OTt2IX4tyGmzpjjvBU6cGVRQeAjEI9NFHvHVsI/DUDfOutruv++v0eAIivtlO5YgdTvOH2/Jehz8GIPUyefqnofA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7WIUE8hY4zuHhe6hl31dpKFcHRObI4kaDdaEsFswLD2Nh7FmZCsM7VsLKzjK?=
 =?us-ascii?Q?jg7aAIJUCyqfdKH5lP8FwJA6tCsLn2QTp9DESPpiqJZ3KUmis4BvOLa/y2SD?=
 =?us-ascii?Q?D5qsiReDIi+0RjRIRflskqNWISvoxtPr40l9EgzxvBfL9Rdpv5xZpVMKLzJZ?=
 =?us-ascii?Q?odD/1L8zn1PBg3s1UNzK7kRYk8TXgBM5TKh9weDhkEW8c1ujXh1bYl5jo5jA?=
 =?us-ascii?Q?UPFP2ZznAPP0HzDLIjw6/smErkQCc3C0aIRZ1qXHincrGLWa5bEAGdV/PJYi?=
 =?us-ascii?Q?T3q0JNetoUPs50iZTHqUP4LtghHi8qP1tv/pzxEAxhXcChifesWJbyW+zbsF?=
 =?us-ascii?Q?nOydJtDN5NQ/kErTle4/JFB3y1Mu+WxL+2UsIM1zVaAKEdyOp0nnGe6kqBN3?=
 =?us-ascii?Q?+Q5/7RGBBYCBGIvvU4DHKMsW6BS1M91IrUZHYNSFkzH0RQI6kq5CnOpY9IvX?=
 =?us-ascii?Q?eOmYznXqCcVBDZ4/aGjlvih3UeCP+f13ZtRgz0bbDfoDe/ECkJ6XeZgU0iwq?=
 =?us-ascii?Q?zsL/cY85BYq2BTnag5rbRbZsF6QFFqWpU2GJyo6fmKB1GJybH5/dO+2aqkCx?=
 =?us-ascii?Q?MMczznz9yVGv/J6QuwyP19Pp/IVxMZcUR5p+DqO9fI33HyzfT0CbM+n58UGm?=
 =?us-ascii?Q?Ry3kTeR4fUx05c2eX3CDzZc6hsJHl9CxAME6V/WL+6f7nvwcfCMuV3RB+uQ+?=
 =?us-ascii?Q?wLCuQc7+MEdAoMd6UXv0/bazMH6abKGm7+sxrTmig2FwK27m0eGS/6XvKk5d?=
 =?us-ascii?Q?NlOeb9jnzdEsQtFOqaahdiJ7L/zC1Pxa9CKvRfBGmAkzV47VJw4jhPmlJiow?=
 =?us-ascii?Q?22d7ZgFw+/FYXqN08WcwE0k4aq5YEBF75PseazBOXi1Ii7iAJHy3yej+uJsX?=
 =?us-ascii?Q?6+ndbi3KjOS6d41WvWvRMmm40V2eLxuAYZSxRJvJkLVoY+n9Ptxz46Azxv77?=
 =?us-ascii?Q?Y4xJ4fTmVTgWv6H/j1u6La98RLwxVUJ1kWzCjy1bxhmSpS5c6v6vuvekrSNm?=
 =?us-ascii?Q?YyU4OdsSHF4epk5zkMsUpWSHs2hH0R4MjZkjHy5cXqFNvBrvhb3Jenm5DULh?=
 =?us-ascii?Q?1RGQ6sAWXtkBh7e3b3H1whQJpz7dFw9p0bbiuDRKDNDx9UD4j6/3bBr+4gTp?=
 =?us-ascii?Q?UJK+Bf+iNF7YaIrO/UwMFQj9AAdTLWXb38Eymvt0zpXDKtzKNWmo1AAeBjj4?=
 =?us-ascii?Q?vLFoEhrirESUV0nRK9oLrQQExjDFeVqWrVKIBIB/UgLQDoAe3m/QKxoJRfKP?=
 =?us-ascii?Q?fElIlxZB6Xmr8zkW3EztbDuh3hQxCS8khxKUxA9/sRE+v01XQc6OnCiCr6Ri?=
 =?us-ascii?Q?izFGa+l6FiYQ5bS+eaZ6zDeZTH3+BXHEOvIZGPu8DNAMNrAB+BNBcg4cOIy/?=
 =?us-ascii?Q?yQZTQpVtpZyV6vjP+isAQkdfx5Eg274p602VGujDcGueDeuj96GqpV1E+5t3?=
 =?us-ascii?Q?2Zo67RQ8t/t3APBAxh0DEmkziT5w3ppjuW1JZEA+KSQmVlA5jvFGOLETn4Fv?=
 =?us-ascii?Q?A2V4GSrjqSdZtRauLSDM0duKsUOAcrpJI3wRJxO9vl8QVXFLTb1SHfCZw46j?=
 =?us-ascii?Q?ITJ6JvptfNEZo+8PqmcRCDPd+c97gE9jthu6Pg4T?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7fbb03-0b29-4483-d1e9-08dc53d5b904
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 12:00:57.6451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nlEubPo48JTopWW/PAqBuxvMMUN6lCHgEIShGOLrTPTOm40Cltuy6mPfJACrzWFqf+YmONnjaxesKBLS0CRtXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7182
X-OriginatorOrg: intel.com


>=20
> From: Sakari Ailus <sakari.ailus@linux.intel.com>
>=20
> Unregister the MEI VSC interrupt handler before system suspend and re-
> register it at system resume time. This mirrors implementation of other M=
EI
> devices.
>=20
> This patch fixes the bug that causes continuous stream of MEI VSC errors
> after system resume.
>=20
> Fixes: 386a766c4169 ("mei: Add MEI hardware support for IVSC device")
> Cc: stable@vger.kernel.org # for 6.8
> Reported-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Tomas Winkler <tomas.winkler@intel.com>

> ---
>  drivers/misc/mei/platform-vsc.c | 17 ++++++-
>  drivers/misc/mei/vsc-tp.c       | 84 +++++++++++++++++++++++----------
>  drivers/misc/mei/vsc-tp.h       |  3 ++
>  3 files changed, 78 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/misc/mei/platform-vsc.c b/drivers/misc/mei/platform-
> vsc.c index 6c9f00bcb94b..b543e6b9f3cf 100644
> --- a/drivers/misc/mei/platform-vsc.c
> +++ b/drivers/misc/mei/platform-vsc.c
> @@ -400,25 +400,40 @@ static void mei_vsc_remove(struct platform_device
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
> b/drivers/misc/mei/vsc-tp.c index 968a92a7425d..e6a98dba8a73 100644
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
> @@ -490,10 +521,9 @@ static int vsc_tp_probe(struct spi_device *spi)
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
> 2.34.1


