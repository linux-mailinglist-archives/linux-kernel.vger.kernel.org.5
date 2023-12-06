Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC488077A3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378829AbjLFSg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378355AbjLFSgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:36:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4B518D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701887818; x=1733423818;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Fvf06t4TtBJYKEaVLpPQYyExg7dZS57o4gwNAMqWKqk=;
  b=IfeGrU7smtKfjhOxDR17IJ5si1BjuH+dE90BKJ2HmqNvg3CTPsiw2gnG
   MlOqLE965U9NzUEPAZcnUut0Bu6qLFCzRiLGHR56+kIw6WMuEOoH2dNNj
   P0IGezE4ZbAZDb6awqawZ6B5xGr7yLG3dWh8rWepV4ndBPKxVov+0c4eW
   0AuTXRx8YulCrgL+G+Uz2qHxswenC3ltIE32ddep5Vt+uhPEnbUhPxw3p
   mmuCP0n0RQ8P1Ich2hWCpvu2iBHaavY3wMvJx0a+jTxoL+5PB7fCtTeIY
   5nHDaHc8kotVPt0qnIyRBWnnRECeBjl+/T9rLQSNQYOOQipauB4Nn17Sn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="391275934"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="391275934"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 10:36:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="19409147"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 10:36:41 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 10:36:39 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 10:36:39 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 10:36:39 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 10:36:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5HpNmJpTf6GQucIV5BdjxgVoZvMp4HB5JUAxfeyQoiyZqa75GtUDq5WJT2FUO4gaDF6UMo2Y2K6JBPl3HFdjGzCMlyZ/2mlKNwuzB6Y7U/0GiHgHOsizu2vi+WmlNzvt/NXY2swLGiyAcWXayXnI2ROOCsZCeYo5XeV+5YXO1f+o/89EEWog7DZnASRR2ZRzRhODH8UjW+D0Ej3MRG5TbCFeLlC5SNfr1SFlrKUZ94HrLlcFpGl+4B4e98PLp9rPv44S4WhQyLAn/3TCyfUhFx+q8T9AYGME/tal2JbKjkISX6r4jXXswH9Dvypn7cCwiMXwaMrXG8bVIWX4BabMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fvf06t4TtBJYKEaVLpPQYyExg7dZS57o4gwNAMqWKqk=;
 b=FQT5dZMvmh7w3dkjNwNYjYjH2e/7QKqD8y2PuVetSQzn2q12GD3CxzpbMnLStxTGT1wlHudOguaPE/XVjSyWLzNa7JB54q9zqMgFCbjfcDlypXAixSTbKWB4orcYZtGXD+y8P9LLQWHHBpPuj/Dy3nD2eDvlUqfEUHZnjzJJk12+EvxLpliXy/tGaoyH00e1+6XEBAYlgABNB4HMkThmnlQQ95EZmgpwI/8zPoXmjYWpcpEBTLahIbhyEHL3a+B6LD1G20beACSdgzg8+c5CQOUQPYNuqrWbRCmAkefxTjoZcxztTG90Q3c7XHyDmD0tfYjdVc0l9x63XBs8RnU+jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB8686.namprd11.prod.outlook.com (2603:10b6:8:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 18:36:30 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93%4]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 18:36:30 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
