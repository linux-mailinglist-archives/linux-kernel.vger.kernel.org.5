Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F56D812BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443429AbjLNJb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjLNJbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:31:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7B2B7;
        Thu, 14 Dec 2023 01:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702546322; x=1734082322;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=Vu5XJ6P8p4HPA7b0V01y7Z87XedKjBMdhgn0ZyD5wYo=;
  b=Q6j86feGE/SrMyquAwb3LyPmeNNWb+seCpGmpC7MKgLh3aIX2O/uQIq5
   tu4mXPr2wXVhOxytOfIOwOjfO57D2nnM54//Tnm3SSMh5MOTtrO0nybCb
   WBj33EbamtMkCR/hJFKCLg5HjwDVY3AQ8AP4cq7fnoNHIR2Wq2ewpaP4v
   6nLOcrXrGce3EJaQr8CehTPtarm3Zn0XujhYwCtY+A2dfEkxjx9idRw6V
   JOf0Aoxd85Ik/WTbWwhRc9Ei4P5JuG6N6NPRj5Q45MziFWqwM3OK8T+41
   Q1s2IDg02kX1iFjgQmA8yAVYSNRVGFZGHGLI+gSm0OMOkCiR2YcEy4BHV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="2248308"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="2248308"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 01:32:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="767550791"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="767550791"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 01:32:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 01:31:59 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 01:31:59 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 01:31:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OB/WeI0MDZ00a5QgFG7EKyVLUn3InHfwwm1sUy3cyh98Y8dBgcKu0O6XlLzXrn6P2OjiumA1/Ep6SBLrNXQbVr/ZFfjkiEX8bBK0LnKjFVopKOIciFFfd48x99HPlMNfBZ8or76UJ+uEHiyU12a8ptlRQLZQHWwSIcaqoXKlyWxSsqdNKj6fsbGQJ+VLPyQeX8O/7aWv/ZWU4sa7OEAgvpWnWAQzyp6BgH4fSIczax0JpqulnKuoNWhnqxDs+r8YxeANS4okNLpLMZxcD1t82SHUIZ6SHR63ZPu9CJaxMf8fb55N3DN1aHsgAeavsjIsjPVeQePzFXo09/XxvFOwmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Qq5Lj+o4DmIErTOiRw47rt8vIZ77PT7o598EyPV3gA=;
 b=MzLtPDGHUOKcjKcvf2I0e6orLBLMr9DHuh9g0/qXZQzsuIeSE8ESPh9PZ68liMDQExjXoHwDwgO8SI0HqdjhK38Gvucz5eTXp1yXD9S0vMaBFdUmEK39hiRTlrlX6b4GJ8RPH3bJAq2JQIdps1wsd9G5As0xn/i9QcrFkF7J28xC9j83WaNiGSfLq2oR+GIYyZjpgpmXe6i4EAPfvIH59NDP6vdKdlnPlnJ2Y4ELb04Jye+QQ5d1qUUDRBLYcIzWlO/Rn2CI0f6w/VSvYAZ2Y4w3LxGNMJwTfkjxHeEV0yxNL6JKB7IBe1cZtercs9l8WZhKNggRKVRjwkDV/8aWGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5359.namprd11.prod.outlook.com (2603:10b6:5:396::21)
 by SA2PR11MB4922.namprd11.prod.outlook.com (2603:10b6:806:111::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 09:31:58 +0000
Received: from DM4PR11MB5359.namprd11.prod.outlook.com
 ([fe80::d3fa:b9a3:7150:2d6e]) by DM4PR11MB5359.namprd11.prod.outlook.com
 ([fe80::d3fa:b9a3:7150:2d6e%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 09:31:58 +0000
From:   "Berg, Johannes" <johannes.berg@intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        "naresh.kamboju@linaro.org" <naresh.kamboju@linaro.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "Berg, Benjamin" <benjamin.berg@intel.com>,
        "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Re: next: arm64: gcc-8-defconfig - failed -
 net/wireless/shipped-certs.c:92:1: error: expected '}' before numeric
 constant
Thread-Topic: Re: next: arm64: gcc-8-defconfig - failed -
 net/wireless/shipped-certs.c:92:1: error: expected '}' before numeric
 constant
Thread-Index: Adot078PtDDEl6shQJysZ7bF7F4DCQAm7U9AAAAwzQA=
Date:   Thu, 14 Dec 2023 09:31:58 +0000
Message-ID: <DM4PR11MB53594DB860C5FA1539FDC570E98CA@DM4PR11MB5359.namprd11.prod.outlook.com>
References: <TYCPR01MB11269DD29E89EF09A4B053C1C868DA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <TYCPR01MB11269A0200358724E126E7ECD868CA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB11269A0200358724E126E7ECD868CA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5359:EE_|SA2PR11MB4922:EE_
x-ms-office365-filtering-correlation-id: 7d19cba4-3d85-4d28-701f-08dbfc8784c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eDruQ9KlwdW0wBJ290hVbukTOo9SxNu0thclbU45FJzcxP76Rr/NlkIj8UPG8IPwAlUpcoLX1J9wPqhdkoVKOK+hfa87/1WmwQfCm/BFpBUN8EX+OWxzDfD5KIHmsl8bca/vnejxqK+a4wfmWUw0FoMy/dQT2JyhdRHbJn8n0rXoMSRWcSCOSRRN9ZXET21dvomDoBtATBStXg0uHZVpa/eOeaNK/dgVWd4Q/2gZg2ad1pAthBSGNbFPmle3A4wjkeApKhyv7U/cbzG+3MIMNrIN0uHTkJAnqUsmoS0FE3prQluAclriMLVf6O2av8Q4m/O9VWkqLoqcQr1oJ2+tCRGRAhRr21Dq4zCI+67fUhlcFZkYsY9xOdGAA/GvUjOlDAPfQREe47LCzJHbeNnVX9NtICaouQIWCWyOlk4IQ2/Be7vTfbAka8IZNSuhBJsoXeI+g634zJ032+z8pXUVfwbnsfzxaFhjtCQth00sJuJlNXmAs70Cwnbd3m6/P3c3T/t3Cbvqwl24n5D4xJXaYnmdgWItYr2o/cNd4ZT6j3jyF1rb9kpwL3qe8wZPvpoyjfBp+zWm4z7CN44iIkFESs4rLbsCObOQVPSfY4cko3QQ9evyywMc43p9RVzWLEl3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5359.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(396003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(122000001)(86362001)(82960400001)(38070700009)(55016003)(6506007)(478600001)(7696005)(83380400001)(26005)(71200400001)(64756008)(52536014)(66446008)(110136005)(54906003)(66946007)(76116006)(66476007)(66556008)(9686003)(316002)(4326008)(8936002)(8676002)(41300700001)(33656002)(4744005)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWJQbTRlYXd3OWpmTGwra2VPT20vUU04bGpaMFNJSk5XMWNMeFlLNkd2c0NU?=
 =?utf-8?B?K3dHbnd2cy9tdjZEaXh0cmhUNWJHRFRtM1FKMlczV25pZGxsKzhSTnR3Rk5Q?=
 =?utf-8?B?cmtPdFFnbStMamdJb1B6SlRWZ0FHMzYyRUI3YnY3L2NKVCs2TWMwU2syd1Z1?=
 =?utf-8?B?WUNHczgySjFpYjlaZzNJWTliWDhKaUw3MGk5WXR4bmk5cGlhNnhTMXpOOXdk?=
 =?utf-8?B?bE0xTmFBYUFuRFlXRlQ4UTd3aWNBRWR3TTg3TDFIQjdVaWlld0QyRVRNTTJ6?=
 =?utf-8?B?UFdDTDEycjJWbkQxZ0s3eHc4WkdXeG5Gdkttd0FJMG1zdThjSjFWOFIyY0c5?=
 =?utf-8?B?T2NTZEFUWW1xSHpNWFFCbTJISUpXeW5OeWZxM1k0eElwY3pNK0tkTWdmdnI3?=
 =?utf-8?B?cmZaa1JzeHhIVFhMNUd5VzFtYjBuSGpEUTJTTldJaWJsME9RbU9xZTJNelp4?=
 =?utf-8?B?enRFWE10UzREQjg4R05SZ2lUemZsczN6YTZWRDN1NE5aYmU4N29aVThPMGV0?=
 =?utf-8?B?TE1zK3Zzc3dyL3ZyTXgwMDliY2VjTm1kbThyS0ZSTkZnV2t0MW9oSjBNTkVz?=
 =?utf-8?B?RnhTa0J1VlVqcVlKUlM4MlJXbU1HNWxhbGNCYUp0TU5maDZ1R3VlUzN3akFa?=
 =?utf-8?B?R0ZUa0ZsUGdvbFhqaHppenlUWEJ3ckpxL1Z1SVRSbGZwU202VEl6R2JTb0li?=
 =?utf-8?B?dDh2TElLTkdQSENmSUFRdVdnM2NKbnhOM0pzS2ZpMEdRL1NLUDBOdGVxWERy?=
 =?utf-8?B?SGZaM252RHhaRCtYVTZNaERsbVA1MlN1Q0xTcFl4NkVFaytHamVaRGxNWTB5?=
 =?utf-8?B?U1UrS3JJZkw1aytsU3NJakJkMnI4Y2phQ2FBNjlZc2RTNTYySkE0aVIxNGhM?=
 =?utf-8?B?NDhKNmI4MmZ2LzI5dlVlTlpqNVJoTFVsbXdobGlzNkZQbko3U3dOSVgzMTQ2?=
 =?utf-8?B?R3RST0JPQXc1cmtqNWtvZkxzVUpnUGFGOGZmRWtWT21la0E4RllVQVBKVDQz?=
 =?utf-8?B?MFhIZFIzNDB2cVlocmZ6Q0xZVnV0Zko2Vkl0Uzl5anptcVhuMi9rdTZldENF?=
 =?utf-8?B?ejJtWVNnM3dwUFhUaWIvS0VWRWRpVlJuMzFXU05hUHJ0cjNhOGpUZzBObUIv?=
 =?utf-8?B?VUxZUUdUcWZpZXduZWNVUHpsVjZWU1dZQ3VJMFcvQWQreTNhVFRxenNNUnc4?=
 =?utf-8?B?WUNCbkhmTWpIVnZrL2JsU1dwaStBMk84WDIwbzJSTEw3WE1PNll4d2tqekxY?=
 =?utf-8?B?dy9BU2dHUCtIM1VvZ3JiYTA1d2N6SkdIL1JkN0w3bDBHZ0o0ejNLcVNZZjUz?=
 =?utf-8?B?MWoyZGRjSTZ2cUhJczdSVWVrM3lUTVhnZGxlU0lNM1ZsV1l5U3k5VVAweHQ0?=
 =?utf-8?B?dGs0NnI2NVFJRXhFOWpsQTFsSXV0NjhzYTA3VmVzOWtSd0MrZElVUUdnS0s0?=
 =?utf-8?B?YkRQbHVpQ0xYQWV3b2swb3FqNmRZNUEraU40dGVxZXRMR2x1QUI3ZGhUaTE1?=
 =?utf-8?B?QWVZRGVXL3JQSG9mRVgzV1h0dStoQ3VzVzRsdmVhL3JSK3gyQm5oZjFCL0F1?=
 =?utf-8?B?Qkp0SWFaempNYVN0T2Y5c3BpclBDSktUaVJTVnExN29KeE9TTnZSK1ZmT2NE?=
 =?utf-8?B?U0VTNWt6UFZ5SEJaVFp5cnY4K1pnQzdxNm1zeXFjTVRYajV4MVNGSG5OblU3?=
 =?utf-8?B?M1NqV1BtUG02Rjk3SFhvbDZ4b0ZqVXoyVmJjSW51WjdLUUY4U01DV3hHVjgz?=
 =?utf-8?B?UUhSd0U2R1BibFZZTXp4YTdiWjhHMGxJSWtINGNNejFyZ1cwemFsRGlaTzY0?=
 =?utf-8?B?OGdaRk1jV0Y5VllKaXpXc0VXbXJiM21NclJDbDZoWHQ3S2traTBzRE1wZGtW?=
 =?utf-8?B?NjJ1ZnBkSEZmeSsvNnVwMS9lajZPSXVtY3JNTzFrbW9KVjNvdEEwTE43WFZj?=
 =?utf-8?B?WUhxR2ZEL0Z2aFhmNHZaRjhQbnltZWtCazBDOTlsODNSb2JMVTNIaHNtTERC?=
 =?utf-8?B?ZitCTE1ZMlhQS0RHbHEzaUhwaEJuMkFXMDdEYnYrakk5bExlR1JUU253YnNy?=
 =?utf-8?B?emN2dENmQzVBNmtsV1ZTazNLRnI3NGcxb28xbUREc3FrM2FCNlpPY3cxem1t?=
 =?utf-8?Q?aP5PjjTHAwYtRqkcvPevPF1+W?=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5359.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d19cba4-3d85-4d28-701f-08dbfc8784c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 09:31:58.1368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZMyyPGI9LPEW35GT0Yxg6jTN5CEE5wUlC2sJKwLR587bCUCLCn64LRKPOPn2CLIy4F2zanWF2okcAgiRrlLPfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4922
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gRllJLCBUaGlzIGlzc3VlIGlzIHNlZW4gb24gdG9kYXkgbmV4dCBhcyB3ZWxsLCB0aGUg
Z2VuZXJhdGVkIGNvZGVbMl0gaXMgbWlzc2luZw0KPiBhIGNvbW1hIGxlYWRpbmcgdG8gQnVpbGQg
ZmFpbHVyZS4gSXMgaXQgYSByZXF1aXJlbWVudCB0byB1c2UgbGF0ZXN0IHRvb2xjaGFpbiBmb3IN
Cj4gbGludXgtbmV4dD8NCg0KV2VsbCwgbm8gc3VycHJpc2Ugc2luY2UgSSB3YXMgb3V0IHllc3Rl
cmRhefCfmIkNCg0KVGhlIGlzc3VlIGlzbid0IHRoZSB0b29sY2hhaW4gb3IgYW55dGhpbmcgLSBp
dCdzIHJlbGF0ZWQgdG8gdGhlIG9yZGVyaW5nIGluIHdoaWNoIHRoZSB0d28gZmlsZXMgYXJlIHJl
dHVybmVkIHdoZW4gbWFrZSBjaGVja3MgZm9yIHRoZW0uLi4gSSd2ZSBwdXNoZWQgYSBmaXguDQoN
CmpvaGFubmVzDQotLSANCg0KSW50ZWwgRGV1dHNjaGxhbmQgR21iSApSZWdpc3RlcmVkIEFkZHJl
c3M6IEFtIENhbXBlb24gMTAsIDg1NTc5IE5ldWJpYmVyZywgR2VybWFueQpUZWw6ICs0OSA4OSA5
OSA4ODUzLTAsIHd3dy5pbnRlbC5kZSA8aHR0cDovL3d3dy5pbnRlbC5kZT4KTWFuYWdpbmcgRGly
ZWN0b3JzOiBDaHJpc3RpbiBFaXNlbnNjaG1pZCwgU2hhcm9uIEhlY2ssIFRpZmZhbnkgRG9vbiBT
aWx2YSAgCkNoYWlycGVyc29uIG9mIHRoZSBTdXBlcnZpc29yeSBCb2FyZDogTmljb2xlIExhdQpS
ZWdpc3RlcmVkIE9mZmljZTogTXVuaWNoCkNvbW1lcmNpYWwgUmVnaXN0ZXI6IEFtdHNnZXJpY2h0
IE11ZW5jaGVuIEhSQiAxODY5MjgK

