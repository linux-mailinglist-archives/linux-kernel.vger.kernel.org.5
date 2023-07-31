Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3C976A43D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 00:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjGaWl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 18:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjGaWlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 18:41:24 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE29719AA
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 15:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690843283; x=1722379283;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=btuaFjZQUIR/d2WbHJzSsPV3wWFcAcWMp0nJQInnQAw=;
  b=RER53f7kKW6whvbFzV8EK4iGCSzxv2uVIYHJqsICki6IShchCaVqSZ5X
   mjhckParBMqvEl+QbZiiGaEH7pBCEcXUwp0nTjc8OJtNXv5DVQfahW1Mu
   4v9hxwwLqDkG8GsrSfnDFnzlCBEQdoVl33tqcvbWi4+OlPOUybvmAlAFu
   R62GJuV2I0yW9QO8j3PIObyBx6OXXg7wnD5bWX9jviWHiqkWPfLFokW29
   Y59TLveGCn+UOXuATyH2xNjG0XJPvOjf6RUod5tgaAW4aOpqPR61yHGIO
   IzHWn61S5AQpQ23SwJjNnTmc0+Bq6IAJIpJpxfTjC0i0LqMmknnqpp4rr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="435463120"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="435463120"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 15:41:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="705595615"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="705595615"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 31 Jul 2023 15:41:21 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 15:41:21 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 15:41:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 15:41:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 15:41:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QI07uE4acPysQxaanzCEDjeLE40INsrBq0/08+1ZvBsezMQckOZ6Ik1zrpCDXB7cl+ook5vNCJYavuOGYjQ5/z+/5taZzoXcrR8+6HnFYWZXXgbGECaYarPfjeSabxSOOnzGNcgMxlLzwF36lP4EVdPREWWwobbRSAbj8FHbRVsa1sJOU0+xFnAds62CZzjFg2rj3YS3H6d/MQGMQW4qG0ySsrh13XRQ7e32smNiUCvcU+FggVYUNLBnglo5c0AVfIhVrTBYk6rq4Q4pQvRHOdOHTJvqLJWRDzH7DkNF+b08+nmVRSDwSNKd0AxCsYPpB2UVNG9uE2UPq7m1J3jwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btuaFjZQUIR/d2WbHJzSsPV3wWFcAcWMp0nJQInnQAw=;
 b=FFTjHsusu8EDP755YLt/CEXTvGmtKO0c5ANsuCzl+ZqabbYKHwkgb9H1iKxiLrQaONT9VGYWWs/8Cj9JbnZlewFfE1IefH950eGi0gJShaSSjlOj+D4Sq/aw47gK5JZmiYo+DvTqkcdmAV8aVtoc1dQuNL/f+xtBmbBXiemMydh+iC+XZCU0OkW8gbPCPTq+H4C8Gs32wMOe9Kvgq+1vXaODUHMWVsy0pERg9N6bB4DrQqnl1W6K/zxuBOgXE7weK9nX/MbZwXqV0fApOZflh/PCcR6odLDCGOHRcFCfd6PquA9TuUzz38/fQjwLfVou44m2qFHzVcGIZpLBIuAZ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MN0PR11MB6085.namprd11.prod.outlook.com (2603:10b6:208:3cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 22:41:17 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 22:41:17 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
Subject: Re: [PATCH v3 03/12] x86/alternatives: Disable LASS when patching
 kernel alternatives
Thread-Topic: [PATCH v3 03/12] x86/alternatives: Disable LASS when patching
 kernel alternatives
Thread-Index: AQHZxAAep6oXe5dBm0qRkHwHAPnX5w==
Date:   Mon, 31 Jul 2023 22:41:17 +0000
Message-ID: <40ac9a487c723eff9eb069a5795760b1caf02f18.camel@intel.com>
References: <20230609183632.48706-1-alexander.shishkin@linux.intel.com>
         <20230609183632.48706-4-alexander.shishkin@linux.intel.com>
In-Reply-To: <20230609183632.48706-4-alexander.shishkin@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MN0PR11MB6085:EE_
x-ms-office365-filtering-correlation-id: 4259b0ab-eb8a-471a-1f10-08db92174120
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 21dYgn8IF1dIWr9O/X3Pf5LcIbL9iaOgVEBmaFFEUOzgt+uDs2mzrOv6ukPzGyek1Vb8BfeVISNhn16ee/1qi8yCIlbi0r7ssQyidEyLYb1zAwiDVLwEcaGQWcGlljfIkhysYyfWhNiAYVcGWJWB/kjc7AZmY7WQNHmjsz9owfx0n5row/1jNxtusqCGe4zm53ybP97BWjAqaD04mj51y+Ezv/7+ml9pc/yWi/6MHVa0BwAw01XEGticYZY3eMZuuiggpP2NTpNddko5zCC8Qj2WFrswHmYCuhVkaog8K8Ss3cYSk5FIYAbSsh2GLNxe8JK1PQWE8ME6Sjnj3D9HfEwFZSKl69RGRKunUCWG/q2FJsE2b0Vrr5LK2Iug4wkoeWEe78O7SW9NJqs9xaIqFQrhF+7POCqfxr+Wpxos525LaokEyu1Sqf60fbUufmiEf/pwTtsZgLcKg4EWahPOv7bFkFCPb+ozYnRPrjZajWyxd5at1reY9EHyfNJGdJeECfsfVRpQ9cG5DixZ8EpRYNi40KscjZ2fQcOi/eYIHU/6O/Fh/mR7/WX7nUdv5Ij/JeXgZVYeksbYGFenhcgweq79S7akSr2Aiprte9hBz9b7ORKxUpqyvX/emyc3Ssjw9vgAs2AAB+10548sLx2hRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(36756003)(478600001)(38100700002)(921005)(82960400001)(122000001)(86362001)(38070700005)(6512007)(71200400001)(6486002)(2616005)(186003)(8676002)(26005)(8936002)(6506007)(5660300002)(91956017)(76116006)(6636002)(2906002)(66446008)(64756008)(66476007)(66946007)(66556008)(41300700001)(110136005)(316002)(4744005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVNvSll2bFA4bTJpMDFQQXpqRE5BRHN6T2hKN05sYVNpb2ZBYzFSYVNzSkRB?=
 =?utf-8?B?b2d4NmhrakJURkx2Y2RWREdqK1U1Q09sbmxXSWI4UjZCSXhCVU1KY2RXck1E?=
 =?utf-8?B?Nmp0S2dPQklBZGQ2K1pvLytWTlpBWm5sdGxDOWR3alFCTjgrZkVIQTdqMk5w?=
 =?utf-8?B?UFZDTkllOThVSzNNKzdkdWFjZXFGakF1b3lUeHJpNFJWbTlScHlpZ0VZdDY3?=
 =?utf-8?B?b0l5WGFTUDNxNWpHSDk3RXZKYU91UGJRSkR4Tko2SFRHVUUvdHNhTDF2cVdh?=
 =?utf-8?B?WjdHUVRvNXJwdDQwWmRwUytFdXBndjkyMTlaZk85dzlqbGpmVmJmZkNSSlRD?=
 =?utf-8?B?TWxDbWs5eE5DU0R4VlRyQ3RnUWdCRkVUWnBaaXJEbFRoQVlreGNmR1VZUFkr?=
 =?utf-8?B?MVo4UDFYNEE0RFJjQmVJZWVhK216UlRyMkIreklqYnJFeUtjZy9UQXY2SWts?=
 =?utf-8?B?ay9wTEg3V0NkditSVk1TNU1MVjB1a1RVOHNiVlU1dVQxbDVQcnAvcUpiOFRs?=
 =?utf-8?B?UkZHT1MwaUNsTERtako0eTNwRE4xTnpQMTJOZXZ0N0Vrc3MzamZZNlc5clNR?=
 =?utf-8?B?ZVpZR3VCSFVTT0psbE42bU40SHBBMFdQMDI2bGtqZjU5K3l6WW9lVXdnWjBN?=
 =?utf-8?B?ckkvcHgyU0pSeWJWWFRRR1BYLzhmckh2ZnBMOG5MaGttU1RkYW1JTWpJcWx5?=
 =?utf-8?B?REk3Q0c5VzZJN1BTQnU2U2RZNEpGN3N0cm1yOGhQT2o3SllZUUlOZnN3ZlJk?=
 =?utf-8?B?RjBBa1gzZkpVVjZNRXBaelVmZ2tRTnE3TnhZbFJtSW1OU0JvZ2d4QzdqcDNB?=
 =?utf-8?B?MkE1UWZyMnZGSVpBdkY3b3ZHN0dGMmoySlprRkJQdXVnVm5xVjRqVmVSYzdQ?=
 =?utf-8?B?YUdiRUlwNTQ1WGNiSlBMdFE1RVZHMVkwU0JRWnNza2Q0M0d5eldUMUxEcU5L?=
 =?utf-8?B?QlhTeHkyYmtnbzYvQXBBUjg5d3I3bkVXeUE1RUtEWVhTTElpOXdLSWp1aVFm?=
 =?utf-8?B?dHZOT3drTitmM2REbjNVcms2aXIwaWVHU1I4bGpPbXF1NWJNeEpKTnFGUFNM?=
 =?utf-8?B?MVpJK2l0bko2bWZ5WitObnVNR3RjbWgrc2Y3TlNJT2RNY3FpOStTWDZaQm5G?=
 =?utf-8?B?enlFbWlzdHlkN1JMeC83d3FyRUJCU3Y0VFVialpBMThianNMT2UxQ1FWZ0gr?=
 =?utf-8?B?YlY1UFNxODRHaVY0VVZVcHdBRmhFU0FGUXhwUC91bUNqUHAvQmRxRjE0RS9w?=
 =?utf-8?B?SmJmMTZOQ1FvbnI5L1hKbmhMeHNLd21wRFVuL3laQjVMek8yTFJqVlRiVDdk?=
 =?utf-8?B?ZDliU1pRQVQ1cnd6MVRyRDArSmpZSXYvUTdERWxRVGZ1T3ZHclh0L2czWG1P?=
 =?utf-8?B?RHJkeldhOFZ6MXoxa2x4Wi90YWw5S2g0UzIrbi9tSHduQmcvRDdQUkhpWFd4?=
 =?utf-8?B?TXUvczdlSDZYMzVIazdKcUF5c3BxeFZYWGdYd1BpZkhzTTNONmR1akNQbkxS?=
 =?utf-8?B?QktmVEtlckFtKzJ5OEhUK1RwNWZYTEl2MFpJSEFqZStiakp0b0toK0lwUXV1?=
 =?utf-8?B?cDg1a3hSZ2RHcWJMMzhWUmp2L2hPU0s0NDN5eXRjMTVCSFJ3a3RkT3AxUmZ3?=
 =?utf-8?B?R01tMjdzNW9LK2dkNVA0NEFtdnBGb1NKZk5VdXNNd3paT1NCZ1dZZHFxN3RG?=
 =?utf-8?B?QkRHNExocnF5ZU8xSXNiRHk5WFI2amFOZ1Zud2NVZlZwMGF0Nzl3cS9XanQx?=
 =?utf-8?B?NHFISEtDTWo5UHFkZjRWamplWURyTlQ1M3ZpTkhYNldzNFdVWkRFbHBmYlE0?=
 =?utf-8?B?Y0ZTSmV3M3BmUkRpeWN6OUhtbDNxeVQ5bGtkcEh4djBkb1hhSUo4Nlk1UG51?=
 =?utf-8?B?ckRUV0I5Q0FSam55c0k5NUZBUE1sdTdPamx2cm5pSmYzemJwa0k4Sys3VHJW?=
 =?utf-8?B?SXU1cUltSUhoS0d0RjFUb211eGlkRUZYVXM4SVhyUkFVbnlvNXFnUlNteSsx?=
 =?utf-8?B?VTR3U00rOEtBRnhvMnJTZCtQcTV3U3Zld29oWlZKSW5UNys5SHJIcTY1bmJT?=
 =?utf-8?B?TE1iTVdwR1FsQTl3UlFXTkR6aXp0eVltMFZxZktwQmNjM0lQVmZHc1VHMzhN?=
 =?utf-8?B?KzVxZ2FRajIwTVhNK0tVMjhsbFhjZVQwa0h3WTJZbVhnUURUV2pMOUQvTmM4?=
 =?utf-8?B?QkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1095439D3B35D14DBF417E0F3BBBB51B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4259b0ab-eb8a-471a-1f10-08db92174120
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 22:41:17.7299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VIyJwLxTsIi7DM2MUeA6DqvTj/N5OCSv1zLQtqTOqmhdf3dyG3OBeUvaT/Thal0GRox0vwFGW31NZPxKGhq8ZZBJb5ecW5X3kteshz+Ml/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6085
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA2LTA5IGF0IDIxOjM2ICswMzAwLCBBbGV4YW5kZXIgU2hpc2hraW4gd3Jv
dGU6Cj4gKy8qCj4gKyAqIHBva2luZ19pbml0KCkgaW5pdGlhbGl6ZXMgdGhlIHRleHQgcG9raW5n
IGFkZHJlc3MgZnJvbSB0aGUgbG93ZXIKPiBoYWxmIG9mIHRoZQo+ICsgKiBhZGRyZXNzIHNwYWNl
LiBSZWxheCBMQVNTIGVuZm9yY2VtZW50IHdoZW4gYWNjZXNzaW5nIHRoZSBwb2tpbmcKPiBhZGRy
ZXNzLgo+ICsgKi8KPiDCoHN0YXRpYyB2b2lkIHRleHRfcG9rZV9tZW1jcHkodm9pZCAqZHN0LCBj
b25zdCB2b2lkICpzcmMsIHNpemVfdCBsZW4pCj4gwqB7Cj4gLcKgwqDCoMKgwqDCoMKgbWVtY3B5
KGRzdCwgc3JjLCBsZW4pOwo+ICvCoMKgwqDCoMKgwqDCoHN0YWMoKTsKPiArwqDCoMKgwqDCoMKg
wqBfX2lubGluZV9tZW1jcHkoZHN0LCBzcmMsIGxlbik7Cj4gK8KgwqDCoMKgwqDCoMKgY2xhYygp
Owo+IMKgfQo+IMKgCj4gwqBzdGF0aWMgdm9pZCB0ZXh0X3Bva2VfbWVtc2V0KHZvaWQgKmRzdCwg
Y29uc3Qgdm9pZCAqc3JjLCBzaXplX3QgbGVuKQo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBpbnQg
YyA9ICooY29uc3QgaW50ICopc3JjOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgbWVtc2V0KGRzdCwg
YywgbGVuKTsKPiArwqDCoMKgwqDCoMKgwqBzdGFjKCk7Cj4gK8KgwqDCoMKgwqDCoMKgX19pbmxp
bmVfbWVtc2V0KGRzdCwgYywgbGVuKTsKPiArwqDCoMKgwqDCoMKgwqBjbGFjKCk7Cj4gwqB9CgpX
aHkgbm90IGRvIHN0YWMvY2xhYyBpbiBhIHNpbmdsZSBwbGFjZSBpbnNpZGUgX190ZXh0X3Bva2Uo
KT8K