Thread-Topic: [PATCH v2] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
Thread-Index: AQHaCR9CmUnE0ixBgUKTFgfG39i7jrCc1AKA
Date:   Wed, 6 Dec 2023 18:36:30 +0000
Message-ID: <1274aee24f065e33139be41d830e572edc9f8cd6.camel@intel.com>
References: <20231027214744.1742056-1-rick.p.edgecombe@intel.com>
In-Reply-To: <20231027214744.1742056-1-rick.p.edgecombe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB8686:EE_
x-ms-office365-filtering-correlation-id: 36364531-43e8-4179-5c43-08dbf68a43cd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7ArCzHmEo9FHAsDUkmdzkcH/7teOQqfK167EJP0VK6l73BxJBUq0I5lhLzrqsCF8kiaRhKi74qKtZsv4ENJH2+NJof6k0uPrVHiTtLI2gcFK76qJ7Wi1u1DB9UAvIvh2GIDOBNVly/uwHDNwMb+wcr9dV4nl0gB0EtRD+42rDhPNdqG8hOCiDU+fzSjpodVUig3aM1Zq+5qOfrcNfl7/aGoi+daqP2d2egVPWWdis7NIEvuS+3GAgtiJn68AOkwZ600jpivonK+d6kq/1LY4GUTGEQJjpka1JRvSnm1TciG/5+ZvCjj8TWnOhnlIU+cBhO+hWBKWuVbapbdM2DyufY1xtQgtUs1+vhVNuoAGgBavBtIex3DIWRX5ywQnmzAzWhGISVn1rT8CmcUFJZ0HlQ+LuJ7dwHNb5wV1QpKoWXzI5iS8JN64i56OM3Qzr9N1az8YYPJHNKB5R7wd6L1qL+iqjo+iMg9CzF+SY84XuI0gOUKJyioYk1GdzgjYG5YbXrP4bxf4paeZiHSYY8BYmnfhbBLArJPcusDreormBl/aoO5sTdbwmScBqpH8i0CcSPGppxWy0Nl7L8JkmBQNmARD3N8RkhRLlZjz4KRguTtjxRs4xHqNgOK02KHJqs9r8qUgmjo8bWM+sikB9RqxhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38070700009)(921008)(8936002)(6506007)(478600001)(6486002)(122000001)(83380400001)(26005)(8676002)(64756008)(91956017)(110136005)(316002)(76116006)(66446008)(66476007)(66556008)(66946007)(2616005)(71200400001)(38100700002)(7416002)(6512007)(82960400001)(86362001)(4001150100001)(2906002)(5660300002)(41300700001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGViM3FVbG5Tc3lKT1daV1YwUnNibVFqS0hYTUk0L2I0dWY5YXRKQi85c0ZE?=
 =?utf-8?B?Um5NaGJ4MlRwOW55cXYzNXJ3anBnVWRjM05jeTlxQ2lRMmtpemEzd3l2Mmhk?=
 =?utf-8?B?KzlrWm9ITVBXL0kwZ2ZXcWM1YlpwMUNyWkIrcjNBOTVycGI0Qmp2Z0VBamJG?=
 =?utf-8?B?Z3NuL2diVnF0dFhjR3hrUjRxYjBEYUx4VC9zZVdTVHBTVUNqOW1IdkFtUytH?=
 =?utf-8?B?V1VBMDhhVFFXUHZLV3BqeFYzOHNOM04zNmNWWlpSSzZuRGErdk5DeWx5eDZa?=
 =?utf-8?B?REllMDExTmhPeERLY3dtNXVaZm9sbThCckpHeWh0M0N5UXZRRER1UXZqOHpp?=
 =?utf-8?B?T21lQ3ZGQ3BkWER3cVd0NmhzZ084bFRPQ2dVdG1oZ25kdEY0RVlTYUwwY3BM?=
 =?utf-8?B?NFRmMFpLRHg0K0pBRkVUb3N1YjZTVlBSNmpBYTYvaStIVEFnc1AxVXRnNFh1?=
 =?utf-8?B?VHNVR0x1dWxGMU1PY1Vhcm9ieUFTVTRTOGdHL1h6NWNYeE1odjg4NDZVZVdK?=
 =?utf-8?B?U1lQM0tiV3ovSkVPVzZxcmxSNThMOW9UM3FWdTNCazdNMXN1UEl6ZzRPVXVr?=
 =?utf-8?B?YmV4dW1pcWlRVlExbHp2QkY1UWtZc3UvaE0vSVFFbW9UdjhKQnJXdE95Mi9V?=
 =?utf-8?B?NTBUN2YvaWMzWHpYM1ltaTBmYm0zaVBDdll0eFJRMUVZZU1kVm91Wncxek9X?=
 =?utf-8?B?TXR2azE1My9FZnNxbWovQTJCZFhTWnJKbVVMUHdMMVpkL3BjRklxa3RsV1BQ?=
 =?utf-8?B?S0lqYVNMUkRvb3hMd2hpQ0JwcXRLb2g4UFRYYzV4dGVRRDNLaTlQTGlUSVdP?=
 =?utf-8?B?UDF2M0w3WXRRWEFZcUdFT0tjODVMS1Q1Rmh0eHExbk9tS1BGcEFnM0dmb1d1?=
 =?utf-8?B?c0VueXNHdFNBVFJCRTBIcFdRNC9STUZEOEtJc1FycWlnZjQ3Z29ReE4wTFFm?=
 =?utf-8?B?ZDEzbHBuMWl5ZDh6K3QyU0d1Q1FlZDZlcktnS21pRDRKK3RwRnFtQUtoZy9j?=
 =?utf-8?B?OFZOa2h6R3RxblZHMmp2NVYvYVQwSFpmMlVyMm5CejFTcS9xVVdwWmZaVHdN?=
 =?utf-8?B?K29HYzNQNWZocWIzOWtJNG9SNmsvNE5BL1hYSW9VWVIyWC8wVm5YNE95c3Y4?=
 =?utf-8?B?aC93ck5wbTZDWUdlS3ZzK0YzREpiejhlY1NITWRrTi95b1VOeUlDdnRGZzMr?=
 =?utf-8?B?TUVjU3M0V3REVjNuSHhCOGphVVJHZ0hJNzQwc3p5TWorWlovckFNWklwUWNJ?=
 =?utf-8?B?akdIRXZyTHdtcGh5UEdWb21LREU1dzNKQi9HKytzcGJZYkFoaE1vRGZZRjNL?=
 =?utf-8?B?Y1lUejlQU2xQeml3UDhGVWlIbUR6Mm56ZkVwQTFSaGtOaUtCdVY1cXk4eUJB?=
 =?utf-8?B?SDAvMnlldkpsbWRCQSs0RkpOenE0OHByVHRySzE0MHZpM0syRy9jS3BQYm9K?=
 =?utf-8?B?WklHNU5VYmViSXJrbzBLdG1vdTdCWFZib25DQkVpdUFVWUlrRVpMQ3hRNFpN?=
 =?utf-8?B?SklNOFc2eE8xT0hWSzhMNzB1R1MxWlhNTnVoNGRnTUF4TkdsYWVoSDQyaEtO?=
 =?utf-8?B?MzNmaFk4eDc0OFVhbDZ2b0QrWldjajcrVTkwRkRRcU1ZRTlnYzFJMU9iQzJM?=
 =?utf-8?B?dVpaNm43NUlwWXpZbHlSQ0xqL3RQRTR1Zk01b29ITWdaYXVVOWZrOFczQ0ts?=
 =?utf-8?B?d3lEYTVUNHJMVTVlalpLK0NsbmpsMFhjV09Fb1ZLeTcxcGI5WUJJMjYzTlFX?=
 =?utf-8?B?cHhGdytsZk00Z3g4N1NzdjZCWURtSGk4SjZLaXNtdFBmRnBZNHFEN2FrTldx?=
 =?utf-8?B?Y0FFUVFETGJpbmxoM1FkcG9zNFVkbDZCYkM3VUJ5V2dtVCtWZnVGQ1NYY2Zk?=
 =?utf-8?B?MnE4OGFQL0hKQ1g2cHZ4NU43NTFhajYrVFRqbDVDTmR0RTlTOHNrVXljYlpD?=
 =?utf-8?B?MkEvK0szRFI2ak42eThQWnFiOEtGOFMyalhML0JObDVrN0hpeTJjN2NjeTRD?=
 =?utf-8?B?cDdJa3loWlVublp6Nm1aTDMySEwzV080MThBeFhOeDdabVp6VTV0WkMvdldV?=
 =?utf-8?B?cXBwdGhqa0tjOXlJQ21yOUwyMU1SZ1cxTVg3R0JxT2pqanR4aVVnWjNTQWRv?=
 =?utf-8?B?RnlRdnRYWXNqOE5BREQ2VjlZNHlEN29FU3ordmdWM3BKOC9tdWN0WTQwWDdq?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6BDA340C3E87249B17884119F5B46E8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36364531-43e8-4179-5c43-08dbf68a43cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 18:36:30.5918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zfdgdt0UmHQBKnwBjnMI2fXtI5QmXSKYWDNeLh3kgO4GI+vzKJPiyTOCIplmcFPjKj4k5NO7LBdND/ZgAOfYDw8RbQe9HE0g7UsSTwaP9gc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8686
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

T24gRnJpLCAyMDIzLTEwLTI3IGF0IDE0OjQ3IC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gT24gVERYIGl0IGlzIHBvc3NpYmxlIGZvciB0aGUgdW50cnVzdGVkIGhvc3QgdG8gY2F1c2UN
Cj4gc2V0X21lbW9yeV9lbmNyeXB0ZWQoKSBvciBzZXRfbWVtb3J5X2RlY3J5cHRlZCgpIHRvIGZh
aWwgc3VjaCB0aGF0IGFuDQo+IGVycm9yIGlzIHJldHVybmVkIGFuZCB0aGUgcmVzdWx0aW5nIG1l
bW9yeSBpcyBzaGFyZWQuIENhbGxlcnMgbmVlZCB0bw0KPiB0YWtlDQo+IGNhcmUgdG8gaGFuZGxl
IHRoZXNlIGVycm9ycyB0byBhdm9pZCByZXR1cm5pbmcgZGVjcnlwdGVkIChzaGFyZWQpDQo+IG1l
bW9yeSB0bw0KPiB0aGUgcGFnZSBhbGxvY2F0b3IsIHdoaWNoIGNvdWxkIGxlYWQgdG8gZnVuY3Rp
b25hbCBvciBzZWN1cml0eQ0KPiBpc3N1ZXMuDQo+IEluIHRlcm1zIG9mIHNlY3VyaXR5LCB0aGUg
cHJvYmxlbWF0aWMgY2FzZSBpcyBndWVzdCBQVEVzIG1hcHBpbmcgdGhlDQo+IHNoYXJlZCBhbGlh
cyBHRk5zLCBzaW5jZSB0aGUgVk1NIGhhcyBjb250cm9sIG9mIHRoZSBzaGFyZWQgbWFwcGluZyBp
bg0KPiB0aGUNCj4gRVBUL05QVC4NCj4gDQo+IFN1Y2ggY29udmVyc2lvbiBlcnJvcnMgbWF5IGhl
cmFsZCBmdXR1cmUgc3lzdGVtIGluc3RhYmlsaXR5LCBidXQgYXJlDQo+IHRlbXBvcmFyaWx5IHN1
cnZpdmFibGUgd2l0aCBwcm9wZXIgaGFuZGxpbmcgaW4gdGhlIGNhbGxlci4gVGhlIGtlcm5lbA0K
PiB0cmFkaXRpb25hbGx5IG1ha2VzIGV2ZXJ5IGVmZm9ydCB0byBrZWVwIHJ1bm5pbmcsIGJ1dCBp
dCBpcyBleHBlY3RlZA0KPiB0aGF0DQo+IHNvbWUgY29jbyBndWVzdHMgbWF5IHByZWZlciB0byBw
bGF5IGl0IHNhZmUgc2VjdXJpdHktd2lzZSwgYW5kIHBhbmljDQo+IGluDQo+IHRoaXMgY2FzZS4g
VG8gYWNjb21tb2RhdGUgYm90aCBjYXNlcywgd2FybiB3aGVuIHRoZSBhcmNoIGJyZWFrb3V0cw0K
PiBmb3INCj4gY29udmVydGluZyBtZW1vcnkgYXQgdGhlIFZNTSBsYXllciByZXR1cm4gYW4gZXJy
b3IgdG8gQ1BBLiBTZWN1cml0eQ0KPiBmb2N1c2VkDQo+IHVzZXJzIGNhbiByZWx5IG9uIHBhbmlj
X29uX3dhcm4gdG8gZGVmZW5kIGFnYWluc3QgYnVncyBpbiB0aGUNCj4gY2FsbGVycy4gU29tZQ0K
PiBWTU1zIGFyZSBub3Qga25vd24gdG8gYmVoYXZlIGluIHRoZSB0cm91Ymxlc29tZSB3YXksIHNv
IHVzZXJzIHRoYXQNCj4gd291bGQNCj4gbGlrZSB0byB0ZXJtaW5hdGUgb24gYW55IHVudXN1YWwg
YmVoYXZpb3IgYnkgdGhlIFZNTSBhcm91bmQgdGhpcyB3aWxsDQo+IGJlDQo+IGNvdmVyZWQgYXMg
d2VsbC4NCj4gDQo+IFNpbmNlIHRoZSBhcmNoIGJyZWFrb3V0cyBob3N0IHRoZSBsb2dpYyBmb3Ig
aGFuZGxpbmcgY29jbw0KPiBpbXBsZW1lbnRhdGlvbg0KPiBzcGVjaWZpYyBlcnJvcnMsIGFuIGVy
cm9yIHJldHVybmVkIGZyb20gdGhlbSBtZWFucyB0aGF0IHRoZQ0KPiBzZXRfbWVtb3J5KCkNCj4g
Y2FsbCBpcyBvdXQgb2Ygb3B0aW9ucyBmb3IgaGFuZGxpbmcgdGhlIGVycm9yIGludGVybmFsbHku
IE1ha2UgdGhpcw0KPiB0aGUNCj4gY29uZGl0aW9uIHRvIHdhcm4gYWJvdXQuDQo+IA0KPiBJdCBp
cyBwb3NzaWJsZSB0aGF0IHZlcnkgcmFyZWx5IHRoZXNlIGZ1bmN0aW9ucyBjb3VsZCBmYWlsIGR1
ZSB0bw0KPiBndWVzdA0KPiBtZW1vcnkgcHJlc3N1cmUgKGluIHRoZSBjYXNlIG9mIGZhaWxpbmcg
dG8gYWxsb2NhdGUgYSBodWdlIHBhZ2Ugd2hlbg0KPiBzcGxpdHRpbmcgYSBwYWdlIHRhYmxlKS4g
RG9uJ3Qgd2FybiBpbiB0aGlzIGNhc2UgYmVjYXVzZSBpdCBpcyBhIGxvdA0KPiBsZXNzDQo+IGxp
a2VseSB0byBpbmRpY2F0ZSBhbiBhdHRhY2sgYnkgdGhlIGhvc3QgYW5kIGl0IGlzIG5vdCBjbGVh
ciB3aGljaA0KPiBzZXRfbWVtb3J5KCkgY2FsbHMgc2hvdWxkIGdldCB0aGUgc2FtZSB0cmVhdG1l
bnQuIFRoYXQgY29ybmVyIHNob3VsZA0KPiBiZQ0KPiBhZGRyZXNzZWQgYnkgZnV0dXJlIHdvcmsg
dGhhdCBjb25zaWRlcnMgdGhlIG1vcmUgZ2VuZXJhbCBwcm9ibGVtIGFuZA0KPiBub3QNCj4ganVz
dCBwYXBlcnMgb3ZlciBhIHNpbmdsZSBzZXRfbWVtb3J5KCkgdmFyaWFudC4NCg0KeDg2IG1haW50
YWluZXJzLA0KDQpJZiB5b3UgZG9uJ3Qgd2FudCB0aGlzIHBhdGNoIHlldCBidXQgYXJlIG9rIHdp
dGggdGhlIGdlbmVyYWwgYXBwcm9hY2gsDQpjb3VsZCB5b3Ugc2hhcmU/IEkgZGlkbid0IHdhbnQg
dG8gc3RhcnQgZml4aW5nIHVwIHRoZSBjYWxsZXJzIHVudGlsDQp0aGlzIHdhcyBzZXR0bGVkLiBJ
ZiB5b3UgY2FuIHNoYXJlIHlvdSBhcmUgb2sgd2l0aCB0aGUgYXBwcm9hY2ggSSBjYW4NCnN0YXJ0
IGluIHRoZSBtZWFudGltZS4NCg0KVGhhbmtzLA0KDQpSaWNrDQo=
