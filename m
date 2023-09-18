Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F91B7A4877
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241434AbjIRLcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241695AbjIRLbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:31:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3EB10EF;
        Mon, 18 Sep 2023 04:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695036599; x=1726572599;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bH/Ubu5mp1udw7rUikXMhI11vrANTJHbYk+wTKyzDQE=;
  b=S5kYct0sk8TMuW60bMXNU7ZrqPNT7Euyb14ltndBQBievEPYl179bOcB
   eMynOD17KfUxd7pioOFb+Dv0uAAvVS3F6My6KKSGi+Xpc3PX3diVzMY+S
   xTLHn5YZCI6Yk58079ZcKt6Gb/8i2IZ2czOqgX/nNgV51+TmbtF4k69vK
   4FFD5SO5up2V1Z7RbA+TvS83FG4NgyYtPN2qM9mwm1SW3yabRfNnunILM
   DtlEO4sYL/Pe0jGOa8CVoI+0Uxe+sOISyqY23V1mbohqQgUp4ZdCyzi4Y
   g3FSSmkHIF02EsCPmwjNwOhG0fLNR0D2moiZC2hMdXs+vXb00LzSOYuwM
   w==;
X-CSE-ConnectionGUID: AX5F2GGaS4mN+FgnJvrkWg==
X-CSE-MsgGUID: BVZBTsCDR3KFSMSkgtGhXg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="5370608"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2023 04:23:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 18 Sep 2023 04:23:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 18 Sep 2023 04:23:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPYg9GjHOWPwT/fZn8oxoHmfU/2dzYH3t36mgTTd/GXL3raKk50AHb3cI0DEjgRdEYXb2AFXjD64qtwK/saxUiP8rBivc4uFCmW28SfSaqWNGh+gvzAvU9Lf9oAn5iTK2p7+rg2+OLknDyte4lFacBIentYnboJa3XPHl0BEFEAereClmNSmg/GaadGuCrvAekTIi6SlPkCihlCbbdJyxM3TpKv8FdT8Tk06B/h30k6LiKLIG+Y3OHiOiYZtvGdreZHF2JbI0p7kkbJAnHp6V25ch6Kx+NmBri3W4rWBs/g3xvMPk74d/RwDcesVzuHUnUqmrmuFOM7aJs+BN55uHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bH/Ubu5mp1udw7rUikXMhI11vrANTJHbYk+wTKyzDQE=;
 b=jwj79jk9dc4D5xP6ala24KmIAaaHMN3wLYOZZoIZZAzpRKOFdQuw9UgQXtT+BOIxreLJD9VBjEM4Fxgt1RJR2SY8EHqAFcDZZHRyWU/M96Ese6SV5qmjo3M1k8hkmwJsfmkacLGEM5Vcpmdv+0drK1/FrRlPoXX2MLqqUtHSk8mYltuEDdeRi7DXfUmBwdRh9kllTJM51ZsXeES6M3qIhNawz0e5l/5ckDz+/2G0FNMbjOF0vViIuNgmCHyoYtGhrp/5w8A/rGPsZUFyjAH5MDsmTFMYgmha17sFP98KRKDR8KOBZAlxM9IIzE3NrbT7JLY9EpQtNgyv0mfiP2UHkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bH/Ubu5mp1udw7rUikXMhI11vrANTJHbYk+wTKyzDQE=;
 b=Mu8zabqs+KjAcTIC0KW8Q9DwCaItXwTmqdWnh88UUMF6+dqIhQgPUb1yvbCF7UyctB/0nqtoVAMhHPtZOclFJtZ+7kJ7SKx6eoDmIq/kl/L2wot6LffJsa6Dh3wtU10EjREDmxZ/AHi05O00+N8RsAXwRoG+C9QA041et4cXFKA=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 PH7PR11MB7026.namprd11.prod.outlook.com (2603:10b6:510:209::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.23; Mon, 18 Sep 2023 11:23:42 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 11:23:42 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <andrew@lunn.ch>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <Steen.Hegelund@microchip.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>,
        <casper.casan@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
        <Woojung.Huh@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>
Subject: Re: [RFC PATCH net-next 5/6] microchip: lan865x: add driver support
 for Microchip's LAN865X MACPHY
Thread-Topic: [RFC PATCH net-next 5/6] microchip: lan865x: add driver support
 for Microchip's LAN865X MACPHY
Thread-Index: AQHZ4mEuK01gdvjwlU2rxFfJz2fLmrAZmDGAgAboGYA=
Date:   Mon, 18 Sep 2023 11:23:42 +0000
Message-ID: <2f60de6a-124e-8c8c-1c79-73fa38141e41@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-6-Parthiban.Veerasooran@microchip.com>
 <8d5078b0-1a45-43ac-89bd-c71c514336f5@lunn.ch>
In-Reply-To: <8d5078b0-1a45-43ac-89bd-c71c514336f5@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|PH7PR11MB7026:EE_
x-ms-office365-filtering-correlation-id: 5cadb96e-d706-4bd6-a860-08dbb839b6e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vybr+Ojmt7SxGSgR8kpo7FFSTT9Lli3RT/ztGwWZBXnZ4gTrWgwvwsP4P/BGgxEiPXW2nNbw72AQeX6jvp7PCpkCR0sc6jEfYDpcT9+hnRsDqFaJ1p64pVX5Zir3PJ2A+r4CgHp6rsZXPxSo7EzBMK9M3YN03e3TqfkbEbMOIzMu4y/rAKTqyT6eEVlsj7T3Vyi4s3IZqjH3b1maq0aXtEyV7hRxDIsKFFqKI68ZjNEIc2txZRQyDyqcDIpNtU+A3efXg7JoHvuCivqL2PhgT+ciev8enTOVsJ49aB9xYJEp00Ofs/n6LpKGEjZyNf3nIo+LnetlTJimrTZ1Qn2GdelTP2RF+oiiJ4OA2Q8gO/Z45TZkTeBBPY0IOj0nhEaVpXR9PpWwr9VbnT2FOBUcwKQSqicr/byPrOs/oPYjJ6mGSZp6lDyYKIYKZSsTpwlJQUx0OkPYj7I+fy91k0w2sFJ/G2Rho/YWHPE8dio08skl81eM6cjJL7U3o1pNvpc7Px7OiZ0y5Nn9IDD/HUAqS5YQ2DTx4hpL/gadyYSGpu9+q1gmSiMJcJ2DqWeYagWkSE6GoghwCcTNNU53X46sUTI71OkHZiQPsKsQbW91YkbcmtgaxFvrUT2t8X7nQRlm4i9Z9u/7tHFnfyG+U2wJXwpZnJHvQODlWCHoJaguMIo/ic1F5F6Oej/Q0zE7B2z2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199024)(186009)(1800799009)(66556008)(66446008)(64756008)(66476007)(54906003)(36756003)(31686004)(38070700005)(5660300002)(107886003)(2616005)(38100700002)(26005)(4744005)(7416002)(2906002)(31696002)(86362001)(4326008)(8936002)(8676002)(6916009)(41300700001)(316002)(76116006)(66946007)(122000001)(478600001)(71200400001)(91956017)(6486002)(6506007)(53546011)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dk5xWXE5NHVabnh3SHFkelFRai95cU5WZzl2RHVGM0M0dUZkSTBYa2N2aUxO?=
 =?utf-8?B?MGtVaERuTnRsaVJrK0hDV1lNVWQzOEpETUhvOGRqNGduWHd1bFdDS1J6T0hs?=
 =?utf-8?B?b3ZzOWN4S3F3emVkUVc0Q1FuQlNOVWtCQjc4Q1ZNbXBGeFh2OEd1Y1dVK0No?=
 =?utf-8?B?SFpFRnkyNDd3UG9ZeFFTVnI3dXdKNXdFbWhjTGdQckZTSDNXUHRZdzNLbkQ5?=
 =?utf-8?B?Nkl1SkUzUlF0K0JieEY4Vy9ycWp4MTdXUWtuOUtiOTYzeDA0czRvVEdPQVo5?=
 =?utf-8?B?TWx4QXhOb1F5VVNTejkxb3FsWnZjeVdtTDNmemxhanNsbDlId2I2TFBFTlRL?=
 =?utf-8?B?eVN6RGpWYjRjUWlhMlE5L29hajN2NlBqYUxQUlpoMFR2ZGQ0NWo1SWZQcDdV?=
 =?utf-8?B?d0ZDMFl0b2NrV2ZMM2NTcFNMcm9UL2h2TWlWb2NlcFY1MUhRL0JLMGRyZTJz?=
 =?utf-8?B?SkNld3BNamI2NkxUazZNUTE4dkhtdHJ0MW11d3VpS2NjYlVZbWV1T2RTVGNH?=
 =?utf-8?B?R0g2QVVxM2pZZlh6Q1czd3dYUGlnZDExUG8wbTcyaXFaSHVzZUc5bWtNWGc5?=
 =?utf-8?B?QmpSdlIvc3lXVWtEVEVZcmo0MjlVNUNubmc4ZTd4MHUyWU5FVXI0a1NSU2VU?=
 =?utf-8?B?T0lieGd1S05iOENXSDNSOFlHMVR2QjUwYXJFaU1iQ2lIQ3RIaXNoRzdGTHBP?=
 =?utf-8?B?MFZSblRyMXVOdW9xWmR3NGs0WWREalRwUjk0Qm5nSXVtS3laTHd4Z1FEUXEr?=
 =?utf-8?B?YnlGZktGK0JhUm1NbFhRUXNpN3hubVlqTlNtVlRRTGZheUZ2S0dGTkh1Nmo0?=
 =?utf-8?B?dGFsZVc4cVdBM3VUWnhwVFp0SUVqMlZNT3liKzR0VEMvVzdlWDRRc25zSmxG?=
 =?utf-8?B?NXRia1BEUHQ1dUcwWEFqNkhqZnhmTGcwNmhJbGVxQzBQa0d0cHJXYW9CVllz?=
 =?utf-8?B?dG54ZDdPMlhEK0pPeDVsQWVFUjZUY2U4Q0YyTmJYQ2hnVy9VVW1mQWJYeG9Q?=
 =?utf-8?B?VTZFVmhSaHlFS1BHUk1RNUthd2dweFE3TjdjQ3VrVDJxVE1lY2dHUHRqQUhT?=
 =?utf-8?B?SFR2Zy9ub1lTTmpyWjYzbjg4a0dNTUVjWnI2VHB1T2VKZVRpZXc5QzJYaENV?=
 =?utf-8?B?Q2wyZkFFa0FYb3BDSWRRd3V3WGlTaElrd1N0aWdRaGxhMncvbTNmbnJ1SHY5?=
 =?utf-8?B?Rm1IRjhvM3o1OFNqSzdOa1lKTFFPeWZQTEQ0bzlhYk1Yc1d1THM1ZGdPeWc0?=
 =?utf-8?B?S21IbTJ1UGIyM3pPbEVrZXFIS0l3WW9lN1FqUThWSXFWL25iQVB5Yy85M2RJ?=
 =?utf-8?B?V3dsMzhyZ3k0SlFTc2xpZEVZaUo5TjdZbHhiVjNHYzVzVjVLTFJxUU1MRTZG?=
 =?utf-8?B?Zk5sNXl4YlZjVVpTOTVLSkFsa3lzaHNscS8xVlVQQXora2o4Q0VITFBlM2dY?=
 =?utf-8?B?TFZWUkRPeDlqMUJVMndDajRrWkw3V2tVMVczVnZSZlAvWWhDallUYStSTGtw?=
 =?utf-8?B?NytxNU5qQ1JjZXM5dHhSSkErU01XTTg5WlhOL3dnWTRjNTYySWRQY1J6VW1x?=
 =?utf-8?B?UEFVeFFmQmE3bXFVbTNxTFYwSkQ2ZFE5YVlWYlNJMlBJTW03am9YK3VKbzA1?=
 =?utf-8?B?bC92d01HRkx2SXo2Mm9lbEN0N3N3MDdSb3lHR0NpSXdQdTZ3Tm9TVnlLRkFv?=
 =?utf-8?B?aFE3T1FHRTRaS01UMFIvY1d6QlRmZys4a01DRmVVWHQ5R1p6TzZ3cFdQVktw?=
 =?utf-8?B?WUhtYVloaWN6VzBiZjN5RmdZRlVnZExsN3lSNjhBZ3VTdG1XbUtvaHFyT2NM?=
 =?utf-8?B?MkFNTXYrL2xPODAzRlRlRjNxZ2xmWndXOFJleXB5RWRoM2NCeFZ5YUxUbW9o?=
 =?utf-8?B?cElZTTZET01JQUtLa0hpdkM2MVUvOHNHcHVPaDkwTEptaGU0YzYydXA2SjF5?=
 =?utf-8?B?YU02VURPM0JsK2ZkMWhNL1JVaTNvaExrdUxubld2bklMald1TXZkOEZMcjhN?=
 =?utf-8?B?VEdHclZPS1Z3WjY3VzlkQ2xueWtaaUxXSUpxWHBlR2NDdG5udFIrZE5kZEh3?=
 =?utf-8?B?aVg0WmduVVVpZmZZRnEzd2sxNWJhVkx0emx6UjdRd1pabHNUTTY2bGtjV0V0?=
 =?utf-8?B?dDIwcHJHZmtaVitLQlVManBlRVloZUUveXNPb3U5SGlYOXRGakVJVlUyVi9F?=
 =?utf-8?B?dHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23C0A64E5DB0184AB375306CC4B9B280@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cadb96e-d706-4bd6-a860-08dbb839b6e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 11:23:42.3828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: htLmr7sw5L9K/rchL9oLi8TnDzFhbib+UgGctYTDvH1ZE7u+EXsrhyyzTu4lEIZqLYN7YX9gZtMMgQwqqeI3qG7E4tvrJSoykKvYGfV0PiSgnLindRJd83G7hyTRJ6hJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7026
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAxNC8wOS8yMyA3OjI1IGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gKyNkZWZpbmUgUkVHX1NU
RFJfUkVTRVQgICAgICAgICAgICAgICAweDAwMDAwMDAzDQo+IA0KPiBUaGlzIGFwcGVhcnMgdG8g
YmUgYSBzdGFuZGFyZCByZWdpc3Rlciwgc28geW91IHNob3VsZCBub3QgbmVlZCB0bw0KPiBkZWZp
bmUgaXQgaGVyZS4NCkFoIG9rLCB3aWxsIGRvIGl0Lg0KPiANCj4+ICsjZGVmaW5lIFJFR19NQUNf
QUREUl9CTyAgICAgICAgICAgICAgMHgwMDAxMDAyMg0KPj4gKyNkZWZpbmUgUkVHX01BQ19BRERS
X0wgICAgICAgICAgICAgICAweDAwMDEwMDI0DQo+PiArI2RlZmluZSBSRUdfTUFDX0FERFJfSCAg
ICAgICAgICAgICAgIDB4MDAwMTAwMjUNCj4+ICsjZGVmaW5lIFJFR19NQUNfTldfQ1RSTCAgICAg
ICAgIDB4MDAwMTAwMDANCj4+ICsjZGVmaW5lIFJFR19NQUNfTldfQ09ORklHICAgIDB4MDAwMTAw
MDENCj4+ICsjZGVmaW5lIFJFR19NQUNfSEFTSEwgICAgICAgICAgICAgICAgMHgwMDAxMDAyMA0K
Pj4gKyNkZWZpbmUgUkVHX01BQ19IQVNISCAgICAgICAgICAgICAgICAweDAwMDEwMDIxDQo+PiAr
I2RlZmluZSBSRUdfTUFDX0FERFJfQk8gICAgICAgICAgICAgIDB4MDAwMTAwMjINCj4+ICsjZGVm
aW5lIFJFR19NQUNfQUREUl9MICAgICAgICAgICAgICAgMHgwMDAxMDAyNA0KPj4gKyNkZWZpbmUg
UkVHX01BQ19BRERSX0ggICAgICAgICAgICAgICAweDAwMDEwMDI1DQo+PiArDQo+PiArI2RlZmlu
ZSBDQ1NfUTBfVFhfQ0ZHICAgICAgICAgICAgICAgIDB4MDAwQTAwODENCj4+ICsjZGVmaW5lIEND
U19RMF9SWF9DRkcgICAgICAgICAgICAgICAgMHgwMDBBMDA4Mg0KPiANCj4gVGhlc2UgYXJlIHBy
b3ByaWV0YXJ5IHZlbmRvciByZWdpc3RlcnMsIHNvIHBsZWFzZSBhZGQgYSBwcmVmaXggdG8gbWFr
ZQ0KPiB0aGlzIGNsZWFyLg0KU3VyZSwgd2lsbCBhZGQgaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4N
Cg0KQmVzdCBSZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+ICAgICAgIEFuZHJldw0KDQo=
