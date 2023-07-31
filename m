Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4017376A437
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 00:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjGaWhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 18:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGaWhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 18:37:01 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2917418F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 15:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690843020; x=1722379020;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=gnQyk+7Hv8KbZQI8bnKhPpVCiUEm4dSrYLCCGMcbsWQ=;
  b=czLqU3isbnJMW6L46m/H0qb2xMN/xDAfzap4DtCyYQgCkx784z5HhqOu
   8YFwNgFVXGzPNB5K4MB2r98+3rAfaLEAAdPNCAA2u+1kDblJTz0jUTVVe
   YPm6DAUbVYF6Vz3SzLNks++SK2KD6CoyFszrpfHFQy6MF47w7v/h6o/gd
   8oCkkw4aM3L/s2ML9xBRWlPogIvYEUlswFwCYeOoEJNf+y1G15t7TlQXF
   o6ieOSjABzwKzd4RWj1hJIai4g3f4vDOqYjJRMwEcPr2OkcGApE8Gl0Xm
   60UM5pQjbHlrt+5TyXXjvN9JAFqW90n2cgZM2ty6YQ8VAF3FNZNS7x/pl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="349439372"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="349439372"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 15:36:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="842468698"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="842468698"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 31 Jul 2023 15:36:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 15:36:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 15:36:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 15:36:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 15:36:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Az9IH4xqkTNn49C6Jf/fbccjZ30eKu22tp6a70xJX6Qq5SiOsryt3rweh25iZUPh1vuvKR549plGYw3suizXUjCX4qL4DuXqeBL08cL1MwjZsEIxLFDE5J2QmuXk6QeWQkBvyxsWrBXnFpSfuSVyL1II+wFr89Qis4BwjsCVyAEPx0HJFFfDynFF6yOlcQ1cU0+eWe/rzdYG0o4nGxmjeEFYtWxNKVCcVQw2UfCAAkI2o0IuyS1XuKqAoDO6nhTvvWWpxelz58dmCm0ERYq3A8SFuzK2yOrG6yiS+9cO2Jzsn68uEhZumFpnx5+2gGvftA6ChqzREKUus9P/gUn2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnQyk+7Hv8KbZQI8bnKhPpVCiUEm4dSrYLCCGMcbsWQ=;
 b=a+b9RW3yQjO0ryZa3bysxQAH5liu3LByLTEY+80D+bqLcEPaTId1Jzt9RxziEan0nLlOWnbtSUgs8kUbjNZaINAhBNkboNW07RJuwA9OOudxRxgDvGL5NY6M7Z12d5HgTW2KtliHbanVSGu+IF/kn+W2I03ObCGhZ1AW+bsLuwYzc4M5FTvW5SxdI+gfXOhwatGpGltarH7NWY5pX0N5IFFjGlqmMkWaS03Sk/rUqQATwfwYu8P958IxoQnX76kubxFG+Qm19Iw6FZherahsZYnswnTbS1me7Dt7GCVM3ZHf9Fp3KBqeIevghHhevL9e7CHD2kuowYidLLM73ONKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MN0PR11MB6085.namprd11.prod.outlook.com (2603:10b6:208:3cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 22:36:56 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 22:36:56 +0000
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
Subject: Re: [PATCH v3 00/12] Enable Linear Address Space Separation support
Thread-Topic: [PATCH v3 00/12] Enable Linear Address Space Separation support
Thread-Index: AQHZw/+CpLA4Kkbz00+t3asZ4sM38w==
Date:   Mon, 31 Jul 2023 22:36:56 +0000
Message-ID: <d6b79dd5d85a30baf2eb138036910890fb060e52.camel@intel.com>
References: <20230609183632.48706-1-alexander.shishkin@linux.intel.com>
In-Reply-To: <20230609183632.48706-1-alexander.shishkin@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MN0PR11MB6085:EE_
x-ms-office365-filtering-correlation-id: ab1ae962-7184-44b8-bdd2-08db9216a549
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KoMZeMxJ3opUDTQvWNBhRb1eIMGJI1TqLdfXXud+pIannw47Sp875FUEXlyjs+3Gf7AQyKm/CDxQIzNYbQ1udrl/rzgebl3e5ORrstouRWjKeUzBgo41esGg9VfC7O9+r3cHr/84kWOLXNacashAVzdOT8wpb+hg0mB300CMJLvDdbwKWbnIhc1DKC4lv3OGp5rmk9Wly9D+tu2UamBjzo6Ch7qxg+4Ok0YxNzGdyAwWC9h+61F63wQCoSLGrcAhvZXeDJ/uDW9gAZZBbFpQWoiQy4h4WhwdQmkXF2zvODd9qpLHgdy6wv6fLFWMOU9SmPmU5l6UnyExiJrVCVr3CaU1+6DXiiAWb6pLgh1thmRCGKGoj4QaM07zTYVS60BW4iC2Xxzj1rVpk7eC067ktBkEktTX+BNgnMVov0Wsc7YWlUdufXmZeag2FMkD3514Z4Y6BNuoK2qNMkqHFBuqdPovqFvLm12nScAWwGxg3DWKooXGjRje8Y0Iymp5ycZabNeQcOYrcQn8VfeyXiD6zo/r8th2s/7iqrbRJZ1BeWzpOgf1Mdj/Tkla9SzAaQhFJ6hPNEUGUm8SmcBkE1lLUVtkanU1/e2BRW27+aqYms2b5fLkK+OJnhv785lYH2f/2E+uC2+XS1Ksyz1jaUYeJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(36756003)(478600001)(38100700002)(921005)(82960400001)(122000001)(86362001)(38070700005)(6512007)(71200400001)(6486002)(2616005)(186003)(8676002)(26005)(8936002)(6506007)(5660300002)(91956017)(76116006)(6636002)(2906002)(66446008)(64756008)(66476007)(66946007)(66556008)(41300700001)(110136005)(316002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFhxZE5YYUcxR2ZwQStKRU9Sd0dJeU8rODR0TXZQNmdLMkVqZ1VaQzd3eWhD?=
 =?utf-8?B?S2FZdkZRaDVtbytVci9PVDQxcmwyR1o1Nk9KOERLQkg0bDlkTUR3SFprcHd3?=
 =?utf-8?B?aDNkTzZQZzluNE44WGZESllMZ05oeFlzMTlRWStFTkVqSnVZRHRHelRQeGdo?=
 =?utf-8?B?eFBWZTJlZGdwMjFwMWlUQkY5R0FNc0g4ZHM1OUFUVTFPWi9tUllUaXJCcUd5?=
 =?utf-8?B?aC9aSlVDNnk4N1RSS3I3T0Nia29mL0FTZHVkazdKUDllUHcyNE01dDl0VU9T?=
 =?utf-8?B?azgxdnFabFpIYnRSeC9YS1ZkZlQzNzgrVDcxbjljeU1oTkpXTkl2N3ByNXdk?=
 =?utf-8?B?Z2hFeTRTOFlKbWVQYlQ0WXZibmNKSy9hVERvbFdzYXBCcUlyejVJYWIzbW9t?=
 =?utf-8?B?OHFRY1lsaWJlTFRCbC9LSGh5T0tFaFBYdUtZbFk5eTJ0NS9uNGRDSVNNQ2N6?=
 =?utf-8?B?V21UUFhYZVFlZlhDVjZMV2Y4dG1jak1pMXBSRjUwYXgvV1c1MStId2JBUWto?=
 =?utf-8?B?VUJOeUl4d0kwbnprNEcrVE9GNFA2M0Y4cHl2bXEwdHhrNWxwZUw5RXplZUhN?=
 =?utf-8?B?T0o1VHo1VTF0Vy9aWGRka21zclZUVG9pdURKczhDQXc2ZG13MGF2NTkxcXdN?=
 =?utf-8?B?MDUzS0E4alQ0VTNRd2hVWUF4cStlM3Bwdm03em5iYnRtbjBJM0MxSFU4S1M2?=
 =?utf-8?B?OUVLeDlxdG85T3hoUXQ3YXkzcUNwMVFMbUlVeDFqYkRPaDZDNkFUdmFuTkdK?=
 =?utf-8?B?RnZQbHpzZ05RM0lQVjNZUzFOWUE5QU5GMERMTUdnQzBHemhmWHJMSWszZjFN?=
 =?utf-8?B?SkRuM2VvZGNBMDVIZXU4QVBTYUU0N25oSytLZVdnL0NaV3hFQW16YzM2NUVn?=
 =?utf-8?B?LzRsS2dLSmpqZzFIVmd0RHZTMjRJaFMwWHRobDlnWnEydm51dXNvVkVteW1X?=
 =?utf-8?B?VG9YVzVEcFZzSVJTd3dnb3hpcFc1SG13NXhrbDV6b3pBNFVpNE96THJjRlVB?=
 =?utf-8?B?MURqZ0VwLzZVY0hsbXJLSHhIUklKbjNxcGRuMTU2Nm81WHdiVU1DRXhPOXZm?=
 =?utf-8?B?SmIrdG1ET3BBK3NnWEdURXE2K2VMb3BJL3VnVTVleDBmUUp0alVMZ3llOEVq?=
 =?utf-8?B?N3RSTWtCR09rZHpKdVR3ak0vT2RMbHg0VCtlbC9xS0JwZlVEUG54V2RidHF1?=
 =?utf-8?B?Q2h4ZmFYOGpmQlFWOWtqKzQza29ySWhZVU41TmU0VkVWVkFxeG55amVOaGs0?=
 =?utf-8?B?eTVNRTR6RnN1c25maHN5bDIvTTJrY013MG5DOWNGdkpiLy9lWXZ5N1V5RlpH?=
 =?utf-8?B?WWdKZVBlZmZGZkoyUXI2eGFLTnZnUndnS3NGVjVwcnpHU0syRjZWY3BTdzJv?=
 =?utf-8?B?SW9ZNmhDTHFZN0VJTFNKQjh4LzI2RTg4S3BUT2EyYVZYdUdVUGZqSHhldnJa?=
 =?utf-8?B?NTV3MS9DRkZ2MzREK0VxYXVLTTc0eHNWbGs2aS96TnVueEhJd29RVlBFcXBS?=
 =?utf-8?B?K0xhQTVFdFNDLzJGb0M2QjduWWxnTkllRkdkUVVkNGlPbFkyR0lmSkp1d25P?=
 =?utf-8?B?RDJ2Umx6eUIxSDdmTUFKVUNxbjNtTTFDVDdLenFtZnNBM21QQTFuT285Z1Vz?=
 =?utf-8?B?ZVNUOEdZYW9rbDBlQUswQ1lUQnVibndUc3JjRS9KWVpNc2dOL2N0VUlwSkVL?=
 =?utf-8?B?VzVudGk3YXJ2bG9CZURicUhRSlA4WGtaWm9CNjFDRWY1MUhUeG56c09adGk4?=
 =?utf-8?B?OTI0WnlFQkJPeHA3aERzNmZuMkRMR3RJYzZUUG9IWUVaTkF4MXBhem1kTy9L?=
 =?utf-8?B?Q3NQUUkzK1BWaFoxRlJkMlhrMVcxYWwyMVMweUtxdGZEaGQwQXlaL25HdnNl?=
 =?utf-8?B?N01oTGxuL3BQTUlubEVCOU8yYXd5TStzZWpUMEVDazNiak81NVpSQXdZOGRx?=
 =?utf-8?B?MGhOS3pNOS9BU0FEVzVrK296ZzU3RUxFR3pSVmxEYWFHQk9laldRSlRBYW1z?=
 =?utf-8?B?M2FvWC9HemRtWUV3WTFMcWVaZkVid0tMZHg5NGFRSi9uU2lzQjZZOWY3THlu?=
 =?utf-8?B?b1lkK0t1WFJaMzFqYWtTNnJEL1MvSnhVMGdQVDFvaWcweUp6YkY0WDBtSUNT?=
 =?utf-8?B?S1diMDVKbS9CNmRNTExIckZuTzBlOE9hc21oam5rNy85MUt6aUFXU21qek96?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B199FD9C83FF9E44BBF04A31A78360A1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1ae962-7184-44b8-bdd2-08db9216a549
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 22:36:56.2998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /cn+KWuhqEmEI74mn1mhHhPrmeTpWWF17KOWkDVZfXSHSPDkcSs1Of2qP7gmnk0XrHdTAQqiNBSzH+WWhJq3bYJOYey6g+Xkd2zbfaaM270=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6085
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA2LTA5IGF0IDIxOjM2ICswMzAwLCBBbGV4YW5kZXIgU2hpc2hraW4gd3Jv
dGU6DQoNCg0KV2hhdCBkbyBOVUxMIHBvaW50ZXIgZGUtcmVmZXJlbmNlcyBsb29rIGxpa2Ugd2l0
aCBMQVNTIGVuYWJsZWQ/IFRoZXkNCndpbGwgYmUgYSAjR1AgaW5zdGVhZCBvZiBhICNQRiwgcmln
aHQ/IEN1cnJlbnRseSB0aGUga2VybmVsIHByaW50cyBvdXQNCnNldmVyYWwgdHlwZXMgb2YgaGVs
cGZ1bCBtZXNzYWdlczoNCiAtICJCVUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2Us
IGFkZHJlc3M6ICVseCINCiAtwqAiQlVHOiB1bmFibGUgdG8gaGFuZGxlIHBhZ2UgZmF1bHQgZm9y
IGFkZHJlc3M6ICVweA0KIC0gInVuYWJsZSB0byBleGVjdXRlIHVzZXJzcGFjZSBjb2RlIChTTUVQ
PykgKHVpZDogJWQpIg0KIC0gZXRjDQoNClRoZXNlIHdpbGwgZ28gYXdheSBJIGd1ZXNzLCBhbmQg
eW91IHdpbGwgZ2V0IGEgbW9yZSBvcGFxdWUgImdlbmVyYWwNCnByb3RlY3Rpb24gZmF1bHQiIG1l
c3NhZ2U/DQoNCkFzc3VtaW5nIHRoYXQgaXMgYWxsIHJpZ2h0LCBJIGRvbid0IGtub3cgaWYgaXQg
bWlnaHQgYmUgd29ydGggdHdlYWtpbmcNCnRoYXQgI0dQIG1lc3NhZ2UsIHNvIHBlb3BsZSBhcmVu
J3QgY29uZnVzZWQgd2hlbiBkZWJ1Z2dpbmcuIFNvbWV0aGluZw0KdGhhdCBleHBsYWlucyB0byB0
dXJuIG9mZiBMQVNTIHRvIGdldCBtb3JlIGRlYnVnZ2luZyBpbmZvLg0KDQo+IEtlcm5lbCBhY2Nl
c3NlcyB1c3VhbGx5IG9ubHkgaGFwcGVuIHRvIHRoZSBrZXJuZWwgYWRkcmVzcyBzcGFjZS4NCj4g
SG93ZXZlciwgdGhlcmUNCj4gYXJlIHZhbGlkIHJlYXNvbnMgZm9yIGtlcm5lbCB0byBhY2Nlc3Mg
bWVtb3J5IGluIHRoZSB1c2VyIGhhbGYuIEZvcg0KPiB0aGVzZSBjYXNlcw0KPiAoc3VjaCBhcyB0
ZXh0IHBva2luZyBhbmQgRUZJIHJ1bnRpbWUgYWNjZXNzZXMpLCB0aGUga2VybmVsIGNhbg0KPiB0
ZW1wb3JhcmlseQ0KPiBzdXNwZW5kIHRoZSBlbmZvcmNlbWVudCBvZiBMQVNTIGJ5IHRvZ2dsaW5n
IFNNQVAgKFN1cGVydmlzb3IgTW9kZQ0KPiBBY2Nlc3MNCj4gUHJldmVudGlvbikgdXNpbmcgdGhl
IHN0YWMoKS9jbGFjKCkgaW5zdHJ1Y3Rpb25zLg0KDQpDRVQgaW50cm9kdWNlcyB0aGlzIHVudXN1
YWwgaW5zdHJ1Y3Rpb24gY2FsbGVkIFdSVVNTLiBJdCBhbGxvd3MgeW91IHRvDQptYWtlIHVzZXIg
bWVtb3J5IGFjY2Vzc2VzIHdoaWxlIGV4ZWN1dGluZyBpbiB0aGUga2VybmVsLiBCZWNhdXNlIG9m
DQp0aGlzIHNwZWNpYWwgcHJvcGVydHksIHRoZSBDRVQgc2hhZG93IHN0YWNrIHBhdGNoZXMgZG9u
J3QgdG9nZ2xlDQpzdGFjL2NsYWMgd2hpbGUgZXhlY3V0aW5nIHRoaXMgaW5zdHJ1Y3Rpb24uIFNv
IEkgdGhpbmsgTEFTUyB3aWxsIG5lZWQNCml0IHRvIGJlaGF2ZSBtb3JlIGxpa2UgYSBub3JtYWwg
dXNlcnNwYWNlIGFjY2VzcyBmcm9tIHRoZSBrZXJuZWwuDQpTaGFkb3cgc3RhY2sgaXMgbm90IHVw
c3RyZWFtIHlldCwgc28ganVzdCBzb21ldGhpbmcgdG8ga2VlcCBpbiBtaW5kIGZvcg0KdGhlIGZ1
dHVyZS4NCg0KQWxzbywgd2hhdCBpcyB0aGlzIHNlcmllcyBiYXNlZCBvbj8gSSB3YXNuJ3QgYWJs
ZSB0byBhcHBseSBpdC4NCg==
