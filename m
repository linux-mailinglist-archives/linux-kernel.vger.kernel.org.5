Return-Path: <linux-kernel+bounces-129696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D84896E94
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A60828903C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B024145B2A;
	Wed,  3 Apr 2024 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j0szE9xk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977BF134CCA;
	Wed,  3 Apr 2024 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712145662; cv=fail; b=W6ok8yxCS6GaLEz5VLmpPunFARiJFVJC2E4NqoD8gKe5kl5S7MvGbm9+HFCbO+kyUXQ8SCs+KGRj48MBqq3YbVV+OUIL1svHYAWNfJpGMI6qw+VtvCsc9GhKnWLxkGi1N44no+ONRPEKPJkowW7Q3kceVL0RamPrlinNEV//CUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712145662; c=relaxed/simple;
	bh=GnkOIhSktsjLuPCwBz7sVCVFITGypkmEfVR1+d32NcI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i4I9x1gX8ozuyivptJT3jXx4GOzRm2L3hMkpIJ/5aaT13qCD4kw5Nk9YiVB2R26wQoaO6It8uVwjF7Myte175q3ZdOpCU9cHYWsIWMAlu/f1hhJrbtr1HosdaxVpseTbH4Xg39MkL9S+sLWbsgcn6tp0AEcaUiV2KDVpHKM25AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j0szE9xk; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712145660; x=1743681660;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GnkOIhSktsjLuPCwBz7sVCVFITGypkmEfVR1+d32NcI=;
  b=j0szE9xkCXTSsYOK1I8eiQ+GjE3Bn7/hegZiEUcAUI6ZfMITJ/7AAili
   1U3AsYaRP918pnFRqGbWLgcgmHLW7XM3+yWZGl9TbZmgYMrMbc6roIbJa
   Tt4OhMcr6OmXpNg99yWS7zZOpwk2H8XbCRjr96s3nGJPEkggkoRCNaWF2
   7oqQAVgnj62IfZk+zpnlUIznfVLfuR2txlF6/led34V+LEr/FGQgEC+uj
   rwoWSXJi2clgaKKm04OyyD+yK4GBZQg2QTdsxdoWGlrOmXoOsRN6f/MwY
   SYwzphyCrZ8rnsk10ShxOGbVec+L6xTWN09oAXqXSfaM1FPwHYkkqxkT8
   A==;
X-CSE-ConnectionGUID: +F3OyXdGSU+4YnymTCddMA==
X-CSE-MsgGUID: +2esweF1R/qxo1XnQ56GXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7559286"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7559286"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 05:00:59 -0700
X-CSE-ConnectionGUID: KitieX5mSVi0PZU9AyklOw==
X-CSE-MsgGUID: cf4L8dTOS6mpnzFfRad+5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18520512"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Apr 2024 05:00:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 05:00:32 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 05:00:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 05:00:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 05:00:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anEAcQ+Gp11LmJVFhlwIP8KOp3EdKQDdkfsbywU8Ym17GTJ6K3Zc/Ia/3kV4Cc0k19uWbN5ySrmuljFkhTJf0IdAEBEu4EC+wfJQHWKjoPbhvQPQCsGmSmeUroDZBpLlITC6QABeosvnO7sHI3cPixRaV2krX9UZf6+ZbMXr+hqBTP1ByxIOlJeOBBq/slz6YtmT0rKA4+Br7vp1P5OdDZwESW6rciroBwdv7ftMgbbphSl+OY9nFSYQe+YJuITIdGseV/Y3GG9FbYZU3v/PtiBKBp0GGVAiyHiYbYp9vPEeKMGOlt+lF2W5M/jDoxXpfIbMgPDiIWekqzP0DkeIYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o7/I/zNeYhh5xRH58uRp3ow8252Zp3kOQSbascREy8=;
 b=Et9RsJYKncedhHWSSn05O30AMJeyhwWRupqe2gaCBhd03WLaFHHAwrI2rRAQskZEkIGarmlw3NQu9D+OLAPmox8jAaQ0j7tb1H+mAwRn9X3b90eFzpALp3q5Hoa3p7KgwKiR16q7wgXtU1kth8DKJAvHgxi65JVS4jpq0XYdPmmjBziUJ0Xjr4EKHhyZ8O8TbyZrGhAZaMWGhpVMARmMDKURkNhoUbrxSY+6ZoUe2BAHc+eHzCiwVG+8PqLW3DAbPvwFdl6lax4VfQTPmiSU2cgEeblaBFOtdI7lq5h8hz7UGKqYe1vTDqi0f51m27FLnSV7Su0naGR2g21coCKyYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by CH3PR11MB7771.namprd11.prod.outlook.com (2603:10b6:610:125::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Wed, 3 Apr
 2024 12:00:29 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::5144:aca9:5cd9:42bf]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::5144:aca9:5cd9:42bf%3]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 12:00:28 +0000
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: "Wu, Wentong" <wentong.wu@intel.com>, "sakari.ailus@linux.intel.com"
	<sakari.ailus@linux.intel.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yao, Hao"
	<hao.yao@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] Revert "mei: vsc: Call wake_up() in the threaded
 IRQ handler"
