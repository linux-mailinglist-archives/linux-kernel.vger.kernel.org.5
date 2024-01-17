Return-Path: <linux-kernel+bounces-28657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7805A830171
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD49287C71
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C57912B92;
	Wed, 17 Jan 2024 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VXyXBw19"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C39D13FEB;
	Wed, 17 Jan 2024 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705481109; cv=fail; b=L1zUcACc7PRPGc1xbZEtOEzN4LxwI3Sb8+OZtTGn1QcB94TGODrlywy5QdjejIzX3mka+T+ZqTc9q8EJCtl4gdJCIuu5UUTyDuDhBEkYTMFbMsfXO/6Cohh5pPPb19+ytVqnR4/U24szCsUeiwVSd6RVsAkJzRyAfI8K8ohWD0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705481109; c=relaxed/simple;
	bh=uwaaMbBx+1ZAsCYtDKD6v4Ob4OfRwfgPqsCQWkwxdik=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
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
	b=ecTUCMgtFhe682msDIa7ZPxJGyBJHjln4v+cHX/5rw21KDWImoY2KxsXd5FfEWEG+z4pyQ3URmOsAXqfPQLDldmngSwM0oM3fXrvlSgTuwtedc7HNnoVZ/J/fVqHanDOAFMhsk6xCyxQMYlPpVP+lmBO62oplFqaLdWioFjia0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VXyXBw19; arc=fail smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705481107; x=1737017107;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uwaaMbBx+1ZAsCYtDKD6v4Ob4OfRwfgPqsCQWkwxdik=;
  b=VXyXBw19VMoopsq6C5UpSxGoIlzsSeSUe9mBxF7HyVbQksnULtozQCYm
   sLM7AWXYCskvUl0hz8PMGTv90Ga/5TuRu2SMaqIxwC6ZEOiySdYvx6RH0
   3OtLSoiF+1DZCwzxb/HnMcKrMCRnCUZqWtw5SC2TqxeapXTp/n3nvVRk5
   NmmYgyTvPxuetGKDF1kERZz+IXuJ6AMZA/jdfddWVRyJkyugDwbnGPIF0
   iqbd7ElGVrlNbTBXkU/zg7ITAWQYMZF+bLghyTl8AjWoVRMzRYAPyTI+B
   kI8w0itLpcvT3TtNR5TWbdvyM1z1CjinZuWOS73+U/u9gnMTWl65VJhGr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="399778018"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="399778018"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 00:45:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="1031286340"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="1031286340"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2024 00:45:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 00:45:05 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 00:45:05 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 00:45:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7rJ0m6uDZS2K0Ea1om3H2q2wHWGLGuvJ0hWqZnu0gvKYBNVzhRdC6liBXaIhVtpw9nbohoX+iVx66SPT1oPzj1DNEHz4XUqd74NCBnjWggzljgIAtk35jDqYqS4zYo1QrKrNkuo/iph2fs5nKETrDiBCwXdzoy6PD+t8VMNu7UvFzGzQk079QrZQ6noghKzK9d3F86Mz3TXuqNapa8ofJg7qxmMO0fjAHP3wK25iPyauPBLuJMqNybAhBvajoi1Hj5n7x/zHo9MMMuxBJxac4sERB9oVgnuR/WqG440gOT0wvVvvtKSu8KLrDsWQQ7AVIp0iWL0uJ+I4pmXLJ05vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwaaMbBx+1ZAsCYtDKD6v4Ob4OfRwfgPqsCQWkwxdik=;
 b=NInzoq1Jfj322WAdCYuVo7nd15M6VFrRFgTNfX1u/ZST15KZcQ4BDe/smLeTFTs/V6A1ycLR1Z0vdjJjdEYLubG7QSkpgDoNkWPwNRCRLvcXm6cmh6bbwHVaEnInJiV1UHlgtwptJdpnB9OG3/2smiI/M2aHGY6cOfj1C1EWktco/8vnFYHHB7sHHFh0MYpSq/7vqoIMr2giDcLaHmth+TgP4taDrIOYowwLHTs2JdQWXvpXj0En9TAwbWkshCSO7S6hoBms9aQ3Dpw1IRqkdXxH4XUKFY/naMcWi45HTJQE7mXOQaWVk48J6MDiUQKM7SYj69ydo2O8qKW60xwOBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5370.namprd11.prod.outlook.com (2603:10b6:408:11b::8)
 by SA1PR11MB8373.namprd11.prod.outlook.com (2603:10b6:806:38d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 08:45:03 +0000
Received: from BN9PR11MB5370.namprd11.prod.outlook.com
 ([fe80::3d32:2de7:4924:4f2f]) by BN9PR11MB5370.namprd11.prod.outlook.com
 ([fe80::3d32:2de7:4924:4f2f%5]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 08:45:03 +0000
From: "Chang, Junxiao" <junxiao.chang@intel.com>
To: John Ogness <john.ogness@linutronix.de>, "bigeasy@linutronix.de"
	<bigeasy@linutronix.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Li, Hao3" <hao3.li@intel.com>, "Li, Lili" <lili.li@intel.com>, "Gao,
 Jianfeng" <jianfeng.gao@intel.com>, "linux-rt-users@vger.kernel.org"
	<linux-rt-users@vger.kernel.org>
Subject: RE: [PATCH] printk: nbcon: check uart port is nbcon or not in
 nbcon_release
Thread-Topic: [PATCH] printk: nbcon: check uart port is nbcon or not in
 nbcon_release
Thread-Index: AQHaSRHUAxkUsa53fEifHKPAjcTOAbDdquOAgAAAXhA=
Date: Wed, 17 Jan 2024 08:45:03 +0000
Message-ID: <BN9PR11MB5370065F4E7443FEA156347EEC722@BN9PR11MB5370.namprd11.prod.outlook.com>
References: <20240117065226.4166127-1-junxiao.chang@intel.com>
 <871qagtlk2.fsf@jogness.linutronix.de>
In-Reply-To: <871qagtlk2.fsf@jogness.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5370:EE_|SA1PR11MB8373:EE_
x-ms-office365-filtering-correlation-id: 45a3a562-f0ef-4003-f99d-08dc173898fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lq1vxbYMyeHpTy/Mk+BzzQJfGWx9W4r1qj2+T8D/3ZBAmimajGw63uY+FxvYawhTFwy6A+nWU93OPTDQTgBlQoub1IXNdVnkJ4kyXvXrRlQ1Mp6sJ0ypILi1foV34IUO46V2UmgdJvLUQxkVUZL8GAhmM/i3qsJYyPRRcIud8WJGLSp+xImwtSLvELPqU/cOM4kobOOm8D60luE/xEh7z3CYkqXuIHDV0i9nnZ+HWMgxjc7EXeZ148RfrVVCguOXs1fE1f9xGMgPfg8jsIrSZ4xBs5wvBQqt2s8Ru03RbiE7QIzyGiRP9CTvYnVg4ywQSE70HeYn6gQkIb5w39QQgruha2DVzniJAVNFUIovTVzG8PDmny/bBREwX5e/fpy07Q4xTgCm3cukZdhmhIeNVyzBY5oaN3TiO1MGP8PAdGi37cdBbC2X2/GpzFN3AH/X7fkOCgwutF3lpoGNwH9UXyIClthNloIDsoJCQB8NXJx1ClNeF71HXWmdmRS1JQwgeSoSVWeJJkjO4nK2GLfEb7Xxo0bWKmvrjhKfcIRm1wJCthLi+0DKeSbqntiaRQmXjuqSoeeuLk77wNcLSqDMF+f9vDPUbR0sSci3KBiRm7FOfH06q/Ja79hYJj96NhXo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38070700009)(55016003)(53546011)(66556008)(9686003)(7696005)(6506007)(52536014)(83380400001)(64756008)(54906003)(66446008)(316002)(66476007)(478600001)(66946007)(76116006)(110136005)(26005)(71200400001)(4326008)(8676002)(8936002)(122000001)(33656002)(82960400001)(2906002)(5660300002)(41300700001)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RXwyPgpVkGmRwy/6Hju5IQZmauhUK/Ghw3FlOP4vfG4vn93zP87rOmIpuzXt?=
 =?us-ascii?Q?TfV6Nrhd1yYpUTHsDsR68aP+KJXiWzjkyJjvdPI4nCWsOPVaGLDnBMDm0rTQ?=
 =?us-ascii?Q?vxSZcOyKqmVUMJyTKZDhZmggIG1B3L9Uh86E/gYuYInbvIyT8GRF/cUFb9UL?=
 =?us-ascii?Q?RDjGSeD+WLGSntPIN2Z38cgXunfgMJe/2tpz2Xm6y+mNapGGUBmyHhEMioSJ?=
 =?us-ascii?Q?6AJvSvL715Es7O4bDLW8vG9mJMCa+scOWNRywZcB3YUtTXvN7iySWVKLVUQR?=
 =?us-ascii?Q?j6s3izYbipyTc1rgo0BNpvezHJ3SCBgxfRohETafP/laYBUx1/G/A0Y65wwm?=
 =?us-ascii?Q?e3nDwgRXCqRVGnFijthHyn5nb+i25mb91GFBzRkVpXDzOohDFPmr3hu9sM3u?=
 =?us-ascii?Q?rXy0ufYokT3203qHwNt7pbx+p8fl01wSbo3HvYu+yipqzmP8ngESEzlzOB43?=
 =?us-ascii?Q?PN2RrbdwkXjMwrhzG93ZU0NrSQEuBvmeoBAcb9cXlRKz0YtX9YdAyOPayNdV?=
 =?us-ascii?Q?23HW1WCujpe2O2XueHcQwSi3P4ryZGdqu84u/pwB1i4knS/vnbtYqwfwdzB8?=
 =?us-ascii?Q?HNaUxWMmSvQW77ljBtZ/uvAfUNaoe7jV/vgr59CiTV70NuoZl6r9/FaV91ck?=
 =?us-ascii?Q?mwVb5xqvPbWgRD5yR43CQtKCAn9FZyaubEcW/upAhxCrw7YCTyiMkhEaHWP1?=
 =?us-ascii?Q?gf5U0SZ2mv+64CIHXS6QEtm1GQ541y/Qg5GldGlOEbOj8IjY0f0Xz5VicOcp?=
 =?us-ascii?Q?9whtpojHlmuScmFI2uvzJ7yzgLkkYwlTYoZm0T2hONfGqLq8bb4gUCfvJ8kr?=
 =?us-ascii?Q?NH9SE6yUmLAMNMyhUldCtAdIPv9m7Xi5SaGZndmtmonDkpQzFQmecruOiP/G?=
 =?us-ascii?Q?BRSKwfSWnHy1HZLXbDlJQw8Efqe8q82t0w8LCJvbWB2znZvfo3KVacpW+rvh?=
 =?us-ascii?Q?Rhmos5N87zmIcNtvBwH29kY5uySYstZz8FBas8cu3930xCENDpvqIjwjnRrH?=
 =?us-ascii?Q?lakKcPI5T+E3hKiy7wG5iK3pUWMhz1AkXCMbijA3UVWUsBzQDcYLGxbr1qIX?=
 =?us-ascii?Q?Ak2Z05VS3enDeR5a7J2RvI56UlZ30JX547bRiUJoWphh7tqe+PT1e+DnYrG3?=
 =?us-ascii?Q?EXNpjbAfJMq6iVWYrqVxf/8Uc/D5k1Itann+6T74IvVQOA0G+6hpZEDz9us1?=
 =?us-ascii?Q?3MdQX6YVWRbm6L3sVlciID3qZrUGImAjNJq/YAOTqp/3Fhe2x9mzfETwAZKN?=
 =?us-ascii?Q?luzvtHSbe0M0dzUDqUGUDpCCHF9G9iHt+g3BukStRVB/b5DVcU3OSdBw2apl?=
 =?us-ascii?Q?rpo+1hKXHDIH7494xKeIqzH4d1E6dqMx6T8lHwFIBBNgycQtk5BuSWswp8IO?=
 =?us-ascii?Q?uomc2tGsZfl8VsGL/9Efs2HJTBLAWNJHlWc+zEel7aghW1z6KnNulNJaPY5y?=
 =?us-ascii?Q?bmiQ3ArbzPkQpbaik3sJ1DO+5YxzBSnrAQ4pmrE7rHOqW5Bc/8Pt4aQTPhQ0?=
 =?us-ascii?Q?j/6FKDELNY3Poalvfn6PlU0HzDHUx9n+zO5rw+rCcSYeFjA1k6ig9uIk6ghu?=
 =?us-ascii?Q?U62GZF8hWp14UebkPOq0CQ7w/5+M+vlK/h8V1CJd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a3a562-f0ef-4003-f99d-08dc173898fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 08:45:03.1793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VClpBsShT2I+KeuMV49ZmBXxQQ8jdKUbPjrRbbBIkjCyNEI3KqJMEjsM8o6DnpYqXxb8CRy5PzxzeMXSZ3psFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8373
X-OriginatorOrg: intel.com

There are several serial ports in one Intel ADL hardware, they are enumerat=
ed as ttyS0, ttyS1, ttyS4, and so on. Multiple console options might be app=
ended to kernel command line. For example, "console=3DttyS0,115200n8 consol=
e=3DttyS4,115200n8 console=3DttyS5,115200n8".

In this case, several uarts "cons" pointers are same.

During booting up process, login thread "agetty" might shutdown all uart. A=
ll uart ports could release nbcon lock even if they are "non nbcon" console=
 However, in "nbcon_acquire" API, if uart is not nbcon, it returns directl=
y didn't lock anything.

This patch fixes a boot hang issue which could be reproduced every time wit=
h Intel ADL hardware/v6.6.7-rt18 kernel. BTW, this issue couldn't be reprod=
uced with v6.6.7-rt17 kernel.

Thanks,
Junxiao

-----Original Message-----
From: John Ogness <john.ogness@linutronix.de>=20
Sent: Wednesday, January 17, 2024 4:24 PM
To: Chang, Junxiao <junxiao.chang@intel.com>; bigeasy@linutronix.de; tglx@l=
inutronix.de; rostedt@goodmis.org; linux-kernel@vger.kernel.org
Cc: Li, Hao3 <hao3.li@intel.com>; Li, Lili <lili.li@intel.com>; Gao, Jianfe=
ng <jianfeng.gao@intel.com>; linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] printk: nbcon: check uart port is nbcon or not in nbco=
n_release

On 2024-01-17, Junxiao Chang <junxiao.chang@intel.com> wrote:
> Different uart ports might have same console pointer,

Please explain how this is possible. It would be a major bug.

John

