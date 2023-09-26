Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAEC7AF1E7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbjIZRqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjIZRqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:46:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A699F;
        Tue, 26 Sep 2023 10:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695750362; x=1727286362;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FZjlwzYS4FksiLyZGxoLQMWy8X6T4ER1C6B9V4chblI=;
  b=PKSBJZrythv5bTZX+DSKYKmikefo35U00XoUR2OntP/82/utzWlhiLn1
   JIUP7mCparFa117Y7IVhii9dtcO4GGjdIGXFMN2gIO9Q/5YB/Pza2lfcS
   YcjAvQicdBfufnNKHgSy/JzRrbDAjnCJ2eb1lEiTN1g1vHjJ/1PWW1P9x
   3nxIjMao3k5IFiugSrESCUwfNAuI//7WyGL9X99iLNchUQXube/VSj0/T
   woSM/aRtI1kikfaD5QZAQlG+nZQ/ihBA/cDK0Z2u3YAVJ8aN73a2PNLMz
   +jfmp9LFO1HkSfEJkRDoh1/9OfgWTIcxgDU/7mSV4xyZPhKUugo4LW1Zg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="371964205"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="371964205"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 10:46:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="892285991"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="892285991"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 10:44:55 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 10:45:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 10:45:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 10:45:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBIq9bL1n5U76bXrUuaReoW6O9hBULerxaygV3NBRRXfu4BZDn59Sily4+AZFgJ0RD8dMZSMLk3mTO2iN1G2dV9QSeKFTb/rfXPqd3DAGZ3mabWbv+90GvOCykOGr6KAM4isZV9qGrLDD+Esb6wgc8S+9kYw8hayab+nqPnh4x6YdNWpWOLvsMiGoWpaf+VkyqVqN44f79DixqhRk73fKTp6QbjAJyuc9CkzmMO8WqWQkkRFQZu38g85kS7BJVEp5Z03+KvRAVjlktB1nggq2CDk+xz9vsV9fIFXIRR1vInXfgB2Txctm0Utr7D6Ho/mVBm4WWyWG3QMZfmG39+4dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZjlwzYS4FksiLyZGxoLQMWy8X6T4ER1C6B9V4chblI=;
 b=EX07nKzhvsvlnYAmpWnkExthekzvenCgVwqfRZAknsolledXnCkSxhVJuaJZozoan5dP2+IIXqlyXG48N6qMfI+K4uJNI+eTZfFq8UHWuuN5VRBbR6jOpIrRMbs/x+Yl+nz07z17IJPDmmqrt3buO20PxxskDTuTx3DhGLh3VmZWytv4eidDQhJdmE0KvY6JuqKB5R1IPSY7BSvLQCb6yrVPQw4Bb1eRBJhvCinEfJvDoS7GZuolLhwHi45LXfeS5NYyiVleY0QhImXLNTGwoMZcKiice7PNvCz9Y3n6Tvz9vzA8GIZ91jYF5XQkXtZ8nCTTf0D+WKCLZQGS1q0iAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB5215.namprd11.prod.outlook.com (2603:10b6:a03:2d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Tue, 26 Sep
 2023 17:45:50 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4%7]) with mapi id 15.20.6792.026; Tue, 26 Sep 2023
 17:45:50 +0000
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
Subject: RE: [PATCH v5 2/8] x86/resctrl: Prepare for different scope for
 control/monitor operations
Thread-Topic: [PATCH v5 2/8] x86/resctrl: Prepare for different scope for
 control/monitor operations
Thread-Index: AQHZ2tLLm4WAqdn+YE6NPkv7LaqVMLAtfoaAgAANXaA=
Date:   Tue, 26 Sep 2023 17:45:50 +0000
Message-ID: <SJ1PR11MB608392F4682FE9EA0EC618C8FCC3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-3-tony.luck@intel.com>
 <ce890031-2478-ad40-a016-03657bc5f0e3@amd.com>
