Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867FC7E6148
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 01:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjKIALI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 19:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKIALG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 19:11:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B6425BC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 16:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699488664; x=1731024664;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=meX9jNqHAO1sEetCI2ZUrU0OQj0wh9Ly2XAraW/HNiA=;
  b=RtfFt10J1m40vq59o2L1Pe8JFFff5VHUPHYWWvHHilouHKXJIvzY+ICF
   UKkzRxuyVlb84OlFWjbmfBEXsnh/dbFanpp524NCpxQ1tkAT5Yx6ZjSLq
   cNvGh/Y39wIOSjLWdM20XuWjSjnPufD48pheJlYTdKLFzIe4UcEvsnw0Z
   2i8RSIII8W4kwECWX2Hzrxqt8/KAr0zAK1ZvvveHdTcTvpY3ZEPvEk45D
   1FzGq/+IAQRe9Ph4Ov6ybI4Cbw5UGBvEQ67rXUbCFWoWDtKvSckQkLTcQ
   jcMSI6mHpk266EL/8JJUW9MmRTJXdpx0G5kcJTjVa3dJ61eRy8r69nrbU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="456380192"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="456380192"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 16:11:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="1094679897"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="1094679897"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2023 16:11:03 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 16:11:02 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 16:11:02 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 16:11:02 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 16:11:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzJbPjGRUNfks0XI+EllG8b6yPw8WmxA5ndIpVLXeBk09irpE6kGnngThlehnzvxdQr1HMDcWQ5wRjFHQMgy1zhRAsxxA6oY1V0kL2xwggylFUSzoin5JIf5o1uxhuTYh8+DV70xE3CvunBMP9qBuZrsEKKsdK5EgEySeHddZqGRO/9i4MeVPteVBcEeAS+KBhQ3nAjI/ByCKUvvt4omPhEVZTG4Wz/Oi34VnyYIbtamRyUzVw1TDD7uSa6t5fixSfGCiRDSGUPspXpZRlF8pkmK9eGJjDSHIwOl3/PFuTosZNrQUsxlxMdWRVK4DlN9H4vB60j3f3oAqYYkmKq/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E646EtcbfkGxuuCxyi0V/7MNFmmuFMCpuPSgR4MvlPw=;
 b=CvpYSeE3LR5EofcZrq1U33a1qUL3bJOwrdCqaBjFaZcfse9VbQ8LHCRvvh3D3PEfx2WF1H/gKwUgn40YzmIUCToN2y1iBFLe+Mah5L0Q/qbq8gKw5VqDkuZ0WsOwBmFFSu3+ivE7FfqA5gJHoWqgfyXUPE2N+o7C9hE6WdBd2JnJ1VVrIXvSjqkN5f3FydsX07uyTAL8zuxJopXw5jjCLqgHFfrPoQ1bZU/vjMonb/71ox9g98CnOsoeahbY08ieKamtffls79TVAuGv6rb1Gjt8lMHvrTVkikiGHODQjzgPFS48wOgkhSCVP0ipx/+wQcWJofH154naP1aeixDonA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by SA1PR11MB6895.namprd11.prod.outlook.com (2603:10b6:806:2b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 00:11:00 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::eab4:33c1:2b7f:39fe]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::eab4:33c1:2b7f:39fe%4]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 00:10:59 +0000
From:   "Zhang, Tina" <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 2/5] iommu/vt-d: Add generic IO page table support
Thread-Topic: [RFC PATCH 2/5] iommu/vt-d: Add generic IO page table support
Thread-Index: AQHaEIDZ+s5mtQZXHkC1pDebLuyac7BtrvIAgANqsYA=
Date:   Thu, 9 Nov 2023 00:10:59 +0000
Message-ID: <MW5PR11MB5881FC3D9DBF14D6BD07025489AFA@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20231106071226.9656-1-tina.zhang@intel.com>
 <20231106071226.9656-3-tina.zhang@intel.com> <20231106193228.GU4634@ziepe.ca>
