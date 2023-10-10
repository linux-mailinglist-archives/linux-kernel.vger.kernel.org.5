Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6557BFE34
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjJJNnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjJJNmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:42:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7501B9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696945222; x=1728481222;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=laFoDDQc8DdDNUkPBDmtYhMFw/oFVkUMrmeQ3mvsQt0=;
  b=h1qrbURYbFwMKnWXaLhDffod1VVa/8PKZc8cfMcP67123UmUhtNEHlgt
   CkAySnOy1qNMSrVHd2baxH5vtfAYZu0R9F0AvzDykra/EWpSa2esBH6fX
   84ZOcEQb8zWgvCVMT1E7wTqNFuNdI1Du1ulz3Vvtu/QP0AOpD7lsJnc4c
   hkwdqKEB3Fz7kOp9ghq5FgEPn8PYdp1qsDq6qGZuIFpWFo9+xtQIAce10
   x3HHk6jQl0IB5ILVhLT7c4G5wLed/SziXHncLGukmpRqfSdwSarWIEwKu
   kzfG0Q3zC+IWuUgnpVJ3pN/ZoXeky1/EKPlfqp9xmcjBy9F+UapDSw3Hu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="450894873"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="450894873"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 06:38:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="703315014"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="703315014"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 06:38:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 06:38:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 06:38:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 06:38:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fq/nnS5M1iEepZcfqrNfHWscIJwSgwiHES7+rHwe4/+RSHBDRJ/vymQmtcjqHRPbvHHnJQ6U03tlv15eHWQWCUMbtUgP1uSVBcakKODAOyo9qI1k2/h8SfRDgd6gzHBfQd/sc4G0snuFXPhwQazw9ObFuS12RL7vEpJmMjV7Zz5iFuB4CoNlc0AGDFql8QEqAA28X6o0TZ53ic3X1D7s54kUY3lJWkIt+pWRVbiKcAlxrgeRX24rAyVQUeF8uuMA2WdzFj+BG5Yt5aJICMelUr8DFQgmEbHswAswZr6BdvN4KbZDxrt9naRADV9AhNSlylI12D//GTudU1/AgTc0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0/xnih8j10UyxxV7ORm9VFlb5ERgALCgWGCyLb0YuY=;
 b=MDsNiPxEw97A3tMGwwsRTc4m46/K4damvSBqmt5WGvbHnhYGh8/QG+iaHJ38Esu2cCdieQAjPyefJdOF63dN1ZAcKFRq3KTapM932ZTbAu3cWZs4sn2wjevSc552SJ2FNUh+gTM2ulira4QtsZ2zZk802bXyJtWvIUvlcuSgJZ+vPyWjdr9Cji7iLrBLfZ5Un3o2F8fSAjYwQ6XM76prp/xK2LOh0KiQjsNqZQ+TAyG8GA+jpGmqoVJ2exgZICKLXCnW1bOGtw18rf5yxDUhmbTzDzUQQhRBEMzWKmsSsbBrwm7laf4wGWmDXCWENBK4txjFDkABiBljcgazkFC1lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by BL1PR11MB5956.namprd11.prod.outlook.com (2603:10b6:208:387::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 13:38:21 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::3346:a9d1:1c70:eec2]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::3346:a9d1:1c70:eec2%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 13:38:21 +0000
From:   "Zhang, Tina" <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 5/6] iommu: Support mm PASID 1:n with sva domains
Thread-Topic: [PATCH v5 5/6] iommu: Support mm PASID 1:n with sva domains
Thread-Index: AQHZ71lrQmeuFVBRWUer3v2RYxTBzrA9INuAgAX9v6A=
Date:   Tue, 10 Oct 2023 13:38:20 +0000
Message-ID: <MW5PR11MB5881879F1B749AB1D4298CC289CDA@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20230925023813.575016-1-tina.zhang@intel.com>
 <20230925023813.575016-6-tina.zhang@intel.com>
 <20231006180607.GA1140589@nvidia.com>
