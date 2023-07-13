Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76713751A34
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjGMHqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjGMHqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:46:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8922106
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689234369; x=1720770369;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bx0ocSlg89ywHvvy3lJ68MI9SzshWFJOfFAYnX5CPmc=;
  b=fcGKNM81zdv+gCugb0KEBcKsv4vPMrDKo92GkM6/l1FirG/MTey6CjF/
   anXuLBQTvx5/OtTW58047ngQIa/yX65RK0ycskq7+kYhzRu55NKde0wm6
   3XDyCU4Akq21vXlCxERTGh7h9S0L5Rbck9KnOehSWp4sZ1QQkwnMNmyd8
   /OhOn3vJvNlSrU3WEu3aAB59Dq2gRN1KhTmZAsv4F/viX3CoTVOU9dUPy
   UK7v44PVp7hS8PxQlE6IwEVyojzB8UpWYaTGHHEZJDbfHhwpQpF3dClIM
   +vNLDBa3CJAoamf5eiUikRZ2my+i3euaWfdd28OC7VK4GV55PWe8o+UFz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="363985357"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="363985357"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 00:45:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="895909521"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="895909521"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 13 Jul 2023 00:45:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 00:45:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 00:45:42 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 00:45:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjeDC46T5xaxEheOueMACjsX4j8b39g3vGxhByuJYBLKR/258AZa9DRUzc2AtoPmJClqoNtjahQu39m1Oey5mNJG2l8YsRMIKPyX7uF0YgYxfM/r9/fSVj9QB3605zKSKc/Ij0QqJ/ieXwfUt2q50UpD3xxd5JC+E5d75iRv0y9r5/IRJuPONSsdhjV83ytu4FrI0UJYnZl/7TnXfUdHVBI1zG81FOw8L49QL8SnDdOZ3nNW5AWVtxEQKXhjrQbEXa30yqx2XjXCpzOOVy4N5rvVVlxIAkc2sZ1juRkn3W3kAolWLgOGc8wFZRlrfWRCq/1rvWwLjfsrZNcX3FYkOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YJoEj9qNC1qpQj2q0oQi5s9KzVq0I2ULOfoB7Kf/7c=;
 b=PVr89XEsdaaKX1vPnhqtotWdDZDet9AzyjFJ8gmh61RhsJ1VXtmIplFWbvMN4rIRJIayXL0LLQT11ZWQ38Cq72RJEdQbibLoEKGsBux/cV9cwb3ks+7R4T7KxUcR8In1PJQXzo9O0Co7MQZEIqlWJNkYFevYHZ7/Jcih4s6Md0tmiqXEjfnsvrpfFWDuiBPTjEnboqys/gf+mZQTSOES3OO+XN1MyZG22ljuBcyuA/Wzt3C2DoPS8YjqCWdob1IRfm+X6P+0lvJi4BNTh8qVbQsUCqs6nsT8R/tpfj27II0zbnCsZiVLk4O7ivteE6DdRwnST0+ns7C9txGNfqwwBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BY1PR11MB8126.namprd11.prod.outlook.com (2603:10b6:a03:52e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Thu, 13 Jul
 2023 07:45:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 07:45:39 +0000
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
Thread-Index: AQHZtN38FvvxAju+I0Wmp9YhFMGVA6+3UVeA
Date:   Thu, 13 Jul 2023 07:45:39 +0000
Message-ID: <BN9PR11MB5276E5CEC47C42ACE74CB9328C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
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
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BY1PR11MB8126:EE_
x-ms-office365-filtering-correlation-id: 529c8698-9270-4a11-3aa2-08db8375272c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dujRcwwbuwKnOj1RO3E/XiJYhuqhTbDCIzRGgS2aARmEutPvTtXjt8mCPj/yFKVRymmRxH5m58tKzn3/J7RDU2ik5du7KTWLzYenRIFap1qKilXT08B6OWm7NabG70pDBNFqlLAD/ymC+izqNI/NVTm6PnOD7Fthv0ny8i0Exy8GY0H95kyfx7eBLf/bAbAo/wH3CVruKye++NIxJy6RaOgz0jdLLTT17FXWcmTzOCrHbncXhKoEoox3ElwIDsB6kxWccjrL/SDqrmiBm085T+WJW8W+tnyMkM3x+FmmP4CGmVWRZPDuNBVd5rg8jpeoAoFDi+gOzrgSAMwmk1B0raX9WeQFn5AceyVOfeQZeoGUbTSAl36bTKbhcVimQyC4SqwEVhn9ht/EPIzKYP/6OsDXoV+lJRc22lZcoQpf6tppmeQOS5jWHmB0WDpRJusIiJakf1BCDbt+4P7jAESaF9G0Qu79CsDFxB85kMlA7Ika4J83Vu+fblsKF1y83Nq3nCYiJLVcfZemeorGvhOtCqNJd7B8FL71G3rMt5JDHXuP+cCuXyhMY4yKfVEgVi71kOCQm3bzITol0rwMb5xxHgDdTKdYl5kcTPjwF9xY2nbm6IoRaLzQowBgM2gHEW7k
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199021)(76116006)(4326008)(82960400001)(316002)(66556008)(86362001)(9686003)(66946007)(66476007)(66446008)(64756008)(186003)(6506007)(26005)(83380400001)(122000001)(2906002)(7696005)(41300700001)(38100700002)(71200400001)(33656002)(5660300002)(38070700005)(52536014)(478600001)(110136005)(8936002)(54906003)(8676002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k5/6++7rY3v/QyzFo3dHndKosvCb0bhpFb7of2EXPhOO+lBBn5uJDQEHPF+2?=
 =?us-ascii?Q?mLm2H/nU2ZaRGplfveJ7FycUIdpbkZFhmMo+C3qK2WSNbivaol9QMjvPBMLP?=
 =?us-ascii?Q?mzZ3MSYQHo1GFCypZm4flmY0HrM79sP2DBBGt1p26euz8TliGpAUH4Pb1Crm?=
 =?us-ascii?Q?+krGc6c0kzCLqiKRQ1ADUVOrGT5feRjE4H8EvpuGSWD656CeTdlD0d+LIpCC?=
 =?us-ascii?Q?eUX8aRT1ppbFm1zpQc1QAN34SnqLnn9RwECngfq4LGu57633qSYOQl0RGieg?=
 =?us-ascii?Q?IZ5XBWlMVZhZSoKDtEPRzOtS8BW1GuHLUn7YGlB/UfOYhEqnN4kkTqgBnOW3?=
 =?us-ascii?Q?uxJ7OPfMutesQDK7AmQ4U+QRhl7FqohHZ3/phggjBNXTovZVbSRc4xEsXyr3?=
 =?us-ascii?Q?EFDb6Hxh8+7Z8ndkrdTupuYBP1X6eUsOng66Smk318f7gv9s0DpnEd+jI7ms?=
 =?us-ascii?Q?xteTGwJNUhy1tn9xRZthqaJltZ2Z//Ix2982Sal/Xzm0BtFHU24d6p9VNAfP?=
 =?us-ascii?Q?vbfECeG47YOCWvzIPy38RmBu4Priuhl8AkeldNXMgLdcSoIiqbDSednsp7s3?=
 =?us-ascii?Q?8usTWcUYR0YmPF4fxsRvY6RKNtiWxaxDzgzqV4/OcBUXp2wF8Kv4WMd+2WWl?=
 =?us-ascii?Q?riu1mYYfrPqgRV1wiQKzrusYPXg0fjYMN2a6RSlz0vSA0XRXyAnPiqNCM9zO?=
 =?us-ascii?Q?6MLuuC6PGi0VVqW+MOcFX0hIrffq2KB+zLrvx63Wfgqw3ALZHW5pc90+bnr6?=
 =?us-ascii?Q?v8odJ0zCxfCs2jMTD3C2J5RRbohC1+S21n7XZ0KazDdu1N49lLJxt1rKqHRa?=
 =?us-ascii?Q?l72hmn9zwgAkaDiz9MwucEe9Y+tOnsrn24I8UEyYlIKECil+SvGy63hI7t+n?=
 =?us-ascii?Q?pmghwNo6DMpFUUZcBYlan4N6Bo9pWuy1YRdNjMzcKQiwcUNpndG+GUCfK18s?=
 =?us-ascii?Q?gPjCAKmvp/ckaWktr/6Wh5otdk5g1Zzw5Z3s8+uuwR4hCbzJKQdlcv93O7R2?=
 =?us-ascii?Q?DVlQ/E4Fxh0FrjY0JXeQ/BtDsmt4/E+QJOCRA+M+obfkENVDeelWM+fM7Toe?=
 =?us-ascii?Q?fyXntuqmdUqQ5/8MZO+Es2PPV3wbVrZN9CxelKan2GX5/IfzKdae/WMnvTJK?=
 =?us-ascii?Q?FqDLqKITrcxqDVKl19uzelfgbFqIwgsmsux4uste/NOlJxCNrB4vo/37NU+O?=
 =?us-ascii?Q?tJWQLnxIMijhFHHjgbpKPHkJcNybD6FAgHdIkaN+3D52hmB6qWEz2+OLzdTg?=
 =?us-ascii?Q?t4ohXjVYpygFf33f8+O0uL/3m7bWU+7AvD7WVfqfd4x2qPkcRKXI24goPKsc?=
 =?us-ascii?Q?BWbMNY/Iu4/TqptBo/I72PBEY0q3hDpENRz+YVSMnwGtujtxWUlaM6qFpJ4J?=
 =?us-ascii?Q?XBg1Ms8vk8HFtk5vbCreTdH9lUJylIOKfPE7RkWYxhYhSFN3XeLzRX3IfHnh?=
 =?us-ascii?Q?gy8cLoK5P9axhVpcAsAJxDEjYm1EZQk6vtAOZmV6VGspBPkMa1iXaecWtRsX?=
 =?us-ascii?Q?TtwvMYX3xY915CUYMzi6EaXHRbjRmYTHXEc4xrUGWAzwiCMxbgWjesPQpaGA?=
 =?us-ascii?Q?Q0IgpHy2lcMNqBmkXh7zMv+sTgbFAEoCTIY2WoAp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529c8698-9270-4a11-3aa2-08db8375272c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 07:45:39.4415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dKeIiRP8LeLjQ9/OGAWWiL7WR+AxumuMRY5KUGjJkpITYIVmHRA6R2U1uU0tVQZADNDz2CO9UC6r+X4XM21qhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8126
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

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Thursday, July 13, 2023 12:34 AM
>=20
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> The VT-d spec requires to use PASID-based-IOTLB invalidation descriptor
> to invalidate IOTLB and the paging-structure caches for a first-stage
> page table. Add a generic helper to do this.
>=20
> RID2PASID is used if the domain has been attached to a physical device,
> otherwise real PASIDs that the domain has been attached to will be used.

this should mention that 'real' PASID attach is not handled in this patch.
Otherwise it's confusing to connect this description to the new helper.

>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index ddff43def3ab..40685cbfaf0e 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1467,6 +1467,24 @@ static void iommu_flush_dev_iotlb(struct
> dmar_domain *domain,
>  	spin_unlock_irqrestore(&domain->lock, flags);
>  }
>=20
> +/*
> + * The VT-d spec requires to use PASID-based-IOTLB Invalidation to
> + * invalidate IOTLB and the paging-structure-caches for a first-stage
> + * page table.
> + */

this comment is better placed in the calling point. This function has
nothing explicitly connected to first-stage.

with that fixed,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
