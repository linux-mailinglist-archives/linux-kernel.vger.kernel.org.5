Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EABC751A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjGMHwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjGMHwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:52:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57AB210C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689234737; x=1720770737;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GLpi+3oumcgTY35EcGo5jLBT9LhpIJEDON5/79lOCgA=;
  b=JhRDFVvGm9aij/JaMqRq9qv5b3STkUSd6qbci5nC9ThZqcoCd2eocqK7
   ODwuGNOdzF+iIt5TOrP1dY0/nGyCo8/MVhtO16QACOyIfam8y4KJqzmh4
   a/IdZARFCDKY3LTXN7FpTmTbLBGXTQcofSA9lbwIpSDowTnXJAcYYvclM
   +PEQp6iG+0azDmHQUiAfQPzKq7mddl9zPZdFNbYKgMnIM77JNzsS1i3Xo
   TT/EQbzn2tkAV+n4Zp/vk1y1SePb5pFzbDMXT1T71masJM/6JJv5byafp
   RD9BwfCaNvJ2laPVK69Z8YzVos4p1dSEbikdVZTZtuNhC8y55o0BOQwg2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="355034264"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="355034264"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 00:52:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="699167042"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="699167042"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 13 Jul 2023 00:52:17 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 00:52:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 00:52:16 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 00:52:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmN7GH46FgZanagomqnfJVXjBtaPmyt/hlMgszMC20CwkMzlZkRxg4qfd6j6jmcYC5HmYWdAyix9eZYWvxM7uZ0uREX72FTUaPCiWmnQYIKrQsbBvP4wzS8RXkMhLTSqYBiJ/TMiFcBNFRWQjlSeUY1fz0k9T++Zk50bM3NKuFBEMCsPimT11zIZBHShG5+cunTxrJAO5T3coFxInOVQSiEHXqlDVvKO9utKZoK18lYnaEsJXZQOdbjwvQeL+VBUg/XfckajdVps71qYappPurSNcPqvbgW4cNN3KTQrbzbq6ladpbx0J5ryLVjeMe0P5iGQXsWD5PSBe2NeHNvl8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/zHBaDc6OTT6ZiHrRnSPT+6gnnP30tPWc9iPbP+uPI=;
 b=mIW/ARJs7gKfiBgQ1W0TXqp/IAIPPOegcwcVqQOf1+fAsxCrlTXQYV+8HjSOmzXMIvuD+D2K73f4aX0i2RSh5kzlrx5YOH0AD91chLWZYKybQjCshfkkVx8GdxwGCvj9kqya75l/bMGf9HCt33KJjtlA3FvOrSxh42+IBpZrNR8gvmHujy+XPy/flqPjE/heMuVc8AOdcTIy4bMnEJyireHc54FLKawKsYoIJCG3S6+rpUh/t9ef9gSYkWTPGW2TAWjOjMv09fJJR5UIsSAsHVq7xiUgwgPOwPAamS5tLM+dvn/TMa9n31uSnUYm1kCJZmgNkxaLukMMoWqBKsZgbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5816.namprd11.prod.outlook.com (2603:10b6:a03:427::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 07:52:10 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 07:52:10 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Robin Murphy" <robin.murphy@arm.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v10 3/7] iommu/vt-d: Add domain_flush_pasid_iotlb()
Thread-Topic: [PATCH v10 3/7] iommu/vt-d: Add domain_flush_pasid_iotlb()
Thread-Index: AQHZtN38FvvxAju+I0Wmp9YhFMGVA6+3U8rA
Date:   Thu, 13 Jul 2023 07:52:09 +0000
Message-ID: <BN9PR11MB5276EC6A22D3A3C9DE1C46678C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230712163355.3177511-1-jacob.jun.pan@linux.intel.com>
 <20230712163355.3177511-4-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230712163355.3177511-4-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5816:EE_
x-ms-office365-filtering-correlation-id: 112fc54e-533d-425a-49da-08db83760fee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tbHovwpTQ77+HnrpsoTkQABn81Kuzd48WNyxrsJ55+DHCVsxmnqw1IuOGJwA8Nhh2KEegvAV1D2ksFg7XAUiLIohNNK+PqiF+00zkom2LzRxHX/58ox4ifrssxKIHMKY+9WBHJI9vB/argMbvuv0NFOhEK14k/VZvIVV4x5+Y4/faJDSkmxu9YhZaP4/7HWe78/P5XScwx3lgw/2w8t6x+N/uVIjcal1ONhHvwhTkLpR2GOyiSfUPPeyh2vIb3/rIaWjR6cOSVz8kRSfm53H4IwrkcpWEobCJ89hvVGy+8jgzuTnRp9fmPzGMdmrM/IYMkw8AxGJilXtyPNdEz6gXBFTpbCm74i0YSypISxN80Np4+75e8tPXT69sOh9CDJdczc+WMbu17ftrKsZ8ryT+e8ebSPkfyCnhA0SY2+KhVEWVYYf7zGod4r9ePDKRGTGXAfWDeCfyUSeFr51VF1k+Ox6mHsc06mUsjS0aIVEfbsR22f1PkQ43vMZHqGWGo1qH1mFjWU4/N47dGre6ivoRuRxVyYbygkD3JDr3LuC3eyLXGhuE4ik7/NzpmiN5n3GvdZ3ziaIq94siLhRBxgdCUKijYd5RRTib1f983ciHK3ACVbSG0EThkCk6JcczurZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199021)(7696005)(9686003)(71200400001)(33656002)(186003)(6506007)(83380400001)(38070700005)(86362001)(38100700002)(82960400001)(122000001)(55016003)(26005)(4326008)(64756008)(66446008)(76116006)(66946007)(66556008)(66476007)(41300700001)(4744005)(2906002)(316002)(52536014)(5660300002)(8936002)(8676002)(110136005)(54906003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zUfV9keIjSSmKltkVEl9xPzdDcgdmSFyoazagK5tctMGuzJ/g0M6gpxRd9dP?=
 =?us-ascii?Q?CN/9mzWb6v4cUc8gMD+zgqcPzertn7rERlaSBsAzXbAHGrSGNo2cyaXrBP7B?=
 =?us-ascii?Q?38Czxc4n7og5+rtPE4eVDK2l45AIDNW+GEe5SFwIKQqI1HtiYWoxudbucLQ1?=
 =?us-ascii?Q?qyqeVy5UXv1uybRxL9Vjz2OUr0eCMsZh+MQR/lJ67hCT1Ski3oERMTqaxQX8?=
 =?us-ascii?Q?jN4vgRgoHR4bzNrRDaUbtNwzG4/Jz90GdCCREwb3h2PXsSn+QbQe2pyBsHJ6?=
 =?us-ascii?Q?q2fGNxC1+zXO8wyC9tL2mQoR+vbM9hKqkW6dFHU6rsmU1iTu4R4xlxrJwfzY?=
 =?us-ascii?Q?7SOnvTW47v3BcuCCk5he7xa685km4SdvdTi3mBdaab1nLe2+IV8mmHnSuDa4?=
 =?us-ascii?Q?YG0+WdUnmqeP0RiMfDMarWR9rMjqg132SQ51mCEuf9wiAYpP0vKaGWJxL98u?=
 =?us-ascii?Q?o4NsLiPu+H+gds1TwTqKxWRclYvKglZbYrZ7yfpIva/MYNSyx97aG/rQkGA3?=
 =?us-ascii?Q?6RWSVLefs5/iI912KMJsg16xtAGfKgOe0KShi3OVWFdn+OyDxQxMgKf7U/I4?=
 =?us-ascii?Q?Ur6ajV4t0VAFou9wyxyMdXeyg8t5KUPxMauWe1LWSBODf5FDi2Q1LLM7QXor?=
 =?us-ascii?Q?NaWHgbUPuXgecczzlAxD1e3ulFhdP8BEKWgYP8SJ7vfXSY71vtOM7U+yNT0K?=
 =?us-ascii?Q?AMB+ZilzrSXVTM3BBZOu7DVAS+80AGlRqwlxcrUyHK5xEfGBYWWYvUvP9rOk?=
 =?us-ascii?Q?mMw5LzakcVe8snn05ObJtanokfdHvA/C8lSzwce05fbN9Cb0iXnBjY2lerdv?=
 =?us-ascii?Q?FfYwPXUyg4nTh3PiIClWR/mpZlIT9dP2zTD55oYeHuOc7RpAAWh+aCCQgm+V?=
 =?us-ascii?Q?Fkbez983Bg3EFksDfB7nuOKAz6GPnNzmVgqxOXxYMkWeeJZj/IBQ26B1c1bo?=
 =?us-ascii?Q?kVDcoPk2z5u/M5+Tlg5QFZQ7rHBpdt7Ynmsd+O5Nj96x7F39Q2Tz+DAHrPv2?=
 =?us-ascii?Q?nxxlU+K3hzwWsTgx7S5kj8lHnJBJDTNpJ4OhRaEByPkpIo9wZ7k5G1vX+MhZ?=
 =?us-ascii?Q?IuOBykBk9S2bPx7bxJkIsj8p/63QmDkyFO5JRhwQ1BmQlQP8Ur9od47gSNY3?=
 =?us-ascii?Q?8kgJNC2+GVSxpBVRpOJbIRFh4MHYkV5GZWW0w2J5/R/vrmV6I1HU3yqGeoyl?=
 =?us-ascii?Q?cfENWUoOwS4i655Gk5PyjpRj9eE31rGRy6xRpilA8u9yE0KY+0pA0n0nLKwa?=
 =?us-ascii?Q?ksulefoIF/TKybn6wKJnONfQTsGPkoNhONY+YermW4KHJLKS5dN5LSPL3lMk?=
 =?us-ascii?Q?yZyfvMtXk3Lj4TB/lb395jUMurHhLL5ZUOsVq9y17rkZI88ibEFBPr8X0a8Z?=
 =?us-ascii?Q?oJ+Pqdsm7rbKt5EiGVaZwtSoO9OCUCJ04SmNd5oG6akydOk67JcPdnnDLQ8h?=
 =?us-ascii?Q?avuNSRhemORUH0bB3pEO35geckwFE1zl2HY8txXehN8kX57DMDLl+rsYRcgB?=
 =?us-ascii?Q?DWq4nFPt0rp9Ic4SVbnErCKT++rvghsK6dvGoSugEPCiRXI5lAu0AlVWXCJ9?=
 =?us-ascii?Q?7Ii38qhXLSRbyVo5Me3vu5jH4hDdrS6xylC1pPt+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112fc54e-533d-425a-49da-08db83760fee
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 07:52:09.9122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JvJ2GlR/QClSY7GlgKTnMxcuI2jIbDunSkKW+a0qx+UodNq2QAbennBsPnwQ/9zHrGq5+TqfeclF1tC4vXepEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5816
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Thursday, July 13, 2023 12:34 AM
> +static void domain_flush_pasid_iotlb(struct intel_iommu *iommu,
> +				     struct dmar_domain *domain, u64 addr,
> +				     unsigned long npages, bool ih)
> +{
> +	u16 did =3D domain_id_iommu(domain, iommu);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&domain->lock, flags);
> +	if (!list_empty(&domain->devices))
> +		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr,
> npages, ih);
> +	spin_unlock_irqrestore(&domain->lock, flags);

btw I gave a comment before that the check of list_empty() changes
the semantics instead of just creating a helper.

If it's the right thing to do please split it into a separate fix patch.
