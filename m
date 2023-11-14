Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C2B7EA900
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 04:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjKNDOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 22:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKNDOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 22:14:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDDDC6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 19:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699931676; x=1731467676;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xq/v7Oolt2rWbaIZYkc80ktcVYUpSW33QfvQINs2MKk=;
  b=mqQDCErsdYN9+Ok5c+0+HrlRx+0gCjCypN3R5Q7Y30X2bCe5eMM7BfFV
   yaD/WBzERxn31/dLUlQ3dIbYd9xlLfADTjc3PFMiL+iY3QeZErcTDvkKn
   dSzxt5QxBeOXSsiYnsUoKY2VFgcFCX085YnF7Ew0vEyzj+kGgb9RhOGo4
   EzrWiY+Mgoj6yjpqiV4ThzBRP35Zi+aihNsrGPXegmxKEG6c7XMpUSlSM
   0UO8Mo5XUN92sjWOv4ynwwWqL3rpAjYXcElKYZt3pSeS+T+n/IEYVTPD7
   PPHUFazTG54Cp2gg8a9FestM/Havy5CAaKJdGdMr17VzhHgvqw3DAvIB9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="370763219"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="370763219"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 19:14:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="1095927666"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="1095927666"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 19:14:35 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 19:14:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 19:14:35 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 19:14:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9G4+2Fd3iWCMX/IrQya7HUxzU+OdjHJh4Ku6EJUX+7ntAKa9y6Ga+nyu/fPQEI9niWlJy0Gq/ksfJ1qKdrjQMqbT2HtT5EReOkejng/6Me4zdoGUCJW+9pZWGNrX2Kq33YTMe3hVxN7VsgmvlFQhue4kjq6ryHIevKNhcqSItrI0vGQJaaI1i7vH3rnZ2A1SmiS52IFoPyTrfIyxk8EcCoSkXHlWgptwPPQ4rLjMChnbIeckoq4F9iQjHeQGLEzTWU+FU3SSoBSUnvsd/6PQ6dz9sCjyhXK9XN4r2r7YIvlQCacUDXYI+IrSDv5TnLCUH2JORrIszVbQVuO4GJFmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eHWbk0EOth8W+Udx692a0WW/cxCTlJKPLgUMDwHmJg=;
 b=dOWvhyw0Fhc5JVCm0vI6CvVGYBy+HrCtCA5+FHLZBfHUKZHDPn7DgfNWWmzWML1xm16F7zQPrFFXsYCrsFlhJDWRYyoa1/cSYvAalN6wkJy6J0gbhrd/fTu2IuG3pXZEOIBFcFeWKE1uDHtonDqezYD8FFrN1zokiNvjgBPUJ7J0alqbUrHFQ3UqlW2ngZIxZO2eXemRxewPjNkHxbyvEfBvmM9mGqacZuTkKQxFmgksSO4ixTOqL7Ul+cSWEJ0pHb7oiVKEfeJZAGlXMzYOWKTr4lzaxdc9+HvXfvDL46UV8E1KNO554GqhMbJjfD+e6LsgG7cw5iyAtaGxDvLgbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB4830.namprd11.prod.outlook.com (2603:10b6:a03:2d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 14 Nov
 2023 03:14:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 03:14:32 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Omit devTLB invalidation requests when
 TES=0
Thread-Topic: [PATCH 1/1] iommu/vt-d: Omit devTLB invalidation requests when
 TES=0
Thread-Index: AQHaFpgA5wtOoye5ZkuI8htuBJqfJLB5I8pw
Date:   Tue, 14 Nov 2023 03:14:32 +0000
Message-ID: <BN9PR11MB52764263BE04AAFAC0907A8D8CB2A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231114011036.70142-2-baolu.lu@linux.intel.com>
In-Reply-To: <20231114011036.70142-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB4830:EE_
x-ms-office365-filtering-correlation-id: 1fd15c05-ee22-4f76-3ed9-08dbe4bfd2a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wZ4W6Z8JjS9EoHu7DD2YBgMakPG5xKdo0lD6NId5S6g+JN36I5BFJ1eiAVF0Pf0fjDc80A36UgnVeT1SlacchhDqzWT2gZlyIFi1STuw+vCzcHs+pMpbZucL2HVipi+jVT1kPTURkvycMw5uh9dE2qC/k5LhmSCW8q7Yh42R0UdQRBzqv5wguRlx4CKQLcyeaJJv3wegbZsmNq2yBKiBmTJWkoB76Bdja7G7DlSw/o+wCNuWWWKOizzlObrCnckbb1o3BYC/+3Yr9mYoepg3KlkTtbqPsANLy+QAT84TPUfVux/ZCFb0OL8phbHvKl/vd52OjJhHy5jWGtAi72g+F/4wKdqJfraJup+5MBOMiYhRF12vvMyAXJlBPu2DTfRd5ko1NuCn+gzKt8hnQVWGRujgwiMkRu9QYnTuRnuAL5qZ7OpbRoiWg1EAn9NzncIcYgqO4h5ZitRelMm3AbhpunCT77a70zKUKocfAmd407CDrJogFFCyvwiTM7rBJde8b4REFVw5eIw9WMPsr7RhLM/dlbz6pp6kOdLc6VHmeD8EgRFTFodUCkYJd/KrwT0/nXjBY7oNzdBcUok2q+iGAFU6Y7lkgutNrfvjYfrxTs2DhC79N0FRgPrCXjJE547k
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(55016003)(83380400001)(86362001)(38070700009)(33656002)(26005)(122000001)(82960400001)(7696005)(478600001)(8676002)(52536014)(71200400001)(6506007)(4326008)(66556008)(41300700001)(8936002)(9686003)(38100700002)(66476007)(64756008)(110136005)(316002)(66946007)(54906003)(76116006)(66446008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IAPkZ6/1eh6YFuRvA6Jm4B4q3YSxPHiw/AtElvBqdWtVqx87A0+wyqW74z30?=
 =?us-ascii?Q?Itsu+JrPnrh3tkC00hneB4Za7n1BdjyDZqJRLHhy3+QyKxxJ5dyTIRWH0isp?=
 =?us-ascii?Q?AxMSXvYHGamQSJa2WMmmEALeG0tz7P4ap9xYzav/U8qAs+Q718PMlmM15+os?=
 =?us-ascii?Q?WPGCCkf46xjJOA6/0t+52VbWAioAsyp2rHqK+yUMQpKjsSytG62P65xH26Ln?=
 =?us-ascii?Q?SkKrjt6zSg+lD/zezDt+TwNQgQ0ixjFAAaXeX9nuNTekhvcPxkwWEQBbqLD9?=
 =?us-ascii?Q?P0QDJUPNizqL/znGcELqfxT/6Z0lL0zJs49E9KJ4XczMUIvS1sLhvhzawmtT?=
 =?us-ascii?Q?PDkamlzpcLAnu2zr/b0IDwlkA8+zpyJ8bUeMCXoLtC9Q54Cb1NgWcAmWNlQ2?=
 =?us-ascii?Q?0G0D2gHtU3PFxjzkpflGQHHt1DCzr5GCT8A0Gl6wyhMe5fMIbDROGJjNggGb?=
 =?us-ascii?Q?nuTjHaoTWOhMNc5DXmyarZzp9M/CJ5rChxC1zFNmFxFRZshlvDvU+Imb8i+c?=
 =?us-ascii?Q?7GoLSTp+VDCM+M0TPRu7fCiqUq7K+IEbJ9158ywVovYngWj8CNPtVSkl/tef?=
 =?us-ascii?Q?PqCbjmG+I9ekpymDZPRy49fv3kkg5LBayCxdchRZo4PMfc1+2aXpbxJ/KEE6?=
 =?us-ascii?Q?S0HRH0V0R6Eg4jpewfm8pIKVY6tjC7Xw2mRQB6WCNZbNi/IdKkYlHOJDBPKu?=
 =?us-ascii?Q?irkeVV3r5YGH8zEGNOd/hm9kgpwS5CT7fdj9NW6jrBKPUx2Cn16+2pFZCUSu?=
 =?us-ascii?Q?L35LLOP7k8adfyMjTF1c6aOBALZK/5zhg6c2YU+vJhmmjlRLjdpaXOlG+eaE?=
 =?us-ascii?Q?UyEuTPgB/tgk3SpewvgC6YKV7x11CmUlhumwXAnxVXTrdozrddf1YciEYhla?=
 =?us-ascii?Q?6hEXSvmZy7rHmxGs/uHOEbquWMyEd83yf8PaSdTIG9CiWUWbi8TASVNM2jOc?=
 =?us-ascii?Q?/3yZYxBkmdzEW4KyTb7AuLihAjfmrh29h4L4DULyOvKBNi34yqNZ7HzcUjSE?=
 =?us-ascii?Q?92yBcz5fvMKr7FEfs+KM3039+lgDPDVLbs6IT1mMvCBT54RmNM6MbdQnKy9t?=
 =?us-ascii?Q?xsAyUzFPZMPhSnQZU+f4nVqYoh6V7syqyiBrK8xGtJ+KqwbOgW2OtwURYQp+?=
 =?us-ascii?Q?nyTryJ4KW7hc0kdIhWSsBJoH7nyd4aYhLMIsK5XFztPCU6NN1iyyn3InZvf4?=
 =?us-ascii?Q?8/LJsqdbglcd4k8ZTx0HYF+VYW463Hkor7PEwe82a7wgKK0WKzj9jg52arzB?=
 =?us-ascii?Q?/OVHFe1rtHlBrdK39iokj9zw3oOSH2FAvrV7iFhndQ1laafoGZMLV4wIAurN?=
 =?us-ascii?Q?n9tX+i20JXHiygs14SfdalqWtmZ6fqyWX+salkrGfUh3GPuxwHurlUPkJp4s?=
 =?us-ascii?Q?AlQdvq+hUVCmqP1DCB5qcUYVX3XfWIoviwnGfmTfHbSOkT92dSKpgQtqzcXL?=
 =?us-ascii?Q?Y1+U+77HT0RePM71Hi6NrqgieqFs34vlVOQST1DajqZUsTcJr2f6MUMFi0Xd?=
 =?us-ascii?Q?AWDZOnvFJ2lVNO95ao0fjoAVQ3Kc3XYKIqjtkxb/clUgURyblygo13XU0Jki?=
 =?us-ascii?Q?48GND3voIMGXHVcVN75Hz4kLOymjUgfHkHecE2fU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd15c05-ee22-4f76-3ed9-08dbe4bfd2a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 03:14:32.6426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sLDSGnHQmbcNxWUgphPgOt+zS8DZiydJgmgodgDTmRob6rCwwfzJq1w1MmirdNnIDmzMEDXYCuZFnBBQ9Ld0Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4830
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

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, November 14, 2023 9:11 AM
>=20
> The latest VT-d spec indicates that when remapping hardware is disabled
> (TES=3D0 in Global Status Register), upstream ATS Invalidation Completion
> requests are treated as UR (Unsupported Request).
>=20
> Consequently, the spec recommends in section 4.3 Handling of Device-TLB
> Invalidations that software refrain from submitting any Device-TLB
> invalidation requests when address remapping hardware is disabled.
>=20
> Verify address remapping hardware is enabled prior to submitting Device-
> TLB invalidation requests.
>=20
> Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode by
> default")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/dmar.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index a3414afe11b0..23cb80d62a9a 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1522,6 +1522,15 @@ void qi_flush_dev_iotlb(struct intel_iommu
> *iommu, u16 sid, u16 pfsid,
>  {
>  	struct qi_desc desc;
>=20
> +	/*
> +	 * VT-d spec, section 4.3:
> +	 *
> +	 * Software is recommended to not submit any Device-TLB
> invalidation
> +	 * requests while address remapping hardware is disabled.
> +	 */
> +	if (!(iommu->gcmd & DMA_GCMD_TE))
> +		return;
> +

Is it a valid case to see such request when the iommu is disabled?
If not then let's add a WARN.
