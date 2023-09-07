Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49333797B53
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343653AbjIGSMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343646AbjIGSMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:12:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CC61703;
        Thu,  7 Sep 2023 11:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694110336; x=1725646336;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b63IABeKe7vJF70MajKgryc8Lw5+jTlNC7m3AMt+fm0=;
  b=TFO72M44CAjDSsW+vQsscfauIbp869JYnQOtVHhQQZizJTw5revK1k0K
   WK+aT4U0OhtN/UTwnzyZxRE+8hZXf6LftThQnfGB4cCBSj9hzgjOUWoFp
   y4lomaaGZbgmGV5zxq9BkMdNWT/ziHArwv7mdfKzZHXMcsZLw7zDYMuaj
   i4eQGHr91KUeJYzFnDcs0wsyg3VIRqjeGUnWf8xanExn4NiamDg2jBSoB
   8/X2nqUFNesw2j/CpWnd1u6cUOIKIuMyIv6YcqPdBpfoKslXW0SzJ673K
   LbXij0HCcShNW/okr4nG1k0Hu/AMj2xei/W9qTAeC1/pxP6qDJWDJQ1+R
   g==;
X-CSE-ConnectionGUID: 8TXbNvv1RE2Z2dTjWv6RCw==
X-CSE-MsgGUID: uq+0TiPpRPuxlaYCf4D1Ww==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="233980425"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Sep 2023 10:36:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 7 Sep 2023 10:35:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 7 Sep 2023 10:35:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kdiex0AtqJTR8wbFugnfRGnDrCYwL/eOn6EWQXRH+dvAu7i12O1mHk2nyp7l/jamZagzCyrRH7bD6UGYKCrZ7Z38h5HBAICIZDkrXLocVaYdqZiffRkgZasqbbCVwDq5+F8YitINcdLCpMGBj9BkWwh99giWlujbsFBPqk4cDo0J3eGVKnhYdLh6X7aRv8x++LVVdx0BQX5ZLJgM8/TCnh2A+iXRsT1wBGch87jpc5NUQT+zc6MgSbMq8WxWPk/ynICb5zqrDN5Z4P7vvJ6hWTFbaVMu3D6EnCcFRs3zuneNhJ4JtM/PC9xkFYkaAwxzSVxXbTlvDVVtzJBtUd9ZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b63IABeKe7vJF70MajKgryc8Lw5+jTlNC7m3AMt+fm0=;
 b=P+E16bx4wuK76Pj3T5S762O31uRwm95WVTSN5Ndk+CkrBfAHJopCYcjnlwrsKlY4wzk9F8/pTfg74y9TuS+XwLnA1FFIZ/z9FDU6Py3iV1EdJGN8lAsfMxHcZhZSiIBFg+HgxtWGB4GO7IZ0He9qbxKYrki9zK1f3Uc9zgYGBLn0iySsh1LbtRM9edeZdUO6q2xE74p/ouxbS5UZTAmubhNqKKss4bWIfeZstMvhZf/Bng1mp8ZKS1ZIvDBnsooyxG3IFSsg6tjvrAW7PJZmCE+vHOwdejsZgF/2EFxBdl8Dn6zZ++P87pmjm1C44n37HtzAUePoir/VzealAEPdgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b63IABeKe7vJF70MajKgryc8Lw5+jTlNC7m3AMt+fm0=;
 b=GEOebAhMdVEGMFu+QLeUPWuQF9nVcPBedvtmqYbJu+w5T+ENUw5uMgDo603vEqmmmCxmk1r8LDjPjcq10LdsBwulgnLFPaU6BA8F6E/10464NKtaUNzTC462MsdivW3Xps1jxu8xXLD4eBHX0dW+OO6pP05lQfsadgRgLl26n5g=
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by PH0PR11MB4789.namprd11.prod.outlook.com (2603:10b6:510:38::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 17:35:45 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::fe40:34af:443b:5809]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::fe40:34af:443b:5809%6]) with mapi id 15.20.6768.029; Thu, 7 Sep 2023
 17:35:45 +0000
