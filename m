Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA06772460
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjHGMls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjHGMlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:41:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FA419B4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691412087; x=1722948087;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WI8xUYxX7Un/i1bxMLscDMP4BYag17mJ6LZBePXN1xk=;
  b=Ur6jmWbF48BpWovYjdwoWbvNlucq2riSNuAGi5YiGDxjBzTReTHYYsCE
   p9ShP6S54VOc1VBvXd1v+ukxK6Bybe59gEStRYTJBPyxAfn31XLJPmyCO
   SftEhoQMlOyarizXeIVOATWKcgw38w0q8VG7NwSCnvxeNRJe5MQQYqE8I
   cp7pbr+XCrgj+CkEkqK3p0WVQyOCBF+KdIoDyS0A/jyR0Z7GWITpTSooN
   5wqlh19h53hd2jsre77wXZu7Z/YD/EJ4ulxhR5K31oOIipLbE4tBe5xmN
   EiRtRlHXskqTqaJ50gAHL27y2pBV5yOv88BOUsOTZPD/f4YEu2ksJKHf6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="367991689"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="367991689"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 05:41:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="854652401"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="854652401"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 07 Aug 2023 05:41:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 05:41:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 05:41:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 7 Aug 2023 05:41:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 7 Aug 2023 05:41:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIMBaidkoSsowlbfmFBnJLNzaSl/OIMX7qoOoibwsg4MrfR2rZuV01EZDIm9z0alTXb1cVlMYHIRhk4fTj3QEOwYHeL3xJyOi6gx9GNQIeBJ76PFZs3bgmULw35lDREUOTVpqnrXYrZ8SYVqBNuOjWa0i+wQaiEML8ValnVzcmgJ9v97O5Nzl64StkDkGFTiYh0JYrqYz/SV8Tt9rM/NXqUS3jz8t/+Lv0KQagchWRau6oicwtabES3HWIRl8lFIoZg0gVMvW29Qo6wctQbmdUPLbJDMg+sErgLZyN5tjk6oifxMtMEOPcMNuxX+SeZ5twLebfjkS6sfkylG6goJ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WI8xUYxX7Un/i1bxMLscDMP4BYag17mJ6LZBePXN1xk=;
 b=ZUQe7aZnSD9T4FgP/NXs0NpF0jVXPWp+PD78TupbnyLoay7r45DGQw2ZkdYfez7rH3+pn4y/QaMwUPLi+mCjWkz204xUR53Sb8HeLEl2FcFdxYwe7MMGB2wn9NkW8NBoGqO7WTuSZYhDd3vPwR6p053kuKa0LrhFcWOeO/TYxnw06r1BunR33na3fv48Zv+beV64k3EeHMWHtPpGwg6uwN9J1E6zusZUzxDlyl7ekDr+B5c4k0zjLGHBNqhlUsPaLDOGhI2A2QAvfw/nKUtn8Yh3EWVtPw8/5jnAGUnP6dYGo1OPYAXXfzlWE26zPJeNP1pcdthxs9EMlycYE6Jetg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB5641.namprd11.prod.outlook.com (2603:10b6:510:d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 12:41:14 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 12:41:13 +0000
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
Subject: Re: [PATCH v3 11/12] x86/virt/tdx: Allow SEAMCALL to handle #UD and
 #GP
Thread-Topic: [PATCH v3 11/12] x86/virt/tdx: Allow SEAMCALL to handle #UD and
 #GP
Thread-Index: AQHZv7EtIX/ZgmaCwUyXvrRdv67KjK/dNoCAgADz7gCAAIAegIAALvWA
Date:   Mon, 7 Aug 2023 12:41:13 +0000
Message-ID: <c4b1ab39b8e6e03e40ca390a41c96d096325428f.camel@intel.com>
References: <cover.1690369495.git.kai.huang@intel.com>
         <659b10910c206cb4a8de314fcf7cd58814279aa6.1690369495.git.kai.huang@intel.com>
         <20230806114131.2ilofgmxhdaa2u6b@box.shutemov.name>
         <b15b45ff5dc2fcfa08dfb3171c269d9ab0349088.camel@intel.com>
         <20230807095307.l7khgiu5y55pqq22@box.shutemov.name>
In-Reply-To: <20230807095307.l7khgiu5y55pqq22@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH0PR11MB5641:EE_
x-ms-office365-filtering-correlation-id: f5569825-ad5f-4b14-c2e3-08db974395f9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6e+3Ih7huisvuCSj4Xa82bxSXVbJ8BqLhIIprh/NoqN3EyACWt4QnBLPcQ/dCnc4MU4oKXlvZzCyaUEvIRRK4PgXhcLdrbKkcLw80jZA6ZMCfRL0BPiIBVNZ+83E71bxHuFVkmJwPv9kb498WIvLgf8ocr9PsL3nUyclorccujsOlRGu8Ba/V6tL5LV9kWBFBfisuNvA11qA3rBS17yTh8GDd8t1epXyWceZ+9N+zvq+8crUmyQosMB70w1zKMwOVdJUn+nWH/OgnV66uyULgaicnucwdQwYVa9udlQuEO4GbcVaHTpG+Lxbm1bs35bL/N7R1CDryEtJrfEjw0ngsdlfyuNm70v5iUG9H/6z5tJQ5RGhPvBeVlKqjey3YAbhwnzGRA5YJbjt4MPZxCFmnh+Yb4KW1JwS43TZUKlDKVOIsJcwQnneJUPOSdODmJVBpJeSVi7WxJmu6FPM6pHq9ZEXNnHBVMzrmyIEKuib+JsxybvLoPBhuAWohVrDHuRWjtiTCId2+v5nAMptn42gw9IryWqiSCw1hFGj4Yyknus9LsVgCJ2CZJOIsIJ1jW5H9HzakLHi7SfCqRZVVBsyxdO0WOCeccoQkKYEkS/CPZ3vObjY+fhpHouh3mL9NwLO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(376002)(136003)(39860400002)(1800799003)(186006)(451199021)(2616005)(54906003)(2906002)(6916009)(4326008)(8936002)(316002)(5660300002)(38070700005)(8676002)(7416002)(76116006)(66946007)(64756008)(66446008)(91956017)(66476007)(66556008)(38100700002)(86362001)(478600001)(6512007)(82960400001)(122000001)(71200400001)(6486002)(41300700001)(36756003)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3VTcWNoMS80SjJTMitsaFdxRTZkakE0anN1M0VGOWxVNVZHZUtzc3BHUkgv?=
 =?utf-8?B?ZjByWThBdWZCekMvQzArOUtDeVpwMXZ0ZHhQdkpnUTBkRmoxenhBL3BJYXUr?=
 =?utf-8?B?YnFISVNJSWl4TzZOY1RuS3JGcHNKTVphdlp0ZDl2TGNLRlR3cmJmMU1YMnV6?=
 =?utf-8?B?ai9KTWcvT3lTa3NQMGVnZkpOZmJpK252dmdPdHp4cHp6dWpFTUNsR0pRVFhT?=
 =?utf-8?B?SVd4c0hpUzQ0L2FBS2cxNlNHVzhjdlJ4NEFqbDVWUytTT1lmTGF0UlNpdzl1?=
 =?utf-8?B?REcxRHpLbEZMUjZKbHNsMFRZSTBtUlpITytHRDVIdkc3UkxvMmR5RW5GaDc3?=
 =?utf-8?B?SDVpbGdvdkExSE1sS3hDUVgrZ205a3drVXZPQnpxc2JnUkJFMU5LZFg2cHVB?=
 =?utf-8?B?dmxKaDhMbzVmS1pLOHc4SWtaWkRod1BteGNKbnFDbGMzajk2RUJKcUFBUzVI?=
 =?utf-8?B?NlJUNUlDZlBkL1h1MWliRzhldXV0MW81RzgrZTFybDlRWmw1NWh3N2pqSFhC?=
 =?utf-8?B?czFLOEh3SEQzZkJKb0NnaExqSFJjL2tzc25QZnh1TnN3ZW1DSmZwVXA4QUpk?=
 =?utf-8?B?cjROZlJNQkRBSEZHVnNoM3BLV0VhNCtqMXpwMzFBTnZYTnZrSEFvMDBHdTZB?=
 =?utf-8?B?LzJaQnFvYjYrOFlWaDR2dXVXR2pYb3Y3M2hHUkozK01CNDJUUkRHaEh1Q1lN?=
 =?utf-8?B?bUJxNEFtbmpqZU1ENEdpQmtITEV5dEFmMHY4NmtDbW8rVGRxN3dOTWpzeDdu?=
 =?utf-8?B?eU1OL1QxUXJNRDFWNzlBSGl1WExlbkg3dEYxSVEzeGo1S0J3aElRMEQwOTFD?=
 =?utf-8?B?YmQ5K0daR00vODFjRUszZUNtTXB6L0x6bi9DSzl5RS8xYUU0bWowNE9Ec3Jr?=
 =?utf-8?B?R2dVdnNNTFdqZWs4K1JPVFJ3MHhsb0x5Z2VKU3VlWllMeXozN0Y1dzcyVyta?=
 =?utf-8?B?SjZpTUhuY0hYeTZMQjRDeUNyYUVsMHFxYytkWWxnditvTXRhdlVpSmRvdTFM?=
 =?utf-8?B?V1l2SnRrbkFETTc5R0c0MjZUT2NTaHNPZ2pESjE0aW5YeFlZNmx4Q1Y3L0pt?=
 =?utf-8?B?ZGZkMjExbCttQVRSNzluWHV0OE1IdjhzMlpzT3ZGcGcxbDlQZDhpQm50TUNx?=
 =?utf-8?B?ZitOc0o5dC9jMDIrRDhHa0t3REovbkRNUVhUNkxLaW1ubzJMbWUzY1l0QUFS?=
 =?utf-8?B?NFdPZWl6azBsUE1xeVVsSzlKWHRhWW14NEc4YklCeEpvMFl5OXc0RURMMjFj?=
 =?utf-8?B?dFRyY2pVSVRheEhpN2JpMjRIMVRQOWFiREZBSFpwdXFqMktTMXNZaVkxbCtF?=
 =?utf-8?B?UTNVRHh3SWRTVFRrV0RTWG9vYWFUa2lhb3B6VkwyTUxtd3R3SWFBUlNkQkpW?=
 =?utf-8?B?ZzJ1WUZqY0tWTGpYcHBEbFlLT2c0VS91Sm14T2R6Uy9mRS9vc3hlcm9xYndP?=
 =?utf-8?B?ajBmOTRKdGhIOHZtak9jRkh2YXpjMzZMYWhlU0RWVG5FOHZxZ0lLQURTUVlF?=
 =?utf-8?B?b2tkelFhaXFQUmNGNHpGV3ZiMkM3ME5rY21wWWtEbmJFd1U0NmZqUGhJQkNS?=
 =?utf-8?B?ajE3QVlPYlBmRnQvNnNqT0JxL3k2N1Z3Z1hRQ3QzWG1vVFk4Qnp2Yy90d1Y0?=
 =?utf-8?B?ZDJRNEw5aWJPYU5POGpYU3IvcFpBZkZ0ZjB3Tm1ndU8rcmlZcnBldm80TFAz?=
 =?utf-8?B?Nk9TNVBudlNIMVJPVlFoZ3B4anhLeHFBMFZLeklJZTBjRVp5ZDVmdGd1YkZj?=
 =?utf-8?B?RTZCdnJJR1FmUTV0ZE9RRTZoUFloNTFZNy8zRFBkTTQzU0dyNldyb0tuZE93?=
 =?utf-8?B?eU1tbDZ3MkRXbC9nNXp5dU5ZWExibndmQlJ5NGR0QXpDaytzeHRWMnpYZldC?=
 =?utf-8?B?Wklsb2YrN0x4Z29TbnU5VXJOeUJNTVFmRFJ2MVhSYU1WalQvUys3WUlQNUp6?=
 =?utf-8?B?dzc4SkdWRi93N0cwNjdaVXhQUXNhZW9YakZQSTk5TitKTEpiQ0xDcWtUQ1dU?=
 =?utf-8?B?c2crSUdVRFRPamtWYU9mbGFHbW5BZjFDWVV3cldzM1BMUHp3Mkh3Z0xWVVZr?=
 =?utf-8?B?Mm1NUE0xdndsaFpwVHVaekw1ejFHZlVXUGRCK2FIanVia2wrb1RldkRmUXVy?=
 =?utf-8?Q?46PkrLfT3bpPVxEi9lbJAoL9W?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB2F968B85DE274D841C826AC1B354E2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5569825-ad5f-4b14-c2e3-08db974395f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 12:41:13.7358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Id5v1IQc1WQPQO59zS/nl4050ic+uQRuS9tkFogYwXFBxywSgQIP2G+1K2Dq2z5pwej13y2dlZfZVFjFNjB6Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5641
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

T24gTW9uLCAyMDIzLTA4LTA3IGF0IDEyOjUzICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBNb24sIEF1ZyAwNywgMjAyMyBhdCAwMjoxNDozN0FNICsw
MDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+IE9uIFN1biwgMjAyMy0wOC0wNiBhdCAxNDo0MSAr
MDMwMCwga2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbSB3cm90ZToNCj4gPiA+IE9uIFdl
ZCwgSnVsIDI2LCAyMDIzIGF0IDExOjI1OjEzUE0gKzEyMDAsIEthaSBIdWFuZyB3cm90ZToNCj4g
PiA+ID4gQEAgLTIwLDYgKzIxLDkgQEANCj4gPiA+ID4gICNkZWZpbmUgVERYX1NXX0VSUk9SCQkJ
KFREWF9FUlJPUiB8IEdFTk1BU0tfVUxMKDQ3LCA0MCkpDQo+ID4gPiA+ICAjZGVmaW5lIFREWF9T
RUFNQ0FMTF9WTUZBSUxJTlZBTElECShURFhfU1dfRVJST1IgfCBfVUwoMHhGRkZGMDAwMCkpDQo+
ID4gPiA+ICANCj4gPiA+ID4gKyNkZWZpbmUgVERYX1NFQU1DQUxMX0dQCQkJKFREWF9TV19FUlJP
UiB8IFg4Nl9UUkFQX0dQKQ0KPiA+ID4gPiArI2RlZmluZSBURFhfU0VBTUNBTExfVUQJCQkoVERY
X1NXX0VSUk9SIHwgWDg2X1RSQVBfVUQpDQo+ID4gPiANCj4gPiA+IElzIHRoZXJlIGFueSBleHBs
YW50aW9uIGhvdyB0aGVzZSBlcnJvciBjb2RlcyBnb3QgY2hvc2VuPyBMb29rcyB2ZXJ5DQo+ID4g
PiBhcmJpdHJhcnkgYW5kIG1heSBjb2xsaWRlIHdpdGggb3RoZXIgZXJyb3IgY29kZXMgaW4gdGhl
IGZ1dHVyZS4NCj4gPiA+IA0KPiA+IA0KPiA+IEFueSBlcnJvciBjb2RlIGhhcyBURFhfU1dfRVJS
T1IgaXMgcmVzZXJ2ZWQgdG8gc29mdHdhcmUgdXNlIHNvIHRoZSBURFggbW9kdWxlDQo+ID4gY2Fu
IG5ldmVyIHJldHVybiBhbnkgZXJyb3IgY29kZSB3aGljaCBjb25mbGljdHMgd2l0aCB0aG9zZSBz
b2Z0d2FyZSBvbmVzLg0KPiA+IA0KPiA+IEZvciB3aHkgdG8gY2hvb3NlIHRoZXNlIHR3bywgSSBi
ZWxpZXZlIFhPUiB0aGUgVFJBUCBudW1iZXIgdG8gVERYX1NXX0VSUk9SIGlzDQo+ID4gdGhlIHNp
bXBsZXN0IHdheSB0byBhY2hpZXZlOiAxKSBjb3N0aW5nIG1pbmltYWwgYXNzZW1ibHkgY29kZTsg
MikNCj4gPiBvcHBvcnR1bmlzdGljYWxseSBoYW5kbGluZyAjR1AgdG9vLCBhbGxvd2luZyBjYWxs
ZXIgdG8gZGlzdGluZ3Vpc2ggdGhlIHR3bw0KPiA+IGVycm9ycy4NCj4gDQo+IE15IHByb2JsZW0g
aXMgdGhhdCBpdCBpcyBnb2luZyB0byBjb25mbGljdCB3aXRoIGVycm5vLWJhc2VkIGVycm9ycyBp
ZiB3ZQ0KPiBnb2luZyB0byB0YWtlIHRoaXMgcGF0aCBpbiB0aGUgZnV0dXJlLiBMaWtlIHRoZXNl
IGVycm9ycyBhcmUgdGhlIHNhbWUgYXMNCj4gKFREWF9TV19FUlJPUiB8IEVBQ0NFUykgYW5kIChU
RFhfU1dfRVJST1IgfCBFTlhJTykgcmVzcGVjdGl2ZWx5Lg0KPiANCg0KSXMgdGhlcmUgYW55IHVz
ZSBjYXNlIHRoYXQgd2UgbmVlZCB0aG9zZSBkZWZpbml0aW9ucz8NCg0KRXZlbiB3ZSBoYXZlIHN1
Y2ggcmVxdWlyZW1lbnQgaW4gdGhlIGZ1dHVyZSwgd2Ugc3RpbGwgaGF2ZSBtYW55IGJpdHMgYXZh
aWxhYmxlDQphZnRlciB0YWtpbmcgb3V0IHRoZSBiaXRzIG9mIFREWF9TV19FUlJPUiB0aHVzIEkg
YXNzdW1lIHdlIGNhbiBkbyBzb21lIGJpdCBzaGlmdA0Kd2hlbiB0aGlzIHJlYWxseSBoYXBwZW5z
Pz8gDQo=
