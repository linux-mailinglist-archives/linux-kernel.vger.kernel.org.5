Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B4078F606
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 01:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347793AbjHaXPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 19:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjHaXPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 19:15:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D546BE8;
        Thu, 31 Aug 2023 16:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693523749; x=1725059749;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+CyQ/AksJDt3A3I78a50JEKdcNAqZS5Xsvovzw/Swkw=;
  b=eYR04XGGHZemr4YQxj7QHOAuED6J4hpFHMo4X5MAT+0X0r3kPABHczNo
   TAvqlH8AjQpGHi2f9XlwzWTVUWLa81RnqEBP+isMupECvZmd9HkctjJJW
   pA2B3sJRxdi5OYfa7LxTYp//U91NVe0EuVZ9iW2yGjjQkB/uTbJmt4iiY
   Y7+KlAfIi+nUSP67r3ewoOtK7KmzNc/xE9lgkEINSIAtDh5s7D4pBBEe+
   FkGY4rzJKenwSF5dNtyFo8LKr1nDmk1fvtxr0z7PNnrKjrIRqM+Uv2jgE
   S7kXbT03lEJcJeUUTHMUHHI/HLXQcnWgcMIO2zgNHmPQB0LytZfVrUDbP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="373486970"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="373486970"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 16:15:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="854469085"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="854469085"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 16:15:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 16:15:47 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 16:15:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 16:15:46 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 16:15:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpDVDMroOOURoIiCRjknE/ChM4Ouqbh8w6ahdm0RA+vgfwXULfLdH+3xCugi90sCK8PhIkDYXC8cWFfrWP8nftX6gGqLPDf56LTq8EFPYiOe8byEMmKK7SRo4vSvaYtg3OWWyngB+XT6LNQC14xFK4yNtBNdOsrhJwXU38h4miuKYbYyWT/6O4fx+S+tLw3mYtE31xVGPV5YTFl6EzIelIltP/yuKu9IlVJzwg5XA5Y4P3RBSTqKdkaDhpFJbRTHpm1SfHuXbVahYbLjHDlz5Xdh2XydUqsBUXHE2YV/S7o8jfYjIUEHh99IXSPtd2yH3JPjPK4J5Fx2KfF+nmw2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CyQ/AksJDt3A3I78a50JEKdcNAqZS5Xsvovzw/Swkw=;
 b=nlsJCj06Pbjg662luSRq0g2w5u4wkIiwghVWPDbHeLSfB5YPvjLIriDefG//SNiNKVY3dEInxwFu/0hQpvMys42iUGgA+5edOIj95LCuJ5Ztmfm1BlJ2Wq5ORo30HAKf/eKmqJmvd6gXS4FBsrk8M8PS1cTYUBUcEOI9BKa8F80rAOFalWrpuU1DrIl5VBI3Cwi6KK89CU+gj9WJPKYz8NSc7kNe42Px3wW4lWcPvtdQtbkmdkNhWRnyuds7AqdnWov6mfmnFgSqX1lOR31aMmrJ0iM3jgxAkwr1zh6roGGYG7XGZmFJeJVuxNfMC64uhi97ImjeGhQkWY97CfmrAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5279.namprd11.prod.outlook.com (2603:10b6:5:38a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 23:15:43 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6745.022; Thu, 31 Aug 2023
 23:15:43 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Van Bulck, Jo" <jo.vanbulck@cs.kuleuven.be>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v5 05/13] selftests/sgx: Specify freestanding environment
 for enclave compilation
Thread-Topic: [PATCH v5 05/13] selftests/sgx: Specify freestanding environment
 for enclave compilation
Thread-Index: AQHZ3BD6tSTC+BCPVk2S9HyAviRHFbAFCfyA
Date:   Thu, 31 Aug 2023 23:15:43 +0000
Message-ID: <ae25b34b901b8cee6e6e186fe5ddc739baab1db1.camel@intel.com>
References: <20230831134144.22686-1-jo.vanbulck@cs.kuleuven.be>
         <20230831134144.22686-6-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230831134144.22686-6-jo.vanbulck@cs.kuleuven.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB5279:EE_
