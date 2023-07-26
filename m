Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89A9762987
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 05:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjGZDzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 23:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjGZDzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:55:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A031BF2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 20:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690343718; x=1721879718;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hifmt1WpPzDFs5RUsY5tiNFBDxgV0CbWq0+6zT1motk=;
  b=ZSf8kX2ml3Zh/Q7atURH40Cm4rwi2uBG/3S71yWrurtjGcOh0J7UtKSF
   O2siEzAsTE2fCPthyimWSDOtmk3QY0Pn/O1cQXWfMtqC3grfNTeRhKPTY
   b5TSF1WvnBNWR+OO/S+f2vBbgK9aQhWlPLY9QEU9FJQ2ZVPwPD5wBZ5RH
   tobfu7eXznG6TFhD4UXVK6MFVDJFTJiNlQVGfnSKMAK0egbFIM54raNgg
   bv23cgJIZ/za5FkbhVSsiXKa1X8K+Ztfyp0KeR39ya2RXjfGfK3QaD5vA
   6DYtsW02eckrpQGBiZOw//OsaiwSqddEKz1nPg+rm4hRp0RjFySgZsmCS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="348179989"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="348179989"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 20:55:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="676487534"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="676487534"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 25 Jul 2023 20:55:17 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 20:55:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 20:55:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 25 Jul 2023 20:55:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 25 Jul 2023 20:55:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJpRE6TXHq1FPZqvONIOHo34rDDsuM+3lo0xjMwe4EFIjwVNByYs9MD2SqjwENWcTn70oOpmex/JV1kU674f5J49SYW6UUGPhcMeduI7oXNfveL0gmf4zJFWV8IZPlt33e26YOypTYi0EQac1P9j3+u+/6LHa2/WFLd/TqgTjjOOD/rmi9nSSjYDPQHuU1AYVWTiJBLSWuogfg/qzRp4Fw1lhibyjy2tplX2eWkGp19qeOKrfW2riUYxRMwWrjiQQpS873nZjeos7+h+Y/YgnNtARIyz8od/C/XEaWw+zmImikZOoF3jp4WNYx9MHu/2MzoHzCGops0ABLlVxxVh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hifmt1WpPzDFs5RUsY5tiNFBDxgV0CbWq0+6zT1motk=;
 b=Kl2hzXngbEGiuWqIlj34sAV7jvc8wsntQEPX1JBWDKFtbhPE+vefSDy/azBhgxlMAfVGWBgzkMWGFemyR1J0EeElOWP1Lh9eH0epxE4V68BDj7fU5b9e6/CGQJo44NNb0gVIooMZveutRxkELMJK/t0Ml83SSLbv7031Zh7IF/NL9O+9nAWK63qWgHvToCL9txRO7wDfUlzVUyHfhNqr7jIDppNkXeU2nWNquKEFyC/u5YRqyaK3n1ExEocMg6qCac3v/fKKQcz0E64hxZZgy4Wn8q9faARW/UU3YE87O78mboB3k0v99vHo9KuhBoZqa29L6xEZ4C5yR2D89zwjww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by PH8PR11MB6949.namprd11.prod.outlook.com (2603:10b6:510:227::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 03:55:14 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::d383:a84c:6dee:47e3]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::d383:a84c:6dee:47e3%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 03:55:13 +0000
From:   "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "apopple@nvidia.com" <apopple@nvidia.com>
CC:     "Nikula, Jani" <jani.nikula@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
        "Yedireswarapu, SaiX Nandan" <saix.nandan.yedireswarapu@intel.com>
