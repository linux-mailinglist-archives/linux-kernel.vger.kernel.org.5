Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64A87D8FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345431AbjJ0Hg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjJ0Hgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:36:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774C0116
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698392209; x=1729928209;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eSpoqaCREloeP7DhJwzAP5ucCygy0336Y8I9PfWg2/A=;
  b=nT/k5GMBk1+RsAI3vBOeGjlvc9qyZjuO1Oi1xFHlqk5g3AByX1tgBKS7
   xS5U4S22PK3W/FGoiKooXfmTOql6PgXumB+Xtc3G/FGyUp4PawLUNbiWJ
   a/7p3yQkxbEsFIN2szA6vOo6gwrIUkK9s2aij8Tz5hGIQrowL0Emo4w+B
   KIFtNWwyBWoZbWR4JmeJJoZHR5bM24LdIhMiHNqVRWtDeCF8SlSOzeinj
   YgHx3X/vhF/1R80eMUyOiON3V4wPV/u8UD/DRbfMgz4KtMVb0rBSAY5AW
   r+ClvDL0AlLdoTZCA0mB3nWyBrK2CbhT/ruT2jlkhQcamxAUosF0b7y2c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="372776600"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="372776600"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 00:36:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="763119567"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="763119567"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 00:36:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 00:36:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 00:36:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 00:36:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVj7rBZ75NRHuey+nsF8POm8CaUxzI5VMv/0lXqtvKvjkvWQyR+TLMB3cHMqv3CQrO/0a59qJem2SjXoKOgrcWCAD9IBsJ7KGUBpacIe1kxbYasmQBrHtpJhjyBiKqAlVIikdjX9HH24P1hrdlskHylJeuuBmCXtZHLwbJdI6OoKNnotw6/SAb4+/ic6BKUnnKi4/fj2RGjdiFOAroeRsUr8LavcXxwU7euGTR0lMOutO0bGgo9xLpXr/5kRlBGX9LEDEjaTkIfzQ5qLQYqakgulS+n4QKhfA+dfxfXLfygZufyEprZAZ1SCf07pxTl7IpuafPaKFzSSfJJzcwJO/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80yn8scpMCGqQLk7PtXN5jRjhrZbkkIUNoogrlmztVc=;
 b=Hh/eALTa+KXZwGA3rkotrey5llwHX7MBLtPSFGlvFIbGt1dGQ4ekDdxqW9qi9frjlwuyOQFj5u9nuniscpzEFH5DSQg6wg12h6XxuCbzpvDByxmE0elZ2NTM5YU2SJmPHD6Rz2NHmxiqtCTUCtXAZNmd271mJ1O+Iiv+nYyDuIhzaBhxopARag6Fu4rMyM/a0gEyoxQINERI7HlBYoYoZDOvnX2cutia8wCw/tyexmyX4/4UnRq961yhI4AsYKsr3MrZIE1WMNm5Ul7JQ8eSPKZ9Z1XMvRl4W8vIYc6ES2yI4Bi8G0b31qoXUpSjwmG8NuzMN2AynA3GR4H6edeRZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by BY1PR11MB7983.namprd11.prod.outlook.com (2603:10b6:a03:52b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 27 Oct
 2023 07:36:46 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::9d29:3f63:cecc:9102]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::9d29:3f63:cecc:9102%4]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 07:36:46 +0000
From:   "Zhang, Tina" <tina.zhang@intel.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v10 1/6] iommu: Change kconfig around IOMMU_SVA
Thread-Topic: [PATCH v10 1/6] iommu: Change kconfig around IOMMU_SVA
Thread-Index: AQHaCGlk1cvAoUzubk6PoTMGEq8RvbBdOPMAgAACSlA=
Date:   Fri, 27 Oct 2023 07:36:45 +0000
Message-ID: <MW5PR11MB5881E07803D25E3588FFABB789DCA@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20231027000525.1278806-1-tina.zhang@intel.com>
 <20231027000525.1278806-2-tina.zhang@intel.com> <ZTtixEgSkBI-TRro@8bytes.org>
