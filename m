Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB1375CFF3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjGUQpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGUQpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:45:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925671FD2;
        Fri, 21 Jul 2023 09:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689957909; x=1721493909;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6oK4rUJ3G6Z8sQUzPvaB9qYhk9Oq/fI6YQKdvqLq60w=;
  b=R6dGwcx87q7nzkw8fa6X2iOiX8vUABQrEbyjz5uuT6n5mSakhWHYKrig
   czKaBXmRzuLAcKS51D+mKv2M8TA3xdBYEvw0sbkoW7GJrgCFNUT4o9zC0
   IMH9dJTbQ2MNdVMG/4Xqq8Yh3WrDj3TMGIyFCTkZ3NAKVK3Xis2MGidHN
   DwoY0CW3SL2UqGlaDUSDQ77irDOIgpvpSME43i4wNlkNEvIIV7D8dpYCc
   WNfALwpa05ECZ0MqGtgoh6Py84NeSPZV3WCw8jeeulDKVVMFTETKIYKH7
   BAoR4i+b2hKYPUZElDGYeYA6eEdtKaL7aNlY0JpnmVAJdy+Qk+tsNb7nv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="364528455"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="364528455"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 09:45:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="760011061"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="760011061"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 21 Jul 2023 09:45:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 09:45:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 09:45:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 09:45:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9Wy1NQVCe4k1uoklzVpjjAClYNdgQYUCiDEcJBh/2hTuufoo86qejVPlsaJKXEnVVDN/lftw3vxYltYmrjhw0cgdgGUhrzL/4GsMdGfpAW0fIk1/+BOMsYhW+ltpAGBJw5ScG/yPoy33Qc5g0+ix8UoBFzxjyd8kOiILinp0O1n025st9KpHd7f2g86MWSuHJlMURJykdIdcK9PLKPv1zi5zVozvuOIcCZzTxSRSuf6zUB3gqFucuzNuC8Oa3Yq5J2Us3AZm4FMUF1gmXemhwire/KsDgWuGIzZsVZi1sJ65kLtiuN82azGSzO8UjHEw9738FDH5hL47qaKeI9Gag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oK4rUJ3G6Z8sQUzPvaB9qYhk9Oq/fI6YQKdvqLq60w=;
 b=iPOPgJLTeTJjm7LpamoB5bBA4Ex9A/QljaT96i0x8lmNT8I2eOU9tE2V4QbYjOf6MC6rlCRxu3m4L/ChaeBf1bUI4JmdjdEWdrjKfa04hfIeo/DZbr18Cc3nCOV8GFkq23Lf5XU5fGaZwml5VC1YGdhAQr7s4tWI9RHx28lp4cx7Ccs85HS4w8dp7P7AJ2ER3K57GcOjb4JLtDq1xfIxKH6gs6CVdSfcgCk0Cz1N6wzijQHBGaWwL2SMFstaB/FJf4Xg/loY0WTAJgEQ3hmziGlPKqSdopHp4F9X4lm0P5HWxzUZmvkbI5fGxT+RvV8kNl56XlOARbc4CtjMU4LBCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 DM4PR11MB8158.namprd11.prod.outlook.com (2603:10b6:8:18b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.28; Fri, 21 Jul 2023 16:45:05 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531%3]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 16:45:05 +0000
From:   "Ng, Boon Khai" <boon.khai.ng@intel.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Boon@ecsmtp.png.intel.com" <Boon@ecsmtp.png.intel.com>,
        "Khai@ecsmtp.png.intel.com" <Khai@ecsmtp.png.intel.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
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
Subject: RE: [Enable Designware XGMAC VLAN Stripping Feature 2/2] net: stmmac:
 dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Topic: [Enable Designware XGMAC VLAN Stripping Feature 2/2] net:
 stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Index: AQHZu5xgYrDsoI6/ykSzsldNoVNgSq/EADCAgABYqiCAAAh7AIAAAnGwgAAGDQCAAALKQA==