In-Reply-To: <20231006180607.GA1140589@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|BL1PR11MB5956:EE_
x-ms-office365-filtering-correlation-id: fdbe4448-9c98-4447-79eb-08dbc9962b36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RPgoB6LutHAaNt1EP8zHGzQnJaNxCDzF0ZxdNCpxiD1fUh8+VzmF8iyUAH4qwrRTUjKclqr++hMugeIwcGtyeZMi42DN5/1Ijag2ULy38XeXnj5ZBytHYzLY3MRAgkLKKoejYGk7sbaHffpJFfaFm8ZRPq22Bw8VwTfzZCPzhA1hQF5Jr2sOnS5Bhna+IMZ9XWJLY+lXuCVanMtWf5u8jRWfQsnvMABb3P8KQrb3a/cwJ6NuoXIWNTMHG8eLEOxULKbppS0R0Bxm7nXsuWOsVvtbPx7BauToGMSMYhKxfkn1QyN/VsA5Q1qSYUel+L60ykBL9TP+3OMDeiHa8lTLp6xhKoBXEarqLEhdnBy5qhz6JqoIgqQcaL4JgBs4R2aMnC7fREPmUaSyegP4eAscfhapkXwgWZ4o+vyd/vfWPaISriQpSJFR91gD2qXkpW3tdMleN2DkvarYGfzlvlhCOgRf3JE26WKrD+nnepKrp02KalbTQ4geJ3oqYgYId9CKW714+0Pa41dOiAxdLRUK065HgrRjjbbANuylKZDLpWUd/cHgnjxpnCC0QwJIYg6NGHq76Evlt2tAHeNTkekmwgVoxPpY99ntjzSJn5QYGJURiJ9Psn9CMwLoGbfi02xz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(9686003)(53546011)(6506007)(7696005)(478600001)(71200400001)(26005)(83380400001)(2906002)(316002)(5660300002)(66476007)(66446008)(66556008)(76116006)(54906003)(64756008)(66946007)(8676002)(8936002)(6916009)(4326008)(41300700001)(52536014)(33656002)(82960400001)(122000001)(38100700002)(38070700005)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X4oxl8fSwVl3VyJMpcgHDe8MRyrPN3bHj2TkLwR+oGJfWP7f3ZEhxEVAijuU?=
 =?us-ascii?Q?N97AjX0nCwVQTM87edRNCf35H/GN1kEeLw4Sgwbkty3YlaYLDW9PjTgDDhGg?=
 =?us-ascii?Q?vhNgqZ+fqOooM7YWNRUDM1ElOzUfVJQVP0QqJu75ldK3R81wvEg0U8GtmVy9?=
 =?us-ascii?Q?7EFpiNOcaw+qRpkM7HZBugKkGivrSlOmkD/ABxQM5FopM6EX6HBCsyCdHRtJ?=
 =?us-ascii?Q?mjQVA8U78ZA1jQinV0dBj0hFZBEmwhrCcY/lLWlv8cE7MTxjC8tjd19QII8J?=
 =?us-ascii?Q?yP1HQ5O5Se9sNhxCSDyAgn+DL8MnOugtJ/rxtH69GVNzOpmDk38k0bdk9SvF?=
 =?us-ascii?Q?wx7fwkzQEnvNWDqfZgIe64z8gBi1ivCfKvfIIRfG5ol58fU3VS+lWMVOyVCW?=
 =?us-ascii?Q?ZG9OBrjw4C6fa2wDM9fU2R6eAppG8qV7+0IP1AB0DgRxtAsarpJWD7hU1teV?=
 =?us-ascii?Q?b4xNU2ih8qhsGnNWGiTHdx0YxINvRgS8ebXWDzW0idA2HN3lgMIkrXvyURj2?=
 =?us-ascii?Q?VDIuKwxaKM+DMrXtx5cLBm+YssqpbQiNrsAEZCeLxgeMB/tyOY8ze2n68d7v?=
 =?us-ascii?Q?fHUxQOakeR4Nbcb6B4JhVM9ruCgkVK8S6BiwtBlmLxUwjfzKVjfm8Q4zlm/2?=
 =?us-ascii?Q?cJny4ql/GkXlmwPhzXSyMihKF0xyETvBU8RbPcxcnDq8CrjzUQaAA2wJYCzW?=
 =?us-ascii?Q?c04ErnGlDTshRFj+4BhEyUhzi5KA0Hq1AMlGrptT6vzGsIIu8lhMqpvLd1Dp?=
 =?us-ascii?Q?U4nx6ydIbfe3hY+yU0vb28DvFC8y4P03jfFQ25qByY2JozS3PplIAq2Kaz6z?=
 =?us-ascii?Q?zIZrw5QevsjU+8M5q9QkeNidYJ72vIW//PbUUXYkkNC8doOyUXliTz9fvuHV?=
 =?us-ascii?Q?2Iqj9cYEJdRuDmCqYfx3em7P/K1SJcAaZW/kAJ7NaDoevLnG0me+ygu+1feq?=
 =?us-ascii?Q?AE0nqBJ6k4Xn4vRkXJt8l3+wIh/vdvva1Tf1ahaIBSds9Xncp3JbFdi3FyMh?=
 =?us-ascii?Q?GtHvzDoTJM6xmLPi6RRE/AblpNVqpjrvca2nr+6ywV0rlocTtCLUuZDR8mIG?=
 =?us-ascii?Q?4Pa1Oo2bcN568rLpMXNIq9/mfgCzc6GeqFajQp5LaGL05Z8TrevePMg+25+7?=
 =?us-ascii?Q?F2kWzwjgeGBylXXERW3IyemVjkV+Fv7KtIwjz8UbYdX25L7N9lvDbnP9U1KE?=
 =?us-ascii?Q?1ARsXqgDQvTiwpQ7wJ5nH1tpe2x/P94J2aPz/mYJkqtsaZ5tHGpctF+JeuY0?=
 =?us-ascii?Q?PoBdjt6mPazeukCNPC9/ZPg/TOI2oTvq21I3kfb86ASBQcXQa99m0oBJ2mc3?=
 =?us-ascii?Q?0xCS+yj0Xx45+fEfVmOVL2H0XR7i+Rb468vhlMG76hwefqfPbfbI1flxVLJ3?=
 =?us-ascii?Q?TCbEHm7Q9xd62MVjX4gZ32rrvBu4035oZngC0LuQFRZ/RsqHmuWqrnJBTKoe?=
 =?us-ascii?Q?fGtjCmJ6B0zpnRsuex1C8Xje+n1M1uuy37ztVTLO2Q9IdpXdNkrtWWc4VQp7?=
 =?us-ascii?Q?Z/Mq1N6ceKz7mwGn/UphSQL9WrqkR7A/8lZGeeoSUdUM6BmtjAWPVfXjtQlz?=
 =?us-ascii?Q?JvKZJQm+Sz7lbLECxFvR9AHIzQbcAXr0tAWt+vJa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbe4448-9c98-4447-79eb-08dbc9962b36
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 13:38:20.9767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a3VrGo2W1t5u7jaKIHqgDLJFtaN0TCeW8+bSkliTWreb4iIMpD+mp9Puk8WdW/Cy+3qn620CArZpXoGckIASFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5956
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, October 7, 2023 2:06 AM
> To: Zhang, Tina <tina.zhang@intel.com>
> Cc: Tian, Kevin <kevin.tian@intel.com>; Lu Baolu <baolu.lu@linux.intel.co=
m>;
> Michael Shavit <mshavit@google.com>; Vasant Hegde
> <vasant.hegde@amd.com>; iommu@lists.linux.dev; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v5 5/6] iommu: Support mm PASID 1:n with sva domains
>=20
> On Mon, Sep 25, 2023 at 10:38:12AM +0800, Tina Zhang wrote:
> > Each mm bound to devices gets a PASID and corresponding sva domains
> > allocated in iommu_sva_bind_device(), which are referenced by
> iommu_mm
> > field of the mm. The PASID is released in __mmdrop(), while a sva
> > domain is released when no one is using it (the reference count is
> > decremented in iommu_sva_unbind_device()). However, although sva
> > domains and their PASID are separate objects such that their own life
> > cycles could be handled independently, an enqcmd use case may require
> > releasing the PASID in releasing the mm (i.e., once a PASID is
> > allocated for a mm, it will be permanently used by the mm and won't be
> > released until the end of mm) and only allows to drop the PASID after
> > the sva domains are released. To this end, mmgrab() is called in
> > iommu_sva_domain_alloc() to increment the mm reference count and
> > mmdrop() is invoked in
> > iommu_domain_free() to decrement the mm reference count.
> >
> > Since the required info of PASID and sva domains is kept in struct
> > iommu_mm_data of a mm, use mm->iommu_mm field instead of the old
> pasid
> > field in mm struct. The sva domain list is protected by iommu_sva_lock.
> >
> > Besides, this patch removes mm_pasid_init(), as with the introduced
> > iommu_mm structure, initializing mm pasid in mm_init() is unnecessary.
> >
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> > Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> > ---
> >
> > Change in v5:
> > - Use smp_store_release() & READ_ONCE() in storing and loading mm's
> >   pasid value.
> >
> > Change in v4:
> > - Rebase to v6.6-rc1.
> >
> >  drivers/iommu/iommu-sva.c | 40 +++++++++++++++++++++++++++-----------
> -
> >  include/linux/iommu.h     | 18 +++++++++++-------
> >  kernel/fork.c             |  1 -
> >  3 files changed, 39 insertions(+), 20 deletions(-)
>=20
> I was wondering what Nicolin's issue was, didn't see anything.
>=20
> But I think you should incorporate this into the patch.
>=20
> And there is a straightforward way to move the global lock into the
> iommu_mm_data that we can explore later.
OK. Let's try it. Hope this could solve the issue reported by Nicolin.

Regards,
-Tina
