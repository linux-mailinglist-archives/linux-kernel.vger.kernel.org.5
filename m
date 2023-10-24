Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5AF7D44D6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjJXBSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJXBSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:18:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBCBA1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 18:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698110324; x=1729646324;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XIsThACAoqZ7IhpZ6LQabNZu6G4qemxhgu/w00TaUXA=;
  b=SndQItP2isxVoXiP1JXLnpUIdRIOLIh4oDfkk+6VOgZoL/dQm5Cqldrb
   4S5XH2ln4RfCamFB6Zm4sRqQS+W5zS+ihZxqI6k1/xxBpDRwabHgRt9i1
   51Dc6q/qCxyUWiOG/r7CzCg8Ktu1QD3XBNowCok1dDn56vGT5QQ3VEfHy
   MDZwmIbJR/8MKa0XFtNZlU2lb1d6WFa4RICicUsACvTDKlPsT6SDx3q69
   VwFcyITgbb/Prtes9W08bVrgTPt9KojAWeu7zjnz385zdsNVVXLxeZiJZ
   +zeIs2oHCXBe/hjlQf5Ov0Ax/ZvGSPUNLFlStenpVEipN3qkUWnRPMt5i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="366305858"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="366305858"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 18:18:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="848962561"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="848962561"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 18:18:44 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 18:18:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 18:18:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 18:18:43 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 18:18:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSxXIiy7EfXyD4x4L5+51Ux//m6DiNFib5Pf47nC04NLOTc0PEtTgfEO32hV6XINSwMjzoADcn/sOedb2AnQ0pqQxFJ8A7yZ1BoEnFTZ1BtBBUBgoTDdZirOG00N1KQYU7mO1RRllIkn0nbQDj7WRBetb+dORy0h/jGcuDjQkgeNB8+g8wpKOTGwi7UsdAtC2XaAQcAiCHy6cOcb2FtM7Oa9xIMnnMnvP9rfVR0nQmpyOiHcgq7GMui9B6nrVMOFgBD/uKvoKQ2wD0Y+hMNVgAQEDZ3b4clGYie2YqUZiSgtvD2CfeZ0WCBl6A+itw0LoHp0XAbAlRMAKgedfLrbYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tFqZD5oJvV5yNAfE7hdHkfObo3Vqthbafmy7DcpiBw=;
 b=dhgaOEmLTXnTllVD7e9ygvo1O4qGEC65yt9Qoi0SN517Wqwgd5SwwupIp0e9sOAwPthfdzwJBTrJO0uv0Bc7WdoTaXEl7UzFANy6I0hVT8AwWTQ5U+KyDpAbPsgnOOx28yvHc7m3hL23yu+Je1BGYCSjZaOdG4QwTpaRqeHkylacac5yXjSV7NoKdB63TxikAt6Dnc9Uq06Qq8sJQB1UGl8IS0Zgpuco3Opeksuc3jkybv+6Sum8yjGeJdHZBKpHoqSTsQMBYc8PSh0MIVWDR6JbJCFY4XDKX8T1QPLx+uuIVOR7LWeg2DlFLrMxhohqmpuQv5E7Hfk1UCHkCaB70A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM8PR11MB5608.namprd11.prod.outlook.com (2603:10b6:8:35::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.31; Tue, 24 Oct 2023 01:18:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 01:18:33 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Nicolin Chen <nicolinc@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3] iommufd: Only enforce cache coherency in
 iommufd_hw_pagetable_alloc
Thread-Topic: [PATCH v3] iommufd: Only enforce cache coherency in
 iommufd_hw_pagetable_alloc
Thread-Index: AQHaBeLDLztCnanYVUqlQIpqtTMrCLBX/veAgAAlKrA=
Date:   Tue, 24 Oct 2023 01:18:33 +0000
Message-ID: <BN9PR11MB5276D46F61B57553CB37AAAD8CDFA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231023185700.11407-1-nicolinc@nvidia.com>
 <20231023230509.GI3952@nvidia.com>
