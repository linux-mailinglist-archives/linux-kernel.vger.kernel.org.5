Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A3B7DE37A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344561AbjKAOkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344438AbjKAOkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:40:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5F010C;
        Wed,  1 Nov 2023 07:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698849631; x=1730385631;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YfUegQpfcPCtVQy3Os2v6B5NXVu4uO8v/gnEXqpX8l0=;
  b=a3jNef3WSNwP3gLNFEvHtvQ2ZgNHWDG3vb82XQN0nePlWBS4tWKUCLhW
   leDhCoQyGj+f+B7o4jXwBzALpMh+xh4aXhmhVzN6b0i7ie5aa+KWDegBK
   pGwxY3FqmF0zUww5vOFYi0wg69iDut/Qdc+XCFbTqqzM+UabtjHWKOCVc
   /+b+AyVBXL0pAFfTmRIz5WmHIrbiS9Ze3oQlNGEZPfvTzSu1aFGkGh4MC
   odSA6kV965sbIKsFtrHo4SpbnRyhon0m59gx6Ec89wWuyRh3y5qXuPMcP
   ZWAVC50q2vgpfElgUd+2ZM3BlcnuThVowlIfoCcPn2rh0b/Ar6lo/lSOB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="10038251"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="10038251"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 07:40:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="710803614"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="710803614"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2023 07:40:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 07:40:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 1 Nov 2023 07:40:28 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 1 Nov 2023 07:40:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+Pi73IiNi5FYcvPHr3qLYPl9cE8/eT+oH8i4Nk+XfTyhIQ4I8yviuCFBSww9mvm4tQocK5IXnqSxDeKjlQdQzi1TS1E3/rZPxuoa/dUyrInpgzvQGYfXP6exP2lht1+XHrufpDC1JQwC0TY34XdvpnpQ0bWyY0QKtRf+US3IZYP6vdtJW/eYo7tj5DnvcReb+Y9ITrGQbruSXlBhjWX3HkT4dB0bYz+10hLd6Jp7ffpGAI0jRrxrWv3xlemiht9FBQ2Wb0SY64+FUBOkwKGs91uPJuNIbbehMNHMs3HngmIPAbLr8d24BDXZsE1TEFFnUZijq2m66vAkd1tEm0rDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfUegQpfcPCtVQy3Os2v6B5NXVu4uO8v/gnEXqpX8l0=;
 b=a3gWw5LO8/2NHFzKDVdaph8Y+/RLi3kxPk7KFULfYgdYjSfYe11Zd6Z30xToFcrahXMg6lOrUQi6+DlpMF0tFoSo/nBUug5azK4F6b9eDJttBuHXeBlQQsK6nCMJCr7vxEeGsslj4TTMvHVG6QKeeIa13dG1+J0E2M3HkeSma37UsHdxV+HZtkPpc0Ib7+uk/9cBXFmnjKrIPgR28GHfoZI2sBWXRVGv7HSSUgP1I9wXDaP1ulumzHgcGOBVSxKt4Ymi/LMh8CuY/yGZzG9lT/JHXeX2RIcUk05w3XDsVUJNF9uI+tPuBDyQDK/OZ4oVdfY8wX9zHf+VEsCyFGpmQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH0PR11MB7422.namprd11.prod.outlook.com (2603:10b6:510:285::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 14:40:24 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1%5]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 14:40:24 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "petr@tesarici.cz" <petr@tesarici.cz>
CC:     "Lutomirski, Andy" <luto@kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "hch@lst.de" <hch@lst.de>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 04/10] swiotlb: Use free_decrypted_pages()
Thread-Topic: [PATCH 04/10] swiotlb: Use free_decrypted_pages()
Thread-Index: AQHaATgY0RLsz+xoMkWnZqzcXks5J7Bjy6sAgABXDoCAABYGAIAABGaAgADZXYCAAIm+gA==
Date:   Wed, 1 Nov 2023 14:40:24 +0000
Message-ID: <e1ab3ef46ae79d1282ff327dde8cbda76e306659.camel@intel.com>
References: <20231017202505.340906-1-rick.p.edgecombe@intel.com>
         <20231017202505.340906-5-rick.p.edgecombe@intel.com>
         <20231031114316.0bfa8d91@meshulam.tesarici.cz>
         <c0233c531965a69ffb55210ace6a8a9d0f844e74.camel@intel.com>
         <20231031181340.30233c17@meshulam.tesarici.cz>
         <3903bbaade7ba9577da88d053b67b8bfdf0d3582.camel@intel.com>
         <20231101072723.44d00721@meshulam.tesarici.cz>
