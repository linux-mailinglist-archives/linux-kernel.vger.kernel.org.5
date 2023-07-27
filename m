Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355947645DB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjG0Fjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjG0Fiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:38:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B333ABE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690436267; x=1721972267;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NIT5MzoOvCp3qiY8aP4wBN2i4gm/F54Ej3otVuGhvhs=;
  b=iyLV/iYpbMgNgNKEpweREB3gFIC8wnQG8Xn38YI0WdAP/pfmwe6i7exH
   ZmGxi8LozExYdn8FtgHRZXj5dt0zp4oDmcWaJhcecXHor+48bOny+gKYM
   trpHXNY1Y68D+FvRCQ/EMGhWKPXizW8dDN/4GuLouC72MDle6Own1TWbn
   roH1UOenA/uyMow9/jFRFhKbIL+1lcrnRQmd3AQfctSnB/0rKVPNAr/Mh
   wliAyZqG2xbVWY5Hb5C3zk8MfoUBEBaq/J6i9yXO74f6Va6SxgM6yRJ6O
   WsWbq974scRTKNkRvabww5PUhX+7kOfX6uiB2IruW3G4nUXtdy1t3lkZo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="454578425"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="454578425"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 22:35:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="726812926"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="726812926"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 26 Jul 2023 22:35:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 22:35:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 22:35:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 22:35:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 22:35:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9olcBQ7wtZbeIwScaeMiHgyr7oFAOeD73CaoTXKMhVIs9wLdfAGlUMeJ93y0F8Pvito6DzCaDCOph2h4vP0YQpnXWuOmcAmkhVBSrREqiND/mKtqQZiYoH0bhn1w3JcUbhSfNioNt8Oqbg/g3/pLtCqaIhiPGz9nKHIdne8OPChy/Q5p1svgmGGcb3p/VAVfcS+2VBTAdsyckDGWmRjA/9f6At0OdtpBBpQPQL2CxtCeqAw5RSj7pDBuZ03opQxxDUHClC+daPuBC3yJQgmi5M3Ws/N+a+vLxVKjvA+DDSu+rB1cL//+rqqYjmpHISwLsoMBnhjdSPJnzrjm0WPlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIT5MzoOvCp3qiY8aP4wBN2i4gm/F54Ej3otVuGhvhs=;
 b=TUz92O7cv7jQglA4Le+TB8dHopdJ0vcsUYnmYOscRAy4V/OAEOp02hMOWB7CApdhEhtrIbRGFGAD24WoIy6Dt1HzFUgzxzeq7nSnQX+6mim26/uLn8IAFYYvOeRjdGSqt2en+j8p4m1XYBlgyzg/W7mRPqgo0P2OPfsongEUGd7UPf+AOsciZR70UxH5Drtd9pm5H1dAz4YqJSbLEV+uMJDN07r8opsOTsRKvmoUx1YPkj+f2WZuhg0FqJQwwzOnINWfLgUH3MJLwbqZn4w57xd3Xs1zX8AfYSu+DWagYVyQeKkJT8wOA9ty/m76veeAZDIoIfMb2PJoV7maDm1sNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB6424.namprd11.prod.outlook.com (2603:10b6:8:c4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.24; Thu, 27 Jul 2023 05:35:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 05:35:25 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rodel, Jorg" <jroedel@suse.de>, Zenghui Yu <yuzenghui@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] driver core: Call dma_cleanup() on the test_remove
 path
Thread-Topic: [PATCH v2] driver core: Call dma_cleanup() on the test_remove
 path
Thread-Index: AQHZvlYXLIXDkH8K/EiN/hCo+9+giq/NG2UA
Date:   Thu, 27 Jul 2023 05:35:25 +0000
Message-ID: <BN9PR11MB527672A6DEE8471B3B6BEE9F8C01A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-4deed94e283e+40948-really_probe_dma_cleanup_jgg@nvidia.com>
In-Reply-To: <0-v2-4deed94e283e+40948-really_probe_dma_cleanup_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB6424:EE_
x-ms-office365-filtering-correlation-id: 881c829e-fa3c-4434-8628-08db8e634737
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aUAFKgU/5nxKcpuiYVhuRI5+Q3MGZn0p5uFXEADpxdfcm8dVWxq7qh2c+C6g8alBlyN1fPajFZVBGYbLGl+OcOUcNRMENuT1/iyhPGqWXuu2WSxqRemU5Dfpe6zEtuaiIja2LkrX8PYvdW5GRptt2b+G6FM5i3nm7wceReSb/5rUZexEF5kZ177Wtukn/n/ojBt5zCV8hOR2z3UnVIUzwW0f7HqkvL12YUXBG4k36ZyjjUTEL4AR7GvXCwrNg/AWIJLyu8YTHbRRPmLcTNR2czfsyWBWfiPxBp9CTrogeqFQj3pOZRmpkxB01raHpSws4S10jrj20y+ewuhZYdFQeJDTKdPxn9ljGGmyPFyJrM9uU49BMihMLMRkeOj5whnpXMW0Il6wHEgDJZD4G9/oT51uEt4ffKUItiI8K39Wka23w+kYW3Vh/V2XTdxf2Ai+++SPzmXP44DIRZADvd8zaqZoShrtJNVCl7OwL22vwOXXey74ovJX6mmi1uMaSN0E08/sUSHRdfTyQ222Iqbqk5i4hbdKGjCfk34IkZmM0Cjt6wT6nsFOVXxtq0hdgl7mDrGCj/0817csPBSDBxvMm3JCkEtb2n3xNt2MQ5wtzZY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199021)(478600001)(186003)(83380400001)(86362001)(26005)(41300700001)(71200400001)(4744005)(110136005)(33656002)(54906003)(38100700002)(8936002)(7696005)(66476007)(66556008)(2906002)(4326008)(122000001)(9686003)(66946007)(8676002)(52536014)(966005)(64756008)(66446008)(82960400001)(6506007)(38070700005)(76116006)(316002)(55016003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mKxB6rmnJY1EXR3omcSTiM98DmPpIvEAYiL6A9LWZpH3i+FyU3Qv/w4tjnYI?=
 =?us-ascii?Q?rPu00SMrMXSHd6Qfb48ztFvHHQ2BpXgerWuj3hNewzT7H3KbmWTd9BO0fHDh?=
 =?us-ascii?Q?tnSWCsKGpXBZu+jZRRR/1Ko1NBD4QIYCEb3XWpO0cuWXUzM/Z0Z1Ks4+6eCO?=
 =?us-ascii?Q?Ef0/Uhu7YtC79y6pp7IOtlwOEgQQJq2DMkBNvVa3dqdItK6Tw6viWy18fPCs?=
 =?us-ascii?Q?rg2kTOvSE6aoYR6Qdx+GujtXkYiU3ki1Sp2W0ilb0is/NIoOstMjzYcuWFxZ?=
 =?us-ascii?Q?EpOJBac/hmKAbyjeraiJfDhDNScJ+jx4w4t6GsmNPOsysno+sUvgDaV1r8Fp?=
 =?us-ascii?Q?ggSM3RnsB9w7p+TeHtMX7z+hPSlGuF5JZBBOkvYJS4LRxOEfh+8ZflkNV1Xi?=
 =?us-ascii?Q?HD/P9B5rJCqrwtAQU4VSwu0t5sqyDLmuohr509eGmAlhlqkwkINe/5FY0D5u?=
 =?us-ascii?Q?ApVtKevfsObfKm7pgI7n3QRMq1s65/891dTOeOYBT12M2Oy0imsdIh23980S?=
 =?us-ascii?Q?f5bjJKLGwf9oiOqxZdezTwn4lLmpzaamgpBmOQfsCExCVv1aQDngTvGIctiE?=
 =?us-ascii?Q?aIXpiqtV2uaZeVnP7UFArB+imzyNNZA4YrnCqsJkh70utH59gNTtMWxreBVA?=
 =?us-ascii?Q?ys89y/WS33UMbmAbQRS1bQW6dvHYS4EDZp3FtczP1k+kBWGtc/0Vz6+LSO4T?=
 =?us-ascii?Q?/qh3NV1l7Nu1iJFllQgQaI2qg/BZMzZXNrNU5SJ4K21lqbWg9iQKeNoyUZWf?=
 =?us-ascii?Q?Fn1Z8j7Z+2CPghEERg5u+J/lwqd/32NbVhqOWaX0cvfla6wDNnrsLa8+k4wE?=
 =?us-ascii?Q?JigGMxZ+GQWaoAndYIMEgArzqNNeBS0B2IjWB2NcR9VCCZftG23VJsT6+eM2?=
 =?us-ascii?Q?GMEPq4YcsZ1RzUn8ATA2h0use1UbKQUjPFmdyMF7CWYTDjCaWBuykYaQXbv3?=
 =?us-ascii?Q?Ayc/fntlLEQrie9ZRyDqnRGYxduWMxWSwLfnnU8n/R9ePh61qDNoesCWGqt+?=
 =?us-ascii?Q?VqW0UfUhzz0fQ+3l/Pv8SDggmeNLK5vgpCl/cmeF+ufVUc3TY50B+ccpMGzA?=
 =?us-ascii?Q?uBE703pZUnScBW0VP2CG9T+zrdKBo+uyQ/jfFX23yLyZ1+mnE1F9IJURhmf4?=
 =?us-ascii?Q?C+olSoKRfCuVLQOHuT0XSMLqTJWjPqON7FBOUCT6I9Zo0oN1GrNsCslzbvMF?=
 =?us-ascii?Q?45aS6Ct6rbbc0CgyvRxvxd2GV0ZpLcn032/gUNry2puHV30eyRdpDpfdiPBV?=
 =?us-ascii?Q?MxI4J/74oXWawMoLZ/OAL6dZKqz+R0RtRIMhU68cOIoCDSy4z4YrvKZK7aez?=
 =?us-ascii?Q?YWs+IjchnvThI05dGS+EpXF6EyIMtGkQ4SfLDCQcKzLRkceNvS9OG/nMoAto?=
 =?us-ascii?Q?AfYvKSOzmF3NPkorW+e+1vAqYxgPaKkJGdVHWO7YAKwad/vvSmq1Zs08+rfU?=
 =?us-ascii?Q?r8jNObwYdqmtwp7uXNFn+wYOect6rEx4a2cMb/RJglW/rzektGccOdauYdMA?=
 =?us-ascii?Q?UHxE71IIy0AOFSi3NCkPf9LfTTrCILpZLPq9NZuxO+P2FJc/G5+c1VaxRhBi?=
 =?us-ascii?Q?u/gIV639ux7UpMQazBCLY/g4A3NPSKZPV1/cTje0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881c829e-fa3c-4434-8628-08db8e634737
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 05:35:25.0564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EWQkCGMTAfVSu8s+lvTzqv9H7dY/2K9sf0beuSdZboWXWQGll6hcGOwoXryvlXTsSvO0oBuDT8Zhz7WyFBikJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6424
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, July 25, 2023 1:41 AM
>=20
> When test_remove is enabled really_probe() does not properly pair
> dma_configure() with dma_remove(), it will end up calling dma_configure()
> twice. This corrupts the owner_cnt and renders the group unusable with
> VFIO/etc.
>=20
> Add the missing cleanup before going back to re_probe.
>=20
> Fixes: 25f3bcfc54bc ("driver core: Add dma_cleanup callback in bus_type")
> Reported-by: Zenghui Yu <yuzenghui@huawei.com>
> Tested-by: Zenghui Yu <yuzenghui@huawei.com>
> Closes: https://lore.kernel.org/all/6472f254-c3c4-8610-4a37-
> 8d9dfdd54ce8@huawei.com/
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
