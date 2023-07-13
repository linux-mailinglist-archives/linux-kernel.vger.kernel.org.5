Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C04751A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbjGMH5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjGMH4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:56:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DA82D47
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689234996; x=1720770996;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PJjlo5uCr8c/6n7VOBsIuze4UqKcMqEH7LTV3ex2aCY=;
  b=LrlhnIK/YYnGtmK/32Cb7QOP90qNxyUonWhwRzR/3dcL85G6Oevxe5ob
   CEccYVzzr1B1t/BWrHKiRrLXWcqZCMnJBuy1GeyAcczytFWgRtzkkDopD
   gTihilyoK2+cZL3JW5czhQcfpZrznnWR+MWknE4YUsYL+eYw0U2tQySUy
   9wxvbwvnfxbKON45fYkmEckOv6drPZyvKqerwrG4Dgrg9g7m8QUWdM2km
   QLITyrKBK7tr4swQesneYrmsWqkWU4fGCW6TRZ0ihq8Qzl87LAcic/mrB
   4o9WyaMD7OLXUrIK1xozhRQUaIRnjjXDDmPZ0WEG+eRJYnT06iOGgGa9y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="362585035"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="362585035"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 00:56:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="751512274"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="751512274"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 13 Jul 2023 00:56:34 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 00:56:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 00:56:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 00:56:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZ+tsxGtcrBxq/0dOTVGgFe2zEH4w05p0YPmUKSSWgIOJYkvq/v10mhsPpEQ8cr3iZ/TosIPMwxXVn21oalmuvSvZXSCjbCZNHKRLAo9aW5HF1wFl5zaAEyAjws7c/V99nSdbEemcp9JeFAO698tPEd5h6a+QhcQIaDlaN7EQDYJGVD87bySn/v2hj08/GtgFB0PJSUwGu4zSj4tmWaXs2pgc0SQQlVDi3/zg+cl4rTTDbGPqW9LQZoFYw/4Hs37bf/OOBjWuAlsG53Hix2DihCRVozBVSzuePhkorrzkxegpZOMoYuF+GMujRpejMUYyzGoUMVhZihn1llOKaUSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCPx1CGQ2Ea85MrRQNEbRnGwJunY3ou9hC/k624MmeM=;
 b=J6pHhqJKM2gTgNYOeJM4Oz8QR96rnl+tH8UW4cr9nno2Rqvz1tf0euOysfMv997WAu2v9+X3iNDgs6Gr/PurOc9BtIIlJn0F5zprIKUUA5yYwVuSyNAfeKtFwvPJE5Gl0FICTLJ/AgPb7o3OsqriwhZG62qoeYX3MsmlshzbgNp2unQeiSjaQ1G/7aNolvR/dvqxX5Sv4H6KAE409wrl6B3TNaoRp1lBwUSv9lC/nGXrUSYhhk4Eq/FFP3OSF3zPNK1chvljbmMLyEYSfjLMBGwCybNmu70d4aeASJl3MPyAkQrecxzIYP19b1cD4v5e28+gj2OdZQJg+LhWY8vwgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5816.namprd11.prod.outlook.com (2603:10b6:a03:427::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 07:56:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 07:56:31 +0000
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
Subject: RE: [PATCH v10 6/7] iommu/vt-d: Add set_dev_pasid callback for dma
 domain
Thread-Topic: [PATCH v10 6/7] iommu/vt-d: Add set_dev_pasid callback for dma
 domain
Thread-Index: AQHZtN38PCDm3MU1mUGnhonJfEjVea+3VKSQ
Date:   Thu, 13 Jul 2023 07:56:31 +0000
Message-ID: <BN9PR11MB5276C14341AC7CE6D352948F8C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230712163355.3177511-1-jacob.jun.pan@linux.intel.com>
 <20230712163355.3177511-7-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230712163355.3177511-7-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5816:EE_
x-ms-office365-filtering-correlation-id: 025c07cc-4d78-4fc3-9367-08db8376abd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rx/K1EkiCb0So9MAC0rgd28KDXJaYf8ds43lucF7Rz5E00+7cRZDgic4qXAjNz/3rrpEedmRTfzmZGvCKrxOy+T45qF5MtMZ+Jj/WKkCtFaX6I0c5lTD8fnXhilq/puc8UwlP2r8//ZrfaEApmsWO+/B0mhh/GZI4KJkqwwt/6bZn8B7C6ct7yTErS+p4W80K1fukgaS6pDNeLOn+k2ZPVSydVlUCtkcmrQK4hcM+BtZzngDZ0XCU9pUmDgOKOm45d+OD4VmpL2XGMMi19yPPBJ2Nfhutbk420D51UvWT0oVoELKvKo2QXmseeMBYCf4++FWUPZyH6e5WCq5iol00vZOwaESxvF4lxGdbf1RYaPWX79Qh1qRpZTPRB1fVP7251zk6vd36pYBuBoylNYaUIHvhSkNVQEDx20M5pmgEPxR/Hm71S0hugi2IHOXijfqV5zoUQDIKmpZijKOXvXnMSAWfuhUbY1rbFDOA+jym3Tr47Muz9Jd1d5jSKJUnHBxBVcR1+mZi0VASGWL5Z8bye5S9agK0tA23NQhotKM7+0BMdURh2Na3ZCs9G+RiSPiyTpQm9Q4QrAsX5bpdE1YSlRPTfbjTFJJ8rH9CiFpM/oM5sS3g5QXLa0H2EE0H0D+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199021)(7696005)(9686003)(71200400001)(33656002)(186003)(6506007)(83380400001)(38070700005)(86362001)(38100700002)(82960400001)(122000001)(55016003)(26005)(4326008)(64756008)(66446008)(76116006)(66946007)(66556008)(66476007)(41300700001)(2906002)(316002)(52536014)(5660300002)(8936002)(8676002)(110136005)(54906003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8OXL4mpdEr2zNMLy7nQBP0SsmVAnKweT5wnhcsK29DtCRwHD4PwlYVwORXzn?=
 =?us-ascii?Q?6KHNpkTIuovL2vWJW5ilbHnxV1+aP3wpL0LBE6SyEtlfmqW0L8uuPX9Il8nj?=
 =?us-ascii?Q?3SjeB4TjIWfM/d1en0kwkEnzzCSVIp2ShT1LeyN2fgiiT845KEU/TWaoPdel?=
 =?us-ascii?Q?WmEJYfJP4kG3F1w/Xg+PK2Q9ttYbovjlXn2XzULPvQikwPGF1lXiYIEYpN9U?=
 =?us-ascii?Q?pYhGmLbDHtEAepk4RY1mG7ddCWH27hhw4w+aYe/6hy9lesCiAQk67DXPt2By?=
 =?us-ascii?Q?hzoi4OEP1zyrKW1BpJBwEMA96Ovns7FLZtajjjj2rWQsoQ5CfzmP3WJp5W75?=
 =?us-ascii?Q?ARWpsrHGfrN8uYS4yC7wZNqc8qA6PGSG0o+g7HY4jKs9extWCQ+fNhI5m8n6?=
 =?us-ascii?Q?mBrlXU9wXkZsmz9ZyIGe3FYHLzYFs86+ctZ4ICKy3oo2EN0DviQFVpCl7gym?=
 =?us-ascii?Q?eySbAKmedzKoaaAkclxjhXtEAluikxDmZqMbAJpdV4G6bJDUOY4FdRMTGM/1?=
 =?us-ascii?Q?9QzF8qaBURVnqGMlXOfpGY6o0/lbV86CVBZsqTHOI2boa9AC0APpiOH9dsyc?=
 =?us-ascii?Q?EjKMIsquUzKvyScEQYqgpc2sOYa9qB9uPd8hdiJE+4Coug62jLO+dPDMwFqq?=
 =?us-ascii?Q?352UrBXR36pUjWMBuaKqz1fu+cdHouA8G3Kz6VQ9fWyUL1YS3QrelkJZkQz+?=
 =?us-ascii?Q?JRUbqkazQpORYgEWjDEVHgwVduhTBOI8mozKwbEReOlZWAkTy7USyy3GJVQs?=
 =?us-ascii?Q?Uh18ilGc8GPY2HDfgehzFei4EH8ZHVC2UJhDNWcV/rmv64dURJNG3bXD6QLr?=
 =?us-ascii?Q?ijmySCWYHT6Tte/G8GTR+V+YAXPd8GNh5YQkrb7KfQMxdok5CjoItidHlmF0?=
 =?us-ascii?Q?DPBYQ4QbQqegrcOH6ndtcyCiRkPewD9mTZjaIpZuQ4/yQ9FFA7E8hll4XScM?=
 =?us-ascii?Q?rhRkcSks8lW5wYuMRUtVzqZgw1Kzzi8QVFNweYwqPOvbXWF5/C2QFq49QM43?=
 =?us-ascii?Q?j0VBwUTuMcuS2Jn36RDqEWiC/npqMI5C/vn9RnOShE/W8tWpwoQ/Ur/vdGND?=
 =?us-ascii?Q?YU9h9BaMiRcZivTmMD0xX4fLjExu+ZLk8TA+TNNwUEDihloSvom98TlhE0lz?=
 =?us-ascii?Q?pOKM1O2DhK98Cd6voNrf/cgoT2v/wM61UGkMPnVuGv7H2Kfma4TTKPCFPSeJ?=
 =?us-ascii?Q?ap4SITMg63xsPN7/1ubNWhzj4KdAdfbJx6e8z4HkGOctghJniyGAkKU+RcuT?=
 =?us-ascii?Q?f14XrMHSINgs0cs48NLiM5C5M8Ttjul1Q/M24pXvrVgpvjW6/a9gAAWbxbDN?=
 =?us-ascii?Q?ZY2VikndujtI/hsR5BuORzxUgqueg2aGihCjNmoyG38iipKgFgARaS2lLBN3?=
 =?us-ascii?Q?U3JOJTp8b6Dln971pA7GcQuPWpt0kChS4rj0m3acIJe1M+a453kyxm6H1Wxq?=
 =?us-ascii?Q?yFlYda14VKOpDvAn6gSqFLioV5v3DVsBOl8xblvgxO1l9H3mLJ/qOKg+PyY3?=
 =?us-ascii?Q?a1V8EaaFAWSFGLyQ6WyRULSYtxHPNseRH2+ElWE/X+FXcjv2JPzbMrwQTkVU?=
 =?us-ascii?Q?jwnyTG6bosoVQEC3UM861GTjzUOi3QMP5lEA6vz5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 025c07cc-4d78-4fc3-9367-08db8376abd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 07:56:31.4877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K04yV160vemBXAgptXc5V6CID3f57Z2q65sLPjzxedqhzWyNBvEuc0jMfpHzCQni2YV8/tz+m1du3lgD/cZZVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5816
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
>=20
> -	/*
> -	 * Should never reach here until we add support for attaching
> -	 * non-SVA domain to a pasid.
> -	 */
> -	WARN_ON(1);
> +	dmar_domain =3D to_dmar_domain(domain);
> +	spin_lock_irqsave(&dmar_domain->lock, flags);
> +	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain)
> {
> +		if (curr->dev =3D=3D dev && curr->pasid =3D=3D pasid) {
> +			list_del(&curr->link_domain);
> +			dev_pasid =3D curr;
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&dmar_domain->lock, flags);
>=20

what about no matching dev_pasid is find?

> +	domain_detach_iommu(dmar_domain, iommu);
> +	kfree(dev_pasid);
>  out_tear_down:
>  	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
>  	intel_drain_pasid_prq(dev, pasid);
>  }
>=20
> +static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
> +				     struct device *dev, ioasid_t pasid)
> +{
> +	struct device_domain_info *info =3D dev_iommu_priv_get(dev);
> +	struct dmar_domain *dmar_domain =3D to_dmar_domain(domain);
> +	struct intel_iommu *iommu =3D info->iommu;
> +	struct dev_pasid_info *dev_pasid;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
> +		return -EOPNOTSUPP;
> +
> +	if (context_copied(iommu, info->bus, info->devfn))
> +		return -EBUSY;
> +
> +	ret =3D prepare_domain_attach_device(domain, dev);
> +	if (ret)
> +		return ret;
> +
> +	dev_pasid =3D kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
> +	if (!dev_pasid)
> +		return -ENOMEM;
> +
> +	ret =3D domain_attach_iommu(dmar_domain, iommu);
> +	if (ret)
> +		goto out_free;
> +
> +	if (domain_type_is_si(dmar_domain))
> +		ret =3D intel_pasid_setup_pass_through(iommu, dmar_domain,
> +						     dev, pasid);
> +	else if (dmar_domain->use_first_level)
> +		ret =3D domain_setup_first_level(iommu, dmar_domain,
> +					       dev, pasid);
> +	else
> +		ret =3D intel_pasid_setup_second_level(iommu, dmar_domain,
> +						     dev, pasid);
> +	if (ret)
> +		goto out_detach_iommu;
> +
> +	dev_pasid->dev =3D dev;
> +	dev_pasid->pasid =3D pasid;
> +	spin_lock_irqsave(&dmar_domain->lock, flags);
> +	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
> +	spin_unlock_irqrestore(&dmar_domain->lock, flags);
> +
> +	return 0;
> +out_detach_iommu:
> +	domain_detach_iommu(dmar_domain, iommu);
> +out_free:
> +	kfree(dev_pasid);
> +	return ret;
> +}
> +
>  const struct iommu_ops intel_iommu_ops =3D {
>  	.capable		=3D intel_iommu_capable,
>  	.domain_alloc		=3D intel_iommu_domain_alloc,
> @@ -4777,6 +4869,7 @@ const struct iommu_ops intel_iommu_ops =3D {
>  #endif
>  	.default_domain_ops =3D &(const struct iommu_domain_ops) {
>  		.attach_dev		=3D intel_iommu_attach_device,
> +		.set_dev_pasid		=3D intel_iommu_set_dev_pasid,
>  		.map_pages		=3D intel_iommu_map_pages,
>  		.unmap_pages		=3D intel_iommu_unmap_pages,
>  		.iotlb_sync_map		=3D
> intel_iommu_iotlb_sync_map,
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 6d94a29f5d52..68bb7cdf5543 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -595,6 +595,7 @@ struct dmar_domain {
>=20
>  	spinlock_t lock;		/* Protect device tracking lists */
>  	struct list_head devices;	/* all devices' list */
> +	struct list_head dev_pasids;	/* all attached pasids */
>=20
>  	struct dma_pte	*pgd;		/* virtual address */
>  	int		gaw;		/* max guest address width */
> @@ -717,6 +718,12 @@ struct device_domain_info {
>  	struct pasid_table *pasid_table; /* pasid table */
>  };
>=20
> +struct dev_pasid_info {
> +	struct list_head link_domain;	/* link to domain siblings */
> +	struct device *dev;		/* the physical device */
> +	ioasid_t pasid;			/* PASID of the physical device */
> +};

the comment for dev/pasid is meaningless.
