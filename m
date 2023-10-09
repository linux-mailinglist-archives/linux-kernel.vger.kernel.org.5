Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9E97BD2B5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 07:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345052AbjJIFDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 01:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjJIFDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 01:03:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5972A2
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 22:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696827822; x=1728363822;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OTm+TkIheP3czOjpg+OE/r94Z6W+he4pj7g/5o0V6XI=;
  b=ELZ8dhI98ySL+mcopad/XtAQuChDZ5SXKNvJHg5KVYuiSWRT9nfA3DSk
   /clRNp4MKMIwOMnE5jA37Ks77UL88YzLKxSUEaGPi9g6U2rDK6XB2LQRC
   Qd9FUrUINw/suGjhZ7yWw+gzf24sRsDafg+exUhBN+BvennS9p9wex2/B
   N0HJR4YVLfeY0HYYsYxVq9/VW7dIxrBOeQq+pIFpveL4Vp7jH7wJFjwit
   rqNgbIqhhNjUrr86NqOReGLCdS9NwK/eUyHp46c92KOjONvIlXzxfiolT
   Gahail0ZjJbtLMSTvXpr7h2pbJJszgnOO2tHen1I9kLfRxJyHc6goHgal
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="383947661"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="383947661"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 22:03:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="702764283"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="702764283"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2023 22:03:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 22:03:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 8 Oct 2023 22:03:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 8 Oct 2023 22:03:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMuWFW5ApbwTjXo74dMsmCveDTycnzqa+Fcvgv0j8v5QhZ1LqU6XVjNIdXLkJg8W19ax/N5AvIt8xWhpGLF5xPCyJLkRHsKFKCfFDSXsgTgR90XLckvJ9UJ1anrwToukTOKctp3Et9pOX8zkiXMzocC0fWeB4NAjDkVMGM6VQAFzMtl7pYgD35GB5p7Lg9Ii/CM2y7KvO4j2SMjw1fK0E4K0OUcU8n/ZOcX1NFLO/urL9oQR2QJUyLAy+SV4rIrDSO4XMX7BwnK3Mq6pzeMaQ93oKRHC6k9qQwsnVHDwQ402PFU7BwFSXmE8hEhwtEPufUzpHz//9kuYzGu36ssYIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTm+TkIheP3czOjpg+OE/r94Z6W+he4pj7g/5o0V6XI=;
 b=ADpbhtJCbGUyGLAIqJq7PRLWVUoX4BFIDG8yv8Vc/F8miy17CL0KYH+/NtGlkDl1ViYUoIpkZNWWrOuGbR9CBHE6H8q+lTJ1Cu77BIiHCdGSlB//aU3wMFRSCoFsM5j4ddecEmviLbBtq61BSRXFteuk4R0Jqde6qFZds/A4IXO3TFp0BR4XRZOfA4AuXfv50r4gzR93lwRWD2bn4Qo8n94NFw/JmVJ4srSSXw1B5p+/oTX9M9eF/9Rne0pRaxB2KECQvdTcAONR3mgP/q8OGGgyc38Z07ezN92MbzU6qxbc5X5cFndOD+tHpKd4bDCwL9aU4Fk38AB5N9iwCHV67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DS0PR11MB8135.namprd11.prod.outlook.com (2603:10b6:8:155::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Mon, 9 Oct
 2023 05:03:39 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::e30d:930b:e14d:bb7a]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::e30d:930b:e14d:bb7a%3]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 05:03:39 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [patch V4 00/30] x86/microcode: Cleanup and late loading
 enhancements
Thread-Topic: [patch V4 00/30] x86/microcode: Cleanup and late loading
 enhancements
Thread-Index: AQHZ+cUs2+mJdQ0iIkuJzDEkINjNBrA/3ZIAgAEJN6A=
Date:   Mon, 9 Oct 2023 05:03:39 +0000
Message-ID: <CY8PR11MB71345517EE18A6F0A73F867C89CEA@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20231002115506.217091296@linutronix.de>
 <20231008085456.71646-1-qiuxu.zhuo@intel.com>
 <20231008130840.GCZSKp2NbHAOB3h69z@fat_crate.local>
