Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D687892CC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 02:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjHZAxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 20:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjHZAwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 20:52:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4A52685
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 17:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693011159; x=1724547159;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ACAt85l69VDEgWn33uDTOXAiPmwcr7sXFugXbPngk/Y=;
  b=h0u9cAF03RiqHm7gCipkjjpWQRFtvn7v/h7+OBss255LGeHFvjEgUfLO
   n2DOeZARVCHAA1BfzlMM+IWb3Xg6Ty4Y5X4pJAY+GOFmIa7wQHHWEWrvO
   Q3cK7KvK4ZafcajpnSQ1mwhgve6GKRcanS8WCnDDMMk4+puHo2bWxCN08
   52ofVYVSTpejD/ovbZ7lw6HdyiKk/oKlTC+O2hmJsmIOMw8zYqcJNzuSX
   zK18qNjfbBmg2vS9a6ogtG1zXbfMQSjqP0Qmv1yS4WGCX4FF5zwXRNPHX
   JHfa6+BUYakRuBqFrB701pTEgyCImkFlsOvQpbvdrOSO/rkEnJhdjZROE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="405828647"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="405828647"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 17:52:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="852160659"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="852160659"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 25 Aug 2023 17:52:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 17:52:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 17:52:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 17:52:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXjrWbFRUmbmnjJPGtwRanj1EH8p6mKBreATQiW0LQO1HUq6LNHy14gTBt7Hh+x8S7PJKhzDdZf087MOPTuM8tZUszQu44IaECqp/GZGMW33lkMsEhwzqlMIg06iO1S8rmy//cuwEwQ401T74CvcG+frUYEL1nvcEuY6YXlyQd5Z+9qGO65d4MozJfziHqvIrwZhUUmv2XqQisgaeUo8AQZOZ+ogYuJdGTX3pCp3TgIYgf9DvOP6G5dl62J3iJZeKg5evsTjr0fmPG1mu56/1+Crd4lGH4qm3zaY3bQs7GYf3MEAF40Zjko3b/5ZzQRyOI1B3zw4AK+BD5vAP5IOSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACAt85l69VDEgWn33uDTOXAiPmwcr7sXFugXbPngk/Y=;
 b=R+UyiaQmRn9uQ27hyj2kO59aB3ucuo4stlPkkBVjeWo+rehlXu6MEXOGkXkuVkfBMOe4DAvplZrgFV+uEw4tkLRhk3h5WxvCnmSg0jNeiyxT0mxtXItIbw750KxMUzGkj+RIv9jMOQEgdnrGYwRqD4ZZHU4qaqDLXPmnUs/UWeCdmxThz5SpRdS/8VrjA9Zmowk/X6V0nlI2/0cmJSERahqmx0++DgwmnEwjUOZbbLoIq2WBqCAY8miefw3yhk/G82Qq2kGYWPZIO2Q6cBYDHzAvZ5Oc3+ShOVdiLFvDbHFvnFpegfoGhdDCPYp6wrShMq4jgQxXdqdfA5281K8jJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB8185.namprd11.prod.outlook.com (2603:10b6:610:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Sat, 26 Aug
 2023 00:52:30 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6699.028; Sat, 26 Aug 2023
 00:52:29 +0000
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
Subject: Re: [PATCH v4 06/12] x86/tdx: Extend TDX_MODULE_CALL to support more
 TDCALL/SEAMCALL leafs
Thread-Topic: [PATCH v4 06/12] x86/tdx: Extend TDX_MODULE_CALL to support more
 TDCALL/SEAMCALL leafs
Thread-Index: AQHZz2d8x/Vv+gCNkkuVI2azm8gi0a/7uzqAgAAVIAA=
Date:   Sat, 26 Aug 2023 00:52:29 +0000
Message-ID: <f52361c06aa553e292cf36587cfb2b39ae533850.camel@intel.com>
References: <cover.1692096753.git.kai.huang@intel.com>
         <d4785de7c392f7c5684407f6c24a73b92148ec49.1692096753.git.kai.huang@intel.com>
         <20230825233649.7afqlopjjmerym3d@box>
In-Reply-To: <20230825233649.7afqlopjjmerym3d@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH3PR11MB8185:EE_
x-ms-office365-filtering-correlation-id: 071230c1-9da2-4dbc-56c9-08dba5ceb94f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e013q6nDMkoeVhRlkZGq35G5Vc/MIB4EwQNmyhQTPbveUedNT1NiEpQj+4nQCuEr+W35lKkxtgUfUr7lACyOGAi/y7PDfbcAhHcNIVoJuC8iG/p2sEvTaC8ErebAAD+K/NkRdArA/H3NybqbdqjbGR8Pmlgvfu2SvCQWOCpeL5vfwe2t2n+UkD3jBsJr9fSoDbY64BUwT4zNjOwDwaWoXMRpBoZM0XCgbCdKMNFDcpMFYFHuDhxt/AQZI4Uqja65AsOIG3IjTlgThRUd08I1bAdHNlYD3nwKsDr2t+JzZduUIhaIkXlqNrL80SWbFZXhO5mzIaRNAw2jgaJgdZ9/yRhC77J9WzOteZqoibPeGhgKRQbDzFmE5wU7746Qz/oc/DVy4+tDOy9WRHDHDx0kDzFJDRY7KBXSXnWZk6C2mTSxrpYU+I1Qb3KukfVfdAGk9VF6TuLUiFMYdLRPvn4QspO3LMl1YewlWWDeiNw7cMeqwsKz5ZoVvy8VNaNfIECemhPSgj+y8KN332QGFbHLIK48zqmPQgg/mxIi3rgk7XqOgtTl5pCDA0ggQPOzax7g8R/AU4KNneBst0h5lkVD5z9sxudby+s4oN2eEblUFyF/y/85n03N8ARtrrhQMY5s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(376002)(39860400002)(1800799009)(451199024)(186009)(6512007)(7416002)(26005)(478600001)(2616005)(5660300002)(2906002)(8676002)(8936002)(4326008)(122000001)(82960400001)(38070700005)(38100700002)(66556008)(76116006)(66476007)(66946007)(86362001)(71200400001)(41300700001)(6916009)(54906003)(64756008)(6506007)(558084003)(6486002)(66446008)(36756003)(91956017)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cll0bTJxNG1Td3JjcjkrZnN4SWFjc2N5blV5V3NBV3BvaUJ0T2YwWUlkOUdu?=
 =?utf-8?B?WXczUEFnMVlmdi9nZUtOUlQ4bnRNV2w3bnZXamJXOEtkc3BVM2p6WEpiMzVu?=
 =?utf-8?B?NWFncEVmai9FdWx6eU95eXlza2ZjUDBxRFFlU3FhalVBdGlCU042eDRJRkpQ?=
 =?utf-8?B?YlVTb1V1eVZweEF1ZTdHajAvNGRsa2tuV0M2TTNnUU80b1gzdSs5WUhBNnhT?=
 =?utf-8?B?MTJjWnQyNDlIRnl5d0hwdmhEVm1teG9jVjd6UGkrSmFpaTNPazRHZVpWWkV1?=
 =?utf-8?B?RFF5K0x6TUNNdTlyNlFvb2RML1A0TXJHOHAvWUhTbU1BNmpQeTlpU1lTT3E2?=
 =?utf-8?B?VWROSVRSbDFkS2RkM1JCcGJYeENCNStuOFh1VkpIUC9TbThjNkxDNGl6Wmdu?=
 =?utf-8?B?algzbE9veFMybmVZN2ZjWVNPMCtrV0ttVXBTY09CQ1FMSjRveUtwc1VnV3RS?=
 =?utf-8?B?U1BVUjdWd2lJdXpRSDBtVCtKOW9NRUszS1U3elptNU10VjZSbEF2ZTVzcU0x?=
 =?utf-8?B?NEpydW1LczJhZndLeUVEOGdrNGUzZjRMWUxaSVN6ZmNMakp2R2djeUNZOWta?=
 =?utf-8?B?TlovVjZ2aEdLK25uWXFXcWNhSXNyb0ZLdGVYbHJlS1F6SEk4em5pY0I0cWp3?=
 =?utf-8?B?K1BPNlhIRDJ0TUdLZUV2ZXFLRDVMa3FPczN1TGI5czMyY2ZyY3k4WXF0WXh5?=
 =?utf-8?B?aVROWnNmRXEzSmttTjZlTnJMUnh5aVVIdCttc29KbkZiQzloODhqSDgyNkNo?=
 =?utf-8?B?dWhjTTRwcUIvaEx0bUZmWGNQdklNVVRIWWNWN1dPWWN4NWo2YkxLS2ZzdjEv?=
 =?utf-8?B?emJDa0NWRDNud0RmZlMrb1lHd3dsOTNqODd2VmlGWmxYM09URU9DSGZXaVNr?=
 =?utf-8?B?aFdUQ2MzdTIrUm1nRDBOZW9UcFlORlVUNlhldTZSdDdRMW9QVGt5NUpWcHVl?=
 =?utf-8?B?bkYzTUwvTWtjNEhDWnZ5WUlEaERQVFdNRGl6aFF0QlJTYWJvMkJoSW04MjFx?=
 =?utf-8?B?RnVOUXprdGFReWxRK3lTVmdUUitvcW1KUFZ0MnVmTTlkcUFOWVVVamNGR1dP?=
 =?utf-8?B?ck9FMUxWSjdaK1BGbCtqY0VTbjdLalBhQjJ2ZUhiYjRLQ1plTVN6akRLeUth?=
 =?utf-8?B?YkM4Q2RucEpYb1J5MjRzeTVmUVg1V3BkMDdOaEYxNzZtQURqYjJGOWdUOW1E?=
 =?utf-8?B?NjZ6SWJVN1ZmVUczUnArOU1OMFV4RGdQTFE0d01YZE1wYXNDSStjKzZFZXkv?=
 =?utf-8?B?dTFOZGU0NVpoeVhtMkhBa2owcjhOVDVNK2J3Z0UrSkg4blRyZENWQ3p4WDFM?=
 =?utf-8?B?OHluQ0JaRStBRzd2N0N0UHZKYzVxbUtwWHdhWUIrVWg3QVMxSVlsRDJIMDRw?=
 =?utf-8?B?MHlwU2JpNGY5NTZTOFIrNWR0amFKRkZjZkY5SGxWQkRaWVQ4anl1Q0N2R1Zv?=
 =?utf-8?B?ME1kbmdDRUxkbytXNnhqek9IOFBHN3ZNcVJSZ3hZWFV5TkUxZmpRbXRESmFB?=
 =?utf-8?B?Z2QvcjNYZitaUXR3RGpYYktFb2JsOHhUYWJ4bk4zN2ltR3owNmpTcUEzMk50?=
 =?utf-8?B?ZmhjdUVDUHJnZGlKVVl2Skp1QkovRXp4SGV1c0tXTjVwYm9Fb3F1YWpndW9t?=
 =?utf-8?B?UnFqUWJjbG1wUHJOdGVVRkU4QXdqTWlIa09xMGVsdVpEc3pLVE1HZjBwYUxw?=
 =?utf-8?B?bjVFV2g3M0p3bzYzak9KUFNaZWxZUlFCWkVQWC9yd1JCRjVtMklRbzNUVG9W?=
 =?utf-8?B?TWRUR1VpaVZYL2E4ODBZdGd3dndTTGFqQ0VZUW9jajZjRWgyQWEwaHFGVEFi?=
 =?utf-8?B?WGFaaDRXbTFOV0ZnQVJMdjloWERQTFhzblZrOFI4U1h3ZS9NSG5JTytPTzJT?=
 =?utf-8?B?b3NOSGtkRWw3TE0rL2tUcFVjS2RkbjBuRGJZYkd1RXBQRUtMUEw4T2k0aFRX?=
 =?utf-8?B?d1ZKOGc3TmhIemxRZitZQU9tK2thekg2eURBTVoySUg4L1Y5b0FNcU5JTFly?=
 =?utf-8?B?Z0JWVldxK29jZU9uRkdNbEpMMjJCMVpEVUsyZHJBeWVhSzE3eHpVNG11eUNW?=
 =?utf-8?B?K2dXcUNFckE2RVhaVXovelpzTVFjU0wzQVNsY0VPWWhWOXRkdUZzZnMwWFRv?=
 =?utf-8?Q?Sow6mml+diMnWQ5ub2ceM2GIk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <724C2B012DE57B4580E95118C56D201A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071230c1-9da2-4dbc-56c9-08dba5ceb94f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2023 00:52:29.3366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Um1tDmrVlxPtfYs53tSq6JdyJoVZRlTKvh9zC9/7wfmY/5S5919zn3IUkmVlmpLJV7cgSCGKrJXUNi9GlT3cEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8185
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTA4LTI2IGF0IDAyOjM2ICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBUdWUsIEF1ZyAxNSwgMjAyMyBhdCAxMTowMjowMFBNICsx
MjAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+ID4gQ2M6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxs
LnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogS2lyaWxsIEEuIFNo
dXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiANCj4gQ2Mgb24gbWUg
aXMgcmVkdW5kYW50Lg0KPiANCg0KV2lsbCBkcm9wIGlmIHY1IGlzIG5lZWRlZCA6LSkNCg==
