Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52A87A6177
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjISLjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjISLja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:39:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE193BA;
        Tue, 19 Sep 2023 04:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695123563; x=1726659563;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jcIhguXC9QJDIRJCai8+gzQ/4hLxSYSYrYK6S1II4is=;
  b=bIE/uaS+q0/ARRjYVA7BkrxUnsAkeLMi1hGldJiySLLZwUOg3s28sFdP
   Is9aZPrGYpc0b0pushKs1jgvIdZ2C5K3X52GT0L7haNaBw1ptqliDXnY1
   xh58wIIhBR+Dnn1sN2HbAEWuabyEcCJ1auJE5vJxsGbabqWDBGDT+yMcv
   AOecmKXej2E6txZVWjGcBm0qqGl08BL1d2wkFTbFRTOm0eLf4i/tdlFtM
   at8Pt5ixoD42jvXfzaPlkCvcMYrhmV4Al/rdfk33crdtUgjkLyHSu0dfp
   tqG+Bz28Cnhq/SF8Vg7b8hbfhQzegcIPJFTm9YTeiFlDaBUldNwisnC6a
   w==;
X-CSE-ConnectionGUID: 5nj8ahTzRBqwgR6koetL/g==
X-CSE-MsgGUID: UlfiPiplQf2otDNWEjfAIQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="172414911"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Sep 2023 04:39:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 19 Sep 2023 04:38:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 19 Sep 2023 04:38:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxoUwa3ym6nkgfUmM9o+kdCBEa/Vat/GJraN9doTYllIWgMy1MOGmOO7ohYdNpcmxXiK3RujgvvwwD6hFCCYsyIljd8FRpGYaOThYtRQKucu4xBtxMsc3oL8b08E5xaCt5UqaNR3Oz4gjInMljfOVHTp+N2tjYaCJFstpjcpHxnLWDPkLTkRhVkUpCyQ/egz88CkppNryWcvfg96eQCFVHWfxXTUjMLnZWlnn6lBfehQS37oiSvAVqysNA2KYo7oJh9IqNOac0nNVCt2R2NGrO2bDsKSKgrIyb68NzyXBSXseqIG2IRo1WpHBNSJJu0803WirU4+aDMdGx/idcJAJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcIhguXC9QJDIRJCai8+gzQ/4hLxSYSYrYK6S1II4is=;
 b=oWy4nyYGOE0tXSby11OTXKN+1NK35wvvZpyT9F7s2co+thTxUQJcXUmZIbLS/z8zu5KFBa0HRlHk9N1CtaecVyoNDZ6g/wBSkcAqfizM7Jq+PJQYjV/hFXhldBEotgLemeCygjGBKKL+b7h2DK9ujx7ZNRsmVcVyE1DLvNA4RbbnInKVF9UmetGojFUMDJ/mgGgnftMnAUNxxisknSkdsJ1PgDJpx9VmasxK6uXCyQBGWwoZGVGPdY83dDuKIaV4GD7MKMBrAN4wBzjKZgPB0f/Ns292xkvvMsyDiTsKjOmJkcAM2DP92lIvpATHM+Q2UXyXmb+ZRRW2Kj84tCFk2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcIhguXC9QJDIRJCai8+gzQ/4hLxSYSYrYK6S1II4is=;
 b=a1UjY4+D1xyARo0bK0oNg30yUWauAAcThmPHs6lGxWzqbnvuAdQHMEEZnxiZ+RHIDjysLioMb75dzKwTePwsJ+zFGWCu9k3uN39x+eApYOpWJtVx6YLYwqemnLMlbZmIiCpa8PqH3PAQnskSIfaly8mj6eYz2kmK+mhEqhB7TPs=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 SJ0PR11MB4991.namprd11.prod.outlook.com (2603:10b6:a03:2df::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.28; Tue, 19 Sep 2023 11:38:34 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 11:38:33 +0000
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
Subject: Re: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Thread-Topic: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Thread-Index: AQHZ4mEB+nwP90vbvEyYqcmk7ntkibAYCnuAgAoMZoA=
Date:   Tue, 19 Sep 2023 11:38:33 +0000
Message-ID: <14c089d7-4d34-9cd5-7f77-55c80815e003@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-2-Parthiban.Veerasooran@microchip.com>
 <f23997c1-7507-41c6-8bb3-47d6a353beb8@lunn.ch>
In-Reply-To: <f23997c1-7507-41c6-8bb3-47d6a353beb8@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|SJ0PR11MB4991:EE_
x-ms-office365-filtering-correlation-id: 26daed69-b4d3-4cfd-a5fa-08dbb904f484
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WSwWgzQi4lzpQQcSQBSecKxY//b9Ip6BcpJAC+8VPSBBCEvefEldJPM+bhBFvNIxOr+8bi7wjpLOd/++l15Y2aygH0NELE4Zf5jtyCnHnAYViySJYfwJboAeFTDygJ32HUnfHAdU5FkZ7vR7cUVhVk8z31/JzoXcTQ8iai0E9iQ96N6SdmWxYnKW5VnyHsHftWb/bZ6zCrQcFNbWhkX43e6gNlxJmC5GGnKEZC68ovcDbBSg1TyL+sz7MDZ2tN7qm6iX5vjFSeU3JICjzRGIYxe0JPXZ65/Y85Nh739GYxLjTWDVw+4DMZQikl6Muuf6/iw6gSHV9ZylULt7b+RbsGYaLMgwTgs7IExKh5W3l0tIYtLJz8ztDTNuzOfbc3aXapGZu4cuqQxTprvFRqmxdX6ENO969K1306P8uMay+EdFAqMxL6c5Lt0NZoSm4RoKdCbxhf/T7dqKkwd1lBUKGS4VeUYAUjYDq4Hrd68a1K1QmqfLshn4Hu5n9d21Q2Z4gLg3LiQ/d7KYsCpj9OuvtIBdR3vbTzKyIyjp4wOUWXKFNiriG0nyFRAl39J85jH0Ogwp48EjNNj1bV9GjXk5aD17dLkU9Xt4hEIA2nR8sqf6B4TQPMOxE/QBylb4Aq1LJ4iHh3QHtGun+BnOIWHjujWdljzYJWBUBx8Vg4wBNs8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199024)(186009)(1800799009)(31686004)(5660300002)(4326008)(6916009)(41300700001)(6486002)(6506007)(6512007)(53546011)(316002)(2906002)(8676002)(8936002)(64756008)(66446008)(54906003)(66556008)(66476007)(66946007)(76116006)(91956017)(7416002)(478600001)(966005)(86362001)(31696002)(122000001)(71200400001)(83380400001)(26005)(36756003)(107886003)(2616005)(38070700005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnlFMDV4Q3EvdGxUcnFkVzBINndGb0hFbEYzL3pjdnJYTm9uRGRkaG9hRWtN?=
 =?utf-8?B?ajlEc1J1cmh5clV6YjdmeFFMeVUxbnp0VnpXamp0bkJvUXpkVGQ2Z2l4b1ZH?=
 =?utf-8?B?TDg2dDVZdFdJWG1vcm9rYW1zQkhsUCtHRHFwNUF6bjBCYUlTUDYyeDJOdGxT?=
 =?utf-8?B?VWw5clc3eXBURjBSdEZYU2cvZzVkaWRWY2pnRjgxbi8rUC94RGFtMmU0QjVF?=
 =?utf-8?B?UUQ4R0VUWUhGbGVwanFhbUtuWW9ZQklSVUIxZE03WGxGNWxLZ0tBTGNYTWFz?=
 =?utf-8?B?NmRucWVZT3NtTmlOWkF1U3JoaXVYVis3b3pIemlQL1R4Y08xWHBDVEZXUThW?=
 =?utf-8?B?NDdYeFM4TjlxYjlEazZub2hXd2QvNWs4ZnEzamUzYjUxWGNYaE9NQmZ1bjAr?=
 =?utf-8?B?aE03d1VXQUpQQnd5VFIybzV3WHFjNEFWbEg4RVk3VmlYd04rbkNmYlB3SE9E?=
 =?utf-8?B?WWFJM0NPOGZuQnBUNTMxbzF2eDY3T0c5VFp0dmlWVTJFZFpjcHgvNllmeUtM?=
 =?utf-8?B?OEtHazNDS2tvRjdPcVJPcGg3bUVmTHJsaGJyNHJmb3gySXczUFZ3NWpDTU93?=
 =?utf-8?B?WnRKQWxYUTk0VFpnNUdQaVZQK1RxWWlMTmJXQVhZVHJDcWRZNVlzeE1CR0tw?=
 =?utf-8?B?RXRuL2NCbG5SUWNqRUZsZ01Tc20zQktWTGVQeE1SclZ0OHZJWW11VTg4YUpj?=
 =?utf-8?B?dGl1cTFVQnl1bkgrWjBUdTBxNTVNdW4yTWltYTRWNzJvU2lHb1h5Y0xjeFp3?=
 =?utf-8?B?NnlONXNoN2lsQWlLNmxQdE02eUJpV1hvYUlnZ3gzRGZiaUc5RTlwVksyTGpr?=
 =?utf-8?B?a3VJMm1zRVRDVHBRZlczNG1pTkdFeDFXYUJCKzJva2o2VGJvYi9ubjdQQnYr?=
 =?utf-8?B?VGI1QmhHTXRnTG5pRmF0RmlqSWZXV1B6WDdJckZDekVIazNBTzVVL1c4cWdo?=
 =?utf-8?B?ckxPckdha2dLbGlYallaVDV4R2VIZUZXc3hIaWx3dmpwVFNNTVZMMGxibE9u?=
 =?utf-8?B?QTkzakl4dDRXRmE4dWhHbktBWEp5ZGxjR3dTVTZLbzJJSEkwcmJ1MGlVRlhS?=
 =?utf-8?B?ZE9RWXlkTUVLQ1o1ZUZwTVl5N000MEl4L3VIOHF2d1RnWThJTkZ4OW5vMDBi?=
 =?utf-8?B?dzYza2YvQ1BEMnQ0RGVWV0dEL3p6Mlo2VDlKQ0ZuMVQ2YU91NEZyZjFPM2pN?=
 =?utf-8?B?OSs2L1Bab04vWHpGWEpwTERPSmVUMDRmelgzY0t2RlhBMGxlUE9ubWNIcFp1?=
 =?utf-8?B?ODNWS0FvR2VVdFZaWVFqeTd3VnVOM3kzVEpYY1ZyZHF5MFg3b29xRnJUUnA5?=
 =?utf-8?B?N0VQZFNGOHZiQU8vUXUvZkF6TFV2M1A3S2VjZEhkV0xDa1ltN0xFSWVQd0lP?=
 =?utf-8?B?SldjbVBGcG0zaU55SnVuR0R0ekpocjhJeDBJdUxlTVdHK1hkeWhBbzdlL1Ra?=
 =?utf-8?B?THZYYk15VHZpQkt1bDdaSWgyeTBITTFwRURnWDBZc3hsU1J3Vy84V056UVFG?=
 =?utf-8?B?Mk84ODZpR3daZTFuK3p5MjBuNjFGRW8vbFFNb1JjVk91d3cwRUpmQ2l6L3NR?=
 =?utf-8?B?QzFmOTVValN1a08wTmZZand6a1NLcElIZlVxOTZDRXRLaEhSV1BQNTArZmJx?=
 =?utf-8?B?anREaklCSzdWdlVRdzc0K1dLRVhmRVQzTDRXdmJieTUzRzdzcitXaFRlMXpF?=
 =?utf-8?B?eURJNmFJOG1PQUgweUpJc0JHUEowYzM4bmJSUk5XTkViblRGZlF4ZHhZd085?=
 =?utf-8?B?dVg2eGxVSVpuVC9TUUNmTGxwbzkvaUZDWjVTSnFsMjVwRGRiWEpuNWczMkMz?=
 =?utf-8?B?WWdGQWxkT3JoL244amMyNzdpSm56TWJlR0tnQWZwRmRzOVVRUXZCdUNETHpn?=
 =?utf-8?B?d3B0dzAvOWZxb1JmMTdQUnlOTS9qa0gxTUpYTEZVOFVHSitvd3pzSW9MR2p1?=
 =?utf-8?B?MXppMzBvK25EVnVaMkhCU1BqYTBjalhPMHp4cXlOaHF1TWNJZGwycEpBdlpR?=
 =?utf-8?B?cFBxclhFV0Z2ZGJaQS9BTGdsWHUwYnR4VStmWTJsTjBQVExUYUg0eE1mS2ZO?=
 =?utf-8?B?QldRdC9KWHl0bjNLelcrMjBXREtVSW5FWVJ2QncxMldkRCtEV0JWSmVUWTY1?=
 =?utf-8?B?Z3FSazg4UVlwOE9nTVJKb0g3RVFpb0Q2ODVjRitNUWk1cVNHdnp5dXZsUUU2?=
 =?utf-8?Q?uafWbeYUrEiFtUAAt2GHRAM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F61F7C64B765964391BE3687AAB6354A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26daed69-b4d3-4cfd-a5fa-08dbb904f484
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 11:38:33.5900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DUbEnR/nC46tTk3cLbM/qboaGUx7rcZBxvJdvDJ/L4JFccfa4b18sd+XhaezhZ4N4Oyh5R/x2tSjAQEnQIKIoKuMx22/kSJvk5pn39g/GICS7eAEKXBkOFoV2kLFLd+4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4991
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAxMy8wOS8yMyA3OjQxIGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gK3N0YXRpYyBib29sIG9h
X3RjNl9nZXRfcGFyaXR5KHUzMiBwKQ0KPj4gK3sNCj4+ICsgICAgIGJvb2wgcGFyaXR5ID0gdHJ1
ZTsNCj4+ICsNCj4+ICsgICAgIC8qIFRoaXMgZnVuY3Rpb24gcmV0dXJucyBhbiBvZGQgcGFyaXR5
IGJpdCAqLw0KPj4gKyAgICAgd2hpbGUgKHApIHsNCj4+ICsgICAgICAgICAgICAgcGFyaXR5ID0g
IXBhcml0eTsNCj4+ICsgICAgICAgICAgICAgcCA9IHAgJiAocCAtIDEpOw0KPj4gKyAgICAgfQ0K
Pj4gKyAgICAgcmV0dXJuIHBhcml0eTsNCj4gDQo+IFBsZWFzZSB0YWtlIGEgbG9vayBhcm91bmQg
YW5kIHNlZSBpZiB5b3UgY2FuIGZpbmQgYW5vdGhlcg0KPiBpbXBsZW1lbnRhdGlvbiBpbiB0aGUg
a2VybmVsIHdoaWNoIGNhbiBiZSB1c2VkLiBJZiBub3QsIHlvdSBjb3VsZCBjb3B5L3Bhc3RlOg0K
PiANCj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3NvdXJjZS9saWIv
YmNoLmMjTDM0OA0KPiANCj4gd2hpY2ggaXMgcHJvYmFibHkgbW9yZSBlZmZpY2llbnQuDQpTdXJl
LCB3aWxsIGNoZWNrIG91dCBpdC4NCj4gDQo+PiArc3RhdGljIHZvaWQgb2FfdGM2X3ByZXBhcmVf
Y3RybF9idWYoc3RydWN0IG9hX3RjNiAqdGM2LCB1MzIgYWRkciwgdTMyIHZhbFtdLA0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHU4IGxlbiwgYm9vbCB3bnIsIHU4ICpidWYs
IGJvb2wgY3RybF9wcm90KQ0KPj4gK3sNCj4+ICsgICAgIHUzMiBoZHI7DQo+PiArDQo+PiArICAg
ICAvKiBQcmVwYXJlIHRoZSBjb250cm9sIGhlYWRlciB3aXRoIHRoZSByZXF1aXJlZCBkZXRhaWxz
ICovDQo+PiArICAgICBoZHIgPSBGSUVMRF9QUkVQKENUUkxfSERSX0ROQywgMCkgfA0KPj4gKyAg
ICAgICAgICAgRklFTERfUFJFUChDVFJMX0hEUl9XTlIsIHducikgfA0KPj4gKyAgICAgICAgICAg
RklFTERfUFJFUChDVFJMX0hEUl9BSUQsIDApIHwNCj4+ICsgICAgICAgICAgIEZJRUxEX1BSRVAo
Q1RSTF9IRFJfTU1TLCBhZGRyID4+IDE2KSB8DQo+PiArICAgICAgICAgICBGSUVMRF9QUkVQKENU
UkxfSERSX0FERFIsIGFkZHIpIHwNCj4+ICsgICAgICAgICAgIEZJRUxEX1BSRVAoQ1RSTF9IRFJf
TEVOLCBsZW4gLSAxKTsNCj4+ICsgICAgIGhkciB8PSBGSUVMRF9QUkVQKENUUkxfSERSX1AsIG9h
X3RjNl9nZXRfcGFyaXR5KGhkcikpOw0KPj4gKyAgICAgKih1MzIgKilidWYgPSBjcHVfdG9fYmUz
MihoZHIpOw0KPj4gKw0KPj4gKyAgICAgaWYgKHducikgew0KPiANCj4gV2hhdCBkb2VzIHduciBt
ZWFuPyBNYXliZSBnaXZlIGl0IGEgbW9yZSBtZWFuaW5nZnVsIG5hbWUsIHVubGVzcyBpdCBpcw0K
PiBhY3R1YWxseSBzb21ldGhpbmcgaW4gdGhlIHN0YW5kYXJkLiBLZXJuZWxkb2Mgd291bGQgYWxz
byBoZWxwLg0KQWgsIGl0IGlzICJ3cml0ZSBub3QgcmVhZCIuIFNoYWxsIEkgbmFtZSBpdCBhcyAi
d3JpdGVfbm90X3JlYWQiID8NCj4gDQo+PiArc3RhdGljIGludCBvYV90YzZfY2hlY2tfY29udHJv
bChzdHJ1Y3Qgb2FfdGM2ICp0YzYsIHU4ICpwdHgsIHU4ICpwcngsIHU4IGxlbiwNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgd25yLCBib29sIGN0cmxfcHJvdCkNCj4+ICt7
DQo+PiArICAgICAvKiAxc3QgNCBieXRlcyBvZiByeCBjaHVuayBkYXRhIGNhbiBiZSBkaXNjYXJk
ZWQgKi8NCj4+ICsgICAgIHUzMiByeF9oZHIgPSAqKHUzMiAqKSZwcnhbVEM2X0hEUl9TSVpFXTsN
Cj4+ICsgICAgIHUzMiB0eF9oZHIgPSAqKHUzMiAqKXB0eDsNCj4+ICsgICAgIHUzMiByeF9kYXRh
X2NvbXBsZW1lbnQ7DQo+PiArICAgICB1MzIgdHhfZGF0YTsNCj4+ICsgICAgIHUzMiByeF9kYXRh
Ow0KPj4gKyAgICAgdTE2IHBvczE7DQo+PiArICAgICB1MTYgcG9zMjsNCj4+ICsNCj4+ICsgICAg
IC8qIElmIHR4IGhkciBhbmQgZWNob2VkIGhkciBhcmUgbm90IGVxdWFsIHRoZW4gdGhlcmUgbWln
aHQgYmUgYW4gaXNzdWUNCj4+ICsgICAgICAqIHdpdGggdGhlIGNvbm5lY3Rpb24gYmV0d2VlbiBT
UEkgaG9zdCBhbmQgTUFDLVBIWS4gSGVyZSB0aGlzIGNhc2UgaXMNCj4+ICsgICAgICAqIGNvbnNp
ZGVyZWQgYXMgTUFDLVBIWSBpcyBub3QgY29ubmVjdGVkLg0KPiANCj4gSSBjb3VsZCB1bmRlcnN0
YW5kIEVOT0RFViBvbiB0aGUgZmlyc3QgdHJhbnNhY3Rpb24gZHVyaW5nIHByb2JlLiBCdXQNCj4g
YWZ0ZXIgdGhhdCAtRUlPIHNlZW1zIG1vcmUgYXBwcm9wcmlhdGUuIEkndmUgYWxzbyBzZWVuIFVT
QiB1c2UgLUVQUk9UTw0KPiB0byBpbmRpY2F0ZSBhIHByb3RvY29sIGVycm9yLCB3aGljaCBhIGNv
cnJ1cHQgbWVzc2FnZSB3b3VsZCBiZS4NCkFoIG9rLCB0aGVuIGluIHRoaXMgY2FzZSBJIHdpbGwg
Y29uc2lkZXIgLUVJTy4NCj4gDQo+PiAraW50IG9hX3RjNl9wZXJmb3JtX2N0cmwoc3RydWN0IG9h
X3RjNiAqdGM2LCB1MzIgYWRkciwgdTMyIHZhbFtdLCB1OCBsZW4sDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgYm9vbCB3bnIsIGJvb2wgY3RybF9wcm90KQ0KPj4gK3sNCj4+ICsgICAgIHU4ICp0
eF9idWY7DQo+PiArICAgICB1OCAqcnhfYnVmOw0KPj4gKyAgICAgdTE2IHNpemU7DQo+PiArICAg
ICB1MTYgcG9zOw0KPj4gKyAgICAgaW50IHJldDsNCj4+ICsNCj4+ICsgICAgIGlmIChjdHJsX3By
b3QpDQo+PiArICAgICAgICAgICAgIHNpemUgPSAoVEM2X0hEUl9TSVpFICogMikgKyAobGVuICog
KFRDNl9IRFJfU0laRSAqIDIpKTsNCj4+ICsgICAgIGVsc2UNCj4+ICsgICAgICAgICAgICAgc2l6
ZSA9IChUQzZfSERSX1NJWkUgKiAyKSArIChsZW4gKiBUQzZfSERSX1NJWkUpOw0KPiANCj4gRG8g
eW91IGhhdmUgYW4gaWRlYSBob3cgYmlnIHRoZSBiaWdnZXN0IGNvbnRyb2wgbWVzc2FnZSBpcz8g
UmF0aGVyDQo+IHRoYW4gYWxsb2NhdGUgdGhlc2UgYnVmZmVycyBmb3IgZXZlcnkgdHJhbnNhY3Rp
b24sIG1heWJlIGFsbG9jYXRlDQo+IG1heGltdW0gc2l6ZSBidWZmZXJzIG9uZSBhdCBzdGFydHVw
IGFuZCBrZWVwIHRoZW0gaW4gdGM2PyBUaGF0IHdpbGwNCj4gcmVkdWNlIG92ZXJoZWFkIGFuZCBz
aW1wbGlmeSB0aGUgY29kZS4NCk9rLCBhcyBwZXIgT0Egc3BlYywgdXAgdG8gMTI4IGNvbnNlY3V0
aXZlIHJlZ2lzdGVycyByZWFkIG9yIHdyaXRlIGNhbiBiZSANCnBvc3NpYmxlLiBTbyB0aGUgbWF4
aW11bSBwb3NzaWJsZSBzaXplIHdvdWxkIGJlIDEwMzIuIEFzIHlvdSBzdWdnZXN0ZWQgDQp3aWxs
IGFsbG9jYXRlIHRoaXMgc2l6ZSBvZiBtZW1vcnkgaW4gdGhlIHN0YXJ0dXAuDQo+IA0KPj4gK3N0
cnVjdCBvYV90YzYgKm9hX3RjNl9pbml0KHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+PiArew0K
Pj4gKyAgICAgc3RydWN0IG9hX3RjNiAqdGM2Ow0KPj4gKw0KPj4gKyAgICAgaWYgKCFzcGkpDQo+
PiArICAgICAgICAgICAgIHJldHVybiBOVUxMOw0KPiANCj4gVGhpcyBpcyBkZWZlbnNpdmUgcHJv
Z3JhbW1pbmcgd2hpY2ggaXMgZ2VuZXJhbGx5IG5vdCBsaWtlZC4gWW91IGNhbm5vdA0KPiBkbyBh
bnl0aGluZyB3aXRob3V0IGFuIFNQSSBkZXZpY2UsIHNvIGp1c3QgYXNzdW1lIGl0IGlzIHBhc3Nl
ZCwgYW5kIGlmDQo+IG5vdCwgbGV0IGlzIGV4cGxvZGUgbGF0ZXIgYW5kIHRoZSBkcml2ZXIgd3Jp
dGUgd2lsbCBxdWlja2x5IGZpeCB0aGVyZQ0KPiBicm9rZW4gY29kZS4NCkFoIHllcywgd2lsbCBy
ZW1vdmUgdGhpcyBjaGVjay4NCj4gDQo+PiArDQo+PiArICAgICB0YzYgPSBremFsbG9jKHNpemVv
ZigqdGM2KSwgR0ZQX0tFUk5FTCk7DQo+PiArICAgICBpZiAoIXRjNikNCj4+ICsgICAgICAgICAg
ICAgcmV0dXJuIE5VTEw7DQo+PiArDQo+PiArICAgICB0YzYtPnNwaSA9IHNwaTsNCj4+ICsNCj4+
ICsgICAgIHJldHVybiB0YzY7DQo+PiArfQ0KPj4gK0VYUE9SVF9TWU1CT0xfR1BMKG9hX3RjNl9p
bml0KTsNCj4+ICsNCj4+ICt2b2lkIG9hX3RjNl9kZWluaXQoc3RydWN0IG9hX3RjNiAqdGM2KQ0K
Pj4gK3sNCj4+ICsgICAgIGtmcmVlKHRjNik7DQo+PiArfQ0KPj4gK0VYUE9SVF9TWU1CT0xfR1BM
KG9hX3RjNl9kZWluaXQpOw0KPiANCj4gTWF5YmUgY29uc2lkZXIgYSBkZXZtXyBBUEkgdG8gbWFr
ZSB0aGUgTUFDIGRyaXZlciBzaW1wbGVyLg0KU29ycnkgSSBkb24ndCBnZXQgeW91ciBwb2ludC4g
Q291bGQgeW91IHBsZWFzZSBleHBsYWluIGJpdCBtb3JlPw0KDQpCZXN0IFJlZ2FyZHMsDQpQYXJ0
aGliYW4gVg0KDQo+IA0KPiAgICAgICAgQW5kcmV3DQo+IA0KDQo=
