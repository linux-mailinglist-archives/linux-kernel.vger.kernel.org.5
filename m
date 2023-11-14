Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DDF7EB32C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbjKNPMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjKNPMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:12:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12896E3;
        Tue, 14 Nov 2023 07:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699974760; x=1731510760;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jpixj36a0FnrQMdjM2lghtS3p3hnhl/NvYRuVyEQLsc=;
  b=GdCtTOMcgDyZpVXBoJfel+XeW1yVv8JOwAkxbTlKxg56Q3/JGXkCm08m
   5HG5I/GLLn+ol4Ok3TD03vwZtDFc0f7y5wOo2tTUou+ODYKruT+85r9Fv
   g83zNkDb53XKZu9IFcdjTLdi9TMrL0GLxLzFQAGSamXlirD3XW5CVJsAw
   vp3MXVRxHZh8TFT30k7zbYi8FyccGfJa1GNJMBIgMVWxVqK/IZcxhM6k/
   2NdTTFCzfph2OcjPH0phqz2hwD4/iOTgSE0C0bL+y0mTjH+dEe4zqOyXD
   1jDUUSnCUJVMewaI9om3LRvpSz4Oj+mzRcJdah8tfIl9hPpQ/hOdohabq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="12217695"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="12217695"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 07:12:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="799545299"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="799545299"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2023 07:12:38 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 07:12:38 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 07:12:38 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 07:12:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9bwTTCJRd9k+ypx5E+PvGxe6AomXwJcZ/XF752ek03crHoXU0sFuzrD++/fYoUBJeoKQ9VRpCvogU3P9hnd8RW0FZD6ptQ+cVSNBObSsb0/yuCMS4hiZ2y5yqTcLSP7VZ2mWQvn0MoRE0xXQU+ImqLh2Y7itxDWU/4qa50u4gRPA8iSsaoklvqKZi8ahpLSnZVmDemJjKXhetZ5xQVHrW6q1/EPdYK2jcWZLxbEJ6ePMAclBZq5lMySNreNapTalKByxZXG/FE8wZItLiR4mLVl3rnQVkXQmwZaXJ2LtPx3PDmNIWP5WbvoMfiUw9J08XXLo9ci0W9RjdnxWJcixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpixj36a0FnrQMdjM2lghtS3p3hnhl/NvYRuVyEQLsc=;
 b=hCWHA7UylKBJXEDhQSNA3atAu5Us+gRnA/qT6L38z0JRENqs8CR/yD+x5IVJz/y3cOyQlZpvONEoTPgXfvxd/rOLipwsv9DKxtQwR8NwA8+jPd5VARUlnPpJ2NJ8TfSyOeIN0F0dRoQGHX+UqcwdqZ1bIRLOOILkrEut9RFSh1UOMCKkPihdBu7lVIdy8m6iM988xqaF/W8OnWf8Ip9AAESGXdAcLr8hJu7Gtekt0yDD9cQki4QGvRLJNYtOAgwYzjNfRJucnQETbxCxpDLVQ0ksOZt5GzBMjeZyf0JG5dfL4I6BrrW5d4EVo10VIOxlTTv4wDvqslsymbK3aVodog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by BL1PR11MB5527.namprd11.prod.outlook.com (2603:10b6:208:317::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 15:12:35 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9%6]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 15:12:35 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH] Documentation/mm: Drop pte_bad() descriptions from arch
 page table helpers
Thread-Topic: [PATCH] Documentation/mm: Drop pte_bad() descriptions from arch
 page table helpers
