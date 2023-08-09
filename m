Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BED3775696
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjHIJl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjHIJl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:41:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE5B1FFA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 02:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691574086; x=1723110086;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ByLE7Ev6bkDN1mjdoyt/Oi+IR1XhLQBryBI4s+OZoss=;
  b=XZMno0sUxzEl8cjLQYh2AWx81pu5YGmEAjSXmDfEefi9ZyCDKEARF9IP
   pEhUyfyghNH9JaFvDSM2IAbmZ+qkdR53hu/JN8R8LcCqjQxFs3R8lTylu
   Q8eph1O2kKXls8DqbneY3/ePpEWkhlX5b5hxGo5fkK4BYLtfVRtiuB1Z3
   a4YNd6YB/2Z++cYCkIqG659KvXcW+P17/a8Z1PNSgGVBUmHEDcgQ4wKWU
   4e3PYNZ7rj75U+cdmnXZAS6+FNVPIZoLWDWwL24bQlTKHi2WuYFIF5BRM
   n/Ws+5FuwK/tmR/bxG7Is1jgIbi6lSfBhDv9k8Rxtg1tqht7PqGwWiP2w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="402042548"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="402042548"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 02:41:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="855454973"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="855454973"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 09 Aug 2023 02:41:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 02:41:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 02:41:22 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 02:41:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beFNk406VmkmMYQo2K4PteD73K9F2+WxUMD15MonQZnWrb3ZfM2d/VvSVGDuzUJ7Bjpw8yZghAiqLcAm30XM9VHVd0unplPRVfutJzSwD7GIMmxdZgQtg+iCDPVhL9WVe9X+rS0AUw4oq0q72UqthHS9pptImCodEWnNmmKdvGFaCiJdm3VzQQEdINRFpXjY5vzSy+emv87pB/qUirOOUA7raJEuYQQObpx/iYdlGsPtj+6mteVwNA78DFQhSfdyUh7RfZvnf1tNRkWKspvi7r82W869G8Qw5XUhLXwLSWi5+FikwcZPuB/BzH8+H70pRk4CyzlryrngiFFLONpvCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UHVU1xkHrGHnbLGPA4ONtxky95QictQ7SkE3HKT/3I=;
 b=GKb01OCfVwIRz+ANBtzd8YfdxGNRbRVbzUulmjTX1NHpdSwrWV/Kq1zKCRwtIFpj8Rtru0s5Gno27NGntR+kUmZZ2vLFEDBPQP1GjU4MSQFI23GxTOgsC7iPF1ZWBCP1l91CH0xGmR1H1rsP8OpHWiR3AD0sQdAM0d7E/LZ/20G/Ij7wZoNt5do9ia/m3LDkG6x1YMih6Rowp8TA4YCXnylPYPA7PUwi1EocGxpPMp9/oL+4ly1/+3MJwdqoQdDSyltnYHk5ZEJ0o5N3Z5DAIeEFDjgdk/IiwqqcIe9XKksFYO7rRfcuQwx9H5xvlWQRyx5sdHzp2r5BlRVfI761Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6379.namprd11.prod.outlook.com (2603:10b6:510:1f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 09:41:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 09:41:20 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Zhang, Tina" <tina.zhang@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/5] Share sva domains with all devices bound to a mm
Thread-Topic: [PATCH 0/5] Share sva domains with all devices bound to a mm
Thread-Index: AQHZyczwIC26PTEzeEyQLUQIHK3R/q/htz1g
Date:   Wed, 9 Aug 2023 09:41:20 +0000
Message-ID: <BN9PR11MB527638E7361714F8AA5FD4448C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230808074944.7825-1-tina.zhang@intel.com>
In-Reply-To: <20230808074944.7825-1-tina.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6379:EE_
x-ms-office365-filtering-correlation-id: 2105ff72-2238-4163-273b-08db98bcc97c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g0kJ1MbCUehywkItzTVgpSTrgJcOL7ns5z68MoUKSKxWOZlavYOl5OTvfPIW46XdS1kX0Os9fCQqHXcM4LXyKpWRcvS3Z3beLDqlMonyWkSBRMp1Qdnns15X29fMKN12YwpdA9fqdWEHhcL/4VkChgqBfquIeBwzGyqFvfvGq3e37GP58x5F7wasB/E5jQzl4j7IF5LD7huzPZ8FR33cdPX2WccDAlFPmvvnczfbe5z1sWri+mlN2Y2Fk7dCYt7bDDsUgqxMo6BLSmNTYPyBkt3EHxNYRmtfFE4+7ScbJ8c8ILrYKiTPAbWeICBKGqchj8oSYF5nuy3Atn3Tu0zqBKZR1ZTSRNTgoOC0AJkgWLSHOVwWH6IacAejow+KDQAWqGSB44LVk2DaC4ReG+sF3CckV13gDqx5IZyDFJeQmZuKiAP+dEUnrVM2GMVUgKDJngt8VgMtFZPU1d/szL3oA2lAxWvI6yj2S1clC4Kh+3uWAcbMrs32zS7iON4w90FbYNFxISxdRXo32d7/milrX8Xw/Rn83dKm0KFI73VIMhE+dPYeoNREYSqy5kHEMBN5+LWJInsYT3mlrK1gr0o9wUEQMTaLuTn6QeUI9JJxVmZyH7D6kLJqX3p04lvH0dLW2zC9+nskxH+EofQNVVqAZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39860400002)(396003)(346002)(136003)(451199021)(1800799006)(186006)(76116006)(66946007)(4326008)(64756008)(66446008)(66476007)(66556008)(2906002)(33656002)(52536014)(71200400001)(54906003)(110136005)(316002)(478600001)(8936002)(8676002)(82960400001)(83380400001)(55016003)(966005)(5660300002)(7696005)(9686003)(41300700001)(86362001)(38070700005)(26005)(6506007)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/wUU97SUpFh+FTg4EwjS36wfTNJPJhir4VxhNlQYvkpP9Pum/jPKYONsv3lA?=
 =?us-ascii?Q?eGucUQhSKiSQeZ0RvzK5a7E6u2ZT/tm6GA81a1PhJeaRjyMSkIGS0oWKNLuV?=
 =?us-ascii?Q?jE+H0OnagtefUNI6mzsX8pQpfXDPc2PUB9oVkT5tPLmfX1ih2cWPqZ/Y4iM2?=
 =?us-ascii?Q?Hl857AzbM3s9knb7lpKetYqw8bnSuVVOp6g9QbCwwer4wWM5/6WTHhn93kNH?=
 =?us-ascii?Q?uF7uvqDKhHGHhi9N16mOVPCeYIpWrH7Itxl0vBey3tq9DjwNv8fgd0ZY0m/A?=
 =?us-ascii?Q?fRfK8KoK/NL94pQ85Uk4ImlL3Z+GznTMnqeHAv2oWcz6ZuU3E2suwx/p6Pv5?=
 =?us-ascii?Q?UnazxvCpQ02rFlUCNHGhrIvsLcXCyWO09/rtTYLy8q/0C4f46boxTi6327lw?=
 =?us-ascii?Q?XuaJTSUwBjth/DsBY0eZZ2vTONeDxQ9qOLmZSyRTWv1k4FuZu0qaETPbuCGr?=
 =?us-ascii?Q?TB03jARamKgsGAo+I+pVnzD35ictwUE3gVeAVhLr2CDZc0okSBD+hWUaNLc0?=
 =?us-ascii?Q?v0KutKl8+WlCX577422ojwJT84gKuyDrF+uOZXZ5hJn06+3Xqzzp+SF5PgTO?=
 =?us-ascii?Q?PWD0GTFI9fU2Mbpy8Uz4DhfjrKgBYTPLcxQKLwEwC+OXnNgFb9HJfFd8mT8G?=
 =?us-ascii?Q?OqQzqvusepqy7UbrYwYSyXJID0SuCl+Z1h9diZYl1Y/JA7+ZwLsH873HqAlY?=
 =?us-ascii?Q?fI3Da+3T1CJUooGCj45qRvdt2JY6HOE0HA5bLdPQzfC6ig4lCHbYe4YTYNcJ?=
 =?us-ascii?Q?/u4kFluo//ouYQg+h7xrRX2ZzQ3U7IeSZiJ912+2zr7hDCpIIpTmS2mb2s0o?=
 =?us-ascii?Q?9QtO7nMV3MgONh/4hIuzxTNCDRjP9KfJp7WsOFvrmisjHCiaQON5opQpeIuD?=
 =?us-ascii?Q?GbWgetV4nppyekchywOJvt6Pkgv5ovZwijo0mZug5MDeFgioPS7zoft0s/8Q?=
 =?us-ascii?Q?dE4Lpk/GP2i4QWEJ1v5ZKN2AzHiJxy4ClTGZr1RnmQu8GOXR972e6Fj4oCZB?=
 =?us-ascii?Q?nb849tqXZ6I20jXFoeVl8qEbEZom9CDpfPu/L7RQUK0aHcokz5ZfzRl7md/9?=
 =?us-ascii?Q?jCQisPHnDKdM04Nog1CVn51KG/p/j8uFl2PWU6nnYf09yfjEGmkzGFXx0f0Y?=
 =?us-ascii?Q?NvW41hZQS2AhkeG8y7+MW/vDMSsYdAvQ7hlmBmPDksABcseE6T9b/+hNr/1b?=
 =?us-ascii?Q?2heiwBu0L0ENzyFaQ+bNAyKbIL9IcFP1qc/GiggNG6aU7Ve/fyfO2TJcBtuQ?=
 =?us-ascii?Q?mCsSxObkx0NGcHsVaQhDqbltSCFbA+rUpKgsQ93SZaN9W6fvu1hBDAyo0BZ+?=
 =?us-ascii?Q?sjX1XqKB22e2gVpKShuKUn1yI9sIe3UQNbn/fncJ6BkbQIQdjqBPwA/Nse4f?=
 =?us-ascii?Q?xZNnHx6zoQg2tqRIE4Uae3zVP54StDXxFOGmh52v8i5AApKAgS8abSvBErPs?=
 =?us-ascii?Q?gliUzgiXQrvueAXFuSTRSh2RdljfKwWQOPl66t9bWgXQT5quL/RY+jA1mtOU?=
 =?us-ascii?Q?wNuXWvha9Eh1Zv6TPFzxquCva4sWVwr9L1DXUSVtZaZM5vuzfawQsiV9FiDg?=
 =?us-ascii?Q?hLJ+VsCqdQsvbvNdaZJddJCla5vdKWgWdiQ6nYF8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2105ff72-2238-4163-273b-08db98bcc97c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 09:41:20.4323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tVC/SS94W5emE+ylhP2K6/CQQgq06lXfoAKyp0KNXxTbA6tXYwirlI38kLqGS+4THBfBTvQHvHiw+6AgnRhMPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6379
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Zhang, Tina <tina.zhang@intel.com>
> Sent: Tuesday, August 8, 2023 3:50 PM
>=20
> A sva domain's lifetime begins with binding a device to a mm and ends
> by releasing all the bound devices from that sva domain. Technically,
> there could be more than one sva domain identified by the mm PASID for
> the use of bound devices issuing DMA transactions.

