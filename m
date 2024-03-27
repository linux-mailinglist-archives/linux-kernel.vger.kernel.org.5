Return-Path: <linux-kernel+bounces-122002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FD888F08A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6911929D16F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D80D153518;
	Wed, 27 Mar 2024 20:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjbFZ1Gf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600DE1327EC;
	Wed, 27 Mar 2024 20:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711573186; cv=fail; b=adFoBOLhDyGmGCnHg8eKNL1fv6p7GHoDjSKyYTgqPzAAQFxFCEQJzbHhHUn5i4BlYFaC0X3Uc4mANAp8efVy8z+hZbXRNNDpcT+tSQVrzqbkwiq+O30w+2UjU4CjN0IPp5uGFApT3Ax0PDJ+3AXn6iiCS5GqkZ4Sb5qBK7R6SUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711573186; c=relaxed/simple;
	bh=V7zl1k9fl9LPv3jnIKFyjww72+51m+dbI4u2z5RYu64=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OJMFyB8BrCLcUX8P6jHSczqSe7nn0Cm2rEtbdpNoVVGqPuluL4YP5WNyzHLQIbNwxGTbb43/xNq1jCjZP31nTGo5ldb0etxEUCboqmHXCFZ/n6wXYwN3Fm+E8Up05iL2l8NBboOy5tQlBm9kRSn0wiuoOYTrgRHczltywkBE4tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjbFZ1Gf; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711573184; x=1743109184;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V7zl1k9fl9LPv3jnIKFyjww72+51m+dbI4u2z5RYu64=;
  b=jjbFZ1GfFjYQhx7JZTRPlvvWt2NSXp4YJpPiTcPSBxYA7DZQV8k1lhmT
   u3UeiuXGjxEGukM5uTXaf3E/V9SWkS11GasJido/Hd6HnTHS15Vf79Rbk
   rTHdiDkFbeD4MCYrENCOi5Pn8/wpQ7CXoymemsK/H0uqNLZGRw9xFkpFx
   xzsPz4iE/AUDTkIYnNdLCwAGl7iQlvVH8AYnqAdxbK0yyeSndhn74eYKL
   zaZAxOXbypgbHlCmd6iO5f/D4awcoPpyy7mlqRmh7p1wKyMkBwJFsXzXN
   Uq9q0MwIpyNsdRvkgZ5cwfTP/3Ew2MQyn70lfg2tq0TcZDXN9WKqaf6EH
   g==;
