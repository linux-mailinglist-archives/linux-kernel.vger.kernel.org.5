Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778287718E6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 05:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjHGD4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 23:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjHGD4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 23:56:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4242D10FD;
        Sun,  6 Aug 2023 20:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691380604; x=1722916604;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WSnu3N2KTELqRHiCd7RjrFverT6LZyOWNDAJxoBK9MA=;
  b=cKl+M0zyhcrzux9Cr2ngqL2ylIPh0uPwN1hnDq1mCTNp6gCTgM7j7Xgx
   U5iOPlkA0zMecf7Ctx5pR3LveT05agSO7SUMAbOyG/yL1CudYb+tA+wuL
   4Wkg0GQJK25KjSE1ZpANSG2xg+WNuEcWCn6AvgR5Y5pjmJ6ls07sPXI4C
   EKilZo8l/MqQvrE8Jl+4WE0BrjlFcEiaC87jFrnywr+a/J87/DLpcFrm4
   YsrfKBN3RnHZFPb6jfxIa4CHc7jaFCxf2sLwShEcrjBUE47TItVDvzZ7j
   yKLpgU4ZbQan4pYe9JcfYx9OcasRGKyTJc8q8c9jFNtUbVGBauko66viq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="355386399"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="355386399"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2023 20:56:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="904566989"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="904566989"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 06 Aug 2023 20:56:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 6 Aug 2023 20:56:42 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 6 Aug 2023 20:56:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 6 Aug 2023 20:56:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 6 Aug 2023 20:56:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpOSSLLXnMmjDlCyTRBw5+XWY9M0yBpn12jtl/We7nDHi7TpRqgwToMZICaYWHOPOivHTrdJYXT49AjXZCFwMEXS7/yHgqE6ecjm/b9omUmjNR3tmD65dQqJiVCXdoZb0OfNoUfCZ1+QAI8rf/ByqIroOmbsMeLmDrFeJpTzfWaEDvArsx+DcZGPN5TfZMZGcRxSJlwq5WK+KrpuqJvQrEWoBHK1UlFXUF9j9vNichAIAjE+kCwmGo9itGAzMejoxcA3PiAW9dUsQbP94jKtXtt6rsAiHyDJO2mykvCzE+wULAtibEs4bMzPiiGEkLAkSGB9182UjuBmczXIjanzMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSnu3N2KTELqRHiCd7RjrFverT6LZyOWNDAJxoBK9MA=;
 b=KAboSAoFGJZpYh3DUjl4RukHsb+5beSc7F1e2m0h/gNZsk4/7gMG5zDiNNwWcTKXotPAm93hxkKhh6eorrgDEG3iG1CPVa1EdHQG3jSYl9E8R1R8zD9+jtnE3jP4AwZn3+5obbTUFuzyyucBeKf7IeRcdKrJXxi+ByrP1r7ZV8NC24wCiPlg+d3cVk1Wg+tpx5HOSS9AVJ1RMcmG6UeQrJQDQIyzLRQJ9ZQbdg6qZI/CEFPJSYUbO7lJkFpRlOd/kxXNvwlXS5Ac4/vP0AdaXeJtZiarQfVmRwx5yZmICNOnEPgQqYdIEuzuq0z2lSZZrnjlKf05VkkmABcJSV2OHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3291.namprd11.prod.outlook.com (2603:10b6:5:d::10) by
 CO1PR11MB4945.namprd11.prod.outlook.com (2603:10b6:303:9c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.26; Mon, 7 Aug 2023 03:56:35 +0000
Received: from DM6PR11MB3291.namprd11.prod.outlook.com
 ([fe80::cf83:5843:b3c9:10af]) by DM6PR11MB3291.namprd11.prod.outlook.com
 ([fe80::cf83:5843:b3c9:10af%6]) with mapi id 15.20.6652.025; Mon, 7 Aug 2023
 03:56:35 +0000
From:   "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "Ng, Adrian Ho Yin" <adrian.ho.yin.ng@intel.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Turquette, Mike" <mturquette@baylibre.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "wen.ping.teh@intel.com" <wen.ping.teh@intel.com>
Subject: RE: [PATCH v2 3/5] dt-bindings: clock: add Intel Agilex5 clock
 manager
Thread-Topic: [PATCH v2 3/5] dt-bindings: clock: add Intel Agilex5 clock
 manager
Thread-Index: AQHZxBQYoDLOJHXuDEWKBojhTKBqcq/dsgiAgACL3yA=
Date:   Mon, 7 Aug 2023 03:56:35 +0000
Message-ID: <DM6PR11MB3291E2046F9596358B6384F8A20CA@DM6PR11MB3291.namprd11.prod.outlook.com>
References: <20230618132235.728641-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-4-niravkumar.l.rabara@intel.com>
 <6fcd8e51-7e97-1261-7cd5-5e18840aaf8e@linaro.org>
In-Reply-To: <6fcd8e51-7e97-1261-7cd5-5e18840aaf8e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3291:EE_|CO1PR11MB4945:EE_
x-ms-office365-filtering-correlation-id: d4e3bf2d-affd-4a27-d203-08db96fa4b48
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v51T9clfvcbnoc/rdacaZBlvSJ6hOT8WzscUvp1wrT9y5Bpe2i73iKSqcP6XJTC80XYkbRELHTtBCBht1ahWFrxYNKFHfXYVPlXXEC1yEI89DiMveWJq86xwWliZw0ApeH3BGowJuKi33KaNIt3Y0/4qKBsA3nIIyOOu3q5yXlLFE4jra//z3ZRtMhAn2q/NyKu5phA2DXSVeiS5BBsqJPMWDQAUCG26AZd6xsicxng+GnZ87+Cn61c9SLeol+kpGlLBnt6nHe+chaZ0CeZSVjp2fNahIL51frNdO+FSZO2K8mloDGqkBqKow+UH/H73sBSvqJ45Q+8BaPn3058UQxMTCXLDnCP7DUz+F9ZX0Rmzj87TdzjUarOxKzL3O47fNlRTRFV7lCksouK+ZDichR131H84J2n31F5d25HBBGqGQqI4lRiQVRh9diQ2CQn3O9S7GBe2q4BH7JZpFN7C5FZHtE0pz5uQ5hSS86zBFvwi8/sb1ggC8oZbJDPbz1yiDwZPtcTfXe80PhW/TyVZQ7dbu3nWZt5dhDD+2vpWPHTwvW0ymH+bkodZs2765/p6G+qqSqXKYzZiaGLZpRmazfoTFGv5IbVcBxpqA9g2JfYdFpR5efIu8spRFa3Ws5Mv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3291.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(136003)(396003)(366004)(186006)(1800799003)(451199021)(52536014)(38070700005)(41300700001)(26005)(107886003)(2906002)(5660300002)(83380400001)(7416002)(8936002)(8676002)(55016003)(478600001)(122000001)(6916009)(86362001)(316002)(82960400001)(33656002)(6506007)(53546011)(7696005)(38100700002)(54906003)(76116006)(64756008)(66446008)(66476007)(66556008)(71200400001)(66946007)(4326008)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wm1IN0d3Q1lYUGpqSDlRMmhpRVRTaUdCZGVMSm95YTk2aWp5OEdtNXNBZzJR?=
 =?utf-8?B?eHd6NEc4OWpvUDZrYmZVM2duaGtXZ1hDVFJEK2FVay9XN0JZTVVRcU1TYXcy?=
 =?utf-8?B?citVT0c1eEwydnozdDRQOE5iL2o4aC9INXhnQkIyU0hhRzZTc0U0TVZNN3ZY?=
 =?utf-8?B?K3dXRWxCNDNpOTdmKytCT0pqc3dxZW9lYWhZazd6ZzlXdU13WlJQRURHUUpi?=
 =?utf-8?B?MjNtS2toSDJLK0hjN1d5SE0rWXBvWjhKNkpRRlFOeWMzeXd2bktUUmxYc3R1?=
 =?utf-8?B?UmUzNDZqWVNBQ25scW10S0JrVjh3SStCNVBNL2pUTGhKdkNORDltdEg1UzAr?=
 =?utf-8?B?QmQ4bGRlQ3YvL2tjQSt6SzlJVnBZVFF3ZUwzRDc3S2dkeWpaamZmVmtRd0Nr?=
 =?utf-8?B?dmZEUlVvVW4vSGNnK1lUWXNqYmsxdm9vZkxvZmhWWkI3UEljZWlqdDRCN0pZ?=
 =?utf-8?B?Yk9LeWU5YUtyYWU2MW9DL2lvMUR4eFNCOStxUm8xNlpBd0ZGZzl5MkIxaUJm?=
 =?utf-8?B?dDRqQUFCcUZBRFZ5MzJXL2Z5eU52WWZLOFBkRERsMTJ4eW14YVNFSHN6TDc0?=
 =?utf-8?B?SDM0cGJkUkk5Q2tDa0FFbjdydzI0MFIrcVcrKy9SN1R6bWFlUWYvQkcwUERM?=
 =?utf-8?B?TXhId1E1cUN3Ukl4T2RtY0JmV3VjZGs1eHRnSXhvR0tUWEIrTEZGOUUwSUVt?=
 =?utf-8?B?WmpsM0ZVcTdPVmM1WmVoaXlHQWZKQVdYUk12ZWtORkQrWnpZcjdVRXVYa3Ny?=
 =?utf-8?B?NG1YcjJFSU1KR29wUGhPKzh6L1AxcVhNK2tpdVhWWDcvMXZDSGhYWlFqSHF5?=
 =?utf-8?B?bTFtb2NDVFkzcDF4cDJVa3Zpcm9SZ09SN3B1S3AyajBzTzAwQnF6V28wMk8y?=
 =?utf-8?B?UXZZZkxiRGtHbzVnNGpCeFkxdmNvTGJDSlpDbzhLYjdIUUg0WWEvNm1QRS9Y?=
 =?utf-8?B?L0dZQWtialRZa1VnKzJ6M1l0dzBDZTJTTWtuNWxqUzZJNFM5QU5SNm5CQWlp?=
 =?utf-8?B?UWdidzIrbENwQkIzWlNIWUVHRFIxQVJGWmtnaGJQajA1Umh4Uk50Q3pKRVZ6?=
 =?utf-8?B?Yi9OZHM3SUdCWTlTais1OS8zU0NsMlh0a2V1SHdIUmZKWFgvREx5enc2ZHZX?=
 =?utf-8?B?VEpoM0dacExIRVJsaEhoTVVoRC85L2J6Q3lZMHE5NGczc2tZajUyV2JRSUxj?=
 =?utf-8?B?R3NXeEpYbU5INWxNN1NwUTJkdzlTT0RyakZuMVl2U1IyS3BGdHBkVmNVNFBB?=
 =?utf-8?B?Y2RiUVE2ZUIwbFBmaFY3MW1KODJrbXlLRzlmbHh4NEk3M1JCYzJIOFNOOWVF?=
 =?utf-8?B?T2pmSWtqejZYYUN4blgxTXNBTXZEN2hzYncybitBZ25VQk1CSFBOd3ZmRUQ5?=
 =?utf-8?B?bUpZOGxZcEZkNmQvaVd4WlU4OEFWMHhaT0VVd0ZIUE15djFqRW1UTjhnanpj?=
 =?utf-8?B?bDQwTGV3ak9STVNIMEwrYTdlaTkxT2VxOWpJZm5lWmM1b2tmcE9jUzlmbEtF?=
 =?utf-8?B?T0Mxdkx0RXZ0aElNeFJwUWtZVHJKMSswUUhtdTFoem55VHd5QlRuWFNTVVJD?=
 =?utf-8?B?UVlrMUVaOU5IZ205WlYzY0xkRlE3N1luNnFma3ZVaWJpdHZJT3hJYzRxbm9P?=
 =?utf-8?B?VUxPU3JuME1tVjlTSElvZ2V3M3Z5YWltRHVJNkFKSVE2ZzEvRGp0Z2ltWHEx?=
 =?utf-8?B?WFBvdkFHeXFlMUlGaXp3Wm1yeWlFbitqeWdYYks0UWxoOTFFeitFNnE4Ryto?=
 =?utf-8?B?aVk2UDMyTWFld3llWDRWUnlHSGpJRnhiU3FheURHVllRSCt6cDB2THVCbCtx?=
 =?utf-8?B?Y24wd0NpRE9Id2VTNCt5U09OUW5OWEVuMHF1a1RCYlpjdmJ3VDUzQ1d4d3hq?=
 =?utf-8?B?SytQcG1oTXpEOU5ScnNFZVo4OUJFd3NCaFlZUVhmZ2ZIeVpJZ2hEUFd5SEh5?=
 =?utf-8?B?RjB4a0pEVTdsbS9USWdSckFpcXovamhRVWxkNTFxWXJhZFV1SmR5a0JQK2Zj?=
 =?utf-8?B?dzFuYjZLSjZQVzhvenAvQXNQWEJ6eWIrRWgrak5OUU1ZRVFhdmNHZ3Y2ZTdt?=
 =?utf-8?B?V2lvYXIxcjFDR1NXNTRoT3ZMcnE2eDQyWnRic0kvQmVMNkV6d09UcUdETmZt?=
 =?utf-8?B?OEJRRldnWDYwY2lvT1VNeENGcElaSDJwQlcvQWM0Wi81TThkNTNHc0I1ZVFw?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3291.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e3bf2d-affd-4a27-d203-08db96fa4b48
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 03:56:35.2035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I7AOaWz4+0ofE0GihMk7enttUJMGtOR96mtpb/V0MPAwcEwrjmWd3r3BiK35MXxmfcTpE6xHCc009FLLlcI4CH02Btzmz8SWnTi3VRMoi20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4945
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBNb25kYXksIDcg
QXVndXN0LCAyMDIzIDM6MzUgQU0NCj4gVG86IFJhYmFyYSwgTmlyYXZrdW1hciBMIDxuaXJhdmt1
bWFyLmwucmFiYXJhQGludGVsLmNvbT4NCj4gQ2M6IE5nLCBBZHJpYW4gSG8gWWluIDxhZHJpYW4u
aG8ueWluLm5nQGludGVsLmNvbT47IGFuZHJld0BsdW5uLmNoOw0KPiBjb25vcitkdEBrZXJuZWwu
b3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgZGluZ3V5ZW5Aa2VybmVsLm9yZzsNCj4g
a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyBsaW51eC1jbGtAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgVHVycXVldHRlLCBNaWtlIDxt
dHVycXVldHRlQGJheWxpYnJlLmNvbT47DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IHAuemFi
ZWxAcGVuZ3V0cm9uaXguZGU7DQo+IHJpY2hhcmRjb2NocmFuQGdtYWlsLmNvbTsgcm9iaCtkdEBr
ZXJuZWwub3JnOyBzYm95ZEBrZXJuZWwub3JnOw0KPiB3ZW4ucGluZy50ZWhAaW50ZWwuY29tDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMy81XSBkdC1iaW5kaW5nczogY2xvY2s6IGFkZCBJbnRl
bCBBZ2lsZXg1IGNsb2NrDQo+IG1hbmFnZXINCj4gDQo+IE9uIDAxLzA4LzIwMjMgMDM6MDIsIG5p
cmF2a3VtYXIubC5yYWJhcmFAaW50ZWwuY29tIHdyb3RlOg0KPiA+IEZyb206IE5pcmF2a3VtYXIg
TCBSYWJhcmEgPG5pcmF2a3VtYXIubC5yYWJhcmFAaW50ZWwuY29tPg0KPiA+DQo+ID4gQWRkIGNs
b2NrIElEIGRlZmluaXRpb25zIGZvciBJbnRlbCBBZ2lsZXg1IFNvQ0ZQR0EuDQo+ID4gVGhlIHJl
Z2lzdGVycyBpbiBBZ2lsZXg1IGhhbmRsaW5nIHRoZSBjbG9jayBpcyBuYW1lZCBhcyBjbG9jayBt
YW5hZ2VyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGVoIFdlbiBQaW5nIDx3ZW4ucGluZy50
ZWhAaW50ZWwuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBEaW5oIE5ndXllbiA8ZGluZ3V5ZW5Aa2Vy
bmVsLm9yZz4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOaXJhdmt1bWFyIEwgUmFiYXJhIDxuaXJhdmt1
bWFyLmwucmFiYXJhQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gDQo+IERvIG5vdCBhdHRhY2ggKHRo
cmVhZCkgeW91ciBwYXRjaHNldHMgdG8gc29tZSBvdGhlciB0aHJlYWRzICh1bnJlbGF0ZWQgb3IN
Cj4gb2xkZXIgdmVyc2lvbnMpLiBUaGlzIGJ1cmllcyB0aGVtIGRlZXAgaW4gdGhlIG1haWxib3gg
YW5kIG1pZ2h0IGludGVyZmVyZQ0KPiB3aXRoIGFwcGx5aW5nIGVudGlyZSBzZXRzLg0KPiANCj4g
QmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KU29ycnkgaXQgd2FzIGEgbWlzdGFrZS4NCldp
bGwgYmUgY2FyZWZ1bCBub3cgb253YXJkcy4NCg0KVGhhbmtzLA0KTmlyYXYNCg==
