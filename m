Return-Path: <linux-kernel+bounces-29476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12651830ED3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460A3286321
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2170C2562B;
	Wed, 17 Jan 2024 21:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3hJVyFl"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D4D25621
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705528467; cv=fail; b=QG14sFyVals3s5PkIIzeZjCa+n513ZUEnVMsTNlAApLcLBd1CdYrL7ccjrZtK3EOUEVeqoYUJR/6OcpEyXfxVHNPVutUVUcCxhXAM8A7VewkrvFJzM2xKkxZl38yhLPeBlQY1mKx6hhtYNQRsOks8DInvUl8p1xIMPLLb7FWSOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705528467; c=relaxed/simple;
	bh=kT7ccFd7sEm2VtjZ3VZw85Ev9+3+h3z/ODRnE86wa9U=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:Received:
	 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
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
	b=GX1oBzqN8XWK+e5bHYq2ElWRzl1D+4rB/vIR6cNp9AsMq8hWLTUXNkEyTHsI7+eip9NRf6U4oZYOm6/h/N0tqjaVTLtW/ckVA8EnoTX8+Qv5AF/FKg7XFiKUfY1SaU+cMx+JEtyvauc846WtSBaq8ByU/D4I0oWs5FzXJR66ZSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3hJVyFl; arc=fail smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705528465; x=1737064465;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kT7ccFd7sEm2VtjZ3VZw85Ev9+3+h3z/ODRnE86wa9U=;
  b=l3hJVyFlCsrfD/MxRaYu8BSLU9q4ezES76J21gI1wHeyHVjROTAAMowW
   YEDWpndzRZqPQtRjaUCmliekG7jkX2AkKRWS4qjQ3RHq27hwO0pen9VqJ
   3d+7puU15VdfoRryIBdpCdPJB1e976TpjcWcXDPhOjfgzzcI9LcAFrKh6
   2+UWDkeY4guHBGNi+UqLhEdNUSLI85UTn6Xp7TsM59CAR5sJ7rAMcySPG
   elBZt+drQGe+buJwBhGL4Pg4qVtlgDBKvPSjYRUO1FZkb6ppvxTGbpv5c
   iWdhXxQhu7+x24fSvS9ZnW1e18ZaU2dBvf9byIjmw148F34iX53Uu2tAY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="464568261"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="464568261"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 13:54:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="854811098"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="854811098"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2024 13:54:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 13:54:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 13:54:22 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 13:54:22 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 13:54:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNIKZlfB1Y9eYWvswXk/FO+B0Ahs7TE9B97chzDlAZJXc3Lz534VCbbP9cf4YUeT7hA8jbCdjhT/TD/k9zoViVdVcVAYBGVYIXM+lI1RCpwfO7Tn8zzcJcDeALPnoe0PinGd3EDrzc8PusLIVF/XK/pSiB2T38eTGZXHAX5+jFdmSuK4Ru/lukidKmTIIDnxleMhKtw+YOyj9ZwKccL04OUDsSNguGJwG3G+k5ar3vTpnIsf7/WpYxAGyqdDSNFiyk1GOJ6h0myaMfh/WL9AuGqmqaqe3bn/OuBOyga8xBB9iKtR5p5JkXU+LPQ9xTlArh/PqROinxn6Fj566cdWVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZwTtSBirKMxrpPHFqkc11e2o4VKcyXByVv7qMgvNc0=;
 b=YblkY8qt91SGDDcKzRIdgMJRTWT2EIMEltpthYQ2txGfn9dKuEAUat90oiQHaxf0Yky1wiASyIkX3s65RUsseFsI+a6Vm5tQrFhV9tr/VihPe0gSM+QIPMyADVTrp3fa9JE/+w4cgDdKm8Im3qbowV/xDBh0M+vKkegrNYvO008gM7qzSggwyrH8DgSA0uT+y6vs44MCE4vLR3EPg/wypcsJD4eUI2rASWMe2bNaBV/fmvMkUfHkxofyKAJs3GLXHknlMi+Pciq1OexGcUIOLJ6L0ySgnWyBaV+9CfE5bWMkTGciVveySSZODOa045Jki3eOnK/wFz8JW8o5pp4KQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB6935.namprd11.prod.outlook.com (2603:10b6:303:228::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Wed, 17 Jan
 2024 21:54:19 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7181.029; Wed, 17 Jan 2024
 21:54:19 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Julia Lawall <Julia.Lawall@lip6.fr>, Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, "cocci@systeme.lip6.fr"
	<cocci@systeme.lip6.fr>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Harshit Mogalapalli
	<harshit.m.mogalapalli@gmail.com>
Subject: RE: [PATCH] coccinelle: semantic patch to check for potential
 struct_size calls
Thread-Topic: [PATCH] coccinelle: semantic patch to check for potential
 struct_size calls
Thread-Index: AQHZSumEyR9kSyf5CEKOOwPKwX3cMbDd/lkAgAKK4dA=
Date: Wed, 17 Jan 2024 21:54:19 +0000
Message-ID: <CO1PR11MB508917C85AAD2ADEFFDAA204D6722@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20230227202428.3657443-1-jacob.e.keller@intel.com>
 <6ee33330-134c-4bdd-a5eb-e8ff0db6cc8b@moroto.mountain>
In-Reply-To: <6ee33330-134c-4bdd-a5eb-e8ff0db6cc8b@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|MW4PR11MB6935:EE_
x-ms-office365-filtering-correlation-id: 12429f4e-8916-4f72-4336-08dc17a6db9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +DkfKR2uM4BI0LLENE0BEOwh6U7x5ia9zYVIhQEKur/zKv3j69HAWu58hJRMPONeL+FKEUT7svSJFENap74DcYoLpW4UK0ra8uqlNvvZoYgqP4dMtoNf3w2XnPylPkCC2rprEP8LxOvjc/HWCKYAf+UVwmbb3SoroRvBdtvl2DRo4bkh24nkZABsxB5ZWXCl4Rt+ew11i3rWxnaaOAkubDHdEqZcUWqjus/DJeyJnt3XKYXP1/WhM4iBNUR6rt7KEe5gXxU3oQHanB1QMTNkP5n/70qH0j/wu56LR0R6ni9JmpdMQMrVoxjWSz9gi5+dfGKwdKgjgzIuNtlJyQAmq1ubvG3zY6NX6jOgZxmXgHR0cN9AOydjIFwrWCBUmieUHAkn69xY3ZFY8yowVMvHWse72H3R+pdL8BRnfHjT3T9Cn8OElZ9hIwsqBV+EtNumov6QJRgVYGLqR3pB5Em02/zBUTjONNLWQEg/VZEkfxhCJUwsL8YD2ciAz1lBGlsI10eT99bhwo0SM/am4atQ0K1JWl88UzXMCd+CkZyhZ3OoLDX3jZzF3JsyQ2uGNs77f0OPVM3gQ6WSZVdU2fLTP9C/mynP5X8kLh5JvSjGNX9rLISn82Y/8Oz99SvIlRMg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(55016003)(38070700009)(76116006)(83380400001)(86362001)(33656002)(41300700001)(82960400001)(38100700002)(478600001)(9686003)(8676002)(64756008)(26005)(66946007)(6916009)(6506007)(54906003)(8936002)(316002)(66556008)(53546011)(71200400001)(5660300002)(122000001)(4326008)(2906002)(66446008)(66476007)(52536014)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XKsHjIwP8/BpzgHZm7cQoIPq8Jb3xZXNGXZ0C6N9jysYsZM2eLExn2s6hJAn?=
 =?us-ascii?Q?c07qMrcw2/uwd0DsVt+vfKf8frh7ZbqiR5aWPSfSUDTfeV7Sel6JWKHfNMaH?=
 =?us-ascii?Q?WN6Eaxw2d034nhs2p0xq2AVNgItktqdurhU3gjgmSHdarpQbP5w9Z/GxF7Hw?=
 =?us-ascii?Q?S/bMVVz5DZ9dnRYtV+PqTij/IAuxg1JTk5YfuhIC6jSakH5PDmiWkP+P0VKF?=
 =?us-ascii?Q?1nFNbuG23aQH4Dj4z7qsDt39n9RyMKv1SDDNcHmcmyNbqWUzh2fkuWh1ByIO?=
 =?us-ascii?Q?TYB1R14SwNlGSTgB28rvvgq4g9PHoxVB34ItjkElEtNtWSnygFMiM617wLni?=
 =?us-ascii?Q?HyggA54J68asWz6n9tLuZ6RimMkdX3j+Vufy+g5WVAfLSx+ZIjvdfAqiuFnP?=
 =?us-ascii?Q?fBLFNImT+JiKlD+3ZpydkSGeLdKFDFSDi1NexaJeA+ErbgII4wC/7SIEXyUv?=
 =?us-ascii?Q?hK8O+V5d/SUwz/7R77D4Zq1owuESxzZ+kOYqjSfP/j2rLj1+jkdNO6tYYqEj?=
 =?us-ascii?Q?9U4wqwgBjdgj4fcHQZnsE9zvGJHKQJwepm1vRqOGEAvR6WNaelnqRNmDCAvo?=
 =?us-ascii?Q?9X8IbEeFvBL+2JjhyzJHhz+2QHcgf1B/C9xktwj2qpIyJPWv5kXLgJxtsUPF?=
 =?us-ascii?Q?SvYYZxyBwnsULRlnRK8ipHl7Pd/EqBgFt01bNAtDL2Qyocc7kYvtIyUiz1JO?=
 =?us-ascii?Q?z6zW2UAntl76odM3CNwoVIcA7ZTNco4ph5TCHbKpkvfFHgYC4DzuIPEtxtHu?=
 =?us-ascii?Q?hDzLyFWtyhVsfGkLUeu+dfHmjfMu3YZMEZFaP6Ei9WUVnitk1dgf74ws2YXp?=
 =?us-ascii?Q?yRwm+vQN24pLsl6cU1X3Pgs48w1h0EHwAJRTmaLM6tmXjIlRXw44PRcu7TRP?=
 =?us-ascii?Q?r43Tl8fRxdj9tFPNjVr11ZYs2/PyjUw+hMhbDdGKpd+s+Ae+q/xJcsVw2mhF?=
 =?us-ascii?Q?L2bMhZfAxSKpfPcDQSxN8f9Cc6g4ANIkduONG/Xgo849ifmpvh2cAFhxmTai?=
 =?us-ascii?Q?7l6wEYu6VffHzGhfZT2MBKPG24dJihyEhpHXl+9xq+ntw+0FBHHFcKZPNOQc?=
 =?us-ascii?Q?XkwpD8um9oi5XpZ0yKyMu1JZGm9qa2o5e2rnwJVB/fQxgsJ7w8BlEPKIrqJw?=
 =?us-ascii?Q?2OeX10VMCoRC9ECzE7hGNGuDJcP9OcEb1nCc28uxw0eTLjMaZcNhVrUr9sTW?=
 =?us-ascii?Q?7Y6qRKESpsy3T2Im3VMH5QE4Ra5US19yehLD2H+YMoPjA0+456GfFeoLAu/F?=
 =?us-ascii?Q?hZdzhtCnMX4FWXye4Y0qHygUQyvIDGLK2XzPbQS3eYyJ9hZ+Zr+jWOo1Q1J9?=
 =?us-ascii?Q?m7vKHO/RVuNalmRnVocX9YssXcJzMIbl05UCEiDOf5ZPymyCr0I51Lp41OEL?=
 =?us-ascii?Q?8dlqx2EoM8JZLk/ztYqmdBqelgMHNNg+XyBJgLEman660FkRshRM90ep2E5j?=
 =?us-ascii?Q?0Njkxf4BrS1V7p6H9acv/HArdxx6mARk6qahYZ1G7iMJLwuSqHTSVVEH0O0L?=
 =?us-ascii?Q?DOH1Kk65qpcvvQf7OAEsUL8nr6FpQx2npPaxy8WUX3jnWFC66FwAOQjDcVYk?=
 =?us-ascii?Q?AsgbQ7PkG9I6p5xjPA0wimS4QHbxsyGy6bZlhUNO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12429f4e-8916-4f72-4336-08dc17a6db9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 21:54:19.5777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LHPUmDLDZ8dXthhcPauhfH/tY3dvZR2eUf/Ymt5VxjpuDfkp2lz72QumRqts4V6dgdw6vIqeuTi82I8A8IqbXbjeJL1OarxlLdGmFqPbvZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6935
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: Monday, January 15, 2024 11:03 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: Julia Lawall <Julia.Lawall@lip6.fr>; Kees Cook <keescook@chromium.org=
>;
> Gustavo A . R . Silva <gustavoars@kernel.org>; cocci@systeme.lip6.fr; lin=
ux-
> kernel@vger.kernel.org; Harshit Mogalapalli <harshit.m.mogalapalli@gmail.=
com>
> Subject: Re: [PATCH] coccinelle: semantic patch to check for potential st=
ruct_size
> calls
>=20
> What happened to this patch?  These sorts of patches go through Kees?
>=20

No one replied and I got side tracked by other projects.

> Also it would be nice if it could handle char arrays.  It doesn't warn
> for the kmalloc in dg_dispatch_as_host():
>=20
Yea it would be nice to handle this too.

> drivers/misc/vmw_vmci/vmci_datagram.c
>    227                          dg_info =3D kmalloc(sizeof(*dg_info) +
>    228                                      (size_t) dg->payload_size, GF=
P_ATOMIC);
>=20
> The Cocci check is looking specifically for:
>=20
> 	sizeof(*dg_info) + (sizeof(*dg_info->msg_payload) * dg->payload_size)
>=20

I think that's a slightly different formulation.

> But since this flex array is u8 there is no multiply.  I don't know how
> are it is to add support for char arrays...
>=20

A separate rule would work.

> Also another common way to write the multiply is:
>=20
> 	sizeof(*dg_info) + (sizeof(dg_info->msg_payload[0]) * dg->payload_size)
>=20
> That should be pretty straight forward to add.
>=20
> regards,
> dan carpenter
>=20

Mostly I just lost track of this because I struggled to get traction in the=
 right lists and trees.

Thanks,
Jake


