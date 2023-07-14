Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F935753329
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbjGNH0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbjGNH0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:26:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083E130E2;
        Fri, 14 Jul 2023 00:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689319565; x=1720855565;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dDeQ8jSONAAdo17kzfYHa7SGQsex66B1Wcsgb9TKjXk=;
  b=KtYHH4CEGgTJ3Xc+hSAWa0XIimZYLEu9s5d+75hD3OaZquVZFsUCDLno
   B6/3IEQQ8TR9c3ZYusoL6TCNlS01lI3eSPcWGpOwd2rHwuuc6TOdXZdw7
   SEPipWhmOQFy4Gg53Kzz5qJUbeURKlVM1db0C168j0JbS9nUiM3m3bMif
   kK5PU0wadxDYztmND3ubn7mj64jrb482IdfKSK2+vqEaUE2F9GsQnHruU
   O0KwXYIdq5ctRVwdT9tTxq56BSOauag32JXVFs2mloyAGNmR+7TD3/rUn
   wM9bH8m7ovOk0rq1c5m87TyjstxUBGNYZB60/q3r0LlScRQxPcKS/0f06
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345728527"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="345728527"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 00:26:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="896318300"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="896318300"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 14 Jul 2023 00:26:04 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 00:26:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 14 Jul 2023 00:26:04 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 14 Jul 2023 00:26:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpJO8o6o7LOAixYUIUtD/aPNjNWmpcpTDmwzdrctJ1KQDqj1NM2TB0KkQ2Omlg7sNHHYFgft+xYzdF1sJ/UwcvWwWAZYvF9aWsewJtjZT3MGadqlgCHuEdHp4BF7mtAGe8MYskocUb+l2wEXyzmwAPegE7OHqR0Li5PjkfqIgCHD6CrWyaCOMexkmpHtS04M7oILod6ClhW0D+mX6nceEm2s1ucUbrPuLq2wDxGn05wcd6wrf7JIbsoP2DHj1Ke+HaL6UmfsKf//vqulSPaYjDwaDXn1oLtQRJEwqLCzgvbVECR2Be+gbSfhj8vA5SAnOA3ZcZnBhoFoHug9KO43XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDeQ8jSONAAdo17kzfYHa7SGQsex66B1Wcsgb9TKjXk=;
 b=TBdQ9cZ2vNFaGN4rAN9caBT0BkyVYJZsGk3KvqdT4APF4mOAcj8otFRl/UlkufIxn2KE84QKlTphXKXBYCL+8uMEKTsq9wGkO6OVYM28VgS3/ObcQibETrEuTkPIlaV7Q1dYSTVrCExhudcoF7NByEgvm41eqv+5TJTq2gffeyvEtvEo9bL4HBnbaIeiOApd0G/IqVGhiTVBrM3aeT/PezXv5fXU4EHvj3cn3m5fwtU7QuLhFILfuIzZZLrxFzyHj7Cqjtm3R8m2/gWcuRc1Y8Q7ZcGJkV4oJxlMTCjlahPy+Kj+1YdYXQIwKpUotaxnRTGDK/v0tSMavTnn6AXoTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6084.namprd11.prod.outlook.com (2603:10b6:a03:489::13)
 by LV2PR11MB5975.namprd11.prod.outlook.com (2603:10b6:408:17d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 07:26:02 +0000
Received: from SJ1PR11MB6084.namprd11.prod.outlook.com
 ([fe80::96e9:6b33:b886:4e0c]) by SJ1PR11MB6084.namprd11.prod.outlook.com
 ([fe80::96e9:6b33:b886:4e0c%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 07:26:01 +0000
From:   Kumari Pallavi <kumari.pallavi@intel.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "rcsekar@samsung.com" <rcsekar@samsung.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Nikula, Jarkko" <jarkko.nikula@intel.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>
Subject: RE: RE: [RESEND] [PATCH 1/1] can: m_can: Control tx and rx flow to
 avoid communication stall
Thread-Topic: RE: [RESEND] [PATCH 1/1] can: m_can: Control tx and rx flow to
 avoid communication stall
Thread-Index: AQHZpbEJFNWZ6ahAAkGbf9aW8zW0xq+rKfIAgAKsd3CAACkQAIAK+VXQ
Date:   Fri, 14 Jul 2023 07:26:01 +0000
Message-ID: <SJ1PR11MB60842B19103EC186A4FDB0838734A@SJ1PR11MB6084.namprd11.prod.outlook.com>
References: <20230623085920.12904-1-kumari.pallavi@intel.com>
 <20230705-return-slogan-36c499673bb6-mkl@pengutronix.de>
 <SJ1PR11MB608478D62EDFAEDDBE8C0890872DA@SJ1PR11MB6084.namprd11.prod.outlook.com>
 <20230707-breeder-shaft-61b826633b7e-mkl@pengutronix.de>
In-Reply-To: <20230707-breeder-shaft-61b826633b7e-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6084:EE_|LV2PR11MB5975:EE_
x-ms-office365-filtering-correlation-id: 1f7becc3-945c-4cda-bc89-08db843b93ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /wY8HqZlFq6C1VYWqscsy4594qodG07i0KhZ0hrvTEhTF5sea+GogeKXJ7ybt4V+dg9Kvt+VyMbdwDIy8yAjcCgteIFh7dBXzyWjdN9E8Evy3Ww26cYdaRHyxFGeIusEjdOADo9MbLaMMsE5aa7bCOsLBC0Y/U67BtdfHhJx0iStwluJRaFKl0q/VkCeJX8qky6IB4tMI7F9npiclHmgPrqDz8Gh3xtbg5HttQw9f3HFK2BwijHNGB3wBRRmNxiymI0k3OTprBCHYqZ7UrmGjGO6U81Zeu54UQyM5WnC3+yyEBSuYk2Bt0dSiJ5zmtPOIqYh63mg2SE8R/WCx+oIPm/76C81Lyr2rKs+pjuZ7n4JB/OR3oDCBHZqH+Ijx/4iDGGAD7Xe3chOKJwWS3y8ZmDf/Ax2lT0KkDk/QLy5UbOaCZGjp51gU/60DaLTB99oI7315LaKoMxZ+oN7T2BV7ca1t8JH5edQmjO3KuwNW6hIuQN4KGnHDqN4TOFV6aayHmWpMDvGwqYtbEtEuHdl2Aq5JFS9cqene1TFgUKFpNp0ix8XzzxHjzcDFINESJ0RWb9Oi9sfZJF/y8jwKnzEv5D9/g26yW4vqn9zzVztBEU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6084.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199021)(38100700002)(122000001)(66946007)(52536014)(5660300002)(44832011)(2906002)(66476007)(38070700005)(66556008)(64756008)(66446008)(8936002)(86362001)(316002)(6916009)(55016003)(82960400001)(76116006)(8676002)(4326008)(41300700001)(33656002)(107886003)(966005)(66574015)(6506007)(53546011)(186003)(83380400001)(9686003)(26005)(54906003)(7696005)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yjc0YkVhOW9KQ0lIL0hLVlh4dVlsM1UydVg3WDVKa3d3d1JISk1HV0lEaFdQ?=
 =?utf-8?B?Zm80aVlBTllSRDMySHVKZUUrZWtTakt6MDhaRWZrdDVXTS8zR20yOFc3S1o0?=
 =?utf-8?B?Nk1IaE1DaUwyMmtmSy82VWs5K1dlcW8zR25NS3pic3dsOUl5VlVVQys2N0to?=
 =?utf-8?B?VVhXOFJQSzRmUUdySmJaY3N2M0JOR1IvK2RxcjhhbHFzTWRpVlpKQ2lPR2FP?=
 =?utf-8?B?RFo0Y3FYelQrSWkxOThYdkwxSHA5d1JUaUE1SkIycXNFTWNtYTFNVUp3T25L?=
 =?utf-8?B?NFNEaVZDY0t4Sm5kVExTcDY3cFJBQmNQbHFBcVAvSDg5VFZkNERVc2YvSlVn?=
 =?utf-8?B?NGhyUks1bWkvZEM5ZlNlYjU2WHliaDMwK1lqNGQzdCtybHhQd2hvbTJob1V2?=
 =?utf-8?B?bExJdHY4SzY4NWdyYlYyUk5EMG9obW91TUdldG5aRUdqeDlta2NOeG5xRThY?=
 =?utf-8?B?QmNubWZFVEN2VGczTHQvSXdHSFc5NllHeldYQWtCQmhGL3NPaWFlSEhUNGEx?=
 =?utf-8?B?TmhGYUszSzRhOGtqbXlhVkJxUnJLQm9iQ0VYQ2lqYzlVdTRoR3RJMVlydEpx?=
 =?utf-8?B?L0dURHJMaWsvY3FXK2ZZcFRuRndPYUx5SFh6NUZsSmNPdnhFVXdpYnNGN2kr?=
 =?utf-8?B?MXZNcU0zWVB2MnlHdHphRXpjbkZpZ1lzclhRY0pEMVN4amRRNnZ3c3J5aFlB?=
 =?utf-8?B?YXlVcGZOTWRDdTdKaThRQ29WWSt5NFVJQ1ZGZU1mTWVPb2YxakJldnlWNTNv?=
 =?utf-8?B?TVFHL0d0V0pLVDlnY0pvZDBtcERtVUJNbk1aeXE5Z2hld201K1dtWW81OFBk?=
 =?utf-8?B?MHBmTldaU1dhK3NIUStNdFdLM0w0M05QY2kwQ3piT3pOL2N5aVlQbVFiWkQw?=
 =?utf-8?B?NGhBQjlFaDJSSHZCMmxmN1ZjZFFCUEt4UndjVlJwV2NFR0F2SXQrQ1h4TjZG?=
 =?utf-8?B?alNXbEIwU3hiaG5WaUNPOWhCcG5Fd1QwdlNocExOM1YvYTBLS2JIcmF1Nlhk?=
 =?utf-8?B?dmpFTjZ3TGZtdS9TV3JqWGpOY2tGL1FxeVpLR25KVVlrdGpldEdhL2RhS3BC?=
 =?utf-8?B?TnpKS1VsOG9JL0dFaTdVWjU5eGh6SVNmYnE1WG5qOWlHNlhWcERIQkdRc1pS?=
 =?utf-8?B?dFM5blN1cElDQmx3cWpaaW02aWZod0pVbEJyUmxnbk5oMEpzQ2orM0hWdXF4?=
 =?utf-8?B?UFpXZlhnTzQ3MElEbnA0bitPeGd1VkZMSlZ2UGpBNDYxVFhPUDJBL1EzM0RI?=
 =?utf-8?B?L1piODlDNWJCMGl4dFBTdXNod0FMRlFTODhXa25JK0hJV2xzS21XU09ldmFj?=
 =?utf-8?B?VVZnNjNkeVZyMHRPMk9ZbmtwOGdSdmd1OWpYT2VEMitJQ01RcGlZMGtIemtx?=
 =?utf-8?B?bXRESlMxaVlaWnFuSHFQWWRlYVhvY0pqeWJTRFBGUldxS1k5YnYzZjE5N0k4?=
 =?utf-8?B?TWMzTmhaYThkc3Q0emJMd3VrMW5TRWlmWjVETkQyWDRUa1B4dDF1N1NVWXlj?=
 =?utf-8?B?OWpXV1dSRGFwOUxJckgzcDN0cG93Y3NNOGxFVUlBc2FyV0VHWG5vSVllRVNn?=
 =?utf-8?B?b0pJMC9NMkl2bWNycjl0eUVzcTFmMFRTbmdHYnFxUFJGeGJrRkxtSVh1UGpu?=
 =?utf-8?B?UGZ0WFV0S3VUZVNyUERMT1lHTmJsT09vRVdjVXplWmVKVkF1UThnNnF0U1Bk?=
 =?utf-8?B?NXJpenZmNFhQVmM3RTlqTG9FVCtwdk5UTTVNTXk4VG5TdkljMTFkVkpJelVL?=
 =?utf-8?B?alpCWnFuU2xUYVFudm9tcmhFTTB3bW40SXJQTzZ4WjZMV3FLTnFTaU1lLzJl?=
 =?utf-8?B?ekZRUDFPSW1jc3M2SnVab2FJeUhRM2V6SHkvUlZyMzM2NEwrL0tHTlkvRkdF?=
 =?utf-8?B?clJ4YWU5c09wNG8vK3lYSUZ5R0Q3Y0lhZUxxMEYzWkRxMnkwQ0F2UDZBM0FH?=
 =?utf-8?B?VlVQdlpxVzlzS1BiOUxteDlWVUQ4ajY4WnFEdUhTSG9HeGRzWG05WjBFR3RP?=
 =?utf-8?B?bWZidkFZOG1DbTJjbUlzOVYvdlhlSTZRbHRyZHNrSlBvRTdIdVo3cUNqWVUr?=
 =?utf-8?B?SG0xUkZrWENnZGJHYnNHRUNSQlozMkFCbktNbnUzR0tIRGhxcmUrZjdwL0RR?=
 =?utf-8?Q?sS90S67n8CbOG8t6ldHxD8axY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6084.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7becc3-945c-4cda-bc89-08db843b93ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 07:26:01.8391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AxFxWcu0nCknWlHwZAQE4bYdlCQsAkpXXlYziPOyFSBvRpm/kBswRirLTVQNIZLy865uNiHQhV8gGLOcmJhq5xJyT3fKqQg5++9JkbjKQ98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5975
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEts
ZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiBGcmlkYXksIEp1bHkgNywg
MjAyMyAxOjA0IFBNDQo+IFRvOiBLdW1hcmkgUGFsbGF2aSA8a3VtYXJpLnBhbGxhdmlAaW50ZWwu
Y29tPg0KPiBDYzogcmNzZWthckBzYW1zdW5nLmNvbTsgU2FuZ2FubmF2YXIsIE1hbGxpa2FyanVu
YXBwYQ0KPiA8bWFsbGlrYXJqdW5hcHBhLnNhbmdhbm5hdmFyQGludGVsLmNvbT47IE5pa3VsYSwg
SmFya2tvDQo+IDxqYXJra28ubmlrdWxhQGludGVsLmNvbT47IGxpbnV4LWNhbkB2Z2VyLmtlcm5l
bC5vcmc7DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IFRob2thbGEsIFNyaWthbnRoDQo+IDxzcmlrYW50aC50aG9rYWxhQGludGVsLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFJFOiBbUkVTRU5EXSBbUEFUQ0ggMS8xXSBjYW46IG1fY2FuOiBDb250
cm9sIHR4IGFuZCByeCBmbG93IHRvDQo+IGF2b2lkIGNvbW11bmljYXRpb24gc3RhbGwNCj4gDQo+
IE9uIDA3LjA3LjIwMjMgMDU6Mzg6MDksIEt1bWFyaSBQYWxsYXZpIHdyb3RlOg0KPiA+ID4gPiAg
CQkJaWYgKG5ldGlmX3F1ZXVlX3N0b3BwZWQoZGV2KSAmJg0KPiA+ID4gPiAgCQkJICAgICFtX2Nh
bl90eF9maWZvX2Z1bGwoY2RldikpDQo+ID4gPiA+ICAJCQkJbmV0aWZfd2FrZV9xdWV1ZShkZXYp
Ow0KPiA+ID4gPiBAQCAtMTc4Nyw2ICsxNzg3LDcgQEAgc3RhdGljIG5ldGRldl90eF90IG1fY2Fu
X3N0YXJ0X3htaXQoc3RydWN0DQo+ID4gPiA+IHNrX2J1ZmYNCj4gPiA+ICpza2IsDQo+ID4gPiA+
ICAJCX0NCj4gPiA+ID4gIAl9IGVsc2Ugew0KPiA+ID4gPiAgCQljZGV2LT50eF9za2IgPSBza2I7
DQo+ID4gPiA+ICsJCW1fY2FuX3dyaXRlKGNkZXYsIE1fQ0FOX0lFLCBJUl9BTExfSU5UICYgKElS
X1RFRk4pKTsNCj4gPiA+DQo+ID4gPiAtIFdoYXQncyB0aGUgcHVycG9zZSBvZiAgIigpIiBhcm91
bmQgSVJfVEVGTj8NCj4gPiA+IC0gIklSX0FMTF9JTlQgJiAoSVJfVEVGTikiIGlzIGVxdWFsIHRv
IElSX1RFRk4sIGlzbid0IGl0Pw0KPiA+ID4gLSBUaGlzIGJhc2ljYWxseSBkaXNhYmxlcyBhbGwg
b3RoZXIgaW50ZXJydXB0cywgaXMgdGhpcyB3aGF0IHlvdSB3YW50IHRvDQo+ID4gPiAgIGRvPw0K
PiA+ID4gLSBXaGF0IGhhcHBlbnMgaWYgdGhlIGJ1cyBpcyBidXN5IHdpdGggaGlnaCBwcmlvIENB
TiBmcmFtZXMgYW5kIHlvdSB3YW50DQo+ID4gPiAgIHRvIHNlbmQgbG93IHByaW8gb25lcz8gWW91
IHdpbGwgbm90IGdldCBhbnkgUlgtSVJRLCB0aGlzIGRvZXNuJ3QgbG9vaw0KPiA+ID4gICBjb3Jy
ZWN0IHRvIG1lLg0KPiA+ID4NCj4gPg0KPiA+IEV2ZW4gdGhvdWdoIHRoZSBSWCBpbnRlcnJ1cHQg
aXMgZGlzYWJsZWQgKGluIElFKSwgaWYgdGhlcmUgaXMgYW4gVFgNCj4gPiBpbnRlcnJ1cHQgYW5k
IHRoZSBSRjBOIGJpdCBpcyBzZXQgKGluIElSKSwgdGhlIFJYIHBhY2tldCB3aWxsIHN0aWxsIGJl
DQo+ID4gc2VydmljZWQgYmVjYXVzZSB0aGUgVFggYW5kIFJYIHNoYXJlIHRoZSBzYW1lIElSUSBo
YW5kbGVyLg0KPiANCj4gSWYgdGhlIGJ1cyBpcyBidXN5IHdpdGggaGlnaCBwcmlvIENBTiBmcmFt
ZXMgYW5kIHRoZSBtX2NhbiB3YW50cyB0byBzZW5kIGEgbG93DQo+IHByaW8gZnJhbWUsIHRoZSBt
X2NhbiB3aWxsIG5vdCBiZSBhYmxlIHRvIHNlbmQgaXQncyBDQU4gZnJhbWUsIHRoZXJlIHdpbGwg
YmUgbm90DQo+IFRYIGludGVycnVwdC4gSWYgdGhlcmUgYXJlIGVub3VnaCBoaWdoIHByaW8gQ0FO
IGZyYW1lcyB0aGUgUlggYnVmZmVyIHdpbGwNCj4gb3ZlcmZsb3cuDQo+IA0KDQpTb3JyeSBmb3Ig
bGF0ZSByZXBseSwgSSBhZ3JlZSBsZXQgbWUgc2VlIGlmIEkgY2FuIHRyeSB0byBzaW11bGF0ZSB0
aGlzIHNjZW5hcmlvIHVzaW5nIENBTg0KYW5hbHl6ZXIuIEkgYWxyZWFkeSBzdHJlc3NlZCB0aGUg
Y3VycmVudCBzb2x1dGlvbiBmb3IgbW9yZSB0aGFuIDEwIGRheXMgYW5kIGRpZG4ndA0Kb2JzZXJ2
ZSBhbnkgaXNzdWUuIEhvd2V2ZXIsIEkgd2lsbCB0cnkgdG8gaW5jb3Jwb3JhdGUgdGhpcyBzY2Vu
YXJpbyBmb3Igc3RyZXNzIGFzIHdlbGwgYW5kIA0KY29tZSBiYWNrLg0KDQpUaGFua3MsDQpQYWxs
YXZpDQoNCj4gcmVnYXJkcywNCj4gTWFyYw0KPiANCj4gLS0NCj4gUGVuZ3V0cm9uaXggZS5LLiAg
ICAgICAgICAgICAgICAgfCBNYXJjIEtsZWluZS1CdWRkZSAgICAgICAgICB8DQo+IEVtYmVkZGVk
IExpbnV4ICAgICAgICAgICAgICAgICAgIHwgaHR0cHM6Ly93d3cucGVuZ3V0cm9uaXguZGUgfA0K
PiBWZXJ0cmV0dW5nIE7DvHJuYmVyZyAgICAgICAgICAgICAgfCBQaG9uZTogKzQ5LTUxMjEtMjA2
OTE3LTEyOSB8DQo+IEFtdHNnZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2IHwgRmF4OiAgICs0
OS01MTIxLTIwNjkxNy05ICAgfA0K
