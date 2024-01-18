Return-Path: <linux-kernel+bounces-30042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DB083183B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0B91F22EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663A3286B1;
	Thu, 18 Jan 2024 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U6Wdwb6v"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F8F288D7;
	Thu, 18 Jan 2024 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576372; cv=fail; b=qfsZycEOrGPCSVhV6LBffDXgterC5/nS44vJ+cqTFlPhvgjBgGx3K14o03+XZWjDszjSiYDqvN18q5L/MjRoxv4DgE3JJUDR0RSmrlciSHt2ojc+8majLpta6Ei/ENNtv1JIAtMYZdKLJ8BXo5/ARECp6Vn6F+yW9X0YUj8Yb5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576372; c=relaxed/simple;
	bh=XDu6OF/MI6+9V8mClzJqoGPxtQ73hj9DhMcOp+iL9Qs=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ld-processed:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=EcZHDS1Tah+dXGdPe1vJ9OXA23bb3Mc/wAKe3NbspbJjHm7RrtBMVzz9TpRe1GZUpqdmakzLI/pOSiKDAZBI5QKLFNE4faQ2qmODVJzMBZrHY3mRjbyhYNvxdPtMBXpxSVziBJ5PhrIUE8cT8Cwyuq9Js1WqUE205Grf1e946cI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U6Wdwb6v; arc=fail smtp.client-ip=192.55.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705576371; x=1737112371;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XDu6OF/MI6+9V8mClzJqoGPxtQ73hj9DhMcOp+iL9Qs=;
  b=U6Wdwb6v5RiYXTQ9JDvkM6IWpvz3s652DWGJfFdSRu/W0c4Cs7LNx9Pk
   D4enj+E72NZx3/ZGVTpQNx3XxqQHqcmzRC/LvIzxnjDv8KOvkI8MWmHjP
   04GxvktJhZMgvqiiushUlafidh5LUzmsUjydtv2kkspPUGDfDUk8a8ZtF
   SRQiC0GAKOSMQ+0Wxu3pL1JwY4GsqDyTIYk/3ngcQYfkWtgJ7OXsJPNa3
   CNjUEej23XMZ7VWEb8uJzI2A/hEktyNV24sPl2v2Kj7QuE94jUvO016eL
   bld+bHbEpMTKnbNJcXW2EDB8yCpqjMEl0rs8NTSusp8LVgnGD3n8tjriF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="486571805"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="486571805"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 03:12:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="784777347"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="784777347"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jan 2024 03:12:49 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 03:12:48 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 03:12:48 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 03:12:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHmqoJz83JViXtos/RHL6Lw/M/BjALPllUwuWtCqneuAkPanxWRlbumfgM+vXXn4eE34KGfDBqlUmcePhr4bE2v8Elf7DUSDxS0nbEs0itaajGRueEhDEXE2zxObP50PBZ+l8KU+8AHVVp0gDDK9WsB+v8WR//L8mSoVuM3Wh/WEAXgkpcgByad90jM12tGz3H7razrYNnZacF3gJo23fpsNymybCeqrd28ppvKDQbhsmT8KQbbk2l+zRiZtTvbF4UEEVCahAJFQuSZKUarPWuydO7l/u63OnQqSB0mNlv+sCO3EcWqPbsX6D6+Wge79L0ZMVCQTJflaMUCmSSMbGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxlby3ixKr/V9hlzIZjjXrRRu7RGLqS6PourkMMOmTQ=;
 b=Tsf+qLI8KJxoPgmiTpOlI8eNq+0TKJC6cNfn7Ko4epwmlp5lZx6h3EiuFUFIpcK/OaGfo2vMBp/zu6dx8pvT9RDVrliVDDDQdajUPHXKnHiON8bxbsL9WYOLbeyP9SS7TRzXcPHThzH2qh744QeuP/Dcyfxeg8Ui2o6KpESM8EZhm2J8PE6DaYgvF6/gRQlxtosMaOacRreWEIxdj30AQVxbHolG0hyNjjIdNNJb4YCQTgzlwgPL11OcSaGhKnGLieV8wN8ZLoD2YsbA51G82l0vJsbpklec9aQBBgeZTnHtNxjACbDT7/lVHizPNP+1GmIiOi6THq4u7Oep466hUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 BN9PR11MB5337.namprd11.prod.outlook.com (2603:10b6:408:136::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 11:12:45 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a%6]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 11:12:45 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>, "Olech, Milena"
	<milena.olech@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>, mschmidt <mschmidt@redhat.com>, "Glaza,
 Jan" <jan.glaza@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH net v4 1/4] dpll: fix pin dump crash for rebound module