In-Reply-To: <ZTtixEgSkBI-TRro@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|BY1PR11MB7983:EE_
x-ms-office365-filtering-correlation-id: 7afc03b6-4608-46e1-3004-08dbd6bf7903
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2vJcVCD5jdLimTkog2xUR7usAuRIXc25STbPAA52IA5W+XfI1+i/QxGK+jqCL7Lnfv16TzgRM5d5nJs4n9SLb8wDFnXRUnaisZG15B8iubmtRJ3re544Hy6yf7etJTXZDOzmX83Yo+RSdkedKLhYBTaO3S5jahX3kaGJu0OnzqI0xdkYPBP6ziHZcrQY3IvhuMuXDoVYakC9czGpYTBONYjW1VlYBKaNRYRn16S7+Q93RS066oy6NqjHPY3peoyBdHlQz3UBrCO/VyPAlEBbvxn0uZY1VACqAq80zMMkHGySNgj/gJm9l5aQ1P6zfSXQGlkcEiouaDextlK9KKfpZviFkllhopWmPOjkQCPCaCl0xTfkqipHyr24nvGOyCw6gyXm79spwZcgNeM8pXd3u07nIGddQ2BaZIws1IFa74qtk4iXD3ZqqtBnwdFhswWybWD4Xc7AOEmhz3Ub2/4Y8hyL6z66REMguY/GoPy3RQxvVqJKYm+3K7eL3HZQnN543+SrRUT4MBks9ShZd+UGO2CXw8u5O6lRb1ek9jBZ0z8LUQCqbd9OoYqo29NiGM/fJ2sgO6LV4bgly75XHDC224FIu6ahGFb25gA3ufQVl9M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6916009)(6506007)(7696005)(55016003)(71200400001)(86362001)(83380400001)(478600001)(66899024)(2906002)(33656002)(7416002)(82960400001)(122000001)(9686003)(64756008)(53546011)(26005)(76116006)(966005)(5660300002)(8676002)(8936002)(316002)(66446008)(54906003)(52536014)(41300700001)(4326008)(38100700002)(38070700009)(66946007)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X5FQ4fYNuMTvL5fzdDwn3achn224EGFJxH+HVRUibPVZtlq98AKkPOrRTB12?=
 =?us-ascii?Q?9CKQOipFHxSQ3Vox+XLW7j8YSTk/cGOst2rM7rS5n0zxUa72JPSQe5M8MPOC?=
 =?us-ascii?Q?Tb3uThwfffrps9dP4PMZGIxlZkEGcQ4jrTocQmzypNFzTPDKSihc3+3pFRWk?=
 =?us-ascii?Q?1bWhvL+k4swPf0Z/9RFtzyq3YKHk6TSb65qrC1IOXpZMDeV0M+VDfsHwJTiF?=
 =?us-ascii?Q?SsSbF60jdhIY/AK8vHBdmfis5/b5PmNmCS+z2eZIW96AZZUOVy8SchXN0zw0?=
 =?us-ascii?Q?i9/2nM7VGzyxb0ZhPJvUGddq11TT89WVBcIuFgscE1nAeqQidUz0PkE7B9kx?=
 =?us-ascii?Q?cSDFWSXakKKIwtaS+tNK06AGjOosvSPMrtRxE1OAYGhxdr8xXXPPyjb4ccw9?=
 =?us-ascii?Q?5o3SvsVC1o3KQKhDRk1m6R25ugxypRifPetBxPk+j+yIsYeoE/Vsj47dwKTk?=
 =?us-ascii?Q?YvrwJoiuSKoaNcvkOUVUOzVriO5Zm0XbZebNVdkZUVBIHkHXmCTjCGlg7RMD?=
 =?us-ascii?Q?Gm6SLE82BgiAHRYlQDo412pTCmVyPYhOmBiovgbZaSzNpEtGYjSTIVShfIjt?=
 =?us-ascii?Q?EyGz9GLX+mPG9IK7YCdm6Rqo+LlryCqnNN9xBFrMEkKsgE4jvjdxCDXMRAGd?=
 =?us-ascii?Q?3/DVbxmKiRgrZAHN4APurgF+QOrDegu9py8JdAFq0e4XFB6LKl4Oepnr8mU6?=
 =?us-ascii?Q?6pxB0/S+bR+k+HleaOwqNQ+rewc/8svz3ttQ8ioXavAOmo86bPhLRJVdKN+a?=
 =?us-ascii?Q?lZ/PUICDF0Apjwevs/98vgXVq9jbrajN3HtKszicglTtzJT8DU045pGctdVs?=
 =?us-ascii?Q?v03Oj+IgU0rT0eJ7hoD1nd9A4ada9KoKr8kv3WF0fnWkt0SUk5FmJXRrXZuM?=
 =?us-ascii?Q?QwZwNLcL4BGyxe2xhYxK6NQd41iHePEn5DU6HXqCCgOoBEH7kpVrGgEPWsgY?=
 =?us-ascii?Q?GHRivpiJ9sCRblybXf2/zc+g1CjiGxh9XC6Ml55aS1m4AGBxDVaiwYPanVC0?=
 =?us-ascii?Q?p3H4odBBKdyaeKCKT0BPEIGxN5svGxOGi1waKZJCBqNylPK3Oh27etl28bu/?=
 =?us-ascii?Q?zjxn1nUhXHJ2S1z5XiSo47+MypzYz2Z2FzfiO/W8lSp+nWzUX6XcmuvpDuI+?=
 =?us-ascii?Q?z3Z6wmhI06Oq3ixhtskhbRfajyGhdV/nxuw+CqXZozey7y+tL+EK0peePJg0?=
 =?us-ascii?Q?ZMKyce3s5bVBmIFMAkYAMtKPv0VTXbRcN9rnvmD3RFh403/yUN0VpwjqGz8n?=
 =?us-ascii?Q?KMEq69zzdFpjPhHKV+9gkmXPZqy4DjkTg1Q3okWGlcjvRuROjONtrUcPUuYO?=
 =?us-ascii?Q?qfannXV195G4sTe4NmzDeirtH+9ttxeqSm8lVvvNyYBDfUB8dedz6iU/Z+0i?=
 =?us-ascii?Q?I7wLTXgU8HBq+asiG2JvHNqwdr9d3J+PEY2HcoXD2S7vKfs+wLCfoY6+1roc?=
 =?us-ascii?Q?LE3B6A294+c9T4xQBCVx0rZJ+qJcHiIgeCSNe71vNhTehIUzqSJymQNO1rWF?=
 =?us-ascii?Q?K9zJDSubVLoT8OBPrecR7UwuKXoWsv6UBCdruRki5dQCpYtFOrWTf/RQ08pS?=
 =?us-ascii?Q?zLcctLx4zjzdBehkui/gIPHeLXyJMMZ8UtXuzJYX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7afc03b6-4608-46e1-3004-08dbd6bf7903
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 07:36:46.0009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8O6zSYbBtXPGMH0YsShdX80jUPcu26iRX/9DbH+h11AFZis53x/wzWI6Iq7/PW07VL3LQIKJUv1VXsRl5LcuWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7983
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