In-Reply-To: <20231023230509.GI3952@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM8PR11MB5608:EE_
x-ms-office365-filtering-correlation-id: e3b5a72e-4708-4db4-dc1e-08dbd42f23cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oRFxZMDrdJA73gOypoISRWYcemcbmuVpEM5kjkJFVj5P4TLUFQVthyaCSWncs670CrHqg/kPVdxGcuvbfmX+vtXeE7iprieCKsl2vGsoz5NhkM0uE4ZGTbI6m61FK0lLw1fblQl/XJOiPkEYlNrWkfSob19sO5PMa6dLrlgX6umohzqnHUvOyVR7Q2rI/skWy9WGbEmGVDnpEvOFLPgpEBYNJCntHA6rOAKOMPPGbRh2QutpEZt2qeqbKpjPMDCYvXgI7d4hDd+qzz8gCV7bcLXSoQ47i9hB+KxnYznlFhFCn13lm9mC1I4e8r3491Kcb2IX728UTM+gFNx0qQAvbV9jv+9Mg1NupIix9uYVEzSlBgVePwo+0VjJ9XxQ5bgW4O/uM++oeeFARiPeeA43e6G67d47TyoeLIF8nmZgGGEE2NnxuULrsDdQaUmSo8wEXRuam4s1SrO+w5PaTeGZTRnEA+5cf6WVeMCUQPItqC2mFfV/H2XeD97gqwdJ0N5CqyqkTXqZk+u++hVRe2pa6/ysqNYc/a8VMZ1wlpmSAgeIskXwToAGbnb2C3bL92WsqMvAu7XOw9fnLJ3SNw17+Hi2peB6pJJACvFhhoHfLQX55xmrUG+Qr4Oq25R7NXJlRc6938ggzttXONzgnVONcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(55016003)(110136005)(7696005)(76116006)(66446008)(66556008)(66476007)(64756008)(66946007)(86362001)(41300700001)(54906003)(316002)(478600001)(6506007)(9686003)(966005)(5660300002)(33656002)(8936002)(4326008)(82960400001)(52536014)(2906002)(8676002)(26005)(38100700002)(122000001)(71200400001)(83380400001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LYRAGFqT5/IcGfrP/gbbxH3S2Ur8rapUCx79NYzaXYyUT8SsNyUDCjITibbk?=
 =?us-ascii?Q?SIxBbI3sC2QsAoVVrvhXfmTexNAhoAP69uKtBcWtPgKtagIHh25LYc7l4Iuk?=
 =?us-ascii?Q?5gm9f4r9sQ0mmiA6xyEXfAmc7UYagjPDwyq5mzdNUdu+DJOSbETuLKSbM4XM?=
 =?us-ascii?Q?K3OB/JscWXpN+A6H6hQQkcSy8FDe67TgWExvcQJMtoZhnHpx+D7aLPlNz3mg?=
 =?us-ascii?Q?cpsr5ioDsgLONMb365lpS0f1YI8lCY1RnFAEpQhb3AdNgVsDaNqcgAE8vLx4?=
 =?us-ascii?Q?V57sE3SRj6pKNLXQNiSU/qfEskeqA9+QGMuiDROkq8esjZztaHsCt+xYfr2n?=
 =?us-ascii?Q?9ixp3IfJuuENknZQXTh6L9dGX0+MFfMKDZi1s29SOs4Uj7yJP8BWIP6CgAq4?=
 =?us-ascii?Q?BIDEqAP16zCReT1CLWFLCZ991qdAWxuSPX6H8mJd5NtMciHKV1n29vg4vOZ8?=
 =?us-ascii?Q?/R55j/2rj/Ee4rINFqcNOdVYUTJC8nI/TDkSsq+INymg4ioNIsb/sPbAdtv9?=
 =?us-ascii?Q?SJh2bmJfBW1N2bO/Wz0Aw03syuPTLXu7LSDervL+d5lMQGu7Q7MPaORUVyKZ?=
 =?us-ascii?Q?6AkFjcRWOBXa6kZsg7ApmOQIDw4W12Qgo/5FtDEPVy6+yCwuKpz9+6mdLEpT?=
 =?us-ascii?Q?0sx6dlm0K9H+ZA2T6zHWpZHUNJPVY6+OHnyF+DkaO73M9qPPZHiVF4YhXJ++?=
 =?us-ascii?Q?/U3zrXaJ3CwvZzmrcqMuQKJXLdahvrU++QHdLstPoBz8VrSiOgleFdsQ6q7I?=
 =?us-ascii?Q?PMihx7Dv0EO6NI2j5Mu+j/j95mfYyK1Gmr/qjs/GW1L5wMOO5csEAramb4D4?=
 =?us-ascii?Q?T/iIfSn9c5z2bEY4WagDWp8e0ttaZKxMy1qmSjt4RmQUFnRsyiqJl1HzmRD8?=
 =?us-ascii?Q?1dvxIWdTMbxBYVpjeuDkSAmKzrT9fxoMkue80ybVx4z414Pe69LDsQniJNCY?=
 =?us-ascii?Q?2D4K2gYkhMyvlEv6ngzLpdrmpJiNDbTBW+FKYpvYJQ051bnyLyeWFGNKkHxs?=
 =?us-ascii?Q?AFB4I4gSTE78NORud8zhOhFQ5YHzp7uWgF/3r2xqC3cFI7xpmEeSbgM3M3ka?=
 =?us-ascii?Q?CCNn8L4FzIAQlu9nRsYb0COQZOEpdJiz9XJ7du+P7TsGlH2M/Ahbrs8PJC0r?=
 =?us-ascii?Q?JR8EuL60nhHie4ESPy4v+/OGftBm3OAgDHRzsAZZ0axyLhFIqPLUpR6rMJPm?=
 =?us-ascii?Q?AmXUtBOeJX44jhRqncWqx9eopZZk8MiU7glK84GMudHYx4YhnXH3+bw5jOy4?=
 =?us-ascii?Q?xepxFlioEv3F4zFNmCgmUFHpwxm1tt9n8Ci+ksB+sknKzQWsoDMkm0BCjOkN?=
 =?us-ascii?Q?MKlcbLx5nhomaGUUws1PZA8le7kpRobQzs3dhhd4aj5hzdhIptsAl/1740dB?=
 =?us-ascii?Q?xuiR3JJkC5vmPNKf/VdBYtYLA7IYvEk4kGziWSIMQfUtasPbxzHw0vg8reQx?=
 =?us-ascii?Q?y56JbhryElBSzI5B05S8RMaBH0Pt3bZHY6qapqFeIBgyLODMHy4H+NwRFEC9?=
 =?us-ascii?Q?iw6UpFnYmgkJ0dsagw1q7ODKWgVRnM9ZI9pBuCNJIxXVZ5kob2bWbibkwevW?=
 =?us-ascii?Q?KToTE+8l2QMSRUfg0XmOpUj8fWcSp5toRlTvd2zk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b5a72e-4708-4db4-dc1e-08dbd42f23cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 01:18:33.1817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fq+3g2nWAgACwlkjoE2IX+W7MJUJZa0f52hcgyiUmqEekHJsGjgCckNiXvx3Qf8IaFKSr2G9EgiWHxkDANEPXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5608
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, October 24, 2023 7:05 AM
>=20
> On Mon, Oct 23, 2023 at 11:57:00AM -0700, Nicolin Chen wrote:
> > According to the conversion in the following link:
> > https://lore.kernel.org/linux-
> iommu/20231020135501.GG3952@nvidia.com/
> >
> > The enforce_cache_coherency should be set/enforced in the hwpt
> allocation
> > routine. The iommu driver in its attach_dev() op should decide whether =
to
> > reject or not a device that doesn't match with the configuration of cac=
he
> > coherency. Drop the enforce_cache_coherency piece in the attach/replace=
()
> > and move the remaining "num_devices" piece closer to the refcount that =
is
> > using it.
> >
> > Accordingly drop its function prototype in the header and mark it stati=
c.
> > Also add some extra comments to clarify the expected behaviors.
> >
> > Suggested-by: Kevin Tian <kevin.tian@intel.com>
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> > Changelog
> > v3:
> >  * Reworked the first line of the added commets.
> > v2: https://lore.kernel.org/all/20231023035733.27378-1-
> nicolinc@nvidia.com/
> >  * Dropped "fixes" tags and merged two patches into one (Jason)
> >  * Added comments to the remaining enforce_cache_coherency call (Jason)
> >    [Please feel free to rephrase, or let me know what to change.]
> >  * Replace "num_devices++" with list_for_each_entry (Baolu)
> > v1: https://lore.kernel.org/all/cover.1697848510.git.nicolinc@nvidia.co=
m/
> >
> >  drivers/iommu/iommufd/device.c          | 20 ++------------------
> >  drivers/iommu/iommufd/hw_pagetable.c    |  9 ++++++++-
> >  drivers/iommu/iommufd/iommufd_private.h |  1 -
> >  3 files changed, 10 insertions(+), 20 deletions(-)
>=20
> This looks OK to me, Kevin is it what you think it should be now?
>=20

This looks good.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
