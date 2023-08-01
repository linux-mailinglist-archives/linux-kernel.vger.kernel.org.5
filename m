Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4115376BF83
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjHAVuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHAVuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:50:20 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E611BE3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 14:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690926619; x=1722462619;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=tW07OGACOHzhnzqGN9XLjMwQJk/wjNWRNxRsMts8GlE=;
  b=kCxyMvgPv1XRU1kmICrPeVJVBcWMrfD653BYtJkX4U2zmyePUYruQjIJ
   3PVRV/lhz4gp61CGdzBoQEGzwG//+q/x2tCStKIqDHoMc8Q75j2nJXP6A
   mTfwiEHgnhKyI4ijOeq95hAmHhiLONxltBGmO77FQCubkM0dfKIjYggIB
   h7uw9XDtTkTSzcNSq5eMGjUmtiM9/UbBuYb3gNGFTscPdRdnnTwZQ4ATh
   ovBFH9nuL06hkq8OD7Oh4/IcXNTtyA6+50t/agrKa37CRhUhSv1sNUr8u
   k9onbwj2hVC2E2xsfOyb3VY3Y7D825ICwsrGYTFYx0tOFSvxWyIcO5Stk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="349724602"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="349724602"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 14:50:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="732140897"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="732140897"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 01 Aug 2023 14:50:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 14:50:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 14:50:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 14:50:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGL4G/xm25vobEa2VAUZEyBPhnjwOPml4C7aUZq1ak1iZlxWbSwSI/spvBbqNiv/XQST3sJPvA4Ob9mQhvsQQ67W3INkw31axB+gPPFc9lvqSTGemGcoaX/xzSo9B+K9woe7i12F8/0lTROARyZtGoP7ILQqZrgWQXu8uN7YMizJpcmhumKNDmemxvVfTOidgCH6F3xdPwz8GwwWqu5Hqpu7HJ/t3zczW2Kp8ygDL+/vAs/L3qEC1WL/oPdQUg/rQvkTjJnFqHsVO5wyWnk1qgAcAV5yT8mfimKP0WUgBNqLopFqHc4eD1hl06tmnKi0VX8A8P0u+Q6rTycNsBDQTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tW07OGACOHzhnzqGN9XLjMwQJk/wjNWRNxRsMts8GlE=;
 b=IhtaiAEARC+dFYCRJYl6jITLw7NBntpRMUIDi1idysySzCJe/DeZPyzizmJQNw5rHytz5eq3ZHVtV+K5cWomwl1/SeGfIEm3Xwd99cuRXIag3+uC2InmmDFPOsBEkyKCdY/THlbcSTDNc33Fq7evY6OhLpQnwBpKKG7eqMDpQaOBsM+rQfWMJqO0Tm9Owpb2B6mxmEAreVY1eQgQbC2XRFraXa+6G8YSoH04lKQ9wmboZJ2J2EMiuwPxCD2G6MZZ2kWY+ZwYi+UlDhTREyFvs13AUM6HIdFcVFwZgSN5B04FglIvOYTFbnaWdmoEK7l/3ICbczvzopFYmOHfhY1FLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA0PR11MB7331.namprd11.prod.outlook.com (2603:10b6:208:435::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 21:50:14 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 21:50:14 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
Subject: Re: [PATCH v3 03/12] x86/alternatives: Disable LASS when patching
 kernel alternatives
Thread-Topic: [PATCH v3 03/12] x86/alternatives: Disable LASS when patching
 kernel alternatives
Thread-Index: AQHZxAAep6oXe5dBm0qRkHwHAPnX56/V8ScAgAALJYA=
Date:   Tue, 1 Aug 2023 21:50:14 +0000
Message-ID: <1432878a512dbb361c0fb9f303fda33a7cf68c9b.camel@intel.com>
References: <20230609183632.48706-1-alexander.shishkin@linux.intel.com>
         <20230609183632.48706-4-alexander.shishkin@linux.intel.com>
         <40ac9a487c723eff9eb069a5795760b1caf02f18.camel@intel.com>
         <a947a270-dad6-5486-2e11-feb288aa9210@intel.com>
In-Reply-To: <a947a270-dad6-5486-2e11-feb288aa9210@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA0PR11MB7331:EE_
x-ms-office365-filtering-correlation-id: eb043b80-7e0b-4dc5-f65d-08db92d94984
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dhMtm3IlBtvsBUbyIv2TjTIR3cNse23xgSmxyPl6wacLGsmwDaOmD0v9zmhQdA/4HufZ32Qx7XLNeIHT+I4jtaIl+kWdgqsaMLCVkusrDaE8YYKK2KpkVdeP8/IjhgH8d3KQjJ35q7PHw4K9rh/nnVhfvNusQOYLwwQ4RObXD9+NWeT65/b8xTXJunQDWImyEeCB2Q3JTcdq9DYdwd8zpv4S1FEr0UeK2Xu3zfWLddllJ2Ir9Txwnra6qmuCLm6flS4lbMotcxz7kVTXKRTX3F5JDbensOjml02Al5dGNXn1xxrMKMKLJG9d+iYj7i2HAnRtJaxN/5GM/kwIeGeB9Pva0q47thZn4ZV9gy+rH2WjlRvw94NL9ECLCsDT16do3Wv4mVdS4bclMxCrPE420q2FD+CSeia8wF2xPRZW1Hc7gyd93PhzTI7HdwirhMKYIoj4z0b2+bZgxtbIgfWntkKn7lXOimtoR6nFk3DuegPjFSLwENdICcEwObMymcd7eQiKRwRhdUfZMLYJUECb36iwDBfjS1+dtrXOy1jn6OTlJ7ejcvRWVsvhQFfuirX6IfE4FKxtl0MkSH2L8Ls7brxxyOcm0GW81KvfoxNvjcfo55Ss9f4MQDqN0rMT7BU/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199021)(38100700002)(66476007)(86362001)(316002)(8676002)(8936002)(64756008)(6636002)(5660300002)(66446008)(110136005)(921005)(122000001)(76116006)(91956017)(66946007)(66556008)(41300700001)(82960400001)(38070700005)(478600001)(2906002)(71200400001)(36756003)(6512007)(6486002)(6506007)(26005)(83380400001)(186003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGZHV21pUFlpZXVnVENhMWtIdTlIWVd6ZlBVek9IMUtCNkhYRHJieWhmcHZy?=
 =?utf-8?B?ektOYXJ5b2V6dkxhOEZlaFgzT0RBcENRWVFTRVFwTTROVnhQYlZUQmxzZFJS?=
 =?utf-8?B?MTVqSnU5MXQwWjhEUjRLbWFXbHpoWEtMRUFld0dTblhvelJ5Z3R6OXlJZzky?=
 =?utf-8?B?N3VjL3JzVG82SEdOUFVvMzRWcW1mQnVIbUxnZExWSUJPWWtvVzJIa2VmWXZr?=
 =?utf-8?B?QUNLaXl6TUJEUEJEQUtPTWo5MEE5c3VGWXFPV0xDOFgvM29ZOGJNU2RYdmI1?=
 =?utf-8?B?UlM3cjRZWUErZkJPb2Q0bTFoNWlad1VCTGl0QVZlaW1IYndMbWpPZGZ3Vm1E?=
 =?utf-8?B?dENVcmowZnpUNkh2Y1JWbm8zL0ZSVFpzM2h2Wk9xQmZ3NGl2aWxRZEpmMGlZ?=
 =?utf-8?B?MHl6djcrQWJGM3RQTm5xZE1jQUVIMElZcW4wOHNZZCtWa2NqbklCRzZsbkYr?=
 =?utf-8?B?T2hhOFhoVlVGbWZTa3U0NjFZYkpRZFE5VkdEcnZNSHhOUFJLelplZ01SMWpV?=
 =?utf-8?B?OXhob1NpL3oyL0s0TFVham43RGNXVlBiRFE4b0s3Vm5jQ2ptaHozV2xrUmp5?=
 =?utf-8?B?TzlqcklHY2pCVWd0RnlEOU56VnNXYmppZ0prMDNMd0ttb21YTzc5K1NITHo0?=
 =?utf-8?B?UG4yOEY4K3pyNElkY1Z2eXU4NE1kSWNCRDAwL2YvUERTTC9SUnJaK3pkRmpN?=
 =?utf-8?B?anNBdVVpV0g1bm4renQvOFdETzJtOXJPU0RpcVpHV2RoMGdsSENpODdvNWYr?=
 =?utf-8?B?UlJ1MVh6YjlaSVpsaTJqVkM4c3pCMnpuRW1aUUd2THErbEdJM00vY1ZhNUND?=
 =?utf-8?B?U3N3UjhXcEorSTNsR0lRbGhjRGtLRmxTYkhaKzFOQlppby9PeFlNTUZJL1FQ?=
 =?utf-8?B?U2R1UGZKNGFqYWhzc0YzZldQMm9Vc0p4ZTJDbzkrNjVybnJ2NU5qQnZHQXVO?=
 =?utf-8?B?ZUZCWWZtNmsvMGJpVmJPQktlSUlLK3Nya2RXNUlTMEJZV29WVnNWd2xJeTNm?=
 =?utf-8?B?RnhSQ3BFRmFGbVJ3c3NVZDB2akRYbFZwTExEeFhJVTdaV1JjK3NpUzdjRjBR?=
 =?utf-8?B?WXdKNWt3RnVLWXlUcEYycGVuKzBSak83c3ptRUVxT3NjenRTemNNdnp0ZXJ5?=
 =?utf-8?B?T1VaWFhJdFo2VHF4ak9QMDJYWHJMNjlYbGRhSlJOWXI2WE0xVUoxTzZUOUxZ?=
 =?utf-8?B?ZU1YV0tGdGx2VEI5RVdNelFoZDdTaG5GZ250ZlFLbzFIV0lKNWhLcTNZMjlT?=
 =?utf-8?B?V3B1R3VtSjJOUzd3TE41aHNKNjBWWVF1Rk9tMGQzVnpQVmhpL3pqeFR6N1Q2?=
 =?utf-8?B?bnliOWlKMWJkaGJTSllWK0tXR2JQUEQvVFNaaGtVa3lvTVBidW1IV2VKOHIw?=
 =?utf-8?B?ekVYcGF6U25rK09Rc1VEc1NqT2c1TWdCZmV3S3MzdWpFc1JVanMvWW5Kb2xq?=
 =?utf-8?B?bEoxNE56ZjdITS9VQkxlMlo5ODBKakVwZ1paamdpaWMrVjdlTXMwVmgwV3ZL?=
 =?utf-8?B?V1piU3EwaUVBZkVMckNaM2p3Y2pKMit5R0Z5RDJNZTlBQ1hPWEVPUEJLRXdU?=
 =?utf-8?B?VllxUGlSc2RjTVFaRlhETmpkSkJmeWxnVEZvL3ppdGtWNitZVkhHbmJ0Y0E3?=
 =?utf-8?B?TDZhVmVQYVY5L3VHRDFZeTNIVUhEbGpuRTNOZGhUQkJlUjBkV3cyWDFoVG12?=
 =?utf-8?B?Q3JzdWFCK2hrSjFjb0Z3SzljWlYzK0Q2Y2pRQnEwQ2s4VDRUZ2IvbG1LcHhv?=
 =?utf-8?B?c2U4OFpOR0JROGcveEVGSzdKcmJrSk14WlA5T1Z6SmNEL2lSdkUyWThLbDNx?=
 =?utf-8?B?TVcxdGFQc1VIS0d6R0dLdXAvTVNpQ3RIQXRzQmN1SlJ2NjBEdHVKTEFxaENs?=
 =?utf-8?B?bFBMUjErYnlnVVp4WjVRbXlFdHROaU9zS2FKME1MNmZnc1ZwTC90bXdrN1Z0?=
 =?utf-8?B?TDJpdlhJYjZQVm10WHZGOVd6bVZ3TkV3U2FZWnZsVS8yeEJFbkZ2M2JQdjla?=
 =?utf-8?B?OEN5cXg3QXRSOElUUEJRN2VnajRmcklQTjBKNFZTQWU4SEcwOGhneU8wR25y?=
 =?utf-8?B?YUVoV2VudkZaVlRlTWk1eXlLaW5ma3RjQ2V0SGFSQWZrOE5SQnJTKzNvTDNG?=
 =?utf-8?B?eW1ueVZzdGg0OFRWS2RWcmw1eEcvWnhPYjZGeWlFL1RRQVlNQWZVd0VpNnN6?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD1327D107AFD14AA431F023FA9F09EB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb043b80-7e0b-4dc5-f65d-08db92d94984
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 21:50:14.1516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6+tJ4s+WRFDF6r8LEqAWLdrknYApPNLeuUm+u60HKJNuxznUEgFnJsx//1IoxQ9FXKZ/ddgdNSRm6FK+yEbRvnIkUDMUiBIoeip0rOCDB78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7331
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA4LTAxIGF0IDE0OjEwIC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
PiBXaHkgbm90IGRvIHN0YWMvY2xhYyBpbiBhIHNpbmdsZSBwbGFjZSBpbnNpZGUgX190ZXh0X3Bv
a2UoKT8NCj4gDQo+IEl0IHdvdWxkIG1vc3RseSBsb29rIHNvbWV0aGluZyBsaWtlIHRoaXM6DQo+
ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9hbHRlcm5hdGl2ZS5jDQo+ID4gYi9hcmNo
L3g4Ni9rZXJuZWwvYWx0ZXJuYXRpdmUuYw0KPiA+IGluZGV4IDBmYmY4YTYzMTMwNi4uMDJlZjA4
ZTI1NzVkIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9hbHRlcm5hdGl2ZS5jDQo+
ID4gKysrIGIvYXJjaC94ODYva2VybmVsL2FsdGVybmF0aXZlLmMNCj4gPiBAQCAtMTc4MSw3ICsx
NzgxLDkgQEAgc3RhdGljIHZvaWQgKl9fdGV4dF9wb2tlKHRleHRfcG9rZV9mIGZ1bmMsDQo+ID4g
dm9pZCAqYWRkciwgY29uc3Qgdm9pZCAqc3JjLCBzaXplX3QgbA0KPiA+IMKgwqDCoMKgwqDCoMKg
wqAgcHJldiA9IHVzZV90ZW1wb3JhcnlfbW0ocG9raW5nX21tKTsNCj4gPiANCj4gPiDCoMKgwqDC
oMKgwqDCoMKgIGthc2FuX2Rpc2FibGVfY3VycmVudCgpOw0KPiA+ICvCoMKgwqDCoMKgwqAgc3Rh
YygpOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqAgZnVuYygodTggKilwb2tpbmdfYWRkciArIG9mZnNl
dF9pbl9wYWdlKGFkZHIpLCBzcmMsIGxlbik7DQo+ID4gK8KgwqDCoMKgwqDCoCBjbGFjKCk7DQo+
ID4gwqDCoMKgwqDCoMKgwqDCoCBrYXNhbl9lbmFibGVfY3VycmVudCgpOw0KPiA+IA0KPiA+IMKg
wqDCoMKgwqDCoMKgwqAgLyoNCj4gDQo+IFNpbmNlLCBfX3RleHRfcG9rZSgpIHVzZXMgYSBkeW5h
bWljIGZ1bmN0aW9uIHRvIGNhbGwgaW50bw0KPiB0ZXh0X3Bva2VfbWVtY3B5KCkgYW5kIHRleHRf
cG9rZV9tZW1zZXQoKSwgb2JqdG9vbCB3b3VsZCBzdGlsbA0KPiBjb21wbGFpbi4NCj4gDQo+ID4g
YXJjaC94ODYva2VybmVsL2FsdGVybmF0aXZlLm86IHdhcm5pbmc6IG9ianRvb2w6IF9fdGV4dF9w
b2tlKzB4MjU5Og0KPiA+IGNhbGwgdG8ge2R5bmFtaWN9KCkgd2l0aCBVQUNDRVNTIGVuYWJsZWQN
Cj4gDQo+IFdlIGNvdWxkIGNoYW5nZSBfX3RleHRfcG9rZSgpIHRvIG5vdCB1c2UgdGhlIGR5bmFt
aWMgZnVuYyBidXQgaXQNCj4gbWlnaHQNCj4gYmUgYSBiaXQgaGVhdnkgaGFuZGVkIHRvIHNhdmUg
YSBjb3VwbGUgb2YgbGluZXMgb2Ygc3RhYy9jbGFjIGNhbGxzLg0KPiBUaGUNCj4gY3VycmVudCB0
cmFkZS1vZmYgc2VlbXMgcmVhc29uYWJsZSB0byBtZS4NCj4gDQo+IERpZCB5b3UgaGF2ZSBzb21l
dGhpbmcgZGlmZmVyZW50IGluIG1pbmQ/DQoNCkkgd29uZGVyZWQgaWYgaXQgbWlnaHQgYmUgc29t
ZXRoaW5nIGxpa2UgdGhhdC4gWWVzLCBzZWVtcyBsaWtlIGFuIG9rDQp0cmFkZW9mZi4NCg==