Thread-Topic: [PATCH v2 1/2] Revert "mei: vsc: Call wake_up() in the threaded
 IRQ handler"
Thread-Index: AQHahYLJaiVrRgbWd0aEvs3QZGIaRbFWceTg
Date: Wed, 3 Apr 2024 12:00:28 +0000
Message-ID: <PH7PR11MB7605A0653F755C3D5ABFED9EE53D2@PH7PR11MB7605.namprd11.prod.outlook.com>
References: <20240403051341.3534650-1-wentong.wu@intel.com>
In-Reply-To: <20240403051341.3534650-1-wentong.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7605:EE_|CH3PR11MB7771:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6RKW4Nb1H4B9x1tTue5C5WlTnh9U/S/+G4elDp9QUxc1HLN7g9xJYHoPKEqDRqVf24iLGjEZrxRGjOEHvU7zSgmbbrCoPQZRZxroah8MqdVUc7ZHdKUIkKs79vKwK23umZC7YNOSJb8N8LHkLqyZLrHIq7Vj1XXynxKCssqYzoX4zDYYA6qZSrFmHmwinZ2CqfMjR38GR8GsdDK4C7+171VP44shrSqYI16Lxpq1D+BWFZ64e39ia/8L3S+VoMpEZWUGm2AS29vDMBnbjPwYIUmO3BfN4P2SlMibErehmBKtHXdat5sPtwHuCepIqscj2vBZC3VscIk+jzLVfhY/65L7VitUy9XHFKB8JNhZe7fS6QoIvn/gkvTWEceG8YzOxLnFU47ggMTFyPG69WQrSCRompXNSyJmjrZXO2MxpWO9EyzfTiVNiIxpFS5fIJZ5doP54RRFm8fi9y6ZXC7uQwIrg/VqP63YKqZzI/j181GIclid60Z+DB0D1QFPsKnZS7S2W87QA/phPx02fj32zBl4nYg40RmzoDS5D6GFtxq/f0BNGBSyDsauxRYYj2s53wALy5/FsagK6sdNEAHrkTjR71mzXE1/ORBAAohjgCGAcTGD3SL+CplSuP5Aj2NLBANqRcoldOgAhjxe+P1yra8NCj9RMFUiRogdAWhPD+g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gPt1fcFICwX+isoKBtn1+j9h+kgyNJ8bYp6LlEAgMgsxezRnE7tclouGDTSs?=
 =?us-ascii?Q?6GowQrgFDrYDDP38KQnso8f3BFsVcIzuRMq+Oa7Ycdexcl47nJFMC4l5IOJw?=
 =?us-ascii?Q?IG2rQeHBZX5U7zW2QrHDKoO6UYPPtaVnCZ3bs/hcd2boFmBmpHh/ikjL4fjM?=
 =?us-ascii?Q?DZYzLKGy3nSxArs4xFbicypBJYdx9PWYSXIv8lbZDSkMWNEqawbrq2LS0hx4?=
 =?us-ascii?Q?L1vo3EUGhkOe120Iub5IdiYjJX+3aCuZmtDErByrt0H9g3EHp0BPJwNAe3Vh?=
 =?us-ascii?Q?y4GhVe4p30pb5cQj4bYRpuGpYJ6hHoVYGJXFoBPrSEcN04DY8YoJZ4W0OIvC?=
 =?us-ascii?Q?4fHO6m6yqC3s3uHy+Z3K+Sm+g19q+pgNhe8UjdSGMs+kbD0loLmpi2jt1kx8?=
 =?us-ascii?Q?uHwNBStP79HNFxwqi/rnYmkSMJMOMmijAKw+njtpxvHSpUHXCZ3jRKI6WlDp?=
 =?us-ascii?Q?OJYV/0DG+2w02g4+bmC7ICCJR5pVbg9mXtWG0SV1/FkPwjYZPDvMMiKr+Ney?=
 =?us-ascii?Q?uczIoAA3MUDw3uqjbEzi/VWnEG+pvb+WTi6cBH+IL1cxkgx9QmMNiDztGYpJ?=
 =?us-ascii?Q?sV+NXwKrZQevv48bUzW/nXcBrwxPr7i0bKpPAoAeC/6UGQotFF7s/eCCSSWz?=
 =?us-ascii?Q?TGKKX2NrKQewGlUtC91nl7TZZrGCG/0LDJRpjKNq9FJVfeVS40P5IES/BvN0?=
 =?us-ascii?Q?4FTwDPi+IN75OTVMfiWw2aqVV1KnYO5SR19KKZDUL4RVJaSYX/lh9pfhrbqV?=
 =?us-ascii?Q?8kiTEEJCt80VB1AsluADyTyCEnpipGwdpBPf8zItHAXJkvZdsRwEIq+Hw/8N?=
 =?us-ascii?Q?J9feFuOwWzBna5hEz50LYU7rc9trDaimdpP0p/2wDu4ASWcTUoRIoqjatrnx?=
 =?us-ascii?Q?G0FpW8Mu+3l/UmeXu996xYTLggze1fyGcabym8z/9uTSR1LoEKTbYNzs4M9D?=
 =?us-ascii?Q?gpaWdXS6MinCdbLDAPg347vIy4jYhvhsLHk6/ZQihUmeH0Dbdbi7q7zRnI0p?=
 =?us-ascii?Q?AHmE3qXzd9iNu+3z8wmmdkQbVUoL9nVGs6AZVc5Yto5ykW12Ke5H7oNBHRnl?=
 =?us-ascii?Q?jBmhGQhs3YWIaskINPcUezgAk6ivVthB5urCFbbXO/gUdbJNa/IPaGoB4xzr?=
 =?us-ascii?Q?N2JrKOFrw2r5MfyW1fjptxv/ugDV7aLZvIXLkYDzKoSPX3ro0zovYRPgCzyC?=
 =?us-ascii?Q?1riqoBGIaYTwwW3prSbKqnOYmL/c/jIrSCpYaAokUZ8/dnJBpBZ26J8yaQYM?=
 =?us-ascii?Q?vb/5w8mCidi/fi666p4W3ms4QS9Ie2fqO8jae1YRs5ghJr69FM++in71OFtf?=
 =?us-ascii?Q?4M3AheqEb1mzN3dCu9Kehf2LF+OCyT3bb2P7mmbWh3CA2ODQ8sjDDspEEmNi?=
 =?us-ascii?Q?pOwlaXZDZ3LPyDHFIq4JiFfL0B2teXLjP5wbqQmBoWqM4liNKkPDv3oFK437?=
 =?us-ascii?Q?eTJ0XfFdUE1ypRSHD76jh1QVFSiY7sFtHIbofRzp+HRC2Uy3xvOF185vlw8I?=
 =?us-ascii?Q?Q+31h4x4BC7fGCzJzMiYdFdNvy6DxyDliK7x27ajXtm0bcyX8PIe8CWjF1ed?=
 =?us-ascii?Q?6xIMaJxGHBg3vVLAPaDmRxsSwQGbDZsd0vbAXfMu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ade5054-03cb-4a40-2dd2-08dc53d5a7c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 12:00:28.6940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vk8pNLsphGxq3aCf7io+n/VeHFDKQNVOGHUmxMaM7ILbPtMfUcP7FcIZyJx0HS56i+EgQ4ta92LsZ6dn712GBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7771
