Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D367B9E99
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjJEOJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjJEOHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:07:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF0C11B;
        Thu,  5 Oct 2023 06:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696513708; x=1728049708;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UQl3NpBUPnHfJsxfxJgOEpsXehF2XgidxeexJScZ+Wc=;
  b=eJ9HAAJqhfhIwR5U5rPGqkHieERdZthq9fPfWBawxL0xoZZlSVU19pgv
   CZ1RzEANTJMaB8YSVsqgV5UZX5rFmncUOcg/yJJy5C1GkSDhODAuiK5GW
   /TEzEeF7M/WCaozb2zAw2XEc6D7efWbDclS9kMZZ3xpYBgA1EljNOy98a
   TAju1KnN9vCuIld8UBCypHj87aU/+WdOwHduunOk6o9M0nmmVsLSr+Ryz
   /9lWLWl9LDB3/r1CPQfJ+WzkAe4WosKAHF3AJf/UVJ5Oa+sZBg85Qudg0
   Z+1MexLPO3ks7OEqcE3nKqMTsowa7GeKhweGLp9Fcb3P8WrMLKhDZN6Jq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="469655115"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="469655115"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 20:09:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="701477513"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="701477513"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 20:09:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 20:09:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 20:09:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 20:09:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJxeHP1LlzmpFgY39H1ca9TA5MUz9xM/Q1927V5DOvkAHgI2q1gFc/sR9hh1/yFnI1EjMcs9Nnd+GlDkGFlg50iySm69jr0wr5JE5E5mA7vDEvyPO80xvBb6zcPQUZ1KlTzlsdenyc2HRBJzpNPo2h/fgBg6SCbJMgPqk2468p32cAv3AP6HEY/d0B0rNDc8gXgffgq6V04CxJyx+y+xCDj/vL9hu4+wzSCh0+VqScvhG8Xaes1EmEOj5iw/oFGIOVqJRtb8HlROidBAC2g4csMy0oMQ7a5r6d2K4bzFC6OFDEdyF/xd8WB/jELazk8smQVjabfRRSpjGFG7uVHV4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQl3NpBUPnHfJsxfxJgOEpsXehF2XgidxeexJScZ+Wc=;
 b=FxZWHTFPEI+CeGtt06g2pOmk5z5DpedYY65A/LhA3BTuN4adFNPHzb7SKOdCjUvM0NB+mmLYMFVrUkL2XK4SK0Fmj8vs/FUOyKBAmhWXau/D/CppRVts7pDNmK7OK1AeWKGQZCWr06p8ySIYP+lgTZgjKuxH2BXPZeixjjw81o+cnXYaqI/qJke7N40okFecMte408u7dOVayt9A4Q5ZiFbmRRe7Mpywe6jU5lR5vJYFqaLwYfKLtuSNE29njfg98TCwP8mHH7evCgca7HLiRFlsgWijV2glUrK1J7LRT0VNKcG0guE1/beuiCqTEguwi/6m6ZhKIyl0dpBjsNveSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB6532.namprd11.prod.outlook.com (2603:10b6:208:38f::9)
 by MN2PR11MB4757.namprd11.prod.outlook.com (2603:10b6:208:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 03:09:17 +0000
Received: from BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::4451:d890:fc6e:aa9a]) by BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::4451:d890:fc6e:aa9a%4]) with mapi id 15.20.6813.017; Thu, 5 Oct 2023
 03:09:17 +0000
From:   "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: arm: altera: convert socfpga-system.txt to
 yaml
Thread-Topic: [PATCH] dt-bindings: arm: altera: convert socfpga-system.txt to
 yaml
Thread-Index: AQHZ9nBN5Rkn+0eu50eU6zME9puPJLA5L9oAgAA3l4CAAF6CgIAAoYMw
Date:   Thu, 5 Oct 2023 03:09:17 +0000
Message-ID: <BL3PR11MB6532BC085CD5E957D3A5B86FA2CAA@BL3PR11MB6532.namprd11.prod.outlook.com>
References: <20231004030723.11082-1-niravkumar.l.rabara@intel.com>
 <43b158b2-6958-4a2f-8b2d-c6f7d3b39dfb@linaro.org>
 <BL3PR11MB6532D84A9844761292995EDFA2CBA@BL3PR11MB6532.namprd11.prod.outlook.com>
 <60d3847b-0a6d-4858-b43a-c88a623fb09f@linaro.org>
