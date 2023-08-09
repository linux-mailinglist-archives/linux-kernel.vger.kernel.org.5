Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8815C7756A9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjHIJt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjHIJtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:49:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5597D1FD8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 02:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691574565; x=1723110565;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IPcaqGiIYdoUsphKBbTe4/pPWXVa4g2QUPPLIjUaE6k=;
  b=igMfpmo8s1VvxuQiNrBkoIGEd6be2flT1qgfTL5mu5oKJKcB96PJ74wZ
   kfkv4YXC0coijPFeqz/g41CeI6ZKnxkq3Qje1DR1H/k/ZYSPJmOSIML8C
   p6jZRaH1dgqeazu/uc28VCdo0rgG6A2UkUbDCuEXdw1zfUSJibwQ4y3WW
   UgXjsmfHFWPnD8W/xTn9jjhImWtXTNFVD0CBdBtb6jKkM9BpeKHFEysGf
   rJFyAACsGpWstaOesjSeb+7Yi2xU3rFwh6t7n4FkUdyOEZLhdrjiOokQM
   8YoDPmeOluVJCOseEcYQ+5dgQ+Mp6j2i/Ermleix8h3PY2pslK8Lv84Pr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="374788979"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="374788979"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 02:49:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="845877605"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="845877605"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 09 Aug 2023 02:49:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 02:49:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 02:49:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 02:49:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rp20UVEg+LE2ekE8VDHLWhQsOUPjMcaw7sYr2M8h3p+vOYMY6LZMsyM8ucb3cNVqaZ6n/eVX2oR8wyXlpTFVgy4b00kjROFZehTIrQPEpq7YhOIt5dJKBZ4qK3MWyCUeTHzAbpbUT2YGYCPa0WA3HsOCQRl8moAfhpjGGaczwNooP1PllwIVKVIyezezAEO4YQjed7k3E1thknCsDx/ktNfRSXM+dIai7CNeRfcPYFcJdSbhe48Odmg21yGS0lccwi7M9ldPvUKq5GOAVG7ZMemj9rEGFqJ0giarT7DbUSZMTuRrTvT6vmDszHgDDusNIlZsO3XF41a2Sb4ftg7zKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPcaqGiIYdoUsphKBbTe4/pPWXVa4g2QUPPLIjUaE6k=;
 b=WquBSEbuHS+2TxJ0DxoJCuG2/NJMz1VqgjKXDmaFLta2uyZvs5t65IC5mf9mLZWUyL1QCpPTwX2cqBZRTrzFLstW5XgkWNRADNYIbji+qUV6DXfWjQP31AS666xTQv9P45+jqQsWP2x8lnb29H/M2NWVgwQ6DkwBMXi1nvNbC6eaVaFM4HOOuuuAdzQ5eLsOSZbbC3NBe8xdyVHyIpy8HfiilfQYeBCfyANLHj37Q0Rw19xAVcNCSeHCO6tofiR7yQgB9tZ8bnbPTHe88THXyVr5wHN9ndavdRjsonaXvdAvsKmXcWB/4k6GRxrWA3Vrd2Tf6SRb9DEFy8cbccejww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB8272.namprd11.prod.outlook.com (2603:10b6:a03:47d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Wed, 9 Aug
 2023 09:49:16 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 09:49:16 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "Zhang, Tina" <tina.zhang@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michael Shavit <mshavit@google.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/5] iommu: Call helper function to get assigned pasid
 value
Thread-Topic: [PATCH 2/5] iommu: Call helper function to get assigned pasid
 value
Thread-Index: AQHZyczxCRfFMGhSVk2JCjxjKYlmLq/hG1GAgACeSCA=
Date:   Wed, 9 Aug 2023 09:49:16 +0000
Message-ID: <BN9PR11MB52767F29A6C11157659D375B8C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-3-tina.zhang@intel.com>
 <f3d8692e-b13d-97ee-2288-c2be1858dcfa@linux.intel.com>
