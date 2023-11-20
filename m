Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A34B7F0B22
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 04:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjKTDpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 22:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjKTDpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 22:45:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B254BB9;
        Sun, 19 Nov 2023 19:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700451936; x=1731987936;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vZfgIOE46oWk1DBrpLKlxglhzO7zUx+wf8M1D78X2Qg=;
  b=F0+LSox2H6CspE5FzQA+zcWgVe8aunk9rdPtcHgklXnGPbUOr30VJilC
   sMx+PYIO9GIBPoVTjWVJoeWdsKuLyDl25CTxsW6nQN9DgTEGA4wMFUv1B
   f7VQ94YVzoXu5JkKAewqGQaszALO1+pCCflxWdj+nH6E0KsbKr8+QCi0F
   f4D3OrP8iFMaaGcH/f1IuS37vbab59o0WnMh0cSTjOciSziNcQjbIdGK1
   dMKY4RdBOiA7IT5s8FFA/HpGEoNoQiMhffqAL/YgHMfstFnFUWTfohSBx
   S26oUn7DvIlgX5lonB9+AxCVY1pvqXMRBRl9lFx8B+atxJLxE554Ut1fs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="455866458"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="455866458"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 19:45:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="766134510"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="766134510"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2023 19:45:36 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 19 Nov 2023 19:45:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 19 Nov 2023 19:45:35 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 19 Nov 2023 19:45:35 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 19 Nov 2023 19:45:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiDicSmgWbzVCfhsCXuJw+xfR1xzGYCmzaJLU0we4TLFgH2Bn0DiIVtRQNyyrvGbIAgEE6II2Xufcz3ESKgREAwOi6uKJ7kN83xLVchHP2Qt1KmtEyjub1TVuImxKA+5AoPN2MHM0oixllVZpf6MyL6lBy6+eqJycq5X1njjg7WtEGrEOavVBqz4LqLItvIE+o3yNkYioHEgUo4C36Zx+0tNHqSyKXwIko3wNWr9V9x7dpIbygUGasl1akPhTf6ubX9/+IP26dlE/GBJgfqTgAC3OboBlUZlkJCCVA5iHVACSe61W7dsjwkWxIt38ctbfwUtjh9mdYKFYlhV4xbgNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d10aXuBIpAWRE65sp6jh6Rjb6AiSTjPzbFUFZGp3QWY=;
 b=LdkwXV3ZF2MYZ0anVBlQ6N/+KvkggEhxHaEv/1a3444OAdScaXVMoE/+MXZKtQ1UDmYt/rJaKZYwyqkLyHjp0Uk9U+fTSMl3UxQxC1gN7veuhSn4Ze8GmIA8XKqPoEJUHnf3iSPYPEGi9TpzUhG50K960eC4WvkYLaXwZUhuKSilfF3oAuc7QtFPC5na5b5s88evx4Le8xwhXrP8wpytJb7BZpssZD8x6pEcVfmeLCriFAOYKJcFvQMmCwRcYiZ341NFkK3g0r7BCvFZuQFKiZtCrw3N2GoarjrCyosC6q0cyfuH8Kp2HhR+EpuHAMSX4hZ7ajuBO3bkAzYWSCaZJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5415.namprd11.prod.outlook.com (2603:10b6:208:315::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 03:45:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 03:45:32 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Luo, Yuzhang" <yuzhang.luo@intel.com>,
        "Zhu, Tony" <tony.zhu@intel.com>
Subject: RE: [PATCH 1/1] iommu/vt-d: Fix incorrect cache invalidation for mm
 notification
Thread-Topic: [PATCH 1/1] iommu/vt-d: Fix incorrect cache invalidation for mm
 notification
Thread-Index: AQHaGTZydMt5bwtVCUafDdflf+2X6bCClLqQ
Date:   Mon, 20 Nov 2023 03:45:32 +0000
Message-ID: <BN9PR11MB52768C9149602718CD2EFC1B8CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231117090933.75267-1-baolu.lu@linux.intel.com>
In-Reply-To: <20231117090933.75267-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB5415:EE_
x-ms-office365-filtering-correlation-id: 9c6666b8-a4ce-4827-13c4-08dbe97b257f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PPVsDbG6KSErLiOpgFraTh9czWtFixoSS3wwC7D+7HbS05QSos61PCFjo8mEYbqmbCo84G6MCeIDV8tVIQMqEWj8dWThqfI3gOevGGQeqtquesaMg8w2wopIMjrnPXPt0IkBLbU1ZYzKhJiVlk8vboyV3Jh8ecN5vlJ1h0zcR5cELa0iHer0NIeIv1GCZvcrUz/3PM12AcfSADC9dp/FrngVBGyzT+kN7nyVTjj8Mbd3AEpmLyf7zJ5z1iPfO8eRRQFmQ9raCcZyYO4VYQuQ7WLyhZf51o2gXQArIWCfB8bFoawplcXPJWDMgWKIh+iQXgko8Vt68RYkvMzRl//WJ8/ytqn3pJmLkK5rrFsVxMKjiZ5zaWJ8nCMMqJN2fwa6LQiVMtai/ERy50jspBDvNKgVm+nqOncG4nLSMNGj/xxJc7EiO3fneCCZ8pFue0nwbh04R5H3nuFpxqEgThZSQNMOfBMTm9aIqFu5AvcIo4z/g0LCHYWQFT7CIPsYqP4j4cI51PFZTyiIEaSvg9LmWj4erXEEO+4VjL47ho9A0C3lTc8NrlPg3lmnONW2ntcEQyY5G236eVPkxuSKXIt/ZMdK2cgq4L/PuANe/SdPs1raZ+zlUWJhUA1LPtmQQCCW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66476007)(66446008)(66556008)(66946007)(110136005)(76116006)(64756008)(54906003)(316002)(7696005)(9686003)(71200400001)(6506007)(38070700009)(478600001)(26005)(38100700002)(82960400001)(122000001)(83380400001)(33656002)(86362001)(55016003)(2906002)(5660300002)(4326008)(8676002)(8936002)(52536014)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HpLT757oGJDIPQTJ7Ai4H+JP20laOMbT8gduD+lRdqUbuveIQYgmUk83pRIY?=
 =?us-ascii?Q?HSsT7WLg7Qiz8agXBwPjjyaZggkZn0jX/hV2MKnxzdvk89LffAN6nk2NAANC?=
 =?us-ascii?Q?A28QRg7uIF8NsCS1qXBx3oq6pGV0v78gqs3ATmDSIxpgZKFNBYr86TV0aBbf?=
 =?us-ascii?Q?rzyVML2wYyz6GV8GLtylA4E/u3AfhM9IQCtgyaS+4ZPsFCgQM8AS+ovAsDDK?=
 =?us-ascii?Q?4MVI2g2h8YPA03E6jbqhwYQE6pFKJfEdaq1nkVLHSdci8s28b7nwo7t71ZOU?=
 =?us-ascii?Q?fwt9rYsg/wspoSSKivZQ0nvDCh9JYKZyiFerr/e/OyacRYL8jHekcdrL+znG?=
 =?us-ascii?Q?6uOXMIYqiV5RvEfAxXDOOJqNbYDb7yWxTvc573a1m13o4duVp0RC+W58oqcQ?=
 =?us-ascii?Q?w03VsdWYLYg9zUq6wlBu5fAzpAi4n1bbujMN137AgTuW/w/Dv+YK1TUJvZLR?=
 =?us-ascii?Q?MENZ6neDLQ3JUtvPKUTz0i6VN5Zk2e+Bgrgf08BFUQsGGG/kn7STZ5gQCDz5?=
 =?us-ascii?Q?ZSoHXrWn4KvuHSeGdFm1iPc6TM0nbTmtL5ES6Xm2Jhgf1HzxY+gSY1QBRaVp?=
 =?us-ascii?Q?/6TAo+Mmkl3FTuFKv7GmCed11qb1NvxKAHmqy0EV6TTPtwoPC3p61D9iU425?=
 =?us-ascii?Q?k0te3oXV/w7o5eSLOBOYxcfU62fxa7iCuE9FTLkimpf3F6anl5kQIOIzp7Do?=
 =?us-ascii?Q?0gBfJgkV1dn6EK9ON0GGJN/tPdEgBG95FJTLnBd/O4TLY6LDuDV6Zmt6Nhfw?=
 =?us-ascii?Q?OVwh38VYvyFYjUtInceNF0Logd+CmNUqQ/1yvDA3qIBE4SkfKVMuG7ZUZYyw?=
 =?us-ascii?Q?gtRCxzGa2a9MIDdgCfOQv8felbjGjO9pW2Oel5ZsXOA0PeeZ9dC+SUQVYdWC?=
 =?us-ascii?Q?1dxyTdaMaiyb0TSBw/5K/bL+fQFALu5KJYzC605VhY5WYDKnaOKRrtc9r6At?=
 =?us-ascii?Q?/gRK1AyE8mc2rAURodyKZX4R+6dYn1JLqx+LK2xgoHTFDMDe542nl+7h3paX?=
 =?us-ascii?Q?4BSqPESfhL8ThQ7aeNmdrUNJibuMON+59FUM2oWxlt+bTN0V+nFeZvdfD9cb?=
 =?us-ascii?Q?tHjMY0WNLJgQeli2Sn2cMKUup3IZGeBX1WHgEyB8njkgr0r5aBpSXTL+7E1A?=
 =?us-ascii?Q?UiDec+JALkq8jyY9anOiKo/OAWR6E1YDAGKu/oE2OYE5XsxRQgrnm3Vu8Ghj?=
 =?us-ascii?Q?+4pzgJp1iJeEKzLUbYpp9gqgo2/LT7KLB1ccSZ98roL/ir8WoKJOfGM+fzff?=
 =?us-ascii?Q?+PcVFZzD00xOuj2/se0PgW8dslYZkLdOhYzA2aHaT7frav70UmugfEB/CMSZ?=
 =?us-ascii?Q?ijGojPciojwHJV4Du7D24QsjPSv8ANbVu5Cuj6W91DkI9Q8jcimubcE14bon?=
 =?us-ascii?Q?9xcmvu+PU/6xJjAU1bKKO2e2ZZtu/jr1w+EWNXICMQDKctuBT2DntXZe0p5q?=
 =?us-ascii?Q?7sZ9NXVe43+mZVERVq3INQ+PWUu7MALEk9f8hrzy7klB1SYI9BZAdzW7CL4q?=
 =?us-ascii?Q?TyYk74/5wFBRaYwkJlMjGIa00pVgCmYGCqSruvKPECb2O9ATF+SwLmHMpdxk?=
 =?us-ascii?Q?YaZ+l6Sjlk4l1h8Z0wAxEBfJNEiWHImJRSVngkEA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6666b8-a4ce-4827-13c4-08dbe97b257f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 03:45:32.1977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 84ZjPmJpubLFGbymM9sxg76OtyuaMh5H6F19v9eGcWYEWyHZr0TXoPu0/s7mLjBE6kRZyG5N8buI3d9VETjf/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5415
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
> Sent: Friday, November 17, 2023 5:10 PM
>=20
> Commit 6bbd42e2df8f ("mmu_notifiers: call invalidate_range() when
> invalidating TLBs") moved the secondary TLB invalidations into the TLB
> invalidation functions to ensure that all secondary TLB invalidations
> happen at the same time as the CPU invalidation and added a flush-all
> type of secondary TLB invalidation for the batched mode, where a range
> of [0, -1UL) is used to indicates that the range extends to the end of
> the address space.
>=20
> However, using an end address of -1UL caused an overflow in the Intel
> IOMMU driver, where the end address was rounded up to the next page.
> As a result, both the IOTLB and device ATC were not invalidated correctly=
.
>=20
> Add a flush all helper function and call it when the invalidation range
> is from 0 to -1UL, ensuring that the entire caches are invalidated
> correctly.
>=20
> Fixes: 6bbd42e2df8f ("mmu_notifiers: call invalidate_range() when
> invalidating TLBs")
> Cc: stable@vger.kernel.org
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Tested-by: Luo Yuzhang <yuzhang.luo@intel.com> # QAT
> Tested-by: Tony Zhu <tony.zhu@intel.com> # DSA
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/svm.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 50a481c895b8..588385050a07 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -216,6 +216,27 @@ static void intel_flush_svm_range(struct intel_svm
> *svm, unsigned long address,
>  	rcu_read_unlock();
>  }
>=20
> +static void intel_flush_svm_all(struct intel_svm *svm)
> +{
> +	struct device_domain_info *info;
> +	struct intel_svm_dev *sdev;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(sdev, &svm->devs, list) {
> +		info =3D dev_iommu_priv_get(sdev->dev);
> +
> +		qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, 0, -1UL,
> 1);

Why setting 'ih' to skip invalidating page structure caches?=20

> +		if (info->ats_enabled) {
> +			qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid,
> info->pfsid,
> +						 svm->pasid, sdev->qdep,
> +						 0, 64 - VTD_PAGE_SHIFT);
> +			quirk_extra_dev_tlb_flush(info, 0, 64 -
> VTD_PAGE_SHIFT,
> +						  svm->pasid, sdev->qdep);
> +		}
> +	}
> +	rcu_read_unlock();
> +}
> +
>  /* Pages have been freed at this point */
>  static void intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn=
,
>  					struct mm_struct *mm,
> @@ -223,6 +244,11 @@ static void
> intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
>  {
>  	struct intel_svm *svm =3D container_of(mn, struct intel_svm, notifier);
>=20
> +	if (start =3D=3D 0 && end =3D=3D -1UL) {
> +		intel_flush_svm_all(svm);
> +		return;
> +	}
> +
>  	intel_flush_svm_range(svm, start,
>  			      (end - start + PAGE_SIZE - 1) >> VTD_PAGE_SHIFT,
> 0);
>  }
> --
> 2.34.1