Thread-Index: AQHaFsTVlF+AOD2Td0yiVwf/IfbtILB57HMA
Date:   Tue, 14 Nov 2023 15:12:35 +0000
Message-ID: <dc5028e587925d78fb0805e21e89efbb293ef066.camel@intel.com>
References: <20231114063456.339652-1-anshuman.khandual@arm.com>
In-Reply-To: <20231114063456.339652-1-anshuman.khandual@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|BL1PR11MB5527:EE_
x-ms-office365-filtering-correlation-id: 2742a401-838e-4081-4b97-08dbe52421f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ELdN2kA4EDRHYZStdqu5KyinByts51i+p0kJ9afN4v5sYgmcHoJ+x911mh17H8DGff+D7orzhcBjgaRLy8BLOx1QUP9cCCJgH0xVJoL77dOpiEyaXFUV8xs58O+N7aASkxQidzrb6/OAvBcvLmClz1Jio3yHDuTJd0wWoAsUIyWpORckiK1HorzMVnDvgsN+87YkK6LHEAWILCH4ixo+2NtqHf7ObzcOqkLcBuP8HN0iXN/I6JxmUZ8+Z0bPVx5JixEXH4tUHKuKwcMgsRia/u7ivE2+0LVFkvrijVDOjmvEEsYBzAooOsYqtoT4L6OnFPGsXrgH7d042NNHR1z8/omtMNUwc44sLyzcTJ4PAdsN2hhrsK6xOffyFkDF+Ql619GtuVj2R8Wl3MTTpw6lXmERojSfvT7DM4m1IfBK4csU63N7p/D51zXThZkBe5Gi+EiguEa4UlCx5Np6fbDI4gBtmSlVeJB1Fzxugbn0HmoUL4DjQu2jAdR4xXp25CRfBgEfpevTBVT+DS5HlRwks/9r6hSpq8pKA8TyFRJ2sLYUeruhleFN6xdm1+BPoe8Uk8Ua84QO7ftS9SdvU2KSPHGR21qZUXWQJ5bVhWP6N6Ow7uVOPkvOC9KKMeVG22Bk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(41300700001)(66556008)(38070700009)(64756008)(66446008)(66476007)(54906003)(76116006)(66946007)(86362001)(91956017)(110136005)(36756003)(6486002)(122000001)(478600001)(82960400001)(71200400001)(26005)(4744005)(2906002)(6506007)(2616005)(5660300002)(4001150100001)(6512007)(316002)(4326008)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1FnMXFsWFhaTlJtUERWYnZ3dTlDTWZLdjZIUmFWdWxxWlVQa255TWlsVE9W?=
 =?utf-8?B?YUl3ZE1oMlM2TXMxWFMwQVpFMEVTYVR1UnBJNFltTm5sZ1ordWNySGhSdWh3?=
 =?utf-8?B?YS9JZXJ5bVZ3V1RhdktMeGI1VW5vZTk0bVpacGJ6anNBbmJNNU1iUjM0N2Nz?=
 =?utf-8?B?YnZmazE5TWVqUzlUMW43STBWWTdnb3VQK3ZXV2YvOWp1aXlnN3dzT3YxNG9Q?=
 =?utf-8?B?RGhtYnJMUU0zZURXM1B0OWRhcmhsNTJPbjU4eWQ2Q2FtRk5hbWFnTE5ROHBh?=
 =?utf-8?B?L1Y5ZW01K3pRQU1IL0EzZVBnY0tKUHMxbzgvZ1lwaVRXQ2xUTk1NcGtveXJo?=
 =?utf-8?B?eHRTbldFMlMzWGtiRGFudmdFYUx3UkZPVm9wY0ZXQ1RnTXZ3aUFzOWdJLzkr?=
 =?utf-8?B?VlNkcTdnSWcyZDk2MXVHWW15NndVR2JYN0RoM0xkVHY3aUpPUlFleThLSkVl?=
 =?utf-8?B?WXlFaWlyQkUvZ3RkZUdTMDZPT1NrenJDZ0NzWUpmY2dsdDJVOWhXMkx0dkxp?=
 =?utf-8?B?aHpCZVYzRjl4RDVCeW5acXN6SVVrdXpQbVdmRW52cUZoYUZQM0Z3c2Vja3Ru?=
 =?utf-8?B?Y21FTkdrMVdLdTIyTzMxWkRYNklPNnByOUV2d241WDRMcm9iOWJoOXpqbUdT?=
 =?utf-8?B?eVlpQi93ZllvcjcyQ2RrYkJkWlFld3NtMkhwenorVXFEQlBWd2I1WEFKUVh1?=
 =?utf-8?B?eCtBY01qM1UwcDNqWE5JNllwTDViUERhc1d5SzM5QzBjS1M2aGN4UnV0TlBT?=
 =?utf-8?B?N3I2SFN1aTMvRFhkN2FqaThsZitYcllFYTVZdmF6QmFTYXRPM3kzOHhWNUR0?=
 =?utf-8?B?VEZHSXRBNmpkODdnbmhxUGJ6enBxWm8zRG9NSnIxV0NDMTZpeDNzSjFIS2Q1?=
 =?utf-8?B?akR6K0s1akFHTzJMMy9nL0ZEaTNITFBpOVRtTzBVcXBLNXFXY0ZmN0trQ0Vh?=
 =?utf-8?B?YjN0RiswL2xJQ283UThIcCtYK2JNZnJtWW92UTQzUy9Iazd4Wm1iSG9IeHlH?=
 =?utf-8?B?QWpBLzlaUTh2UTlJVHRONEk0Ri9FYWxwaHErNTlsTXp4U2FXRjhOZlhkSW83?=
 =?utf-8?B?UW0yT1JFTXduMWhOL3k0ekZqUFFqOERydDU1ajRqdmY2MVc3L3pTQThscTkr?=
 =?utf-8?B?Z2x6VkNLUVBLNEk1RGlIK1ZGcWZQaUtXZ1pvcTFJK3BSNDV0Sm5LU3U2NCth?=
 =?utf-8?B?WUFoK0h6UEs5VjNxNXRGWnY0SDBSTWk2SXZGRXl2SjIzejAzM281a0tTalZQ?=
 =?utf-8?B?Q1UrZ0tmYlpLQzloU040cG1jRWZuUW4weUxhTjFHT1hOZmxuVkc2Q080RUMr?=
 =?utf-8?B?TUoxNjFLZzVaZU1QK09RWmwzelY4VGU5YUNEMG5VQjZpUlkycnpqOEJrb2xT?=
 =?utf-8?B?QnA4ZG1uRytmWFpKYVZvb1VkZ3E3TmFVMFp0cGRVb0t5Z0FTbitjQmwyWThQ?=
 =?utf-8?B?OGlxRmh0RlU3QlhUZ0pnRkdCSzlVTlRxQUxWdktyYkpQLzU1b21NUG5GS05j?=
 =?utf-8?B?ZncrTXpMZXRvMjZWelRWdmI1ZmErSXZBenBRT2dLUUMyVHhuaUtkbEJHcjFP?=
 =?utf-8?B?TTNTUHZNZUpTOWRpVGJrTjNNMnFuWEx4RkZuS3FkNkozb2lVMWthZVk2THpH?=
 =?utf-8?B?WFNBZG02V3B1eHp0K3dNV3YxUGcrb25JdVVsU0NGV1dIK3BrK3VZMzYwREFv?=
 =?utf-8?B?UGJiQ3BSNEtsVjZUaDEyem40aTJiK3l1dW52dTVINTJBZHRtb0t2WVN1TGo1?=
 =?utf-8?B?MUM2U2JGR1ZtZ1pDUldFNkpSdWo1T1U5VUtTdk5ZdSszRHg5RDQ3dU8yWjA3?=
 =?utf-8?B?S0lZOFVWYUc1RGxlN3d2MHh5YnFKeG1FL2VTcXFuMnpyR1dFWDM1bDlQdzBy?=
 =?utf-8?B?cDEyNnV4a2FSWUVqcjYrQU1WcmtEWDRiSzd5QzlZSWJEd0ZrYVdsL2hHUkhB?=
 =?utf-8?B?cWJIWHBpRHUwazlUaW1pK3dhK1RDM3pXVEt1bXB6K0t1WVZEVnc0cit4R043?=
 =?utf-8?B?ckxiQjNhWWU5TVYvRmh2dmpiVW9LSE41VyswdDFhdTZhVGM2Wkowcmowak5C?=
 =?utf-8?B?SGFBNWFnaVVjdHNRWko2U0lMUCt6SzlWSXN5USt6ZFNPZElyT1dRcVB2ZlBH?=
 =?utf-8?B?WnZUcGJMbDRIeWtYd2I3amlMWjAvWnNOMVlXNmNDeUJWdkREbWd6RU5zeGJS?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2AC9B755A32861438EEA5607F5194B2D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2742a401-838e-4081-4b97-08dbe52421f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 15:12:35.3446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wUyuP57RbMQbipBa/0B5UaguwRr56NjAEgiyRqKiqN9SfquC9Jy0vf3TnDgWixkwyc+uz5HhhKLOU09ZqavZ+gMEx+LnjXHoU+vuqj3fxfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5527
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTExLTE0IGF0IDEyOjA0ICswNTMwLCBBbnNodW1hbiBLaGFuZHVhbCB3cm90
ZToNCj4gcHRlX2JhZCgpIG5ldmVyIGV4aXN0ZWQgdW5saWtlIHNpbWlsYXIgaGVscGVycyBhdCBQ
TVUsIFBVRCwgYW5kIFBHRA0KPiBsZXZlbC4NCj4gVGhpcyB3YXMgYWRkZWQgZXJyb25lb3VzbHkg
YW5kIGhlbmNlIHNob3VsZCBiZSBkcm9wcGVkIGluc3RlYWQuDQo+IA0KPiBDYzogSm9uYXRoYW4g
Q29yYmV0IDxjb3JiZXRAbHduLm5ldD4NCj4gQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgt
Zm91bmRhdGlvbi5vcmc+DQo+IENjOiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBp
bnRlbC5jb20+DQo+IENjOiBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1t
bUBrdmFjay5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVk
LW9mZi1ieTogQW5zaHVtYW4gS2hhbmR1YWwgPGFuc2h1bWFuLmtoYW5kdWFsQGFybS5jb20+DQoN
ClJldmlld2VkLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+
DQo=
