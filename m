Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE89D78747F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242291AbjHXPnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242158AbjHXPnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:43:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF6C1B0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692891815; x=1724427815;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/rngujuSt11nhka0yADuk09mVBGfz3RsM1r+5hqYwgM=;
  b=LuGn/fnVL7G1z7jifio2SXYrTQcqloNjZd+mHpRrSlcdqQzWJPRrZOGK
   K+UenvcZ/aHqbE9O2SCP1ztiFesV9ovRw1/PAvUEpKbcPpoQIiTz8NMmi
   mDFtSEct9TTMjVLrTSePFeJMqZg+F8fYkxZfEI6QI7QKjxT1u6UtNLo+Q
   QCTI3HgnfbAKrVEZMBsPmKBazM4/QK+qvoaF+gqY3S6wvFDB8Av52lG3r
   mDiIDBbayuUdEzLVmFZoWoaFs8YWQYb45gxBiUPKfa11Yk+BTE+BuGFmU
   MaM8KewqvLcOR52Z0j+I9LHOzEWeqp7anu52lRmWxOD2U3G3Cc2R/362N
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="374446479"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="374446479"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 08:31:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="827190534"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="827190534"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Aug 2023 08:31:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 08:31:02 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 08:31:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 08:31:01 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 08:31:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyFSFy+Q+VfrBYX7JKoLGR3YBxFkKULPeNXUQx3MvX8XHV5V0KExbrMB2lnUpQZsQ2xdtoVERv4hBl1R35MF3T6dqYfIjWzPg2o6Pg2/DwOLSrnPK1Ui/r/bKnaZzE3FnwR4o7Az7a/YR1yRBsEdMolcy0aL3TwLXRHmp2hPSshFbNa9SMBEizWfLEblGOh8enM0jtVm0JI0tjBn4RGZu3UmftbFQdPCY1LR9+qV1fJw2+ymFT1tdHANiOEP9vmPa15pJOJ0pVcPKSZC6QDVsTqL9TUaQKWo4IBkvfQncV05dl20waJzTJInLx9T7HpPGbEF1KfvyaCq9VOWf15Hjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rngujuSt11nhka0yADuk09mVBGfz3RsM1r+5hqYwgM=;
 b=FxUS8ZpbCO07qJvP8weo0nab2QXMWg1wqtts+/vF+y+52HsIlmhobv5skhUTIxfejUeEdPGr02nkgj4nalCW/Prp/cBxUFIBOQrdc5/IL1soL+89/ag9fxs6DF0i+hE38FbEVqhHra81r39sNIf43c2C9l7SEk9qcJQ08gGBLMh1aMJp2tL8TR+ZWD4mbgQfMyg4FZwCLhIdA01LpbVAXyvsEJVQeVifK4xNRFCgddKDLCU85C9qWo43G6Ozereuwq8zuqsuG289t7YK6cIkhEUUVFCLsMbIDzY4MZqkyqJU7qWTioq3n1iSoi2kmMXSnwNeqsA4f+2AavRjhonchA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) by
 SN7PR11MB7994.namprd11.prod.outlook.com (2603:10b6:806:2e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 15:30:54 +0000
Received: from DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::7e17:9947:411e:e99e]) by DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::7e17:9947:411e:e99e%5]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 15:30:54 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Amit Singh Tomar <amitsinght@marvell.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        George Cherian <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "peternewman@google.com" <peternewman@google.com>
Subject: RE: [EXT] Re: [RFC 00/12] ARM: MPAM: add support for priority
 partitioning control
Thread-Topic: [EXT] Re: [RFC 00/12] ARM: MPAM: add support for priority
 partitioning control
Thread-Index: AQHZ0T6XikHFu8Y0uEe4Hq2FndRcXq/2Si6AgAH9QACAACj2AIAADSIAgACwfACAAG3SAA==
Date:   Thu, 24 Aug 2023 15:30:54 +0000
Message-ID: <DS7PR11MB6077FDF2B6EEC736D6506C7AFC1DA@DS7PR11MB6077.namprd11.prod.outlook.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
 <f0e10f31-8571-baf6-6665-b077af067777@intel.com>
 <MW4PR18MB5084D5EEBC450BD66E8063E3C61FA@MW4PR18MB5084.namprd18.prod.outlook.com>
 <6114c8d0-97a1-be54-3e43-30348be38683@intel.com>
 <MW4PR18MB50847032F3ACFDBDBCA6D57AC61CA@MW4PR18MB5084.namprd18.prod.outlook.com>
 <be51596e-2e62-2fb9-4176-b0b2a2abb1d3@intel.com>
 <MW4PR18MB5084EB7DBE4985D981FE84F2C61DA@MW4PR18MB5084.namprd18.prod.outlook.com>
