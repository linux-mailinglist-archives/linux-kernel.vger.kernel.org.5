Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8737078C99F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbjH2Q12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237295AbjH2Q0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:26:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26781AD;
        Tue, 29 Aug 2023 09:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693326410; x=1724862410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FUIp2Y34+G4ZEisy1T1FmZBI88IL6LvGsLDxNKPHEhY=;
  b=cbh/ZAU68zZbiPBkLXoTTO9hsHpLBEGMHmNxLHeJp3DLcFCswsvjWjeB
   EeoCuwjFDvnCKni3vOkzW7S0pmOR3VpxHbMujqXcfZdpASaC2nXjyaNlf
   n6PF2HdHUSVuovTOAADrhYFI987/63CaZOXIkrsCLnM7F8uAYbbAe9U0T
   jlwzyegdz1CWf9Hi7y1XnvmAoSx1SJPWSc6zGGcpHddk+fTcAaLrfUtty
   seE2h6KabGmLuFtfArr1lW7rOzoQFB9pkyOzL934S2dp1viG/fxiau2w0
   luEqwD/cmBtRtYBWOPWcC9wsOAVKwT3e9an3rfohlwG8xG1+8+OS+42Pd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="365625688"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="365625688"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 09:25:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="738768352"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="738768352"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 29 Aug 2023 09:25:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 09:25:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 09:25:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 09:25:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkclM701WaLDvpGP8/Di6HcaGxwpNkT+q+26ZZcIsn8aWnaxfMTnpAvcs4n2oL9Cl/SpEmxqtTJJxQbIPzmIaXZi+vy357YEsF+Lnj/o9hnecSC5O9sUWLwe/ofKuCfo3JiHwBLFqArKUbEUEFjW0hkkL9p/UtHWL6jwoY9X6CsYrOkCA6pfdwTKeUUf0i4qQE7wle/a5kGiMtDEEKBdwrQMoQ3oUiuA9PNowK8jm97ZZ6i6vX0fE/Szxy+dpp6VN3XUKwDzef+nwhuiTQm9zk5HC7d7pYXEks/zdzqo7Wm1uHxNcOklfE0RE1i/677kGyynxBUzKzdoGuhrrsM3cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUIp2Y34+G4ZEisy1T1FmZBI88IL6LvGsLDxNKPHEhY=;
 b=ZNUKsvk5c5cV6Kjan0CAToWrzsWfr5MWHLi2IRt52GIF3Z8ykAFCo3xNuAv7sfhcngHUfL2SCr4jW/kdesLk0QkRXyVsDGaJqJW+qwDxt3mabAPPljHHooHq76wutojScOE7YBn625z6r5npHuZTY2LhskXeathfVWgDdFh2Z6dq39W+3ylKAw2UwtMHHqo5I3tWWSWribKflMg/5hTBE5ZUNgYj3jIPtI2A6ZxZEtdegZJNguxPB2I7hQABRMRfpV5XHdqICiKd2f3E/EkMG0n1yLSPFm4JT+4WKTSVHa/UaccChiuwrKELAx4VileIF9yK/0B0wRefNY3QhbCxWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by SA1PR11MB7700.namprd11.prod.outlook.com (2603:10b6:806:330::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 16:25:45 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::c733:b6c6:fe0d:d4c4]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::c733:b6c6:fe0d:d4c4%7]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 16:25:45 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "sultan@kerneltoast.com" <sultan@kerneltoast.com>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: iwlwifi: mvm: fix power save for MLD
