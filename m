Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A16C7717EC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 03:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjHGBnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 21:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjHGBnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 21:43:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4FE170B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 18:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691372612; x=1722908612;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cq+VdnpUnb+iIb7Yl8BWOXS4djxuLptIYlpGWf3Vfbo=;
  b=hn5ne6f6uCMOd9DgTbTdEFgmjewa3P15DtneMkt30L3fygrsxbxDkUXB
   VXB+40p5gfU+H92cKfcmArhFlCE2m+0mqb38mDvMiZQyOh3uDMJLP/3TI
   MLQCP0j+u0AMRBJ64mqPL7RbQSezWJrQjvHBcJGho+0GnTdN/QnCFHAIR
   +Qd5+3zgVfPCJ39Fng9ESYj1IBzB4fanX4aHpwWghy/sQ7UKTYdUQM5io
   KOkhQKF/t1FRFxuPt9WbcbrGNEo4tRQIAWIMJsatvkBsEZhXbkSkKFpvF
   w9pRgKHcsaViloZTloONScCIN8Ts3Hf0Nj2hiL0G7f+LX4ZmyPK1WloFX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="374101370"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="374101370"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2023 18:40:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="854465608"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="854465608"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 06 Aug 2023 18:40:47 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 6 Aug 2023 18:40:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 6 Aug 2023 18:40:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 6 Aug 2023 18:40:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFShn9ZK9XM5yuMU+FspP8ZJofw3esP88sX355iHLuhiC/fUn/YP/RjQovaXaYGe+jvnv8y1NdFqCqiU0KaytYhG5l2ZPefGbDz0ju0lenFGP7XibyUKrqzCRu96UFl8C9wMsQuoFs/zO/Qn12n8h/8QGuUPCDvR+HvZ7w78Ts1auZ/CZoybnYs2R/7QxpcwqtMgXWDwJqJf4pcTocJqePDu0SyaGUknttzRg87F/d00WbEnzkNMARH6oq/7aXgEwbykAf4+0eMeOxUkFBMC4h0z7EZXpvsJhLFizp0TEjfbTDiL2FC5mD7rRikuJ1Dzm03DJAhepgm8EBjElXPVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cq+VdnpUnb+iIb7Yl8BWOXS4djxuLptIYlpGWf3Vfbo=;
 b=YXOzIlYQ2QIfPS3x/Yn+Jf2DqY4lwMuDTp+N04Y4+WbfCeYh6AaaqN+rJC2ty4x2zHLcSda5AsH1KrFzgsVY7R/1E07NbSwuhfM3gUtUT6HqzEIGS9vt1OV3ZN/7Q0XnzmcdY39ScYt4etkQY94Iq0K65uARTLYFzlQweakDEzCZT4SPIUzfJYDPSS045wCNRr9vGlf5kOYbNU2J8JDwMj6u7iBcmsK4UcxSG7GyBSPlLiPpIjThIZdVIY7mkoppxiBYvqKPrOSMY063WDAWOysp7DiC5T1BgeGv23RUzmwc0j7vFQcxuYYuwSP1LpAFSkcFRHrXpnsEjl6Cru2tGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA2PR11MB4795.namprd11.prod.outlook.com (2603:10b6:806:118::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 01:40:42 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 01:40:42 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>
Subject: Re: [PATCH v3 10/12] x86/virt/tdx: Wire up basic SEAMCALL functions
Thread-Topic: [PATCH v3 10/12] x86/virt/tdx: Wire up basic SEAMCALL functions
Thread-Index: AQHZv7Eyl+F6coJV+0e6U/ItafZ+ha/dNRGAgADr44A=
Date:   Mon, 7 Aug 2023 01:40:42 +0000
Message-ID: <030a485fb852c4604371adc3aeb5511ac6501b88.camel@intel.com>
References: <cover.1690369495.git.kai.huang@intel.com>
         <b57460d1d12d1f6eac9073cefd6976812b1eef5f.1690369495.git.kai.huang@intel.com>
         <20230806113623.f7am5levfsllpko7@box.shutemov.name>
In-Reply-To: <20230806113623.f7am5levfsllpko7@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA2PR11MB4795:EE_
x-ms-office365-filtering-correlation-id: 6c41edce-c0a3-4f62-3d45-08db96e74fb8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j0Gne1SstMrgr3MsYuUJ5ErRhrifXGpZI9tWqbjrDG+YQAGBLpFqymO4RMpzu/KNfcNfIODcN+Jlv4YGFD2X3Twf3R+YAJ/dS/Sr28mxUE1MeHyLfzfPXROAWNVfTa7p0DRfW2qyQKuX8XkGYQtNx6nRseEhFMzHgaGbz3b460hXFuRMVYwBweWp5lJZvP96olD+nExlK/KEj1aXpoNbdjkfaXPL+j4ftuvXx66w7PP2isU5DV+piGyA15kCXoRdArWyvWrkjni1hhlJllU2NpRGq1uQT2J6+8wZkwl9ZKzbYn+MakfsTl2BiLWWnrLcfIzU7B0hWSrZXlmQZfqUUN9/Jz6nHEk+hCdkNeo4671xlyHZ181H83isd1OaUW6vR4F/x9dbj5npTLGDPPTvHyED7g6VEXcycSqiKPi6ITHq+xNKorrbuXzS3kgPuX0oLumLPNW8K80o4stILpmgh0ROXBbgBw7vXqwgqQxlLTjQQZvltSjhpFSgv8w8FM69fC2hoHMfPwTNK/nDFg3zHnTc1hPBVli0KaRfINkP6cFhi26M1QluJs6F3wQ2tvhO/bDSZvmHqYH60ndAru8RxMIwIlFNaY0e9p88yLgzKCbDmUKBa7t+3sHYmNSWTD3E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199021)(1800799003)(186006)(2616005)(6486002)(558084003)(71200400001)(6512007)(478600001)(86362001)(122000001)(82960400001)(26005)(36756003)(6506007)(41300700001)(316002)(5660300002)(8936002)(8676002)(7416002)(38070700005)(54906003)(38100700002)(4326008)(6916009)(2906002)(66556008)(66476007)(66446008)(91956017)(64756008)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkxmZ1JSVXVyQ1owNDhaR2pHSnNzRTZZMU9FdWFuUnlBOThDVzFOdkxJOFJo?=
 =?utf-8?B?SkNVNld5NlNjZkowcVdkQ041ZVpORU9zdy9lbkRSaUFiV2xFUExWdVZtNVBx?=
 =?utf-8?B?VlVhOUhyK2l5eHEvUXNhT25TM25XUTMySDVBb1pqUTl1S01RK2pmN3pCME9R?=
 =?utf-8?B?VVArS0ZkSzJpTmMxYlptTmdMcUhGN2d0azA5V0I3SHlDNEFTdk9sc1l1TE8w?=
 =?utf-8?B?Sk5YS0YwUEJkVkxpbVNSRmZoYlI2a0JyYnVOeHZTSlgvU1d3WXpkTDcrMkVN?=
 =?utf-8?B?WDM2VzRQWnhHbDBKUDJvTGNZazRsQXFvdXdwQURUMG1rNnZOempWbDBpV0Yz?=
 =?utf-8?B?K0FsbVp1TlB1cE01WjdIYjFSbkRmdEFOaFhSTEZTM1N6ZGtzckJoN2cvZmVH?=
 =?utf-8?B?QlQ3bGY5dFVTN2taVnZFbXlueHRsSVVNWGJVaVpnTXp5MENDQUhzOHdzZkoy?=
 =?utf-8?B?STRSd0Nia2lVa3pDNGdBMFZCVGZwNmJWZVh0YS9NTUF4VEgyL0gwVEhSY3NQ?=
 =?utf-8?B?U2ZXUmY1cmVMYlJXR2hQWjhDUmVXL24xeEFOK0g2dEdKT2dXZjI3aVlDQlor?=
 =?utf-8?B?TE9mWk1jRUJXYnc1dEpnK1QxY1lmMVhnTnNndzhLSVJrMzYraVQrQ29pUlpV?=
 =?utf-8?B?RWh5NWNpVEMxQTFWNUpYdkc1T054citORVRHY0xKem9oTi9vUGlUVmpDVWo4?=
 =?utf-8?B?VzFTUjZkaHAwR1BMZkt5ZzdMMndvR3lxM0FuQUhFY243TUF0aHZnQmR4VFY1?=
 =?utf-8?B?RDkyR0NJTjY5Z2MwSWxQMzQ5d25lcDcxS3pNZ3NLdmtPTWc0QVJNTnRhWGxW?=
 =?utf-8?B?bEpBSVlONGlZelU2WTA2NjhrK3BIY2pxM0hLTEZ2azZmU3lXUHVIYmoybGJy?=
 =?utf-8?B?aHdoanlTNVhEYjU2RDNxcEpNWlhLUXRFVEN4dyt5YkQ5RFVxUVVXR1hPZUNH?=
 =?utf-8?B?bmdtZTcxZTdyVUFYeERzMjl0SU9GRm1wWmU4M0dLRjlpNVdSWHpaU1g5d1JZ?=
 =?utf-8?B?SE55QVpQdXNORzdnM2RXYnBLczlXbGx1Y2NIeXNCcFZnWmM1aXU1QWd3WG1D?=
 =?utf-8?B?VjQzVVpiamUvQTBaZFV6TkZyTE1ZS3VBQ3RaT29YbGdQbFdlNHFqeU5QM0Jq?=
 =?utf-8?B?S0Q2SlVLSHNpNGRROTd1UFUxaTgzWmpQVno0TDlRZzJud3dXaW9JM1FLdzRM?=
 =?utf-8?B?MWdXbHc0UWN4UkI3ZHJzYkRFVVVIUnAxYmFrRnhUVE5TTFFYNThMQlI0bWR0?=
 =?utf-8?B?Qk9JNHQxbUtVY05jYVJMTlNzbGhUeXVKUGVIVExtN2NZSFI0TXVvK2Q1WDFx?=
 =?utf-8?B?U0xVNkozMFBwUWs1UlRkT085VmxMcEY2UndubWVRRnYreU5zTC9BRVVQKzhT?=
 =?utf-8?B?ckMxbFlSM0UxREJGby9OSkxwaldnaEZBQkJUSHVpZkRwQXAvNWVWWmhFc1kv?=
 =?utf-8?B?UzhNRWhVQzVCdk9WQmd2YWpOMnBpNS9GVjVBcE9XejZkcFltUC9sSjJqQkFC?=
 =?utf-8?B?alpJWU9ObHBBd2wvSktFZHd0ZkxqeFJJck1kZFJGRXA4Q3QrdlBWZE9Gc1Y1?=
 =?utf-8?B?UlRXZ1JoWmxsbVl6Z2p3VC9iM1AxOTJSVFN2SnFuMUtySmJtNW1aR1dtQ3Ar?=
 =?utf-8?B?OXl3Y09XSkRKL1JjWFZsQ2RITVpqQWtLRkUyZktrWldLcHVJeHBzdEhoV0c5?=
 =?utf-8?B?QnBadHNwVW5jVGJhN1pyTEI1VnFqYW8rZkM2WnVqdHc3S1FjUjlMWnhmQ09Q?=
 =?utf-8?B?N0RZKzRkazZvSkcyQXNNTzJmci9nZ28xNXg3N1JSYW8zNHE4VVJRdlJDYm84?=
 =?utf-8?B?clM4U0JFT1kwd3lFbnlidzJ6Zm5Tc1RFKzBsaWhnSldtL25hQ0lrY0t1RXl0?=
 =?utf-8?B?d1RNN1hhT1cvRmpWeHNQeVRCTWdmTW42cUZteWcyRG5kRHNpNFBpRy9nTUN2?=
 =?utf-8?B?cEtjTTRaUE84ZmxZQkw5eGtsWjZNQnkvNGlPZEpFK0pCUEQya3BiWXd4M0lS?=
 =?utf-8?B?S3JUMjdlak1IZTBaWDkvZVFEbktDaFZ0ODRqcVBEM2hiK3JkVU5pc1BVRkFh?=
 =?utf-8?B?VDYzUlpEVEhkT2NCUVpYaXRJZldWMVpzeGNoYlVEUGJWbHpRemFDUURnWGNL?=
 =?utf-8?Q?edTvtuRou7AOpk0SGf5Og9hr7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4794F7097B3A64ABCCA025843B03C61@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c41edce-c0a3-4f62-3d45-08db96e74fb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 01:40:42.1701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wmHGcfS+DvHfv6PIglFvfyq2EPYtEAitehnkq2duXa+ShIXg2q/p9EiVs+4Cs7LATtnr0LYPHO3CWGAvhHjfOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4795
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gIA0KPiA+ICtjb25maWcgSU5URUxfVERYX0hPU1QNCj4gPiArCWJvb2wgIkludGVsIFRy
dXN0IERvbWFpbiBFeHRlbnNpb25zIChURFgpIGhvc3Qgc3VwcG9ydCINCj4gPiArCWRlcGVuZHMg
b24gQ1BVX1NVUF9JTlRFTA0KPiA+ICsJZGVwZW5kcyBvbiBYODZfNjQNCj4gPiArCWRlcGVuZHMg
b24gS1ZNX0lOVEVMDQo+IA0KPiBIbS4gSSBleHBlY3RlZCBLVk1fSU5URUwgdG8gZGVwZW5kIG9u
IENQVV9TVVBfSU5URUwsIGJ1dCBhcHBhcmVudGx5IG5vLg0KPiBBbnkgcmVhc29ucyB3aHk/DQoN
CkhtbS4uIE5vdCBzdXJlIDotKQ0KDQo=
