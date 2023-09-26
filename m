Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E2D7AF3DE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbjIZTLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjIZTLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:11:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FD392;
        Tue, 26 Sep 2023 12:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695755505; x=1727291505;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pmky0pe1jsHePK5KUez0zz4vSK6gXJ2ijWsVbhWhca4=;
  b=S1jg8vIf9QE+fZ9PBVozbGIjWh2dAog5KYw0xB1EuP/tdScz81SL4lU/
   Gf3EzDiSrgeKK7cz0EbePZqiiZHPUsP1N/cfS//WNd+Eu9VVegK3ZQPLH
   0wGhHgVhFAZM2bGFxlCNk8bqwwypj8V+7xUXXmBWFbqBRcrTuC3bJFxud
   gKXr7JHcUSJp12clVPufbKXvbWBMFhEBPrr4sNjFcRWbq1pHRV5AX8tMj
   E4Y0LBUVQo5Jl83eowoBaJD1hwUAUFGiQ5J4XQeSII2U2HwlxzMklcs5j
   iNUSr5+7n8mpIacfd6CmUNmjZgbWr9U0SsjXFjninKQTGo9/VVXkfHu7Z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="467936727"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="467936727"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 12:11:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="742452600"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="742452600"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 12:11:30 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 12:11:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 12:11:30 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 12:11:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUsq8tlmPEILVNXMLICTUgHRUPZk56lr4tBno5qfufOPZ+RG1Q/bIlaCyzzdgAOyQr6ck3iQIBW+ADZD6jIoN+G+v9vUfJH0OJkq4lGXpGZm+Sh3BT+rSasM5uT7riGC3k42OUnM+KtKs3vkIoqicvArXiXJlQMzBbITAKLoOmELoHI0pozF8YWb9hZm8RouxllB19zo5NFnsxVh2jeN6LdCPTRnVU+ufqEIfGrM5pkqMdZPs1I4CbWZqG8JlxtiiL/9oOmhgiN2+1K9db27JOc/WzOf3tMPEOW/OEMzb1qbJXsYQnyS+k7NLV+m0LlBD+A8Zlf/HLPbRhFaml89aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pmky0pe1jsHePK5KUez0zz4vSK6gXJ2ijWsVbhWhca4=;
 b=FURD4zGPE0/zMfyaM8qxMi4Q4SeunoNVg1vZGMWZ/zrZB3LeoCVuPZEK2q0CG3UqnfUSf/J5g5q3LWDKBL4tN+ocMabnEprxjJbXAoxWHwqUJmUTTGHPnBgwY3Kyg6qDjchpo4MkVtqVzHplMRHtC5Mn1ojDnvcR7rFW/yMyZlk1mv0AlCWsFZ++cHU3EQGFrQ3iI09KbyT+J+dhJSzE4rVWlaWcgc4WuhJuQn0XDRlhcyqfkT7Rqy/kiW/vzV9BUHBJsXxcpzpHPIo2KeECCWuJp0TJ6odVjmxd6gGsJ8/ZliP8mgtdFPNvEyKVtHqYupHjy4oMiCDPxZFOYF//gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS0PR11MB7957.namprd11.prod.outlook.com (2603:10b6:8:f8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Tue, 26 Sep 2023 19:11:28 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4%7]) with mapi id 15.20.6792.026; Tue, 26 Sep 2023
 19:11:27 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "babu.moger@amd.com" <babu.moger@amd.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
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
Subject: RE: [PATCH v5 7/8] x86/resctrl: Update documentation with Sub-NUMA
 cluster changes
Thread-Topic: [PATCH v5 7/8] x86/resctrl: Update documentation with Sub-NUMA
 cluster changes
Thread-Index: AQHZ2tLPm03/QLAOkkSe+DrgrX62prAtodMAgAABZ+A=
Date:   Tue, 26 Sep 2023 19:11:27 +0000
Message-ID: <SJ1PR11MB60831009ACAC814C4F2A6072FCC3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-8-tony.luck@intel.com>
 <560710e3-ce47-db07-e81e-3abd61e6ffbe@amd.com>
