Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F096809EA9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 09:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573392AbjLHI5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 03:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjLHI46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 03:56:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E90B10F7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 00:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702025824; x=1733561824;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+NQPrtiQVoYdYVl3osD248WAnUXraC/S/F21nt55neM=;
  b=QdX0jhjmFo1Kb0e3t+1M4ioOAf87kK3IvVr290KIAuRM01MxSgXkZMik
   2Ofb5M1U5WdaPti/L0HjHkDcGAVPlYb9Ui7OPUoLACNvAvCm+nQzmlgFz
   4AVLkn29jPcCDj8s05YS+GBi6Kfsu1fLW/Pg0DU9fdXlr/MoORuhOSyYY
   B7IXImHaaHGQqEz+Zj0qHgULGpzvW9rHFcOcRUzUOMsLBV//vExGpr5lw
   mvYiW0yCMg9j+JUD8F+AnFCPNKI4UZRx58vb1Ox+B8fE7jyQnS3KbyKUA
   GiXoM7leQJZMOn4k57oyaxwjwOljzoNybg9/jdEau7zgb2uUCYNDQZZ6g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="394118463"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="394118463"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 00:57:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="772067152"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="772067152"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2023 00:57:03 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 00:57:02 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 00:57:02 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 00:57:02 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Dec 2023 00:57:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQ1zTCLnUkFYf4ctVrlqNt9fJQYLi6AkVAANO0D5/z/CWTjpfMIZGiV9hLPhlSpxUx+x6yCu7xxDNvuNqj8KBQiNf/6Abh1McZ8HnnxK8FfsjjngvaxNl6rpU/te0hJPkR6CdxVCoGzU7MZuR7rSDVCQCoStEmiJKEpv9gTMpUjiuBIKkZRJKQgV/LAi/m0mCw3+4i7ZiRIS5Nq5vsLhzKSPFtTETyJBYksYGqnRx3i1SvA5tO3BNg2TCawKL6YAa3pipfIo9L0RrPbdF5yvT4SnX/jY1g7LB5lQKAbF91i2c/A+e0v5u+PeDEQMWbXekdnUdIhTRA/nhYsqTCgkog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgL4GyviJ3/tQ08hbkOBUH6CQ04JsdTr4yfJACkZrow=;
 b=oFtmIs1gQCyKvCLQg/GStGRarnCXcucXRo8rTf/9RIkhZNL9x9ZUm0+5JMHDYqZ4K8e0Kjwsw1XAL+cqdlhzex4J8gaV2aOy9r1qYTwj2a259g6piGcu+2z+TA0w6TYDh/w2isSDrUV8NUHI71Fcckn1p2wbZF3pDUOucu84UmFyp3al/CjOEAEMk9da7c6rr20Bao4F0seBzbdlxOEVDwcNIRG8z7NxlL/qGk3OXsoSp3qj7MIgg08VenDYzZKsQo7R8yCpLffZuNyFC4YWS9Cvgv4AWvl6AKn+xy8eTrzf6BOgNngqyXlIyZDG/EtzpoQ2xhAuLQnwgYm8hnAKjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4888.namprd11.prod.outlook.com (2603:10b6:510:32::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 08:57:00 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7068.025; Fri, 8 Dec 2023
 08:56:59 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/6] iommu/vt-d: Remove scalable mode context entry
 setup from attach_dev
Thread-Topic: [PATCH v2 2/6] iommu/vt-d: Remove scalable mode context entry
 setup from attach_dev
Thread-Index: AQHaJxolbx/4QRtvTESJCUSpS0ZhzLCfGUaQ
Date:   Fri, 8 Dec 2023 08:56:59 +0000
Message-ID: <BN9PR11MB5276C76349963BBF68307FF48C8AA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231205012203.244584-1-baolu.lu@linux.intel.com>
 <20231205012203.244584-3-baolu.lu@linux.intel.com>
