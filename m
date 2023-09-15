Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14AB7A190E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjIOIlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjIOIlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:41:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0F8E7E;
        Fri, 15 Sep 2023 01:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694767278; x=1726303278;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lhH1uxeM5ccq1UrdotnTYR0iOnXyVCB7kb9EWe8cL9U=;
  b=QcqvX2V4bL1aAg8i9ck6UhUb9NR7K/dZhQCutKAY83IiBlxoPeKQwElO
   zVUTlRPGvAn8d1xtb0ifcuIZ46VE5QKRKc7OoEd1GUifZYXj3Rwk3JGE5
   QvrCjyHBvgyZIdRgSjdOMHcLcl+2Ur/0sRt5LvWRyzHllmBr0yNwB1Chq
   iaQWGCelACkcocFfmEwm/CXzE0u7jY6AtAPT5WrCenTBfOKyvVKJBhKE+
   xv12RJ062bnrbi4BoUSBroNHp17LO5uwAKU6zmWcBucnC1qcucYcA/YUc
   Wje5pyt0CzOwtWwA7+4wqDQ5GSgLvkXLvkWEhDn7RkznujzI7cgKXW1gR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="443263939"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="443263939"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 01:40:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="744890302"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="744890302"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2023 01:40:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 01:40:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 01:40:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 01:40:15 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 01:40:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2mfervHO+5JR0Muw6WYvZQ6WIQazghQONxXaLqK+te8kc1GYf7f2mYRsYOagaH8NFrLsTctmmtVdcFEypbliZQ4TDeq01emvqpOilpWmnGBsR0Oq3zXwfHR6yTXy0xhPKvWRif5djL4SvvLA0ppztfqE1hx4GCfj8EMN0PL8aTwfLcaVuBMgjUVOHYCl/Fk9MAfNBHxTWpIWoOk7dhkLA6HrE06zfeDeThfeOJ6ltbw3ML3Mca4+FYu6IvlPBkbMyhsBaWydUOPSlIgqhR22u25AajtL0IAnDjtIMbGUe2sl3A7Qh5ZPLGSBmTcM6eDiPr4LW1OsnUb0A+y/dKV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXmlg9A3IXkSRA+PVmHTkkSUI8IaBCKtfIsRnNLrisI=;
 b=LL0k/oPIXaJz24qyEmFHpHKW0myx2HK6jJutWCnS9NVdK0BxpYABQux8XA+Z1YrlbeG/YiU7jqdYGB0U/yrZgWHCaGZqMXmKiwjvWd9mG4cuk8WDeXTgxUyEp0xH5UdjlRn8HNXFf7qST/GYzICxrxHoQAUEQ1zM1V1NcgkhHSnYYkJ17whA7/V8ca9LvavZfGlVtP1cv7aIInk9BI2qUNSUuNTG5Fi6T1/uV9/USH86i5ZQHCKKS5B2g3R1FsZ7aJxub81kzQtwPoyGWOLZDAsdUmIUKANPRImqyEpL/I2RC+wv7DA/1rdWEhrUUHnkpaxxAkHMN9zUqjiebwqHUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3521.namprd11.prod.outlook.com (2603:10b6:208:7b::32)
 by SA1PR11MB6941.namprd11.prod.outlook.com (2603:10b6:806:2bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 15 Sep
 2023 08:40:12 +0000
Received: from BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::d36b:7f39:5410:6b30]) by BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::d36b:7f39:5410:6b30%6]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 08:40:11 +0000
From:   "Romanowski, Rafal" <rafal.romanowski@intel.com>
To:     "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        poros <poros@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     ivecera <ivecera@redhat.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "horms@kernel.org" <horms@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net v2 2/2] iavf: schedule a request
 immediately after add/delete vlan
Thread-Topic: [Intel-wired-lan] [PATCH net v2 2/2] iavf: schedule a request
 immediately after add/delete vlan
Thread-Index: AQHZ4aKdRNkl6NYnMUmPbKg7+r3ofLARXcQAgAo/X8A=
Date:   Fri, 15 Sep 2023 08:40:11 +0000
Message-ID: <BL0PR11MB3521F2616C7A00C2BA9546BA8FF6A@BL0PR11MB3521.namprd11.prod.outlook.com>
References: <20230907150251.224931-1-poros@redhat.com>
 <20230907150251.224931-2-poros@redhat.com>
 <9a84e07a-d74b-aa8c-3da2-a8fa0838a11e@intel.com>