> -----Original Message-----
> From: Joerg Roedel <joro@8bytes.org>
> Sent: Friday, October 27, 2023 3:12 PM
> To: Zhang, Tina <tina.zhang@intel.com>
> Cc: iommu@lists.linux.dev; linux-kernel@vger.kernel.org; David Woodhouse
> <dwmw2@infradead.org>; Lu Baolu <baolu.lu@linux.intel.com>; Will Deacon
> <will@kernel.org>; Robin Murphy <robin.murphy@arm.com>; Jason
> Gunthorpe <jgg@ziepe.ca>; Tian, Kevin <kevin.tian@intel.com>; Nicolin Che=
n
> <nicolinc@nvidia.com>; Michael Shavit <mshavit@google.com>; Vasant
> Hegde <vasant.hegde@amd.com>; Jason Gunthorpe <jgg@nvidia.com>
> Subject: Re: [PATCH v10 1/6] iommu: Change kconfig around IOMMU_SVA
>=20
> Hi Tina,
>=20
> On Fri, Oct 27, 2023 at 08:05:20AM +0800, Tina Zhang wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> >
> > Linus suggested that the kconfig here is confusing:
>=20
> While this patch looks decent to me, you forgot to Cc Linus on it. In gen=
eral,
> given that it touches a couple of core files, I'd like to wait for some m=
ore
> people to have a look at it and not rushing anything in.
Make sense. I'll CC Linus. Comments are welcome.

> >
> > https://lore.kernel.org/all/CAHk-
> =3DwgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhU
> > gvUqjr9Xw@mail.gmail.com/
> >
> > Let's break it into three kconfigs controlling distinct things:
> >
> >  - CONFIG_IOMMU_MM_DATA controls if the mm_struct has the additional
> >    fields for the IOMMU. Currently only PASID, but later patches store
> >    a struct iommu_mm_data *
> >
> >  - CONFIG_ARCH_HAS_CPU_PASID controls if the arch needs the scheduling
> bit
> >    for keeping track of the ENQCMD instruction. x86 will select this if
> >    IOMMU_SVA is enabled
> >
> >  - IOMMU_SVA controls if the IOMMU core compiles in the SVA support
> code
> >    for iommu driver use and the IOMMU exported API
> >
> > This way ARM will not enable CONFIG_ARCH_HAS_CPU_PASID
> >
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>=20
> If you send it, you also need to add your Signed-off-by.
OK. I'll add my Signed-off-by.

Thanks,
-Tina

>=20
> Regards,
>=20
> 	Joerg