In-Reply-To: <20231008130840.GCZSKp2NbHAOB3h69z@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DS0PR11MB8135:EE_
x-ms-office365-filtering-correlation-id: fa8b9c79-62e2-4d5d-765f-08dbc88519be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VkufPJR8G8aFjpEVWPkpqWJkhezglukq208rfhCYm9My7I6/KA1TrR40wAOLL45uUZfDrZrQ59piditt542mHY9RBTAdRsLc+E+N6KYKXCbzHF3ML0dg6jVCk9UMxyYEm3e//SXQeWj9zBdfpA7ebUrcni5V4fUgRZT8KRmHskGFKQKP7es7MqzKNiZsrtJizbR8bntH/E10zPBZlcMysyun+dP+dNreH5kF5ni4+Y/aCjSFbOfPX2dmh8XOdBpGMdQzKceJsWjAVNFHe5nPXpzBPOGR59EKxVSxlCO+v7NTuEPSjLJUt0gv2xdKXLQchK+zxLLoBwB2NJqLSb4n4J4BKZAtG6I5ZyHektEn3wooN5hH5r0F5kee2OjGxKLEz5jLNhDQTBFssWnLGvnhqwL35UBfDGTGRbiyvCAXBwHCCM7iuJibx9uNZV6GFlOGL0dslPzC3tvNVsAJ401X6sHqbqT75WrKP+SVXAtD8NJJwL+nd1y6dgLa8TGWvv6tU82ftAHk8XiYasYwGUKdG70F0pdMZW1euwg6HBbjmq9ehKUbeeCjItEvgIxuBanB/muyri/gzs7xnHd5lCgxsVv8KVY40x7AqzeDHJsBXCg4MXeR11syuG8UOAXAXVow
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(136003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(9686003)(6506007)(7696005)(38100700002)(33656002)(82960400001)(86362001)(122000001)(38070700005)(2906002)(4744005)(71200400001)(478600001)(8676002)(41300700001)(316002)(4326008)(8936002)(55016003)(52536014)(26005)(66476007)(5660300002)(66556008)(64756008)(66446008)(54906003)(6916009)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VE5LOFdJTGtsYVdRbWZDcXRTcWVmSnIxRld3OVZYTGdaOFJTY2pINzV5b0E4?=
 =?utf-8?B?dVA2UmNFZFZKWjFpdVJoeGVlNVEzclRhNzRkWWlkMml0dUh4MUVJUXFTVGdE?=
 =?utf-8?B?ZjJYSzBTYUNoblV0UWJnME1mNkFtR2JiS0M5eHFYNXhvQ2hXQ3p0eTZIRHM5?=
 =?utf-8?B?b2NseHY2SUg3Szd4L3Avd0lyanpZeXBCZVpJbSthaU40TkZXblpYSnIvZHU5?=
 =?utf-8?B?RkV2MHdndzRGTEJRY3d4eEpGTC80ZmhTV2dLZ3U2RURkczZLdTY5UXFNVGdH?=
 =?utf-8?B?Wk1MTTAvM3JqL1hyakVFcmZqMzRpRkFRTEVWbmttR2hRNEFaWk13YjFGUHN1?=
 =?utf-8?B?NzZEUGNWM25lNmNjR00vY1lndncvZ0tPOGZsZmxJdEF0SDQ5ZkhNYmp1TE5H?=
 =?utf-8?B?bXlkdWRwVmZsY2hiNU03WVoxQXR0ajdXTHpQRWlkeFl1R3lmMjVCNlo1UFJa?=
 =?utf-8?B?TVhLTVZtd29SL2M0K1pHQ1plQVU3Y3NYSGRCYXpIT2NiNnhnMU1jVTU4eWc5?=
 =?utf-8?B?OXRwZ2ZuYldNVWExODFyZThNYTdkc2Zwa0YwTkU1OEY2WEtzdWtLUS9FVkFD?=
 =?utf-8?B?YlJpNTZJbHk0dGVDV25IYlZIeU5ySThQb1Rxb3AxNHhvYWRESlllZmtGRVVF?=
 =?utf-8?B?ZHlLVndOQlo5SjlqTHBoaU4rbXFEREI2TEZrRnQ1ZkM4UVMvckU0R1kwU25X?=
 =?utf-8?B?T2I2R1l6SGNvYm1qanFaN0JpTDdCaUNPQjJ3NEZyUlJCZkVvM2czMUp4ZGJ5?=
 =?utf-8?B?N2Qxb1p3RGZqWEE0TkUzZTJZT0xLNjZCYkhVUnNEN1BobS9oQ21tYUxGQUR6?=
 =?utf-8?B?MENEOHMyektzK1hWZ3Y3UTB2K0dZL3k4cU9uS3g3dnZIbG5vZUVKM1YyT05L?=
 =?utf-8?B?dXZ0ei9mYXN1VXYyekJONWNOSnV0clJ5NWtVMUZrZ1dkbFdUSUcxTEtnM0wz?=
 =?utf-8?B?NGYzNkRRam5HUHUzUHpETzFZS0VvbGdxcW52bjZEVHpvdTFmUGF2eXVxWUJq?=
 =?utf-8?B?cE01b3NmOTBydWZjSU1pSlk0OGRoVlF1N1lSdUI4VU85clpJTUFDM01teVFm?=
 =?utf-8?B?NVJKNDJrcmxKS21yeE9KQzEwY3NrK3lxckRabGQ1ZUQxdTI2MW4rRk1KSnln?=
 =?utf-8?B?K0hHWnhRTGJ2aDQvVERlMUs5RllLNlJkcWlEeHNwanZBYS9RdWtqZTZlN3dn?=
 =?utf-8?B?dzdVTFBHME9uNTJlaERZNythVmlaYW91UFJZQ0Y2YWlOb2JsUnRpNHg2aWt3?=
 =?utf-8?B?SDZkK0h1TDlQc3hnVEhodmloclZlVlM3MG1QbFBmamdMWVYvVnI3T05tNTEw?=
 =?utf-8?B?OEtDMjNyTEFEQmJDdkZMTlZHQitCVkxiTlgvMzRmWndIQkxEUktjRGJ6YVpB?=
 =?utf-8?B?Ny9weEg1SkVqSUhneGl0OHN6ZVJGVEJZcDR1aHA2ekFudFpQSndvaDRUT093?=
 =?utf-8?B?cUQ4bFNvc2RaMlJwdGNUelJJRGowOTF5a0RrdVJXSUhCbkh5cG5NdTVseGRI?=
 =?utf-8?B?TFNaWXEyc0dRWHo2RDVwOFFOMUVPRHB6T1ZXMGl0Q1U2YktjZUFGRitrNkhL?=
 =?utf-8?B?M3FhT0tLOGJvNjMvSjBDZ2FyRnlqRUFHL0VsNzNzdlZhR1VreWRNVG9MZ1Z3?=
 =?utf-8?B?MTBWNTdvRHE5QkU1NTJPakpadWJWVGZhRmpFTkUzRHVKN01vcUR6cmszcXI0?=
 =?utf-8?B?ZlkrUVlMOVZTS2NlUVRsK2xLa1pFOUYyTEF5Vit2S0FHSHJsWkVOUm1EWklG?=
 =?utf-8?B?d05oZk1vS2Y0R1BUdDlUbEtKOUVEUlhGVDBtK25Ma2F0Y0lpOHBpSjZNbFBR?=
 =?utf-8?B?ODhtMC9DVlN4V1lFS1l2aCsxQmY3Mk1kSExscVRseUQ5bXhZYlNWbzNTenF3?=
 =?utf-8?B?QVJMdXRaQTdiOXRtS3NXbE4zZ2YvcXpLY0tuZjlJUDdSS2pGQW94NkQyWEZr?=
 =?utf-8?B?VFExR2ZjMTl5Q0pzZHJpR3MwQ2tZNnJSMjkyaU1Udjh2V3MzUmY2RkNDcWVX?=
 =?utf-8?B?ZUEyc0NqUFNWd1pTTVF3NnMzQm1DSjdNWVZEd2U1dzhwZ0pzcTdCdVZqRGN1?=
 =?utf-8?B?NlJhcmthcm0xQnFKbHBhYVkvZHI5Q3VZd2x6TzZGVFVpVXhQMTFNN2JlYzQ1?=
 =?utf-8?Q?xEXFfjtluPE/dZ4WRHCPVriN3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8b9c79-62e2-4d5d-765f-08dbc88519be
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 05:03:39.0847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OmrrlqXwBlB4U+wxyOfeQGIoPivb2mZ6Gw6YPlDcgSBhj3kTYm0L1lqgjha0qqjt+V94NjVyUJ3O3mc52zeUhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8135
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4gLi4uDQo+ID4gVGVzdCBS
ZXN1bHQgKHNhbWUgYXMgdWNvZGUtdjMpDQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+ID4gVGVzdGVkICd1Y29kZS12NCcgb24gYW4gSW50ZWwgU2FwcGhpcmUgUmFwaWRzIHNl
cnZlciB0aGF0IGJvdGggZWFybHkNCj4gPiBsb2FkIGFuZCBsYXRlIGxvYWQgd29ya2VkIHdlbGwu
IEZvciBtb3JlIGRldGFpbHMsIHBsZWFzZSByZWZlciB0byB0aGUgdGVzdA0KPiBiZWxvdzoNCj4g
DQo+IFRoYW5rcy4NCj4gDQo+IEkndmUgZm91bmQgYSBjb3VwbGUgb2YgaXNzdWVzIGFuZCBvbmNl
IEknbSBkb25lIHdpdGggbXkgdGVzdGluZywgSSdsbCBwdXNoDQo+IHRpcDp4ODYvbWljcm9jb2Rl
IGFuZCB5b3UgY291bGQgcnVuIGl0IHRoZW4gdG8gbWFrZSBzdXJlIGl0IGFsbCBpcyBzdGlsbCBv
ay4NCg0KSGkgQm9yaXMsDQoNCk9LLiAgSSdsbCByZS1ydW4gdGhlIHRlc3Qgb25jZSB5b3UgcHVz
aCB0aGUgY29kZSB0byB0aXA6eDg2L21pY3JvY29kZS4NCg0KLVFpdXh1DQo=