Thread-Topic: [PATCH net v4 1/4] dpll: fix pin dump crash for rebound module
Thread-Index: AQHaSSYIaKVjAh3jtkyFeoA+JDsxBrDeD0mAgAFcfIA=
Date: Thu, 18 Jan 2024 11:12:45 +0000
Message-ID: <DM6PR11MB465715FB1297FE557BD492669B712@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240117091416.504096-1-arkadiusz.kubalewski@intel.com>
 <20240117091416.504096-2-arkadiusz.kubalewski@intel.com>
 <Zafi9wid9HlbLM0z@nanopsycho>
In-Reply-To: <Zafi9wid9HlbLM0z@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|BN9PR11MB5337:EE_
x-ms-office365-filtering-correlation-id: da5258de-c050-407d-3b75-08dc181665e8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B+/tYeo0qybkdrqBHV1//Y3sIKZtNRgVj8naIPG9iyovZWKtP+K+Gi99OFESZpCjVyjGUUrN5ZxAewaxtQUEbqIKq3nxTSL6qT1KHFQmYY+p0fHAskx7wfGnH2zhM5z+k1K44JzAtkLYRzclhxWGMnXDFVOTd8zziNy2CpJePKvCpKZnFhFfDIYZzTMTYgbiFmLzxxR+MxuK/AMWzEngEdG2+Xt5wCK2Y9lmY5RzF2lFXh+RcEh/Qtuf933W8cVxc7MhqG9BeNdU/ZSbpFT0ELAaMU7rNrnhZkFzt3fBLWkAGC1x036P/iw/iOfMVkMhHF4GKLfNB5WS5jQWHsqay5idDxBlYC657/S/uRF515NcFA9P0KnQ94xZvA1O9iPwbvhnEPN1jtwkKNHxvlOKwcjgdDpSNVsbUdyRI6b7TX52C1tEXCZFIXxwq/mmKKFA3qsBmRf18ovXSIErIlI8o2w5OkgNVcodxrZYljMwdIXjpJgVSFR3YuZ5QSHwXJKGPUqq7P3RO8YZ5J0c+eQMf5kKXN2lTgLnifELnD0U8s65tA/c8mmuTspvjcenfPWo2dK7jAnx20H4PZGDwXNoiNQ/CRzziQ2VqWUuFD7LkDqDaHeaOImKsdYgBGsHR/mf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(136003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(52536014)(66899024)(8676002)(8936002)(4326008)(38100700002)(82960400001)(41300700001)(2906002)(33656002)(86362001)(38070700009)(122000001)(5660300002)(7696005)(6506007)(26005)(478600001)(71200400001)(83380400001)(107886003)(54906003)(66446008)(55016003)(64756008)(66556008)(316002)(66476007)(6916009)(66946007)(76116006)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x4u5dqX35KX+uFaM4lNALf0j/dBeXoTnQrfqDMVQoQHl011PSzvwfZoFx5Nn?=
 =?us-ascii?Q?URoOYnG9K0iiZj/DpFVqUVwTKyw8j+glTQA00oEYG22HWNvDAxgQQ75ATuAP?=
 =?us-ascii?Q?AumSw1IakrPn1lNFQvYab2w+gDi2jfEeIwJjgTPD4A2Q0MoQV1tE4BX+g1sa?=
 =?us-ascii?Q?v7y4XGkUj1329YaU/O9CFivDacFzSF8xFHQQ5Qga7FXkkYw4+0YRThvcjO76?=
 =?us-ascii?Q?FvVj72QCClSiVt8dKD1oCRe2TyKFxWhAfXVPcjYWFR6sN+UpJAOl5rxiRnws?=
 =?us-ascii?Q?XOuN7SpQ0y8Tb3L0BWFbpxAl+0Ws+rmoDaoK6uuxzwfrcq9d8xeBHTOtEqG/?=
 =?us-ascii?Q?y28Jw1BtcxTv4QVOMm+DsU4ZPsxVYqY+sthqC8JgUYSFo/P2qlllnmotJuVH?=
 =?us-ascii?Q?ydXJgdPQeD1p4mHy+ZoTtTVg2j+qbTE3EDIHPL+j9WkL5GPDFC2eyXcmRfV8?=
 =?us-ascii?Q?4Fl2YclApi0RCW4ylsJdk/SfdA0b2GA0dsZlH6d1hAHeuySWwnzdh2pJ32MT?=
 =?us-ascii?Q?b5aaX5GRL+XXHKepO+om7PW/D4vnFvG/WQU82vy2GcitAluWE5csBmXWOjOj?=
 =?us-ascii?Q?S/FBwPjDiSwG/3yxT7sCP9YTZF/eMBjjhiqWveg7WirsyTrsBp+MzjmRTFaz?=
 =?us-ascii?Q?uG1mNjzGxcmsPvwI8MqD16kdWJAbSxdXR2kpn1ZzRkgb3tNmWTxnqKI3ojxP?=
 =?us-ascii?Q?49vcZZd0TnXoxNUJ/din3qFRbz2cN0+ra2QBAUjtt7X+IvxR3O8HFzknhvbO?=
 =?us-ascii?Q?JGPVc+HcY9BfVZqLeCpUIaObZJ++bMZ9ifk4gnhlFYp6mOptNjP0Lup+jHD0?=
 =?us-ascii?Q?F6Rxl4p9wH+MCtpfZt1AUcCFoIEqEa4Axn6YCuBb/K53uXA8C1cqE+x/G06E?=
 =?us-ascii?Q?6bNvvcc8LyVyz1W4ob+rMrghjANDXgs3MIqNaKXTFunANnXZagtl/Abz7fRq?=
 =?us-ascii?Q?atquF68BCPsfXmcFcT2Xce7qMEASirJPDLJvhYHqp7kgML9JCRbvv6z2v2jI?=
 =?us-ascii?Q?R/FPBhzWE9XX5kIKSCnGxTX+9gWyPAmatlRyGxmseLl8/lyUnd6T22JHmPKc?=
 =?us-ascii?Q?9lBgZ1Io3GT1aHE2S4NN1Kwa/MM5mWtb7S+GHbn70wOVQ4W0p0l5woLs46NH?=
 =?us-ascii?Q?hJxw/ihw38ZNN3pNvWg+upve6uK72pO7ozBjE9sIUk6g3xjLE4YYPoQD7kGF?=
 =?us-ascii?Q?dtYN8bzGsY3ZGjsE2zOGOBc6nzRWbcSVPQMhoxKcrjQnfZYzRYuW1BBuMvO+?=
 =?us-ascii?Q?tBNdNODWJSjHrbFFv5sKSGkyZtk+t68F0pPifkzszVU0E1d5koVK7NagEs5x?=
 =?us-ascii?Q?bkE/wPclswmrCSb6WZSTkCrW2daKsUMOrgM20Lb4NhP6zcsU9L3LWTeWCinz?=
 =?us-ascii?Q?+Mj6qR0OLRSjhDsedh2F5PVoTQWpnams3OuC1LnNncD6pDlU0Cfv/n71ZjEI?=
 =?us-ascii?Q?Sh8nSMq02DTpPyFrb3Q49iueNgCR/vWuzmYdSS0XROwUE1FwsYkPrjE7vYjX?=
 =?us-ascii?Q?L+0+Chmxre0eWLR4n0jEahZD2ZLTA7+QOClwKbzrQxiGc46/RyPq8/RRFUDI?=
 =?us-ascii?Q?zlkuK1O3OKHhrubSpEDv4obPykI0fIeudSGJw7MVC+1LQrTXUCcU8MhxYsLA?=
 =?us-ascii?Q?HQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5258de-c050-407d-3b75-08dc181665e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 11:12:45.7307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jYi6uiXx2NsyDMtuQ/Gy9O+emP0ZExKUrYf7oFDRmRfvtqLh/wy5+d2aZm074fcCufb165Qk1DYfnExS1oe4mgCy2SSRttmmilnIPoTAdyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5337
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Wednesday, January 17, 2024 3:24 PM
>
>Wed, Jan 17, 2024 at 10:14:13AM CET, arkadiusz.kubalewski@intel.com wrote:
>>When a kernel module is unbound but the pin resources were not entirely
>>freed (other kernel module instance of the same PCI device have had kept
>>the reference to that pin), and kernel module is again bound, the pin
>>properties would not be updated (the properties are only assigned when
>>memory for the pin is allocated), prop pointer still points to the
>>kernel module memory of the kernel module which was deallocated on the
>>unbind.
>>
>>If the pin dump is invoked in this state, the result is a kernel crash.
>>Prevent the crash by storing persistent pin properties in dpll subsystem,
>>copy the content from the kernel module when pin is allocated, instead of
>>using memory of the kernel module.
>>
>>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
>>Reviewed-by: Jan Glaza <jan.glaza@intel.com>
>>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>
>[...]
>
>
>>@@ -443,7 +490,9 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct
>>module *module,
>> 		ret =3D -EINVAL;
>> 		goto err;
>> 	}
>>-	pin->prop =3D prop;
>>+	ret =3D dpll_pin_prop_dup(prop, &pin->prop);
>>+	if (ret)
>>+		goto pin_free;
>
>This does not compile, does it? Please fix the error path first (patch
>4 should be patch 1) and then use properly named label right away there.
>

Yes, I messed up it, haven't check if each patch compiles separately.
Fixed in v5.

Thank you!
Arkadiusz

>pw-bot: cr
>
>
>> 	refcount_set(&pin->refcount, 1);
>> 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
>> 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
>
>[...]

