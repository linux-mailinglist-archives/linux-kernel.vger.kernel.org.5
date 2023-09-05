Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56183792C64
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjIERTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346262AbjIERM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:12:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A346B1AF31;
        Tue,  5 Sep 2023 09:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693932180; x=1725468180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9JTfzQPEr415vV/od0mic13TkAODeeVna4Y9HhWBkK8=;
  b=QkkrUavqjeBCayyOm1UkrQoqmUaGlqcWWXbQvZ+8TFFSbXYBQrftT2Vt
   lJvhikshFKpepgVkvetI60DmlfolgEqoPvPIjJ9T4XnXG1MmTf4f8Ohgt
   DdFU/0Gwnk78Kst2jXoaLHcxc5/PBR4zo+e6ivIL7u2bF0w4u8Y0t79pb
   GCOi8lp4kkFLnHQFQZUnI82uc6/zgy0zoOF/FCw7BpjU8PDxlj+P8ZkzM
   +d41t87GfNWIQx9gQm4Vc0S1hAX52zByn3j3iImfXr9oOIV/ong6EH3bb
   W9BGd6FhESc7ACtOvY8AqwoAv4j7Bx0q7e2ZMVTyUQSrO7AKrniWiFZig
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="376760067"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="376760067"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 09:34:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="806670705"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="806670705"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 09:34:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 09:34:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 09:34:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 09:34:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 09:34:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3ZMVOOKJZMMxTbG94zA1Bgrzd/bJ680l/dNm+OO+0xPi4vwaRrkH+ZAxZ/4jVWhriQa8UKXP+hqY26XdhU0etgFfJyqiRZgyR5c0mtSfpLOXDmOBxHaqcqkR2s7LQfh3KJrOXcqpC0Ll1srJOoJxgwDf138IAsEJ9NZtn9n2mhciu2AMXJZpVqIC2Mqpoxx66hCBBjWy6DJ8scfc7aIwi9hwwqB1T7zaVr3cOTyiVCV1h94rZF0w0uYfAbN2sVXqdxb9PyNj1NkTtyilU/QVZLnWdS2bL2JYVkGKi0jP8K8A1bGHkaX/kkdwh8DrhuPBB6kdwljlmdawvwceJK08Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JTfzQPEr415vV/od0mic13TkAODeeVna4Y9HhWBkK8=;
 b=N7wRVeqI5KdpdX8YMUbcxW5k/nEIknlOkVjwt7XNhQKaW5F6lSL+jY2N6kcQncWy+43C/H73HlI4Gfnoh6dC4n14BY7ie/PgfHS/qkIKwgwEYCmT4mC8D8+N0Wh4jULJp0ea0lOAxIVUaKtvDhgq8niiLo6/KqEaRI7HCcMGkzjGC3eyUYXfbDNc3qkbFFCHIg5X0jWWrrhlAxzpO+ng7sF3CfkmZO4YRKCFgVZ8glFbaOOso8Smptw/VYX6erlY0c7sdrS5E/8WKTu0CPvFgJtwc9e4Ibrl0pZX4txC22OaUeY0ag4ekUJkTnVKzv37qD6TDKX+Dwz4dlQyTF7T/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by PH8PR11MB8016.namprd11.prod.outlook.com (2603:10b6:510:250::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 16:34:39 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::c733:b6c6:fe0d:d4c4]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::c733:b6c6:fe0d:d4c4%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 16:34:39 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "sultan@kerneltoast.com" <sultan@kerneltoast.com>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: iwlwifi: mvm: fix power save for MLD
Thread-Topic: [PATCH] wifi: iwlwifi: mvm: fix power save for MLD
Thread-Index: AQHZ1K5ISoNk3fBCf0axeYS3aTgmD7ABgY2AgABBzICACsECgA==
Date:   Tue, 5 Sep 2023 16:34:39 +0000
Message-ID: <26a2786c775105df765827520bfbd40a31b49fe3.camel@intel.com>
References: <20230822040745.260086-1-sultan@kerneltoast.com>
         <5a5d6502180858f811861384acc49f9174ca8652.camel@intel.com>
         <ZO5TOS3HxyqN-bNu@sultan-box.localdomain>
