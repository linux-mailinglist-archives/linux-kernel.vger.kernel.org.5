Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D1D751A1E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjGMHnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjGMHnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:43:06 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A2B2115
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689234183; x=1720770183;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j+GRpBXUoOIB9ldQpMkKO2LJYaiWNu6J+YAuUyOZ+pE=;
  b=ifJpGNjZD7U4eOeVCaKp8MuDE11XRFr3KYYx6j8Ws9OfyZ+/ONj7Hv2P
   ll+lXZzbH+2byge+y6p8/KHEniUuyyqjxqtdjuZYwg+sbD7Qys+ztZ9xE
   Ca3zLRyc1cZrujnaq3FqInRDQJzWuFM1kPlSizfnz4YqCVpU6qaOZiZKn
   gdeTgIY169JDjE5Z+Qde9DaIntcRDAmtNjYaXEBov6FHSyizx1ZJJBDni
   QKsNsQlylh6cYVmhhXEz2I6XYedNgCpVOZIhOwRzWto9u7VRL0czDHY+k
   t4fysUyZuaiyG3CkvpC9F0GnuPAaif4nUO8aaTb/3Cy1xFwzd97Odv04V
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="428866169"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="428866169"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 00:42:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="757063113"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="757063113"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 13 Jul 2023 00:42:04 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 00:42:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 00:42:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 00:42:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKy3mUlZTcUYUerH9rX+qbikN6Z4Jp5L1GkRrwEGueIpw8ML4Th/4zMZzpBcUad6gZDSIeBCYULjDNkOJAug/WXqNTftAqpAjNBd3ffbsPYJIeQfBrd/EmFm2RyTFEkm8PxhLehQ36y4TB7sm/MdNL3YexpcZ3pF/kJsc7aU7z/tUGZcQ0rVcFFqY87RJzb/JnQsYdWa7nD9mV3jBh+wfOjWwgCypA3kK6CdKPjEyY396xoUVZCZmMx9WbNqwbVzhFDKvlSNk1JpR37QZOg1Opy+aP1f3uEMNrQAJPzMfO/y/wI7OaGIEbN6lZ370qoDkEcDOXPxcOiRLmGFIKeLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrCym9NGj6FzmHxZeHYPJzdFZp4GHSTUkPNMIbK1ktU=;
 b=ExdsIHdiHa8lHEnrJp1PE7l5st2WT+7k0va5lS8Nf0RjtlRO7tdBvVI2gq+gFwGOKaV88mBaHX2gLxqE3GKtndjJtOR2DB7pQdL9og3RrTl0xLxVZUAZ87SeEvObiWKA9j5JO52NDkShX87Ekr3Xb1xVizvXbGEb7ItLi9DwZ/gNinW9sKN35xpu9xZm6Zx8kDXS0F9tBCW+RlalQgPrc7XTKnSDGFMc54W6pV5uiJPdk9Td0T1/3boWxvUhImQ6pHZjdVJlq9WuFEzY/uMgkytSptQoyVva2O04K+0TPOfXejXFQoK/NnN11FZZ69KT9P+G6clM/iCs1AZfltsggA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BY1PR11MB8126.namprd11.prod.outlook.com (2603:10b6:a03:52e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Thu, 13 Jul
 2023 07:42:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 07:42:02 +0000
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
Subject: RE: [PATCH v10 2/7] iommu: Move global PASID allocation from SVA to
 core
Thread-Topic: [PATCH v10 2/7] iommu: Move global PASID allocation from SVA to
 core
Thread-Index: AQHZtN391/lvNgjG5EiNtGDik6wH1K+3UQwA
Date:   Thu, 13 Jul 2023 07:42:01 +0000
Message-ID: <BN9PR11MB527619C7106BE91167B9EC118C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230712163355.3177511-1-jacob.jun.pan@linux.intel.com>
 <20230712163355.3177511-3-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230712163355.3177511-3-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BY1PR11MB8126:EE_
x-ms-office365-filtering-correlation-id: 53b07c85-d6df-47bb-14af-08db8374a591
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ursn/krsClYwAiIYEvt5mAztlqGRF4a0cYb8f1acsfogISu/Cs04UY5oCx7bOxxKtOuKT8V0S0UrcKuUvdkhJg+M5Wr2CPqEpYwfUd2W/z3JXU7jxjRoX91dB2HpAd/kG4yfrPZjlx9Whg7qe5yk1xjxFtlgPRWP5mPTgQPIqha7R3Vv429U6e/htK9KBG7evbWrNYE76coT7b3UKPYGPbWTzDwWzSmzirwdrYrBvuFiYEds42eGHsKMtHCQ5uRZzy+kBzrJi3OGNt8JePc3vDTPIdDOv31xD6mO424m0lThDsIWo9QTbgI3HsAhTeLNn1IkbGLweXlZ8RfQSq3lnJVJQPAZP2Hhc4V65pL1x21buJHckpw+8M02P/2nkTkxNdUdpLqFJZYpdQ11KyW6n0cI2dKXj0t6mNqhJxrVN0/Gm4UTWV1b8JuhXhqVqAQKW5pci6o53E7GW1I9hXf0C8aTUERAesXgGAMgyA7y91gDdAdAttbO8lQd3kL1BHxSY/u0z85y5cBwzZZwO3arAByNjyczi8lwQSQrXT4BqlC/AI6TptZa0vU+Fsu7+rSLm63A3UyG+uZD3tDIZVOqkfkV4DF2Bdywxm7GT5aBBIfdYdjwjaJCaQQMb9O6pBNb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199021)(76116006)(4326008)(82960400001)(316002)(66556008)(86362001)(9686003)(66946007)(66476007)(66446008)(64756008)(186003)(6506007)(26005)(122000001)(4744005)(2906002)(7696005)(41300700001)(38100700002)(71200400001)(33656002)(5660300002)(38070700005)(52536014)(478600001)(110136005)(8936002)(54906003)(8676002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c+5m97v4CebVOeZ8w562tTEJdu664zb/OCKbmlfkAIXbMK7FvLg2xtdG2drU?=
 =?us-ascii?Q?oorCnwPsndJXsfcLf/IyUCljb+Tp6DOJ8gaOJPzzW/RSAtOsYMBas4j7lxuT?=
 =?us-ascii?Q?3ztwQPTOuEdsUgqcOx7axY3/58/YC1gyB7puRZldyorczI+UXVwGOdwywfDY?=
 =?us-ascii?Q?81Di0Odv7nQz3bI+s69p4Wu7sHDj9ndpmyrenBYyEhq0Ho0ULGOHQj7ZfbJO?=
 =?us-ascii?Q?bOOF4vknLALbpVplnVhhFVRS2bB9TFv397YHEEXK9uQcNa765JC7zABhqEWe?=
 =?us-ascii?Q?z5D1xNFFiBOMivyd9EM3NWYOuEdGJajuir5PSsbct+89stkkHU4BOcKZxfuA?=
 =?us-ascii?Q?+7MIXfxHea93Xef9YrCnzSFqGg0IPomG1Zz8EmAqumsyagkz5q5XQlRJ/Y0q?=
 =?us-ascii?Q?2xV1Wm0Y3EMzNHa2zi0SNM4xakNSzPiQyWzDhkEF+N27YHsyJZzwVcOQW3ud?=
 =?us-ascii?Q?+l2mkL7CC72BIm3oLoAXrwCKmCRM2rnFiQUPH2juFUdSYKXKDjW6A9oLeBLu?=
 =?us-ascii?Q?s1k/Nzp81Gx/Ox0FBl5LGdVGWEc75L+Hwnj21/ljV77fnRjAL818sad2A4L+?=
 =?us-ascii?Q?bmd3j3ovg64chaDCYuA011Jiq2LsUrvnZ2IG8D3JSDy5s9IiYMS/fLWbpAje?=
 =?us-ascii?Q?J5iUMYJSsAUZm92ekXGzXTsEHK5adO5x9RW28hv9Imk2eUFeobUlWRQ1bUxI?=
 =?us-ascii?Q?WdCo7ersxzFUyGoN3+TKumtqac1UdbU/VmRi8oDy1f7VeTClPVhdZWEWCQf3?=
 =?us-ascii?Q?BKzlBeI5B/dVnhmZKAX9y7HR8GINEufLipoc0zs2GSPDN4gnRY93xyAGhskR?=
 =?us-ascii?Q?ZaOjtHGa4OK3H9L7q+7WwEZhpUeSwVhHIAcfPHn4i0yoMUFxfxVQy2CVO3Bl?=
 =?us-ascii?Q?C4wLgnz1y3irpMJk/7i0bh3ceG1LPjGVZNqX6LVi7AV05ImNI5NMXlQk/eo3?=
 =?us-ascii?Q?6uww2/XQbxUs5SckgEjYGGcJM64G7CEAA1P9Y65NxN3Z74+P8cMuzHC9IQlm?=
 =?us-ascii?Q?WlND/TxPqPdFa1rTaix0rMNDNsI/XL8+xiwT0+GwgpN234pH5JY48tkO1HX3?=
 =?us-ascii?Q?N+RDE6VhZ9dAvyz4ld+SnbVaTSxADp1hw4kcDD7rQKYPsvCuRR/zHwT6KiaK?=
 =?us-ascii?Q?aQU2Vjfw0sR1lXq2Hn9lgk8jPCZkaQjzWntFmNpIH3hQ9W+FS7+nSzbypwgH?=
 =?us-ascii?Q?Gx5KrlM8e9MPBLykO3L0lXttdTGqZYuzBrvzWhi/q0BmuZreUzXmMU/EqGs0?=
 =?us-ascii?Q?6w3YuCRQ0OJypqbC3E5fx8ZzrkJUyzf41mYoHs9KhcjUIuEz3E0Z/jelRwJe?=
 =?us-ascii?Q?EZuz1UjWJTOIJNghaNOAaLqMXTphaf9dJpAYOgaXbJ3Nm+pzFcz5WOgcySCi?=
 =?us-ascii?Q?bN8381YiIgt6vUeZO/Yb3nFLiqVRq6/wQTsccYE7Dyd9OKRlP0L25lQ/tUUE?=
 =?us-ascii?Q?vVM9dfKVKKzHqBB2fY+fOJdzxN2lPns1zGxnfEO3eBafrqP2qzPWb2pMY1Hq?=
 =?us-ascii?Q?ZCtn6AJoe+ZWvV3qXURyhA2w4MRL8ovwj7N9LxuHCl0x57hj0tsmdulsvGCT?=
 =?us-ascii?Q?576nJg+amUrk01cj3uD4kWIQeem2TcB+dYlxTegC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b07c85-d6df-47bb-14af-08db8374a591
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 07:42:01.9716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l0GvsyOFgR3rdXv0iwsGHifkK8hD9P2LK32nJGjwZrV8Y43pPmI1gxNSkjz4N2z79G92BLjvp0UATUm3rsPrjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8126
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Thursday, July 13, 2023 12:34 AM
>=20
>  }
> +
> +ioasid_t iommu_alloc_global_pasid_dev(struct device *dev)
> +{
> +	int ret;
> +
> +	/* max_pasids =3D=3D 0 means that the device does not support PASID */
> +	if (!dev->iommu->max_pasids)
> +		return IOMMU_PASID_INVALID;
> +
> +	/*
> +	 * max_pasids is set up by vendor driver based on number of PASID
> bits
> +	 * supported but the IDA allocation is inclusive.
> +	 */
> +	ret =3D ida_alloc_range(&iommu_global_pasid_ida,
> IOMMU_FIRST_GLOBAL_PASID,
> +			      dev->iommu->max_pasids - 1, GFP_KERNEL);
> +	return ret < 0 ? IOMMU_PASID_INVALID : ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_alloc_global_pasid_dev);

nit. Just call it iommu_alloc_global_pasid.
