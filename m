Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C476875CFDA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjGUQk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjGUQkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:40:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BAB2D51;
        Fri, 21 Jul 2023 09:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689957610; x=1721493610;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vuorpe9YOtqdwYu52z4sYNE1Z6kEENEnvGuWNG/Xgx4=;
  b=lE0lspGCfPqDGIYHXO1U64njVwqC8pwiprj+tgU6TnDB5mZh/n4uJKk0
   3PoQuVw+fIrT2/g+NnhmgIQQBisQAHkB6uNrhqvTsnr2n8Un1oN8+enja
   rSAl6400w8thM7b2PUS10uEQHrNYfBYbM5pNpO3Ot17djddWfVfDENOX+
   6jtmF7+kHSbKHnLvVYhH0EvT6jmKccrYyH9Zdda8Ric9XAcnYuZMRw43m
   gcGF6tc6tyg7nJilVkpCA7JKRSdeOICZQY1ChcwROKQ2cJwiqt+z2i8r5
   BBaCL1GpDFNaFBsKdGtcs0vK9lT+NPFktW0YUaRLPzBEXmRoVXdQPERf9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="357054459"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="357054459"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 09:39:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="838625007"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="838625007"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jul 2023 09:39:18 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 09:39:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 09:39:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 09:39:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZnrY7D0TW6orcgoRsvOXQX5VCr+biOBxF1Oms9AtQmgqznvqJ5yS/cV3/40Xt/B9zKNcUocmlTc7JmvWNvZCKTT0eXt7Lr1QzZUin1pAZsP+GaW+/ksiXhSDbyvPsQW6zaJUseWWyYSsz2uOmAKsfNiIngoJgUD9ZzZP+USZpwmVTYSDOS0uUo8u5C93vkNETMh+yf8kcnrI2DeKwJapdrqTs63ClaJ05Te6utO7oCXONintgpzs4iZc6yHkzc9Gh5UF5yuz0pqewfbJGKvQ/tJlBXapwbc0+sxHYUrkbChd9hE/7Qf8xgotfbgcvjIy4TomXyvjLSH7n+k9ITBRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuorpe9YOtqdwYu52z4sYNE1Z6kEENEnvGuWNG/Xgx4=;
 b=hboYcc3RYhTc5tTwLvMTejJC21nKipRo2i9Y1eg5iY22jQJsrkyLom0SxRUQrqLT69H7oyYcWziy/WkPWKz4EoAsLS0TDarBZaHGGplZet3H7z/PX19C5MaoIzzGfCpmk3qy8MhOJbMy3LombeZnZEK7qb/h84TKNDBy0nKQvFrein1schA8a8HDnLlANf3A1DjEVc2O23JJnDRkbyB0+Nn1MqpXvWQEVu5r3FnB3ntUpXxsteil8YLDpsUWp96Fc4pE62zaLDM/j0SdcrEq9MjDrvF1b0jygUsrNVaSBma6+Mya3lGidjua1nWGF6K7aDVvNwrl63reXzLMVLQjOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 SA2PR11MB4795.namprd11.prod.outlook.com (2603:10b6:806:118::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.23; Fri, 21 Jul 2023 16:39:10 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531%3]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 16:39:10 +0000
From:   "Ng, Boon Khai" <boon.khai.ng@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Boon@ecsmtp.png.intel.com" <Boon@ecsmtp.png.intel.com>,
        "Khai@ecsmtp.png.intel.com" <Khai@ecsmtp.png.intel.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Tham, Mun Yew" <mun.yew.tham@intel.com>,
        "Swee, Leong Ching" <leong.ching.swee@intel.com>,
        "G Thomas, Rohan" <rohan.g.thomas@intel.com>,
        Shevchenko Andriy <andriy.shevchenko@linux.intel.com>
Subject: RE: [Enable Designware XGMAC VLAN Stripping Feature 1/2] dt-bindings:
 net: snps,dwmac: Add description for rx-vlan-offload
Thread-Topic: [Enable Designware XGMAC VLAN Stripping Feature 1/2]
 dt-bindings: net: snps,dwmac: Add description for rx-vlan-offload
Thread-Index: AQHZu5xgG1a+wZGOqU+EmB1OiRdona/EAA+AgABTXyCAABV2AIAAAmPw
Date:   Fri, 21 Jul 2023 16:39:10 +0000
Message-ID: <DM8PR11MB5751EB51168E04E186C33A72C13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
 <20230721062617.9810-2-boon.khai.ng@intel.com>
 <e552cea3-abbb-93e3-4167-aebe979aac6b@kernel.org>
 <DM8PR11MB5751EAB220E28AECF6153522C13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
 <d58cd6cc-70a9-3759-9af2-c4a292440767@kernel.org>