In-Reply-To: <ZO5TOS3HxyqN-bNu@sultan-box.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|PH8PR11MB8016:EE_
x-ms-office365-filtering-correlation-id: 07b1e2a2-eba7-493c-3ba4-08dbae2dfffd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eTXTRDYkyAnsknjsM2+aOIJwllyoPLvwJydQTrxu2HdOQuzv+i3loyQFbmuNJkYxYi/EN0feGiCKYCFjY5rh3iDMjZ3qahK2p//is/zB/sbIlJPu5ON+FF5TPTjyQSu03joz/Pl5ZyqC2vE9cvX6qFwAaxOERbfDruQh0Ich3ZgkJtT0X6t2xL3HTGVchKYSEJI5/u7bD3ebniV1KMEtnrSm6e4wyPKFGQMK5FqIg77cdrFGQrXLKIs9Z5fMPL+UKcxPe3xJ8q+5aY1z2l3IBy4yJSR1aZILNtDgK208Hv+aqAUIXAJSkouNmjOhv7fJ6k9FS2/KDxGjGld58ruNe605KXu0+P1WAvpiaV3DwKXycLNJM/cULIkjm7JRWrtXDNH7H82xdcJlC6sqnjPlnBGBcG39vYtzLSEZB1sdXhpDXiRk7LBNKwSPktWLma4Awzl0PH5WBIJX6j7aMYZ7vlAq4Kt8+FOfr8c5cF2O4RAmfweuBDn+5Y0ti7BS2AntPF+H8XEnkINsXAE8bXnEBcn15lIS+9u7y6KgYNiCxuVUq11rPS1wjH9IjWgq6/7y58YrGDsrNs8CFIRpXNKW6t48kLsoT3wR4vVTT7NecJnLfb09c3/Yg8+Ok2MgP7Zkz8o1JYAATUr16N7Wj7E2gg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199024)(186009)(1800799009)(2906002)(6512007)(6916009)(76116006)(66476007)(66556008)(54906003)(66946007)(64756008)(66446008)(316002)(41300700001)(8676002)(4326008)(36756003)(8936002)(5660300002)(966005)(91956017)(86362001)(71200400001)(38070700005)(38100700002)(6486002)(6506007)(82960400001)(2616005)(122000001)(26005)(478600001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWtHQUpvTGtneGFCQnpHM05XQXlqMlRXV0ZVVFdHbS9CTFFXQ3dCY2FQZVJC?=
 =?utf-8?B?WXNuWVphaG9GQWI1eUNiZENzenUxbXpCdml2ZUV2Z001ekxjNHc5a01WcDdO?=
 =?utf-8?B?WnlyRHBnMW5ib0hvQXJ3UUVqQTFmRUxrZkFXOEJhT3BVZzRuNE5sMXlyTGhr?=
 =?utf-8?B?SUxMUXlXZkplemxuM2RJeTgrRWptL3BJL1QyOVlEU3E2ckR0R0ZuSldOcEd6?=
 =?utf-8?B?R1UzWnV3TU5meVhwOE53QSt0UkJtd3d6Q2YwdHJBVkRncmxNN3dKQlNtbjF1?=
 =?utf-8?B?aklkUlZWVTBrdkdXOVJVeHh1TkYvNVIwL2FKRUhEVWtIbXIxV3hGVzVPSHRr?=
 =?utf-8?B?aGdKSktneXdnOVhRUytCK2FHMTBWWXpMMDdOMU56UlZ3Vkxta0orYnIwcGRa?=
 =?utf-8?B?T25mak85bFdaeWltRzJzNWFMd1lKRnlrVDJKQkxpTHJJR2RyWHFvRDdyVDE1?=
 =?utf-8?B?UDFjZHk4UlcyYzQ1OURMcG9FbUlsMFhTa2ZKTlZXNVRVRDEyZGtnMzF6dVJR?=
 =?utf-8?B?QUY3V3pUV0FubHRrK3dnbFZYeGlYbXhNWWNobms3SXVIVURKZ3JSdVdaMnJK?=
 =?utf-8?B?WTBlT0JXSXJKTkJ2d1pvUlFoZ2hoMXVLVnYwUzk4bDBlbVY3b3pCWlNiVldx?=
 =?utf-8?B?MEhrVkhmY0xqVkFlU084SG5Nc2J1Y3BqN2Q0NE4vcU12Mm14a0V3ZWg3MGdZ?=
 =?utf-8?B?Wk5nT3BVOG9rM0hsS2o3aFEyMzhKNnZiMWE4U2hBdnlrRzFDci9tQzdmNDYy?=
 =?utf-8?B?RXBqaWxCcC9lOFhISmVQNENSRHF6MVl3TFFtS0FBOVJDSlM1M3FIcFJWaWh3?=
 =?utf-8?B?L2ZXd1Q1Z21QcWhUMHNoaUZZSEkwVjluSmFiT3d6VWNQcHNoS2FyUEtlbERM?=
 =?utf-8?B?cll5MkZWQi9wV0poVzZyS3VtVE5aLzRFZzRiQVBCU2NWWUpZVzRGWXZZV01v?=
 =?utf-8?B?em1OaVdBZkNYODNZa1FTdjB1UG5qb2VjOUpyWnJPLyt6SUVUdUpCQ0NiTTJn?=
 =?utf-8?B?bXdnTC9KdUpHOTRuWVc0cXJnT0s0U1daV1pIdFBzTEdSLzY0VUQyZnNZMWpW?=
 =?utf-8?B?aUQ5TlJSdzIyQWl2a2ZjL28zSFo3M09UVVBDcjJiL1lxRlVLSXBQRk1aTDdt?=
 =?utf-8?B?Rld2NzVrUTQ4VUNDR25UdWlwT29MR01oSzFjUEtkbWVTdmhTKzVmcVpjeGNE?=
 =?utf-8?B?ak1iUjk2VnJLQVNxdXhjU1ZEbzdQWGdjUzBLTCtrcXNJTDU0RjAyOEIxTm9t?=
 =?utf-8?B?OHZaMkE1OUxPeU83NGZNcG9VNVNPcndMWUtqMW1xR1BEU24yeHcyZXZrdnpt?=
 =?utf-8?B?aFNCc1loRkN3cDU3SjMrNCtzVEROdm42dVg1YTJtSTdLaDRwMTJDZVpQV1JH?=
 =?utf-8?B?QUYrRk50Q0tkaVpYYldpZFdiRWliZVdJU1lvSnYxK1JZb0dzOHFXdkNZQWxX?=
 =?utf-8?B?M205dm4wOUUzRmpTZWl6cWF2WWlzZDlPYjVnK1E4a3N2Q0JwZTFlbFRaZ3No?=
 =?utf-8?B?cllIb2IvR2hXaUM2Y3l1L21nL2FpUEhGVmNhM3daN3ZZSk1pRG1HVFFNM01J?=
 =?utf-8?B?WmdXc1VjTVRWM3AvYmlMYklkZnhIWjhxeGR5eENSa05aL29zQTF0MXY1Yzk2?=
 =?utf-8?B?NFpXOTNHWkhEOEUxdUlYQndnRUVXaGhUVEZoZ0NHaHVSZjFCZlJxdy8yNFVE?=
 =?utf-8?B?TEpqaWk0WVpWZVZnUDVmSlVCejBpTk1Pcnl3U01ScE1JK3NJVzUvWTlmWWFh?=
 =?utf-8?B?SUZXS2JzQ3NrVjRRUnJlS1Y3Z1NTZVNJSDFaSEJRWHhJY2xYbks3UUV4MWFu?=
 =?utf-8?B?cWhTQW1RUnJ4bi9ZcVlGMDVFaGxCcWpNVGxGZERhanM4amxZREhJclppZkti?=
 =?utf-8?B?RXNoSmNISHNpNDhJeXdPN2xHRDNadEVXUE1VbllUR2tvbmxMR2liYW5jdk1p?=
 =?utf-8?B?eUJ5S0FOQmwwYnpwZUdVT2p1ZWV3dGdOZ29hY0RRejJYZEZZME91NC82a1dQ?=
 =?utf-8?B?TFFoYjBCdUo5dXh1aFlCTnh4ZGlRcHkwSDc3RGh3cHdqdjZmUzRFMFdRbjBB?=
 =?utf-8?B?Q3pTd0VZWWNUSmZwTzVJQzgwOEI2TDVMS2d2TmFSQVk1M2EwRS9KV0l0YVF6?=
 =?utf-8?B?M3krVDAwbUZRYmhSNUIxeGxaN1RxNkNZcUdIVkhGbEpjQkZ4QWJ6NW9aazFq?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D2C50D2758E6E40A0AB46EAF23A90B6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b1e2a2-eba7-493c-3ba4-08dbae2dfffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 16:34:39.4421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZ2uzSFPhmLXmrRJRZ+jSV93nP/85haakou9oNlUUcyAChKyJ5rCLnNwfvZZ3vGeF5ua0PI4nQoNKIeZTAFL7vOWg/zaM0mhMdhbsxCd7v8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8016
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