x-ms-office365-filtering-correlation-id: 2d4085d3-690d-4fc4-1589-08dbaa783365
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bPiBm7fO8FcoOzvZe0HCqA8Tbh8p0cCzLZ6g2z7NHiX23J2nAQSViackNbo1olSqtYEtRyWlWnFhTn7Kg1LUsC+1VVr566uRephVby9/NpBxKHMSYqf3Ea9MfMs/bcXJa+WLrX0kpt1Q5Z77YuDZS5IRaJczTYExB+dtec05zCLSgiq7c6JbUmt/iraYk6wVcynswrwyxJLxwxHXjktNch6OjMInG570JIkN4VJTQsE3PHbdhwZ6awB+BRtU53SruYhcONgXkvQ3ApkI5HXRwxP/duGeOyA5dO9m4gZep0qNYpAkIRBO1xYbOcQMmoea7XcRYCehUZfDzCKlJT7debhV+figw4IkXzrzaIoeprNnnrcbdkQXxarjps6nWPwfXqrxISsLCwIjFPFcJFgzEKr4PiRiJbMzm/r9gANcZuWwrdWmPGHIkkvp3W34LNfyO2mkwpdFOpqi15YSPxSn0HdoY2vWEoeTr/z1hXO0ILjjPNIxbA/NjKUlar6cVk6h6woRBiBdqjlg34NyHdc9JMAVAnASwtD4xNzo8BfhlbJNByzV+yOoWLHlg46n0C29hbk5cya6/5BYBr6vGXtR/OmWzcYQUJwinDKuhvcPnmAYmNvPRGN7gZiP3js1oB8h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(1800799009)(186009)(451199024)(6512007)(6486002)(71200400001)(6506007)(2616005)(2906002)(4744005)(26005)(66556008)(41300700001)(478600001)(316002)(66476007)(64756008)(76116006)(66446008)(66946007)(110136005)(91956017)(8676002)(5660300002)(4326008)(8936002)(36756003)(122000001)(82960400001)(86362001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejI1V0FSZjBSUlZ5RXhjM3htTndlRzN2cW1iTDJQTnJrVkV3cDd6MUZ0YXNM?=
 =?utf-8?B?Mlp2OVBNSUlHYjFlQk9mOWhNdmpMWnEreFc5Mk5zS1hlS3ZkR1RIdnBaa2dS?=
 =?utf-8?B?RkJScmQ0ZTJ6NkxPWFNON2c5MjZ4Z3NTM0RacmZUTnZEeC9XMy92emVXWlJK?=
 =?utf-8?B?SjFDSXVpVUh4NU9raFFMVE1uakR6dnFYRFB5NjZvZnUrRUZIOVFDZkVWMzgw?=
 =?utf-8?B?OFpjSG4vZnBGa1gwVERUeGlWS2ttUi9HZm5NYVVjejJkSEdnc1RxV3lKbHJ5?=
 =?utf-8?B?aUI2anNIaWdCc2REZmpVMnlqRjZzVUp5NG00ZzJjVVhCL2VLU1lKUWRrekpk?=
 =?utf-8?B?SlQybnZLQ0JRTHpzWVFJdHplRVp5YkhqL2hjSW0xV05tRHBoOHlVWCtDMUtz?=
 =?utf-8?B?bUcrNCtHQk4vaWI3WjRVL3hETE45OVR2VGtvcTZZVlZQR3RGM2VQS3lRWEtv?=
 =?utf-8?B?S24wdHhoN2ZYSWllL05va3RndHlpUkJ2eHRya3Q1VjkyMERYYThLS01ZYkQr?=
 =?utf-8?B?N3psLyt2MUwrSCtrcHV3WTgwTzNyK3VhQlU0VVozbC91L0ZhOEh1TkZydGlm?=
 =?utf-8?B?amVxWGVWdzQrWUJlYWZJdzZ2ZFhDdkpSRWR5aXljeGgvalh1Szl6Z2kvQVdZ?=
 =?utf-8?B?bXMvVTZESmU2dUp4ZzNGN1l2SW1kbnRibmE4VzUwMEpxYmw2NmdxamlLZWx1?=
 =?utf-8?B?VDZYYTBwWHNRQWxDNmRLcnBvMnpVblF4V251NlhZcnZLL2hCR3Z2aFhvclFE?=
 =?utf-8?B?eWJPUkt0N2dBalRwWXk4YmFzYUdCbjZTTVAvejlQNko5NzdDV2pPNmFNVXEy?=
 =?utf-8?B?bU1nMlVkWDBkRytEUlVSVUhRWW1KN0RjNmw5YVFqNmdEY1EzZnY1Q3FEMVFE?=
 =?utf-8?B?WENKbFVuNTVsOUtEbGdLUytQd3FMd1NHOWorRUMrbUZyYjdwblB6OXpDWml3?=
 =?utf-8?B?OElSVXhoa0xtMmZkZnkvWmhnNnlqTUtIdCtRU2l6YnVscWQ0N1F3bC9OSCtU?=
 =?utf-8?B?R2FwQzZYTFVkVDdQditJM1lwMXV3c0dZOWNjZXZ5eUNuejVwR2M3V2YySDdL?=
 =?utf-8?B?MUpYS1FVUkxxRGtVK05RTkJ3a1hsNktselB3QjlZbE9pVzZDSVZDWTNCQ0kz?=
 =?utf-8?B?R3lRN1paajF6alRCTTQ0SHVYRzBKNmRhb1crQ2RPSTFYTkIzZDlmdXVEMW13?=
 =?utf-8?B?am9NajRTOU5uRFRDODhkNEZ2cGxBaHdBZ3hZNkN2MjRJTDAvUkM2Zm91YndW?=
 =?utf-8?B?Q0RaWUZEQk9OYzVKOUU0bWVsRTN6THpaZWVyWjFXNTRKRVFxd2V6eWNHOE5S?=
 =?utf-8?B?YjZFRy9rRTZ5VHlBNTlOL2NmSXlZcWl0ZCtmc05qdnppL2loajhyYUYyMHAw?=
 =?utf-8?B?QmdWRUVIMGppZU5nYTZ1dklnd21zSStKZjZ0SWdieUxSUnVLbVlWS1NmTTdr?=
 =?utf-8?B?U3dQVkRHaVV4OUlLQzg5aVV2L3BwanVyT3RjMklBM0tVTnpMTWVBby9BMlpF?=
 =?utf-8?B?cWNPdS94ZXF4MjJiNksyMytYUjhSYWppeUJlWUZ1c2tWWU56Um1CT1ZycFc4?=
 =?utf-8?B?dlQ0MkQ2U2lsNWFZTXExR2k1dWhqSDZwSklTZTNOYysrOXU4T3Jaa0RDUzU3?=
 =?utf-8?B?RnkxRmhHaVlzbG4yWnl3MUpqTUh2SWVETWw5OEt3bXdRTGZJa29vczVVS1NP?=
 =?utf-8?B?aXc0WVo5MWkzVDVVcWtFWUZUZklFdmFpWjV5L0FwUEtTZHBUcXdhTGY5L1ZG?=
 =?utf-8?B?NE1KeDNEL1dZM1MzaGV6S0ZvWUdHdGQ0T25PZHhmelV4STIxeWNFRm5RcURm?=
 =?utf-8?B?VEd1TXA0bUM1OXNXN25tMDRKcGhlTkNPNUt5QXhXZEhBZUpwZXB1aGIzOG1L?=
 =?utf-8?B?UkMxN3JlcHFnUTRvemRQSlJITXBLdnZQK00rUmp2MmdlTDZhTmRxRkt2KzlK?=
 =?utf-8?B?TXFYODE1SXBxblBwS2FvcDN3dlNVT3dwTnNyclowaWdLZC9ZalpTWjl3aVRx?=
 =?utf-8?B?TnIybHgrRStiVWlhdjFYSjBKTFJPbUVRTm83dDVMRXRuMjJMSEpraFVFRXVW?=
 =?utf-8?B?VTU2dCtUd0RzNTNiOUoxRFUxMVVHenF4cEhQTlZtS2c4N2Nod0pBa0JEbE1l?=
 =?utf-8?Q?8DrCQgqwk9USIkzSS+pmXNG4e?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBFDC7934795734A85E2099ABFA50C08@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4085d3-690d-4fc4-1589-08dbaa783365
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 23:15:43.7503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yGJ4gSEotz+HxR09TAJG+j2i0h3Y4lJTnWyOYhZzqgzY/vilroirljjEmxSFhpH1JLa2GQ5qsG/NApHaUwdE7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5279
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA4LTMxIGF0IDE1OjQxICswMjAwLCBKbyBWYW4gQnVsY2sgd3JvdGU6DQo+
IFVzZSAtZmZyZWVzdGFuZGluZyB0byBhc3NlcnQgdGhlIGVuY2xhdmUgY29tcGlsYXRpb24gdGFy
Z2V0cyBhDQo+IGZyZWVzdGFuZGluZyBlbnZpcm9ubWVudCAoaS5lLiwgd2l0aG91dCAibWFpbiIg
b3Igc3RhbmRhcmQgbGlicmFyaWVzKS4NCj4gVGhpcyBmaXhlcyBjbGFuZyByZXBvcnRpbmcgInVu
ZGVmaW5lZCByZWZlcmVuY2UgdG8gYG1lbXNldCciIGFmdGVyDQo+IGVycm9uZW91c2x5IG9wdGlt
aXppbmcgYXdheSB0aGUgcHJvdmlkZWQgbWVtc2V0L21lbWNweSBpbXBsZW1lbnRhdGlvbnMuDQo+
IA0KPiBTdGlsbCBuZWVkIHRvIGluc3RydWN0IHRoZSBsaW5rZXIgZnJvbSB1c2luZyBzdGFuZGFy
ZCBzeXN0ZW0gc3RhcnR1cA0KPiBmdW5jdGlvbnMsIGJ1dCBkcm9wIC1ub3N0YXJ0ZmlsZXMgYXMg
aXQgaXMgaW1wbGllZCBieSAtbm9zdGRsaWIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKbyBWYW4g
QnVsY2sgPGpvLnZhbmJ1bGNrQGNzLmt1bGV1dmVuLmJlPg0KPiBSZXZpZXdlZC1ieTogSmFya2tv
IFNha2tpbmVuIDxqYXJra29Aa2VybmVsLm9yZz4NCg0KQWNrZWQtYnk6IEthaSBIdWFuZyA8a2Fp
Lmh1YW5nQGludGVsLmNvbT4NCg==