In-Reply-To: <d58cd6cc-70a9-3759-9af2-c4a292440767@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|SA2PR11MB4795:EE_
x-ms-office365-filtering-correlation-id: 958ad9b3-6d9c-476d-37f6-08db8a0902a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yb144kZiRfuP8zQxzo6m7gmP27OZZakliUJEwtyf5Y3eobb5/MvPdsj173cntUS8YhDBbano6hjtzFMIMQ/5Mjg3vqxetDWnQ2gsOjJ3SklQTfcR1deMhleeRg0jKFouHWhJXiI6/Ag0e4lREEMCzQvlOWYwVJqLROz+Xo5aRSh+0NqpRUjT6hNGZiuvrmMCKM90isikNsD9vWL7l6j9hwsIsiqf0EAngRPC2+EMyhl/X/+5Aqzv/HfhPaQHlvfLTH8fpTKbT518JrR3gcnw4tr9TAwrvCp2Ilmc7f3vyxyRi7B01wKF1u2bCwPjufQojmPRSl/3qKNPjAxGxzBHGNySmgKuzCKM5gK0zve2pot+oZEus3yiexAX8S7a/7CI5DT72dhkd50q27O27IwHpVjFgPqjK43egSLpQu+fokDRrIMSmZRYk/hDnOmL55BxLmAXPVyCvBUhBBxXBhVDzESN7er7uKb+ct0etZEeJy1Lsv7EvKzap03mOBZftxd82SuWCBTsjOn7IjVKqVjTOruoT4QnuNfSj7fU2LiiShYP/BRfsALDQPqtBxO+a2O2Rsu0fvrh0fWl+41yzTAW4IIqSDyspJChaTo7ziigCUWJtMVMEb1DJZxbwUERsYNV8irGdz0eK0w4UmG2PQQpvz8c4FwHN3b8WY8YR5VDr50=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199021)(921005)(66946007)(122000001)(64756008)(66446008)(83380400001)(66556008)(8936002)(4326008)(66476007)(55016003)(186003)(7696005)(110136005)(54906003)(6506007)(53546011)(26005)(478600001)(76116006)(2906002)(316002)(9686003)(33656002)(86362001)(38070700005)(41300700001)(7416002)(71200400001)(82960400001)(8676002)(38100700002)(52536014)(5660300002)(168613001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MENTMU96ZTJSTmhQaUlRS09SNWhmZmh6RnRNNjZGSEZGQ2Vpd0lyR3VleGFz?=
 =?utf-8?B?SEQ5ZGJyS2pOcGNIVFJhNnp6ZzdhWkVGY2F3ZE4ydEgzZWtHa1gxOGwySXdH?=
 =?utf-8?B?MmpjUVVqdFhaVkVTRzdqNWpFOXYvbGhidzVUZ3FXQ1kxYmhRZm5XakJhcUNl?=
 =?utf-8?B?WTU3MFhldXA3ZTVkeUt2ZStxWVIxZk5UaDBXcFNwem11UnpvZHgrVXRDNENL?=
 =?utf-8?B?UWkyWnFTQ0U0VXpGWERnZHI2azBZZlFuVm1zUmRPWFliMzY4bjR6YXVrUTcx?=
 =?utf-8?B?ZnNyZEx2eGRoUTREZGViYk9OZ2NvTGxwZkdNRU8zbWFiZ0h1K2VCSFRMQ01F?=
 =?utf-8?B?MlJOaEJhN1k0YU9BaDlhWXNTLzBSMFpRVjR4NG52Z2R4SXZyaTRBOFVMTVgr?=
 =?utf-8?B?UVU4MGJYWEdrQ0t1aC8zblR6UnUxR0sxUXZTc05NVjZjd0hVOWxZQWRtMHVj?=
 =?utf-8?B?MWk1NU91QzVYTjRzbHprSFN4UFNnYkpjSFczanZRVzZxOW81THhJdXBWcDFx?=
 =?utf-8?B?TE53Rm45KzZJREZPdzVRWVp5Wm4vZEx2ZU9JbW9SeDl1SDVLSjJXNmQ0ZGE4?=
 =?utf-8?B?dUkwaGRMVTd1ekF4cnYvazFSRWEveVlzMklmWVZuMlBaSkZiREwwNU1QUHUx?=
 =?utf-8?B?YTdpazlBQS9xb1R2cUtHOE80OEZqQU0wZUZGdGVDVFJSYnc2R1F0ZC9tRTVy?=
 =?utf-8?B?ZmtNSjQzd3Erc0o3K2lOL3NSVXFCeWl5QzZVeUx6dEFvVEUzckUxRXlOSHdn?=
 =?utf-8?B?OVQxOGJsaEdrbnZRajl0STYvU2hIM1c4TmlwekxBRHlzRnhtOGgrZm5VeThm?=
 =?utf-8?B?aGJ3aVNLL2dacWp1b25wRHo2K2w5WWxDVzFUd2NIUUxLUmlpSzJqMGliRHg2?=
 =?utf-8?B?VHpKcUtuQTFDZ3R6N0VzVUxLcWpvSXl3WS93bmVhei84dUphamFBUXZDVEEy?=
 =?utf-8?B?UStPVE1GSDRMNlNDTTFZckF3ZGhLS0kxK3NxbUdJc1RpQWxiOWt5Zk05dlhL?=
 =?utf-8?B?OGw4aENLRWR1RXo2Y3FsYUkxekJLU3Fod05HOERtblhzNDMxdlduUjBUajhi?=
 =?utf-8?B?VnZ1WlVkbitvSlRVdEVualkyREJXTmcxVlBaaEN6NlRZOVltekl4emYwcDB1?=
 =?utf-8?B?ajRycmhISlBvRWlzeEFDZy81czJBalRhWEN6Y2ZyRDdoUkowT2FPelZBbEk3?=
 =?utf-8?B?dGhyQ2dZS0UvYUgvZWdjcUh4aVphY0pzTjRrWXRlcEhyR1BmZGJIWHh5VUQr?=
 =?utf-8?B?b2EzVmFnYTgwN0RiWlYvUHFpRDhXNElCYWJTUlAwMVF2RndWT0dveHBIMDNN?=
 =?utf-8?B?QlFIdm1MUE1zK1NhWTBjMmFUeE9QWllxdWtBSjBIVjVacU5pL3JZRE14NTM5?=
 =?utf-8?B?N3RuemdBZDNEVGRvNlBaSElIRzlhVVZVdm5rR3U4bnd1QWV5N2ROUmcyZUhu?=
 =?utf-8?B?ZXZFeUFockowTHRjWHlBcHFFWlM0NWVtYXl5R29FVkxJZVBYa0Rud1BUNkhZ?=
 =?utf-8?B?ZVlSNlNUcCtyK1NYeFlGTlRVTW9OcmdCanZYY1VYaWJMMzhrclovQ29oWHho?=
 =?utf-8?B?MlFWK28yOXpRb2w3ODBtbzV6enRRVTlDdEh4WlZwc2YxVk1yem9pVGxyM2FK?=
 =?utf-8?B?akxkWkt3MTZWWE45RFFBYVBTek9lMWM0bmJmb2oxelRoUTdhY1o0NCtKVS9t?=
 =?utf-8?B?WGZPdGhrVGlLUlpVdEZ4Ylc4YmtHbmxLaFBORzFyQ0k1SnhCZEtRejJqTGF5?=
 =?utf-8?B?S3NzN2xPcnNQRk9lNWozYTNpdlNzd09jM1R2VzVDdGM4S2dKQ0E0K0tzSkww?=
 =?utf-8?B?MEJ3Lyt1UnhsRUszVmpiTitpc1kxSkpWc1JiVGdsVzhMZWg3NUplR1d1aVZs?=
 =?utf-8?B?OUVkYWcxZ29qVXU5Y2orTm1CbStWUGlsY09mSms5QUhDblJMRXpob096R1Qx?=
 =?utf-8?B?RVlwd0dPbExRVnpRZ2hVcDRUb0w3cStMWmNQVStYb3IyM0R5QkhKZmVzVUZT?=
 =?utf-8?B?clRicE04aytUNksrSmxMM3NtV2hNcnJubWlUWEpET1VaVW9SYVV3Skh3bzNr?=
 =?utf-8?B?aWI3N1VuVnRrTTdpd0Jld1gzVUszN1JVZmlJUHB2bEZ5c3l2MzBzNWUvQXMv?=
 =?utf-8?Q?RKHh5nN/ySTNDJ+kPhdtAz+kR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958ad9b3-6d9c-476d-37f6-08db8a0902a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 16:39:10.6584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XRUuA20DpCh45RLocoIDIupCuXPOtzU1+NUrDcawzWAG75Yp1IqgSlZGUMCysrTcMJ/8eHvBReoqvxW6P/ESsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4795
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFNhdHVyZGF5LCBKdWx5IDIyLCAyMDIzIDEyOjI2
IEFNDQo+IFRvOiBOZywgQm9vbiBLaGFpIDxib29uLmtoYWkubmdAaW50ZWwuY29tPjsgQm9vbkBl
Y3NtdHAucG5nLmludGVsLmNvbTsNCj4gS2hhaUBlY3NtdHAucG5nLmludGVsLmNvbTsgR2l1c2Vw
cGUgQ2F2YWxsYXJvIDxwZXBwZS5jYXZhbGxhcm9Ac3QuY29tPjsNCj4gQWxleGFuZHJlIFRvcmd1
ZSA8YWxleGFuZHJlLnRvcmd1ZUBmb3NzLnN0LmNvbT47IEpvc2UgQWJyZXUNCj4gPGpvYWJyZXVA
c3lub3BzeXMuY29tPjsgRGF2aWQgUyAuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVy
aWMNCj4gRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJh
QGtlcm5lbC5vcmc+Ow0KPiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBNYXhpbWUg
Q29xdWVsaW4NCj4gPG1jb3F1ZWxpbi5zdG0zMkBnbWFpbC5jb20+OyBuZXRkZXZAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1zdG0zMkBzdC0NCj4gbWQtbWFpbG1hbi5zdG9ybXJlcGx5LmNvbTsgbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiBDYzogU2hldmNoZW5rbywgQW5kcml5IDxhbmRyaXkuc2hldmNoZW5rb0Bp
bnRlbC5jb20+OyBUaGFtLCBNdW4gWWV3DQo+IDxtdW4ueWV3LnRoYW1AaW50ZWwuY29tPjsgU3dl
ZSwgTGVvbmcgQ2hpbmcNCj4gPGxlb25nLmNoaW5nLnN3ZWVAaW50ZWwuY29tPjsgRyBUaG9tYXMs
IFJvaGFuDQo+IDxyb2hhbi5nLnRob21hc0BpbnRlbC5jb20+OyBTaGV2Y2hlbmtvIEFuZHJpeQ0K
PiA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW0Vu
YWJsZSBEZXNpZ253YXJlIFhHTUFDIFZMQU4gU3RyaXBwaW5nIEZlYXR1cmUgMS8yXSBkdC0NCj4g
YmluZGluZ3M6IG5ldDogc25wcyxkd21hYzogQWRkIGRlc2NyaXB0aW9uIGZvciByeC12bGFuLW9m
ZmxvYWQNCj4gDQo+IE9uIDIxLzA3LzIwMjMgMTc6MjgsIE5nLCBCb29uIEtoYWkgd3JvdGU6DQo+
ID4gVGhpcyBpcyBhIG5ldyBkZXZpY2UgYnJpbmd1cCwgdGh1cyB0aGUgRFQgaXMgbm90IGF2YWls
YWJsZSB5ZXQuIFRoZQ0KPiA+IERUUyB3aWxsIGJlIHVwc3RyZWFtZWQgYnkgbXkgYW5vdGhlciBj
b2xsZWFndWUsIHVubGVzcywgaWYgSSBjYW4gdXBzdHJlYW0NCj4gb25seSBteSBwYXJ0IG9uIHRo
ZSBzZXR0aW5nPw0KPiA+DQo+ID4+IFBsZWFzZSBraW5kbHkgcmVzZW5kIGFuZCBpbmNsdWRlIGFs
bCBuZWNlc3NhcnkgVG8vQ2MgZW50cmllcy4NCj4gDQo+IFRvIGJlIGNsZWFyLCBzaW5jZSB5b3Ug
ZG8gbm90IGFncmVlIHdpdGggbXkgY29tbWVudCB5b3Ugc2tpcHBlZCB2aXRhbCBsaXN0cywNCj4g
dGhpcyB3YXMgbm90IHRlc3RlZCBieSBhdXRvbWF0aW9uIHNvIGl0IGlzIE5BSyBmcm9tIG1lLg0K
PiANCj4gU29ycnkuDQo+IA0KDQpJIHVuZGVyc3RhbmQgdGhhdCBJIGFscmVhZHkgZ2V0IGEgTkFL
IGF0IHRoZSBiZWdpbm5pbmcuIEJ1dCBJIGRvbuKAmXQgdW5kZXJzdGFuZCB3aHksDQpQbGVhc2Ug
ZG9u4oCZdCBnZXQgbWUgd3JvbmcsIEknbSBub3QgZGlzYWdyZWVpbmcgeW91ciBjb21tZW50cywg
d2FzIHRyeWluZyB0byB1bmRlcnN0YW5kDQp0aGUgcmVhc29uIGJlaGluZCBhbmQgYWxzbyB3aGlj
aCBhcmUgdGhlIHN0ZXAgdGhhdCBJIG1hZGUgYSBtaXN0YWtlKHMpIG9uLCAgdGhpcyBpcyB0byBo
ZWxwDQptZSB0byBsZWFybiBhdCB0aGUgc2FtZSB0aW1lIHRvIHNtb290aGVuIHRoZSB1cHN0cmVh
bWluZyBwcm9jZXNzLg0KDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