T24gVHVlLCAyMDIzLTA4LTI5IGF0IDEzOjIxIC0wNzAwLCBTdWx0YW4gQWxzYXdhZiB3cm90ZToN
Cj4gT24gVHVlLCBBdWcgMjksIDIwMjMgYXQgMDQ6MjU6NDVQTSArMDAwMCwgR3JlZW5tYW4sIEdy
ZWdvcnkgd3JvdGU6DQo+ID4gSGksDQo+ID4gDQo+ID4gT24gTW9uLCAyMDIzLTA4LTIxIGF0IDIx
OjA3IC0wNzAwLCBTdWx0YW4gQWxzYXdhZiB3cm90ZToNCj4gPiA+IEZyb206IFN1bHRhbiBBbHNh
d2FmIDxzdWx0YW5Aa2VybmVsdG9hc3QuY29tPg0KPiA+ID4gDQo+ID4gPiBUaGUgY29udmVyc2lv
biBmcm9tIGJzc19pbmZvX2NoYW5nZWQoKSB0byB2aWZfY2ZnL2xpbmtfaW5mb19jaGFuZ2VkKCkN
Cj4gPiA+IHJlbW92ZWQgYSBjYWxsIHRvIGl3bF9tdm1fYnNzX2luZm9fY2hhbmdlZF9zdGF0aW9u
X2NvbW1vbigpIGZyb20gd2hhdA0KPiA+ID4gYmVjYW1lIHRoZSB2aWZfY2ZnX2NoYW5nZWQoKSBw
YXRoLiBBcyBhIHJlc3VsdCwgQlNTX0NIQU5HRURfUFMgYW5kIG90aGVyDQo+ID4gPiBwb3dlciBz
YXZlIGNoYW5nZXMgc2VudCB2aWEgaWVlZTgwMjExX3ZpZl9jZmdfY2hhbmdlX25vdGlmeSgpIGFy
ZSBpZ25vcmVkDQo+ID4gPiBmb3IgTUxELCB3aGljaCBicmVha3MgcG93ZXIgc2F2ZSBlbnRpcmVs
eS4gVGhpcyBoYXMgYSBub3RpY2VhYmxlIGltcGFjdCBvbg0KPiA+ID4gcG93ZXIgY29uc3VtcHRp
b24sIGNhdXNpbmcgaWRsZSBwYWNrYWdlIHBvd2VyIHRvIGhvdmVyIGF0IDEwIFcgb24gbXkNCj4g
PiA+IGk5LTEzOTgwSFggbGFwdG9wIHdpdGggYW4gQVgyMTAgd2hpbGUgY29ubmVjdGVkIHRvIFdp
RmkuDQo+ID4gPiANCj4gPiA+IEFkZCB0aGUgbWlzc2luZyBpd2xfbXZtX2Jzc19pbmZvX2NoYW5n
ZWRfc3RhdGlvbl9jb21tb24oKSBjYWxsIHRvIHRoZQ0KPiA+ID4gdmlmX2NmZ19jaGFuZ2VkKCkg
cGF0aCB0byBmaXggcG93ZXIgc2F2ZSBmb3IgTUxELiBUaGlzIGJyaW5ncyBpZGxlIHBhY2thZ2UN
Cj4gPiA+IHBvd2VyIGRvd24gdG8gMSBXIG9uIG15IGxhcHRvcCwgYSA5IFcgaW1wcm92ZW1lbnQu
DQo+ID4gPiANCj4gPiA+IEZpeGVzOiAyMmM1ODgzNDM1MjkgKCJ3aWZpOiBpd2x3aWZpOiBtdm06
IHJlcGxhY2UgYnNzX2luZm9fY2hhbmdlZCgpIHdpdGggdmlmX2NmZy9saW5rX2luZm9fY2hhbmdl
ZCgpIikNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFN1bHRhbiBBbHNhd2FmIDxzdWx0YW5Aa2VybmVs
dG9hc3QuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiDCoGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVs
L2l3bHdpZmkvbXZtL21sZC1tYWM4MDIxMS5jIHwgMiArKw0KPiA+ID4gwqAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tbGQtbWFjODAyMTEuYyBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL21sZC1tYWM4MDIxMS5jDQo+ID4gPiBpbmRleCA4
YjZjNjQxNzcyZWUuLjZhYmMwNTk3Njg3MCAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL21sZC1tYWM4MDIxMS5jDQo+ID4gPiArKysgYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tbGQtbWFjODAyMTEuYw0KPiA+
ID4gQEAgLTczMSw2ICs3MzEsOCBAQCBzdGF0aWMgdm9pZCBpd2xfbXZtX21sZF92aWZfY2ZnX2No
YW5nZWRfc3RhdGlvbihzdHJ1Y3QgaXdsX212bSAqbXZtLA0KPiA+ID4gwqANCj4gPiA+IMKgwqDC
oMKgwqDCoMKgwqBtdm12aWYtPmFzc29jaWF0ZWQgPSB2aWYtPmNmZy5hc3NvYzsNCj4gPiA+IMKg
DQo+ID4gPiArwqDCoMKgwqDCoMKgwqBpd2xfbXZtX2Jzc19pbmZvX2NoYW5nZWRfc3RhdGlvbl9j
b21tb24obXZtLCB2aWYsICZ2aWYtPmJzc19jb25mLA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBjaGFuZ2VzKTsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBpZiAo
IShjaGFuZ2VzICYgQlNTX0NIQU5HRURfQVNTT0MpKQ0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByZXR1cm47DQo+ID4gPiDCoA0KPiA+IA0KPiA+IEkgYWdyZWUgdGhhdCBp
dCBsb29rcyBsaWtlIHRoZSBjYWxsIHRvIGl3bF9tdm1fYnNzX2luZm9fY2hhbmdlZF9zdGF0aW9u
X2NvbW1vbigpIGlzIG1pc3NpbmcgaGVyZSwgYnV0DQo+ID4gSSB0aGluayBpZiBpcyBpcyBhZGRl
ZCBoZXJlIHRoZW4gdGhlIGNhbGwgdG8gaXdsX212bV9wb3dlcl91cGRhdGVfbWFjKCkgYXQgdGhl
IGVuZCBvZiB0aGlzIGZ1bmN0aW9uDQo+ID4gaXMgbm90IG5lZWRlZCBhbnltb3JlPw0KPiANCj4g
VGhhdCBjYWxsIHRvIGl3bF9tdm1fcG93ZXJfdXBkYXRlX21hYygpIG9ubHkgZXhpc3RzIGluIHRo
ZSBiYWNrcG9ydCBkcml2ZXIgWzFdDQo+IGF0IHRoZSBtb21lbnQsIGhlbmNlIHdoeSBwb3dlciBz
YXZlIGlzIGN1cnJlbnRseSBicm9rZW4gaW4gdGhlIHVwc3RyZWFtIGRyaXZlci4NCj4gDQo+IEkg
d2Fzbid0IGF3YXJlIHRoYXQgdGhlIGJhY2twb3J0IGRyaXZlciBoYWQgdGhhdCBjaGFuZ2UgdW50
aWwgYWZ0ZXIgSSBzZW50IHRoaXMsDQo+IEZXSVcuIDopDQo+IA0KPiBJIGFncmVlIHRoYXQgdGhl
IGl3bF9tdm1fcG93ZXJfdXBkYXRlX21hYygpIGNhbGwgaW4gdGhlIGJhY2twb3J0IGRyaXZlciB3
b3VsZCBiZQ0KPiByZWR1bmRhbnQgd2l0aCB0aGlzIHBhdGNoLg0KPiANCj4gSG93IHdvdWxkIHlv
dSBsaWtlIHRvIGdvIGFib3V0IHRoaXM/IFNoYWxsIEkgc2VuZCBhIHYyIHJlZm9ybWF0dGVkIGZv
ciB0aGUNCj4gYmFja3BvcnQgZHJpdmVyLCB3aXRoIGFuIHVwZGF0ZWQgY29tbWl0IG1lc3NhZ2Ug
c2luY2UgcG93ZXIgc2F2ZSBpc24ndCBicm9rZW4gaW4NCj4gdGhlIGJhY2twb3J0IGRyaXZlcj8N
Cj4gDQo+IE9yIGNvdWxkIHRoaXMgYmUgc3RhZ2VkIHVwc3RyZWFtIHdpdGggWzFdIHN1YnNlcXVl
bnRseSBnZXR0aW5nIGRyb3BwZWQgZnJvbSB0aGUNCj4gYmFja3BvcnQgZHJpdmVyPw0KPiANCj4g
VGhhbmtzLA0KPiBTdWx0YW4NCj4gDQo+IFsxXSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC9pd2x3aWZpL2JhY2twb3J0LWl3bHdpZmkuZ2l0L2NvbW1pdC8/
aWQ9YzMyMDFlM2Q3ZDg4YmRmYTBmMGE5NGU0MTQxYzYyNmMzNTcyNDY1NQ0KDQpTb3JyeSBmb3Ig
dGhlIGRlbGF5LiBJJ3ZlIHNlbnQgdGhlIHBhdGNoIGluIFsxXSBmcm9tIG91ciBiYWNrcG9ydCB0
cmVlLiANCkNhbiBJIGFzayB5b3UgdG8gdHJ5IGl0Pw0KDQpUaGFua3MsDQpHcmVnb3J5DQoNClsx
XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC13aXJlbGVzcy8yMDIzMDkwNTE2MjkzOS41
ZWYwYzgyMzBkZTYuSWVlZDI2NTAxNDk4OGM1MGVjNjhmYmZmNmQzMzgyMWU0MjE1Zjk4N2ZAY2hh
bmdlaWQvDQoNCg0K
