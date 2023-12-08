Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2555809E99
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 09:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573365AbjLHIvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 03:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjLHIvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 03:51:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6BB1981
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 00:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702025461; x=1733561461;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VRtvOlqPv07flVaupgljIgFnvRHQuk0e3KvwqR67hn0=;
  b=SPjJ92u4EfCr+dJBwY5LF5YdyYYf+lO7Sitztk2myBTKveiSl1w2Vn0L
   nSnRACIV43bWeehYKaa1hFIZv5rEOrapMiQkVMegl9qZwC8+BnfaoRg5J
   BNyo/t1aBCYHWWVs3Uy4kI57vt2J9XCi5nR9p+YvzI6zx9PXyujUbPx0r
   FmlbhnAaLcIet/XdDSbdVHsqXOApaQep3gkWrIkA9SFku0lzccu8foOL2
   LJeNhnBXe6yAA8+tvF5TiiivVUKAJwfzXmCoSgId+dOzVpsn8O86nlSl6
   maHAtemRUXIfL+6i0bmqMyGIpSrINgfVUGtO/+cOj3C1MBaoJE06f5hgZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="458689611"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="458689611"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 00:51:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="895462406"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="895462406"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2023 00:50:56 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 00:50:52 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 00:50:51 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 00:50:51 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Dec 2023 00:50:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVH28TbijglZauSin61T+wxCJ4hjGPG9TqfLqqmaUq2FPmTpAQafgKUJ3wSqRdcEqCGeh7ScFv6VMmLRoLNk3yt6aEg8OmRxN5Qii71V+qZRXY9O487taUxsmxMWXO6mEp2rBlfsSPoIKrLswYb3EYj9y5QeX0KCqqhNhZBtiaP0pdnFyxzoEslAM8TSyoY53IVB2BkcwVXNLnFTqupW3qdl8ywYMYFvw7UGZp1j84a+74rSm7ItOZ/Ga1M3fx7UhO2OlV6owHhV87rvi2Wge7g3kXYYu/1YXRViF08Sg6rwpYDuEjE/fV6Q5ur4EgBjemsxNWfluhSyAW/iFKa9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=my841BX3+tgUscuFa+baJsLIX1wlaULkCplECgjREug=;
 b=RBJFqdGgCf9AJtvtyiRpuaqUNVFpKTYq9kLdnDYMGg3tt7XU+D5GE60XWz9bcXIjtHDfMD05iC0shpt1FixcQEPcpFd8urmKhYcF1uXUI/OiGeF6wgjatmfCtDxdahdZpTIR039LpXUTNeuK1DU31/ioTexbY1bwuxd0gCgme8iTyrgC7465ne1qztEhK8E9/XFE147WPTXpMws0X8YOyoHZeoFqcBRbSvmfe6uXrBjNYBJa+lxEixi1B/95GcC+Wr207SkvcX40hIdpIiCkTFioQWrgkVrw36DuPur30tvx2trfMoVGq6BHWHAedXjVi7Vf9m5y0owP5vGkx4TecQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB4794.namprd11.prod.outlook.com (2603:10b6:806:f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 08:50:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7068.025; Fri, 8 Dec 2023
 08:50:49 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/6] iommu/vt-d: Setup scalable mode context entry in
 probe path
Thread-Topic: [PATCH v2 1/6] iommu/vt-d: Setup scalable mode context entry in
 probe path
Thread-Index: AQHaJxokPxGF/GdwxUyj9CpRvu5z47CfFpuA
Date:   Fri, 8 Dec 2023 08:50:49 +0000
Message-ID: <BN9PR11MB5276A5F34EA7CBBF026E264E8C8AA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231205012203.244584-1-baolu.lu@linux.intel.com>
 <20231205012203.244584-2-baolu.lu@linux.intel.com>
