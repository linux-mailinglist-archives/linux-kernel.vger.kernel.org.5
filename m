Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5489475CBB4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjGUP3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjGUP3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:29:04 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D0D2D4C;
        Fri, 21 Jul 2023 08:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689953340; x=1721489340;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0uj7w7D3f4vLnclAo6oRJsghLULyJTPCI+tDXEg7g/I=;
  b=fSqKvbrWeq+TMT26uPNhxDEZbumYri6ZijdAqhvwAKPEdG9MY9iFkKZa
   v6+Z7Y8Et9UlSrkuRuGBtk0NUvs96RfRpFj6rl9igkeyaOHdvnF3/CyzC
   wuyVsT6pGw9Pfb6rs4sDQUMAd8vPYP3lw+ZpP/DaQMEFTPzuZxw/mYl1L
   8FBBoPammMlsnWIFMoDCPDCnUYGJyByadGXK+ec/+onTf0dMDCwuRARMy
   mUsphXOrLsUKbRaL0vbdiXb3o6OgpEAIeReMabYE8JQv4SBFVWdF//x49
   W2rL4S1BT0eUQUSdXcqalMkiQNh7bSZ++aqbOm2ThylFAzknX6Fw5IUrQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="369717769"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="369717769"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 08:28:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="848856327"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="848856327"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 21 Jul 2023 08:28:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 08:28:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 08:28:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 08:28:36 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 08:28:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzrA3oSzqViXeEAZ2tA40X4eyRSpbG4Ig8BjBcQeWR9j7+8eTF7SVMmIjLd3uxSCAEqeI6Eidn15dRdkavENI/NRfu7ApnyHeYYJZ/ggX0JZYiRuvFGUffB60WLTKDwavsSgBHZJaXWkxu9ruVBo9KDvjRtCnLRGUfwm/IurcqKKi1sPghNrPlKpCrQo7+ORXFTSgPqBbJjL/pg52/Ba1yTp7XlpngHfML4wJ08zfNXq2ImzlMQqTRtbYAgBq5J6FTBzdoVrqjEVfYr8pJ8Z8RzD8TMxOrwc20MLbhOqTwZdP70CqVqx4IWgLTgzlrr6AD5NtsvW9xGpwJaVuwwDPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uj7w7D3f4vLnclAo6oRJsghLULyJTPCI+tDXEg7g/I=;
 b=YwlGACPLwmKJB0li0sVSnICgAU+SrX/jJaJmtzPQlGBfWdkkSATrtZvUhv/mj3QBiR5HMsknWTlCFX5Dm0eQ87S9zA0g70W7N0n0EYpVHrH/4FNXokUJR/gynMVjGEC0r3xD9SBl0WzIcjDCcyy4zmLd3qgs23nL+XcpYr7WcntwXSLylaC5k23An0tO591MsTYm7M9Cv2arCBPtqM40TnoEuPeqGOFTuPe8q8Eh4bigB6qTpfNyGIZNfwMZUIEn+W616UtPdsIx1Ogr9H/DzskmYipXs6Mf5BE1/UC1A5O9kxYc/OW1ix2x8G3P6+qZD+ebnFDphI0+hrV7Pma6pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 CH0PR11MB8167.namprd11.prod.outlook.com (2603:10b6:610:192::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.24; Fri, 21 Jul 2023 15:28:34 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531%3]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 15:28:34 +0000
From:   "Ng, Boon Khai" <boon.khai.ng@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Boon@ecsmtp.png.intel.com" <Boon@ecsmtp.png.intel.com>,
        "Khai@ecsmtp.png.intel.com" <Khai@ecsmtp.png.intel.com>,
        "\"Ng <boon.khai.ng\"@intel.com" <"Ng <boon.khai.ng"@intel.com>,
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
Thread-Index: AQHZu5xgG1a+wZGOqU+EmB1OiRdona/EAA+AgABTXyA=
Date:   Fri, 21 Jul 2023 15:28:34 +0000
Message-ID: <DM8PR11MB5751EAB220E28AECF6153522C13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
 <20230721062617.9810-2-boon.khai.ng@intel.com>
 <e552cea3-abbb-93e3-4167-aebe979aac6b@kernel.org>