X-OriginatorOrg: intel.com

> handler"
>=20
> From: Sakari Ailus <sakari.ailus@linux.intel.com>
>=20
> This reverts commit 058a38acba15fd8e7b262ec6e17c4204cb15f984.
>=20
> It's not necessary to avoid a spinlock, a sleeping lock on PREEMPT_RT, in=
 an
> interrupt handler as the interrupt handler itself would be called in a pr=
ocess
> context if PREEMPT_RT is enabled. So revert the patch.
>=20
> Cc: stable@vger.kernel.org # for 6.8
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  drivers/misc/mei/vsc-tp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c index
> ecfb70cd057c..968a92a7425d 100644
> --- a/drivers/misc/mei/vsc-tp.c
> +++ b/drivers/misc/mei/vsc-tp.c
> @@ -419,6 +419,8 @@ static irqreturn_t vsc_tp_isr(int irq, void *data)
>=20
>  	atomic_inc(&tp->assert_cnt);
>=20
> +	wake_up(&tp->xfer_wait);
> +
>  	return IRQ_WAKE_THREAD;
>  }
>=20
> @@ -426,8 +428,6 @@ static irqreturn_t vsc_tp_thread_isr(int irq, void
> *data)  {
>  	struct vsc_tp *tp =3D data;
>=20
> -	wake_up(&tp->xfer_wait);
> -
>  	if (tp->event_notify)
>  		tp->event_notify(tp->event_notify_context);
>=20
> --
> 2.34.1


