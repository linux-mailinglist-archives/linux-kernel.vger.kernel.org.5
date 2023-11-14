Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92997EAA23
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 06:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjKNFbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 00:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNFbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 00:31:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A789BC5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 21:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699939889; x=1731475889;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kK0uInazJhbKRixXg/Iut0udCefAJgZZ6t0EyQNLgzA=;
  b=cg1Vn9oPzETauJqS/38GHYpZAAlT4SxgS9Amfafvwey/GDFgsHw4tUOT
   lUabjKDajLeA4KLkEbbduqL0WbSvURINdKtQYur6/i5k3ZFWoxMuYSZQm
   vCzNeurX/Jh6NbXA2MQGSvb/3UCAoxIA8cg9t2J19q561CA4DYRSBNZDy
   CW13xcl/4jy5wS9Zq9jO+AfcbE+3MLVjeQY/7+gK/ETYJaReyzU0F1xlJ
   xe+LLB4Lm0qYrk8wo9kaG+K3V/sppylVoMJMZweg3/dcPGfJw2vlCjz9o
   P6b1o2cXlC1IBj2TCOkCm1bztQ5lYdNnH92cI0Sncsn6WnvMBXl3eBMBM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="393444275"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="393444275"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 21:31:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="768147470"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="768147470"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 21:31:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 21:31:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 21:31:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 21:31:27 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 21:31:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1HufyA+H1SJhKnaCocAF730abbQ+GSMi6w4T/uBFdg1UaecB11GvMOGCB6qCM3lk2TQSxwv5G/+yZLPz4GcD9WOAXupyLnXO9kuxdrSqHJiJ6+8lYWuWLQWx7EAallR+v+1wn7GGQa5NqmrPWo250Wm1sfAy3jgfL3qPDS1I/c0h3lQdqW/y8E2VvhtTZ2UkL3kR7xMOrWNnmoSffEIHnSeDURZNzuh8I3fUJlRjZtXp/c4l4FqsNJm4GYNXvGwFLkyMmWzTgGA8crsN/MGnJnaeuVJD8qSJI9Jp3jVy56ULJMg+raysrxj17zVHMnMEfjo4NvP/+lBb2lJij6pWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kK0uInazJhbKRixXg/Iut0udCefAJgZZ6t0EyQNLgzA=;
 b=YufkUwBtudZyJACoFc+22K/Vth4gaX/at5uTdgWk6ZAJ1AjZ+L4TCJ/Ldz0c1uVm6rusmJDOxFNb1E93pkxZvFobJjEpkSvUrxz6rb7ZbazdkM9DO/QM+lxqrF9PvdzVs25Vo7/GJKJd1pGKSWeh+JwWN8p00lT3zulVuAEZuShz2GI0kuuBAscqYIT5U/VC/3rNIYwZGR7zpt1/j+wdd3y7rb5mvV6yY1MYCiSUr8N4vDGR82vrSAa5aFAhx7Wl/kNNSvtKODoBTNuZ8cmEclFurXLQVETH27M2sDf7fO2JeW0l9D9EdruOnEO8tSRainxfnjaJuooL8KaBRhN9nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8576.namprd11.prod.outlook.com (2603:10b6:806:3b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 05:31:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 05:31:20 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
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
Thread-Index: AQHaFpgA5wtOoye5ZkuI8htuBJqfJLB5I8pwgAAAI4CAABlw0IAAAtMAgAAKFQA=
Date:   Tue, 14 Nov 2023 05:31:20 +0000
Message-ID: <BN9PR11MB527662008A42304A70AFA2378CB2A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231114011036.70142-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52764263BE04AAFAC0907A8D8CB2A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <1a07a265-f834-4834-b9cb-5c7016ee9142@linux.intel.com>
 <BN9PR11MB52761EDB3AE90DE87661A3C28CB2A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <79b2f656-6342-4f46-a4cf-fe8152f1c67f@linux.intel.com>
In-Reply-To: <79b2f656-6342-4f46-a4cf-fe8152f1c67f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8576:EE_
x-ms-office365-filtering-correlation-id: 6c0ce04c-0ead-4129-8c7e-08dbe4d2eec1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RDPjSPmes438AkeIg5FwFeDqe0tzXA3L7mHFqUh7eMQDfl1k8030Xsxs9vUh9r9grgGm4h5NKFIbgrpNrhQlZoKrqTZMLZsuB61xlKrYlAdiiVpcQ3yfbsLkU2tu2nMYHy7e/ds5shEBsO4xkN1C2liTwZEtjhRI1ghXu431aSxsWIVvKD2lCjddrVIVsO2fghVyNFK2S+M5aEs5HQ9LkA+CqOqg1G0PRAIinfH3eoGeRmPSSxYwLQdvNt4C+PPj7oWOF3TumTHV/SzpAE8oPj2pXykYKVcOUNuQOYRpLSKuOAwDogwGn81jI5KSCfrRHpuASsbsnSE80mA1T4ITXbOeuH42U45PsxgNVyirDOPFlq50LiiiLYm7EGTRlUdnddFpAj93yhfJoPjrt5cITuZjbPQFGwS2SnV1pyCltdeIHXHsN8t+YebyNCxbSw8CIJwFCHmAhIPBnpOejfFE+d66d8COxbT7seZfBvCihQqg2VJ2f4KmtScCnL7ympp6anbo1/l276muGm2NBSsFSdTF8oYbD6OPHSTDG5zq0SZYN8fgnC40vZVsQfDXPkyaUH900P8BBpu1ZK3ey+pnGv70heOYcnwe2moWN1bJUGiGpOBXY/uOyFUHLtrF9Hrp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(82960400001)(71200400001)(53546011)(6506007)(9686003)(83380400001)(52536014)(5660300002)(4326008)(41300700001)(8936002)(8676002)(478600001)(2906002)(7696005)(110136005)(66476007)(316002)(66946007)(66556008)(54906003)(76116006)(64756008)(66446008)(122000001)(86362001)(33656002)(38100700002)(26005)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXh5aUZ2M2ViN2VaZXQzUjNjbTB2T2R5dVVoK3ZweFdKK2pwb2dtUEhwRnEz?=
 =?utf-8?B?ZHlybk5UWGUzWTdCY0d1RDdVUUpjK2hNNlBKWW8zajFiSmVjd2tMZHNESTJh?=
 =?utf-8?B?cGE0ZHFIbGxWK1FnMis0eXVmSXlmdXAvUFhOSEhMaTVUZngzajcyOE0razg2?=
 =?utf-8?B?NmQ1OWxJWFFzWHQ2bWNpc25oaDRraHBLWE5UMHhGQjM0TmI0OUIrandwaklt?=
 =?utf-8?B?WlVOVGhmaUFzUmJqODhmVXJaZzVaYlN0a0JzZXdYRVF6SUFPNFRYWjgzQnZx?=
 =?utf-8?B?cTVVbDJEZHZkNW1wcDB5c1RGalJSY0VhWVdwbG5nUUUvWG1peS9hL1B1c202?=
 =?utf-8?B?OFluTlhkSHhSbTZIbGoyUDB4SUN3L0xMak9xYmtiQUw0UGxtOThIZmlJTCsy?=
 =?utf-8?B?Q3hKTWRFYmNsbGFZWElwOHUwSjc5VjI1VXRMTjlyOE51bDJRUDlWajN3OFlv?=
 =?utf-8?B?cTRIUHExb0VwUGxYZDQ0d3BmRk5tMjZyTy9xRS9QQm9wUmdFV3k0bnFsWTZP?=
 =?utf-8?B?aDVaaUh2aTFmajc2M0tRQ3ZmdE9MTVBoVU5qMWcvUEphZlFGR1Y1L3ZkbEVl?=
 =?utf-8?B?eC9XL0RCYTMxak9IVkRYRmhzMzkvZktaMjJOd25BRWxzSE9ZdDI2ZkM3YWt1?=
 =?utf-8?B?V1U1blpkRzlVYzhWMUQvVmJ3NkRGZ0ZubmQvalNqMlphR3BDLzdGNlVCVy9Z?=
 =?utf-8?B?TVFRQ2p5MTdsRVMrNGZQanZGY1B5QTk1ZUplU1p2clFkZlJ0MDI4WU41dzBE?=
 =?utf-8?B?Sll3aGpCRWxodjEya0FBSWduVHBZd1ByU1QwOG1xUk92S2l6SklhTlRmVUF1?=
 =?utf-8?B?NDJyVjZnRVdmUEpQeDhzalVFZ3JJRkxhSjBubmNxczdOcXArTS9kbVRZQnJ2?=
 =?utf-8?B?ZEZvUG5oVVR5UFVYMmg4YXR5VnVFNEo4cmF1M0o5aTYxSVdTRFNnWW5OU04y?=
 =?utf-8?B?bGcxbU5KbURicmNibzJRT2ZadWVlTllFcVRialBsSHJ3ekUvVlVGMW1PWnNO?=
 =?utf-8?B?RjhDQngxVm9CeE9TZnhvZ010MzBuTWhjTFZ1U0VaRlViREFjU09CbEx6MWVK?=
 =?utf-8?B?d05YT2FhU0pRemRCUkhMNUtQVXNOeWIwUnZYbnRwMm1uSDNvNE9wUm9QQUpt?=
 =?utf-8?B?U3IxTlgzSWxRb1NlUlFFOXBVLzZoYkN6d0dJWTdGRmF3SXRYQU1rMmpOS0U5?=
 =?utf-8?B?eWJDeTNFaWtxekFoalZBamtwc1VkS3gvVXp1Znp3SmkrM3M4MUNncms5VmFG?=
 =?utf-8?B?VVdoMXpIK2oyTGF2Ylo3YkN0a3ZWU2VoSHRlMTBtOFphQjhISkNQUExQV2lU?=
 =?utf-8?B?STlQMUpOSmx3NmNTTnYxd3FJcUZ1MmQrMEQ3RW9Oa1BJeVQvUWV6QW93b0lp?=
 =?utf-8?B?UHRBWHUxdHkrcktGYTY5OFNTNjZtNWJPMUFod09hM3d5amNEMUFGVjU1WTZ6?=
 =?utf-8?B?VWZrR0wycmIvaWtDcDZvSVFQR3VuM3EzU2cwZVVSNnV5UmdjNGEzbkV2REFL?=
 =?utf-8?B?bmlOZWFPOW5RU2dnYkkwY1BtL281RWRQRWtEaEJZSzdMaXlkMUwzNG1TQWdo?=
 =?utf-8?B?Q2QrdEZvVE5aQmZDQVl0Wm8wS0NDTU0vWWltNHg1LzNZOGk3Rms5c2tSRXdG?=
 =?utf-8?B?U05FRFhwU21LYm00UllzNml4b1hxOGtwOVR1TVRIV2t3dVJLQUhoc2FyZUpR?=
 =?utf-8?B?T2RNcnlNeTZaZUowT05XblZvV3ZUMFNkQWdKS1Q3YlZvendtVkdhdTNGRFhz?=
 =?utf-8?B?MDArRXpOQlgzc3RFcm9SNGJLY0lVYTREWjZ3UE1KZ3pqWVRobTdJY1NZTUww?=
 =?utf-8?B?c1JzbGVXNTlCTk4wVGR4STJoYXdhUk5EM1AvSjRjbC9iVlczZUoySHpid2Np?=
 =?utf-8?B?Q3RoRVZkUkh6Q21TSWhJZENVMHgrQkZEb2QzOVhabnFMc1B5blBiM1FQR29D?=
 =?utf-8?B?Vkh0QzM2bTFHNC8xWUJCaGEwaEFEM1hCSElLbXRMSitkQUpPTFlQV0x6MWVE?=
 =?utf-8?B?SUx3WVcvK1FQYVM1aFg5a0FQbm4ySWIrVDNHbmZNRFdjWWdmTnYvRXp2bkt5?=
 =?utf-8?B?bnhUc29JdGhvc0RBangwNmNtandjS29jWkpOKzVqcFlsV2UyUjcxMHlBdE5K?=
 =?utf-8?Q?dqENN9O8L8FoJCfurg3ouw5Z9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0ce04c-0ead-4129-8c7e-08dbe4d2eec1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 05:31:20.2404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j1huNgvOme97VEoAZY73ZzmB/vs4e+wFb+Pdew5UKhbcqzIURyJBODyZVsUNgJg8j+53tgHBhi9SemlOcDCxpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8576
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBOb3ZlbWJlciAxNCwgMjAyMyAxMjo1NSBQTQ0KPiANCj4gT24gMTEvMTQvMjMgMTI6NDUg
UE0sIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGlu
dXguaW50ZWwuY29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxNCwgMjAyMyAxMTox
NCBBTQ0KPiA+Pg0KPiA+PiBPbiAxMS8xNC8yMyAxMToxNCBBTSwgVGlhbiwgS2V2aW4gd3JvdGU6
DQo+ID4+Pj4gRnJvbTogTHUgQmFvbHU8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiA+Pj4+
IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDE0LCAyMDIzIDk6MTEgQU0NCj4gPj4+Pg0KPiA+Pj4+
IFRoZSBsYXRlc3QgVlQtZCBzcGVjIGluZGljYXRlcyB0aGF0IHdoZW4gcmVtYXBwaW5nIGhhcmR3
YXJlIGlzDQo+IGRpc2FibGVkDQo+ID4+Pj4gKFRFUz0wIGluIEdsb2JhbCBTdGF0dXMgUmVnaXN0
ZXIpLCB1cHN0cmVhbSBBVFMgSW52YWxpZGF0aW9uIENvbXBsZXRpb24NCj4gPj4+PiByZXF1ZXN0
cyBhcmUgdHJlYXRlZCBhcyBVUiAoVW5zdXBwb3J0ZWQgUmVxdWVzdCkuDQo+ID4+Pj4NCj4gPj4+
PiBDb25zZXF1ZW50bHksIHRoZSBzcGVjIHJlY29tbWVuZHMgaW4gc2VjdGlvbiA0LjMgSGFuZGxp
bmcgb2YgRGV2aWNlLQ0KPiBUTEINCj4gPj4+PiBJbnZhbGlkYXRpb25zIHRoYXQgc29mdHdhcmUg
cmVmcmFpbiBmcm9tIHN1Ym1pdHRpbmcgYW55IERldmljZS1UTEINCj4gPj4+PiBpbnZhbGlkYXRp
b24gcmVxdWVzdHMgd2hlbiBhZGRyZXNzIHJlbWFwcGluZyBoYXJkd2FyZSBpcyBkaXNhYmxlZC4N
Cj4gPj4+Pg0KPiA+Pj4+IFZlcmlmeSBhZGRyZXNzIHJlbWFwcGluZyBoYXJkd2FyZSBpcyBlbmFi
bGVkIHByaW9yIHRvIHN1Ym1pdHRpbmcNCj4gRGV2aWNlLQ0KPiA+Pj4+IFRMQiBpbnZhbGlkYXRp
b24gcmVxdWVzdHMuDQo+ID4+Pj4NCj4gPj4+PiBGaXhlczogNzkyZmI0M2NlMmM5ICgiaW9tbXUv
dnQtZDogRW5hYmxlIEludGVsIElPTU1VIHNjYWxhYmxlIG1vZGUNCj4gYnkNCj4gPj4+PiBkZWZh
dWx0IikNCj4gPj4+PiBTaWduZWQtb2ZmLWJ5OiBMdSBCYW9sdTxiYW9sdS5sdUBsaW51eC5pbnRl
bC5jb20+DQo+ID4+Pj4gLS0tDQo+ID4+Pj4gICAgZHJpdmVycy9pb21tdS9pbnRlbC9kbWFyLmMg
fCAxOCArKysrKysrKysrKysrKysrKysNCj4gPj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMTggaW5z
ZXJ0aW9ucygrKQ0KPiA+Pj4+DQo+ID4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50
ZWwvZG1hci5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9kbWFyLmMNCj4gPj4+PiBpbmRleCBhMzQx
NGFmZTExYjAuLjIzY2I4MGQ2MmE5YSAxMDA2NDQNCj4gPj4+PiAtLS0gYS9kcml2ZXJzL2lvbW11
L2ludGVsL2RtYXIuYw0KPiA+Pj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvZG1hci5jDQo+
ID4+Pj4gQEAgLTE1MjIsNiArMTUyMiwxNSBAQCB2b2lkIHFpX2ZsdXNoX2Rldl9pb3RsYihzdHJ1
Y3QgaW50ZWxfaW9tbXUNCj4gPj4+PiAqaW9tbXUsIHUxNiBzaWQsIHUxNiBwZnNpZCwNCj4gPj4+
PiAgICB7DQo+ID4+Pj4gICAgCXN0cnVjdCBxaV9kZXNjIGRlc2M7DQo+ID4+Pj4NCj4gPj4+PiAr
CS8qDQo+ID4+Pj4gKwkgKiBWVC1kIHNwZWMsIHNlY3Rpb24gNC4zOg0KPiA+Pj4+ICsJICoNCj4g
Pj4+PiArCSAqIFNvZnR3YXJlIGlzIHJlY29tbWVuZGVkIHRvIG5vdCBzdWJtaXQgYW55IERldmlj
ZS1UTEINCj4gPj4+PiBpbnZhbGlkYXRpb24NCj4gPj4+PiArCSAqIHJlcXVlc3RzIHdoaWxlIGFk
ZHJlc3MgcmVtYXBwaW5nIGhhcmR3YXJlIGlzIGRpc2FibGVkLg0KPiA+Pj4+ICsJICovDQo+ID4+
Pj4gKwlpZiAoIShpb21tdS0+Z2NtZCAmIERNQV9HQ01EX1RFKSkNCj4gPj4+PiArCQlyZXR1cm47
DQo+ID4+Pj4gKw0KPiA+Pj4gSXMgaXQgYSB2YWxpZCBjYXNlIHRvIHNlZSBzdWNoIHJlcXVlc3Qg
d2hlbiB0aGUgaW9tbXUgaXMgZGlzYWJsZWQ/DQo+ID4+PiBJZiBub3QgdGhlbiBsZXQncyBhZGQg
YSBXQVJOLg0KPiA+Pg0KPiA+PiBUaGVyZSBtaWdodCBiZSB2YWxpZCBjYXNlcy4gVGhlIFZULWQg
dHJhbnNsYXRpb24gaXMgdHVybmVkIG9uIGFmdGVyIGFsbA0KPiA+PiBkZXZpY2VzIGdldCBwcm9i
ZWQuDQo+ID4+DQo+ID4NCj4gPiBidXQgSSBkaWRuJ3QgZ2V0IHdoeSB0aGVyZSB3aWxsIGJlIGFj
dHVhbCBtYXBwaW5nIGNoYW5nZXMgYmVmb3JlDQo+ID4gdnRkIHRyYW5zbGF0aW9uIGlzIGVuYWJs
ZWQuLi4NCj4gDQo+IEZvciBhbiBleGFtcGxlLCBpbiBpb21tdV9jcmVhdGVfZGV2aWNlX2RpcmVj
dF9tYXBwaW5ncygpLA0KPiBpb21tdV9mbHVzaF9pb3RsYl9hbGwoKSBpcyBjYWxsZWQgYWZ0ZXIg
ZGlyZWN0IG1hcHBpbmdzIGFyZSBjcmVhdGVkLg0KPiANCg0KT2theS4NCg0KUmV2aWV3ZWQtYnk6
IEtldmluIFRpYW4gPGtldmluLnRpYW5AaW50ZWwuY29tPg0K