Subject: RE: [Intel-gfx] Regression in linux-next
Thread-Topic: [Intel-gfx] Regression in linux-next
Thread-Index: AQHZvsM91PW1SDpunUS9z3A/B3yYEa/KTvgAgAEdNUA=
Date:   Wed, 26 Jul 2023 03:55:13 +0000
Message-ID: <SJ1PR11MB6129F38F4B28D24A89D3E3A3B900A@SJ1PR11MB6129.namprd11.prod.outlook.com>
References: <SJ1PR11MB6129592BDF5D06949F99816CB95B9@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB6129A7F5C08E2C47748F2BA5B97E9@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB612980562220A376CA90E105B97E9@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB61296D265E3407D447188EF6B903A@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <ef712b76-ef8a-9c01-08e3-13a1ee5b00b4@linux.intel.com>
In-Reply-To: <ef712b76-ef8a-9c01-08e3-13a1ee5b00b4@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6129:EE_|PH8PR11MB6949:EE_
x-ms-office365-filtering-correlation-id: 29d2af1d-8159-44e8-177e-08db8d8c1de1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iacNxRDVF5XWJqbZ7PJ42k06dsjX7WDr3zcp2kYEp1ikJQqSqspihyXvWTfzmv2KVWxYBGImm6CtU6zk9h4EBNInGhQyZCOlo/HTOEd1rsk/A829tPhQkissmdVW3xDWjcjbr02TZ7TGMv9Ie9CWZ0sYBpCsfn1XMjo87JJ3YkefXOSjlfAYffOH0n6nuPVsUISbtq/niYg8OJ7Sk3WqcLMV9B4MgorlX5I4XZaWrvwTsifcMnA97qm5pdBKdE4Q6xKR7OjICxrVm3bl0yRq+o6XtNAFnzGYAvAi63Rltvkq4jXaVVYv5n8e3P7U3XrObnBO8LmxaLab2JVOI7/QAb3tACtf2ct0IhbTMjm1zxbivsIr/LnzOXd3ypfGnN1l3ZZE6jcBTKUBBCCycUWUVjPwEEieJYzXrkjw+tPmE73e+tJBETFRdScZABvkzdD4zhZ3pHSUPr2S9jdj0uNQ3xmCdlqXz9fwfNbGHM+EflV/f8K2wrToxFBuL5TZMrCPMmTD1434uqSvmPnctje/4HJUEHFGv61c5e4h3IyyfItx11DXcEoOZKnHMUoA3V1wMrBiKCU0Z4mggbdsH7dydloQ+EZOBkrXqOvbnzvVPIQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6129.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199021)(55016003)(6506007)(186003)(26005)(71200400001)(53546011)(66556008)(83380400001)(76116006)(66946007)(4326008)(64756008)(66476007)(316002)(66446008)(52536014)(41300700001)(8676002)(9686003)(966005)(8936002)(5660300002)(7696005)(2906002)(110136005)(478600001)(54906003)(38100700002)(122000001)(38070700005)(33656002)(86362001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVFDelNXRjZMdTBPSFFTNFN1dGNwVTA3bDZLbFBzTnk2NWxHWlBaK2RqTXFS?=
 =?utf-8?B?SUR2a3ZsV1VpakNuWEVQcElDdTMweXJBTHR6cDFlb3ZLcTVCSlovOG0ralJ1?=
 =?utf-8?B?NldqVHBpV0VMb3hrdU9ieXJTVzJmR2tkWEp3dytQbWRFNG9XREl2MFpSNVNV?=
 =?utf-8?B?RThDWTdmN0YyMFAyV0sySDdMMkV0NlpwTDJWWWY5VXk5a2ZEY3JlQ01Yakds?=
 =?utf-8?B?eXQzUXBOOGx2UG1JUTBGckl2bzZTTmxlcms3NW53RmlEZUFVMWZOeldFOXNt?=
 =?utf-8?B?SkNDQVpPTHR6eklOZEw5UUFua3d6YnY5aU1MMG5QWVF3VEZBZHQ0aTRKZWQ2?=
 =?utf-8?B?UzhRYzFnVjB2OWRoY2lPNGkveFl5RGY5WC9tdFBxRGFZSVUrREllYVNuV3A2?=
 =?utf-8?B?Q3BPZi9YaGoyZENRaEw2OThwRTJuQUNOcDVyVDVBVjNXOUVlT0ZWK3RWL3pt?=
 =?utf-8?B?Z2RWbEJDVDZNb3ViUk5ScWt6bTVwYVkwaVo3SFBlNWJPOTBxOXVZbTBiOVhk?=
 =?utf-8?B?Y1BTUzhWeG9Tei9nUEp3WkMyK2FpYzMxWnYvVit1N1BKaS9PVExZczEwZjVN?=
 =?utf-8?B?bmZWYXF3U2tEUm1Hak5sdFYzL3RoSVlQemkyN0dzUTd3d0Vlb2xNUldxWFN1?=
 =?utf-8?B?S2ZwaXRlandHNVY2aWZHOHUwaVBkVHN2MENPbS9pSWRaU3cwVDdBTkVqYXVC?=
 =?utf-8?B?enZpb2pqTEV6QXE2eFJrTGcrUURLbGp5c1dHMnRtV3lxOVR2aklLejdDNzJL?=
 =?utf-8?B?bkc1OGJlcXFHTHlZcVVNaE5GOWZYY0I3WlJ6OURVZzErM3E4KzByK21yN1VH?=
 =?utf-8?B?ak56Q054WFRwUHQrWDFPZ2p6UHhBUjUzMGN5YlozeCtIbnJGY2ptQkZ0UzIy?=
 =?utf-8?B?dG4vc0U4UlJtQStpQkMvQ1VKUFhlUHhyWUl6bWFPY081ZUJsWGRScmZ6cUJK?=
 =?utf-8?B?d2szWXFzNDM0TnJmUE5ONzFEQVkrZXd0S29Dd2M0UVV2YmJLdjZIenZsNUFE?=
 =?utf-8?B?MDhTUEMrUXNMc3QrVXN1ODZhYUU0bndOMnora2pzT1FXazY5NTFyc3JjNXpF?=
 =?utf-8?B?eEpldU5KNDF1QkszOVhFdWI2RnVMRGIzbjZxOHd3UUtvZjlXZjhvRHN0aFBk?=
 =?utf-8?B?SGFTVzBDbFNRcDNIanlmNDVCTkc0dFd2ZjZnT3VRcjJIOFUva1ZPTEZ4cTB5?=
 =?utf-8?B?RTJSay9oMGV2RG1jQ2dicmdhYit6WXhISyt0c3U1ZDdhNmxSL0VHZml3cFd4?=
 =?utf-8?B?bmM1bUttK3kydjhEVkRvYnZqeUZPNTQ0d2c2VmZuZTE2MDMwOVV3bkJqSXdJ?=
 =?utf-8?B?ejF5bmVYR0xDQjM5cWllbkVYQk1xRVpXSDdONTVMTkFGQjYyNkZvVzl2TjRt?=
 =?utf-8?B?LzBWRENybUZPWXErb2lzVkQxZGpua0t0SFNvS2JIc1k3a0cxZld6RlFQVkV2?=
 =?utf-8?B?R0RjY0JYRjFmQ0ZGMVlHLzVMUGJTcENGblAxRHh6SjFXamtwTFlxVElYZWlj?=
 =?utf-8?B?YmVxak9xQm03aERzZkpIczVkc3R4L1hZQW9aOUduU1RaRHhkZndhaWFKaDAy?=
 =?utf-8?B?a29CcS8zMlhpSmxjS0U3NjBlL1pUSU5EZU1aa1VKbHB0YzVrKzRXSWcrY1p6?=
 =?utf-8?B?OFhEQkxvUVBVb0cyMVBXNEZBQXBQWDh0b3FmWDhsWGRTbDhmaHZhM2tId0pH?=
 =?utf-8?B?NldnS3ZUaUEwclZZYU5YaEtWZ0JmY0FTQTcvOFcrYzRtL0JaMFoydlpzdGpN?=
 =?utf-8?B?aWd6TW5tbDBFaXN1b2pLK2tPWUUyemg5MXBQQm4yS3VuNEFnMlNRaXFwVW9L?=
 =?utf-8?B?TjhVVmJ0QVNqYnJ0TldLdUYrZk56ZUFhVURCbjV4UCs0R2V2TUZUNjhpeUg2?=
 =?utf-8?B?NlBHV3lYM2ZteWh5eHgxMTFSRGg1bk82cEZUL2sxbG1iZ3V0bTZzT0dGSFgv?=
 =?utf-8?B?ZEFJM0RueUVXMjErRjM0cG9mclJ0L1I4ZE03b21kWER6MHRzUGlDN1hNTG1i?=
 =?utf-8?B?aGoxaVkwL2tqNFhCNFhkRm56aEFjZDYwUG9nZmZFdnpEQkhIZklTU0hVdXQz?=
 =?utf-8?B?U3FaY0I3QmdMK3F2cGRuczdJQzU4RStiQ2ViOFNrTklPbXZDV1JtbWd6LzFu?=
 =?utf-8?B?VVJKdDZWaVNiV0pLK3VaRkdqUWJLTUZ2US9NR1pubzNhaVQxZmZ3TSsxL3Vx?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d2af1d-8159-44e8-177e-08db8d8c1de1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 03:55:13.9129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MWFh8+1uQ4YoeTOTBIxwkmzu81Wrd0uJ9vS60bFB3TW5HeeFBR7wCBEDzwdtxGcedzNbueQ4ApCoTQ0FRbljD2rSHWHW1V/XImnbLFLkh40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6949
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gVHZydGtvLA0KDQpZb3VyIGFuYWx5c2lzIGlzIGNvcnJlY3QuIEFsaXN0YWlyIGhhcyBz
ZW50IGEgbmV3IHBhdGNoIHNldCB3aXRoIGEgZml4Lg0KDQpUaGFuayB5b3UuDQoNClJlZ2FyZHMN
Cg0KQ2hhaXRhbnlhDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHZy
dGtvIFVyc3VsaW4gPHR2cnRrby51cnN1bGluQGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogVHVl
c2RheSwgSnVseSAyNSwgMjAyMyA0OjI0IFBNDQo+IFRvOiBCb3JhaCwgQ2hhaXRhbnlhIEt1bWFy
IDxjaGFpdGFueWEua3VtYXIuYm9yYWhAaW50ZWwuY29tPjsNCj4gYXBvcHBsZUBudmlkaWEuY29t
DQo+IENjOiBOaWt1bGEsIEphbmkgPGphbmkubmlrdWxhQGludGVsLmNvbT47IGludGVsLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1tbUBrdmFjay5vcmc7IEt1cm1pLCBTdXJlc2ggS3VtYXINCj4gPHN1cmVzaC5rdW1hci5r
dXJtaUBpbnRlbC5jb20+OyBZZWRpcmVzd2FyYXB1LCBTYWlYIE5hbmRhbg0KPiA8c2FpeC5uYW5k
YW4ueWVkaXJlc3dhcmFwdUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbSW50ZWwtZ2Z4XSBS
ZWdyZXNzaW9uIGluIGxpbnV4LW5leHQNCj4gDQo+IA0KPiBPbiAyNS8wNy8yMDIzIDA3OjQyLCBC
b3JhaCwgQ2hhaXRhbnlhIEt1bWFyIHdyb3RlOg0KPiA+IEhlbGxvIEFsaXN0YWlyLA0KPiA+DQo+
ID4gSG9wZSB5b3UgYXJlIGRvaW5nIHdlbGwuIEkgYW0gQ2hhaXRhbnlhIGZyb20gdGhlIGxpbnV4
IGdyYXBoaWNzIHRlYW0gaW4NCj4gSW50ZWwuDQo+ID4NCj4gPiBUaGlzIG1haWwgaXMgcmVnYXJk
aW5nIGEgcmVncmVzc2lvbiB3ZSBhcmUgc2VlaW5nIGluIG91ciBDSSBydW5zWzFdIG9uDQo+ID4g
bGludXgtbmV4dCByZXBvc2l0b3J5Lg0KPiA+DQo+ID4gT24gbmV4dC0yMDIzMDcyMCBbMl0sIHdl
IGFyZSBzZWVpbmcgdGhlIGZvbGxvd2luZyBlcnJvcg0KPiA+DQo+ID4gPDQ+WyAgIDc2LjE4OTM3
NV0gSGFyZHdhcmUgbmFtZTogSW50ZWwgQ29ycG9yYXRpb24gTWV0ZW9yIExha2UgQ2xpZW50DQo+
IFBsYXRmb3JtL01UTC1QIEREUjUgU09ESU1NIFNCUyBSVlAsIEJJT1MNCj4gTVRMUEZXSTEuUjAw
LjMyNzEuRDgxLjIzMDcxMDE4MDUgMDcvMTAvMjAyMw0KPiA+IDw0PlsgICA3Ni4yMDI1MzRdIFJJ
UDogMDAxMDpfX21tdV9ub3RpZmllcl9yZWdpc3RlcisweDQwLzB4MjEwDQo+ID4gPDQ+WyAgIDc2
LjIwNzgwNF0gQ29kZTogMWEgNzEgNWEgMDEgODUgYzAgMGYgODUgZWMgMDAgMDAgMDAgNDggOGIg
ODUgMzAgMDEgMDANCj4gMDAgNDggODUgYzAgMGYgODQgMDQgMDEgMDAgMDAgOGIgODUgY2MgMDAg
MDAgMDAgODUgYzAgMGYgOGUgYmIgMDEgMDAgMDAgPDQ5PiA4Yg0KPiA0NCAyNCAxMCA0OCA4MyA3
OCAzOCAwMCA3NCAxYSA0OCA4MyA3OCAyOCAwMCA3NCAwYyAwZiAwYiBiOA0KPiA+IDw0PlsgICA3
Ni4yMjYzNjhdIFJTUDogMDAxODpmZmZmYzkwMDAxOWQ3Y2E4IEVGTEFHUzogMDAwMTAyMDINCj4g
PiA8ND5bICAgNzYuMjMxNTQ5XSBSQVg6IDAwMDAwMDAwMDAwMDAwMDEgUkJYOiAwMDAwMDAwMDAw
MDAxMDAwIFJDWDoNCj4gMDAwMDAwMDAwMDAwMDAwMQ0KPiA+IDw0PlsgICA3Ni4yMzg2MTNdIFJE
WDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IGZmZmZmZmZmODIzY2ViN2IgUkRJOg0KPiBmZmZmZmZm
ZjgyM2VlMTJkDQo+ID4gPDQ+WyAgIDc2LjI0NTY4MF0gUkJQOiBmZmZmODg4MTAyZWM5YjQwIFIw
ODogMDAwMDAwMDBmZmZmZmZmZiBSMDk6DQo+IDAwMDAwMDAwMDAwMDAwMDENCj4gPiA8ND5bICAg
NzYuMjUyNzQ3XSBSMTA6IDAwMDAwMDAwMDAwMDAwMDEgUjExOiBmZmZmODg4MTE1N2NkMmMwIFIx
MjoNCj4gMDAwMDAwMDAwMDAwMDAwMA0KPiA+IDw0PlsgICA3Ni4yNTk4MTFdIFIxMzogZmZmZjg4
ODEwMmVjOWM3MCBSMTQ6IGZmZmZmZmZmYTA3ZGU1MDAgUjE1Og0KPiBmZmZmODg4MTAyZWM5Y2Uw
DQo+ID4gPDQ+WyAgIDc2LjI2Njg3NV0gRlM6ICAwMDAwN2ZiY2FiZTExYzAwKDAwMDApIEdTOmZm
ZmY4ODg0NmVjMDAwMDAoMDAwMCkNCj4ga25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KPiA+IDw0Plsg
ICA3Ni4yNzQ4ODRdIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAw
NTAwMzMNCj4gPiA8ND5bICAgNzYuMjgwNTc4XSBDUjI6IDAwMDAwMDAwMDAwMDAwMTAgQ1IzOiAw
MDAwMDAwMTBkNGMyMDA1IENSNDoNCj4gMDAwMDAwMDAwMGY3MGVlMA0KPiA+IDw0PlsgICA3Ni4y
ODc2NDNdIERSMDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6IDAwMDAwMDAwMDAwMDAwMDAgRFIyOg0K
PiAwMDAwMDAwMDAwMDAwMDAwDQo+ID4gPDQ+WyAgIDc2LjI5NDcxMV0gRFIzOiAwMDAwMDAwMDAw
MDAwMDAwIERSNjogMDAwMDAwMDBmZmZmMDdmMCBEUjc6DQo+IDAwMDAwMDAwMDAwMDA0MDANCj4g
PiA8ND5bICAgNzYuMzAxNzc1XSBQS1JVOiA1NTU1NTU1NA0KPiA+IDw0PlsgICA3Ni4zMDQ0NjNd
IENhbGwgVHJhY2U6DQo+ID4gPDQ+WyAgIDc2LjMwNjg5M10gIDxUQVNLPg0KPiA+IDw0PlsgICA3
Ni4zMDg5ODNdICA/IF9fZGllX2JvZHkrMHgxYS8weDYwDQo+ID4gPDQ+WyAgIDc2LjMxMjQ0NF0g
ID8gcGFnZV9mYXVsdF9vb3BzKzB4MTU2LzB4NDUwDQo+ID4gPDQ+WyAgIDc2LjMxNjUxMF0gID8g
ZG9fdXNlcl9hZGRyX2ZhdWx0KzB4NjUvMHg5ODANCj4gPiA8ND5bICAgNzYuMzIwNzQ3XSAgPyBl
eGNfcGFnZV9mYXVsdCsweDY4LzB4MWEwDQo+ID4gPDQ+WyAgIDc2LjMyNDY0M10gID8gYXNtX2V4
Y19wYWdlX2ZhdWx0KzB4MjYvMHgzMA0KPiA+IDw0PlsgICA3Ni4zMjg3OTZdICA/IF9fbW11X25v
dGlmaWVyX3JlZ2lzdGVyKzB4NDAvMHgyMTANCj4gPiA8ND5bICAgNzYuMzMzNDYwXSAgPyBfX21t
dV9ub3RpZmllcl9yZWdpc3RlcisweDExYy8weDIxMA0KPiA+IDw0PlsgICA3Ni4zMzgyMDZdICA/
IHByZWVtcHRfY291bnRfYWRkKzB4NGMvMHhhMA0KPiA+IDw0PlsgICA3Ni4zNDIyNzNdICBtbXVf
bm90aWZpZXJfcmVnaXN0ZXIrMHgzMC8weGUwDQo+ID4gPDQ+WyAgIDc2LjM0NjUwOV0gIG1tdV9p
bnRlcnZhbF9ub3RpZmllcl9pbnNlcnQrMHg3NC8weGIwDQo+ID4gPDQ+WyAgIDc2LjM1MTM0NF0g
IGk5MTVfZ2VtX3VzZXJwdHJfaW9jdGwrMHgyMWEvMHgzMjAgW2k5MTVdDQo+ID4gPDQ+WyAgIDc2
LjM1NjU2NV0gID8gX19wZnhfaTkxNV9nZW1fdXNlcnB0cl9pb2N0bCsweDEwLzB4MTAgW2k5MTVd
DQo+ID4gPDQ+WyAgIDc2LjM2MjI3MV0gIGRybV9pb2N0bF9rZXJuZWwrMHhiNC8weDE1MA0KPiA+
IDw0PlsgICA3Ni4zNjYxNTldICBkcm1faW9jdGwrMHgyMWQvMHg0MjANCj4gPiA8ND5bICAgNzYu
MzY5NTM3XSAgPyBfX3BmeF9pOTE1X2dlbV91c2VycHRyX2lvY3RsKzB4MTAvMHgxMCBbaTkxNV0N
Cj4gPiA8ND5bICAgNzYuMzc1MjQyXSAgPyBmaW5kX2hlbGRfbG9jaysweDJiLzB4ODANCj4gPiA8
ND5bICAgNzYuMzc5MDQ2XSAgX194NjRfc3lzX2lvY3RsKzB4NzkvMHhiMA0KPiA+IDw0PlsgICA3
Ni4zODI3NjZdICBkb19zeXNjYWxsXzY0KzB4M2MvMHg5MA0KPiA+IDw0PlsgICA3Ni4zODYzMTJd
ICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg2ZS8weGQ4DQo+ID4gPDQ+WyAgIDc2
LjM5MTMxN10gUklQOiAwMDMzOjB4N2ZiY2FlNjNmM2FiDQo+ID4NCj4gPiBEZXRhaWxzIGxvZyBj
YW4gYmUgZm91bmQgaW4gWzNdLg0KPiA+DQo+ID4gQWZ0ZXIgYmlzZWN0aW5nIHRoZSB0cmVlLCB0
aGUgZm9sbG93aW5nIHBhdGNoIHNlZW1zIHRvIGJlIGNhdXNpbmcgdGhlDQo+ID4gcmVncmVzc2lv
bi4NCj4gPg0KPiA+IGNvbW1pdCA4MjhmZTQwODVjYWU3N2FjYjNhYmY3ZGQzZDI1YjNlZDZjNTYw
ZWRmDQo+ID4gQXV0aG9yOiBBbGlzdGFpciBQb3BwbGUgYXBvcHBsZUBudmlkaWEuY29tDQo+ID4g
RGF0ZTogICBXZWQgSnVsIDE5IDIyOjE4OjQ2IDIwMjMgKzEwMDANCj4gPg0KPiA+ICAgICAgbW11
X25vdGlmaWVyczogcmVuYW1lIGludmFsaWRhdGVfcmFuZ2Ugbm90aWZpZXINCj4gPg0KPiA+ICAg
ICAgVGhlcmUgYXJlIHR3byBtYWluIHVzZSBjYXNlcyBmb3IgbW11IG5vdGlmaWVycy4gIE9uZSBp
cyBieSBLVk0gd2hpY2gNCj4gdXNlcw0KPiA+ICAgICAgbW11X25vdGlmaWVyX2ludmFsaWRhdGVf
cmFuZ2Vfc3RhcnQoKS9lbmQoKSB0byBtYW5hZ2UgYSBzb2Z0d2FyZSBUTEIuDQo+ID4NCj4gPiAg
ICAgIFRoZSBvdGhlciBpcyB0byBtYW5hZ2UgaGFyZHdhcmUgVExCcyB3aGljaCBuZWVkIHRvIHVz
ZSB0aGUNCj4gPiAgICAgIGludmFsaWRhdGVfcmFuZ2UoKSBjYWxsYmFjayBiZWNhdXNlIEhXIGNh
biBlc3RhYmxpc2ggbmV3IFRMQiBlbnRyaWVzIGF0DQo+ID4gICAgICBhbnkgdGltZS4gIEhlbmNl
IHVzaW5nIHN0YXJ0L2VuZCgpIGNhbiBsZWFkIHRvIG1lbW9yeSBjb3JydXB0aW9uIGFzDQo+IHRo
ZXNlDQo+ID4gICAgICBjYWxsYmFja3MgaGFwcGVuIHRvbyBzb29uL2xhdGUgZHVyaW5nIHBhZ2Ug
dW5tYXAuDQo+ID4NCj4gPiAgICAgIG1tdSBub3RpZmllciB1c2VycyBzaG91bGQgdGhlcmVmb3Jl
IGVpdGhlciB1c2UgdGhlIHN0YXJ0KCkvZW5kKCkgY2FsbGJhY2tzDQo+ID4gICAgICBvciB0aGUg
aW52YWxpZGF0ZV9yYW5nZSgpIGNhbGxiYWNrcy4gIFRvIG1ha2UgdGhpcyB1c2FnZSBjbGVhcmVy
IHJlbmFtZQ0KPiA+ICAgICAgdGhlIGludmFsaWRhdGVfcmFuZ2UoKSBjYWxsYmFjayB0byBhcmNo
X2ludmFsaWRhdGVfc2Vjb25kYXJ5X3RsYnMoKSBhbmQNCj4gPiAgICAgIHVwZGF0ZSBkb2N1bWVu
dGlvbi4NCj4gPg0KPiA+ICAgICAgTGluazoNCj4gPg0KPiBodHRwczovL2xrbWwua2VybmVsLm9y
Zy9yLzlhMDJkZGUyZjhkZGFhZDJkYjMxZTU0NzA2YTgwYzEyZDE4MTdhYWYuMTY4DQo+ID4gOTc2
ODgzMS5naXQtc2VyaWVzLmFwb3BwbGVAbnZpZGlhLmNvbQ0KPiA+DQo+ID4NCj4gPiBXZSBhbHNv
IHZlcmlmaWVkIGJ5IHJldmVydGluZyB0aGUgcGF0Y2ggaW4gdGhlIHRyZWUuDQo+ID4NCj4gPiBD
b3VsZCB5b3UgcGxlYXNlIGNoZWNrIHdoeSB0aGlzIHBhdGNoIGNhdXNlcyB0aGUgcmVncmVzc2lv
biBhbmQgaWYgd2UNCj4gPiBjYW4gZmluZCBhIHNvbHV0aW9uIGZvciBpdCBzb29uPw0KPiANCj4g
V2l0aG91dCBjaGVja2luZyBvdXQgdGhlIHdob2xlIHRyZWUgYnV0IG9ubHkgbG9va2luZyBhdCB0
aGlzIHBhdGNoIGluDQo+IGlzb2xhdGlvbiwgaXQgY291bGQgYmUgdGhhdCBpdCBpcyBub3QgY29u
c2lkZXJpbmcgTlVMTCBzdWJzY3JpcHRpb24gY2FuIGJlDQo+IHBhc3NlZCB0byBtbXVfbm90aWZp
ZXJfcmVnaXN0ZXIuIEZvciBpbnN0YW5jZSBmcm9tDQo+IG1tdV9pbnRlcnZhbF9ub3RpZmllcl9p
bnNlcnQsIHdoaWNoIGk5MTUgaXMgY2FsbGluZy4gU28gdGhlIGNoZWNrIHBhdGNoIGFkZGVkDQo+
IHRvIF9fbW11X25vdGlmaWVyX3JlZ2lzdGVyIGNhdXNlcyBhIG51bGwgcG9pbnRlciBkZXJlZmVy
ZW5jZToNCj4gDQo+IEBAIC02MTYsNiArNjE3LDE1IEBAIGludCBfX21tdV9ub3RpZmllcl9yZWdp
c3RlcihzdHJ1Y3QgbW11X25vdGlmaWVyDQo+ICpzdWJzY3JpcHRpb24sDQo+ICAgICAgICAgIG1t
YXBfYXNzZXJ0X3dyaXRlX2xvY2tlZChtbSk7DQo+ICAgICAgICAgIEJVR19PTihhdG9taWNfcmVh
ZCgmbW0tPm1tX3VzZXJzKSA8PSAwKTsNCj4gDQo+ICsgICAgICAgLyoNCj4gKyAgICAgICAgKiBT
dWJzeXN0ZW1zIHNob3VsZCBvbmx5IHJlZ2lzdGVyIGZvciBpbnZhbGlkYXRlX3NlY29uZGFyeV90
bGJzKCkgb3INCj4gKyAgICAgICAgKiBpbnZhbGlkYXRlX3JhbmdlX3N0YXJ0KCkvZW5kKCkgY2Fs
bGJhY2tzLCBub3QgYm90aC4NCj4gKyAgICAgICAgKi8NCj4gKyAgICAgICBpZg0KPiArIChXQVJO
X09OX09OQ0Uoc3Vic2NyaXB0aW9uLT5vcHMtPmFyY2hfaW52YWxpZGF0ZV9zZWNvbmRhcnlfdGxi
cyAmJg0KPiANCj4gLS0tPiBzdWJzY3JpcHRpb24gaXMgTlVMTCBoZXJlIDwtLS0NCj4gDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKHN1YnNjcmlwdGlvbi0+b3BzLT5pbnZhbGlk
YXRlX3JhbmdlX3N0YXJ0IHx8DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Vi
c2NyaXB0aW9uLT5vcHMtPmludmFsaWRhdGVfcmFuZ2VfZW5kKSkpDQo+ICsgICAgICAgICAgICAg
ICByZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiANCj4gUmVnYXJkcywNCj4gDQo+IFR2cnRrbw0KPiAN
Cj4gPg0KPiA+IFsxXSBodHRwczovL2ludGVsLWdmeC1jaS4wMS5vcmcvdHJlZS9saW51eC1uZXh0
L2NvbWJpbmVkLWFsdC5odG1sPw0KPiA+IFsyXQ0KPiA+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQvY28NCj4gPiBtbWl0
Lz9oPW5leHQtMjAyMzA3MjAgWzNdDQo+ID4gaHR0cHM6Ly9pbnRlbC1nZngtY2kuMDEub3JnL3Ry
ZWUvbGludXgtbmV4dC9uZXh0LTIwMjMwNzIwL2JhdC1tdGxwLTYvZA0KPiA+IG1lc2cwLnR4dA0K