In-Reply-To: <560710e3-ce47-db07-e81e-3abd61e6ffbe@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS0PR11MB7957:EE_
x-ms-office365-filtering-correlation-id: dfa98a32-e07c-44dc-aa33-08dbbec46287
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O/wI+q9+fRt80MUw9+oz9spvyPDjDv7MLmYVYXLlv7AWx7d/TxU4orgS3B4Hi36UDoqezn8dzrh1q4CR7G/8m4gqDqu6dhszzSa3XeqTuTybVb0UwMKM1I9TJ6MMsYObCDTJqojpzDqnGw07wAkRiSu9ned//B0LbbN8MDjZ/B0ZI0FF1noY8tF5Gv2P5qbsnzOcQLwarqBowTDsdafKH30jnxLWMq5niZDvcncYUkWxBZUvT5Ez9XJlAaZ1d7GNyWS4UlB/h6VzurAgLV+x8NPoeuxgMN7POra88RhKrqE77rO5ntUlLqb416UorBg2zEGtVix0D1js+IShnnc5jb/oKpoaCx3FO/y+HoxoS5mV6HYcLuxOhGOTaSWV59Lqms6N6LpWvMZ7H/zVyUh8Y+aT/zeMflRjxe4O9d30YSliA/Yao3O6fr/frxOCjMpuGgwEIKrcA3NwRrO0Nvo4no11OroXfVV7Ho7kD/Hu9EpwmWUtUheXLR1Cr8XvhNNsQMihSB232v0kjzzcXWm/1+CWqBgyNrO+RBvvq7ktp79Bbrbp8u5dbMAjIQFbUxzVX23OzvSN5qg6w76IyMyx+nrMOStM5nf+pFdtGyxRkmE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(186009)(451199024)(1800799009)(38070700005)(82960400001)(33656002)(38100700002)(86362001)(76116006)(55016003)(2906002)(4744005)(9686003)(66476007)(71200400001)(5660300002)(52536014)(41300700001)(316002)(110136005)(66556008)(966005)(66446008)(54906003)(64756008)(66946007)(478600001)(7416002)(7696005)(6506007)(122000001)(83380400001)(4326008)(8676002)(8936002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dG1JbThnSE12cDRpdFRwbFpnNGZvVmgxOURNWis2cXU4SmN1akNXNVo3ZnN0?=
 =?utf-8?B?WTVJTFd5THE0N3ExTkQ4ZmlHMkxSQ1NQN1BmOHRyWDE3Rk9lVjlzVSt1NnhG?=
 =?utf-8?B?QVY0WWx3UUZDcndSZDBRZzB5eHZ6UUZyTFE4UEpab0lRTmd2TEZnNTYvWk9a?=
 =?utf-8?B?QXlhMmZQSlZ0U00zcXQ3SVc0YWlqNXh6Y2hpa2lPcGxTMUp1eVFidHptVVIv?=
 =?utf-8?B?WkYyWWNVZWZNRzNyWFZzUW1vc05WNFZJUFVvSE45bE5JRW9jenZBZVYxczRi?=
 =?utf-8?B?YWFVQURPbGovTXFFRzJNMGNJZFRNWks5dUlPMGNpZ0R5YlRHVjh2bGl1ODRk?=
 =?utf-8?B?dTZYYnNEbWJmU00rY2FObmJJb3FDaE9wTGdaTXhVTFZUdjA2bW1iMjg4RDZt?=
 =?utf-8?B?R09PVFpnbEE2VUU0c2s0UHMzYmZTZ0J6ZGMzWTdaeW1VczZiYkFyMlQydm9I?=
 =?utf-8?B?MnRRL1lzVGxVMFpGbHFwQXJmYVRtNzhVNXJ0Wk5JSDU0RWtHZjNMQ1hRbUJ2?=
 =?utf-8?B?WWV2WXZxa01OamNHTnYvVHljMkFnSk9TRVY5QWp1a3ZqOHBsYWdyK0k4RURE?=
 =?utf-8?B?bGhQZXY4WHZmZlRuM2FyU2FQQ3VFRGR2Vk9CUzNLTDNVN0JnaEdUeU5PTFl0?=
 =?utf-8?B?MFJPNEM1K0N3dlRIeGxGNHRxUjZ2d2c0UWZVNnc2V3VWV3hocnVkTXVtZy9O?=
 =?utf-8?B?RUo5dXZtZXBmSXVKc0l3U0UxOVR3UlV0Z1lSbFpqV2RqRHl2SjhlaG5PL21K?=
 =?utf-8?B?K3RYVXY0T2NMZERvYjE0c3NvYWxOS0RUUXgrZmtWb0FoTDJTcEJ5SVJJU200?=
 =?utf-8?B?bUxsQ3BaUTVUVzRybEF1aFlUaXVBT2pxYUNFVWgxNXIyL1BEQk92cUE4ZnQ1?=
 =?utf-8?B?VEx2UDhyNWttb0N2eGxtOGVyL2pLZFMrL3NydzJKelphTHc5VEtSN1RHYkFQ?=
 =?utf-8?B?OGN0WjB3SVZzQlZ3RzVVQzZDbktXOXRvVm9ZLzlPck9rSWdZS3l1VzNvd1Vn?=
 =?utf-8?B?M3NMeklrT0F6MFdJZjErTWJybEEzTjlydFZXalNmT0hQbklsRHhKVmFuek1v?=
 =?utf-8?B?OUF0NEcxWjJoaURtOHI0c01pR2NNbkhxRVUwdFkxQlZIQ1A5WVllZXd5VWJ0?=
 =?utf-8?B?Y09ySVhqOGRmNVFIZEp2bE9lKzJSVEtkelBoM01RSTJ4TEg5QllINktIL1M3?=
 =?utf-8?B?WldnaFUxekgxM0prOXYzMytBSGt4YWRsZGx1SnhacTNlYUJjUnlVZ3VGc1Zl?=
 =?utf-8?B?QmhMNHJiSThjRlhtM0FxZytJb243bk4vWXBrWlV1ekNqSmltVENxdS9RN0FC?=
 =?utf-8?B?UHR4azhxaFhEd0s4R0JtNENOOWhQRnhUTUpLekpiMi9Wc1pYdDZDcm1jZCtP?=
 =?utf-8?B?aDZpQlB1WnI4NWRhaGVMV1BZOVRLcHh1QU1NWXNkZ2dGYzBEZStrQkozSkJx?=
 =?utf-8?B?dWFBa2hwbjE2YkFLMVhGdXpnZFBYdDEwVEt5Z2lJM0gzZFA3cVZhNTE3M0VJ?=
 =?utf-8?B?SU1OTVpGRTZBRS9oVkx3OS8xV3ZZdDRwWng2MldKbXl3ZFMwajA4RzIwRm9U?=
 =?utf-8?B?V1A1aU14UVh3MWVXUmwxZG1GT1Rac08wOHM1cUM4T3laUWw2bFFwUTJLNkN6?=
 =?utf-8?B?SGwwNmxKNUtNVkFKSnV5S2tqd3NpdkkzRmtteDlvZFJJTWdSR3I0MnhKb1lR?=
 =?utf-8?B?S3V0ZXlrdXAzajVmQTUrUFEzdFZUaGFEUDlQNlJQWnZMcWJtajkrZHNkZDBD?=
 =?utf-8?B?dW5OTDNPU0E3RmFlU1hVOWpOVklZYzBCbmV6S3RzNkhoczdUSjdqTFRmSFQ2?=
 =?utf-8?B?Q1NUMG8xOFdPOWgxVE9TVVBmS2VvVmFwZSs0NW5xSkNMYjIwUXJQY1VkSVpJ?=
 =?utf-8?B?WitBSEd5NFB5amRCUjlKdGk2Ulg0c2JibVFYM0d3TUI5WnR2bVgyZ1BqR1Rq?=
 =?utf-8?B?a0pxSVJuQlZQY1NRUkVGeU5xQWtxZUpqTzk3QWNmY1VESmFBTHJ2RUdTcG13?=
 =?utf-8?B?ODhPdnkwaGQzdlY2RHpnVEpYTjFRV1N0VWVzU3lMY1EySXFvRjZIZ1V4N0xG?=
 =?utf-8?B?WktHNExjbXRzSTM1dnpmSjBHMFBzczh5YUQ0WWd5VWlZeUsyT2xEQTdyNWJa?=
 =?utf-8?Q?bQyHZ0H0CRIMP4P/EMhqi4Nzg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa98a32-e07c-44dc-aa33-08dbbec46287
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 19:11:27.8432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pvHj1yeVml91lA4Y1/+OFQvJd0ewexYDucNF7lMXkZQQBNXVnxDTZpYkw4kqgDWiaKueJKUhfKqQrlR8K2UlGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7957
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIb3cgZG9lcyB1c2VyIGtub3cgU3ViLU5VTUEgQ2x1c3RlciBtb2RlIGlzIGJlaW5nIGVuYWJs
ZWQgb24gdGhlIHN5c3RlbT8NCj4NCj4gRG8geW91IGhhdmUgYW55IGluZm9ybWF0aW9uIGluIC9z
eXMvZnMvcmVzY3RybC9pbmZvPw0KPg0KPiBCZWxvdyBkb2N1bWVudGF0aW9uIGRvZXMgbm90IGhh
dmUgYW55IGluZm8gYWJvdXQgaXQuDQo+IFdvdWxkIGl0IGJlIGJldHRlciB0byBhZGQgdGhhdCBp
biAiaW5mbyIgZGlyZWN0b3J5Pw0KDQoNCkJhYnUsDQoNCk15IG9yaWdpbmFsIHBhdGNoIHNlcmll
cyBhZGRlZCBhbiAic25jX3dheXMiIGZpbGUgdG8gdGhlIGluZm8vIGRpcmVjdG9yeQ0KdG8gbWFr
ZSB0aGlzIHZpc2libGUuIEJ1dCBJIHdhcyB0YWxrZWQgb3V0IG9mIGl0IGJlY2F1c2Ugb2YgYSBs
YWNrIG9mIGNsZWFyDQp1c2VyIG1vZGUgdXNlIGNhc2UgdGhhdCBuZWVkcyBpdC4NCg0KaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2YwODQxODY2LTMxNWItNDcyNy0wYTZjLWVjNjBkMjJjYTI5
Y0Bhcm0uY29tLw0KDQpVc2VycyBjYW4gZmlndXJlIG91dCB3aGV0aGVyIFNOQyBpcyBlbmFibGVk
IGJ5IGxvb2tpbmcgYXQgdG9wb2xvZ3kNCmZpbGVzIGZvciBub2RlcyBhbmQgTDMgY2FjaGVzIGlu
IC9zeXMuIFRoZSBvcGVuIHF1ZXN0aW9uIGlzIHdoZXRoZXINCndlIHNob3VsZCBwcm92aWRlIGEg
c2ltcGxlIHNob3J0IGN1dCB0byB0aGF0IGluZm9ybWF0aW9uLCBvciBtYWtlIHRoZW0NCndhbGsg
dHdvIG1pbGVzIHVwaGlsbCBpbiB0aGUgc25vdyB0byBmaWd1cmUgaXQgb3V0Lg0KDQotVG9ueQ0K