In-Reply-To: <20231205012203.244584-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB4888:EE_
x-ms-office365-filtering-correlation-id: a3e305fa-071c-4189-2fd8-08dbf7cba37b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PCii+0hu8+ieiPoZpo1/aA1UunyxMBxAhZFjcQPfTuDMw/7thyJgpkKwxDDPHYEeUtFXKHXs7BDwRg0Q076OUwyCNwF17qTxnRDHA5ZmvpyN8emndH0yfxE4XJ2tVqx7eV6oSgqCJL70CJGOpVd7BQXbpAebAQhxNyekZin5MbSOsUX1U0yF1+ZRPd4Vb8vhijIritKVBvTG5zPWrKPN0JFbRFYxbM2abbW5HNd0YH1vDdP4INIAnvIG6CxzsiBSBTTDo4Aocz+p3/EJRT6Mm3V3sm3faPklZ6SHoWlaj15GWbFMgFc+DqQARn+mjXnx2x+lo7rEVvnMuLCyIkFevZRLFkw6qBVYsK6hcpqprPcm34TXiVQGFdBj7Vdcs/sLhbgBLb312mHg/e81u3LPGqu0mPcOqavIhbwTH9pKctQIAX1mN1D9CtDEXxJcchGOO5FECVuFcZ3SGq0oDG5mhvMYgsBTAoG5S4PUM67e31fc9nLpgM7zrqVU0SnH4KQ+s9+1yD68w8ccLtV5WoEqmmhnRp+AlEIS71GnQDHvpT89zPizx5i9D8yeeyd5nuplHXxO1mQPR571A2593JyWTy5XKTM/HGf4dd9UhJu5/fCRVveEZNvl1vP/EkzKlGaL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(366004)(376002)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(41300700001)(33656002)(2906002)(82960400001)(38070700009)(6506007)(9686003)(478600001)(66446008)(66556008)(54906003)(66476007)(66946007)(64756008)(110136005)(122000001)(86362001)(316002)(55016003)(52536014)(76116006)(4326008)(8676002)(8936002)(71200400001)(5660300002)(7696005)(38100700002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1IAkJRc8Pl/Dil6NxZSBTmxeTFDLmHnC9lpWvgHwSiQnLIuFk0zcsr0VRTQA?=
 =?us-ascii?Q?TG2Nite+37n8fgVMM7mogYYesgvycZRTDiHPRp/iHzCxI6gTSDi98OooOfgI?=
 =?us-ascii?Q?/12OwVykBvZj8WsQNX5hTgdYtIpSsksv1d4gzd5KCArXnbrIdSMUq+EWxR3g?=
 =?us-ascii?Q?z/QnU31dDLqLqnTaJ4kxPoKuY+dYC1NGSKtXdx/pWVtUzcpWVgMoCZEo+NVZ?=
 =?us-ascii?Q?sQeUI7Zvp11Saws6YLNW5OaYBTDhIMvfdhA9WL0DU0GeJCBlS4TLHa5QcdGK?=
 =?us-ascii?Q?Srv88R9CqivTHN/t8MfhBW+UD7J+fyzwPtc9Ht+Ccy1Kp+unAqOxrw2H9w+q?=
 =?us-ascii?Q?lbT+vQnYCkCoo6OmlMWVcJ9o5LuZtmE3Vy32Gbr/OXRaVFQY4JUoKUXG2pSM?=
 =?us-ascii?Q?5eKw5tpbrP29lB0St5vSUsJa4vzdeoQcUTgQiQmMIKC6lZxFw9U3vMEp6XqU?=
 =?us-ascii?Q?qcyVLrg/O2muUWNer+8JUpO7AF5zQlk6QXthZN3CDnzECptrHQneoJDOKxNn?=
 =?us-ascii?Q?qOocUhffNpr6dZQOVyF7qTUmZDKct8hBka1PwSDisW/XSyfVYDrBG1WlBr8c?=
 =?us-ascii?Q?DkDtNGLaMwUgme41/Xr/ZUKCmQ3CK6KYZ274YWa/1P/pKjUi5b+ix2BP1g7e?=
 =?us-ascii?Q?qdxFMmE28nw70aztfHxbLxgpixA8ZNoCZhA+OEwYM6+WBVEQ/yoc4KlQDruh?=
 =?us-ascii?Q?05nS18eyH1y6o5SbHit+/zPAdl6ySfiMCUCpt230y80FpSHOn/w1A1IsfOaf?=
 =?us-ascii?Q?O8GHcmWUyvwAuishVrSUJrjwXO5ZM0u9LyyBth6px/UbvGAhXd1DZa62L/xV?=
 =?us-ascii?Q?UUBP0n/Ae5PbVOeeN6WV7rIPg7dW8ZnyJ65SXx2Ow753RGjICfCsyKvvk7aQ?=
 =?us-ascii?Q?5FhHj6zHbkyeGlqvEHkg7ZAAp8wHGL394pK0qxWRDOtO+WvFfH6DcaYmOymA?=
 =?us-ascii?Q?2nqXWHbcXvjIvvHNwpmNJwU4EQ60ABLuITB20hmxJrK6sDf/0LbGhDleyP/B?=
 =?us-ascii?Q?p+zOs9Fr9VzRwn9v59srpEstw0b3ylgchhR7oOuLUJniMgIZip9qIGqFDlpD?=
 =?us-ascii?Q?qUHe15GT7M/5hLLhlI+BrOQsDOREXJx8DL4C6Uts0BMHDg7NJHKDTyuj8fxr?=
 =?us-ascii?Q?V1xV/IBmDdczNNSruk7H+XogznM+IYR3dpyJIYyHSwb7iKJGzOPpvNU9A6+f?=
 =?us-ascii?Q?zue4JfQ/3lJFkeiyc3MuLhcMcTbJTXqPBwjmZa2bVpv23a6O8PaNG36qmelI?=
 =?us-ascii?Q?2unGn80KDIkM32xLPMFnijOdtYRr1UUPmm2pR/19FklA65ljFONKpjq3QCZ6?=
 =?us-ascii?Q?BUnvXSe6OHxtHLQYVJYacD4jQhO7xZdHVvqI1vidYbgpTDsfmtX44kQrPc0W?=
 =?us-ascii?Q?OGBLMs7+I8F79QHp4CFGkTyCK9SGrakDDGVUmYPVSYOQv1oxtnaz8F0GaGRz?=
 =?us-ascii?Q?mZ29lRarTl2HY1EwUiYzGENClLfd4WYpuUJbc3gYXLzQsk8fhFMmTFoffqVr?=
 =?us-ascii?Q?CDmMvhgKiqTy0p1sHFtphFRcxCQZB0yzl6xhyxou+ZIzwtoqqIJGd/61rKgn?=
 =?us-ascii?Q?RGJAUOWA6ozxkK0OlRYJSqVoD6lB+We3k8SNe2Qp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e305fa-071c-4189-2fd8-08dbf7cba37b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 08:56:59.5855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Wdw4R3OWnrqKLkf54/puSburXGKa/ZDB0cazvq97ctNivqpDv2HPWeMjC4yxEv+aGjF3+iIzYUK5k75ZgCYJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4888
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

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, December 5, 2023 9:22 AM
>
>  static int domain_context_mapping_one(struct dmar_domain *domain,
>  				      struct intel_iommu *iommu,
> -				      struct pasid_table *table,
>  				      u8 bus, u8 devfn)

since this is called in legacy now it's clearer to add a legacy_ prefix
to this and other related functions.

>=20
> -	/* PASID table is mandatory for a PCI device in scalable mode. */
> -	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
> -		/* Setup the PASID entry for requests without PASID: */
> -		if (hw_pass_through && domain_type_is_si(domain))
> -			ret =3D intel_pasid_setup_pass_through(iommu,
> -					dev, IOMMU_NO_PASID);
> -		else if (domain->use_first_level)
> -			ret =3D domain_setup_first_level(iommu, domain, dev,
> -					IOMMU_NO_PASID);
> -		else
> -			ret =3D intel_pasid_setup_second_level(iommu,
> domain,
> -					dev, IOMMU_NO_PASID);
> -		if (ret) {
> -			dev_err(dev, "Setup RID2PASID failed\n");
> -			device_block_translation(dev);
> -			return ret;
> -		}
> -	}
> +	if (dev_is_real_dma_subdevice(dev))
> +		return 0;

is it a functional change? old code doesn't early exit for such device.

