Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B127D8BFA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 00:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjJZW7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 18:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJZW7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 18:59:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EC91B8;
        Thu, 26 Oct 2023 15:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698361177; x=1729897177;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lmJG963th2RuE19bKfJAFgWgnygZggBBnEgwPeRyifI=;
  b=RtQxDMeWvTXjkLD1W9mJSttobSK/Hlz/aP8+2TBE7chrgnZDnqyBu37z
   bajNuxnU2wkIaLu89BItJCT6iHQfjuOLuCkTsVyLOvwOu4HIPdedZyYIV
   Kb2atCA+8BUp4zH4988hQlrFsLq2L2Ycanpbo8cEVVTPQVV4AH5ZDdv9N
   DoUkG9/92riBrZWl/S0WReuAKBNnutH1Qdzaj4H7iKV0ZBV2Nh7W9uHhw
   9cgoncFbMAI4dDwHxgiPjoKJj9dSFrhggOYevtJKCwS+WHIhsQedcgt6c
   V7nzmdrBYBUgeV19O5cGCKx4f+KpoFhZ8qu+g8oEPz5Lz5gNU5hYFIr2O
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="378034892"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="378034892"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 15:59:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="850066902"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="850066902"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 15:59:35 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 15:59:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 15:59:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 15:59:34 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 15:59:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PE5JueVaTvkUPZtZhniFoxEa7Z7h5y0NstPcru9BOfBftMmD0wfOEMQB1p4GyyrUAiUORG9DO0Gg1IEikCoFZ/Br1jd2QMhL6U8elTrPpCTMDUl7SKTxmOFoqYLgqwAI3iU4+9vd2jbmqz5ckmMOzjn3xOr82M8NJdRLDifszXPbP5U7kbPbmf53toxJ9YBwsZkbfqbk1tM0FOG3XfHGXKe7+w5hn0TDIP5uOKxIsbpsiXS9e1Aom+WgrPKpzr6NmjWtRvs7AdWEOi/A9IJ5i3IkGGxEzTjPBGEO92VIB/twcyoPOTvYrgnW3OYfjh6bnIPJe1zYoIyTMxtvnDm0nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmJG963th2RuE19bKfJAFgWgnygZggBBnEgwPeRyifI=;
 b=R2yg7kQki0vRYQTOjParbLI7LHkNt8DQH7T1xEojXcnyDTxOsaHokcKpwGW6BkBeVrGdQ0V7TFMPEwwNAbhjPawCuI0Zs3YVlZcmfpwVWnzkwBcIY2rX+CeMmF+x7Sah7dicQOVJFUI+4RQ3t+KIiRe/fJLEXzibhI4xSjuzzAioPp2R0dSx7Na6uTtwONyMx67aYNeKRrHbp8YT9RnN8tUF4wIVvzPatXYrySlCWgeG8Yw0h4u+xV06TWyTKKPa/DGhFpVxkrL6o48X84aDIMMip6rlC4dbeaW+M2+swrEh80azkn/klg4MmtqFCpgzlKjLeWz5foPEutUMUTXFyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BY1PR11MB8006.namprd11.prod.outlook.com (2603:10b6:a03:52d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 22:59:32 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3ffb:89e2:2724:4c5]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3ffb:89e2:2724:4c5%2]) with mapi id 15.20.6907.025; Thu, 26 Oct 2023
 22:59:32 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "babu.moger@amd.com" <babu.moger@amd.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v3] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
Thread-Topic: [PATCH v3] x86/resctrl: mba_MBps: Fall back to total b/w if
 local b/w unavailable
Thread-Index: AQHaCEddvpO8kujzW0Wys14hXinuwrBcqkOAgAADlJA=
Date:   Thu, 26 Oct 2023 22:59:32 +0000
Message-ID: <SJ1PR11MB6083C75727F30800AFC7A1C9FCDDA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231025235046.12940-1-tony.luck@intel.com>
 <20231026200214.16017-1-tony.luck@intel.com>
 <a03e5f5e-ac9c-f8b1-0260-d58ede569d67@amd.com>
