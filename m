Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEB67D8C7B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 02:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjJ0AK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 20:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0AK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 20:10:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111281B2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 17:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698365424; x=1729901424;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SFC7Nj6FAzn00iCYXjoq6LJi+/in70/IUBtG4eKIu88=;
  b=Qoqw3I1rJPtZaqvnYAU3fPn8G1NgegkvdShcEDYB2sBcAeNicyKqk38H
   w9HraQ4AbKYaUeAAh5is6pEyiJUTeKIqDnMbwZLH2hPLnEoLSp8oa+4R+
   FTnB3tSanxSolCqhKYWiK0eJ13UKm7EwangUQXh+u1QXB4PvsqVepLQrE
   JHvt5JIiNQ9sp9EWlWxYv+llTLxKohjjeju59e+vzKD7E7Y8VrN7E9vCT
   LkT69BJNU/4fFxdE4bjAwZu8V/zWKD3pqs67xzNPcr++nh9UYePfDH8Ep
   UASaFdfXPfwGNtjBnHDcIXlfmL2mPJzeNHr8ArBUVRRDvoIyYbUzuUvRZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="451920374"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="451920374"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 17:10:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="876147220"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="876147220"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 17:10:23 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 17:10:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 17:10:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 17:10:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzwV47lA2/lDPzLDVGmdvksO05hk5Px3u6fP07ViE/MEyMhXDYwUHfIxnRvJHPhJWf0txeKeNtWlCx0Cutn55B5A0yXGFwxitPUJtCYxzrRDiauR9HddfH0g509Z5/nC0s2KapUXs/9StEapUScJUoN+qzn4qryOPCmJoMKBxXt0+LsKp3L0LuwXaqO8TpQ1mjGeGmV+KL7PSTNsSWcMlvxbHWDZvEsn8NYad2rez6ZzlzfDbnCmz84W+jzcnsiC/5TNwB5AQG7ehybaQtJ3R0q723DPpZt0Mnw/Q0DVlsOt+gmlL2jr6prOWCV/d+aEZEsve76E8X4Us17im0D96A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9i0LSUOpwSBXHex1lPVhIckn1gPQQyYLAGhFBrDMTNA=;
 b=RpZ4ZvT4wOjInc6BYoRTT9ILGHYrW3SgL2Y9mQe8FPNWaFOz8uWYLCb46U/WxU1DtUD9ELg+x3/OTCR1trBhrxXSOK0Fssw1r7nxwyTWnLzzK6NXCMTC3xNtifuiZoOZ6Xr8bEm6z89BVT2dKsj6Uz/Etxw9T6H0xZFRg5OeXkGUM3uVb3k1YJJwAsl5lpK/bP8/82GGwOjp2ONcoK8dlTakyrxFYaXSqrO7g85MiJmWTVq7z8JgHmIP9m/3bFpZDJGG2D86VTpnsp8ZbXKM5HMqk8Y6gTPcwU3k/r6RuEyZx97fJ+la8tSz1W0GWmCQShMrztisQTN9B9zV3lMPVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by SJ0PR11MB4927.namprd11.prod.outlook.com (2603:10b6:a03:2d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 00:10:20 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::9d29:3f63:cecc:9102]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::9d29:3f63:cecc:9102%4]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 00:10:20 +0000
From:   "Zhang, Tina" <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>
Subject: RE: [PATCH v9 0/5] Share sva domains with all devices bound to a mm
Thread-Topic: [PATCH v9 0/5] Share sva domains with all devices bound to a mm
Thread-Index: AQHaAYDvo1dMRebqg0WIkJITnmWIJbBbt/QAgABSlwCAABlYAIAArDCg
Date:   Fri, 27 Oct 2023 00:10:20 +0000
Message-ID: <MW5PR11MB58811AD51C945F94F7BCD0AE89DCA@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20231018050640.24936-1-tina.zhang@intel.com>
 <ZToUOKSqqI6Bh_03@8bytes.org> <20231026122016.GU691768@ziepe.ca>
 <20231026135058.GW691768@ziepe.ca>