Date:   Fri, 21 Jul 2023 16:45:05 +0000
Message-ID: <DM8PR11MB57515FDFE2A7733D1A37812CC13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
 <20230721062617.9810-3-boon.khai.ng@intel.com>
 <cfba8fa4-47e5-7553-f40e-9e34b25d1405@kernel.org>
 <DM8PR11MB5751E5388AEFCFB80BCB483FC13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
 <7549a014-4f5e-cf87-f07d-c4980ab44dc1@gmail.com>
 <DM8PR11MB5751B68955275006A16E1C75C13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
 <4dbc07fa-e446-8694-3371-fa2d0432fbc6@gmail.com>
In-Reply-To: <4dbc07fa-e446-8694-3371-fa2d0432fbc6@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|DM4PR11MB8158:EE_
x-ms-office365-filtering-correlation-id: 71431e5c-c78a-4d52-9aea-08db8a09d5e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HvjegDp1VKdS9r9iDk0jt5eR4w8qkbFkBdcbeL5KGqNPF/vfWghnUKHQ8jJRuUzlNuH1kvliBE6lvVkAOeq8M1g8hzlE+e7P2Irlyr+ov8JI5ZhlyI1U5H7qYlviCSuLPPqbgVJ1BBSBkn6Twqbl38pIWiSwDFFORRsTDOm+TGQcylogf44ehzv73Z2IF5J3eyxH79eDlYID3sZRiHLyO6UI909j9IZt0aY1ukGHZ9rDAu2QU9pZl0E+FbUC8vwFOXpU9tOgWPYxQ4b5zx85bABrmJhV2JGp7SBBKbWHwCjUWhgnXm32UGcUrx43oL77XuS8BeeIXQylfZ+PNYqk1FLK+R18cd9kITWvrxM29xgNObitP/zYq69DZMAYSN6yKLhiuMf0N6vZ5E9I8GOfYH/OPwVNp6BnXZ034EkJ+zO78xrMhaKHW1OcmO3s1KEiSmwAFonfmmg6l0VDxEioeqMdcaUxLhr3xwSOV3piNBEIXst0NavnJ0O8x87nmSPaKlTF74ueWGafqa/APqC9jHrBwNPeBxuCPgLv6muyfq3PvHRceM562dci+trvGdnpoGpkJGrXaqBfmSsoVsByZh4Z7bO1aceJpg7F+m1khuanrwaYWTVPKUS//++UVzIPXqkI5XbL+tWJUfb4DYhp1gVBL3Br3Aw1mWN20ixnPxE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(316002)(76116006)(4326008)(64756008)(66446008)(71200400001)(66946007)(66556008)(66476007)(122000001)(921005)(38100700002)(7696005)(9686003)(33656002)(86362001)(38070700005)(110136005)(54906003)(478600001)(2906002)(82960400001)(55016003)(41300700001)(52536014)(5660300002)(8936002)(8676002)(7416002)(186003)(6506007)(26005)(83380400001)(53546011)(168613001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDRVeHlEeXF5Q0E4OFBXai83NWxSREw1aTZsN0dSTGYxMGlCMndVa0QraW55?=
 =?utf-8?B?QmRVRUdOcFFieUpXWHlWSFNOUFJVOE92bDRKeVVVRzlWZTZDZklaRVdnMEpw?=
 =?utf-8?B?bVphUURDQXY1K0pyQ01URzJtMFVYV1RKMHRheDJyZDVjb0dZbjVtcmZ1cHlG?=
 =?utf-8?B?dXVEamxkeDN0WGNBNi9pQ1AxVklpcE1vV1JmM0h1WGM1TEZ3K2xERmZacUVD?=
 =?utf-8?B?MUpxZ0VGZkNHcm41Q1RyenN2Y2V4eFdxRWxNLzZNa0N4eXJUZDYrSmdldGZ1?=
 =?utf-8?B?TE44VjFja3k0RnhXKzhNVnZvSzNtUDZKR1BndFdkVjk3OWFaWEl3WjFZdHB3?=
 =?utf-8?B?RStXaU1VSHBBZ0EydkdHSVlwWlVrSEwxcWRjbXRrbm1HVWlob2gwdldwd2o0?=
 =?utf-8?B?TjBjemEwZS9EcmFJTjlJWHZ4RVY1NitjcE9od09LV3NoM012R2VsbjRZQXp4?=
 =?utf-8?B?eG5uYmRqajMzL1dlQ1Jna1FaVmNaUTlvcHdMWGZYTUxFT0x1UGM5MmpVbTli?=
 =?utf-8?B?aHRHQUdYYnJlSHJZTWtCYVNVVGJhdHp4dEljRTF4NjU0R0grNVFjZ0puT0sv?=
 =?utf-8?B?c1lpSzJ6TTJlUFFLb1dpbmxwSjQzSk5laE4wY3kyZ0xtem90eS9JS0ZOTXRC?=
 =?utf-8?B?akJtQkUwSGtJL2NHZ2ZTU29NdVBpQ2JlWnFKZXBTeDRtcFRoeTZtRk1xdzcy?=
 =?utf-8?B?eldwSmhJRmJhRnpxY2Q1aHFoMFNVZVQ0VjdDdjRCZ2FqdGQ3RnBZeGk3R3ht?=
 =?utf-8?B?SFkyanBsTlJHTXJVL2E2ckkzckppR1RRWE5YNUhVMEtSVGdNUGFPcVpqeUFv?=
 =?utf-8?B?ZUFVUHh2NGcrTHRnTXZSZHQzV0NpZkdjQnN4TVFqTDZkRkZvSUJFZm9WLy9p?=
 =?utf-8?B?U25UamU2WW9ZZkRzQzlsUmJJMHNqQngzTWUwQ2dNRUl5UFpqOG9ndTdXUjF2?=
 =?utf-8?B?MGQyRG00R1dpVittR29tYjZUM1pJdjA3YXdEdUtxOXA4R0FNaWozRXZTc3Rw?=
 =?utf-8?B?bGFsTmkvWC96ZFR1dzBSZjJrRHQ5SGVFVDZpZmp6TzVrS3pGMzhxdmlSM1Vn?=
 =?utf-8?B?WUk4d0xKWEtWdFZFQUR2RllURllkbVRoOGxtbDcvQzAvMXdqQk4vV1ljck9W?=
 =?utf-8?B?WmF5YTdQL2xaZFQ2cGhMczNSdWFVTWkwM2doc0U2U3JYbVJqOFFvK0Z2N043?=
 =?utf-8?B?WnNIVDdMY1JBL3h1VmhOS2xLcUVTYVBMSUZzVTI1Z0hpb1gwMDNObCt2RFBP?=
 =?utf-8?B?U3RzWmsrZ1FLL24wQVBSOC90MTlCOE14UjMrcktCRmJrQmVSaktucDFpZzhp?=
 =?utf-8?B?RHAvUkJqK0xwSndoOGdqOTZqaXdlNDJPSEMyUmhLQ2ZHSzNrblBnSFRxdXNM?=
 =?utf-8?B?Zkhwb3hYNnB0NDh4UzI2ci9tNWdIR2w1b3FaaDZZRnhOanNsL0VOemRoUHQx?=
 =?utf-8?B?QWg5eTc5REVuK0plY2ZUYWlhUVEvUFhQNGw2QkpYd1R3ZkRJRFhna2tsSjlX?=
 =?utf-8?B?NUhjMVJUWGdqcmpYb25VTnZRZ2lxSkJwY0s4VitZZzVQaWpwVXlib2hremtW?=
 =?utf-8?B?RDgrZm82UUUxOUxYUXNySFpCRzU5bUtqNFVhaER3SWdMcXdRcEs4MFRoT2Fy?=
 =?utf-8?B?aFpBd095UFVWUHRWdDNBb1ZpaEdyaitMdnQwanZiQkFvTW5qcW41OU1LS016?=
 =?utf-8?B?bmJqMHQvVElVTTZ5TXRnSldFSGVvekQ1K0l4azRtYm5jSlBXb3NuUllieDdS?=
 =?utf-8?B?ZGdFdnh3SlNJM3J3djJwQzFibFdZeXNwTmpWS0E4R3lXZUtJdURxU0pKOWpv?=
 =?utf-8?B?T2xaS2lXOXF4QVF0S0lEeTZLOWpjMTlWUEU5aFBkUjlMUGVPbFdjRTBUSjBR?=
 =?utf-8?B?bldJWEZ1bExnYVdtZkxqd1JHeVEvMVpPdlg4TGRKRENVWHNyY24wUS9oUUNJ?=
 =?utf-8?B?c1BucG1MWTUvSnJwU21YSWk5M2VzeGlFMlJEL3hmbkNvMWtoL05TQk5najBy?=
 =?utf-8?B?bkRTYnZPTUFQOVR1VDJRRWFJT3U5UTc1Q21iMDZrQmVnb3hsbnZwZlBzREtE?=
 =?utf-8?B?VllIblgvcndCL2Z4ZlZhbFhBWnlranBoVTZWWE5yajhxQ0JxMi9JRnRSdThC?=
 =?utf-8?Q?S1oYdANI/ukndzG5j2IKcDBXA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71431e5c-c78a-4d52-9aea-08db8a09d5e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 16:45:05.0937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LBdA0aDfsrPfZyLLeu/JWQpyRmnUCO8vmNKDL7ikGPEiTsMF0Gvcjm2B+MvkGu3/EByQ5RHrcAvE9mX4ozKvRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8158
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGbG9yaWFuIEZhaW5lbGxpIDxm
LmZhaW5lbGxpQGdtYWlsLmNvbT4NCj4gU2VudDogU2F0dXJkYXksIEp1bHkgMjIsIDIwMjMgMTI6
MzAgQU0NCj4gVG86IE5nLCBCb29uIEtoYWkgPGJvb24ua2hhaS5uZ0BpbnRlbC5jb20+OyBLcnp5
c3p0b2YgS296bG93c2tpDQo+IDxrcnprQGtlcm5lbC5vcmc+OyBCb29uQGVjc210cC5wbmcuaW50
ZWwuY29tOw0KPiBLaGFpQGVjc210cC5wbmcuaW50ZWwuY29tOyBHaXVzZXBwZSBDYXZhbGxhcm8g
PHBlcHBlLmNhdmFsbGFyb0BzdC5jb20+Ow0KPiBBbGV4YW5kcmUgVG9yZ3VlIDxhbGV4YW5kcmUu
dG9yZ3VlQGZvc3Muc3QuY29tPjsgSm9zZSBBYnJldQ0KPiA8am9hYnJldUBzeW5vcHN5cy5jb20+
OyBEYXZpZCBTIC4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYw0KPiBEdW1hemV0
IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47
DQo+IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IE1heGltZSBDb3F1ZWxpbg0KPiA8
bWNvcXVlbGluLnN0bTMyQGdtYWlsLmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LXN0bTMyQHN0LQ0KPiBtZC1tYWlsbWFuLnN0b3JtcmVwbHkuY29tOyBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IENjOiBTaGV2Y2hlbmtvLCBBbmRyaXkgPGFuZHJpeS5zaGV2Y2hlbmtvQGludGVsLmNvbT47IFRo
YW0sIE11biBZZXcNCj4gPG11bi55ZXcudGhhbUBpbnRlbC5jb20+OyBTd2VlLCBMZW9uZyBDaGlu
Zw0KPiA8bGVvbmcuY2hpbmcuc3dlZUBpbnRlbC5jb20+OyBHIFRob21hcywgUm9oYW4NCj4gPHJv
aGFuLmcudGhvbWFzQGludGVsLmNvbT47IFNoZXZjaGVua28gQW5kcml5DQo+IDxhbmRyaXkuc2hl
dmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbRW5hYmxlIERlc2lnbndh
cmUgWEdNQUMgVkxBTiBTdHJpcHBpbmcgRmVhdHVyZSAyLzJdIG5ldDoNCj4gc3RtbWFjOiBkd3hn
bWFjMjogQWRkIHN1cHBvcnQgZm9yIEhXLWFjY2VsZXJhdGVkIFZMQU4gU3RyaXBwaW5nDQo+IA0K
PiANCj4gDQo+IE9uIDcvMjEvMjAyMyA5OjEyIEFNLCBOZywgQm9vbiBLaGFpIHdyb3RlOg0KPiA+
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBGbG9yaWFuIEZhaW5lbGxp
IDxmLmZhaW5lbGxpQGdtYWlsLmNvbT4NCj4gPj4gU2VudDogRnJpZGF5LCBKdWx5IDIxLCAyMDIz
IDExOjU5IFBNDQo+ID4+IFRvOiBOZywgQm9vbiBLaGFpIDxib29uLmtoYWkubmdAaW50ZWwuY29t
PjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA+PiA8a3J6a0BrZXJuZWwub3JnPjsgQm9vbkBlY3Nt
dHAucG5nLmludGVsLmNvbTsNCj4gPj4gS2hhaUBlY3NtdHAucG5nLmludGVsLmNvbTsgTmcsIEJv
b24gS2hhaSA8Ym9vbi5raGFpLm5nQGludGVsLmNvbT47DQo+ID4+IEdpdXNlcHBlIENhdmFsbGFy
byA8cGVwcGUuY2F2YWxsYXJvQHN0LmNvbT47IEFsZXhhbmRyZSBUb3JndWUNCj4gPj4gPGFsZXhh
bmRyZS50b3JndWVAZm9zcy5zdC5jb20+OyBKb3NlIEFicmV1IDxqb2FicmV1QHN5bm9wc3lzLmNv
bT47DQo+ID4+IERhdmlkIFMgLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1
bWF6ZXQNCj4gPj4gPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBr
ZXJuZWwub3JnPjsgUGFvbG8NCj4gQWJlbmkNCj4gPj4gPHBhYmVuaUByZWRoYXQuY29tPjsgTWF4
aW1lIENvcXVlbGluDQo+IDxtY29xdWVsaW4uc3RtMzJAZ21haWwuY29tPjsNCj4gPj4gbmV0ZGV2
QHZnZXIua2VybmVsLm9yZzsgbGludXgtc3RtMzJAc3QtbWQtIG1haWxtYW4uc3Rvcm1yZXBseS5j
b207DQo+ID4+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtIGtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gQ2M6IFNoZXZjaGVua28sIEFuZHJpeSA8YW5kcml5
LnNoZXZjaGVua29AaW50ZWwuY29tPjsgVGhhbSwgTXVuDQo+IFlldw0KPiA+PiA8bXVuLnlldy50
aGFtQGludGVsLmNvbT47IFN3ZWUsIExlb25nIENoaW5nDQo+ID4+IDxsZW9uZy5jaGluZy5zd2Vl
QGludGVsLmNvbT47IEcgVGhvbWFzLCBSb2hhbg0KPiA+PiA8cm9oYW4uZy50aG9tYXNAaW50ZWwu
Y29tPjsgU2hldmNoZW5rbyBBbmRyaXkNCj4gPj4gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4Lmlu
dGVsLmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtFbmFibGUgRGVzaWdud2FyZSBYR01BQyBWTEFO
IFN0cmlwcGluZyBGZWF0dXJlIDIvMl0gbmV0Og0KPiA+PiBzdG1tYWM6IGR3eGdtYWMyOiBBZGQg
c3VwcG9ydCBmb3IgSFctYWNjZWxlcmF0ZWQgVkxBTiBTdHJpcHBpbmcNCj4gPj4NCj4gPj4NCj4g
Pj4NCj4gPj4gT24gNy8yMS8yMDIzIDg6MzAgQU0sIE5nLCBCb29uIEtoYWkgd3JvdGU6DQo+ID4+
Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+PiBGcm9tOiBLcnp5c3p0b2YgS296
bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+ID4+Pj4gU2VudDogRnJpZGF5LCBKdWx5IDIxLCAy
MDIzIDY6MTEgUE0NCj4gPj4+PiBUbzogQm9vbkBlY3NtdHAucG5nLmludGVsLmNvbTsgS2hhaUBl
Y3NtdHAucG5nLmludGVsLmNvbTsgIk5nDQo+ID4+Pj4gPGJvb24ua2hhaS5uZyJAaW50ZWwuY29t
OyBHaXVzZXBwZSBDYXZhbGxhcm8NCj4gPj4+PiA8cGVwcGUuY2F2YWxsYXJvQHN0LmNvbT47IEFs
ZXhhbmRyZSBUb3JndWUNCj4gPj4+PiA8YWxleGFuZHJlLnRvcmd1ZUBmb3NzLnN0LmNvbT47IEpv
c2UgQWJyZXUNCj4gPGpvYWJyZXVAc3lub3BzeXMuY29tPjsNCj4gPj4+PiBEYXZpZCBTIC4gTWls
bGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0DQo+ID4+Pj4gPGVkdW1hemV0
QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8NCj4g
Pj4+PiBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBNYXhpbWUgQ29xdWVsaW4NCj4gPj4+PiA8
bWNvcXVlbGluLnN0bTMyQGdtYWlsLmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+
Pj4gbGludXgtc3RtMzJAc3QtIG1kLW1haWxtYW4uc3Rvcm1yZXBseS5jb207DQo+ID4+Pj4gbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0ga2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiA+Pj4+IENjOiBOZywgQm9vbiBLaGFpIDxib29uLmtoYWkubmdAaW50ZWwuY29t
PjsgU2hldmNoZW5rbywgQW5kcml5DQo+ID4+Pj4gPGFuZHJpeS5zaGV2Y2hlbmtvQGludGVsLmNv
bT47IFRoYW0sIE11biBZZXcNCj4gPj4+PiA8bXVuLnlldy50aGFtQGludGVsLmNvbT47IFN3ZWUs
IExlb25nIENoaW5nDQo+ID4+Pj4gPGxlb25nLmNoaW5nLnN3ZWVAaW50ZWwuY29tPjsgRyBUaG9t
YXMsIFJvaGFuDQo+ID4+Pj4gPHJvaGFuLmcudGhvbWFzQGludGVsLmNvbT47IFNoZXZjaGVua28g
QW5kcml5DQo+ID4+Pj4gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4gPj4+
PiBTdWJqZWN0OiBSZTogW0VuYWJsZSBEZXNpZ253YXJlIFhHTUFDIFZMQU4gU3RyaXBwaW5nIEZl
YXR1cmUgMi8yXQ0KPiBuZXQ6DQo+ID4+Pj4gc3RtbWFjOiBkd3hnbWFjMjogQWRkIHN1cHBvcnQg
Zm9yIEhXLWFjY2VsZXJhdGVkIFZMQU4gU3RyaXBwaW5nDQo+ID4+Pj4NCj4gPj4+PiBPbiAyMS8w
Ny8yMDIzIDA4OjI2LCBCb29uQGVjc210cC5wbmcuaW50ZWwuY29tIHdyb3RlOg0KPiA+Pj4+PiBG
cm9tOiBCb29uIEtoYWkgTmcgPGJvb24ua2hhaS5uZ0BpbnRlbC5jb20+DQo+ID4+Pj4+DQo+ID4+
Pj4+IEN1cnJlbnRseSwgVkxBTiB0YWcgc3RyaXBwaW5nIGlzIGRvbmUgYnkgc29mdHdhcmUgZHJp
dmVyIGluDQo+ID4+Pj4+IHN0bW1hY19yeF92bGFuKCkuIFRoaXMgcGF0Y2ggaXMgdG8gQWRkIHN1
cHBvcnQgZm9yIFZMQU4gdGFnDQo+ID4+Pj4+IHN0cmlwcGluZyBieSB0aGUgTUFDIGhhcmR3YXJl
IGFuZCBNQUMgZHJpdmVycyB0byBzdXBwb3J0IGl0Lg0KPiA+Pj4+PiBUaGlzIGlzIGRvbmUgYnkg
YWRkaW5nIHJ4X2h3X3ZsYW4oKSBhbmQgc2V0X2h3X3ZsYW5fbW9kZSgpDQo+ID4+Pj4+IGNhbGxi
YWNrcyBhdCBzdG1tYWNfb3BzIHN0cnVjdCB3aGljaCBhcmUgY2FsbGVkIGZyb20gdXBwZXIgc29m
dHdhcmUNCj4gbGF5ZXIuDQo+ID4+Pj4gLi4uDQo+ID4+Pj4NCj4gPj4+Pj4gICAgCWlmIChwcml2
LT5kbWFfY2FwLnZsaGFzaCkgew0KPiA+Pj4+PiAgICAJCW5kZXYtPmZlYXR1cmVzIHw9DQo+IE5F
VElGX0ZfSFdfVkxBTl9DVEFHX0ZJTFRFUjsNCj4gPj4+Pj4gICAgCQluZGV2LT5mZWF0dXJlcyB8
PQ0KPiBORVRJRl9GX0hXX1ZMQU5fU1RBR19GSUxURVI7IGRpZmYgLS0NCj4gPj4+PiBnaXQNCj4g
Pj4+Pj4gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1tYWNfcGxhdGZv
cm0uYw0KPiA+Pj4+PiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0bW1h
Y19wbGF0Zm9ybS5jDQo+ID4+Pj4+IGluZGV4IDIzZDUzZWEwNGIyNC4uYmQ3ZjMzMjZhNDRjIDEw
MDY0NA0KPiA+Pj4+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9z
dG1tYWNfcGxhdGZvcm0uYw0KPiA+Pj4+PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1p
Y3JvL3N0bW1hYy9zdG1tYWNfcGxhdGZvcm0uYw0KPiA+Pj4+PiBAQCAtNTQzLDYgKzU0MywxMiBA
QCBzdG1tYWNfcHJvYmVfY29uZmlnX2R0KHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UNCj4gPj4+
PiAqcGRldiwgdTggKm1hYykNCj4gPj4+Pj4gICAgCQkJcGxhdC0+ZmxhZ3MgfD0gU1RNTUFDX0ZM
QUdfVFNPX0VOOw0KPiA+Pj4+PiAgICAJfQ0KPiA+Pj4+Pg0KPiA+Pj4+PiArCS8qIFJ4IFZMQU4g
SFcgU3RyaXBwaW5nICovDQo+ID4+Pj4+ICsJaWYgKG9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwg
InNucHMscngtdmxhbi1vZmZsb2FkIikpIHsNCj4gPj4+Pj4gKwkJZGV2X2luZm8oJnBkZXYtPmRl
diwgIlJYIFZMQU4gSFcgU3RyaXBwaW5nXG4iKTsNCj4gPj4+Pg0KPiA+Pj4+IFdoeT8gRHJvcC4N
Cj4gPj4+Pg0KPiA+Pj4NCj4gPj4+IFRoaXMgaXMgYW4gZHRzIG9wdGlvbiBleHBvcnQgdG8gZHRz
IGZvciB1c2VyIHRvIGNob29zZSB3aGV0aGVyIG9yDQo+ID4+PiBub3QgdGhleSBXYW50IGEgSGFy
ZHdhcmUgc3RyaXBwaW5nIG9yIGEgc29mdHdhcmUgc3RyaXBwaW5nLg0KPiA+Pj4NCj4gPj4+IE1h
eSBJIGtub3cgd2hhdCBpcyB0aGUgcmVhc29uIHRvIGRyb3AgdGhpcz8NCj4gPj4NCj4gPj4gQmVj
YXVzZSB0aGUgbmV0d29ya2luZyBzdGFjayBhbHJlYWR5IGV4cG9zZXMga25vYnMgZm9yIGRyaXZl
cnMgdG8NCj4gPj4gYWR2ZXJ0aXNlIGFuZCBjb250cm9sIFZMQU4gc3RyaXBwaW5nL2luc2VydGlv
biBvbiBSWC9UWCB1c2luZyBldGh0b29sDQo+ID4+IGFuZCBmZWF0dXJlIGJpdHMgKE5FVElGX0Zf
SFdfVkxBTl9DVEFHX1JYLA0KPiBORVRJRl9GX0hXX1ZMQU5fQ1RBR19UWCkuDQo+ID4+DQo+ID4N
Cj4gPiBIaSBGbG9yaWFuLA0KPiA+DQo+ID4gVW5kZXJzdG9vZCwgYnV0IGhvdyBkb2VzIHVzZXIg
Y2hvb3NlIHRvIGhhdmUgdGhlIGRlZmF1bHQgb3B0aW9uIGVpdGhlcg0KPiA+IGhhcmR3YXJlIHN0
cmlwIG9yIHNvZnR3YXJlIHN0cmlwLCB3aGVuIHRoZSBkZXZpY2UganVzdCBib290IHVwPw0KPiAN
Cj4gWW91IG5lZWQgdGhlIGhhcmR3YXJlIHRvIGFkdmVydGlzZSBpdCBhbmQgZGVjaWRlIGFzIGEg
bWFpbnRhaW5lciBvZiB0aGF0DQo+IGRyaXZlciB3aGV0aGVyIGl0IG1ha2VzIHNlbnNlIHRvIGhh
dmUgb25lIG9yIHRoZSBvdGhlciBiZWhhdmlvciBieSBkZWZhdWx0Lg0KPiANCg0KT2theSBnb3Qg
aXQuDQoNCj4gPg0KPiA+IEkgZG9u4oCZdCB0aGluayBldGhvb2wgY2FuICJyZW1lbWJlciIgdGhl
IHNldHRpbmcgb25jZSB0aGUgZGV2aWNlIGdldA0KPiByZWJvb3RlZD8NCj4gDQo+IElmIGJ5ICJk
ZXZpY2UiIHlvdSBtZWFuIGEgc3lzdGVtIHRoYXQgaW5jb3Jwb3JhdGVzIGEgWEdNQUMgY29yZSwg
dGhlbiBJDQo+IHN1cHBvc2UgdGhhdCBpcyB0cnVlLCB0aG91Z2ggeW91IGNvdWxkIGhhdmUgc29t
ZSB1c2VyLXNwYWNlIGxvZ2ljIHRoYXQgZG9lcw0KPiByZW1lbWJlciB0aGUgdmFyaW91cyBldGh0
b29sIG9wdGlvbnMgYW5kIHJlLWFwcGxpZXMgdGhlbSBhcyBzb29uIGFzIHRoZQ0KPiBkZXZpY2Ug
aXMgbWFkZSBhdmFpbGFibGUgdG8gdXNlci1zcGFjZSwgdGhpcyB3b3VsZCBub3QgYmUgdG9vIGZh
ciBmZXRjaGVkLg0KPiANCg0KT2theSwgd2lsbCB0cnkgdG8gc2VhcmNoIHRoYXQsIGlzIGFkZGlu
ZyB0aGUgZXRob29sIGNvbW1hbmQgdHVybmluZyB0aGUNCkh3IHZsYW4gc3RyaXBpbmcgYXQgdGhl
IHN0YXJ0dXAgc2NyaXB0IGNvbnNpZGVyIG9uZSB3YXkgb2YgZG9pbmcgaXQ/DQoNCj4gPiBBbnkg
b3RoZXIgc3VnZ2VzdGlvbiBvZiBkb2luZyBpdCBvdGhlciB0aGFuIHVzaW5nIHRoZSBkdHMgbWV0
aG9kPw0KPiANCj4gTGV0IG1lIGFzayB5b3UgdGhpcyBxdWVzdGlvbjogd2hhdCBhcmUgeW91IHRy
eWluZyB0byBzb2x2ZSBieSBtYWtpbmcgdGhpcw0KPiBjb25maWd1cmFibGU/IEhXIHN0cmlwcGlu
ZyBzaG91bGQgYWx3YXlzIGJlIG1vcmUgZWZmaWNpZW50LCBzaG91bGQgbm90IGl0LCBpZg0KPiBz
bywgd2hhdCB3b3VsZCBiZSB0aGUgcmVhc29ucyBmb3Igbm90IGVuYWJsaW5nIHRoYXQgYnkgZGVm
YXVsdD8gSWYgbm90LCB0aGVuDQo+IGxlYXZlIGl0IG9mZiBhbmQgbGV0IHVzZXJzIGVuYWJsZSBp
dCBpZiB0aGV5IGZlZWwgbGlrZSB0aGV5IHdhbnQgaXQuDQoNCk9rYXksIHNvIHNlZW0gbGlrZSBp
dCBpcyBzb2xlbHkgZGVwZW5kcyBvbiBteSBzaWRlIHdoZXRoZXIgb3Igbm90IHRvIHR1cm4gaXQg
b24gYnkgZGVmYXVsdCwNCkVpdGhlciB3YXksIGlmIGl0IGdvIGFnYWluc3QgdGhlIHVzZXIgd2ls
bCB0byBoYXZlIGl0IG9uL29mZiBieSBkZWZhdWx0LCB0aGV5IHdpbGwgbmVlZCB0byB3cml0ZSAN
CkEgc3RhcnR1cCBzY3JpcHQgdG8gdHVybiB0aGUgZXRob29sIG9uL29mZj8NCg0KPiAtLQ0KPiBG
bG9yaWFuDQo=