In-Reply-To: <9a84e07a-d74b-aa8c-3da2-a8fa0838a11e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3521:EE_|SA1PR11MB6941:EE_
x-ms-office365-filtering-correlation-id: da2229c3-a022-425f-af17-08dbb5c76029
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CNCMNp/S32wcLzzTDAhdx+N2abSvXC6CfJ5Du73HU+uebyjrATP0V0pTN2OYFGc2/uVxJQWHkjaOFoV7wGgFcj35kjsRfqfyonrUKKTH02Np90gdXjN/ONXpkkIgIoU+ilQGivfwVGLSm/g5GUfE8tzpDuJ6ZVEhGEbGtEGdZJJiGDRak7qaVb2opUFH6j3jgf2cMS78nmk4xkh2BgiH03lI4KPj3ssmGgena3flG0dUAQkwJr0qjVeOcevClW6kX4pSho3y0uJgmckhHCiXYY1mngZ5ONlMHpYMc2hBf4zJn0iUXjHEF2lZkcTJmv7NnCpMQrK9qcwY56qEGW509tX3XlZc/NZwRpZ6DN4z77HmLKe8tb1BeP5t8Nn/RWM9SgyJ0XK7tjPuu6U1OIf3MtWoruK3A2+KMgWyvPJwaGn90JqHUiPGB8Wt/F5lgWDpZPqO8CWh3K7e7+goRhcHgjFFTVhYP1zFJ7tCAwqNJfyktppbbul5X1GgUO9ogam8ktHeBozmyW45B9UinF8LkUudqMHXXhRcZ3MPEUhSIrjUnlIk8fZlqYtsyMqFWc1tPRa7kL+S50wXRE897vmEdmzYA34gecYJSkQl/XXn19R/xVpVRm/RHUy5JwgF0tkyoSjHAAQ9GYK88hKRYN2hXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3521.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(186009)(451199024)(1800799009)(83380400001)(478600001)(122000001)(14773004)(38070700005)(9686003)(71200400001)(8676002)(2906002)(53546011)(55016003)(6506007)(7696005)(66946007)(64756008)(52536014)(66476007)(8936002)(86362001)(4326008)(41300700001)(5660300002)(54906003)(33656002)(66556008)(66446008)(82960400001)(76116006)(110136005)(316002)(7416002)(26005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zs2O4YMpR2rVbUKMHpADl4mSyH0axlSBufYBvyN70MWFFlkR8G95bwnzw44T?=
 =?us-ascii?Q?bD3daCWaeLvBZFKeTyHVGBMRQo4jhVwzEOnpXoolfDUXBR209R8X78512o9F?=
 =?us-ascii?Q?BaNt/Cq/FzK7mvrjG1gR3wp0mrBuQbn7lRfWIr2t1faOVkpgYTbn54abO8xJ?=
 =?us-ascii?Q?Who+TAg1b8Dk0lWtrn2713gQ5QpdgLHqeAMhvr2FJt2YZHLkYntNN9YWYWzN?=
 =?us-ascii?Q?BFEX8f8orJLNpsm2dumGqVua3JeMR7kDQjW799v8vzjuIKkGNqbsnOQLVC1u?=
 =?us-ascii?Q?NNFfxg2EThPZXllZOaiao6MxYjnccEovn/1Au4qRYgTpgCjvhL+XLnK0R6dP?=
 =?us-ascii?Q?+Pv9ebzho1m/+y4/psHmFDa/anrdk+P3dY1gDKGjInSQL43UcMu5Q+C21wj4?=
 =?us-ascii?Q?ogg23dx/Ko6eiN8x6JTfCng8C72AGohF3Z0XVG7/uY4eqdtekSGzESR8XZXn?=
 =?us-ascii?Q?oUxtZDy2f4lgzqbDmOyQxfdIydeIdTlu6UJB2XMNtdL2Ai0B5A3YMbnz1Tlm?=
 =?us-ascii?Q?BdG76Sgkn9Y75Vdq94ymgqxYBd64w/WZOWSFgNbrOjvFDwLifMaP9zaBmm1q?=
 =?us-ascii?Q?PAqVdMjYuSEo5vOudX3PwnvhEzjiP3qjk+cxWTq2XQjdt/I+ho8f8Smh6Wxe?=
 =?us-ascii?Q?ll+GjBiLTlWjfBrp6mOKOUJidabidyIjxuE9//k71j6YCLMUzQ2DfPQyYncE?=
 =?us-ascii?Q?CYCr1r3FZ/uebRoc7WabMhv8IXiRKw1MIhxNXLr7hpEkNE3+4yjidHGmxSUQ?=
 =?us-ascii?Q?UHB7ZZz7bWvU5KCfrR/mMh4nUNC2an6VdulJgCJ3iB+kqeJa25Gbfm2DwWca?=
 =?us-ascii?Q?1DyWCS1ITRV9AQlm2nh4vaFpZe3/Dfco4nUA5uikouT/6aLEnb7Sv/GDUjxv?=
 =?us-ascii?Q?FFPtkxdNBQeELGl3iGIXFjL9q5OTAAx5A+2TkjbqopPpQzkeIrugZ/CLtIWd?=
 =?us-ascii?Q?ck1OAlB6Qte3Pqk0LeOx9tyh98BFwmuFOr9riRrwfRMBL3dCeIV7pJGs6ERO?=
 =?us-ascii?Q?rvqSfBKnAhIABSIpkLl1BulMu/iVXEf4eKCPvTOj6btJD04T2vkKgxkkV8kI?=
 =?us-ascii?Q?ToX7gQ9r4qErogtpU7+ytEMfnWNNluGjGpgk95p89Tb3Z7qfec4FqSnYNIlP?=
 =?us-ascii?Q?Pn80PLtX6gLLEVJxHViS0PRHmvKR+8r+9e5s6dphJA+kxvvaj7s70AJQWr59?=
 =?us-ascii?Q?6h6qN3g3nZtMFgj+VPM4R9x+c5ofSq5WQ4tRtNeRclo9z0yGq9IVwg5ekMm6?=
 =?us-ascii?Q?1MifaSyK2puN6oSQEfxryG5F4BKBFKZBSFaOoGpqsO+P0ga7t+yH0BLEpKSb?=
 =?us-ascii?Q?PJsJj5h09p3IPYuvAB7B+polaqxavMr2zX+H6cevPZrkqOX5phTPCt7/5SlY?=
 =?us-ascii?Q?mqOgmlpeIbm+aMxWgrs7fUoKfl1ZKyUD/G1YvxP3ZzMyuvxG/0GmItDs9wuM?=
 =?us-ascii?Q?5mxX8lMwTX5L0CtCFZgvSOisARKmyGb4gGKZpiSrT4V/Uw8dQ75fezCjrzT/?=
 =?us-ascii?Q?cxBo+XSD10gWCCeBtgjvwcCr2dPuw6ZIO5FaP/iY6nirsSR9L9h0jynqgIfv?=
 =?us-ascii?Q?zBe5kh1rkLpQblUbxqIGz/f53PCpNlm0d08FISCWJTF4yPl232d9mB5UGUNr?=
 =?us-ascii?Q?9g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3521.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2229c3-a022-425f-af17-08dbb5c76029
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 08:40:11.8957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: STzkIiIfNP+4XIibPBMxz9OdP841tduOokGTzOp4qIrjE+oPhhQmlcLoS3tcCQMNb0s84rm4D2rM9GruIIs0fw1wGJPW9YF0/yEe6Bt860o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6941
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, September 8, 2023 10:11 PM
> To: poros <poros@redhat.com>; netdev@vger.kernel.org
> Cc: ivecera <ivecera@redhat.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; linux-kernel@vger.kernel.org;
> edumazet@google.com; intel-wired-lan@lists.osuosl.org; horms@kernel.org;
> kuba@kernel.org; pabeni@redhat.com; davem@davemloft.net
> Subject: Re: [Intel-wired-lan] [PATCH net v2 2/2] iavf: schedule a reques=
t
> immediately after add/delete vlan
>=20
>=20
>=20
> On 9/7/2023 8:02 AM, Petr Oros wrote:
> > When the iavf driver wants to reconfigure the VLAN filters
> > (iavf_add_vlan, iavf_del_vlan), it sets a flag in
> > aq_required:
> >    adapter->aq_required |=3D IAVF_FLAG_AQ_ADD_VLAN_FILTER;
> > or:
> >    adapter->aq_required |=3D IAVF_FLAG_AQ_DEL_VLAN_FILTER;
> >
> > This is later processed by the watchdog_task, but it runs periodically
> > every 2 seconds, so it can be a long time before it processes the reque=
st.
> >
> > In the worst case, the interface is unable to receive traffic for more
> > than 2 seconds for no objective reason.
> >
>=20
> Changes look ok, however, can you supply or add a Fixes:?
>=20
> > Signed-off-by: Petr Oros <poros@redhat.com>
> > Co-developed-by: Michal Schmidt <mschmidt@redhat.com>
> > Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> > Co-developed-by: Ivan Vecera <ivecera@redhat.com>
> > Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> > Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> > ---
> >   drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> > b/drivers/net/ethernet/intel/iavf/iavf_main.c
> > index 86d472dfdbc10c..d9f8ac1d57fd62 100644
> > --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> > +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> > @@ -821,7 +821,7 @@ iavf_vlan_filter *iavf_add_vlan(struct iavf_adapter


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