In-Reply-To: <60d3847b-0a6d-4858-b43a-c88a623fb09f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6532:EE_|MN2PR11MB4757:EE_
x-ms-office365-filtering-correlation-id: 2692a549-8073-4346-8a69-08dbc5507664
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wt4RtVnfkTXJiu3xq1PIkgV7eBJ9TDFK+o3XNMn8HPoOHVtijl7qHaYihioQYdhr2T5tlkUBpkZyLTIBe7IEqSGL1CYmawppk9ca0rxP66H4j1MtWoT3ZFND7XccsR3M2u5Ylsg4Y76xBNwtLIXyMAozXuVWykC6Hb9Ls2lVfl0S0TUA8+4MxiDGccijU0n0TmRa6j4lpm231ehv38TSPQBIyzzb1evx74WuQEtMjNLjsRi93sDsa3l+23w1geszZcFXie6Kr/GlN4nXUfJ3Zib4U7Wqyp9Rf14QUtMczCf27v9YYYcNGGVdQJli7jmDFnzlEGCjmPyGBMhivQU5rF6ON+bpwmNyX+F1Bt1PNncmFR5/T3ZHLzHXGxu3nVUMZk3QZu+Z+TzBhtVsKKTh9RsVTYMTveTQ/Y4giC3e09iCMddN+IAkhmdj6tHzn8SSFYeBwKR93BweSyvjl3meHi2gaxj0Kzx/8J7EPE/r3Zbl8zljrYBh18sYCDeEQsurEtwYb9Cmca0OjtZFPkHoMYYcV1ZTX83Q/IrUNMClE7MeZeJ7JEUpjpSFTVp6gZ9qokgLw5iDf06epmb7TYPLZMbzToTON2ZS/OKCEGsRhspLKpaLDehYGLp9xWGXKa7+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(396003)(136003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(83380400001)(33656002)(86362001)(38070700005)(38100700002)(82960400001)(55016003)(122000001)(316002)(66446008)(66556008)(54906003)(66476007)(64756008)(66946007)(76116006)(9686003)(6506007)(7696005)(110136005)(41300700001)(478600001)(71200400001)(52536014)(8676002)(53546011)(4326008)(5660300002)(8936002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2lHQ2prREhqQzhKbUNjZVJRTWRTZ2JYZ2RTeWlMVTZqdmx1a0xFeG8yZldj?=
 =?utf-8?B?SmhHNkJhVkFLbXNpNnJjeU85ZXVLS2syYnVWWTFRTnNpSC92ZHAyNjJhRzBR?=
 =?utf-8?B?TjJrY2tJZzVlRnJMNTRDNEdFdisvT3AzZGxuamZUeHduM083UVRwZmhHYzZ4?=
 =?utf-8?B?YzQzYmY3RURiZzVob0FyUzE5bmJpZTQ0NGdWSFNydkgrdFNBbHNUdDRPVzla?=
 =?utf-8?B?QnpyNzFGdVZDTXBDZkJOTmIzT3A1cTZhb0xtK1ZGRkQrYTBUMHgwMWN0dTNQ?=
 =?utf-8?B?VGE1cUo2VmNYblEwZitwaUF1bXA3c0JXVWpwVzBpdTlLVUlNeTF5WnZEc2o5?=
 =?utf-8?B?REpwNVpmd2dhd2RtY0twUk95bUdOclhLaDcraGoyZ0V5WEZ0b0FDM1JPRm5N?=
 =?utf-8?B?Rkh6TmxSWHFXaCtZNzN1TTd2TnppREQvczBDSTQyd1NyZlBmK0Z1cHpPNmdN?=
 =?utf-8?B?T3VkbmxTUkMwSU1rVG0yNU12anZoTTJYOElmS1ZWVlpzamZMZXMxMGJ0YVVz?=
 =?utf-8?B?OXFNVFVTVmJyTG8yNFhoSXRyYnhVS2ZuN1VFV1ByMVlyNU4yMWorR2owNFUz?=
 =?utf-8?B?Wjd5VmZGbWREQThKaEpNMEo0bDJOSHRSOVFyWXQ4blRDOWxMYWNRQS9paDRY?=
 =?utf-8?B?YUc0V0FNeFZETS9zZkx5MGVNM2M5QlJTczBKWlFMejd4b2dQaFh0STdtL1FK?=
 =?utf-8?B?enpYTy9CNHBtK0pyVVhjbER2bFkyRjJ4d3paMW1Wdk0wem9hUnh1YU5GNC9N?=
 =?utf-8?B?aFFReENlMytSeGorcGZTU3RkZW9jSE5EVmwyMzFYU2U2NTBvS0dNVWR3cXdO?=
 =?utf-8?B?Y01JUjR0SkZqYmdtMjJSNHEybzZOSnZjcDRCbTloMGZhNEtndko2OVNnUkZo?=
 =?utf-8?B?S0RKa2FSbzkwZDhQZktDQVN4cDNqVHdpZ3QzMS9oU01BUTJqRVBXNHJyMmtB?=
 =?utf-8?B?ZzUwYXJRb2xnUjBObTZnQVRFRWljaGRlUngzd05iVTBqUUZYQWkvNUxRaE9R?=
 =?utf-8?B?aXhvSVg5d01qQWtoelc0QWlnTTlZUTZ4SDFJenRuaDZKQjNCNjBRbHFzRUZM?=
 =?utf-8?B?QTFBRWUxZzNPTHU1TTFYVkxhN3VlZGlDSDlhRHZicW9kN3pVNDI2ODlCbWdE?=
 =?utf-8?B?eW5GVytYVUc3OEpyZFcxUkhhNkVtUWtZMmNxSFdTZm9IRWd3Z2tUdUlRVTNG?=
 =?utf-8?B?ck5kREUvb1FDSEtzSkNRZHpURzFIVk8xc0puMStZbHVhZnp0RHlhMzhzNm94?=
 =?utf-8?B?QzFJQ3lBTWVRWElmMDh6YmdmY2t6ZzVONnh5NTY5ZkxBYVhzOGhqNUJLZFJ4?=
 =?utf-8?B?enhnazdIRGY4QmdDTlFhNUd3UmErbDJTOWNKSXppWTUvNDR3Y3NUYkJvdWhx?=
 =?utf-8?B?UUJ3eXVkd09nbktqMXVjam8ycVlxU0xPZFJtaWFiTWM4cWJhTmVybWVKR3BE?=
 =?utf-8?B?NmtpMWlrWDE4UkFzcFA1bnQvSVBFaHRhZ0Fmd1pLZlNVT2lsejloSzh6alRD?=
 =?utf-8?B?NG8xcElwUTZFdUxvR1BMaWx6UTJTd3dwR2x2YlcxWmQ0aFViUVZLRitqTHdO?=
 =?utf-8?B?bG5zR2FEMVVkeVdxUlR4R1QxTFFiYi9JdVc0My90MCtpbWRMeVpuOHdPZDRl?=
 =?utf-8?B?N3lMQ0JadmtyaDR6d282MXRhY3RkcjE3V0VmR1g0NWRkNWh3SDllKzZLNVFL?=
 =?utf-8?B?TjRvcWhmZmpRQUg2R20vbzhhSmM4amdOZk5VdnY1bnM1QkxubEJNalRONnY5?=
 =?utf-8?B?R3p1RHpoTkJFanJQMnVMdFJhSTMxZnZBajBKUTF2UHh0NCsvN0UxQWV2WWZW?=
 =?utf-8?B?eW90bDROZTAxemx3MUV5cks0TFZQb0Nua1JobGZGVmhkYWxRZHVBUkI0dWFh?=
 =?utf-8?B?Q2k4THlXZFRCWk1sNUtUMS9ISk15V1hiTzhpU0RDdDM3K2hhV1dUNENvL0V2?=
 =?utf-8?B?bzYzK1JUOWJibFJoTkJFS2hzeXFqWDFLSnNEbExFSGZvMDN3NlppZ2xQQlI3?=
 =?utf-8?B?TTZQU1dxTk9ERmJGM2VDNFJ2K3FZVnhaQ3l5b1UyTEpmZHg2NGxVMTRPM2pL?=
 =?utf-8?B?aVJld3V6SHRwUzBEKzBmV2piSFQxL3ZDeUNIbjJkMTZhQWl6SEpLL0dkOHBG?=
 =?utf-8?B?UWxYakJhcEtxV2tYVUVleCt1UXRzcTc3Sm5oMmE0ZDhYbGxVMmllcklyNUJN?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2692a549-8073-4346-8a69-08dbc5507664
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 03:09:17.7269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nd1lHIUTUsC5tV7diAfTfm1uHIXeQO95J/C8dWIHwjbYd12sy3SZctjvEF3DKCt77HrAb9+mKTBoz8yWmnAyxobze6/F9Vr1ZxGPYok0Z0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4757
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IE9jdG9iZXIgNCwgMjAyMyAxMTo0MyBQTQ0KPiBUbzogUmFiYXJhLCBOaXJhdmt1bWFyIEwgPG5p
cmF2a3VtYXIubC5yYWJhcmFAaW50ZWwuY29tPjsgUm9iIEhlcnJpbmcNCj4gPHJvYmgrZHRAa2Vy
bmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kNCj4gPGtyenlzenRvZi5rb3psb3dza2krZHRA
bGluYXJvLm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47DQo+IERpbmgg
Tmd1eWVuIDxkaW5ndXllbkBrZXJuZWwub3JnPg0KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SF0gZHQtYmluZGluZ3M6IGFybTogYWx0ZXJhOiBjb252ZXJ0IHNvY2ZwZ2Etc3lzdGVtLnR4dCB0
bw0KPiB5YW1sDQo+IA0KPiBPbiAwNC8xMC8yMDIzIDEyOjMyLCBSYWJhcmEsIE5pcmF2a3VtYXIg
TCB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+
IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9y
Zz4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDQsIDIwMjMgMjo0NiBQTQ0KPiA+PiBU
bzogUmFiYXJhLCBOaXJhdmt1bWFyIEwgPG5pcmF2a3VtYXIubC5yYWJhcmFAaW50ZWwuY29tPjsg
Um9iIEhlcnJpbmcNCj4gPj4gPHJvYmgrZHRAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dz
a2kNCj4gPj4gPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz47DQo+ID4+IENvbm9y
IERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47IERpbmggTmd1eWVuDQo+IDxkaW5ndXllbkBr
ZXJuZWwub3JnPg0KPiA+PiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHQtYmluZGlu
Z3M6IGFybTogYWx0ZXJhOiBjb252ZXJ0DQo+ID4+IHNvY2ZwZ2Etc3lzdGVtLnR4dCB0byB5YW1s
DQo+ID4+DQo+ID4+IE9uIDA0LzEwLzIwMjMgMDU6MDcsIG5pcmF2a3VtYXIubC5yYWJhcmFAaW50
ZWwuY29tIHdyb3RlOg0KPiA+Pj4gRnJvbTogTmlyYXZrdW1hciBMIFJhYmFyYSA8bmlyYXZrdW1h
ci5sLnJhYmFyYUBpbnRlbC5jb20+DQo+ID4+Pg0KPiA+Pj4gQ29udmVydCBzb2NmcGdhLXN5c3Rl
bS50eHQgdG8gYWx0cixzeXMtbWdyLnlhbWwuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTog
TmlyYXZrdW1hciBMIFJhYmFyYSA8bmlyYXZrdW1hci5sLnJhYmFyYUBpbnRlbC5jb20+DQo+ID4+
PiAtLS0NCj4gPj4+ICAuLi4vYmluZGluZ3MvYXJtL2FsdGVyYS9hbHRyLHN5cy1tZ3IueWFtbCAg
ICAgfCA1MCArKysrKysrKysrKysrKysrKysrDQo+ID4+PiAgLi4uL2JpbmRpbmdzL2FybS9hbHRl
cmEvc29jZnBnYS1zeXN0ZW0udHh0ICAgIHwgMjUgLS0tLS0tLS0tLQ0KPiA+Pj4gIDIgZmlsZXMg
Y2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pICBjcmVhdGUgbW9kZQ0K
PiA+Pj4gMTAwNjQ0DQo+ID4+PiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJt
L2FsdGVyYS9hbHRyLHN5cy1tZ3IueWFtbA0KPiA+Pg0KPiA+PiBhcm0gaXMgb25seSBmb3IgdG9w
LWxldmVsLiBXaGF0IGlzIHRoaXMgdGhpcyBkZXZpY2UgYWJvdXQ/IEZQR0E/IFNvQz8NCj4gPg0K
PiA+IFRoaXMgaXMgZm9yIEFsdGVyYSBTb0NGUEdBIFN5c3RlbSBNYW5hZ2VyIHJlZ2lzdGVycywg
Y29tbW9uIGJpbmRpbmcNCj4gPiBmaWxlIGZvciBBUk0gYW5kIEFSTTY0IHBsYXRmb3Jtcy4NCj4g
DQo+IFNvIFNvQyBwYXJ0Pw0KDQpZZXMNCg0KPiANCj4gPiBTaG91bGQgSSB1c2UgICJhbHRyLHNv
Y2ZwZ2Etc3lzLW1nci55YW1sIiBhcyBwZXIgdGhlIG5hbWluZyBjb252ZW50aW9ucz8NCj4gPg0K
PiA+IERvIHlvdSBhbHNvIHN1Z2dlc3QgdG8gbW92ZSB0aGlzIHlhbWwgdG8gZGlmZmVyZW50IGZv
bGRlciBpbnN0ZWFkIG9mICINCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL2FsdGVyYSBhcm0vYWx0ZXJhLyIgPw0KPiANCj4gSSBhbSBzdWdnZXN0aW5nIHRvIG1vdmUg
aXQgdG8gc29jLg0KDQpBbHJpZ2h0LCBJIHdpbGwgY3JlYXRlIGEgZm9sZGVyICJhbHRlcmEiIGlu
IHNvYyBkaXJlY3RvcnkgYW5kIG1vdmUgaXQgdGhlcmUgaW4gVjIuIA0KRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9hbHRlcmEvYWx0cixzb2NmcGdhLXN5cy1tZ3IueWFtbA0K
DQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KVGhhbmtzLA0KTmlyYXYN
Cg==