In-Reply-To: <a03e5f5e-ac9c-f8b1-0260-d58ede569d67@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BY1PR11MB8006:EE_
x-ms-office365-filtering-correlation-id: 597c9315-e2a4-45ff-32b7-08dbd677376e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 20+fyRsWCNLZF9NqjdukY4LembRg/XIkydX9iiB0/Ky/SdB4yv3DwFX+bqOszA1jLD72LdAC+IGcdSvH7tZtHl0lBDQstTTJ8ZKPCm5GIE2xU/9ysnkF9R6W89+jVLEcdv7QXX4wgiVtGSToMK2o8jxoE8np3ojeHdXBpCiObIRAPRoXjC+Xs7Y0IqTVk0ph/nsxkPDBZA1UEVslpTSty+jsPnf7vvFutZaEaFuwFYQvVBwkfWa5SsYngccK92rbMsiaj+2XKus6Kz+ij6y8OU0Ze3LBcRDy+h6f6zUcok47pYXpgFyTwYy6q4lLG1bN6D43jCNEnXy5TUxkF/dxAaPhAJ37gAvj3OBQbQ/US2n5EYt0bbh6XphV3WqAF3x+FSRNgVBLHNwmMsFAkK+zJbPPA7Wy+H1zo6lodnCv5QUUyXakATuO5BPkoZvS6QP9T6DpO3QjV2BtKpjFtBJuKLnAedQcyJ67FG/RddT+eySlg9QJq60/H7vGGV/u7jWLlJ5WfE46olL3F0fTZIhT46NlenCEXQN/8LbhUkdaXa1q+cyTO2YDqk6w4dEfwxhzUkf94W1pJyjflabgSeY1OKFAACWHXJcLSDaewrE0mKkG9UsdbLf7ue/JwKYqyroR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(55016003)(4744005)(41300700001)(2906002)(38100700002)(122000001)(110136005)(52536014)(316002)(64756008)(66556008)(76116006)(82960400001)(66946007)(66476007)(478600001)(6506007)(7696005)(66446008)(71200400001)(9686003)(54906003)(86362001)(7416002)(4326008)(8676002)(33656002)(5660300002)(8936002)(26005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zmk3N3VCUytWMVgxYkF1cldUa2hsZ0xZN2VwZTI4YjVNRjlPbG5TQjc0TlRG?=
 =?utf-8?B?WkFGTk5yRDhtTGRqb3QxZDNpMGlhR25QOHB6RjRlNENYYldWWk5SSU5XYXUw?=
 =?utf-8?B?aU1ZVUhmWm1sRHBPcVJEQWhUSEpKVVpJclhmd2hWbG9FaHFMY3Bocm5LQm1O?=
 =?utf-8?B?WWZCTnkxYlNkS0h6ZVQ2b25uTUFFRmQrdGNCREZtSlRUQVdJWU9EcUtzc1ZL?=
 =?utf-8?B?QURhVTZiOFRPcTlheDREaXRqZUJaY1lwQ1NTTkxCTWpyTzlLSWhPYm55dExy?=
 =?utf-8?B?OTVHYjZzY0p4Z09QUE4vczdiUVVCaHU4Mjl5R1dzOFhIdFQ0dzZDQzNtYjYx?=
 =?utf-8?B?a3IvanpzYk55ekdodyt4a2Z5M3AwQlNTYXVuRVdyQ0s3bjdpdWRjRW41VDht?=
 =?utf-8?B?VS9haTNzdnlRbzJ0T0kvcml4WHJOYmtGWnVkQnFSNHduY25lSDdRc1hBYjlU?=
 =?utf-8?B?NGh2N2dtbEYyU0QwYW9JaTlEZ2puWkp5cG5KQzB3U0ova21OaHl5UDZrWlJ4?=
 =?utf-8?B?eHZPR0J3MHU5MWs0Vnk1UXU0SjZLWlpiLy80UXNZQ21ydllzVDVIalhPOENx?=
 =?utf-8?B?bjZEazRoVWZ6emg1Wk5Zcm1wY3VneTNITDRtU0x6Rm9XcVlkeHhQUXlFdVhz?=
 =?utf-8?B?akQ1VVRydENuQU5IRVR3c0JDcHRsZXJ6SWxoUTFXUzR5RFhtSkUyaldRakZ5?=
 =?utf-8?B?aE85UWwyZzF5WnpqeFBlRUFOeDhXdHp0UjlRelQ3aWJvOWNqTHY4S3l6bk96?=
 =?utf-8?B?Y0lGSEc5b09CTmxnak5QOC93RHdQdE9jZjR5b3R6eWJRa1RqWjI0NStrMVQ5?=
 =?utf-8?B?NC9Xb1ZhV3dWNXRhbisvU3UyVFF4WjRGTHRUdzFSS0tiVUUzcDZzemErY0Fn?=
 =?utf-8?B?SWo1OTRJSGFkMDkrWGxxUXo1MnVIZFJpbTVqQWNGRnVzeVVETHBaL09zMnlp?=
 =?utf-8?B?ZjIxcG80cURXZmc4cHV1MGx2R2NPVG5QSWR3K1MvK05qK0gzMjFsaUtaK1dl?=
 =?utf-8?B?ZS81YWhrRkVyMUY5UHFMNjhCcWRiWHZCbWFMb2h3WTRISHNHa3hKazk2Mm95?=
 =?utf-8?B?OUE5TEFUMUEvYWVYZWtncC9xWUVUaXhMeXVlSERmYzE5QVFqWFluYlFrWHJT?=
 =?utf-8?B?RzZxMCs1MnM3c0RJNmt4bDl3ZUZ4TTJqb2tqOVNRWWErdHd1a0tQUm15RWxW?=
 =?utf-8?B?UnNuYy9OTzQwOEhTZndmdTErSzB0WFdrdDdVR2VKTlpGV2tJNlN5SCtMTFdn?=
 =?utf-8?B?ZG54MHZmNDNRVnFmQnQ4S2pWd2NsS0pQN3YrQ2pKVDkwUzYvS05TdXNpRUVZ?=
 =?utf-8?B?YU1pa0Jpa3hGa1JMVlc5SS9RbU5tcmVWZUozRzFDQysvbUJSQWI0MVpuczFP?=
 =?utf-8?B?MEZKajR4SlFDNzZYdjRBZm82OWRQTzJ4RTVSQVZyc21BRFJxVktPOUc5bnVB?=
 =?utf-8?B?TTEwcTI5S3J5bGY0UzczT3plSkEvVndSdFFITG1iT0xoWkpmNzVtZExnUWs3?=
 =?utf-8?B?UmwrekQ1UmtHR1Npdm9pSUJrRmFydDFoMlExUTY4WVF1aDdnTlFvdTY3QlQ3?=
 =?utf-8?B?N3k1N3p4NkR2TmZsRC9DM3VnYkJmWitEK1JKYUVuTzM3UDgveEY1NFl5QUtO?=
 =?utf-8?B?ZVBQNFpXTWFINUZlMERNdE9JaE4yQkFBSmlWdldHYnpVd01QMThkL3VGVTVm?=
 =?utf-8?B?dmlvaFZxdHFDV05BZDRWcFJUMDJTY2JCR1VYVGRLb0tLM2lWdGtNOGY5amdN?=
 =?utf-8?B?QlF5VkkxZDZCYUp5OENTSEYxUmdOZ3cxd0x4eG4yc2VCUThKV3hSb1RVUE1G?=
 =?utf-8?B?eWZYWjN6Q2Y2MUxCUm41cTVDcXRuaFJidGY2aDVOejl4M1Q3V3lENHlhVjRT?=
 =?utf-8?B?MWxGUVJQdGVyQ3JpVWtTU2lpU3Q4amJnMXBCK29ySlBiWUhqTm42bWF6REs2?=
 =?utf-8?B?R1dpY3NvamxzVWxGTDNjMmpiVU51ZnIvVndUWTBiUDhXYzdGdkJXSTY5eU1m?=
 =?utf-8?B?MHE0MFU3L2tpREZTV0FGS1RjT2hSc1dkdlNzdTdEamVlVzZndDZjRHpwNkdl?=
 =?utf-8?B?SVZmRlgzUVYvN2xWTzgwMTdiR1ZoV2t0c3RreXZiSmNibXlncUhuQW1jYWgz?=
 =?utf-8?Q?yuCcagG3WWSWkRYmuXT+etwGM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597c9315-e2a4-45ff-32b7-08dbd677376e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 22:59:32.1910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gi0EpnF4cNTLMW3tcc888NAPXNIXgrfeT+DIj4CxXNHfo0i03PBBnWAvx4bvx9SP1zGYo3T44gO37XdojTZIYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8006
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gICBzdGF0aWMgdm9pZCBtYm1fYndfY291bnQodTMyIHJtaWQsIHN0cnVjdCBybWlkX3JlYWQg
KnJyKQ0KPj4gICB7DQo+PiAtCXN0cnVjdCBtYm1fc3RhdGUgKm0gPSAmcnItPmQtPm1ibV9sb2Nh
bFtybWlkXTsNCj4+ICsJZW51bSByZXNjdHJsX2V2ZW50X2lkIG1iYV9tYnBzX2V2dF9pZCA9IHBp
Y2tfbWJhX21icHNfZXZlbnQoKTsNCj4NCj4gSG93IGFib3V0IGV2dF9pZCBpbnN0ZWFkIG9mIG1i
YV9tYnBzX2V2dF9pZD8gSXQgc2VlbXMgcHJldHR5IG1vdXRoZnVsIA0KPiBmb3IgdGVtcCB2YXJp
YWJsZS4NCg0KU3VyZS4gVGhlIGxvbmcgbmFtZSBtYWRlIHNlbnNlIGFzIGEgZ2xvYmEuIEJ1dCBh
cyB5b3Ugc2F5LCBhIHRlbXANCnZhcmlhYmxlIGRvZXNuJ3QgbmVlZCB0byBiZSBzbyB2ZXJib3Nl
LiBDb250ZXh0IGZyb20gYmVpbmcgaW5pdGlhbGl6ZWQNCmJ5IHRoZSBwaWNrX21iYV9tYnBzX2V2
ZW50KCkgZnVuY3Rpb24gYWxzbyBoZWxwcyByZWFkZXIgdG8gc2VlIHdoYXQNCml0IGlzIHVzZWQg
Zm9yLg0KDQpJJ2xsIG1ha2UgdGhhdCBjaGFuZ2UgaWYgb3RoZXJzIHZvdGUgZm9yIHRoZSB2MyBh
cHByb2FjaCBvdmVyIHYyLg0KDQotVG9ueQ0KDQoNCg0K