Could you elaborate it with some concrete examples which motivate
this change?

>=20
> To support mm PASID 1:n with sva domains, each mm needs to keep both a
> reference list of allocated sva domains and the corresponding PASID.
> However, currently, mm struct only has one pasid field for sva usage,
> which is used to keep the info of an assigned PASID. That pasid field
> cannot provide sufficient info to build up the 1:n mapping between PASID
> and sva domains.
>=20
> This patch-set fills the gap by adding an mm_iommu field[1], whose type i=
s
> mm_iommu_data struct, to replace the old pasid field. The introduced
> mm_iommu_data struct keeps info of both a reference list of sva domains
> and an assigned PASID.
>=20
>=20
> [1]: https://lore.kernel.org/linux-iommu/ZIBxPd1%2FJCAle6yP@nvidia.com/
>=20
>=20
> The RFC version of this patch-set is here:
> https://lore.kernel.org/linux-iommu/20230707013441.365583-1-
> tina.zhang@intel.com/
>=20
> Tina Zhang (5):
>   iommu: Add mm_get_pasid() helper function
>   iommu: Call helper function to get assigned pasid value
>   mm: Add structure to keep sva information
>   iommu: Support mm PASID 1:n with sva domains
>   mm: Deprecate pasid field
>=20
>  arch/x86/kernel/traps.c                       |  2 +-
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 12 ++---
>  drivers/iommu/intel/svm.c                     |  8 +--
>  drivers/iommu/iommu-sva.c                     | 50 ++++++++++++-------
>  include/linux/iommu.h                         | 19 +++++--
>  include/linux/mm_types.h                      |  3 +-
>  kernel/fork.c                                 |  1 -
>  mm/init-mm.c                                  |  3 --
>  8 files changed, 58 insertions(+), 40 deletions(-)
>=20
> --
> 2.17.1