In-Reply-To: <20231106193228.GU4634@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|SA1PR11MB6895:EE_
x-ms-office365-filtering-correlation-id: 13922d17-a5c7-4778-a4fa-08dbe0b85a00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wDAQj/aB1Aaqe4JzAvKkBscEzR7VJTT0YCHvkGo+coynViupWh+G8wVfCAAUmD5we09eOGHScSPYr1F+mM/7c8ZY8n7IhM9IsXwOThCRZxvOwQ7xnolvbBGU2a7zJpqrytb9b2G3XC4uEuPzCcznV8PYJSyZK/KHtWNrEY9CFe/9cyEKOkCGzcpXZAe8k8XiP7IgpYXCIGI13xsJeGSNH+ZYFs3TXTzpkHITV4AK430woAL8WMsxJtLDCEXcjEZE6mxVziBWZdjMNb8tu2b5OAwQ6uDSOitxU8zUYW0Uvezhb9Sv4C877gTzCIudryFuEtSjOFGihJMotuO7eGeLA9LcfPiq9qvD3XAVAetxNlyK9GpuoQh8D81xj7M9ob8CaMz5JUcGdnV4oIdceFU3PhdquMAHq6g7WmZKIYwbkhF7HK8eseqA3AezQtj8R38i4vDaYMsGdMtjQs4gPwBz2evqEO5znWa30rYYNm08tve4/h6XbFEoLdZufIEpHAc6CuasD+PnB44cFSgOLvtnxZ6e22cl/5XJOdwF2omfegD05GBCEIS41XcTvxYC72mI3jrhksea/0/NJ+DRzD6yDXzBeQsG6lg1BvHTSXe0lbqF3TO6/0K67BDjYSMDCHoGx+xl+tNB+LkYy02A8k/FCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(55016003)(83380400001)(52536014)(38070700009)(8936002)(4326008)(41300700001)(86362001)(8676002)(33656002)(316002)(2906002)(76116006)(71200400001)(7696005)(54906003)(66446008)(6506007)(53546011)(6916009)(478600001)(82960400001)(122000001)(38100700002)(66556008)(5660300002)(66946007)(64756008)(9686003)(26005)(66476007)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y1Mfbv0WNVNiH9CEbKZkX0Vq/X/3fqW+CPzk+CbByNUMCK+Ul2mrl1dfaOWj?=
 =?us-ascii?Q?aQ53acKrj2a3+Mo6Ijh8JrEe7d5WNnnrdO8KG3BsTufCAfoJX9Nnq6mesVK+?=
 =?us-ascii?Q?Z0aJnj9kk1OaJ3kpcsgfIxD/UBapj2KJgdaRYDKnnQEAA/XaBpbQ+59rVoRC?=
 =?us-ascii?Q?CpdELPQ3GO2epgrnkPsNwUJLNApP6MhOTeIJWXCurzFVDFCjm6STn8UHMzvW?=
 =?us-ascii?Q?CWCnuUcBIQbvyp1SKY8hvWXBg6ywSMV3oVfLcrIDa7OQCbzu1MCYcM05fptd?=
 =?us-ascii?Q?FD8npzj+lwdclPzZrUS0CeT+SFDw5+dGI9OtVsy8ZjMElrUG0O4iOqW5zEoY?=
 =?us-ascii?Q?l+/7kWqHddDA9J9eJ2WdszEVOxCd0n0WH4YtpBvEc0ulUDolmAiubxMjb6CD?=
 =?us-ascii?Q?c4OO0GDD/vNQhousuk74OK269lCGvuIM4pieEG9rNUQ1Av3C1Fi3nSx6w17G?=
 =?us-ascii?Q?N4AsXboQ7YOyGBjpS9lcnq0jXEeNHwtQ3ewPkSm/EK6ND99jvOEPRRaidBEh?=
 =?us-ascii?Q?0TEJ6AZumBjs20MlWpXARgE2KK9t8doSVAY/DqPRV9ttQMZNVmW7nuZI2J9G?=
 =?us-ascii?Q?/Nw6oBShgq0P18aqfjq0uPHA/0P/9NS8SHzCy7ETKb5uiOA36h5raALwr7KW?=
 =?us-ascii?Q?VsF8e2pygULtfW4ChxGTNT0snylR6YlZnx9/WDpKP44mt0GO5kQH+0zkeW2K?=
 =?us-ascii?Q?QqjgbpeK+v3uRln2yx/h379fTCcKWUPbvFLPG4lj8/nTgIad8PfqDvKXiuzt?=
 =?us-ascii?Q?imv/wc5BHKS1preFbw/j5paB1xMjYyJIGV6bW5naNMafuIx94AXxSLbXOuI4?=
 =?us-ascii?Q?Ix5W6VJDQM60mD29ALcguEPtanhnVCsXeZv+OZLxWqpxeS7DAzFa7bo9vrot?=
 =?us-ascii?Q?w5qGHKD4jbnANK8i/kNMdiF3SMxe2X+FUh4/cmbXFgIGF+iLuK/M0XU6OAB9?=
 =?us-ascii?Q?49TcdRyhG6lvKUkzhe6ny6FvAtxsvChkqwP07W39Vo44jVS6zMYVE/MphGhG?=
 =?us-ascii?Q?JRT41Yvfqwh1DJfQPGcdVLsVj56FesFh3GPiIeUL8ykkOOGYJSAy0kn/uBQe?=
 =?us-ascii?Q?VaIv3xMofAV9mhaXnclyd+lmmvf9mEjYNsq3jmE8XlssREMIyVsa/JvgBZaF?=
 =?us-ascii?Q?5/zE/78d+PkZ4LaqtYArXPUiJuB+GV6fAEUFc/34P6zZvU7M0c1t5y/yOQkB?=
 =?us-ascii?Q?aidtuNWYxxXVbVlaRvp0c6J7eG1XyagmLiGJNP2qqOt/aTWzr5h3RGR3+or2?=
 =?us-ascii?Q?CZAGy2wT6UxBFnksyP1/0nrbGheQe9mwifruMRC04VH4U0NWr6gmngv8hnJm?=
 =?us-ascii?Q?unDNqXsu9kkzhKthQkxrVemHWg3fx8oNDW0mVU22OJkZ0IlPJwpfEW7VWu3z?=
 =?us-ascii?Q?96E9FwXC9EjrsDSGxRAAcz/3DDISrXOch02scPjRgoM86TOIl2e8+jbcb1SK?=
 =?us-ascii?Q?xtmR5BaywaQwBIPLn05aSNrxgAIW0PFimudpOBcVX8WUDJB+luoDpWqOgN4l?=
 =?us-ascii?Q?ohlCx5Uoj6we1GpSUk8S0oMRbpQHvKH5lpNB9PRS2clH1Tv0H/dIEHMa06d3?=
 =?us-ascii?Q?NqFxGo5qgycTfYygotDx6GGoeaU1vSykmo2nsrIt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13922d17-a5c7-4778-a4fa-08dbe0b85a00
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 00:10:59.1522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: emM1HJYrZfeMGdtW+ZA+ouR1im49xZ+4xacDXDkpvMyDWl9eVzfVLT7RygbUYV0hVx9XkKC8/peWZjIG/3mt8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6895
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Tuesday, November 7, 2023 3:32 AM
> To: Zhang, Tina <tina.zhang@intel.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>; Tian, Kevin
> <kevin.tian@intel.com>; Lu Baolu <baolu.lu@linux.intel.com>; joro@8bytes.=
org;
> will@kernel.org; Liu, Yi L <yi.l.liu@intel.com>; virtualization@lists.lin=
ux-
> foundation.org; iommu@lists.linux.dev; linux-kernel@vger.kernel.org
> Subject: Re: [RFC PATCH 2/5] iommu/vt-d: Add generic IO page table suppor=
t
>=20
> On Mon, Nov 06, 2023 at 02:12:23AM -0500, Tina Zhang wrote:
> > Add basic hook up code to implement generic IO page table framework.
> >
> > Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> > ---
> >  drivers/iommu/intel/Kconfig |  1 +
> >  drivers/iommu/intel/iommu.c | 94
> > +++++++++++++++++++++++++++++++++++++
> >  drivers/iommu/intel/iommu.h |  7 +++
> >  drivers/iommu/io-pgtable.c  |  3 ++
> >  include/linux/io-pgtable.h  |  2 +
> >  5 files changed, 107 insertions(+)
>=20
> If this is going to happen can we also convert vt-d to actually use the i=
o page
> table stuff directly and shuffle the code around so it is structured like=
 the rest of
> the io page table implementations?
Converting VT-d driver to use io page table involves much code change. I ma=
de a local version of it, and it didn't prove much benefit.

VT-d only supports one 1st-stage IO pgtable format and one 2nd-stage IO pgt=
able format. So, the current IO pgtable handling operations seems more effi=
cient comparing to adding another layer callbacks in them.

We have a plan to add a new io_pgtable.c file under VT-d driver directory a=
nd use that file to collect IO pgtable related functions. But we want to ho=
ld on converting VT-d to use the IO page table directly unless we can see s=
ome benefits.

Regards,
-Tina
>=20
> Jason
