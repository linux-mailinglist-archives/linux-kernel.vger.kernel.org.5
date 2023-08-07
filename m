Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8D377353B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 01:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjHGXvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 19:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHGXvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 19:51:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E029E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 16:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691452269; x=1722988269;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5LRREy+TBRyPW1lZSRurygLI4772NTo07HHw55pIp70=;
  b=g7XWWViv2e2XUbxnUq7LUZla+2B/WGh6gdaUOXl9Qw9So5doUDD2e4Vr
   sy/h9rRbvcec5BRIYb7TaT4M83V9OFmw0vBv/0bpK2K10bljWLu8myOew
   dbaNYlqPxwSdocYwv5BpwUz0BNciExSlYhAQ2aqyVOerFqgqy71ywVBW8
   ey0b+qxYYWXFYDp9MJuT57r0miB00fX8j9pevWxnJuC5CJk8eWJ+YoqYq
   GrYi+6Ms8rIMVHYkHYfaxSBaha88Vxfa8gt5ZKtkdPxM/qU/lIWQDni1y
   bfiCCUfHlrTJrcU1KK/39FeecPxFCpyKZZ5QhsECgLj89Uj4YUZgzU3qY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="373431420"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="373431420"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 16:51:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="904998430"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="904998430"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 07 Aug 2023 16:51:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 16:51:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 16:51:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 7 Aug 2023 16:51:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 7 Aug 2023 16:51:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8wRkB5BjkaWHJe0luc0ubv0tekqEVP0qQ5HIsi1Ck7JjXJ+4n1QrSTHujndr7gkPsEKMC1dkbDkvL9mjxzJadn7LNaFOV94dRv1yfj7VhbM3c1oCBN0Yc3cQaTJiCRrfADRutWJdlR8fyrNMieZr0pTtnz2kPbBZ6zyigqR+PwnqR95uIZlPHUn1rOLxpQ3NqiT3SbwScb22waPQu8KcO/EjV86cqEnhl6iv47HOtNu1ax+3ER0U/Xn33FgmsCyTcxjWK4Of5w4TXJPV7UghPW4jowfM8R0dH48gMon7h2jO87IQ15Efm0f9R0JmCtPKxCP35tTQsZmGLTWpxYVwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LRREy+TBRyPW1lZSRurygLI4772NTo07HHw55pIp70=;
 b=G83Nam+n/jV8TkYAIg8CWE3Jf07x5miWScUj3XhsSfaIYPLRZOmq3T92wbzYEQ6oMHk7f8l9wti09VM2yWRzp1mPvggHuXGVvClNl4MtIS2MXCeQZJdHQdxKxES70J+w16ZCqy26pmaJDJnXCrvFkCyFFgYHL10geRAZAIkqijUMZfGfN5Bxtm7X4mUcgoyshVVS0RI1LSfS2oix2C1rDyOl71/xRdKweHZMZgB+WYZIAL1r/0tJy9jN4xbWnRtv2m/kQDhEPNRSOOapidc3UPEF+Y8pzZrHyYcichy6dWxXhfu9aRbs0nDWQygNYTJISQ1ygxVPv1NgLTrdzAqGeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BN9PR11MB5531.namprd11.prod.outlook.com (2603:10b6:408:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 23:51:01 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 23:51:01 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Christopherson,, Sean" <seanjc@google.com>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>
Subject: Re: [PATCH v3 10/12] x86/virt/tdx: Wire up basic SEAMCALL functions
Thread-Topic: [PATCH v3 10/12] x86/virt/tdx: Wire up basic SEAMCALL functions
Thread-Index: AQHZv7Eyl+F6coJV+0e6U/ItafZ+ha/dNRGAgADr44CAANb4gIAAnLmA
Date:   Mon, 7 Aug 2023 23:51:01 +0000
Message-ID: <048399f29d702435c41b11c3ff16a1ae257f70cd.camel@intel.com>
References: <cover.1690369495.git.kai.huang@intel.com>
         <b57460d1d12d1f6eac9073cefd6976812b1eef5f.1690369495.git.kai.huang@intel.com>
         <20230806113623.f7am5levfsllpko7@box.shutemov.name>
         <030a485fb852c4604371adc3aeb5511ac6501b88.camel@intel.com>
         <ZND+Cs8roqwnGba4@google.com>
In-Reply-To: <ZND+Cs8roqwnGba4@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BN9PR11MB5531:EE_
x-ms-office365-filtering-correlation-id: 37218412-f5b9-4860-25e6-08db97a127e6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iyU3H8OlxWpJSBN2lAIHY4mYtJ54/PZ8pQv+lmb5wmaJocz4sNAZTZ7W2lPIlE2sUUFU+4dHdCAA5lnoVjE16aHpAqny6e9lZm4hDWu8stBC6v3zJ2W5o6tKWBoBxDKGiyKKn/HEBrKUs20vxj+SZ8YceZP7ucbBpbf/jl9Bps4AUd4qXlohX8fi5lbBJ4hRF+eEDB5PO9Jm670sGe0bkLTzVOwWcDZr37Jusmb1PYXkbsK8284iswYnrnS6qOhwQ1TbWipwR9VWEWrjHkwTTqqE4jVY1e8LuZEibDE86pLo2ZX9Om5MAyImhXYlTAcIJhrkYjuIbFC3o6uZZ3It8VY70jUhD6noqig/n+96oqz4qnpcViT44z1+PcUQWc4uy+YczeGEYQv3oLn3zL7EGURlk24uygwBfk3VoqRo/cVR9ZgJx9S7LRO7QqvjjYHTNj4jczAwxkw1rbBKCu0QFE/Iq8n+wjr0vU0PvLGbkXoUsaET8t66H8ABQNtePh9j/ie6yhPlCKH1c7QxL8ffqBJEYNEntUGlmSr4i1BGqt/T1mbT/0nz8rsC3aCJKrorpILmA5vSWcIsqQ8aRGHmpmGbCVuZIxnY8EyDEQa0lCE/JKcT2ya7fY4uun5Irh7sadLCKwDeZ7jYNL2sFEuvF6o+dTIVZedQAcIwmATCYXk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(90011799007)(90021799007)(186006)(1800799003)(2616005)(36756003)(6512007)(4326008)(316002)(6916009)(86362001)(478600001)(122000001)(54906003)(38100700002)(71200400001)(76116006)(66946007)(91956017)(6486002)(6506007)(82960400001)(66446008)(66476007)(64756008)(66556008)(41300700001)(26005)(38070700005)(8936002)(4744005)(8676002)(2906002)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THloQlRQWEx2Z2FFdjRmMVFVZ0dLOHhlMkFjMHJSWmVDNkVJVFY5empWV0ZR?=
 =?utf-8?B?TnhrZVo5SEJ2eUZpbTdrWS9PYXdZTUR3cWE5aGtza2R1SW93clRlSy9JLzBP?=
 =?utf-8?B?dmtsZ3U5MnI2ZlZvUDdWWUMzdFNNaVRrc0x5QktybDZQU3ViZDJhbURjWUNp?=
 =?utf-8?B?YW9kRnMvK1ZKVXRzR3N4WFdYM2RMU3NMMllrNHV4QTZEZU1GOUlKUW9Ralp2?=
 =?utf-8?B?SFBuekdpMkJvQ0FkYWNPdmRSZEcvaEU1YTA3YnlKZjNBdE01bm04OWswb29E?=
 =?utf-8?B?NTFadVNlcFBuNndEaVVvTlN0QnlaSnpoYXFyM3orMU1kYUh3RFgwL0dmYkYx?=
 =?utf-8?B?dW5TamQvaGg2T2F3eWc2c2cxN0k1RlNuWFlzMGZTdjBnWEozZjhGZnNCWlZU?=
 =?utf-8?B?WWJWVUViTFFZbW42eU5FekhKVDlKSzJta1pVYkxvK2dKa2txU2d3aVZaQjQ0?=
 =?utf-8?B?aHc1cHVIM1ZKbEx4MkF0WE1TQ0JDVEhpK1FFckZ3K3pYcmF5OE51eTl6dVJy?=
 =?utf-8?B?MnNzOUU5SnZGZTlsYTdiaE1UTWxIcFpoK2tHTzU1anNRZERGQzVWbStGODQ3?=
 =?utf-8?B?L3EwL29rZVkzZWtxQkQyQXo0MFZMNno1SGZCN0hOV2ZGYkE3b0tJVjhHOFVT?=
 =?utf-8?B?aDdJc2hvaUV6Z1BHcFBLaUlFLy9rSGZVYVJMUDNra0hNV09lYVJTdVpiVmRY?=
 =?utf-8?B?NzFvMWhrUGQwQXdZdDdkcVF4WXpCSGhSdm9vNzU5Z2NMSVJQVHBaNDhBY2Zh?=
 =?utf-8?B?RFR6WWY3cElWbldrOXlVdEQ0S1VlaGdsQ2hVWXUyWnE5NWxkc3Y4RHZ1c3lh?=
 =?utf-8?B?S0kwSFlVYUlEaWlpTTliZVFnaWxoRXg4SzZFK3lRa0F0c05WeXJTZUxTSjYz?=
 =?utf-8?B?bE1Xa21ka2pOendMdkpTOFFJejhxcTV4M250UXRzejJiMWZEK0o5RlJuVEFH?=
 =?utf-8?B?MjVHZVJ5ME9ESFB1cldDR0dOdUpVTVdXdlFTQXNIZHMveTNKdnpScldWanNz?=
 =?utf-8?B?U3d6OVQvdmwvc3Q0eWpsY3l6OWwzYkpVRy9xNEVVb2JGemI4ZmVMcWhvdVIv?=
 =?utf-8?B?d3VERGlwUVBrUmd1S3BSZmcrZlk5NzRzbTBuRUpoNUFOMHZuc2ZVQlZjZEpo?=
 =?utf-8?B?cHczMWNqck5DZ2hrMDhjSlF2b0pKODJLSGMxanhvRTgwT3ZqYjRpNUlsb09K?=
 =?utf-8?B?cDl4Ym1uaUhac1F0MytvajZjdGFJSXUybS9DRnhvWGREUUliWlBRQWFBaklT?=
 =?utf-8?B?Z3BPb3FrK3dvSWc1djFsMGpxUHEwZUZLV2MyVkhQNldtMzQ2ZDh5aE1lRmJH?=
 =?utf-8?B?clcxR2xRN2Z3YnBKZTlvVS9RK1Yvczc1RU5UNy91c3QvME90dUZrYlc5aDBj?=
 =?utf-8?B?NzFieU1ZaVFEMnZjY0ZxVzVCS2tmSElhVURjNit4OWN3UWxMT0lJc3g0L0RL?=
 =?utf-8?B?TDJKS2UzMFAzR0ZMSlZkbnZiTE1sZGhBTmsydmlHbFFBTFV4TGNiaE5JTFJH?=
 =?utf-8?B?Ty83ZkFDUDc0Y1hXd0QzNVQyMitQaDRTMUFvVFFrdTU3SUNrc0dPbVV1N1V0?=
 =?utf-8?B?S0kvZUtxUmtXb1p3Um53c2RtZUs0U2xjQk5JU2pmNUhXWXkxTWdCQ1VwTUJH?=
 =?utf-8?B?dExoZUdyT011aVdpMGU1NXRTQVN6S0loa2JnSE5SdnRaK3dKQmJJVk1WOXZj?=
 =?utf-8?B?andjZ2huTUpudzQ5aXMvaXIxek1jZlF5TXZkb2p0TjlGYTh4c0MyTmw1bGl5?=
 =?utf-8?B?Y01yM1BWR3hXYVpFeVZvZG1lemlCK3JnbkhZcWw5dWdvaDFqN3ZPMHVxMEF4?=
 =?utf-8?B?ZXRqS3ZvU2pHUGV6Q2NPaGQrMUk5RzZOY3FoT1pGZ2xIQjB3MmhHakY4dmUy?=
 =?utf-8?B?Vit2ZlZVQXpmdFFSMkJFZWI0L2trWkVVek5YME5mVDZWY3VxZG91R1JnY051?=
 =?utf-8?B?NTBtcGhqUGE1MWZIbSt3QVBqYnlVS2NwUG1NaThZakswamFFaXpUK3ZzS0Qr?=
 =?utf-8?B?Z1VDNlNVL0JXalVwTlFMaXZ2L0J2aU5SbXFmc2tyNnpBZHI0ZmR5ZHJkcm1o?=
 =?utf-8?B?NktGTnZaekZCU09XZjc0dUNCc2JLcUN1RmhKKzMvdm9rMGZ3Q0o3Z1NUaExB?=
 =?utf-8?B?YjRTZXd2aXFzYzI0WUNFYUlmNm5DMVh6VDJQdUVwSlgwQWZrRFFWenM1SDQy?=
 =?utf-8?B?RHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04C210AF4FF2A44DBE19DBCAA0A86F66@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37218412-f5b9-4860-25e6-08db97a127e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 23:51:01.7738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3WdJ3a8ciyCmiWvVXDMyCjgGYaNdj6g/hdYUeaxEGmKIb2o5t576w6sBSo8BbJza4mOt8Vf0Rdl0IfI7KSzOig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5531
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA4LTA3IGF0IDA3OjMwIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBNb24sIEF1ZyAwNywgMjAyMywgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IA0KPiA+
ID4gPiAgDQo+ID4gPiA+ICtjb25maWcgSU5URUxfVERYX0hPU1QNCj4gPiA+ID4gKwlib29sICJJ
bnRlbCBUcnVzdCBEb21haW4gRXh0ZW5zaW9ucyAoVERYKSBob3N0IHN1cHBvcnQiDQo+ID4gPiA+
ICsJZGVwZW5kcyBvbiBDUFVfU1VQX0lOVEVMDQo+ID4gPiA+ICsJZGVwZW5kcyBvbiBYODZfNjQN
Cj4gPiA+ID4gKwlkZXBlbmRzIG9uIEtWTV9JTlRFTA0KPiA+ID4gDQo+ID4gPiBIbS4gSSBleHBl
Y3RlZCBLVk1fSU5URUwgdG8gZGVwZW5kIG9uIENQVV9TVVBfSU5URUwsIGJ1dCBhcHBhcmVudGx5
IG5vLg0KPiA+ID4gQW55IHJlYXNvbnMgd2h5Pw0KPiA+IA0KPiA+IEhtbS4uIE5vdCBzdXJlIDot
KQ0KPiANCj4gQ2VudHVhciBhbmQgWmhhb3hpbiBDUFVzIGFsc28gc3VwcG9ydCBWTVguDQo+IA0K
PiAgIGNvbW1pdCA4ZjYzYWFmNWM0OTNjNjUwMmEwNTg1ODVjZGZhM2M3MWNkZjhjNDRhDQo+ICAg
QXV0aG9yOiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4NCj4gICBEYXRl
OiAgIEZyaSBEZWMgMjAgMjA6NDU6MTMgMjAxOSAtMDgwMA0KPiANCj4gICAgIEtWTTogVk1YOiBB
bGxvdyBLVk1fSU5URUwgd2hlbiBidWlsZGluZyBmb3IgQ2VudGF1ciBhbmQvb3IgWmhhb3hpbiBD
UFVzDQo+ICAgICANCj4gICAgIENoYW5nZSB0aGUgZGVwZW5kZW5jeSBmb3IgS1ZNX0lOVEVMLCBp
LmUuIEtWTSB3LyBWTVgsIGZyb20gSW50ZWwgQ1BVcyB0bw0KPiAgICAgYW55IENQVSB0aGF0IHN1
cHBvcnRzIHRoZSBJQTMyX0ZFQVRfQ1RMIE1TUiBhbmQgdGh1cyBWTVggZnVuY3Rpb25hbGl0eS4N
Cj4gICAgIFRoaXMgZWZmZWN0aXZlbHkgYWxsb3dzIGJ1aWxkaW5nIEtWTV9JTlRFTCBmb3IgQ2Vu
dGF1ciBhbmQgWmhhb3hpbiBDUFVzLg0KPiANCg0KQWguIFRoYW5rcyBTZWFuIQ0K