In-Reply-To: <MW4PR18MB5084EB7DBE4985D981FE84F2C61DA@MW4PR18MB5084.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB6077:EE_|SN7PR11MB7994:EE_
x-ms-office365-filtering-correlation-id: a2651cc1-c0c8-4530-778d-08dba4b71b14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jak/iO7MQwNeRDL2VQkk5iFMaejAz/4G3xHJ4GlXofEKyVRn0k+bYqDMHbKkFPtmdksUu+gyJ1gX6CDqWmKlpcPB4g4jzpYXIbAH8PHs4lHlBWigoH7lB0xL56A5zSam6IOor19cePLDxwIAZOR87RualyURd2JGcpLn6Xl7fnyF7HzUEBAq/hbBGZqkfmAmtEN2CgZplSMunLEnlwOGt4RTWy2Vnh5Zmu31gwa84xzQ0Q9Gus06EwVCteKfPjrcEyCR3pb5nOuYl7nitYqBOZEIS3U0SIhHPwhgSSTvO0LjjVV5D4It0CMyGDTPmeMVyJEkQajN0pf5TyqYbZG92yjpLDmE1aiNZEkds5xd2mKVs6sbD0YOpveAIs3V8ioDm8z06w6uBC7D806jEod/448aCn3/OpImrRo4YQcWlS9xDRA/NLiBuiuhlgReh6GtHn8ghztdg20vu90aCqxNWCh/lV01YsFK0la26UM2/Z4naPiiUnDdPfVbbvT23wcv9OrA7Q1nc9uO1V5YdyQNTpK0/oRANp5IqIxZrcpVkkXBY1K3NAG0FiKiNA5FI5acQSZyl1iWNc4ozFzfjB46SiQS/3QFTr1yuW2IcvkI/GskDy7NjUxRe1vuYnmiD++qM+tLz4xeMzE3sifrzRg0vQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39860400002)(1800799009)(451199024)(186009)(9686003)(26005)(478600001)(55016003)(5660300002)(52536014)(2906002)(4744005)(8936002)(4326008)(8676002)(82960400001)(38070700005)(38100700002)(122000001)(66476007)(66556008)(110136005)(66946007)(76116006)(86362001)(71200400001)(64756008)(41300700001)(54906003)(7696005)(6506007)(66446008)(33656002)(316002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bURCQS9VVlEwN28zN0lNWWJoRzV5OGQ3Z0RHazFjWkN1aURUQWZkVDEzc0ZO?=
 =?utf-8?B?QUJ2cTBSY3l6NXRTVjZGM2J1QkUvQ2Y3cjBwVjhLbzBEWllxTElrckRhbjFv?=
 =?utf-8?B?ME5vcVVOTVd0dUxIWFZnWDZyOWY2aHQzaWQ5WnJ0NEx5SG5WM0ltS3VlK1p6?=
 =?utf-8?B?eEE2YXVDL1Q4VWlaR1g2YWdGQ0Z0RkFUR0Q1MzFxOTM2bitGaGJvTCtHR2Fh?=
 =?utf-8?B?Yk9kR2d3cmhSdTdIUStsblVkbXlOd0k0UHRsT0dIT2djNWJnT01LRWdnM3Fv?=
 =?utf-8?B?S1RFdDNib1ZLRC9PZGt4aXRiK0NHc04ySWMzeXNmdVFCWDJ0ckFFTzV3NEQ0?=
 =?utf-8?B?amIxeHpqR2wrVjgyTThvSFdwaThWcGR0OHFTZERjUVprcjZ0UWxSWGxtd1Nk?=
 =?utf-8?B?dkdvb3lWZENiUEk0T290V25tbGMrVTB2MTRQamYxSkIwbzBNQzVLZFdMNWYv?=
 =?utf-8?B?SE9qVzNiR2JsdmVMN2lhbzFoU0dzS0xmdmZDckJJZW91cXArT0kyNnVGajZT?=
 =?utf-8?B?R0t3RnZWd3ZpTDh6RlZhK3d4bGNQQXViQWtpMVgvMzA4L0FiMzQ0TGQ1USti?=
 =?utf-8?B?aTNHby9qTWU0b1o5TnY2MXFwQlFTNDJESnRXYitiUE1uNytRMEhaQmdXZXdP?=
 =?utf-8?B?eGlmSEdMazBmT3BsMlIyQmhhVHZKUms2SlhhM0l6QWJMTXZCb0d4WGNsLzE2?=
 =?utf-8?B?OEJiOEtSaldZN2tYaWU3Mk5YV1NORGVCdC9yVFZqZzA5VklXTXFuVlliTkJw?=
 =?utf-8?B?Ni8rVzdwRXpqU01BbVI1a1RjL3ZtNGZsWjNqWURjRkFjQ3BJOEcxbjZyaUt0?=
 =?utf-8?B?bkVac2k1VHBhL3hpZkQ0UkNTblVLV0ZPSVZWdGtxMlhHai9iRERUY09ITzEr?=
 =?utf-8?B?cHg4bURmY1hmRkVlSFBLY3RObG9rWFliQnVKcEhtSWRKK0dXM3RHS05zSXFT?=
 =?utf-8?B?YXpYMG9ibS9zcjJrenY5Qm9uekNITklrcjh2Umx0U0RIYmxzQ3J1N2g2L09p?=
 =?utf-8?B?NjZ4UkdreWdoVTlKbUhoUlRIUUZ6V0Y5SWZhUEQ1MDRYZ01KZmdxUDQ4T1BV?=
 =?utf-8?B?UDBzZVBzNU1jcWlvZXFkMytva1F2cjdMRGJUbFpHanplMmtRK3J0WThKcitJ?=
 =?utf-8?B?NmdDbDBrQjZoRUFtRk4rM1hmZGYyTkQzZW9RNkRxdFZmMlo1eUFzYnFaOTd3?=
 =?utf-8?B?bk9nVFAwUFVMU1lGNWdCUWZpeGNhOTZOTFZwZEE4QUptOWhiZW5IbHA2ZjBx?=
 =?utf-8?B?Uk4rZlh0S05RdUpzTzFOUGxCaGVUajlQcllUTnRZSTBNU0RkL2hDSGN1TDJC?=
 =?utf-8?B?cXZQeWFSMHJaTkIrOGFPbU00OUJ3b3NoaGFTRDh4VDlxQTJpQU5uQzQ0V240?=
 =?utf-8?B?NnJRUGErQjlJREV5M1NzUGJHMi8zeXgrWlROZGR6dUVBNDg4R1NpUzYxeVZ0?=
 =?utf-8?B?SWxCeXVGZHcvci9oWGFYNkl5TGhRMWU5TEhCam1lbFhCVzZNSTNERC9XVFFC?=
 =?utf-8?B?SFppRDZkd0h5eU5wTlFIWVBHWkFDMG1lLzlBL1prTk1ZNmM1MDh6eDA3T2Rk?=
 =?utf-8?B?dFI1LzJVS25FcjkyYkdCR3ZEYUdzTG42L0hVU2hPWFJwMGd2amo0ektONW9h?=
 =?utf-8?B?NjltcnhzV2lNdWlIUXVrNEpPdkRsYWo4WHVYWXUrQXdITlg1VGpFY0ZRZ3VS?=
 =?utf-8?B?K0Q3OWhZYTZkcHRrWEpadzl4eDEwMjhDUW5sVnFkMWJTdVYxcEQ5VFI0dGpQ?=
 =?utf-8?B?UE5JTjR2clpERXk4ZXZQUVRhNUpQbFNzYVlCTk8wSHczNzQvemlXZFducUR2?=
 =?utf-8?B?anl4cDcvK3QwWmVWb3NrN0piSktlYzBWVGkzcTNFc3FCZmNRbUJuL0lsTFdh?=
 =?utf-8?B?V2VrRFBKc09LUVFTS1B6ajNnb1owQzNtYVFaOUdPVzdBUVB2WFQzS3ZscWpU?=
 =?utf-8?B?U1FIOXBIYWJlbE9JMVRFRFFYVjFGRHB1L0hjTmhhcktlL1FrS3pYOGl0Mm80?=
 =?utf-8?B?a1QyVVM3RHRMQ3hta3FoNUdWT1FmS1lGaUpFdmJhWktjY0wyNjFjdFJOM1N6?=
 =?utf-8?B?alZRbjk5RHhMM3ZJWDdCaDdBMVdZRUN4YlNIbHZyaDVKZE1SOG1OYnkxZXdr?=
 =?utf-8?Q?GxnQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2651cc1-c0c8-4530-778d-08dba4b71b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 15:30:54.2924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XmNiY0ijdjD0V2PuodElD6H5re61gDWaA916huSR1d4Tp2A4eTivQknXGeWwNFQXr2YdapQXvyA2D8PB6h6VLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7994
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAyKSBTZWNvbmQgYXBwcm9hY2ggdGhhdCB3ZSBkaXNjdXNzZWQgaW50ZXJuYWxseSBpcyB0byBo
YXZlIHNjaGVtYXRhIGZvciBDUE9SLCBhbmQgUFBBUlQgc2VwYXJhdGVkIGJ5IG5ldyBsaW5lIGFz
IG1lbnRpb25lZC9zdWdnZXN0ZWQgYnkgUGV0ZXIsIEJ1dCBpdCBtYXkgcmVxdWlyZSB0byB0d2Vh
aw0KPiAgICB0aGUgQVJNIE1QQU0gZGV2aWNlIGRyaXZlciBhIGJpdC4gSXQgd2FzIGtpbmQgb2Yg
dG9zcy11cCBiZXR3ZWVuIDJuZCBhbmQgM25kIGFwcHJvYWNoIDopLCBhbmQgd2Ugd2VudCB3aXRo
IHRoZSAzcmQgb25lLg0KPg0KPiAgICBMMzowPVhYWFgNCj4gICAgTDM6MD1QUEFSVD1YDQo+DQo+
ICAgIFdpbGwgbG9vayBpbnRvIGl0IGFnYWluLg0KDQpUaGF0IGxvb2tzIGhhcmQgdG8gcGFyc2Uu
IEhvdyBhYm91dDoNCg0KTDM6MD1YWFg7MT1ZWVkNCkwzUFBBUlQ6MD1BQUE7MT1CQkINCkwzQ1BP
UjowPU1NTTsxPU5OTg0KDQotVG9ueQ0K
