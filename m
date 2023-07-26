Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1407628C2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 04:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGZCb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 22:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjGZCb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 22:31:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7342695;
        Tue, 25 Jul 2023 19:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690338712; x=1721874712;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LUSUCKdU4C7o6dcfr2QF81uR8BX6JLic8D8VIT8KW84=;
  b=O63gwC8yPAUllpLzfhi7UrWRzhEQxgVWf20MgOlmBqUwcYqbikk4vh+m
   r2cUuP58VZfyIJkRRKDXFtwZbUJi4IMqUJspGtwXusUFRuSIFtGTIFTG0
   M9qApQe1+MpZu2hzb3dXMYXsTxKuQnwKJQjCzjTxXDQJwyg1t/5es+7vx
   8RqO+u2U1orlztq8h9g44oTociYo3FVIYqUoFLm6Zl09BE8JHyQ/IGJ1B
   VUYWRYZciRuhvQ8rlY7wJR5WDFxOMYDYyK24xopB83cR/lOx18wtOO+/C
   wqRSTLubIWx9yrg1b1gHtB3tgOd8apMei9Onx24PQTy7CGDV9x0fkItkA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="434148692"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="434148692"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 19:31:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="791626129"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="791626129"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jul 2023 19:31:51 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 19:31:50 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 19:31:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 25 Jul 2023 19:31:50 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 25 Jul 2023 19:31:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpJ/9RikRCuORkqwgTB5/Xvt6zeL0QSGnMpaOcdnKu2zYSXzGeJTOzk0MO3PZ7O3Gq6HO8f2uxUr3whs4NBgC2fwBTiQymRTigwtFN8URlEDCS+3JVtWZBj77s37FOfcaKbumugD9vUKOICUlBsOsjwWLEDg+jnnVchSfzua8zw2fyyqF0ZKz9YUFSvdjJjUF2bpM1LirUWIhnKzQbivklRIk2e4j2xQsayaQnaXmx8oPPh1VOUpgk6ilBCV8yGtSvTPfXDu5YpYFKBa+lJ8yFJ+Wkpq4AGWQ1m3EUBf8CH5AmHrT/dHIIJ1kH3CeAthMttWuJoGdIkmrF94AGxQSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sk8/Ay1SoaHY0QW/aIV19GoNZ6C/2zF4Mhcm345gMX8=;
 b=TjXtEaUL6GtuBQltHFW+IGE/qMe8jHra9W+v9JEfNXP1YpSV8IWMZQyAQfk46defpbWSjWUO5zQGqP66+jbrvADrthVws5Fr/CC9dIaDiPyz9CgleZr5HrN4pfc+m6m5UEJS/44gcwHUhe4mPidKnTfOBJLAJe8wR5g7jPRLWWP8rDUwRIU+OqHYF/E/leNydjVzwX8uKUTlOIxjCZ8j8QK7q/jXSLyNP+PNlJe7k0tz/OTze1zqSgP+q9eHaqy7C3jwoWSH0HRT3QyqxZ1W1npcoGG42SRE/LPDptkRWfX5oetl+pnQXWoYPk65wF9vhL0glUqtMzGqjpZvdfp3sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CO1PR11MB4929.namprd11.prod.outlook.com (2603:10b6:303:6d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 02:31:48 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::afe6:1e86:52cc:f71d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::afe6:1e86:52cc:f71d%4]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 02:31:48 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     Borislav Petkov <bp@alien8.de>, Aristeu Rozanski <aris@redhat.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lim, Ee Wey" <ee.wey.lim@intel.com>
Subject: RE: [PATCH 1/1] EDAC/igen6: Fix the issue of no error events
Thread-Topic: [PATCH 1/1] EDAC/igen6: Fix the issue of no error events
Thread-Index: AQHZvs70SFSyROm3IU+Y3Dd4qGeH36/KohwAgACusbA=
Date:   Wed, 26 Jul 2023 02:31:47 +0000
Message-ID: <CY8PR11MB71348563C78864640BC3B9248900A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20230725080427.23883-1-qiuxu.zhuo@intel.com>
 <SJ1PR11MB6083D914A12B64369E478BA3FC03A@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083D914A12B64369E478BA3FC03A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CO1PR11MB4929:EE_
