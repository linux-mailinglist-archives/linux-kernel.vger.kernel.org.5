Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB59175716C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 03:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjGRBjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 21:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGRBjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 21:39:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A13F19B;
        Mon, 17 Jul 2023 18:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689644375; x=1721180375;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8L6ekwZa72BlFJT/q2dLVEcgzl516dsX1gDSmbPa5E8=;
  b=JVgRgfl5AI0XB5WKit8uEmgDnpSdWH+qjxg7ZyQMT//fNUy2Tvr6y9QH
   EQ8aUknl+UEKQmD65JGKRp3asHI3vDqpCfiCF/f4UVkoPtay6ROP9lBX3
   OmhnSIpfqxxDSaKVdaOPfbh5nwFFEG3lvtjPI5yrDGbGXZbnDUl+VJ0SP
   YWOmUmaaxGe9vz8ZvafR0NXMhh4vTaK9rTih79ug/csXgbOmI7iEZKKEW
   L4pAZc5xogPV2M4OcS14TILZUMOztLUrMPOAHjtw3mYK+H3kH4mg+zaZb
   emjQI3XGp49Ebr0S5zIXXxA8kaLHnPA/1Z4ft85bIbvTQ5rKpDlugQ7Qr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="432259241"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432259241"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 18:39:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="847514621"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="847514621"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 17 Jul 2023 18:39:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 18:39:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 18:39:34 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 18:39:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPfNLThL0G9pOU+8v1jd2bCnut2mkb6RDsfXssWf7pHkFIv+6v2PDjGG72tJ2VSXITl14HPMsghYGtGmvgIhBQ3KSx1CetbA+J0VPJmAd66I02DTZBzgWzlrkO2/L0qMU6s3igSDWDbh9z26MFBYcm4AwKkoXsth39A0OxsAF/V1ZX0peCjV+HBTFDJP5lZ79BeCyCwUYqL4MIvMGSG8juD6WnRG5xGTDpOxS+cgIlLiNxsHhwT4Vaagr9nKVDEfqgo4y7XnpuQ5k/cjEtZNpN32+CoA6NSDNTs7karRa8x0yP8PR1NIKc+DUrAcITbWh4WY4mLSHOT0/mJeJdaPVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8L6ekwZa72BlFJT/q2dLVEcgzl516dsX1gDSmbPa5E8=;
 b=ZIw+Q8riXtCu2wNDLaoyI/125MPGuIsM2WOUhYIOLiD/8fVQpxkK5qqeOfEz9NTbLh1PsaS8HaaTpmv+01W5Hw16UFn6ZbuK3zMDOqD3/eOUjX+qhbRnDNGF0TGN4GqxQt2zAhYJVIqwYNgBjDTde81ASIveQWm1b/RzvqUY99XBIBqi3zXomEMX9aaR2uS1EJy2DR0CBnnDX72PE5ibIHdWaDit0BzTI7CHyqEu8dP+XiWKVU8ZsBNVCDSUuX038LCeeC/PHMatRF863XLxmhcwcIlCQMReeJG0j8JI8J9cchpCYbRWPryziPzt7lNVMQR1QkpV4plWVxlGLm2j4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA1PR11MB5779.namprd11.prod.outlook.com (2603:10b6:806:22b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 01:39:31 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 01:39:31 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>
Subject: Re: [PATCH] x86/sgx: fix a NULL pointer
Thread-Topic: [PATCH] x86/sgx: fix a NULL pointer
Thread-Index: AQHZuNr+gc+uEEAR2keHYngpqSvf+a++Tj+AgAAAPwCAABqcAIAAJQSAgAAieICAAA8VAA==
Date:   Tue, 18 Jul 2023 01:39:31 +0000
Message-ID: <a0dbb519550bae23c2bd02cd9c5940f4e9b2a38a.camel@intel.com>
References: <38deca3161bd4c5f1698fd7b6c43aa3c7b94d3da.camel@intel.com>
         <20230718004529.16404-1-haitao.huang@linux.intel.com>
In-Reply-To: <20230718004529.16404-1-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA1PR11MB5779:EE_
x-ms-office365-filtering-correlation-id: 92f14e24-3074-49a3-b1ce-08db872fd522
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HWFU3QNKLAj8dux76EL17xULkch7+1d5Sqi1Wl4qAkLs8Cplb9ORH2RG+O51drCZb6bDIa3fX7Dq6E0S2cwvD2qCnLPShQ9SQNb0w6gRSKtm2tLiaVA2I2Zsk5r1m2fpFneGuBPXwUKhwKsG8fw/M97X/nYdLi31mtvzKNH4Ot8DqESiAy7P7D4LPVKJ3gCZbSJsVCiPu8GHtxwyP1lRIuApepVbyyXZK9Ds1kXByCNJUXjpcL+8hHRZ38v9adYDpkMnaPOlw0bXA98dtQ0yzo8iqHUGdTAzNkoK+5Xmjd4AgH7j1IvYKWuIGULvAJNKx8CwBsXBCQBYRlMRarCaLhbtuWWg5dRU5V/yybDRIjWHCrk2b1w9g8KXgNxSE/v8Nap+7A/9qLzqdypM5KR5MmR2CxrOoA2hYu7mRLkflBpi3psfx26rpt3BRvj5GpNIMw6INevkCt10GgFmQhdEJ2l3uU3KLU7DfCqPjgHbZpWtEyE4pWpkG3ktlzx3BwcVuLJcKrkYv36pVSqV5zCs3sRZN+XjK8KyWYeSBcI3dKk9JaVDChzQrkIRwvagEMw0D72aC93yySu9wxubVRiTtFVoUcTwXpnYvWaBcCW9rrHhc+ILvn0k4Xbt1AAYnFTJ0mBAseZu/6m3zCwWmx3E8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199021)(6512007)(6506007)(122000001)(921005)(82960400001)(66476007)(38070700005)(8676002)(8936002)(5660300002)(4326008)(316002)(54906003)(110136005)(41300700001)(66556008)(91956017)(76116006)(66946007)(64756008)(38100700002)(7416002)(71200400001)(66446008)(36756003)(26005)(2906002)(83380400001)(478600001)(2616005)(86362001)(6486002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGtVeUQzWnNDTFd0UVB6bmMyT0RTdjJpaExpSmxBbU1ZSXpka091YlY0R0s1?=
 =?utf-8?B?YkFJYjFhV0ZvZFpVdm1VZVk2NHBnL2kxRUxITW1oanVBdXdYcWdNa0hCNjlv?=
 =?utf-8?B?VVczUUJuZHhjK1FscjEwN0Z4VCs0K0dLWUpjTVJtZ0VYTmNRTDJ0WFVjQ1Uy?=
 =?utf-8?B?NURTRkxZQTcremVUbDNBeTlVa01mTGpJN0g5cmVKUS9VOXpxbWZQYmxveUxE?=
 =?utf-8?B?N2dJazBrQU5Gc05BTDFCbXkwWTBoWHVtWjY4eFEwV3pWQXZ3M2NLU1d3RmhE?=
 =?utf-8?B?c2E4V1g0eGpOTzczaTVXMkZzemFQbXVYcGUxQ1liYTA4bVByQ2RtcS80dEg0?=
 =?utf-8?B?WXdFeHBuNmdjMW82VUQwNFpWWWp1Zk1PZFlyaWFoUGMvL2VwZ2Y1VWZzcUZu?=
 =?utf-8?B?TEJqMFZkY1ljVmNZQ3AxMTFEUWNLSDJwOXB5U004U2xlakV5TEE1VnpKVUln?=
 =?utf-8?B?bVZ0MzBqTXBKeEFlNEo3L1MwZVljREdWY2FoUUs0UFlPQVYwWUtLVlkyWXNu?=
 =?utf-8?B?L0k2M0dRWXJ0b0UzeWs4QUdZKytCNTVDUE5hdVN2SWVST0lkclFFQkNZR2JP?=
 =?utf-8?B?dGtZaHJrL251V3oyV2Y0Zm54Y0pJdkVRTXJCMHB1V3o3ZzJXcWJkc3RheVZW?=
 =?utf-8?B?aFljWmdGRVJkemJ5TlVnUHlIcDdzVDh3ZXJvM1dsc3RhYUZqZUs2Qm9uVVl5?=
 =?utf-8?B?TjYwY1ZlV0dBcXhFTUhBYk0xQzcvUk1wbW10ZTBLOUM2NXlMNUx6STRKQkh2?=
 =?utf-8?B?MGUxeXp2eHppQThQSUV6azdWaW9MVktyUSsvOGpBQXl5SnQ2bHZaNzVQcDUv?=
 =?utf-8?B?QURoWFp6TWVYY1YxVmp6aGJhSDhvTFppRXAvNStrRXZLaEtNcWtOVDcrZUNQ?=
 =?utf-8?B?cC91dmNORHJOVDkwVE9JY2Y5VjRFTVNNeUxqOFpKT2pCWkdOcWxjK0U1cEc5?=
 =?utf-8?B?UXFZMFI5dHI2T095cXY2Qi9uM2FyWWJ4NitWVm13YXlzVVFFOFU5RnJHUEVK?=
 =?utf-8?B?Ni9nSlpQV0FQOUNrUEVSaE55MEYxSTVDRW8zd0xyTU1yTTNqYWtiWklYQUhK?=
 =?utf-8?B?c0ZQWmRuVW9tM2Y3VEZVR3Zhblh0NUJTWFZBU0pKWGV6YWxRZ0tadVJiZjZ0?=
 =?utf-8?B?QTNwWWJ3a1FpSllRMVNydnFWaWJ1TWlTRnNXNzBQZVVZYXBNYkt1QTZiM2Yy?=
 =?utf-8?B?S0RyNjZMYnBaTVUwZjZVUTh2TFJHK0RWNllBa0wrU2ptWnR1WEQzZkVFajdQ?=
 =?utf-8?B?THZhc1djdTU4S2ROL1plUHhiSytnaVVuWGRTaytzZmJtSzZjTTFpaE9WenhZ?=
 =?utf-8?B?N01HM3JVcTB2L0pqUVgvRU52cWlkRktOUTFWbTBCeVdUckJOWTRhUFVtWWY4?=
 =?utf-8?B?UXE2Y1psNTh0ZFFCN0QzVDhuWkVVWVR5clhNWi9yYlR4RC9zUjdrcVR4U3Jx?=
 =?utf-8?B?ZGtXTDRUOURlbTdQczI1S25OaHA2YUVicFpVZWhSMzBsMnA2UDliQjlOUStt?=
 =?utf-8?B?RWt5b0d4V3R5R2tLWlhlSStQcWhHK2tWRmQ3WlpkMlBRTlJ2NHRlelJVaVBH?=
 =?utf-8?B?MGMvRkU4Rnk0REszRjB6S2NYdG91NUF5MklLZi9tQ1daM1lTQjJudGtCRjlp?=
 =?utf-8?B?K2s5NFAvWHpwamhvazVya0xNRTRucDZjNXpBMEpORTNFbzRZcGtwL2dvTWZS?=
 =?utf-8?B?aElnc3JuZ0VkN2tSSUlkSlZ5a08vZGJwT3h6WFRJNU5oUStkVzdJNlgwM2Q2?=
 =?utf-8?B?b1NQNlNNa0ErVlhld21YZktMRWkydHdwRDFrK0xXbnEwK0NPNGs3VzV0UnFU?=
 =?utf-8?B?ODhSbmZzYjJ6YW1TckRmZndNcStkWURxYS84ejNWMHR5aWY4cXZuRER0cmEx?=
 =?utf-8?B?UW0yRzQ3dG9zd2NJSzlTTW1TMEpSRU1aU0dtOCsrRDFoYkhPdG1BQjZKbWhH?=
 =?utf-8?B?RStibjl6bHFncTlLMFpQUHd4dmdVb2N1YmFqTTF6VkM4STVxRVNSbnFveXJx?=
 =?utf-8?B?M3ZwZkxvRThtWWlrb2pnTFlLOW9CM1pKZlVNRGhML1M2TUZHNjRTNHdkc1Vk?=
 =?utf-8?B?L3ZuYlIvQ1diNHVqOVBrektKT1pvUFFaalJyczIzVlpncHkrcGpIbHRNd1dP?=
 =?utf-8?Q?Ky0FaqKZ/ywIe6ONkPuf4XXGt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8A624A55F756748AD9200D8847D935A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f14e24-3074-49a3-b1ce-08db872fd522
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 01:39:31.1736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MbuqWU/JtC7npEHq+77DDT1Tr8ANzWVeXdaE72BdkXJf1cD/2+Hze7LZoYCNeLXrt+e/EKDJEaaeT0WTEhmhcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5779
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

T24gTW9uLCAyMDIzLTA3LTE3IGF0IDE3OjQ1IC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IFVuZGVyIGhlYXZ5IGxvYWQsIHRoZSBTR1ggRVBDIHJlY2xhaW1lciAoa3NneGQpIG1heSByZWNs
YWltIHRoZSBTRUNTIEVQQw0KPiBwYWdlIGZvciBhbiBlbmNsYXZlIGFuZCBzZXQgZW5jbC0+c2Vj
cy5lcGNfcGFnZSB0byBOVUxMLiBCdXQgdGhlIFNFQ1MNCj4gRVBDIHBhZ2UgaXMgdXNlZCBmb3Ig
RUFVRyBpbiB0aGUgU0dYICNQRiBoYW5kbGVyIHdpdGhvdXQgY2hlY2tpbmcgZm9yDQo+IE5VTEwg
YW5kIHJlbG9hZGluZy4NCj4gDQo+IEZpeCB0aGlzIGJ5IGNoZWNraW5nIGlmIFNFQ1MgaXMgbG9h
ZGVkIGJlZm9yZSBFQVVHIGFuZCBsb2FkaW5nIGl0IGlmIGl0IHdhcw0KPiByZWNsYWltZWQuDQoN
Ck5pdDoNCg0KTG9va3MgdGhlIHNlbnRlbmNlIGJyZWFrIG9mIHRoZSBzZWNvbmQgcGFyYWdyYXBo
IGlzbid0IGNvbnNpc3RlbnQgd2l0aCB0aGUgZmlyc3QNCnBhcmFncmFwaCwgaS5lLiwgbG9va3Mg
dGhlIGZpcnN0IGxpbmUgaXMgdG9vIGxvbmcgYW5kIHRoZSAid2FzIiBzaG91bGQgYmUgYnJva2Vu
DQp0byB0aGUgc2Vjb25kIGxpbmUuDQoNCkFuZCBJIHRoaW5rIGV2ZW4gZm9yIHRoaXMgc2ltcGxl
IHBhdGNoLCB5b3UgYXJlIHNlbmRpbmcgdG9vIGZyZXF1ZW50bHkuICBUaGUNCnBhdGNoIHN1Ympl
Y3Qgc2hvdWxkIGNvbnRhaW4gdGhlIHZlcnNpb24gbnVtYmVyIHRvbyBzbyBwZW9wbGUgY2FuIGRp
c3Rpbmd1aXNoIGl0DQpmcm9tIHRoZSBwcmV2aW91cyBvbmUuICBFdmVuIGJldHRlciwgcGxlYXNl
IHVzZSAiLS1iYXNlPWF1dG8iIHdoZW4gZ2VuZXJhdGluZw0KdGhlIHBhdGNoIHNvIHBlb3BsZSBj
YW4ga25vdyB0aGUgYmFzZSBjb21taXQgdG8gYXBwbHkgdG8uDQoNCj4gDQo+IEZpeGVzOiA1YTkw
ZDJjM2Y1ZWYgKCJ4ODYvc2d4OiBTdXBwb3J0IGFkZGluZyBvZiBwYWdlcyB0byBhbiBpbml0aWFs
aXplZCBlbmNsYXZlIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9m
Zi1ieTogSGFpdGFvIEh1YW5nIDxoYWl0YW8uaHVhbmdAbGludXguaW50ZWwuY29tPg0KPiAtLS0N
Cj4gIGFyY2gveDg2L2tlcm5lbC9jcHUvc2d4L2VuY2wuYyB8IDI1ICsrKysrKysrKysrKysrKysr
KysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L2VuY2wuYyBi
L2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L2VuY2wuYw0KPiBpbmRleCAyYTBlOTBmZTJhYmMuLjJh
YjU0NGRhMTY2NCAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvZW5jbC5j
DQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L2VuY2wuYw0KPiBAQCAtMjM1LDYgKzIz
NSwxNiBAQCBzdGF0aWMgc3RydWN0IHNneF9lcGNfcGFnZSAqc2d4X2VuY2xfZWxkdShzdHJ1Y3Qg
c2d4X2VuY2xfcGFnZSAqZW5jbF9wYWdlLA0KPiAgCXJldHVybiBlcGNfcGFnZTsNCj4gIH0NCj4g
IA0KPiArc3RhdGljIHN0cnVjdCBzZ3hfZXBjX3BhZ2UgKnNneF9lbmNsX2xvYWRfc2VjcyhzdHJ1
Y3Qgc2d4X2VuY2wgKmVuY2wpDQo+ICt7DQo+ICsJc3RydWN0IHNneF9lcGNfcGFnZSAqZXBjX3Bh
Z2UgPSBlbmNsLT5zZWNzLmVwY19wYWdlOw0KPiArDQo+ICsJaWYgKCFlcGNfcGFnZSkNCj4gKwkJ
ZXBjX3BhZ2UgPSBzZ3hfZW5jbF9lbGR1KCZlbmNsLT5zZWNzLCBOVUxMKTsNCj4gKw0KPiArCXJl
dHVybiBlcGNfcGFnZTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIHN0cnVjdCBzZ3hfZW5jbF9wYWdl
ICpfX3NneF9lbmNsX2xvYWRfcGFnZShzdHJ1Y3Qgc2d4X2VuY2wgKmVuY2wsDQo+ICAJCQkJCQkg
IHN0cnVjdCBzZ3hfZW5jbF9wYWdlICplbnRyeSkNCj4gIHsNCj4gQEAgLTI0OCwxMSArMjU4LDkg
QEAgc3RhdGljIHN0cnVjdCBzZ3hfZW5jbF9wYWdlICpfX3NneF9lbmNsX2xvYWRfcGFnZShzdHJ1
Y3Qgc2d4X2VuY2wgKmVuY2wsDQo+ICAJCXJldHVybiBlbnRyeTsNCj4gIAl9DQo+ICANCj4gLQlp
ZiAoIShlbmNsLT5zZWNzLmVwY19wYWdlKSkgew0KPiAtCQllcGNfcGFnZSA9IHNneF9lbmNsX2Vs
ZHUoJmVuY2wtPnNlY3MsIE5VTEwpOw0KPiAtCQlpZiAoSVNfRVJSKGVwY19wYWdlKSkNCj4gLQkJ
CXJldHVybiBFUlJfQ0FTVChlcGNfcGFnZSk7DQo+IC0JfQ0KPiArCWVwY19wYWdlID0gc2d4X2Vu
Y2xfbG9hZF9zZWNzKGVuY2wpOw0KPiArCWlmIChJU19FUlIoZXBjX3BhZ2UpKQ0KPiArCQlyZXR1
cm4gRVJSX0NBU1QoZXBjX3BhZ2UpOw0KPiAgDQo+ICAJZXBjX3BhZ2UgPSBzZ3hfZW5jbF9lbGR1
KGVudHJ5LCBlbmNsLT5zZWNzLmVwY19wYWdlKTsNCj4gIAlpZiAoSVNfRVJSKGVwY19wYWdlKSkN
Cj4gQEAgLTMzOSw2ICszNDcsMTMgQEAgc3RhdGljIHZtX2ZhdWx0X3Qgc2d4X2VuY2xfZWF1Z19w
YWdlKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLA0KPiAgDQo+ICAJbXV0ZXhfbG9jaygmZW5j
bC0+bG9jayk7DQo+ICANCj4gKwllcGNfcGFnZSA9IHNneF9lbmNsX2xvYWRfc2VjcyhlbmNsKTsN
Cj4gKwlpZiAoSVNfRVJSKGVwY19wYWdlKSkgew0KPiArCQlpZiAoUFRSX0VSUihlcGNfcGFnZSkg
PT0gLUVCVVNZKQ0KPiArCQkJdm1yZXQgPSAgVk1fRkFVTFRfTk9QQUdFOw0KCQkJCV4NCk5pdDog
dHdvIHNwYWNlcyBoZXJlICh5ZWFoIHlvdSBjb3BpZWQgZnJvbSB0aGUgZXhpc3RpbmcgY29kZSwg
YW5kIHNvcnJ5IGZvcmdvdA0KdG8gcG9pbnQgb3V0IGluIHRoZSBwcmV2aW91cyB2ZXJzaW9uKS4N
Cg0KPiArCQlnb3RvIGVycl9vdXRfdW5sb2NrOw0KPiArCX0NCj4gKw0KPiAgCWVwY19wYWdlID0g
c2d4X2FsbG9jX2VwY19wYWdlKGVuY2xfcGFnZSwgZmFsc2UpOw0KPiAgCWlmIChJU19FUlIoZXBj
X3BhZ2UpKSB7DQo+ICAJCWlmIChQVFJfRVJSKGVwY19wYWdlKSA9PSAtRUJVU1kpDQoNCg==
