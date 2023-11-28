Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DE47FAEFA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbjK1AXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbjK1AXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:23:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7F319D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701130994; x=1732666994;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+X4WjDAEz6OCap57ANdRi4WrWaY6Bh0Zrt+VaFT0CZQ=;
  b=PKcI9fYCk7qHfsmacAbAhfs+psOJiQR69Zf8Vezmd1rG2JhMHf9WoEOf
   uTdNcqKPwgIyw47JLmdgCeFTV8WnTg5TsxzfeUDSZuoivzD+J6ud5p6iD
   56wNZ+tiQHN4UVo0ED6WRQFuZxbBIZqLM0t4B5y+EATTy01EQaynX8bhN
   RIHi+kTIyEbfpYaZVQ4pK2H8OhlFETaoSSbcZwwfExJUOjqM84YofPrTE
   /DeeXymgU3Qx1Nxk1qLY67hpjWE/HYeTIHrhAVLQyyCLeBelrW98WLMAs
   gX/WHDwzSCaJ3wSxpOoBEE685ztvNS1C4i9lzao6KsavJZwyx5zNrj8XV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="372193816"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="372193816"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 16:23:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="9767089"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 16:23:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 16:23:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 16:23:12 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 16:23:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIjROeGFU/HoDClQJZQk38BHfft1NgUQUH9ZCHICvYFqkZUeIbVASS7wuWDaLR+S6PnEOmHBPYWMQdeWI13QGZHSkBjedERaBEuPc7X9de07VPjiZ0YJj1UCQubFErXw/cegPzNInv0OxFBqXw8MDafIIV9xUkvKwPXuSsYW3KDIPdhodSZwZ4SDG1wHIaDgb7tnFpDh+z3I5AKEKtxXOFBhs389QLMeVFaaBLB5XoIR3MZkycs9eP6HCG5GgWB+h5lJWbi88sy+37On0dAA3YjWut+w02VFs2YQuB3WSif1bEjOW6Wf0f6s/iKhyHklg0Z4qbu1MkoJUnw2iyVC/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+X4WjDAEz6OCap57ANdRi4WrWaY6Bh0Zrt+VaFT0CZQ=;
 b=iSHAgneIbBecDCkuJbN/u4NEcauQ+nnTBnPBSzq9fpjT5CVxm0DEbmGWrMqt6dLz4h1tRZiWZUo6zRdx2Yvk2w2eYyu+JdK29ueeejpY3SS8PstOMswlH8hmzDGCGkcBk8mLdSvgnwhhE2pcybN848n/vH+f3JTT2NSciXP+f5jcfLlCa7WQpMwQi4stansH9O2vdFkqXWwSttKA0pVsoEpoiJkpHxk2lo79hACh3uEbrIeAWfwf1BzcIm7AO+UYOce4LG5YEE6Ubv5ljDbpDwfmrOAC17BT90Uvg9ME+7iTRqWxdqpLqMBOQj5Kvbfia8GqYbyJosjHRX69xmdC0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by SJ2PR11MB8347.namprd11.prod.outlook.com (2603:10b6:a03:544::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 00:23:10 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::eab4:33c1:2b7f:39fe]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::eab4:33c1:2b7f:39fe%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 00:23:10 +0000
From:   "Zhang, Tina" <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Nicolin Chen" <nicolinc@nvidia.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>
Subject: RE: [PATCH v10 1/6] iommu: Change kconfig around IOMMU_SVA
Thread-Topic: [PATCH v10 1/6] iommu: Change kconfig around IOMMU_SVA
Thread-Index: AQHaCGlk1cvAoUzubk6PoTMGEq8RvbBdOPMAgAACSlCAAB3GIIAAJUWAgDEu3oCAAGPl4A==
Date:   Tue, 28 Nov 2023 00:23:10 +0000
Message-ID: <MW5PR11MB58812E2A471CB470CD2D36DD89BCA@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20231027000525.1278806-1-tina.zhang@intel.com>
 <20231027000525.1278806-2-tina.zhang@intel.com> <ZTtixEgSkBI-TRro@8bytes.org>
 <MW5PR11MB5881E07803D25E3588FFABB789DCA@MW5PR11MB5881.namprd11.prod.outlook.com>
 <MW5PR11MB5881463F11D86198291EB52989DCA@MW5PR11MB5881.namprd11.prod.outlook.com>
 <20231027112013.GT3952@nvidia.com> <20231127182441.GA1170207@nvidia.com>