In-Reply-To: <20231026135058.GW691768@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|SJ0PR11MB4927:EE_
x-ms-office365-filtering-correlation-id: f5687aaa-2535-4fb6-8565-08dbd6811b9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YwezxFdnlAM1mpGrf9v5e4BY6JzPrflfWKFO6/XF9YfNaarAbFHKdYtIxqPToR86BTy+MW8BU1+DYCrZQMPujbEIwT9e4nm8lRjSoWNFURE+6ykP/MvBUps+aEXu4Q8WqGHrcxXg4z/TfPtE4WtOvMyq28ZWs4Zy9uovsLKjq5LeP6LKeHT+OcDY2KWnEpDGccOSSQp1v6u07dppFLdl2nQekb2OoG7Da4jLWuU675OOp8laafJ228tTmdytR8sR8iaij8/wjpu5ASgVkN4FYg+p3t9MF4DQu90YDDw5IQAqZN4NqQpmyrN0xGeoKzktQlRBK38Y2BsTbECuRn6Kd+XjKT+63jLPWVnbOw1+AiU7x0LZpmfn5K/nsvRiCvu0NM+cLvx0BzTeR9+Ww0ce3f6vZVA8MpEZO+a2ZLMvV9r0zj5BqyGcyQhJ7FUu6tEnvQtMT90zKhnuaUpThxpYHPJMH6NdpzQEHX9qMBH9ZyY/A87KwfUSKkNCyt48f/pU3449wkSIG8iPQ3IQJq6xRxgfUHQR3SW+J6kU5jLhjGj1tWkyS5EWqwdFK7VBwtgdmSPL2E8112QqE02EvQfI7K2C/llKrJznBNsNYllaHgpOCiPro54iBi06dA7CjBxXypbS1ue+nMdFXIlA+4yYLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(52536014)(55016003)(71200400001)(7696005)(478600001)(6506007)(53546011)(64756008)(122000001)(66476007)(9686003)(76116006)(54906003)(110136005)(86362001)(33656002)(966005)(66446008)(66946007)(82960400001)(26005)(38100700002)(8936002)(8676002)(83380400001)(41300700001)(66556008)(4326008)(38070700009)(7416002)(5660300002)(316002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7yhIi5oUkfy1f8sgpiHJsdaqFErOuypm2z+En9It2Aky/qfVIAeZQma/LUIM?=
 =?us-ascii?Q?22IYfXb+upFFTTj60IgbDkjfMPl/ISW4pgIt4sKTTcjtc+d+CHWenZh96Ugl?=
 =?us-ascii?Q?mYY9ozU5eSmLaCoDb+hjOCufPfpBXVf4MUzyUjY/aUKL27LCkpIQ4VnZyfaA?=
 =?us-ascii?Q?nVory5hEVPTcDBbt5UT8B3fiKWYbs5vd4RO6hyv2hCa4k/o/c9nsk8Deq9PZ?=
 =?us-ascii?Q?GrIh5XDjlskxtetU5Zspgj22++Qgriz10aP2Q0ay9KfWjPNRVQlQfe3vGWc/?=
 =?us-ascii?Q?JkJHfs8mcgppipwRQSG9sqv7zHWZkorgajYWfGpYaKpz7Qdrzwkox2zgRJPH?=
 =?us-ascii?Q?HufTs/lJHaKVg9MYp6gyaArL8eBUJVjOHUzLEUZhXGGZ2uFXKf1oMWxNtgfR?=
 =?us-ascii?Q?V+fqZV5V7lVfz3TB0C5B9oFzD5o1D4LA6/VbOIBRFXjAS7hjvnGxgbt78wE3?=
 =?us-ascii?Q?N8pfzIWSc8PlnJfnj53SkVSej4D3FIxt28Qqfu8OQZju7NU+PQ3d9tRw0Ztq?=
 =?us-ascii?Q?LvmAs4lHG8taPKxfYt8Vmc3g0SWDzyg1dHccRCzUhq0ibIVAMnWFmixQ1y5o?=
 =?us-ascii?Q?0v/R3zTDHxDLKxiEKR+xNhW/rErwaUaue9/Z35zv7UBScXoB6os66xIbkGZl?=
 =?us-ascii?Q?AZFQ9LIpbtQGExtczyV7QPaT+aeMtnbvu/kPPIhPnxB3hvbnCg6pSwx1WHKn?=
 =?us-ascii?Q?+FqXb/FCLy6PhaARtso8ZB0N0DjM5VofOznUK6OC/xtEad0DBQdEhtaPgDMj?=
 =?us-ascii?Q?JD08IGHy4LMwvsHIJY1n7HEj1K6niRh5DoUOyHZbwHMv7FJm0bFoYeqF1pUJ?=
 =?us-ascii?Q?QuU1Q2O6fHn4OpaOMW/jAS4Bw9xU/eHaKyKcizYD2Yh6WRZNpP7Rsk2h0F2E?=
 =?us-ascii?Q?EgwhyvIo24W7hkxL+bmaWQtXL96LRBm4Ks6vyrFOCuJ+AZUwUbJIUf/XVX70?=
 =?us-ascii?Q?RCbnqlI0svA405J2utqH3SCHu9FuQNLjswnNMueZy5BBA8Z/6AcDyhjAZbbM?=
 =?us-ascii?Q?eCexxSh51PIv7GrR07IvefC4rjLRr4EMaMTBGHJBl6++QGgCFYYJYqNNSf/x?=
 =?us-ascii?Q?kMd3VS/kuw9jdNtCBmJTB0oli5D/DYJHAI3nH3upZ73p2ZfScSLRKQR64gmZ?=
 =?us-ascii?Q?sv6Zxw/lEIpVKf7KCQAo/D+zz+HjK2JwFLt1mm/Zzsf0tfFsYZ9vXhouQffk?=
 =?us-ascii?Q?NQvOUoVZ5BaNJmzQJluG+TEkS7sJpNvyEjpJeQWsS2jrRlITKf3pn9/CJG1e?=
 =?us-ascii?Q?l2H9bsGixKuk05S1OTa3udQgs176IeiBzDPLkAj7cSpEHRxtG69BOk+kVjgV?=
 =?us-ascii?Q?/fQj7xY6QOcm+d5jAWQAxhearjBbCTpuAMYev5LrvAGfVG6u4cutSpHFvmC6?=
 =?us-ascii?Q?8fmo4yy+fHFxK3l6ym1ZPLtzmOmFzWPBI9mrI0JGHnsw+W2urxVgALcFWiJP?=
 =?us-ascii?Q?7h4592na4k1gy8gYtBEe0CJGlqR+VtITYrgZI38UUC66y+Xygz3lR0BJNg/F?=
 =?us-ascii?Q?H76kp37mW1Uxeh6ttmzj3kiYLsKAJWJtAqeGtaESlkhEK+kW9jDRIqA576Jc?=
 =?us-ascii?Q?8LEQygiR5kLvaINxTDGpkVdWTns/LRJHn6mtxswn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5687aaa-2535-4fb6-8565-08dbd6811b9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 00:10:20.5157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hPgE9HlGAG9uqx1TBG0w5u6Ytra5yZeU1dCX1NVV/FlX3QurmldzD2sg7S9NwDZLZ523djpfUii0QPycUwmNwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4927
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason and Joerg,

Thanks for this commit. Version 10 of this patch-set has been submitted and=
 this patch is added.

Regards,
-Tina

> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Thursday, October 26, 2023 9:51 PM
> To: Joerg Roedel <joro@8bytes.org>
> Cc: Zhang, Tina <tina.zhang@intel.com>; iommu@lists.linux.dev; linux-
> kernel@vger.kernel.org; David Woodhouse <dwmw2@infradead.org>; Lu Baolu
> <baolu.lu@linux.intel.com>; Will Deacon <will@kernel.org>; Robin Murphy
> <robin.murphy@arm.com>; Tian, Kevin <kevin.tian@intel.com>; Nicolin Chen
> <nicolinc@nvidia.com>; Michael Shavit <mshavit@google.com>; Vasant Hegde
> <vasant.hegde@amd.com>
> Subject: Re: [PATCH v9 0/5] Share sva domains with all devices bound to a=
 mm
>=20
> On Thu, Oct 26, 2023 at 09:20:16AM -0300, Jason Gunthorpe wrote:
> > On Thu, Oct 26, 2023 at 09:24:40AM +0200, Joerg Roedel wrote:
> > > Hi Tina,
> > >
> > > On Wed, Oct 18, 2023 at 01:06:35PM +0800, Tina Zhang wrote:
> > > > Tina Zhang (5):
> > > >   iommu/vt-d: Remove mm->pasid in intel_sva_bind_mm()
> > > >   iommu: Add mm_get_enqcmd_pasid() helper function
> > > >   mm: Add structure to keep sva information
> > > >   iommu: Support mm PASID 1:n with sva domains
> > > >   mm: Deprecate pasid field
> > >
> > > Thanks for doing this, it all looks reasonable to me. But there is
> > > one thing missing which needs to be done before we can move forward
> > > with this.
> > >
> > > There was a discussion about the Kconfig symbol naming used in
> > > mm_struct. Please see the discussion here:
> > >
> > >
> > > https://lore.kernel.org/all/CAHk-=3DwgUiAtiszwseM1p2fCJ+sC4XWQ+YN4Tan=
F
> > > hUgvUqjr9Xw@mail.gmail.com/
> > >
> > > Please update this patch-set to solve this and I will take the series=
.
> >
> > Lets call it CONFIG_IOMMU_MM_DATA then. It is still pretty nonsensical
> > but it speaks to what it does after this series
>=20
> This is what I came up with:
>=20
> From ca97b6cb94eadc4066d762aa4c54e7ba9789f3f4 Mon Sep 17 00:00:00
> 2001
> From: Jason Gunthorpe <jgg@nvidia.com>
> Date: Thu, 26 Oct 2023 10:43:12 -0300
> Subject: [PATCH] iommu: Change kconfig around IOMMU_SVA
>=20
> Linus suggested that the kconfig here is confusing:
>=20
> https://lore.kernel.org/all/CAHk-
> =3DwgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com/
>=20
> Let's break it into three kconfigs controlling distinct things:
>=20
>  - CONFIG_IOMMU_MM_DATA controls if the mm_struct has the additional
>    fields for the IOMMU. Currently only PASID, but later patches store
>    a struct iommu_mm_data *
>=20
>  - CONFIG_ARCH_HAS_CPU_PASID controls if the arch needs the scheduling bi=
t
>    for keeping track of the ENQCMD instruction. x86 will select this if
>    IOMMU_SVA is enabled
>=20
>  - IOMMU_SVA controls if the IOMMU core compiles in the SVA support code
>    for iommu driver use and the IOMMU exported API
>=20
> This way ARM will not enable CONFIG_ARCH_HAS_CPU_PASID
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  arch/Kconfig             | 5 +++++
>  arch/x86/Kconfig         | 1 +
>  arch/x86/kernel/traps.c  | 2 +-
>  drivers/iommu/Kconfig    | 1 +
>  include/linux/iommu.h    | 2 +-
>  include/linux/mm_types.h | 2 +-
>  include/linux/sched.h    | 2 +-
>  kernel/fork.c            | 2 +-
>  mm/Kconfig               | 3 +++
>  mm/init-mm.c             | 2 +-
>  10 files changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/Kconfig b/arch/Kconfig index
> 12d51495caec18..35b9fd559bb697 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -301,6 +301,11 @@ config ARCH_HAS_DMA_CLEAR_UNCACHED  config
> ARCH_HAS_CPU_FINALIZE_INIT
>  	bool
>=20
> +# The architecture has a per-task state that includes the mm's PASID
> +config ARCH_HAS_CPU_PASID
> +	bool
> +	select IOMMU_MM_DATA
> +
>  # Select if arch init_task must go in the __init_task_data section  conf=
ig
> ARCH_TASK_STRUCT_ON_STACK
>  	bool
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig index
> 66bfabae881491..afd9c2dc228bdf 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -72,6 +72,7 @@ config X86
>  	select ARCH_HAS_CACHE_LINE_SIZE
>  	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
>  	select ARCH_HAS_CPU_FINALIZE_INIT
> +	select ARCH_HAS_CPU_PASID		if IOMMU_SVA
>  	select ARCH_HAS_CURRENT_STACK_POINTER
>  	select ARCH_HAS_DEBUG_VIRTUAL
>  	select ARCH_HAS_DEBUG_VM_PGTABLE	if !X86_PAE
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c index
> c876f1d36a81a7..2b62dbb3396add 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -565,7 +565,7 @@ static bool fixup_iopl_exception(struct pt_regs *regs=
)
>   */
>  static bool try_fixup_enqcmd_gp(void)
>  {
> -#ifdef CONFIG_IOMMU_SVA
> +#ifdef CONFIG_ARCH_HAS_CPU_PASID
>  	u32 pasid;
>=20
>  	/*
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig index
> 5cc869db1b79fc..0f9c3f6ae8d32d 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -160,6 +160,7 @@ config IOMMU_DMA
>=20
>  # Shared Virtual Addressing
>  config IOMMU_SVA
> +	select IOMMU_MM_DATA
>  	bool
>=20
>  config FSL_PAMU
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h index
> 8fb1b41b4d1580..0d2e01404c3e50 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1324,7 +1324,7 @@ static inline bool
> tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream
>  	return false;
>  }
>=20
> -#ifdef CONFIG_IOMMU_SVA
> +#ifdef CONFIG_IOMMU_MM_DATA
>  static inline void mm_pasid_init(struct mm_struct *mm)  {
>  	mm->pasid =3D IOMMU_PASID_INVALID;
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h index
> 36c5b43999e608..330f3cd8d5ad97 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -881,7 +881,7 @@ struct mm_struct {
>  #endif
>  		struct work_struct async_put_work;
>=20
> -#ifdef CONFIG_IOMMU_SVA
> +#ifdef CONFIG_IOMMU_MM_DATA
>  		u32 pasid;
>  #endif
>  #ifdef CONFIG_KSM
> diff --git a/include/linux/sched.h b/include/linux/sched.h index
> 77f01ac385f7a5..3ac8e8556c3d93 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -949,7 +949,7 @@ struct task_struct {
>  	/* Recursion prevention for eventfd_signal() */
>  	unsigned			in_eventfd:1;
>  #endif
> -#ifdef CONFIG_IOMMU_SVA
> +#ifdef CONFIG_ARCH_HAS_CPU_PASID
>  	unsigned			pasid_activated:1;
>  #endif
>  #ifdef	CONFIG_CPU_SUP_INTEL
> diff --git a/kernel/fork.c b/kernel/fork.c index
> 3b6d20dfb9a85e..d28f0d4582dcc1 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1179,7 +1179,7 @@ static struct task_struct *dup_task_struct(struct
> task_struct *orig, int node)
>  	tsk->use_memdelay =3D 0;
>  #endif
>=20
> -#ifdef CONFIG_IOMMU_SVA
> +#ifdef CONFIG_ARCH_HAS_CPU_PASID
>  	tsk->pasid_activated =3D 0;
>  #endif
>=20
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 264a2df5ecf5b9..fee4a15e444b74 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1258,6 +1258,9 @@ config LOCK_MM_AND_FIND_VMA
>  	bool
>  	depends on !STACK_GROWSUP
>=20
> +config IOMMU_MM_DATA
> +	bool
> +
>  source "mm/damon/Kconfig"
>=20
>  endmenu
> diff --git a/mm/init-mm.c b/mm/init-mm.c index
> cfd367822cdd2e..c52dc2740a3de2 100644
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c
> @@ -44,7 +44,7 @@ struct mm_struct init_mm =3D {  #endif
>  	.user_ns	=3D &init_user_ns,
>  	.cpu_bitmap	=3D CPU_BITS_NONE,
> -#ifdef CONFIG_IOMMU_SVA
> +#ifdef CONFIG_IOMMU_MM_DATA
>  	.pasid		=3D IOMMU_PASID_INVALID,
>  #endif
>  	INIT_MM_CONTEXT(init_mm)
> --
> 2.42.0