X-CSE-ConnectionGUID: ZmtTWtr4TOWYvcTaDVQdyA==
X-CSE-MsgGUID: S/CUusaTSz+vu+NOkQkUmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="10508691"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="10508691"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 13:59:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="16824145"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2024 13:59:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 13:59:43 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 13:59:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 13:59:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 13:59:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ia7dHp9DDd72j7tgCGb2vJkgHUQoPVvjjbp9C1BNPUARdkcXIzHKVKSOwVkiJnomvQayB+qG/4X0Ernqp8xE0cMHc6tvDMz7xVssdelDgn1GJWQ2o16kSg+6nLXHjSOL/n11ZI5o16zavyKjblGvR/vRxI7+cyHsDNkXISKaTpawmxraks8tewuLGo6spDlHiemgqTLUbQgjnP3wK2nKww5LRu7d9dUpyrpOBakHO2txOqQ4uh90bF6KlsFB2Jb0+17cFIdp6Wpjet3yRoa0oDPqIS8I44VzKc3htTeizDTEedC33Io8Cww9WStPP9GIOXlZpBj1pfPVYu+WadZEPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7zl1k9fl9LPv3jnIKFyjww72+51m+dbI4u2z5RYu64=;
 b=ABDXCKKj78/CrtY5grx2pSApCHxz0cKnDtw6E0noJRW18BhSeRjYglR+YoR2cKTBjgmF+7EJUXsJ7YSPvJBwQ6TemFoEJ5PRtv7m8U/dJhW8QasViEMZOuYGOEu2dDiDKyuXOpLDkKw1ZnNENrQQhGDgUyAt9chM6tmpgPJ1LVGtyXBSb6HAfefTawUU16SGbbQLI50vlmz7i0CoBLSlKPs86YZfzIlCjSMX2ZYVcHgFGHJIqayKqDiMlyWvgLesGr1+FXVGzbjs8P/VY+/co5J00rUxXbIalfSDZqtOtQxEydp20nBPPfHSSZPxJ14+VF1pJpMo778yUx8jkOjtBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH8PR11MB8285.namprd11.prod.outlook.com (2603:10b6:510:1c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Wed, 27 Mar
 2024 20:59:35 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 20:59:34 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Avadhut Naik <avadhut.naik@amd.com>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "rostedt@goodmis.org" <rostedt@goodmis.org>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>, "avadnaik@amd.com"
	<avadnaik@amd.com>
Subject: RE: [PATCH v4 1/2] tracing: Include PPIN in mce_record tracepoint
Thread-Topic: [PATCH v4 1/2] tracing: Include PPIN in mce_record tracepoint
Thread-Index: AQHagIkSEh+dMVNOYkaLfL+BrrGX4LFMEfwg
Date: Wed, 27 Mar 2024 20:59:34 +0000
Message-ID: <SJ1PR11MB6083A99D9463B78275B68E4DFC342@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240327205435.3667588-1-avadhut.naik@amd.com>
 <20240327205435.3667588-2-avadhut.naik@amd.com>
In-Reply-To: <20240327205435.3667588-2-avadhut.naik@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH8PR11MB8285:EE_
x-ms-office365-filtering-correlation-id: dce8d2a1-eff4-47d2-c862-08dc4ea0ceb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LWH7vH7J6im1MYtUy67ig//+BWNYnmKSE0fHiLhC2Ugw4mVI9a+ihol9HPVHZH1EkYGpXS9z0U32Hc6cRib8Xpr9WBfhVHbLpK2lZqJxDLprZxpPc97vw2ahh6OnhEjSf/6J6klcQg5xBTUpFAFzQ/OPb5AHirDpkW27OHx9D3kFeErMuC+vLOlGX6wV032TuHce2+Y69vtOIaNneuaAE3MFAjiWrxF1XS/prIjSgE+QsDwQDMgwPY0g0+BKlmsd8OFvf8Napa+T5VXxZ8qJc3VlEPtAJaU/aVf1Vl7jG/COhpu35A1E5V3SUNbHDXEL8hbKWLZb4lTrnRUzwcuaNssmaibRyVsS3+7eOanWlIIU+KHV2CDJKDcXBn25pabrLZd0rwHgsdvpMhVgD7ofYUHn1U8dWoaJdwRHhtckAls8jZr5aPFJXqy6PT/fibaRR5ypVrbeC9jRf0tRCtJnzpim3NMg4T/rdyz8up8fwuJh2fnKDKU+stGK6RzIkeZO8oDcYhyAYH4gr5mfPePy8m2aVBLb3WKEGmIN4nKjlzsTDtaxcPF4P9BDf6O4CFrAWf+omeHXR6BwKXruGovHAmRfBirzva5RgMcSOnL4bg5y9X/fHMKHnsywIwvZ0gaD8B8TcbdT2N97SaVngfxvn3mSIt28AC6LquVF5hA271U9R5119E56xM6ScO4xDL3ZwUoBDThrZShWYTOz/md0eA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JiyRj2mt+H65hPuwUgBp/vnYWAnewA80wM4CQafq7L/+zJC4hEMBcXpQJMvb?=
 =?us-ascii?Q?AgmIPHnPOFPkYmpVWN0QF4V8X+xqAopjhbh+qNM8DHmq3oDELv1kUT2ktU0M?=
 =?us-ascii?Q?EElGhkjprbLhn/iH99ewlNfmmuulb3SNaZcJlCQIg7EsVt9B8kCQoAR0j9K4?=
 =?us-ascii?Q?WbLnV3voKAsYpqUnKo5kQOmBbD9Z2iOaAWnnNAV9mb6DFEDKhY0N5Nru9zPf?=
 =?us-ascii?Q?g3TL6Tj5SbguuN4oe+xWNv1kmm85UtPEYqNlcLQunp5DqWRL5e22jpSfITJL?=
 =?us-ascii?Q?ARlKNwXszZ+OY/oArSMFjgWnD+ufqV9x29G6+vU6p1hex63bkRBZTY5uNBIX?=
 =?us-ascii?Q?+ygNzUy6iCsRzETqnZljuNbgZvhLI2OWiBCLCsmtTYbeV+R2I2RUNcfOm/zk?=
 =?us-ascii?Q?KIZIsdCjhu02tMwU/QffNVj+x/90IVkTer57Np2hGfLlmBagPd8AZvp3lNj0?=
 =?us-ascii?Q?nVgYnNkkCyRN84zrUBImRmYSOUG2xlzHVgyPM9mDg4ONRNj0gPzgop5QanSE?=
 =?us-ascii?Q?mSXzb3XyirhrGSmpxHkFmllTUSKKla9ClV1MyWWHUcdFjzhXKqlcCmuy49vz?=
 =?us-ascii?Q?8bYkQkqn6CR+5vrXu6zUJErmtwh0Mw41h6hBLoJUOhTwfJ6DOiJP/cGWdiT9?=
 =?us-ascii?Q?UUxOVXI9zPDAiJ1VRmUao9JwzjKmvpw/RJFhhcmTMr188VfHlOn6e/GjSx8Y?=
 =?us-ascii?Q?AYi25k7T9gj7/uiy6aQVZyoASI+vKG8w9dO35P2CECZ1pfRevacPJAwrvF9a?=
 =?us-ascii?Q?DLWCeOGO99AwY+krBfjxYTkySv6s+kF1yzspK4xDLN0hg7jafndGU4UgvOtE?=
 =?us-ascii?Q?m2GsEi1QX46R/BqKr2Xvmwpq+6XHfFhDyvyqEB+CJxpJvXoseX7M0F/aWl7o?=
 =?us-ascii?Q?alsv9C371gn16QNEwG41b51xwfMREX6UuC2ulUMshnKh13KSGJEKL0zsv+PV?=
 =?us-ascii?Q?7MO2tvFprpZ7+0YbCvBnG7eK4KhBNY5avE+p8h5Ux8ZKEh70G1pax0UocVmf?=
 =?us-ascii?Q?2dRMvcdV7/P5mlnmHKd0saz+uni0xGJPdWB0LaVGr9KIjZMod3Aw0tgADmBi?=
 =?us-ascii?Q?2DPJsowSousqhzKv8fhITMV7hjYFNyxBlK2mF3CREQdjjErikGM3J3sWRQz3?=
 =?us-ascii?Q?yDop1RnfntCZmZilUSr3NepVAb6wJMvF1JOSLwkrALBeR4bCLdGUMrrYTPLQ?=
 =?us-ascii?Q?7roWKWX+wecWia8pJAiYoVTFSflxIpEu8WpoeTZgKx1NbUMGd1JVTA93pD9s?=
 =?us-ascii?Q?WYkvZFLWZXKcbponOLtWbESGPOXEPuQ8oMLUb6zSHepKNHwcJe3i41ZBI6H9?=
 =?us-ascii?Q?/V3GuPDzTrbIkSM4IuWu/d709i0eLh9sp8SvSJWPm0t7mlNUZ8n7bWSlPjyC?=
 =?us-ascii?Q?fO3HhZJ8gsgjXusgwMOzHGdI2RsrPnFsanxF+bVN8gfF9XFzryYrMllhalVV?=
 =?us-ascii?Q?wVCKdyLJM0ojxItHNrihDAIqDWH/Fw+gbnyHiWf6GcvlrTJvc1V26f6KRykY?=
 =?us-ascii?Q?fL1+QWZDZxX88H/yuZu7m1HtbKsiOU+lsq9Y3PGNB3QWHHRZwOCfJORWMuCU?=
 =?us-ascii?Q?+0zXTfMiRUOx3Rs+gA+K+6f/wG+0fr28dFAm56TI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce8d2a1-eff4-47d2-c862-08dc4ea0ceb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 20:59:34.8883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GpBL7kf4JsyMi0TEsazUGryQWbm8KlEIYiXNzb5Nr2jUAjUYKSMU9O1VrOdL/NqZkasr0XxtYgRDO2m6BnusDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8285
X-OriginatorOrg: intel.com

> Export PPIN through the tracepoint as it provides a unique identifier for
> the system (or socket in case of multi-socket systems) on which the MCE
> has been received.
>
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Tony Luck <tony.luck@intel.com>