x-ms-office365-filtering-correlation-id: 2bbbf804-43a9-4c23-d4af-08db8d80760f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v10f93ITXsatQSrVEgkFPbOEJGy/Kgf/z+uWWh+auexMJPs8jav7OyZVPmwTO/Xxqiv9DxNB4zV0s2BNAmqEhnxGZ/dyXfr0ER9LMNy1ySr3PrfE1oFtZhaz2ceQ7GkETt36/S8zXLHNZhXEfgF2aZSO2r5kS4hGBEUNJAgPVBKPXmLJBqHJCL8fq6rcxAs+9S6xZaYvUOdhsMIhXudCqcAYy/3YCGGkrdTnxsSfUUdx6acWal7Yb0sb763YTCHRbzcGROIYPakyjj3Hcgjplj1V140MXNA56b2wa5vyqSRr7ZO3QoLKyQAC8ao8+Q4gzfzZr7UcGFnj4a47BaNsm2ymLkW39ISnIAe+b7bg7f0d/9NJBO9N2BFTmHOdYlpu+RUKtCGenaRH4H9+IR2fh9x8eiyraBcxkrYqVEMd+dBmq9jlMqrTHvscbYqIZo9K2JTsVNcZad/uhxSL1ot29Dsn+TzKiNmNsEIljHwfBEeBbLCCczFjNaIFzY2be2obPHlWt24jI3X70qbYl+t9HfNfQXSGYpOaIS8z48bKFgBMw8/ckUFzrMmhHpZfp5UguXNYATkELjK2/cTuLm56+StaAx3GURzGty81VZy60FTdVqMjbkuOe6WydDzUgIAn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199021)(478600001)(54906003)(86362001)(38100700002)(66946007)(76116006)(6636002)(316002)(4326008)(122000001)(66556008)(64756008)(66476007)(66446008)(6506007)(82960400001)(38070700005)(71200400001)(186003)(26005)(107886003)(7696005)(9686003)(5660300002)(52536014)(8676002)(6862004)(8936002)(33656002)(41300700001)(2906002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mxTHSWPUcJaJUI0Joy/yPFdF5EH/TWTVXSziV96yKHMF6Nz0uneYcRBbF2J4?=
 =?us-ascii?Q?256WQgzUu78t919q/IhUm1ASKEWrjgVnfjq+VpI7Tor5fJ8JESqx3gtu6p6j?=
 =?us-ascii?Q?0u6uKmtxkbTzZy7Xkpdzo/HlauVs38fQnpr23F27F6aLLetI9yLywxy9rL+J?=
 =?us-ascii?Q?GHNRt5RSb6wpkvN2/X0hjEP8NUmUoUYDnIpI4RLHM1eCyAL/TE+Z/SlPn9wS?=
 =?us-ascii?Q?kH0tNRBCalY+Smg2TK7MvpOJluqFJpDUItw1nBXIZgOHqskxU5UpBhKA0XDH?=
 =?us-ascii?Q?iEgFUcQF5+CIv+HHHObl0pHNyCHLm37OC3kNJhoUQ1WKW8P5dbj+r24k6+hh?=
 =?us-ascii?Q?BZCgSO4CiowT4omZFErG4KRd+FntgHPoREbi904AiiIrvIfHLWsnsedp/S0W?=
 =?us-ascii?Q?Lkhoqot8FSnS+XwN3SRaO6LwMJqhmtjdQQl0Exq8Hm6Lwv/Adn6oEOYH5T/S?=
 =?us-ascii?Q?Ox21YB/Klm9tF3ht6vj0vrbDJMTKRuhbrp8Bqe9CmOYM4YpFbhVFWSR1JJtU?=
 =?us-ascii?Q?y6zZRv43UZxou1L68yfNg6to2J8u8voNIVb7jTD2QEIlMg1YXWQ0IcWgUMUV?=
 =?us-ascii?Q?7fZ+9WN1eNi/7AQFFfXPsyuQ2541ljqomT4jxXEl1Q3lQnk+aFzQ7TPWhqT7?=
 =?us-ascii?Q?wAniK0n+kex4mLxRTT0PRjVR8xLjfG3F/q7FguXtCOQj7BsHyL1bPS0Km9vr?=
 =?us-ascii?Q?sFXuPbtdqTegCzFU2tJO5kuH5HQGk3+/0TL77F3y3P9fslZnqLrXCPYSFWb7?=
 =?us-ascii?Q?ZxcWLR4hfbhi2qICFGo+WAEVF7K7N6mEQe0ECAAQJgS0VvW5mzU3deJB7v8N?=
 =?us-ascii?Q?Tr/Z/HDY3l96LlCUEl7TbpLiCBOdHgiF74vd2rPjlLDMV6oDD5zSBSPTL98b?=
 =?us-ascii?Q?gsgBTr9FTG+aVFrBew7bM/ROUxa25RNIShkbFnKVoEKYhY2muFQlXdWfAugt?=
 =?us-ascii?Q?vAzTytXuE2lT/gbJeLM+qFKZm/dAsJRC2Lo5+D/+VCNDpPjbDpGXkDObjc7v?=
 =?us-ascii?Q?m9uuwhKqDICJm0Pjrp2gaWEyfCpzPkoYa0IvGZfncYpFjS2PR1zPH/FAKwtp?=
 =?us-ascii?Q?QGdePhr2/Kbgujvha2d7OXoU0O/R6YbKy8lYwPsI9IS9iP3Uc6ttV6IjHyR+?=
 =?us-ascii?Q?oq3Fi9psbhh6wVfyWpd/Z747HEf/8g09pxol+PEJCoRkihxhVasQWWvKrWBl?=
 =?us-ascii?Q?c1PHR32Pjuk/1iF3v4ziUOaYXTJ4NiVia8Wow70bQwo+bvdEJHcncBSDK+Ol?=
 =?us-ascii?Q?uJ/WFEslNfTgYxIMjintwksYmO0xRwnGXVLCYpJ+bYJINkwbL4oa1nFUtBnC?=
 =?us-ascii?Q?cYTqO2N8aXAiH21vuD2uY7gNax7MYdKL2hnKSllDP5sgJ3AfoWF3bVxZz1in?=
 =?us-ascii?Q?KwiUytRw1Cig/fmJ8Ic7HilMyyt/dRmlM8l0XFrS9Ja03Wk8GcUu3rpmnhcz?=
 =?us-ascii?Q?u2dLARIK/4qtcngQBsiQg59yM0VRkyzMQXGRsJ8mh3fN2FHaqAnubPS3k1m1?=
 =?us-ascii?Q?IBgJhEqKnqH4moqlOPRAQN2iSzdwPVdcogf8b8A1oF01s8f0nejW1dsYkYjL?=
 =?us-ascii?Q?60AvrQ9LWKru3hAA/SPUeSadwQuag7GWCW4AXWRP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbbf804-43a9-4c23-d4af-08db8d80760f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 02:31:47.8966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 25ZoU+VAofjgRCGQ34NcH28yRVzBVPEovmPvSouE9qOnyclFgV9cRZJTXL0VoX8MCZrRiKuxHUblK9hROPlu4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4929
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Luck, Tony <tony.luck@intel.com>
> ...
> Subject: RE: [PATCH 1/1] EDAC/igen6: Fix the issue of no error events
>=20
> > Fix this issue by moving the pending error handler after the
> > registration of the error handler, ensuring that no pending errors are =
left
> unhandled.
>=20
> Do you think drivers/edac/e7xxx_edac.c has the same issue?

Hi Tony,

Based on the code [1], the e7xxx_edac works in polling mode and the pending=
=20
errors can be handled within one period after the error handler registratio=
n.

So, I don't think the e7xxx_edac has the same issue.

[1] e7xxx_probe1()-> mci->edac_check =3D e7xxx_check;
                                  -> edac_mc_add_mc() -> if (mci->edac_chec=
k) { mci->op_state =3D OP_RUNNING_POLL; ... }

> 491
> 492         /* clear any pending errors, or initial state bits */
> 493         e7xxx_get_error_info(mci, &discard);

                   This function is also invoked periodically in polling mo=
de:
                   mci->edac_check() -> e7xxx_check() -> e7xxx_get_error_in=
fo()

> 494
> 495         /* Here we assume that we will never see multiple instances o=
f this
> 496          * type of memory controller.  The ID is therefore hardcoded =
to 0.
> 497          */
> 498         if (edac_mc_add_mc(mci)) {
> 499                 edac_dbg(3, "failed edac_mc_add_mc()\n");
> 500                 goto fail1;
> 501         }
> 502
> 503         /* allocating generic PCI control info */
> 504         e7xxx_pci =3D edac_pci_create_generic_ctl(&pdev->dev,
> EDAC_MOD_STR);
>=20
> Though it might be hard to find such an old system to test.
>=20
> -Tony

