Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723087589F8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 02:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjGSAOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 20:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGSAOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 20:14:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BE2B3;
        Tue, 18 Jul 2023 17:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689725681; x=1721261681;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ftiAJag0QMzWVO3TrLOvhCS05y3YFSfnBNLgX9oyce4=;
  b=FmEVPJDMjRiYOMu4Lt+G+/h9CLV6gWotUDZgASy0s8fGERJ/3/wKuolX
   Ux9DFbuBVnm8sfIhniXM2cNAW2e8fbFydfZF7roUMVMA2afilvIoG2Aqf
   vV2xvxSelt2D4G3aZNeRFrIVQrfxvHugBjvkHnhjxLQm5t3s3Ns7EP6dW
   Tgu7kHrlHQYz9cFTn7LtZnbTy9KdMSyrHX1N07atnTgjJr7vg0Oy7aoWT
   s15+QqvctjfATVTk43EbNskv3zSy1Liip0ZPLYw/w7Ty8WacdS6cA3ulM
   o76bNNryw0MpsNJWQacLNMSlKrTmvJITkLObeZd3gDGuKqjpwkhSOmuMi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="368986495"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="368986495"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 17:14:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="758965678"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="758965678"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 18 Jul 2023 17:14:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 17:14:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 17:14:39 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 17:14:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bs/A6UC3gbo068l709qsOqiTLLVKMDGFsmL2xIppY3J8S1sRCbYP7lZojaA4QHSyOiv+7YEq0yVKABsM3qaZAkQCr9neXXVe1KB2E61tOIKokdlz/DDjoOo7bJugrLj+GTEuc8p4B6tidcoo7SxU8+8IAq40uWtybl6nOgcZ0dqtqYkwOHv68RI3kMXHk8npYzl/aJtOY1kxUTUTrxpZ0nXqSqMgUDDd2DdL1xbRHMA7qWYyi1HQRp6jIWxSkioEPHZEAaSG47sgJt+C5Y53yL2TQSWbyKdyVfunufazvKSLKk0Yc147/9wEqdsf+LRPBvEyPPqUSv54CkXBZeIM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftiAJag0QMzWVO3TrLOvhCS05y3YFSfnBNLgX9oyce4=;
 b=AkZtS11CiPmtjRYRERaDZvm1Z4Lkh+bgmoBXBvDgZAwgIg3xY0i6V9VK3sJ26z18lkMplMdAgaM63Rv4raLL39Dni8/tlZwSsyqYWVraY18Yl/OyKmP6b3ufafg8D3UNfcpNlG/t/LABjZPbyEFd72xl8YqtjbFreJAyCIyq16zJlQGzuFvUWQ9DyZ4uoqfM6HB2ZRnKZlIhX4CXwaVPymy8hDw9z1FluaCnwJlFgXbUZ0CMo5k5rGJcClDLLRQaQMsT0Gtc9gVcwLolmJIVqFLTkXmYca/12w/n0V5oCY+XDvXfKSipUaOjl788RS71Hg8qcm2e0YdyoppTBMY4WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB8228.namprd11.prod.outlook.com (2603:10b6:8:180::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 00:14:36 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8%3]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 00:14:36 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
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
Thread-Index: AQHZuNr+gc+uEEAR2keHYngpqSvf+a++Tj+AgAAAPwCAABqcAIABLT6AgAA+hgCAAAvJgIAAG3mAgAAGzYCAAAdZgIAAA/OAgAAFqACAACZlgA==
Date:   Wed, 19 Jul 2023 00:14:36 +0000
Message-ID: <520111c9ccdd7356f9eaf20013e3e3c75b06398e.camel@intel.com>
References: <CU4OBQ8MQ2LK.2GRBPLQGVTZ3@seitikki>
         <20230717202938.94989-1-haitao.huang@linux.intel.com>
         <dfb1f233-aebd-50cf-8704-e83b91ee110a@intel.com>
         <op.18ah5mn3wjvjmi@hhuan26-mobl.amr.corp.intel.com>
         <b5779418-e2a4-ca7a-866f-97e49cd272cb@intel.com>
         <op.18aontlmwjvjmi@hhuan26-mobl.amr.corp.intel.com>
         <eb1aea6f-3688-f871-2335-ff911a51ef52@intel.com>
         <op.18aqz7sbwjvjmi@hhuan26-mobl.amr.corp.intel.com>
         <ad2d9610-61c0-4719-9df1-0116ef317d8a@intel.com>
         <op.18asliuzwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.18asliuzwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB8228:EE_