In-Reply-To: <20231101072723.44d00721@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH0PR11MB7422:EE_
x-ms-office365-filtering-correlation-id: bd3f3530-0121-4bd7-6880-08dbdae87b7f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fQDSPfCzigaKUAZ/M97/UybfU19xmMvF4UaGmQxAOB41rZy2TXLpqXfgkEXxZHMGfu3VXVgcs6TFq4C1NlWwENqpuh2lxpoNzAXVAB7ij1zXY76EpfvqKmnDC8YH21IJY9uTZ9zrTyxkeQt5pEN5A9gwtcmG2vuZToOKZtFXEDdegpeG7uuF50++cyWQYy8LHTeYtE+oy/rF6D8NoV0MDE7iuVtsY4GXhemtWxonPb7PDHE/b+biQv4I8QwlfSgTGUJsKMumsqFPyJScg2Qgf2SHNjklM0ZP6vXrFEFwu5oF8nuzNdSPdfliXTNREkOi3CMu0OkVo07G1JhWoEPdHDRgX5GZlH2EMY/ezJyE1iwo4hdBDgfe8DJf6dRzYgNciLOg5bYu5nAIrrL9Y+mJefS3ROWk/c3JrqVEpN4o08a3FMjv5043jI08fmgfBQRBpwt4WJ1U/7OSTVoqk9zsRdD0fYfzVvU51lurBvhjHidxP0a1JpIhmEjFRut4XdSspI34ohJpkgkwoQfhs9fvyjwE6woAowiATpO2217BgFJEiAVZbPtUxsyRauUeE8Dndrn+At+gQU12I0LM+8S1EYb0vcuw1Kbiiz+LIPaaBTEbZxWa+QxVLBTHTzcuK7Iw1PLSJb+M3OWbPMFm59dXZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(366004)(136003)(346002)(230922051799003)(230273577357003)(230173577357003)(451199024)(186009)(1800799009)(64100799003)(38070700009)(36756003)(4326008)(8676002)(8936002)(91956017)(6916009)(66556008)(64756008)(66446008)(66476007)(66946007)(76116006)(26005)(54906003)(316002)(4744005)(2906002)(83380400001)(7416002)(5660300002)(966005)(6486002)(478600001)(71200400001)(6506007)(2616005)(6512007)(82960400001)(122000001)(86362001)(38100700002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUx6ZTBWL0ZucGdmTStSTWI3SFZwaE9oUk0zR1B4ZFQxckVOOUphT3lLU21M?=
 =?utf-8?B?VzdERGx4WkZhQll4OHhjalpyemxkblp2b3V1MFphU2twd3Q5VVY4cVQrRmp6?=
 =?utf-8?B?ZEdPY2EzejZTaTNJbk92VEJ6bzhkZkcySWRpOG9RRzgyOWIwZ3IzQWtHajdY?=
 =?utf-8?B?NFJ6L2tUZC9tc2pWZUxqTnB4MDl1djF0bDJXRlVSR21DcDBnUnRTalg0bTlo?=
 =?utf-8?B?VVliU21kRzBSb21rK1dNbGVUQUQ5SUMrQmsySDdHWkNWa0hwTW1vZDJBWGRl?=
 =?utf-8?B?RVF0Z1pkcU43QSs4QnQ4U2hnWmwvUko0Q0dGd3BuSkw1SmhiZjI1SS92c1Fm?=
 =?utf-8?B?QnR4SUMweStrV0czRnBsajZZczYyeUlrOEx6Wk0xYmMzckhEcjZzUXJPMGlu?=
 =?utf-8?B?QjVjY0JNSDZHTnFnRE9OTGZjaEZlQ1BWQ2tZV21jeS8wZ0lhN3Y4Y2ozaDhU?=
 =?utf-8?B?WkNEUU9ZYkQxSkc1Q0lYMWxiV0ZQcUNsU3ZXTXFGUk84T2M4eVNOcVpWaDg3?=
 =?utf-8?B?N1QrbUgzb0pMcEJBanpqZFkrbEQxV0c4ME1Rei9rczdwNC9CaC9iTVJEUXdT?=
 =?utf-8?B?MlVnYXg2SmtrN2lJNjIzRGNYd091cUNyRW95cTZzaTdXcHNCOVFqQlVSRVY1?=
 =?utf-8?B?Z0t5RHNXNlljeXFlQ3pwYmdRWVZRaDE3Z0Rub2JpMWV2OHk0ZXRuV3gyd1pK?=
 =?utf-8?B?ZWpwV0NvWnI5Szl6YnF3RGhJemxaRnBiWUdzeGRFbk9KYW13T0U5S3E2UW5G?=
 =?utf-8?B?SjFjL3g4ekc3Qzdpa3BPc0p5Z3RuWk95UXhlZjlWVXB2bGRHTzg4YWJ1bEZu?=
 =?utf-8?B?Tk1qZjcrNVR1YlQxZHNmdnIyM2xUMERTcUx5SXNpQVNFV1pjckZ3RndBVzFx?=
 =?utf-8?B?VitDTitVd3ZubjNjcDlDMDBWb2NRd2s3ZjMvbmVsaFdseXhHWThzeXJ3MEdX?=
 =?utf-8?B?c2x6S3dyMGpPdCsrZEJwRUQyM0NvZXZUL2hUU1hieElhY09kdkFHamprS24r?=
 =?utf-8?B?R25PbXJYK0kzVDVYdU0zNTJvQTh0UTlocEsrK2pPbE15K3F5OEEwVlk3NW1X?=
 =?utf-8?B?V3B2ZzVsR3p6WFJnT2R5NjcrVkNSbmxaOUNUUVBGNmg1TThBclRFWWQzZUlQ?=
 =?utf-8?B?T0pQT0hnRXF6Y3lvQ1dkQWpIUWhTS1pFbU04VW9GWDg3bVNBUlFCTjVCcThX?=
 =?utf-8?B?ZGFTZjRTT2VqYW10K3dUMG4rcmZUbklZbFFDdzhqeitoUEtyRzNyYWhiYURj?=
 =?utf-8?B?Ni9TVkhtMUNHdFJtc2I3Wi9qdHpkR3JIMXBWSzJSYTJnemxKRjJsYk0zQmZJ?=
 =?utf-8?B?YTVua3RqVDFtbm1MWG5YTUJjeXlRbkt4UmhBVllZRDJaSWZiOEU3WjUzTWhH?=
 =?utf-8?B?Z1Nla2dHL1hEVllCMHVmWDdPeVI0OW84NUdzRk9TQmhDWEdtMkd5VHVMRHln?=
 =?utf-8?B?UUttVUMzK053aTBNNTRSakp0NUNpSUhxRG16Z1RvMUp0S1NPU1AwRmdjai94?=
 =?utf-8?B?WXhCUGxvQUJmVUpiY21maXcwbVpBeWJaak5RTnJtZnNBY1MwalErM0FPaVgr?=
 =?utf-8?B?d0tFVkV4akR3N0pDYlNMZGVUTWV1WmlxMi9Ld1VRdjFmc05PMHMvTldKVGZF?=
 =?utf-8?B?RHc4bXlpSUZtVkVadUFpdmlvS3dvRnBndWZLN3ptWUIrTFM1MHhKL1pHeENY?=
 =?utf-8?B?OEs3Nk9lcTNTZjVrSldKTDBGVS9FNThYelIrSVhYVXFBZVdqa1FoUmlFc3dW?=
 =?utf-8?B?MUt3c0h4bU5ZNVJ5MXJJTE5qMUJJOVdDeGUxVW05bkgrQ01zNXdJMnNqWlo4?=
 =?utf-8?B?dFZEOU9CMkZ2RW5tQlEwWFAzM3BjSFBPZWEvNVBhS1N0aUFkNktxZ2lONEsy?=
 =?utf-8?B?bXlOUVhBbzZscHdJb0twUXg3UlVGTVVyMEdhMmZUeERwUnZ3QnhkZTlGUjdP?=
 =?utf-8?B?YWVYTTJkTGJjQ0VoYzdFVDlGL094K1Y2Nzg4RnF0MUNpYXlROS9PT3Jrb3dF?=
 =?utf-8?B?K1oyVE56ZXAwL1JqSEp0Qzc0RUNpZkJLYkpsRXlUb1hTK0MwV3liUVJ0Ti9Y?=
 =?utf-8?B?WXNZemVDV2JESDNLNkdsNlpGcEJSek1MM1l1ZTZPZkFxdk9MekJLeHk3RHIy?=
 =?utf-8?B?NjZYTlRCVythMHVMbmwyWktVQ2Z5YjJrMUZFMWExUXN3emhyRnNINUZJcERM?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2A7C61BF347204BAC933AB9D0864987@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3f3530-0121-4bd7-6880-08dbdae87b7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 14:40:24.1690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6TxHKdY92UPTj3S0bdIs2PbJYsFV4qrT7Q+l0uQzid4zFRzICmzZJktAHEpt2HitfpZtE4JYAAweu/GEDfCk+8w5ZJpTT1UsqDPA18zRcok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7422
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTExLTAxIGF0IDA3OjI3ICswMTAwLCBQZXRyIFRlc2HFmcOtayB3cm90ZToN
Cj4gSSdtIHNvcnJ5IEkgbWlzc2VkIHRoYXQgZnJlZV9kZWNyeXB0ZWRfcGFnZXMoKSBpcyBhZGRl
ZCBieSB0aGUgdmVyeQ0KPiBzYW1lIHNlcmllcywgc28gSSBjYW5ub3QgdXNlIGl0IGp1c3QgeWV0
LiBJIGNhbiBvcGVuLWNvZGUgaXQgYW5kIGxldA0KPiB5b3UgY29udmVydCB0aGUgY29kZSB0byB0
aGUgbmV3IGZ1bmN0aW9uLiBZb3UgbWF5IHRoZW4gYWxzbyB3YW50IHRvDQo+IGNvbnZlcnQgYW5v
dGhlciBvcGVuLWNvZGVkIGluc3RhbmNlIGZ1cnRoZXIgZG93biBpbg0KPiBzd2lvdGxiX2ZyZWVf
dGxiKCkuDQo+IA0KPiBJbiBhbnkgY2FzZSwgdGhlcmUgaXMgYW4gaW50ZXJkZXBlbmRlbmN5IGJl
dHdlZW4gdGhlIHR3byBwYXRjaGVzLCBzbw0KPiB3ZQ0KPiBzaG91bGQgYWdyZWUgaW4gd2hpY2gg
b3JkZXIgdG8gYXBwbHkgdGhlbS4NCg0KT3BlbiBjb2RpbmcgaW4gdGhlIGNhbGxlcnMgaXMgdGhl
IGN1cnJlbnQgcGxhbiAoc2VlIGFuIGV4cGxhbmF0aW9uDQphZnRlciB0aGUgIi0tLSIgaW4gdGhl
IHYxIG9mIHRoYXQgcGF0Y2hbMF0gaWYgeW91IGFyZSBpbnRlcmVzdGVkKS4NClRoZXJlIG1pZ2h0
IG5vdCBiZSBhbnkgaW50ZXJkZXBlbmRlbmN5IGJldHdlZW4gdGhlIHRoZSB3YXJuaW5nIGFuZA0K
c3dpb3RsYiBjaGFuZ2VzLCBidXQgSSBjYW4gZG91YmxlIGNoZWNrIGlmIHlvdSBDQyBtZS4NCg0K
DQpbMF0NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMzEwMjQyMzQ4MjkuMTQ0MzEy
NS0xLXJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tLw0K