In-Reply-To: <e552cea3-abbb-93e3-4167-aebe979aac6b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|CH0PR11MB8167:EE_
x-ms-office365-filtering-correlation-id: 863504ba-7bc5-478b-e717-08db89ff25b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FCVSKZY5ONoi72AWEHq3iMUi4aXvbcxrt8dEUnm/O3AXZq+blIeM136lBaInkZ2nH1RgrSzj9zU/750UPpP7UqrZ3bCQkH5/UrEEDRAy1Zy9nXx2yxWTp0C1aELWRRzxaKrZMt3atH7HNSVGpFgDPd6fzpAMQqawUyOM0rjq+jIaACpIx1r0ayIbqyA5Ls9pDPlMP2cMTutrIe1fS6vRmsz/3t5wQc+BtWTPZskoU65miZEmZbykK3i/cgH7lMiDNOV2EpgQ38uyMGz4tUMo8yZ4BWvcIURblLtIaGso56QdeFLZP8NFct+VQA8DrnVQ+rkmYMRx79NhjaGmMHWuD0TNFPCKmFpeMjxC9bGVxPfHK/jmtEO7LIlfqawaSFCiylqOcWOGMGCkx2mS173+GrkBLj8mmvzbTfGey272vVX7dRVTDBN8zyz+HIcAJDLoHVBlv4howEodofU+ueHR5/stn6vATaZitusco/6wzko/WkPdxahx9n87gehuy5prXzisBlPtM/YmvwggOdq98s+HOjZqh+IzsyWtSGCULr313K+woJ01Wa8ML3yxPEgpSIzStnVaG980DBo41gTXBZvqG9rljhO6amC/fCdf2VqFjlaVXCg0WycEgHgh+LsAgGDiCDYTXYfmGfC21IP/YFhR+JwbMnm+GWFeWM4IzEw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199021)(55016003)(26005)(186003)(6506007)(53546011)(83380400001)(4326008)(64756008)(5660300002)(52536014)(71200400001)(8676002)(8936002)(66946007)(316002)(66476007)(7416002)(66446008)(54906003)(66556008)(76116006)(41300700001)(110136005)(9686003)(2906002)(478600001)(7696005)(122000001)(921005)(33656002)(82960400001)(38070700005)(86362001)(38100700002)(168613001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UExFbERmTDl2MmlHcC8rYUhjeXllb0ViS2NjcFJtQXl2WDBybFRyaFY0ZDVS?=
 =?utf-8?B?ODVqa0JhVGhCWGE2emhrNlhEYXJBVkx1VjEydDVrZkVxaDhIZUlhbmNsMXVS?=
 =?utf-8?B?NEtxRHRFNWhiZ0NiWmZvQjZMMVkrRlRjZUhBbnFBVDAxaVZNREFmYkl6ZW9i?=
 =?utf-8?B?U0ttWld3S1p2QkFmNHBFL3RCdmRxZ3d1ZjNGNWZrZER5MUhERWRJRG11TmJV?=
 =?utf-8?B?Vkk1dEhMTnk4SlpUSXZ5dnNCblJpQXd5Rk1DSjU1djdSaWJiNHQ5MjBwWnVC?=
 =?utf-8?B?bEdwa3JNNi9ITUJDUjNibG1xbUwwa3RGcFhxbmZqUmdBV04zK1phV0J1TEtW?=
 =?utf-8?B?bEJ0U2w4Mk5DdlljUGtGREc4dlo5Yk5lMUxhcWw4OVdaMjdkMHZvR1cvNFZJ?=
 =?utf-8?B?MHQyS1R3djYvTys1Q0NaQXhEWVZRazZudDlNMU9FMHdidGRtQ2dOdTBkYnRD?=
 =?utf-8?B?c0dyQ1M3RjMyRllUSElYRUdNOE9VTU14SExlTnpJQmdGSGphc2M3OUNzVHk5?=
 =?utf-8?B?NzEvdjYxcnQ0YVpmd3lKbG9tWm0vY3RpeDBHQmxZWDJmUVd5bGNTa0srZ3gy?=
 =?utf-8?B?Y0tPQm5Wa29xMjQxSjZnd3NNakhUcy9JUzBiUDgvUmZjQ0NLUy9lWjVrMld2?=
 =?utf-8?B?NHdwZGJ5c3BBTUxkZGpJd2RCdG9jS0FMcFBOWjRscXZ5ZG1penJiMU9qbERX?=
 =?utf-8?B?REdXUXozQmgzd21EZmxZT25sM2JzYWpjSnVKUU9DbWpidjFZdTBKWnA5Qk0z?=
 =?utf-8?B?Rmw3UnJFZHd1RmlhWWpza3FBOHdhaStzUENHNmhDTVRMa203bkJwazR5Ynoy?=
 =?utf-8?B?R0pjbHlkZTkwbEFrcTBURkFVZzNVQWFJWElWY0twYWdlRlBhL1J1T2xoU09q?=
 =?utf-8?B?SG9HODJuK0k0ai9sV28xczFyOU9aVnRpMVpOK3NrNEk0VFFmQ2FHZ25qR2R2?=
 =?utf-8?B?WE9VemZqSG9ITGtCNFdkZmVqdUFRQ3JGMGorNElrSzFveFRveS9VSFdxWThL?=
 =?utf-8?B?VTVZTkpLaGlodVVMUDF0emNCcU1mTHVWd2twSjRubyt3R21lSUY3QnNVcGpv?=
 =?utf-8?B?eFl2cTZhR29QbHlnUU5wRlVNcm9VcGFHVTNBWnhEOFk4TzNkcDNqVkNRMVJY?=
 =?utf-8?B?VSsxOGRDUXd4aEg4OFJINVZZOTVrUEdtSGRtd2M5VFNGT21yVkdNbmJmUzhB?=
 =?utf-8?B?d3dRNkRQMXQzeHV1dTdobGQ1V2VUREFBaURLd1NUcmRmcW9mV1NGMXlQUU9s?=
 =?utf-8?B?MzZublhNYy95N1lCVGovQ3c3R0tDWlZKaUNKM2R1ZzZjSUtYMlVzSW95MVZX?=
 =?utf-8?B?L3g0cVh4cUwwMktrMGxsc1oxTHYwQXlTKzJqVTZyVHJvUzdaSGVmUGYzQVJ4?=
 =?utf-8?B?djZmRlREOVpoVnRUS2k0Ym1FaXgwOG11MDNKMFozNGViaTdJR05JQ3QvazIx?=
 =?utf-8?B?OWM1RXB5RDVPYUgzMWRMa0MrcklnVFVZM2lLM2cvaWJaQVdZKzQxaDA1SUtT?=
 =?utf-8?B?bmF6Mjcwa2tDTkZCN1V6OEd0Um9ibFFWaUEyS2dFYTUyTmpHVjNNbUlmSk11?=
 =?utf-8?B?SWxTQ3ltdFFVWTYvdlF5MSt3cTlkOTFmSzdRU1NDdU1FeklnaEZmeTRYSldx?=
 =?utf-8?B?S2tzMlpOY2FGclF2cUtYbUdTYW54QVlDVHVzN0RITEx1RWgzMlpIMjQzV0ZN?=
 =?utf-8?B?VUt1L0wzYVYyMTUwQ3ROeHp3YjVTc1dZdXdLajBxSGpQR0ZIQmZ4blBPekxq?=
 =?utf-8?B?Sis2Qy9yWnpETVFzQXJQSnZPOHFSY3M2ajRMdUs4MVhYMUNqbDhXbExGZkVD?=
 =?utf-8?B?VW5KeW1DME9QVnNxN1JMcER1d1VwTy8yZU1vbHR3QTRRaWZ6SllLUmRjbDYz?=
 =?utf-8?B?Qm9WTElQZUZSNFJ5eG9UdDRzakVBdS9OTE9WbkduUzdaaFBOaXp5UW0rcllK?=
 =?utf-8?B?cDM2M2pIMWMvQm1YSzhBQkJtRGtNV0c4ak91RTVubjdaV3N3OGZNdmxEeDRh?=
 =?utf-8?B?aUkxa25TVVZXK1V0TGFaZURDZm4vSlhRSEhlN0NCTzd4OVZpMzJYQzlMc1F2?=
 =?utf-8?B?TG9qS2J5SkJzT242QThxNEx6S3JLQWlaclhWc21wT0JqbWRGdTRiQ3Q0ZGVz?=
 =?utf-8?Q?qBl8exmWzfoFtYMQQtXfhuP8M?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863504ba-7bc5-478b-e717-08db89ff25b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 15:28:34.4913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UK9bTauuKQoMT/Soako6tvyFGat116aCaC70KL2P8lLnA16TMKCzkkC9Rn2/MEJc74kQoL8n4ROA90Up4Ms1UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8167
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
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgSnVseSAyMSwgMjAyMyA2OjExIFBN
DQo+IFRvOiBCb29uQGVjc210cC5wbmcuaW50ZWwuY29tOyBLaGFpQGVjc210cC5wbmcuaW50ZWwu
Y29tOyAiTmcNCj4gPGJvb24ua2hhaS5uZyJAaW50ZWwuY29tOyBHaXVzZXBwZSBDYXZhbGxhcm8g
PHBlcHBlLmNhdmFsbGFyb0BzdC5jb20+Ow0KPiBBbGV4YW5kcmUgVG9yZ3VlIDxhbGV4YW5kcmUu
dG9yZ3VlQGZvc3Muc3QuY29tPjsgSm9zZSBBYnJldQ0KPiA8am9hYnJldUBzeW5vcHN5cy5jb20+
OyBEYXZpZCBTIC4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYw0KPiBEdW1hemV0
IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47
IFBhb2xvDQo+IEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IE1heGltZSBDb3F1ZWxpbg0KPiA8
bWNvcXVlbGluLnN0bTMyQGdtYWlsLmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LXN0bTMyQHN0LW1kLQ0KPiBtYWlsbWFuLnN0b3JtcmVwbHkuY29tOyBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IENjOiBOZywgQm9vbiBLaGFpIDxib29uLmtoYWkubmdAaW50ZWwuY29tPjsgU2hldmNoZW5rbywg
QW5kcml5DQo+IDxhbmRyaXkuc2hldmNoZW5rb0BpbnRlbC5jb20+OyBUaGFtLCBNdW4gWWV3IDxt
dW4ueWV3LnRoYW1AaW50ZWwuY29tPjsNCj4gU3dlZSwgTGVvbmcgQ2hpbmcgPGxlb25nLmNoaW5n
LnN3ZWVAaW50ZWwuY29tPjsgRyBUaG9tYXMsIFJvaGFuDQo+IDxyb2hhbi5nLnRob21hc0BpbnRl
bC5jb20+OyBTaGV2Y2hlbmtvIEFuZHJpeQ0KPiA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50
ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW0VuYWJsZSBEZXNpZ253YXJlIFhHTUFDIFZMQU4gU3Ry
aXBwaW5nIEZlYXR1cmUgMS8yXSBkdC1iaW5kaW5nczoNCj4gbmV0OiBzbnBzLGR3bWFjOiBBZGQg
ZGVzY3JpcHRpb24gZm9yIHJ4LXZsYW4tb2ZmbG9hZA0KPiANCj4gT24gMjEvMDcvMjAyMyAwODoy
NiwgQm9vbkBlY3NtdHAucG5nLmludGVsLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBCb29uIEtoYWkg
TmcgPGJvb24ua2hhaS5uZ0BpbnRlbC5jb20+DQo+ID4NCj4gPiBUaGlzIHBhdGNoIGlzIHRvIGFk
ZCB0aGUgZHRzIHNldHRpbmcgZm9yIHRoZSBNQUMgY29udHJvbGxlciBvbg0KPiA+IHN5bm9wc3lz
IDEwRyBFdGhlcm5ldCBNQUMgd2hpY2ggYWxsb3cgdGhlIDEwRyBNQUMgdG8gdHVybiBvbiBoYXJk
d2FyZQ0KPiA+IGFjY2VsZXJhdGVkIFZMQU4gc3RyaXBwaW5nLiBPbmNlIHRoZSBoYXJkd2FyZSBh
Y2NlbGVyYXRlZCBWTEFODQo+ID4gc3RyaXBwaW5nIGlzIHR1cm4gb24sIHRoZSBWTEFOIHRhZyB3
aWxsIGJlIHN0cmlwcGVkIGJ5IHRoZQ0KPiANCj4gU3ViamVjdCBwcmVmaXggaXMgdG90YWxseSBi
b2d1cy4NCj4gDQoNCldoaWNoIHBhcnQ/IEl0J3MgYSAxMEcgRXRoZXJuZXQgSVAgZnJvbSBTeXNu
b3BzeXMsIGluIFJvbWFuIGNoYXJhY3RlciBpdCBpcyBYIChtZWFuIDEwKSwgc28gWEdNQUMuDQpF
dmVuIHRoZSBkcml2ZXIgZmlsZSBJJ20gZWRpdGluZyBpdCBpcyBkdyJ4Z21hYyIuDQoNCj4gDQo+
ID4gMTBHIEV0aGVybmV0IE1BQy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJvb24gS2hhaSBO
ZyA8Ym9vbi5raGFpLm5nQGludGVsLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogU2hldmNoZW5rbyBB
bmRyaXkgPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4gDQo+IFBsZWFzZSB1
c2Ugc2NyaXB0cy9nZXRfbWFpbnRhaW5lcnMucGwgdG8gZ2V0IGEgbGlzdCBvZiBuZWNlc3Nhcnkg
cGVvcGxlIGFuZCBsaXN0cw0KPiB0byBDQy4gSXQgbWlnaHQgaGFwcGVuLCB0aGF0IGNvbW1hbmQg
d2hlbiBydW4gb24gYW4gb2xkZXIga2VybmVsLCBnaXZlcyB5b3UNCj4gb3V0ZGF0ZWQgZW50cmll
cy4gVGhlcmVmb3JlIHBsZWFzZSBiZSBzdXJlIHlvdSBiYXNlIHlvdXIgcGF0Y2hlcyBvbiByZWNl
bnQNCj4gTGludXgga2VybmVsLg0KPiANCg0KVGhpcyBpcyBiYXNlZCBvbiBuZXQtbmV4dCByZXBv
c2l0b3J5IHN1Z2dlc3RlZCBieSB0aGUgZ2V0IG1haW50YWluZXIgc2NyaXB0Lg0KDQpJIGdvdCB0
aGUgbGF0ZXN0IG5ldC1uZXh0IGp1c3Qgbm93IGF0IHRoZSBDb21taXQtaWQgYjQ0NjkzNDk1YWY4
IA0Kd2hpY2gganVzdCBjb21taXR0ZWQgeWVzdGVyZGF5Lg0KDQokIC4vc2NyaXB0cy9nZXRfbWFp
bnRhaW5lci5wbCAgLS1zY20gIC1mIGRyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFj
L2R3eGdtYWMyX2NvcmUuYw0KR2l1c2VwcGUgQ2F2YWxsYXJvIDxwZXBwZS5jYXZhbGxhcm9Ac3Qu
Y29tPiAoc3VwcG9ydGVyOlNUTU1BQyBFVEhFUk5FVCBEUklWRVIpDQpBbGV4YW5kcmUgVG9yZ3Vl
IDxhbGV4YW5kcmUudG9yZ3VlQGZvc3Muc3QuY29tPiAoc3VwcG9ydGVyOlNUTU1BQyBFVEhFUk5F
VCBEUklWRVIpDQpKb3NlIEFicmV1IDxqb2FicmV1QHN5bm9wc3lzLmNvbT4gKHN1cHBvcnRlcjpT
VE1NQUMgRVRIRVJORVQgRFJJVkVSKQ0KIkRhdmlkIFMuIE1pbGxlciIgPGRhdmVtQGRhdmVtbG9m
dC5uZXQ+IChtYWludGFpbmVyOk5FVFdPUktJTkcgRFJJVkVSUykNCkVyaWMgRHVtYXpldCA8ZWR1
bWF6ZXRAZ29vZ2xlLmNvbT4gKG1haW50YWluZXI6TkVUV09SS0lORyBEUklWRVJTKQ0KSmFrdWIg
S2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4gKG1haW50YWluZXI6TkVUV09SS0lORyBEUklWRVJT
KQ0KUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPiAobWFpbnRhaW5lcjpORVRXT1JLSU5H
IERSSVZFUlMpDQpNYXhpbWUgQ29xdWVsaW4gPG1jb3F1ZWxpbi5zdG0zMkBnbWFpbC5jb20+ICht
YWludGFpbmVyOkFSTS9TVE0zMiBBUkNISVRFQ1RVUkUpDQpSaWNoYXJkIENvY2hyYW4gPHJpY2hh
cmRjb2NocmFuQGdtYWlsLmNvbT4gKG1haW50YWluZXI6UFRQIEhBUkRXQVJFIENMT0NLIFNVUFBP
UlQpDQpuZXRkZXZAdmdlci5rZXJuZWwub3JnIChvcGVuIGxpc3Q6U1RNTUFDIEVUSEVSTkVUIERS
SVZFUikNCmxpbnV4LXN0bTMyQHN0LW1kLW1haWxtYW4uc3Rvcm1yZXBseS5jb20gKG1vZGVyYXRl
ZCBsaXN0OkFSTS9TVE0zMiBBUkNISVRFQ1RVUkUpDQpsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcgKG1vZGVyYXRlZCBsaXN0OkFSTS9TVE0zMiBBUkNISVRFQ1RVUkUpDQpsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIChvcGVuIGxpc3QpDQpnaXQgZ2l0Oi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25ldGRldi9uZXQuZ2l0DQpnaXQgZ2l0Oi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25ldGRldi9uZXQtbmV4dC5n
aXQNCmdpdCBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYXRv
cmd1ZS9zdG0zMi5naXQgc3RtMzItbmV4dA0KZ2l0IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQNCg0KPiBZb3UgbWlzc2VkIGF0
IGxlYXN0IERUIGxpc3QgKG1heWJlIG1vcmUpLCBzbyB0aGlzIHdvbid0IGJlIHRlc3RlZCBieSBh
dXRvbWF0ZWQNCj4gdG9vbGluZy4gUGVyZm9ybWluZyByZXZpZXcgb24gdW50ZXN0ZWQgY29kZSBt
aWdodCBiZSBhIHdhc3RlIG9mIHRpbWUsIHRodXMgSQ0KPiB3aWxsIHNraXAgdGhpcyBwYXRjaCBl
bnRpcmVseSB0aWxsIHlvdSBmb2xsb3cgdGhlIHByb2Nlc3MgYWxsb3dpbmcgdGhlIHBhdGNoIHRv
IGJlDQo+IHRlc3RlZC4NCj4gDQoNClRoaXMgaXMgYSBuZXcgZGV2aWNlIGJyaW5ndXAsIHRodXMg
dGhlIERUIGlzIG5vdCBhdmFpbGFibGUgeWV0LiBUaGUgRFRTIHdpbGwgYmUgdXBzdHJlYW1lZA0K
YnkgbXkgYW5vdGhlciBjb2xsZWFndWUsIHVubGVzcywgaWYgSSBjYW4gdXBzdHJlYW0gb25seSBt
eSBwYXJ0IG9uIHRoZSBzZXR0aW5nPyANCg0KPiBQbGVhc2Uga2luZGx5IHJlc2VuZCBhbmQgaW5j
bHVkZSBhbGwgbmVjZXNzYXJ5IFRvL0NjIGVudHJpZXMuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+
IEtyenlzenRvZg0KDQo=