In-Reply-To: <20231127182441.GA1170207@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|SJ2PR11MB8347:EE_
x-ms-office365-filtering-correlation-id: ab70dca4-359b-4b6e-7ebd-08dbefa833d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YgqTt66luVHRX9uJuzspR5z+kXRHVsyexGGxc8NR3n+Noyti1etTM575HpQ6WjCBM1N6b5uG3tCnCNylv5aiqsfHOma0sIMNFI3HGxkTvOVM3YHFmTuEhGqnJzP4w/gft5o0wfO3uahfzVC3MuJwweDzIrsxogF+lfIMV5jVL1KrxbTr6KhnthBnAAZ4aqg/tVCaQaaSUGsOPq0u7jLxlCS+fM7GcgY85nkFr/G5gtstyhVUd7SjVkr1+dAQN8INHo14Tq9CmoVXdcmB7tXFFyYdTELN1K01W4gSa/DrhBJ0vA6YJdjYmOhHLmHPGcvZlieaQSl6bXmCnRs08IWLkJnhka3RSzBpQdFyAUwvqioq+I58mi/Dh0AiDyuYkbCiYF1tsXsDIrNFMAqWzDm16SV6IHi1j1kufqbmQdd4ALx5nwJSrIN/wJaUsNvlRjA355cuEQBeWKOVkBNIyvcKNiZyFxe8yK89pg5cfcyKcWTbp5O1ahCzRRLNrpB29fKHNr/Xr477Nbblv0CPYt2CSaYS0HLhrMRpJadwL7DJ6cZbB/8MIpkZ8g04E1oWKFLTLRqITnkW2MvGl3khGqrIJ3BP0XVzDEueXIeVc9Pz20Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66899024)(26005)(71200400001)(6506007)(53546011)(55016003)(52536014)(82960400001)(8676002)(8936002)(4326008)(5660300002)(7416002)(86362001)(478600001)(966005)(6916009)(316002)(66946007)(76116006)(66556008)(54906003)(66476007)(66446008)(64756008)(7696005)(38100700002)(83380400001)(122000001)(38070700009)(9686003)(33656002)(41300700001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?colznQATwk70R0igPsDBL6UtNUdMRfWUYeVeMCqGPJSlAIw11/RlbR9yT/xR?=
 =?us-ascii?Q?N0+jlEsCOS8SQM6N7tCNKmuHJYoniUJRYqRJ8xBZ5am5x1UwCutqlSg/W/3a?=
 =?us-ascii?Q?NFMtEnI6Ww9pczGV2ecm87nibBJ+rUAawUB3vXzUv5Pi0skZf30/yWw+UmuJ?=
 =?us-ascii?Q?vHhjca5YJVovt9g9274WJ32ciK8go/9LQtcYTRj/+XZkj8k26/9mG4z98euM?=
 =?us-ascii?Q?dhvKSeqgRDtBNbJvLAFegl65yitmEtPdbz8E1qPnSaYeqrlPFK5n3D3ITLkP?=
 =?us-ascii?Q?YkApuGMtprNqTM6XdXGyMcRYdQNKJ/anmSTfCXsbGS/KToaQ4fLLvVM8eBAV?=
 =?us-ascii?Q?MbNhU367lExR5PrwBTP/82dX61K+6t5uESTHQHHt7kGe2zMk6r6NBu0GnBY/?=
 =?us-ascii?Q?3OnTjBYBp5nTURp7WJsQ/NkEUA7OW8oq/SWCQ4e2c/FDUfZDpS1HazVTNoqq?=
 =?us-ascii?Q?OYDtO6m+w/BfBocgf3GTnrvT85vX6N467EZVfZxxEWXbdvlinV2InzQlbgm6?=
 =?us-ascii?Q?xFf87G+ibY9eDDBhMjgIiS/ODpNfDgPMN4zV1i813o7x/fgPKvA3BCGXRm0v?=
 =?us-ascii?Q?gePeX1+t4b/xcniEO1zypjye0Uuv2gC770Zm5kpuxO4henAXSpFtlorTmuKA?=
 =?us-ascii?Q?avEj97qKKxlXMTYlgEfgQpIsocDXa3q1PNYfXHy5cRYD/sJPpdA/+obB9ctk?=
 =?us-ascii?Q?p9Gfej31xtV2Lhho5E4/+pfh8fFZe1Dh9hYOhmN81iodOaxcQB2jY8RSNiGp?=
 =?us-ascii?Q?9LUWmZLv31DolaoxTcShs/jGN5N8PVIOKIXn7NQ51Cu4ytoRz51sUTuToA8T?=
 =?us-ascii?Q?FwBN5FzkuO4EnBzfbNS2iRAhcst6XHCiGDERhMpsTee84G/xQ6rYWPBZG3nG?=
 =?us-ascii?Q?wrtLtZAIAcAdkqCcrb8EQ6FkpHpz6luetDMbfwPPlMq/eOVPyaTcUyrk+EG3?=
 =?us-ascii?Q?DCLyFDyJR82U3KlKfk6daCM9B3ivYfO49bBch580k8ZfjrZcywCJEe6wV6gi?=
 =?us-ascii?Q?wNh1uE0LSF0gjILptaUL606kxK00i7fC2DiefTAs6CMhVa6pAfrZwNOZwkHl?=
 =?us-ascii?Q?ebqdRYFzcqpF23wTc9GQJiXF7FMOtNZvbfKbLHWbplUnmcg799mPUe3c6PTB?=
 =?us-ascii?Q?dFK3HV8wiCJCxOMzl0O8Cd1cyFWVXvqMszYReEq3U9+fLXNMOFI9NDSTmx+3?=
 =?us-ascii?Q?534xPQD7IIaESJC1gfeP6HKmmrIMjXRhJOdSEt5eggaMzGf9Dn95Huo+NuDD?=
 =?us-ascii?Q?JTSmDi5azj1MPoKziRShsyGPp4TIacKLGNL+y68GyLIXXZONgEj784apvVHA?=
 =?us-ascii?Q?nDN/FH/gR8FLtn0L+rsS8lP7bx+Xnnns6uHBDqOcC8YAcY7fUvf0f8rFlTLG?=
 =?us-ascii?Q?68sqAFtXCC791rVWnhhQSB7tCegiqXVUer9BHBvAzMJCIz4rTzyId+2oa1y/?=
 =?us-ascii?Q?2Fn51NXlf94gxwyy/iEzGNTVRzlYLh1AIYy76gjvk1Bml/sazoG1tSBueAK+?=
 =?us-ascii?Q?5WElvu80XqG7KwVaJq2Ws58h0+zJ/dm6+bk3I6uYwJqv+uub9iOd4v0j8z3Z?=
 =?us-ascii?Q?eu1npE3c80yd6mvrCJfqWLH4ORJXBZAW6gZZV1/k?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab70dca4-359b-4b6e-7ebd-08dbefa833d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 00:23:10.6187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eKiEf2wyDbQTo4EwqaTOwNc5tbtNn1PpchPu34Haj7SvpszW/ZI2Q4B1JYi7HnwRielbaEZrHk+OsnrgDDtOQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8347
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, November 28, 2023 2:25 AM
> To: Zhang, Tina <tina.zhang@intel.com>
> Cc: Joerg Roedel <joro@8bytes.org>; iommu@lists.linux.dev; linux-
> kernel@vger.kernel.org; David Woodhouse <dwmw2@infradead.org>; Lu
> Baolu <baolu.lu@linux.intel.com>; Will Deacon <will@kernel.org>; Robin
> Murphy <robin.murphy@arm.com>; Tian, Kevin <kevin.tian@intel.com>;
> Nicolin Chen <nicolinc@nvidia.com>; Michael Shavit <mshavit@google.com>;
> Vasant Hegde <vasant.hegde@amd.com>
> Subject: Re: [PATCH v10 1/6] iommu: Change kconfig around IOMMU_SVA
>=20
> On Fri, Oct 27, 2023 at 08:20:13AM -0300, Jason Gunthorpe wrote:
> > On Fri, Oct 27, 2023 at 09:14:17AM +0000, Zhang, Tina wrote:
> > > > > On Fri, Oct 27, 2023 at 08:05:20AM +0800, Tina Zhang wrote:
> > > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > >
> > > > > > Linus suggested that the kconfig here is confusing:
> > > > >
> > > > > While this patch looks decent to me, you forgot to Cc Linus on
> > > > > it. In general, given that it touches a couple of core files,
> > > > > I'd like to wait for some more people to have a look at it and no=
t rushing
> anything in.
> > > > Make sense. I'll CC Linus. Comments are welcome.
> >
> > > Can we separate this patch? I'm thinking about CC more people for
> > > review. At least, we need to CC all the reviewers of
> > > https://lore.kernel.org/all/20230506133134.1492395-1-
> jacob.jun.pan@l
> > > inux.intel.com/ to this patch. So, it seems more reasonable to
> > > separate this patch. What do you think?
> >
> > I think that makes sense, let's go ahead with the rest of the SVA
> > series and we can do this next cycle. Bikeshedding config names isn't
> > really critical.
>=20
> So this didn't make it even without the config change :(
>=20
> Can you please resend it again and CC the right please please. This needs=
 to go
> into this cycle for sure
Sure.

Regards,
-Tina
>=20
> Thanks
> Jason