In-Reply-To: <20231205012203.244584-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB4794:EE_
x-ms-office365-filtering-correlation-id: f8c13d06-2089-440a-db71-08dbf7cac6a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B3Z4T2TPSGcwP0kkbxRS+cJxRNJciVNGHfHYYzNFzgHY0/wOSAbvEYewPvXSFFAvIDv5+Njtw74wq13GPygvh4gQMdL1jdNjorVLiGHxvsl4czb8mwF3v7wYbEp1tkiAIP+q9QqNXpEroV2AJ4R9xOwzMakUauW94UF0VfWLlpPcpYOZvqasW8qjqSqhE6ZagO+To994IObIHzbUOBcPY0Nr/cOrh0pTeiBlzOSpuIyJ30odn7TVGcM4+tKZJIHwkzU7dv/g8q8IbItoFMTTURy1skEHbFOvydJmSF3DcGa0OS5VKW8RU0eI9owxWo8qYmP/AH3xR3RMRpH/nG/FlIbNjYgUbY7xFUZqPczxyp/Xh8N9ol/LXUTJG1I2uZWw/ZYjyOeoaJTE5GjeATRMV0fVd6bqZGyfTE9jAHfaty3IXR278Ir2N2HfZGcgSrj77c9F4VjyFp0K6pw5i/o1Qdwei8LuMxn4HHDo6CyUwEN6sbSP23BYHbvI/Rmgown9xc8sM9fT8BekuFuVYZ438GF95AE7oDTFd0ZX3a0rJOyKe9McE71SKgPkRfaSCxRrrGGMbnpnuOgoJPjHStk6yqkugoY8BGZDX7J3AB1+m8v6gh6Cxcc0c8b5PSK9/3fN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6506007)(38070700009)(55016003)(478600001)(9686003)(8936002)(4326008)(8676002)(38100700002)(82960400001)(26005)(7696005)(71200400001)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(52536014)(110136005)(316002)(83380400001)(33656002)(2906002)(122000001)(86362001)(41300700001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f/adxINvmaaSDL4NwKfZY87NDf3jRI5NyBAep30elZYBQzSKG7r6SxON6+hb?=
 =?us-ascii?Q?LdTSQlXlXJVGN6DqBuPVBWEBCipCzeGCBmyrPxvMfVvl3tH0oXEDqHJa4ilT?=
 =?us-ascii?Q?lxTyig/wSO7dYvGzwUdy5dYaPpKwu975gvRkHVAe5P1lcTHLOJE2ZszPptWW?=
 =?us-ascii?Q?6XlpEbgLw8TfaRcRC8C3fdbQhD/fNTVVEyzwQ/kqvT9OtIPN6mbR7H5EhKbD?=
 =?us-ascii?Q?lAKALIIAcnx2wtsp1HsFFLfb5PnT6UeJ1RDGehK9O4xZScDgG0yfSVgR1Mrs?=
 =?us-ascii?Q?CiuQ/uM14gg0xNaxPgQEWOQ8TCy3x0KvsPwdQkN0J3CIEzWKveF6BBRdtdea?=
 =?us-ascii?Q?CnuuJsz9vVYHYs9FVXV6Ve+cruPTShnJHBi3RjtE2wZKleKVViUcVw0oUUnx?=
 =?us-ascii?Q?7E68iP2vPFpdUzoY2Rq2FX/Si6tjjYw5ijYuCgTYq9eUW3KnOpmw4Z4LYq/b?=
 =?us-ascii?Q?pYpG774HV4glJnjYqH72n6nGVQeWxtMGqUIImNyUNDjKNAdC8UVJoM7etnqf?=
 =?us-ascii?Q?nYtvss6xddp6jrKuJ8BjjeRUHadONZH/UaGg9363uAx8qrssNAC4iKmdZU2c?=
 =?us-ascii?Q?KacfGaTEsBvuWzp7ggot7nVlZVOHS55ONMZ9n1MTZAZddmTyGOH3MVVOjLPr?=
 =?us-ascii?Q?0wSU9jIolhi9M1ijKGz/ocovs4FKb/9cKfAQDAVeeLygvZTCRhUdL510qVG3?=
 =?us-ascii?Q?JZW3N7udeigyqUrB7N+FFOynlt7YnnI7pabqDOiL1tIRypdA96TBHqs8o3kO?=
 =?us-ascii?Q?geub45qgzXneSvjmLbf4QizhZWiyEQh3TRbPowj4rlJldGLSn5sM4UaysQSp?=
 =?us-ascii?Q?oftkhsfc/J2Y+TihTIpXSoPWEjO8w2D81rlV2iSo8S+UAP6RmAfqQXgn3EjK?=
 =?us-ascii?Q?0OC5GtO5HsNen8y0w/OlOsdzpfpi6uaUy7jAUyTJdtczbwCuOQuBbENfpNwO?=
 =?us-ascii?Q?B1giZ98pC3AIBHl3/SzfnMVGB6bAaWCbXKuzivUBS9vpmMQGboWnfKDI30Ys?=
 =?us-ascii?Q?g5IflJZDabDBkjWZtAuznrxBca5UnCh42pIEj8CTqZUkFNgzZb6Igon8AZV3?=
 =?us-ascii?Q?iU7pmHYEitB47friiZ/XfexlDE2Af21mPUyoB4s8nB7tekptGtSQ3ibOMxkj?=
 =?us-ascii?Q?VDGtVA7haa8AYaXt1Hu896wyYpaC9eQiyRL3dLOvxGekCCc8nY5/EAWPCb/x?=
 =?us-ascii?Q?5MGovKUAW8Vy0zKCcXojz/HSNsUeZgsbkPDoYzu3aO8+G3AEWRTgWpJnPKgD?=
 =?us-ascii?Q?GsQh7ZbQCWg2B8UJOF4K3hRKYvI36fjF2NDLUsRW/R1iBo5NDHGDEdhOu38E?=
 =?us-ascii?Q?ZkqiDIeOx8mv/lSML+orZ4qNcpP1LwnxWyUPIHZ4lMR90JoLW/Rll0iKIhzb?=
 =?us-ascii?Q?xo0TQPe7PaK2nMvR5frt0K1Kk3msSiyccehbjCfX58/XixniM4qcuXj1Slq/?=
 =?us-ascii?Q?5ijSqwyY//0ocSOow/hyuKD0KBPAyxtN8sFixeP/PImuXhemLrrzRDFHrQA3?=
 =?us-ascii?Q?n9PavFpHrZteFTXehgNL//LSuaduLtcwq92EYe6xKHywo9xy49E0Z5APVBB2?=
 =?us-ascii?Q?UZfmmz15ZJX7HgGfMA6rQNtRclFnrd+bjt4xjCoi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c13d06-2089-440a-db71-08dbf7cac6a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 08:50:49.0943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OjUxflOz+dkEX/w95b90K9F6QgsIFNBviJBvE4RgLKlwXykzzERwtd7zE4TYXfGDiqMj+aYpm6Q53aH3y7TmKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4794
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
> @@ -304,6 +304,11 @@ int intel_pasid_setup_first_level(struct intel_iommu
> *iommu,
>  		return -EINVAL;
>  	}
>=20
> +	if (intel_pasid_setup_sm_context(dev, true)) {
> +		dev_err(dev, "Context entry is not configured\n");
> +		return -ENODEV;
> +	}
> +
>  	spin_lock(&iommu->lock);
>  	pte =3D intel_pasid_get_entry(dev, pasid);
>  	if (!pte) {
> @@ -384,6 +389,11 @@ int intel_pasid_setup_second_level(struct
> intel_iommu *iommu,
>  		return -EINVAL;
>  	}
>=20
> +	if (intel_pasid_setup_sm_context(dev, true)) {
> +		dev_err(dev, "Context entry is not configured\n");
> +		return -ENODEV;
> +	}
> +
>  	pgd =3D domain->pgd;
>  	agaw =3D iommu_skip_agaw(domain, iommu, &pgd);
>  	if (agaw < 0) {
> @@ -505,6 +515,11 @@ int intel_pasid_setup_pass_through(struct
> intel_iommu *iommu,
>  	u16 did =3D FLPT_DEFAULT_DID;
>  	struct pasid_entry *pte;
>=20
> +	if (intel_pasid_setup_sm_context(dev, true)) {
> +		dev_err(dev, "Context entry is not configured\n");
> +		return -ENODEV;
> +	}
> +
>  	spin_lock(&iommu->lock);
>  	pte =3D intel_pasid_get_entry(dev, pasid);
>  	if (!pte) {

instead of replicating the invocation in all three stubs it's simpler to
do once in dmar_domain_attach_device() for all of them.

Then put the deferred check outside of intel_pasid_setup_sm_context()
instead of using a Boolean flag


> @@ -623,6 +638,11 @@ int intel_pasid_setup_nested(struct intel_iommu
> *iommu, struct device *dev,
>  		return -EINVAL;
>  	}
>=20
> +	if (intel_pasid_setup_sm_context(dev, true)) {
> +		dev_err_ratelimited(dev, "Context entry is not configured\n");
> +		return -ENODEV;
> +	}
> +

Do we support nested in kdump?

> +
> +	/*
> +	 * Cache invalidation for changes to a scalable-mode context table
> +	 * entry.
> +	 *
> +	 * Section 6.5.3.3 of the VT-d spec:
> +	 * - Device-selective context-cache invalidation;
> +	 * - Domain-selective PASID-cache invalidation to affected domains
> +	 *   (can be skipped if all PASID entries were not-present);
> +	 * - Domain-selective IOTLB invalidation to affected domains;
> +	 * - Global Device-TLB invalidation to affected functions.
> +	 *
> +	 * For kdump cases, old valid entries may be cached due to the
> +	 * in-flight DMA and copied pgtable, but there is no unmapping
> +	 * behaviour for them, thus we need explicit cache flushes for all
> +	 * affected domain IDs and PASIDs used in the copied PASID table.
> +	 * Given that we have no idea about which domain IDs and PASIDs
> were
> +	 * used in the copied tables, upgrade them to global PASID and IOTLB
> +	 * cache invalidation.
> +	 *
> +	 * For kdump case, at this point, the device is supposed to finish
> +	 * reset at its driver probe stage, so no in-flight DMA will exist,
> +	 * and we don't need to worry anymore hereafter.
> +	 */
> +	if (context_copied(iommu, bus, devfn)) {
> +		context_clear_entry(context);
> +		clear_context_copied(iommu, bus, devfn);
> +		iommu->flush.flush_context(iommu, 0,
> +					   (((u16)bus) << 8) | devfn,
> +					   DMA_CCMD_MASK_NOBIT,
> +					   DMA_CCMD_DEVICE_INVL);
> +		qi_flush_pasid_cache(iommu, 0, QI_PC_GLOBAL, 0);
> +		iommu->flush.flush_iotlb(iommu, 0, 0, 0,
> DMA_TLB_GLOBAL_FLUSH);
> +		devtlb_invalidation_with_pasid(iommu, dev,
> IOMMU_NO_PASID);
> +	}

I don't see this logic from existing code. If it's a bug fix then
please send it separately first.

> +
> +	context_entry_set_pasid_table(context, dev);

and here is additional change to the context entry. Why is the
context cache invalidated in the start?

> +
> +static int pci_pasid_table_setup(struct pci_dev *pdev, u16 alias, void *=
data)
> +{
> +	struct device *dev =3D data;
> +
> +	if (dev !=3D &pdev->dev)
> +		return 0;

what is it for? the existing domain_context_mapping_cb() doesn't have
this check then implying a behavior change.