From:   <Woojung.Huh@microchip.com>
To:     <o.rempel@pengutronix.de>, <davem@davemloft.net>, <andrew@lunn.ch>,
        <edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <olteanv@gmail.com>,
        <Arun.Ramadoss@microchip.com>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>
CC:     <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
        <John.MacKay@microchip.com>, <Brigham.Steele@microchip.com>
Subject: RE: [RFC net-next v2 0/2] net: dsa: microchip: add drive strength
 support 
Thread-Topic: [RFC net-next v2 0/2] net: dsa: microchip: add drive strength
 support 
Thread-Index: AQHZ4LFOsC3lKa1Y6kuvmX31i+J9OLAPoXlg
Date:   Thu, 7 Sep 2023 17:35:45 +0000
Message-ID: <BL0PR11MB29132964F3D56FD2F555FB7DE7EEA@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20230906105904.1477021-1-o.rempel@pengutronix.de>
In-Reply-To: <20230906105904.1477021-1-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|PH0PR11MB4789:EE_
x-ms-office365-filtering-correlation-id: 2393a3be-0f34-4dd3-c49d-08dbafc8dde1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r35AK0OahQ+kjBYZynMyqq9X5SgQu9br/3VryjaDCkxn8xPgeYTNpOK1B8l//n1UG4uBwJiP29HcatY52zN98d1n4/yMsDUI7YPdY4V2uxb+7M0R5Sj2A01Ys7nQ58nTSG5yeLvRZ2SgBkq9tMY0tfGNcxLkW91FJ8a0X85qhRaSjvF2dWenUvfhnqOqsb/p0v+b2BESoBk67+XtUUCw5Y8mixqUTFJ7OWkF7kO3Y290j39H+NDJtkr6s1Tc7WvcjsYwwMfpB7AjAyDQNTBinzfBn43GB+FQVAcCriQqG5MSRJoDsZwWbBjaSsGrSjGAwTq7AWZcXAzDKmA6bcduOMMM57nhLoFsNKIdH2PNjgp/RjNPBCw94B6ZkgYpCoBuk2svJ38/H4pREmVUbqulcNozjX7yPL3esjtv3293DR7XNc6BkCaJlKvSKptGWt/i5egFnYCXlmx0pjlkbG8reXCqaznvcdS/8xrQ9SnVvkFKsdRu/EOVIoGEsQJzuFYzNg+Wka5TDWdmbPqjofrwvBMqri9taKk06renmPZFsudX4si89DBqye4URStsMuUYl0dblBaEwkzDKZg6/8JIYf1roM8AU3fpm9jU9CVOW46ydHsUwGAiFEArW/+Mb1+o5Xuw8r2y4A7tTSKFZc9ooA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199024)(1800799009)(186009)(52536014)(64756008)(66946007)(54906003)(66556008)(316002)(66446008)(76116006)(66476007)(107886003)(8676002)(8936002)(110136005)(4326008)(921005)(55016003)(122000001)(6506007)(53546011)(7696005)(9686003)(41300700001)(478600001)(26005)(7416002)(83380400001)(71200400001)(5660300002)(4743002)(2906002)(86362001)(33656002)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnVjMjVha2x0QWF1OFhldkpON2JRZXZ1dU9BbjBHMlZBemhoYmVKTm5XLzlI?=
 =?utf-8?B?aDNJUjRCQmFsK1lJZ1JJelFrZllaT0tBMDVOSDd1dGRtUmNodm5GU2l6SDBI?=
 =?utf-8?B?WFpJUmhMMkNWZjRvanFVcWxRaEpLbkgvajFua010bk9CWHhGbWo0R2hweFpH?=
 =?utf-8?B?Uk1wVzJlM0VZUXR6Z0FHcSt1TVNFMitKMkJscmNKN2dqbW5icWJlcmI1bVFi?=
 =?utf-8?B?QkVLRi9vMnNBZGJ4WENCWWVkZmZvQTJmZlhlc0FrMjM0RVdveHEwemQyQXg4?=
 =?utf-8?B?WVVDSXJoY0Jvc0dUTUoxemtvUzd3UzF3Z0Mrb0RYZzFhZ2FYdXRseWNGK0s1?=
 =?utf-8?B?aWZiN0cxenpia2tZRzdkRHNOTytaY1R6eVhUMW5tcUs1d2RDUVBFVWVvSWow?=
 =?utf-8?B?MGs5VnpkbWpuQ21qS0lhczZXZnVoV0dzNmhiNFdVNklGUGN3ZVIyTHorTXJv?=
 =?utf-8?B?c0VHYyszenVJQXA3dHpWVTlzT2FPR3ZpOWtnOWNEMkhxVzN5bWllRXIrM0F6?=
 =?utf-8?B?N2dCY2JLcmdzK3NsWjR3MnBjUFd4YnNFSXR4N0wrMldNWTAyZFFJdXlrdERO?=
 =?utf-8?B?bTRqb1QzYkJMMGFmRWhmelJsanBkZ3FYRDlHRnhwOVVLeTdRTkJBMkFmL2s2?=
 =?utf-8?B?TUdxdWV2YTk0dWcyMFBoL2c2di82RGE1K2RaTG9RSnBmMWJ2UHRwTEZmbkhH?=
 =?utf-8?B?MmdlWW8xUktlRm1OV0x0OERvaFV4UVI3WHVnK3hSMWloKzNIdmR3LzNWOVJx?=
 =?utf-8?B?cHpHRnVjOFhjeWM0aVdIVHE5MWhVSGoxL0s1QXgzNXR2UFd0ckJ5L2IyZ1Bj?=
 =?utf-8?B?L2VBSE5wYXBndElDdzVKaHVZUmNqNE8yUGMzUURNU2ltc2pVa2NRS1NpejlW?=
 =?utf-8?B?b3EyaTFNM29ZZjRJL0dBaG4ramlFcGhwZEh2c0pGelJ6NFhydGhYd05BVm9N?=
 =?utf-8?B?RFpLSVVGV21ia1hJVlVnUytXOUJGa2JseGlDMEM1K1pkaGVscUY4aUtuMjZ1?=
 =?utf-8?B?T05JL1JYUVREMGZFVjJhQXBiQklkbU11MmJPeWpVbm00a0E1WGpDTnJ0N1lj?=
 =?utf-8?B?ZXlKVHJoMXl5WVhFYTV5NElzYWtoNTNaeFpRUzhQN2tIT1FDVjR5dkI1SlJK?=
 =?utf-8?B?bkpGa2tlcjNEN29DV1FxMGNCY3I4R2phbVNOY1d1enhkMmFFUnk4Rkxlb1Y1?=
 =?utf-8?B?YmpmczlCS0tuVmh5dUlORktOaGN2WSszWTVkOWEvOFBud3FQRW1sbWVQQWVT?=
 =?utf-8?B?RnIvdHZ6KytrTkZvbFVnK3ZyS29DR1VrelpZd0IxT3A4NUR2ZGU3QXByZFhy?=
 =?utf-8?B?dktvdjhvT1NZa0E5MWp3ZEk5ZUZIdGtuNEFpT3VaQWpmRlBLakk2ZkJ0UWxp?=
 =?utf-8?B?RldSWXZITm0xWXVxQ2VsdDRiUDZpU3dCT3pTZjFXeTRXWlYzQzMraGtsTTYz?=
 =?utf-8?B?Q21Vdjd2M3pPQzZGRytqRmUwUVVCQ2RTUlZhT0g3VjY5bWpCUVZKd09PclIw?=
 =?utf-8?B?azVaWEFFRVpsWklZNEdmdlVYN0FxcnFCcGFVQi9mMWJLMGVDV0l4NVVpY0Fv?=
 =?utf-8?B?bXdpeWQzVi8zR3ZBWGFoZmJCUVRCS2plNUtSSyt1bnpmODJUZi9lN1dWUnpV?=
 =?utf-8?B?dXBPdlBkNC9Md3RKdGR6c3lKY3p0am0rYXN6YVl1cTNIaG9xbTVhVGpSZ1RY?=
 =?utf-8?B?bGtMTnUrb2VVajYrdGRIWmpxai81bjd0QzZWYmRhQUl1SE03L2Vma1RuRVBh?=
 =?utf-8?B?WU9LTjVNOG5VVEIrT2RTQ0dTZEN0YU1teGdxcytPTW1sdmNuV2ZETnZsTG9n?=
 =?utf-8?B?bXpoUVBSMjFXcmozbVlGbE1GT2pKMzZkUTNRaUdqQlhMeVJ2UG9FWThkelZV?=
 =?utf-8?B?TGY0bUErNFpvaDRuczFmWkgvSFpZbE12MWxXcStWbEswcnpzelFvSnlrU202?=
 =?utf-8?B?LzdwNGVKeHRJNXM1YUhwWGM3S3ZmTmJPZ1llYUczaCtUYk1wR0tUeXpUcTEz?=
 =?utf-8?B?QmwxYzdsVUEzQUh2dUhaalBpRnU0TElQb24wc2w1MHFrMkN4SnFQTWcvRnVC?=
 =?utf-8?B?V2JlQklCVE1Rd0F2VElPVkZkS04xbmIwc29rLyszTVZFdnU0YU55ZVpBa2w0?=
 =?utf-8?Q?fAgll8Roi0ML0RrzFfxhQJ+L2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2393a3be-0f34-4dd3-c49d-08dbafc8dde1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 17:35:45.3675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wSN0DtLDG3+DQ0XEhZRIWlzXnDf/HZWXcWKwVGLsI/IymbPCuck46T1ubuaaFzfzHSkWvfxfXKXutHlKd9ljkWaRloEfmPTxoVBRDRE6MY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4789
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgT2xla3NpaiwNCg0KVGhhbmtzIGZvciB0aGUgc2VyaWVzLg0KTWljcm9jaGlwIGNhbiBjb25m
aXJtIHRoYXQgS1NaIFN3aXRjaCBzZXJpZXMgb2YgS1NaOTQ3NywgS1NaOTU2NywgS1NaODU2Nywg
S1NaOTg5NywgS1NaOTg5NiwgS1NaOTU2MywgS1NaOTg5MyBhbmQgS1NaODU2MyBpcyB1c2luZyBz
YW1lIHJlZ2lzdGVyIChkcml2ZSBzdHJlbmd0aCkgc2V0dGluZ3MgZXZlbiB0aG91Z2ggbm90IGRv
Y3VtZW50ZWQuDQoNCkJlc3QgcmVnYXJkcywNCldvb2p1bmcNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IE9sZWtzaWogUmVtcGVsIDxvLnJlbXBlbEBwZW5ndXRyb25p
eC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgNiwgMjAyMyA2OjU5IEFNDQo+IFRv
OiBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBBbmRyZXcgTHVubg0KPiA8
YW5kcmV3QGx1bm4uY2g+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBGbG9y
aWFuIEZhaW5lbGxpDQo+IDxmLmZhaW5lbGxpQGdtYWlsLmNvbT47IEpha3ViIEtpY2luc2tpIDxr
dWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaQ0KPiA8cGFiZW5pQHJlZGhhdC5jb20+OyBWbGFk
aW1pciBPbHRlYW4gPG9sdGVhbnZAZ21haWwuY29tPjsgV29vanVuZyBIdWgNCj4gLSBDMjE2OTkg
PFdvb2p1bmcuSHVoQG1pY3JvY2hpcC5jb20+OyBBcnVuIFJhbWFkb3NzIC0gSTE3NzY5DQo+IDxB
cnVuLlJhbWFkb3NzQG1pY3JvY2hpcC5jb20+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5l
bC5vcmc+Ow0KPiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxp
bmFyby5vcmc+OyBSb2IgSGVycmluZw0KPiA8cm9iaCtkdEBrZXJuZWwub3JnPg0KPiBDYzogT2xl
a3NpaiBSZW1wZWwgPG8ucmVtcGVsQHBlbmd1dHJvbml4LmRlPjsga2VybmVsQHBlbmd1dHJvbml4
LmRlOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwu
b3JnOyBVTkdMaW51eERyaXZlcg0KPiA8VU5HTGludXhEcml2ZXJAbWljcm9jaGlwLmNvbT47IFJ1
c3NlbGwgS2luZyAoT3JhY2xlKQ0KPiA8bGludXhAYXJtbGludXgub3JnLnVrPjsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1JGQyBuZXQtbmV4dCB2MiAwLzJdIG5ldDog
ZHNhOiBtaWNyb2NoaXA6IGFkZCBkcml2ZSBzdHJlbmd0aCBzdXBwb3J0DQo+IA0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZQ0KPiBjb250ZW50IGlzIHNhZmUNCj4gDQo+IGNoYW5nZXMgdjI6DQo+IC0gbWFr
ZSBpdCB3b3JrIG9uIGFsbCBrbm93IEtTWsOcIHZhcmlhbnRzIGV4Y2VwdCBvZiB1bmRvY3VtZW50
ZWQgTEFOKg0KPiAgIHN3aXRjaGVzDQo+IC0gYWRkIGlvLWRyaXZlLXN0cmVuZ3RoIGNvbXBhdGli
bGUgZm9yIGtzejg4eHggY2hpcHMNCj4gLSB0ZXN0IGV4YWN0IGRyaXZlIHN0cmVuZ3RoIGluc3Rl
YWQgb2YgbmVhcmVzdCBjbG9zZXN0Lg0KPiAtIGFkZCBjb21tZW50IGFuZCByZWZhY3RvciB0aGUg
Y29kZQ0KPiANCj4gT2xla3NpaiBSZW1wZWwgKDIpOg0KPiAgIGR0LWJpbmRpbmdzOiBuZXQ6IGRz
YTogbWljcm9jaGlwOiBVcGRhdGUga3N6IGRldmljZSB0cmVlIGJpbmRpbmdzIGZvcg0KPiAgICAg
ZHJpdmUgc3RyZW5ndGgNCj4gICBuZXQ6IGRzYTogbWljcm9jaGlwOiBBZGQgZHJpdmUgc3RyZW5n
dGggY29uZmlndXJhdGlvbg0KPiANCj4gIC4uLi9iaW5kaW5ncy9uZXQvZHNhL21pY3JvY2hpcCxr
c3oueWFtbCAgICAgICB8ICAyMyArKw0KPiAgZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3o4
Nzk1X3JlZy5oICAgICAgIHwgIDE0IC0NCj4gIGRyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6
OTQ3N19yZWcuaCAgICAgICB8ICAxMyAtDQo+ICBkcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tz
el9jb21tb24uYyAgICAgICAgfCAyODYgKysrKysrKysrKysrKysrKysrDQo+ICBkcml2ZXJzL25l
dC9kc2EvbWljcm9jaGlwL2tzel9jb21tb24uaCAgICAgICAgfCAgMjAgKysNCj4gIDUgZmlsZXMg
Y2hhbmdlZCwgMzI5IGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0KPiANCj4gLS0NCj4g
Mi4zOS4yDQo+IA0KDQo=