In-Reply-To: <f3d8692e-b13d-97ee-2288-c2be1858dcfa@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB8272:EE_
x-ms-office365-filtering-correlation-id: 35d4552d-ca37-43a9-4aec-08db98bde55f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r7XRHZZkSmtNRwCqaeL0nvfpw7rEyy730MGELs/lzwcTqasD/U5j7L0Yc6aoh5P4onv56AM1yBWtfvY5EQNMVVCR5ebycLJnQO4yQ4/IbS1RgEtmyXTvnAb8o3NH711IAFVuhN+B2hc+NGsh7ebA0wg/W38fgE0teNTuWl5BCbs02w7Ts0+++MJOBZtLfJx3cPZTDLjyqbmQjWMdMesbCG1VrjzrKZO1wMP2Vb9hEh+wWBCKYta6mJHl1l++RJgWrWex04PZqzteQb7Pq1AzsIZZoQ4U0IvAQcKoHowsIASKXwuFmDnjh91wA11Gud3JR0adH2heQJsgW7+kqNG1ZdbBVZb9WTBcYF/1VCwIzN6eLnxJ8Bx91b3Dq3dnz/wwp3WbVIevwZnwdVnCuSL+zP93XpKLyaZ/Sq1uTVjH2UzExDZQO5LU4eD+bR9hFgtYauEn6nOJwW+4QIMB+cgl3O+ehRlrgX5Iwy65gJIKz4Opk/PzOfdcF7HTZn0015Hujm+pSEUFOg5YxxKBx0PSKOe9+44eMMoyMTtGBod5CnlNGCvE1nlf+4wHGYpnrV+/ICSwZq+mAJXqn/fMDgKiPEEChuSWJOm06b8DsPlmIjWlBmGi0osTmA8IFYEJUNJp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199021)(1800799006)(186006)(71200400001)(55016003)(7696005)(8936002)(26005)(33656002)(110136005)(478600001)(9686003)(82960400001)(122000001)(86362001)(54906003)(6506007)(316002)(4744005)(52536014)(8676002)(38100700002)(4326008)(41300700001)(5660300002)(2906002)(66946007)(66556008)(66446008)(76116006)(64756008)(66476007)(38070700005)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mm1mVHNETTY1c0FQN1hqK3g1TDRmb1FHenV3UWx0TGlBbEU2cERGNjU4elRu?=
 =?utf-8?B?UU8wU0ErZG5EZUt5YnF2dTNGYXVJQ0p1azJsSjlaVFhleTBMNlY3bEQ3Umxv?=
 =?utf-8?B?OUJjZjIwWlBYZEt4N29GNUxNdEY2U0NFMXZSV1FyNDNyckwwS2dNVWlsaW45?=
 =?utf-8?B?MDhKV28wVFNGa2RpSC9Ga0RINitiamJIQkNkM2l0MmZrbWlRbW1WL3crbUJ1?=
 =?utf-8?B?c2dSd0czZTgvay9QTitNUzNJM0MzY1BCdnJnNWMyT21jemJnK1F6Um9RQlND?=
 =?utf-8?B?Tlp2bWlnKzdnZnNQWEN2bW01aTl5WDRoOVp0Zmg3VWwzYktuYkFPY0xhUThS?=
 =?utf-8?B?ZjZzNEEyYi8yNGo2bHk2bk1pOG9SS0MrMFdodWRLRGx5RWhHVGlHZFpONXdv?=
 =?utf-8?B?d3daR2RzblNtNTRFMjNxNW1pRDJyVU0zNlh6MWZsSnU5RmhLbVJBNGJRS0RJ?=
 =?utf-8?B?QU5HYU5CM3VNNkU1N05vSmV2T2xzbmNUeFJhcFNBL0N2ZjZRU3FzbmQrL2xV?=
 =?utf-8?B?RFhVQmcvUlVSZFBnckN3OE45eEVkUkgrOUpQdDBDYmd6RGlGK2x3K05YOFpC?=
 =?utf-8?B?aUJtZlA2akQ2b2RQVWNqdVdOWnlSd1RtR05oeHFIRzNNbVBNRzJsUW51R3RM?=
 =?utf-8?B?VnArYjZST0lGMlorSkRHc05RZXd6N1RiNGNPWWp0dHc2TEFXT2twc29Jb2JR?=
 =?utf-8?B?dW9ValFtOVdKOHB1UmdBZnBtLytLQmduWUMxZDdDTkVlRDlyNzF3QUVPTjZa?=
 =?utf-8?B?QzB1V3JYTHRtM1RKQmVRdEtMT0VkMlRSUFFNM0R1WDBleTM0VC9sVmNPK2JT?=
 =?utf-8?B?bnB1cHd3QWVDbFlvRlUzSzM3dUlBeXJrV1lkYS9hdmpDKytWYXlYR0c5aUNY?=
 =?utf-8?B?cUtINFFqRjRCR1NSSzBLU0k3NWQ0K2JTdEJkQWh3NHZvbDBrZWlwN2xSdWV1?=
 =?utf-8?B?cnhXVTh3ZTFwSVgzMzVPUHJ3WVBsMzU1MkJLb0E3L0NqSzAzU242THhRUU5S?=
 =?utf-8?B?R0VEOExWYVNHUlZxcnFrSTRhQWNHMncyQ3JjNmp4TDIvYUl3dUtnZks0ZjRl?=
 =?utf-8?B?YkZsZ2dyc2IxUkkwVWlEVHpRZWpCaDFsNG5JTWFGVU1aNVdVTFlKNzJtSWZs?=
 =?utf-8?B?K0VwT1hSVm1iczZ2VHl4aktZS0l1NnBaN2RWeERPRmg0b0FJbzY4S1FnM202?=
 =?utf-8?B?UHJoeWNYNUtHUzBTMjd3RE14TEd2d3pwNlpUWjd1d1lnRE9yM1lCZE9pdmd5?=
 =?utf-8?B?UE9HcFZrc25LZmgrMTl1NWprWVUxVG0yUlA4Q3ZZQ1RJOXpCSUIvKy9NTEFq?=
 =?utf-8?B?V3lyYkhzMTdvUlE3dk9MS1lLZWFlaWRzSElJQklzcTlGcyt3RU1ERlgrME9M?=
 =?utf-8?B?YW1SeHZQQnNHRlpuRWhHOXA5QjlRNERydlZzeGpmTmNhZlE4M05WSUkzVmNE?=
 =?utf-8?B?WG5ZOTAvRkpndWZEMXNnS2tuU2h6ejY0V05PMHM1K1g4S0dUUHBOOUg5VmZK?=
 =?utf-8?B?OW1CalB5OEhCNEhsd21HR3hvR0p4Um1JOHIxZHAwaVVCd2FHSjRoVVplN3Bq?=
 =?utf-8?B?WTZGNENySmdiNHF4eXRhMkhPZHk4TVd6Z1VJQnVGUjRXUHdTaTJ6WTNnU1Jp?=
 =?utf-8?B?a084ZDFFRVNJUjRuODJuZ1Y4SWhNZmpIQXJtbzBJYU55dHMzMnY3SFpOZjJa?=
 =?utf-8?B?aWZoL1B6RmU3T3JYWmgvOFVIMU9WcWs0b2lvZmhJN1FTWUNhb2I4VXZIaFY4?=
 =?utf-8?B?OWpCV2RwQUdyWDlEa0J5Qmh4YjhuaTRwQ1FxYmo5L0RRTWdUL0s2d21sMGw5?=
 =?utf-8?B?S09mOVoyQ3JZelNyNy9odmJpcGJwQ0xSeVZ6bStCejdOQ2QzUklQSjVSZXNZ?=
 =?utf-8?B?NW8zRjRGUEhDc3pGaVZoSGRLbWw4VzMwbUtUQlVnckR3RUNreW8yU1F4em5x?=
 =?utf-8?B?b29MT0twNVIrTi85ck04T1k1RzYxZ2JyZ1ZraE1Ed2l3NVhiL1g2R25PT2Rn?=
 =?utf-8?B?TC9UM1g5ZGg2cE1wODcrc2xwYWxkUDg5WjJWcDFiRysyT3liYmF4UWNHdTRG?=
 =?utf-8?B?NU9Ca3B6WkNjZWduRmExaC93aFFHNUlja1RhUDZWaC9TNzFIbGw5TWVJY1d4?=
 =?utf-8?Q?4JjSt2JN94oAZYbmhLDwMJhNX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d4552d-ca37-43a9-4aec-08db98bde55f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 09:49:16.7097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yljJoHtGAGyXDhr16I/Bn8Dg3F1LnD6CchtChCd0cyKabX8mshPNYzFdYdtu+1uqSxL6ynrBA06wV5pcfe1/kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8272
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

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEF1Z3VzdCA5LCAyMDIzIDg6MjIgQU0NCj4gDQo+IE9uIDIwMjMvOC84IDE1OjQ5LCBU
aW5hIFpoYW5nIHdyb3RlOg0KPiA+IFVzZSB0aGUgaGVscGVyIGZ1bmN0aW9uIG1tX2dldF9wYXNp
ZCgpIHRvIGdldCB0aGUgbW0gYXNzaWduZWQgcGFzaWQNCj4gPiB2YWx1ZS4NCj4gDQo+IEZvciBp
bnRlcm5hbCBpb21tdSBkcml2ZXJzLCBwZXJoYXBzIHdlIHNob3VsZCB1c2UgYW5vdGhlciBoZWxw
ZXIuDQo+IFNvbWV0aGluZyBsaWtlIHN2YV9kb21haW5fZ2V0X3Bhc2lkKCk/DQo+IA0KPiBTdXBw
b3NlIHRoYXQgdGhlIGlvbW11IGRyaXZlcnMgc2hvdWxkIGhhdmUgbm8gaWRlYSBhYm91dCB0aGUg
Im1tIi4NCj4gDQoNCkFyZW4ndCBhbGwgdG91Y2hlZCBmdW5jdGlvbnMgYWNjZXB0IGEgc3RydWN0
IG1tX3N0cnVjdCBwb2ludGVyPw0K