Thread-Topic: [PATCH] wifi: iwlwifi: mvm: fix power save for MLD
Thread-Index: AQHZ1K5ISoNk3fBCf0axeYS3aTgmD7ABgY2A
Date:   Tue, 29 Aug 2023 16:25:45 +0000
Message-ID: <5a5d6502180858f811861384acc49f9174ca8652.camel@intel.com>
References: <20230822040745.260086-1-sultan@kerneltoast.com>
In-Reply-To: <20230822040745.260086-1-sultan@kerneltoast.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|SA1PR11MB7700:EE_
x-ms-office365-filtering-correlation-id: 51e159bc-4102-4018-4d8c-08dba8ac98da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iZbOxCemycXb/ecJGCLbe7iR19kUbRozBJG2WgDoQ54PzQLgzomD9dFyaAvEXCGoBpPejcasxYd/g2GUkrBvPsC5iStltv5ySbtzKNy/lp39BXIkVhFVf8ZdK1pBl0UoAzX3VwKGWgSvCgjsKYIM4y7p5HFJxRnN9rF1t+s29abczJAx+Qs+1Dd5yxIyi4wLs8/H8rpShxO2VZEZj8HAzJywHA0RPzFvpl1FvBCS5poVwPOWTGTS5j2pufvtuAFD99pLe6cXONE3S6Hu1DU+wLdRjeItX105TJfSLJVDvfZP1T8vpJumSf9ID7pNZJdvc0yDSEo87WBbIq1u2eGhDvsMSFpkuYevnEtWAC6sGCfGxvwRIM5sR2ivjrJJYC6tx3vFHBD0gFr2g0/5kaZg3yUkxuLr3ZP64Bx2zJ/O+rveaNE657INYq55WXPgW66LIIsrYJixa1uJQWRURNqJwdouO84cwfuJEyaKFPy51n+QpVHACHEz/3yTEKzgMejvOOgz1Rn+MJy193tbwuWNh8v5vy9JmOqHsRBj8/QCAVS+5jhTyawcKwFGslfVoL3GiacMWQJhzkaPg7Bo3Bp3f2LTqjjKZdAX4gZPTe841YAzbXAyBEKz5gfNnlfN/Kbo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(186009)(451199024)(1800799009)(41300700001)(26005)(122000001)(38100700002)(38070700005)(86362001)(478600001)(71200400001)(82960400001)(83380400001)(2616005)(6512007)(6486002)(6506007)(76116006)(91956017)(66446008)(54906003)(6916009)(2906002)(66476007)(316002)(64756008)(36756003)(66556008)(66946007)(5660300002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3Nnblp3bEREeGRqQjM4dDJTaDEzR1lmZVRBenZmT01RWVltL0M1dU9odzBv?=
 =?utf-8?B?M25GTHdsVngvN0N0VjRPTTVwWDJ3SFB5OHIxUExMT3VzeHRVb2xLTjlwN1g5?=
 =?utf-8?B?bE92YXZaUk5ZNFlwQVlKaE9xRCtGdFpLWkJnaWRJV3BMOTFManRBSFNOQnBD?=
 =?utf-8?B?UWxFamhSTVROMGVNRS9iMkhFYzNMa1JKWTNVVmM0cnVjdUV4a3kxVUY0T1k2?=
 =?utf-8?B?Tmp3Y3lTd3FiU0FOZWpVVWV6K0RoWEh2VTg4azdpQzJYcWh6ZUVCT0RhaDd2?=
 =?utf-8?B?MkticmtBUGpBb29QaG5kdWFvdXNOMW5lR21DcTA5b1VIU3Y0cUo3NVNsdG45?=
 =?utf-8?B?WG5lMUVNL3ZWMkU0L0lOTW5vdWQ0NU1tM09VVVZkMDNodEhXL3ZrbzF2QXh0?=
 =?utf-8?B?cjFuODVTNjlGWHU1SlV3Tzl3K09pVlkxODdIb2o5WVFzR2JXckx0OVVMSVZt?=
 =?utf-8?B?bkVrOTVzclI3eHltekFKSUwxcEtONkIrL2xXN2NJMjA1eThuM2sydkFtL0xz?=
 =?utf-8?B?dDZScDdNTDVVcnJnYUx5c3NzSVRzeTUrSjloczJ5azlzb0JaZlJTa2NGclJT?=
 =?utf-8?B?QjZoVXM4UGxwUmZYVjlUelMvNVhnR25qNE9ENGJ6c2IyQ3VUR05wMnFaYUJm?=
 =?utf-8?B?cjh1NzcwUDdoWk1hY3Q0VXNjSEZqN01aY3BZbGFZUHJqK3VQOFMvbW5taUQ1?=
 =?utf-8?B?ZjE0cVhGOTJvcmtwQUNCZ3Y3QklySitKNFQ1blBTM3NXTjM3S1Y4aEZseHBi?=
 =?utf-8?B?N3VSZi9jaDlZODBZejcrcnZjdmczelNBUm9UbEhyOXI3eWNRazZDdnhlTHk1?=
 =?utf-8?B?eXZYNkFac3hoMXU5eERFalllTFQzMVlrL3EraXgvekNTVGdFZEJnU2JnM2RG?=
 =?utf-8?B?bXVDZU9ncFJUekRkN2ROdTkxdS9Nd3ROUkc2N2FOSFBhdEZyOGRWRkdLUkhB?=
 =?utf-8?B?a0VUV1A5L1BFckl3SmM5bG5Mb1l0Z0JqcjIwWWVLZmZ2ZWNzSytYWVZJYXFB?=
 =?utf-8?B?Ym0vSlJ3YlhVT1hReDZGWkU4TlMvNVN4SFhXWG5wVUdRVmhQUU5vR3hyaDA1?=
 =?utf-8?B?YjlKL29CZVlTMUcvM1AzOW91YUJFRkpNR1BpOWlYMnVjSlVHTnJkMHBzeHdn?=
 =?utf-8?B?TmJhQVNvZUlwVGVobW1neTVrNDNwcm9TR3dyY0QxcDBYakI2VUhUcVpGMGx1?=
 =?utf-8?B?b0pGdEM0WlBaakxUV3RiR1FHZzNEMXpwalFqRnlMVk4veHVmblUyUlczaHVM?=
 =?utf-8?B?QWdzU0RLUExxQTgrYlZ3ejZnaHFob0VXSVdWeXV2aHNqYzVvd1hvV2VRTDhz?=
 =?utf-8?B?TkJJdXNNTEJZaWQyc2JTTTNXYXBpR0k4YjNOM3h3SUY3ZzdLOGt5VGI5djlO?=
 =?utf-8?B?cWs4OFdkVTVkRDV0S1lCcGY2Vng1Y21JTitOUkhVTEtpQ1BTMDdnQ0tydjF4?=
 =?utf-8?B?VVhiaXBwVmNUWUwydERXR2hGa0dhcWZnMUJ3MTdiZ01rRDBIQUNsK0RtV0Ex?=
 =?utf-8?B?akRzSGhqMCtGeDVlZlN3enpuRThWcGdrS0VVMHZLWFBKQTR0d3M5MmoyNHQ3?=
 =?utf-8?B?Z2RtblAwWGpTNjdwZFgwa1JsTHRnQkNuVGFWUWpVWWltRXhpTUs2L2VTVGp3?=
 =?utf-8?B?b3FyTm9xSzFibXYrMmd2cEltZzU2dkRDNGcxWEVpbVlzMHpmRXpUSnBSZmFC?=
 =?utf-8?B?dm9WVkFjQUNvMTlnN2xENC9iNys3elhRK3FKS09OMzY4MTkrUzhqR29ncGgy?=
 =?utf-8?B?VWN2ZnJsaUtUT2NEUDgwdDhreTJ1REV4RHlGRlZHRjZhVUlENzFXckFxR1I1?=
 =?utf-8?B?Z1Jpak13STQ0eGNvZC9VVldtcXFDL0hHS1lpZFB2R1JlTXpJOU1lb3NCdjZh?=
 =?utf-8?B?L0wvckhvK1ZTbklDaHczeTcxZXc0SXczSlA3cEk3ZnBLazhvbnVyck1CVllI?=
 =?utf-8?B?aHJZeGRzL0pWT0VxdkI1a2NYZXduVWZRUGgxR1F0MU1GSjQvc3pmZkhqZ282?=
 =?utf-8?B?NGdZNmxnVlNJS1k1WEo5Z3NCYWFrb0dLcm1uN095Qy9EbkpLUzY5b0NuR0tq?=
 =?utf-8?B?SDJybjVESWZGeE1HK1lURzYzWUxyWGNSYytibjVhbkdWd1hPVlNUVExGbW1J?=
 =?utf-8?B?WXlSamlQYkRMWkY0Q3p3cUlrV1I2RU5CWk9Mcm9nNHI4L0VzcEc1S2M5M3pW?=
 =?utf-8?Q?0cwP1q9NecdUG85FMd9SOf0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AD7C30D72A6F04B947DAC0AE8243E65@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e159bc-4102-4018-4d8c-08dba8ac98da
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 16:25:45.5160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ImsTSEFmsRPqnDOPW89/vHQYROwel2Kyh5VeqFvxnUG91hHa7jb5FeIv98Y3KJ2LujkwoVA9d3MWaqylg52sQPv/mG3ERT9uZpIW7KdOCYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7700
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

SGksDQoNCk9uIE1vbiwgMjAyMy0wOC0yMSBhdCAyMTowNyAtMDcwMCwgU3VsdGFuIEFsc2F3YWYg
d3JvdGU6DQo+IEZyb206IFN1bHRhbiBBbHNhd2FmIDxzdWx0YW5Aa2VybmVsdG9hc3QuY29tPg0K
PiANCj4gVGhlIGNvbnZlcnNpb24gZnJvbSBic3NfaW5mb19jaGFuZ2VkKCkgdG8gdmlmX2NmZy9s
aW5rX2luZm9fY2hhbmdlZCgpDQo+IHJlbW92ZWQgYSBjYWxsIHRvIGl3bF9tdm1fYnNzX2luZm9f
Y2hhbmdlZF9zdGF0aW9uX2NvbW1vbigpIGZyb20gd2hhdA0KPiBiZWNhbWUgdGhlIHZpZl9jZmdf
Y2hhbmdlZCgpIHBhdGguIEFzIGEgcmVzdWx0LCBCU1NfQ0hBTkdFRF9QUyBhbmQgb3RoZXINCj4g
cG93ZXIgc2F2ZSBjaGFuZ2VzIHNlbnQgdmlhIGllZWU4MDIxMV92aWZfY2ZnX2NoYW5nZV9ub3Rp
ZnkoKSBhcmUgaWdub3JlZA0KPiBmb3IgTUxELCB3aGljaCBicmVha3MgcG93ZXIgc2F2ZSBlbnRp
cmVseS4gVGhpcyBoYXMgYSBub3RpY2VhYmxlIGltcGFjdCBvbg0KPiBwb3dlciBjb25zdW1wdGlv
biwgY2F1c2luZyBpZGxlIHBhY2thZ2UgcG93ZXIgdG8gaG92ZXIgYXQgMTAgVyBvbiBteQ0KPiBp
OS0xMzk4MEhYIGxhcHRvcCB3aXRoIGFuIEFYMjEwIHdoaWxlIGNvbm5lY3RlZCB0byBXaUZpLg0K
PiANCj4gQWRkIHRoZSBtaXNzaW5nIGl3bF9tdm1fYnNzX2luZm9fY2hhbmdlZF9zdGF0aW9uX2Nv
bW1vbigpIGNhbGwgdG8gdGhlDQo+IHZpZl9jZmdfY2hhbmdlZCgpIHBhdGggdG8gZml4IHBvd2Vy
IHNhdmUgZm9yIE1MRC4gVGhpcyBicmluZ3MgaWRsZSBwYWNrYWdlDQo+IHBvd2VyIGRvd24gdG8g
MSBXIG9uIG15IGxhcHRvcCwgYSA5IFcgaW1wcm92ZW1lbnQuDQo+IA0KPiBGaXhlczogMjJjNTg4
MzQzNTI5ICgid2lmaTogaXdsd2lmaTogbXZtOiByZXBsYWNlIGJzc19pbmZvX2NoYW5nZWQoKSB3
aXRoIHZpZl9jZmcvbGlua19pbmZvX2NoYW5nZWQoKSIpDQo+IFNpZ25lZC1vZmYtYnk6IFN1bHRh
biBBbHNhd2FmIDxzdWx0YW5Aa2VybmVsdG9hc3QuY29tPg0KPiAtLS0NCj4gwqBkcml2ZXJzL25l
dC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tbGQtbWFjODAyMTEuYyB8IDIgKysNCj4gwqAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbWxkLW1hYzgwMjExLmMgYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tbGQtbWFjODAyMTEuYw0KPiBpbmRleCA4
YjZjNjQxNzcyZWUuLjZhYmMwNTk3Njg3MCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbWxkLW1hYzgwMjExLmMNCj4gKysrIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbWxkLW1hYzgwMjExLmMNCj4gQEAgLTczMSw2
ICs3MzEsOCBAQCBzdGF0aWMgdm9pZCBpd2xfbXZtX21sZF92aWZfY2ZnX2NoYW5nZWRfc3RhdGlv
bihzdHJ1Y3QgaXdsX212bSAqbXZtLA0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgbXZtdmlmLT5h
c3NvY2lhdGVkID0gdmlmLT5jZmcuYXNzb2M7DQo+IMKgDQo+ICvCoMKgwqDCoMKgwqDCoGl3bF9t
dm1fYnNzX2luZm9fY2hhbmdlZF9zdGF0aW9uX2NvbW1vbihtdm0sIHZpZiwgJnZpZi0+YnNzX2Nv
bmYsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2hhbmdlcyk7DQo+
IMKgwqDCoMKgwqDCoMKgwqBpZiAoIShjaGFuZ2VzICYgQlNTX0NIQU5HRURfQVNTT0MpKQ0KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybjsNCj4gwqANCg0KSSBhZ3JlZSB0
aGF0IGl0IGxvb2tzIGxpa2UgdGhlIGNhbGwgdG8gaXdsX212bV9ic3NfaW5mb19jaGFuZ2VkX3N0
YXRpb25fY29tbW9uKCkgaXMgbWlzc2luZyBoZXJlLCBidXQNCkkgdGhpbmsgaWYgaXMgaXMgYWRk
ZWQgaGVyZSB0aGVuIHRoZSBjYWxsIHRvIGl3bF9tdm1fcG93ZXJfdXBkYXRlX21hYygpIGF0IHRo
ZSBlbmQgb2YgdGhpcyBmdW5jdGlvbg0KaXMgbm90IG5lZWRlZCBhbnltb3JlPw0K