In-Reply-To: <ce890031-2478-ad40-a016-03657bc5f0e3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB5215:EE_
x-ms-office365-filtering-correlation-id: b1a819f5-eec4-4a1c-9220-08dbbeb86c73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pF9X5TxVbo5btjmiJuAsFIoj34+lC1wAY8tGlNiB9yFDYDhlvKs+zSuiNzaCiytVrfJHMLPvQTH0+PegC1+RzIwObYHfIvCTcAg/E4DHkd5EuXw72kPftxXiQHpHNPrR0jQzBmZpLsRQhCSeOxnclkR8buaxNGfJQHzAuI9dHx8ftrXG4peFNgc1BybwmfnGOXsspac14CHw6XshOFT09PXeXTz2x/sKFZ5yBSxWKa9H2YkMEGLpowIXHNTuD+F+8HY1R7aNSZC2AsKkyMPQh16M5Oz/BFQxBPEPXB5VwLm7koBPEYThEeYXZhfsDg3v1OgTeKPNL9+N5BDsxPMKt567l07qpHFfBCRtWmu2ucC53NK+6pZ/wMUPrGyYjl0UGgUPE+TOWM2Syy/CBq6yNjau5RFBp5CNJ7sGLA/g7Q2fxlbhTjvot0Zmn0dE/p9iLqVo20MT6IavjYURrVY2Sw0w4WzCEJNLICJYGhkGDCqueehjLQvn3JlrkidSAbyDIP3wdxJaNhbj+2eg7l4rOyM7NwbA9pNqTifFP1+k4GUMVcWkcRMMMd8USSH6JrLPbSJorO0stUOt3rkzysr/rytTg247YvE2VP5TcZKADkDcmsNC+MC+ozbxBIzjXb7L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(33656002)(82960400001)(2906002)(86362001)(38070700005)(26005)(7696005)(71200400001)(6506007)(478600001)(122000001)(38100700002)(9686003)(4744005)(55016003)(41300700001)(5660300002)(7416002)(4326008)(52536014)(316002)(76116006)(110136005)(54906003)(66476007)(66946007)(66446008)(66556008)(8676002)(8936002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTllL1p1QW9uWFlmSi9oVDFsNDRDV2VndUZvZ0ZrZEVxalFjc1pSWlp5TFVR?=
 =?utf-8?B?UWcrc0VnRnJjRDNJV05ZL1k1VlNnQVpGaHV3eHpkTnZLR21FaEZ1c2Q5Njdh?=
 =?utf-8?B?TFI4b1JQQU9HcW5RL216YW9HSllFaDZ1aU9laHJVMnpVZzRkKzJOSytJcG4z?=
 =?utf-8?B?MVNRSnhBTWQzSm42ZEg3MGFtOGg5a2NqZ0RPOEt5OXdzTEhwZTYyaHRZc2RE?=
 =?utf-8?B?Yk05VjQ1SHBZS2Q4eVp0clFTRURLUDdGaFJiQjkzdVVXd3JyT1JIM0E3bTRq?=
 =?utf-8?B?akNSOXZwd0JQWDdlUE9MNTY3UCtIVE1wb3YwM2tsZjM2cGNhM0wxelNBQVFn?=
 =?utf-8?B?N1AwbWFUMDhJVVBXbUU3b0ZnSzV2MXZ6V2wvTS9veVJWeGIxT1dLNTdPdit0?=
 =?utf-8?B?UFJEdTNLYmdFRW1hMkhpOXF6VENzd0JHdVZQRFVmSkRBYVRKcGtwV1ZtTlA5?=
 =?utf-8?B?eHZJRmZRdWgvNis0RHh4TmpBc1JJTWVyZm9nRDNUK1BLS1NnQXFXZFpONzY0?=
 =?utf-8?B?VGFjdWpHV1pkUGtQUDE4R3JDMkRERjkzOG1ObHZxNkNBZ0lQbHVscS8wd3Zu?=
 =?utf-8?B?RVZqTmYvd3Nrd0x5YnlaRzgxamRUTXJ5L3pvQ0xGbEhsdHFVQ2RnckZsMTBQ?=
 =?utf-8?B?UHYvZUh3bzNOUFZXTld2czF4U0VTVVZheEc3a0VoRkVQa21hZXRJaXhBM0hz?=
 =?utf-8?B?bmNDZDBOM2Y4QmxKanR4dUZaSzNqT3ZpLys4ZGhNYlJzN3h1ZUxnWTY5dVNk?=
 =?utf-8?B?aDVwR1g2SUZ6TTNlK3pTTGVFYnZYeVQ2Zjl6cU1QR2xEWkpCOFdZb245NkJG?=
 =?utf-8?B?MlVnM2FZSURYSnlsekZNNmpDMmJTL0V1Q3lqTW1uS3RRRjRvY0RzWDlGK2Ri?=
 =?utf-8?B?TXBaTDduTFBWSWJ0TmhXSmtOT3NtN0wraERDNG1GTENwU0RIenBRMHBNVnUx?=
 =?utf-8?B?L2FsbndZS2pLWEtySWpiaSswVU9LbGdOMytwaWhoNlc5WmJ1OElUem5mNlJG?=
 =?utf-8?B?bDd5aXFnb2VvN256UHNSV2FlSXNhMTB1WDhWMFpYSjF0L2VpbW9pdXJibWhq?=
 =?utf-8?B?TlR3YjZsTHpZWXo2MTlIZFdFVVB2d1QrOXp5T3p1dEpxc3J4djBWYyswbUFm?=
 =?utf-8?B?VmlyNVU0YU1UemR2REplZDVjSW9hRm1jcnV5NldDWEJ2TmZOTGJ4WnErY1hq?=
 =?utf-8?B?YS9ZSzFXTTlBWi8ycmIrWmI4RUZqZkFvZmpzL0lUR0RuaGNlbnNwUXF3OHQ1?=
 =?utf-8?B?eCtEZVR6a29JeGhRdGMyQnNOamtXM2V1Qlc1NW5ZTUtyZk5lU2d1QWJzTm13?=
 =?utf-8?B?NWp0UWx0eEUyMmo5aVZvZVIzOUNLY2wybXRoWHR1MUxMQkJ5Qk80bFlrbUh1?=
 =?utf-8?B?OFlKYUZLRVVuTmYyTjBCblVlZms0dDhjeXVua21sK0xjSXpuNHMvdW9sMnY2?=
 =?utf-8?B?dzhLS2FaQjVxVzVTR0VSZE9lNUV0NTQvNDk0ZVdUOGVVR3BOSzAzVlZabkhJ?=
 =?utf-8?B?V1N6QUFNVTJ5YSswRnpWVXBMUFRDcDNWVS9GZm9qTDRoZUxVNmlva25ETXEz?=
 =?utf-8?B?TnF1UUlhRks4VndzbjhBZzE2Y2htVytrWEdORERjY0FnK0NubGdVazdudExO?=
 =?utf-8?B?SGNRWlRCVjRxMXBKOXNmT3dQclF6Z0JZY1piT2FjeFpWaFBZVjFMR3h6RmVy?=
 =?utf-8?B?ZXJJckpXVVBBRVdDUDhkbjVUWjdTZjZvN3dyNkQ3OFIvYTdvdkIzTWxqYzhX?=
 =?utf-8?B?QVcvOEpjYjRpTCtCNmg4STE5YWwwSUxhUjhRc2FhRXYyTXhEUWlVRDlIY3Rx?=
 =?utf-8?B?VmR6OXZFZWRBckdscTl1azJnTHVVZElTblNXalJDYnd5aXVxUE1LemRSUnVV?=
 =?utf-8?B?Qm5zZWlhUlpWNUkvTmZkS1FQOGRBTk01d3ZZa2JsYllsTFNaS1VTSk8wQkky?=
 =?utf-8?B?MkczSjg4ZnQzSXZrbU5DY01xaE95cm1Pc2FnZzk2NWJhRUtHTGdlbjVnWjhE?=
 =?utf-8?B?WmtYN1ZudGNYVEpFdjVDR2hwQndOOHNCTzM1QVhnWmdyOGsyaTVhM21UR2RI?=
 =?utf-8?B?WjBSa29nZWRHNjBraytlUTR3TnFDWmVJQjNCeVJEZjMxWTRNN3ZzRENEMFdh?=
 =?utf-8?Q?f/AKuVsZ//vwzPGrJIwwslncU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a819f5-eec4-4a1c-9220-08dbbeb86c73
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 17:45:50.5741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aARbI5HQsRYyHKLScyao41zUnVq44o97ecpdhaiFcisZ2EzBWu1HSC1bJmxe6aZx41IQI3Nb+VFp7kOo8ZNpSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5215
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

Pj4gQ3JlYXRlIHNlcGFyYXRlIGRvbWFpbiBsaXN0cyBmb3IgY29udHJvbCBhbmQgbW9uaXRvciBv
cGVyYXRpb25zLg0KPj4gDQo+PiBObyBpbXBvcnRhbnQgZnVuY3Rpb25hbCBjaGFuZ2UuIEJ1dCBu
b3RlIHRoYXQgZXJyb3JzIGR1cmluZw0KPg0KPiBJdHMgYmV0dGVyIHRvIHJlbW92ZSB0aGUgbGlu
ZSAiTm8gaW1wb3J0YW50IGZ1bmN0aW9uYWwgY2hhbmdlLiINCg0KV2lsbCBkcm9wIGl0Lg0KDQo+
PiAgCXN0cnVjdCBsaXN0X2hlYWQJZG9tYWluczsNCj4+ICsJc3RydWN0IGxpc3RfaGVhZAltb25k
b21haW5zOw0KPg0KPiBGb3IgY29uc2lzdGFuY3ksIGl0cyBiZXR0ZXIgdG8gcmVuYW1lIGl0IHRv
IG1vbl9kb21haW5zKHRvIGJlIGlubGluZSB3aXRoDQo+IG1vbl9zY29wZSwgbW9uX2NhcGFibGUp
Lg0KDQpBZ2FpbiwgeW91IGFyZSB0aGlua2luZyBsaWtlIFJlaW5ldHRlISBZb3UnbGwgYmUgYSBy
ZXNjdHJsIG1haW50YWluZXIgc29vbi4NCg0KPj4gK3N0cnVjdCByZHRfZG9tYWluICpyZHRfZmlu
ZF9jdHJsZG9tYWluKHN0cnVjdCBsaXN0X2hlYWQgKmgsIGludCBpZCwNCj4+ICsJCQkJICAgICAg
IHN0cnVjdCBsaXN0X2hlYWQgKipwb3MpOw0KPj4gK3N0cnVjdCByZHRfZG9tYWluICpyZHRfZmlu
ZF9tb25kb21haW4oc3RydWN0IGxpc3RfaGVhZCAqaCwgaW50IGlkLA0KPj4gKwkJCQkgICAgICBz
dHJ1Y3QgbGlzdF9oZWFkICoqcG9zKTsNCj4NCj4gRm9yIGNvbnNpc3RhbmN5LCBpdCBpcyBiZXR0
ZXIgdG8gcmVuYW1lIHRvIHJkdF9maW5kX2N0cmxfZG9tYWluIGFuZA0KPiByZHRfZmluZF9tb25f
ZG9tYWluIHJlc3BlY3RpdmVseS4NCg0KQWdyZWVkLg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcu
DQoNCi1Ub255DQo=