x-ms-office365-filtering-correlation-id: d75fc683-3140-42f4-04e2-08db87ed22b5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LLo8TZTx/qvihb0qz9UiGEPd6hYmfn6Aamd0Qyd/+aGtqg4Uzwb2tXPcIrSZOT8CFfp2oQkHfsPF5rTdr3RsZJnfNJXAlJtFmeFqMIhiaZg45BEakW3+LG4IXPCHIH5qTMmYKzUZRul/suEqPQzRTprWctZ7hXJvCcb/+LBQOYTlUdKtlpL4BwaGnbFIySGQFIgl+/Uoixrj+ZJ4jgUyVgSc1f2FSTp9G/tszmXMGyIJDU5VTlyOivlO6YHUol9u9M6Jlr8B7cWOrpUsGKYldzM93r6bhh6KcegCirgsmjlYybYSO3vX8CrTtXAzGmm0PQdEP5Q3SJKiuskWAH9Lx7ZAieSEvCyVM0uAb06s/cNChGTtj+udAiruTXuoP+jX9uU4fVs4ow75U63Pq+ruTg10CuUVan2/oYfc7E0PnPkY5L/zqHwn+rtEXF2Ye1KIDBJv8DAcOmiu4sElRlC5RNDGGwDqBzNX0UFplGgthZ+YchAXto8ekk6kISHMV3YH9L6M+G4aByxI9/9p3S6cWxZ4aNfip+Ld64okgQwqrGP7Zcq1zE2IG9dfRLtlEJjPUG2KDHEx4l4pWpvyRT1kVYb+Q46EArgUpjaEfq+Y2vJ92TVmNWo8x6EmC4mkQPu4AJGxCEJf3EiAj7EMKY+P/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(2906002)(71200400001)(478600001)(6486002)(110136005)(66476007)(8936002)(8676002)(7416002)(36756003)(66556008)(54906003)(41300700001)(4326008)(91956017)(66946007)(316002)(66446008)(76116006)(64756008)(82960400001)(83380400001)(86362001)(921005)(122000001)(6512007)(53546011)(5660300002)(2616005)(26005)(186003)(38070700005)(38100700002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHlZQ0ZXaW9iUllqeUdLenVrWndISk5mYUFGUVQvcDFWZmhIZzU5YklnMDJK?=
 =?utf-8?B?QU5WMVdiVmgrMUVkYk5RV2tIeVNQZmhDS2J4TDdRZHA0eGhocXB5SE0vOWZj?=
 =?utf-8?B?S3FTeHlRc2VQTm5rbHhDaWJrK25zWlR2aS82aGp3ZEVEc3F0YVh3N2VvN0xI?=
 =?utf-8?B?YnVLU09rQTk1bGFhYTkyN0JBMWRQejVCMzh6SWxzYW5WNnd0cEhDNldtTXJo?=
 =?utf-8?B?Qy93cHcvOXl2KzZTRXlVYkdrTmVWWmZuK1psbC9xMG8zVFBqc09FaWYvcnk2?=
 =?utf-8?B?eVdTd3lmQ3FnOUFSY0pNenJ4ZTlxZlZWM01vRDJpak15cGo2emo1eC92VVFQ?=
 =?utf-8?B?eWJjc29tbno0aUFFQW9Jd2tZUnpmQU1OQ3JzTlZVYzRDSW8yQURnRGxENXZu?=
 =?utf-8?B?WGdjVmhXckxZOEoyZFdWKzR4M0xBZUs2YVBPWCtXVy9HMUJ0Q0ZLQXNYb2Jj?=
 =?utf-8?B?U0syRnRlTCs4Rm4wbmtxWFpDV2lIbmFOYmFtdER0NVdkeEJHR2ZGQkRib3lQ?=
 =?utf-8?B?S2EzZHJVMUR1MG8xTEgvbjJObk9ObG4rTTJzeTJ2TmkxaHF1ZG5jK1N6NHBw?=
 =?utf-8?B?a3NTVHpnQVBJK0l2RDNaVzdSSzZJektITUkydGZmV1VEcm5TRmVJSExKYnpF?=
 =?utf-8?B?SzgydWF2M1EzSGZPNlBnek56a3Iwb2xwMHZTWFkrR1ZiREtST1ZqNFBnUllQ?=
 =?utf-8?B?RHk2TC81amRJYW1YNnllWVJvYmpLTUJrNnpzWXJRVXA4T25HSWFSVmFqVlpF?=
 =?utf-8?B?c21lZnVSaWN1QUVMQkhHWHRXMnNLT0IwcjQwbURadWM3Zmp5a0VMMUZmaGxz?=
 =?utf-8?B?cTFqUWNZRUIyQnc0L0p0T3h6dEo4ZlFaQVRpQnJTQ1lOSXBIdEswQXFTbWdO?=
 =?utf-8?B?T1RJQWd1aXZ1SG4wSnpGakxqVTZsT1BEVHgyaXp6Y2MrY3RnTHN6SnU0RXlo?=
 =?utf-8?B?VTZLQ1MwZDg0aVJlSEt0a09zQXQrZ01ldm02eG5tT1V3K2pKRS9PVjNpZVdQ?=
 =?utf-8?B?SWlFMkxoNmJRYWdxalRvTm4xOVgzS00zN1lod0oxZTA0SU9Sb1lLL2Q1ek9a?=
 =?utf-8?B?QW9NOFF6cFo2bUY4b1ozamVqT2d1bnBjUTVXWTRRNDVnbnhZTFpXUXBtYmxB?=
 =?utf-8?B?eWd5Ti9SUjhtOEZoS2toakFtZzBjODRXTEZzMkpvMzZJWmRKZUl1NnZMa0Rr?=
 =?utf-8?B?MFRMV0lOaGpsUWlTaSszNjZ3MWR6R0QwSERJMytZRXVOLzZkQjNmYmdmTnlO?=
 =?utf-8?B?eCt5TlkwZWtMTktlaFE1MnhUb2Y1MERXTHUrZkFLSHQzQ2Fkem5kSEhLR1lR?=
 =?utf-8?B?Mm1JWGx2MytiUW1TQkVQa2dWUGhKWlhSa2VMT3NwbDd3WGFiZTltMm4xeFZ1?=
 =?utf-8?B?TmNJcEprMFhYZkUwY3duMlAzY2NmOG81eTNsUVZ3OUM4M1EveWUzenNoTTMr?=
 =?utf-8?B?MUNlOXVkR0FaenY1ZHJ3bmxhaWVTZUU1cnVDb3VoTFpKK0NweUtscXlXVkF2?=
 =?utf-8?B?bytwb2E5cERYN0pEaThUMWQ2YVZXM082dzFsa3cvanBpbHNKWnBkaTVyRUVu?=
 =?utf-8?B?WTNESzZqeDBnUkhpd0dqTGtuQXphQWJpeDRvTjJTMzVpa2Z1blBMbVlIVEtE?=
 =?utf-8?B?a1UxZFp0OGdRRXNHZTBpdEFlcjlxM0orV0o3cmQ1MTNHWUNoa1BiK091OUJq?=
 =?utf-8?B?L3FpS1I4Q3pncFRhWm52QzVGT2w5ellsdHg1TEltb3JWd3h3TGdydmlQMEpB?=
 =?utf-8?B?RjJCdEtKNFNLc20xenN0SmtJcm9PaEZMcnZaR0Zaanl0czA0YXBRNUl6TVgw?=
 =?utf-8?B?UG1hY1pETGtyWXl2Z1pPNk9VT2ZwaG8wTUV2VSthbU9WUmxCakcxREgrQy9k?=
 =?utf-8?B?WTc5RW14S082bVZqUkt3U1doLzY1NUVKNkpTOWdMWEhCb2FiZVNJNDdJU0NU?=
 =?utf-8?B?MGJwbklHdzBvc21mOWZlZW13b2NYNGlCVnZGaDIxSC95bEp1S2JhYXNJYXF6?=
 =?utf-8?B?YTZ1ekNsazkwTVNkQy8vbXN2TjJ0bkFSNVAwLzI2N0YzeUQzNTN3bXZuVmpS?=
 =?utf-8?B?OEt5MUppV1ZzaWxPb3pCU3BuakllZ3ZKTnJwRzU4K3FqK1V6SGo5a3haajdJ?=
 =?utf-8?Q?OxrGXH8ZZKbwJM6sLytIQd/To?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E0BC52BCB04234D9F75A591FD3AEE75@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75fc683-3140-42f4-04e2-08db87ed22b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 00:14:36.2169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 87dWKgolPnzMziSkwZZ2WYaVkb6cmhLHI4KOvtTlsEv7qwxj+UJz84LLstlMdUoTJnAGS272fzfzn0N0eZYW9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8228
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA3LTE4IGF0IDE2OjU3IC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IE9uIFR1ZSwgMTggSnVsIDIwMjMgMTY6MzY6NTMgLTA1MDAsIERhdmUgSGFuc2VuIDxkYXZlLmhh
bnNlbkBpbnRlbC5jb20+ICANCj4gd3JvdGU6DQo+IA0KPiA+IE9uIDcvMTgvMjMgMTQ6MjIsIEhh
aXRhbyBIdWFuZyB3cm90ZToNCj4gPiA+IEkgYWdyZWUgdGhpcyBpcyB0aGUgcmFjZS4gQnV0IGZv
ciB0aGlzIHRvIGhhcHBlbiwgdGhhdCBpcyBhdCAjMSB5b3UgaGF2ZQ0KPiA+ID4gb25seSBvbmUg
bm9uLVNFQ1MgcGFnZSBsZWZ0IHNvICMzIGNhbiBoYXBwZW4uIFRoYXQgbWVhbnMgaXQgaXMgYWxy
ZWFkeQ0KPiA+ID4gaGlnaCBwcmVzc3VyZQ0KPiA+IA0KPiA+IEkgdGhpbmsgb3VyIGRlZmluaXRp
b25zIG9mIG1lbW9yeSBwcmVzc3VyZSBkaWZmZXIuDQo+ID4gDQo+ID4gUHJlc3N1cmUgaXMgcmFp
c2VkIGJ5IGFsbG9jYXRpb25zIGFuZCBkcm9wcGVkIGJ5IHJlY2xhaW0uICBUaGlzDQo+ID4gcmFp
c2UtPmRyb3AgY3ljbGUgaXMgKG9yIHNob3VsZCBiZSkgdGltZS1saW1pdGVkIGFuZCBjYW4ndCB0
YWtlIGZvcmV2ZXIuDQo+ID4gIFRoZSByZWNsYWltIGVpdGhlciB3b3JrcyBpbiBhIHNob3J0IHBl
cmlvZCBvZiB0aW1lIG9yIHNvbWV0aGluZyBkaWVzLg0KPiA+IElmIGFsbG9jYXRpb25zIGFyZSB0
cmFuc2llbnQsIHByZXNzdXJlIGlzIHRyYW5zaWVudC4NCj4gPiANCj4gPiBMZXQncyBzYXkgYSBw
cmVzc3VyZSBibGlwIChhIG9uZS10aW1lIGV2ZW50KSBjb21lcyBhbG9uZyBhbmQgcGFnZXMgb3V0
DQo+ID4gdGhhdCBzZWNvbmQtdG8tbGFzdCBwYWdlLiAgVGhhdCdzIHByZXR0eSBsb3cgcHJlc3N1
cmUuICBZZWFycyBwYXNzLiAgVGhlDQo+ID4gZW5jbGF2ZSBuZXZlciBnZXRzIHJ1bi4gIE5vdGhp
bmcgcGFnZXMgdGhlIHNlY29uZC10by1sYXN0IHBhZ2UgYmFjayBpbi4NCj4gPiBBIHNlY29uZCBw
cmVzc3VyZSBibGlwIGNvbWVzIGFsb25nLiAgVGhlIFNFQ1MgcGFnZSBnZXRzIHBhZ2VkIG91dC4N
Cj4gPiANCj4gPiBUaGF0J3MgdHdvIHByZXNzdXJlIGJsaXBzIGluLCBzYXkgMTAgeWVhcnMuICBJ
cyB0aGF0ICJoaWdoIHByZXNzdXJlIj8NCj4gDQo+IE9rYXksIHRoYXQgZXhwbGFpbnMuIEkgd291
bGQgY29uc2lkZXIgaXQgc3RpbGwgdHJpZ2dlcmVkIGJ5IGhpZ2ggcHJlc3N1cmUgIA0KPiBibGlw
cyA6LSkNCj4gDQo+IEJ1dCBJIGFncmVlIHdlIGNhbiBkcm9wIHRoZSBtZW50aW9uaW5nIG9mIHBy
ZXNzdXJlIGFsdG9nZXRoZXIgYW5kIGp1c3QgIA0KPiBzdGF0ZSB0aGUgcmFjZSBzbyBubyBjb25m
dXNpb25zLg0KDQpBbHNvIHBlcmhhcHMgdGhlIHBhdGNoIHRpdGxlIGlzIHRvbyB2YWd1ZS4gIEFk
ZGluZyBtb3JlIGluZm9ybWF0aW9uIGRvZXNuJ3QgaHVydA0KSSB0aGluaywgZS5nLiwgbWVudGlv
bmluZyBpdCBpcyBhIGZpeCBmb3IgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGluIHRoZSBFQVVH
DQpmbG93Lg0K
