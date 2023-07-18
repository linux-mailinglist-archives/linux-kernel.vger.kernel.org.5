Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2F17577DC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjGRJZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjGRJZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:25:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA11EE0;
        Tue, 18 Jul 2023 02:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689672302; x=1721208302;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uTcLrlXBarOiNfQ8H1aEAInVFYjQhmlebQyj5oU5HSE=;
  b=DkzTJZ4kGZTBiWKObmKXzEMo37lqNv9Rafc3G8N7O3z6LsbIMo7o935z
   8RhooXma9RKNlhUFHOft14wAnHAgQok0KPJJDRZad39vmdidc/PH2x7Fr
   6531m+/+MCWRDJfzFFIBqVoOpv6YZX5eBqaBcVjI/SkJIGFZp8BFOlW5x
   UBM8kQ2nAuCDHecc/Xk8dnbB6mWe2K1C4veJOG7StBI9MQSb04dg30bKU
   eVRP472SaZY9crUjilQsNaLjKprf7QUPRMVuNhLPBQrLpCIhGIzR0DrSk
   ivab8+p+JXa0fWJDs3SMbyykvF0nxjWBEFxf0ZLmgq0PrTwuiJ40ThwVp
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="220898105"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jul 2023 02:25:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 18 Jul 2023 02:25:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 18 Jul 2023 02:25:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enlkFK+By03b1BzVxl/yJgIlYpODBHRtOa42nz3aE1c/aw4s7hTG9lmV8TS+scmTx0T7inP0ljSZAATlf5ia/zRffgSS368hEQ2gYc/7JgkbRyFqthOXEMhgU/lPgWkgL9ztKERFyEQO81f/nTMRyUMeNJ8/9wKLrAghufQPvBZNvHg4X8Lth6krTDXCPBmSh14PY0M3B6fv0IuuSz8/oPHPOS/rrD69CdD7bMC1s7FQm8rNGSV7W2tz47AhLlKA8Mxx7lp9zXvtAXOAkpVb4AB/XqogQFQ03UyYaaKpapzFQKQofw/xtut8vCNQyIytilfETqUCy/gsIJfErPdWpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTcLrlXBarOiNfQ8H1aEAInVFYjQhmlebQyj5oU5HSE=;
 b=bbCXnzmMeVtWAuuWMX7hwA7szf+fDsLrn99JPZPhzO2076qL0uLHYKZ1F8cRm9iUBv/TZPry8jWYwnPOuTNd+PLjGybYXyt1qLQ3jYL9zkfyufY1P7noEM/1m+yyfY6Bcbpec4TYKgLPm+6KZa/1aM9P4wWzsqK3vSVcrpkXcj3p2YSfMyK+bHsp8/uhtGwXkxpPj/XZ5dmkJ7EJTSzfelR5VXFh86BXCu9RDuiS9BMLq+HHj0t/oliFzpnj5FVHyzQBKWSRI5F/3BQNjpwH0BYWVl0tAV3HdGC7CBMlBYd3FsG6Sldf8F5GKYeh2sauxt1N3Hsi22LhrWr0I8ilUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTcLrlXBarOiNfQ8H1aEAInVFYjQhmlebQyj5oU5HSE=;
 b=h5uBWIQ0iz4QQKnkrEVvp7yH8hygy6VDSKWqF9mEMpYJcXIeP9xFFmpxhZV2JySL9yPOzgCnL/LHoJoLb443fDDklgVVcPdEBfTA3hj/dRz6MqHAAYgDFF6bTTLA/XWDgWd7IbSLjaitqO7OezlAjECc/JLwOI+E2woFUKdGHGo=
Received: from IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14)
 by PH8PR11MB6780.namprd11.prod.outlook.com (2603:10b6:510:1cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 09:24:59 +0000
Received: from IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::6ca0:521:dd8e:b296]) by IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::6ca0:521:dd8e:b296%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 09:24:58 +0000
From:   <Marius.Cristea@microchip.com>
To:     <conor@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <lars@metafoo.de>, <linux-kernel@vger.kernel.org>,
        <jic23@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Thread-Topic: [PATCH v2 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Thread-Index: AQHZtmQN1fNQSJrvVUecFTBMTPHvkK+6oUqAgASlXYA=
Date:   Tue, 18 Jul 2023 09:24:58 +0000
Message-ID: <0cd0a08c38bd261664b6a0dafe85c32bdc68249a.camel@microchip.com>
References: <20230714150051.637952-1-marius.cristea@microchip.com>
         <20230714150051.637952-2-marius.cristea@microchip.com>
         <20230715-violate-suburb-ba9ae0a46674@spud>
In-Reply-To: <20230715-violate-suburb-ba9ae0a46674@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6395:EE_|PH8PR11MB6780:EE_
x-ms-office365-filtering-correlation-id: ba6a1d47-3178-42b4-6aec-08db8770dada
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IrktaVNCkhK9HyOnr+c8GF7QJM0MS8Uqq/j4Ol2VpAJcPJAaey77dpexeA9zk9YzRonjkrCyJFrP+hw4/f//etmiv5C5Y0+X4de8uhNMJZVZNx+fvYEwRRtKsR/wNAEjflWMoHbkH6Rpzy6BSgWFULvqWfEd3ezRZA0ay6alXm6ImOmY13Oy0Owhrd6UQDNn13tidHlJmCC692E126QnP/1l7GdcDfcnNShN4IETgiRsruow0b5tRVKuINPfCQF/QQ98Mqaa6yr/JjNOJ1mnasPEvaQQ/lh4HYBjJ6UGlaUC0IrceJUZWeOwFgohIdxt91Wt/5yEFdr0TvbCJ43f+TxyBJLZ96YiR/2T98mzznWuWUovQYpf25dByiuSGgpq9iJmrrC7wsgjKWiSx0zmzXy3BNTgHCYBtrMx6f8BvKGcVSkUPMbVFnmhb9KiUw9QNnfeFEOcURgcHRuQBxoRX4zrHBkZ1oYfTdDRMduTricFqiL/809JKzj9bGKscgcAg3Gy4SLZHb/yBvDIXRHcv5fx2qKqa5bN/7e2QuFS7zQDidevWJeKJdcd5Urf9A+toUwNJLnhg46VQp6BOrM4osEwXJNmfbrC2qABpCAKvMw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6395.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199021)(86362001)(2906002)(36756003)(38070700005)(6512007)(966005)(2616005)(186003)(83380400001)(26005)(6506007)(38100700002)(6486002)(54906003)(122000001)(71200400001)(66446008)(316002)(64756008)(5660300002)(6916009)(76116006)(478600001)(66556008)(66476007)(66946007)(91956017)(4326008)(41300700001)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3pkenZzQXJnTnpCVnY5WjJMbmlaWVJ4Nm0xNWFxaHBaQ2t5bzFwdVhMYnFl?=
 =?utf-8?B?bUY0QVJnc2FIOEhoUlBCQ2ZvWFM0dmRaVkZndjBETVAvMkw5OEl6TUVrMG1R?=
 =?utf-8?B?WFdKNTM1MXMxeDE4eGRmNzRSc3QzbGpiOUZ1OHpTYTFwU2JUREZMTGpRdTQy?=
 =?utf-8?B?bnRwdkZJM3dNUDJ0WS9UVFp0N2h4M3dhVS9rUFNHOWdaSy9VMmJJL2Y3RUlF?=
 =?utf-8?B?Q3dtM1AraVNHT25qUTY3THRjMHZ6WERhQWlnUGdFb2RLbm1kcUZDV3NibTQ0?=
 =?utf-8?B?eEFidVIzNUg2dUdMK0Q1YTNNLytqZmtMUTJoOVp3aDRCazIydmlidnliZ0lB?=
 =?utf-8?B?M0kxa0V2WVlVRndmMzAvT2p5Mmc4TFQvaUxjZjIxUGNYN1V2LzNFVWM4enJv?=
 =?utf-8?B?ZkxOZ3JhTG9pM0k1M1NPRkI2T2htWXp0SndZazNDUHU5VW1NelFRLzUxSEJT?=
 =?utf-8?B?Y3JQaU5lRU83UmxJaXlUMTZqZW1nRTlyYTM3UW1aME1vTjRrVm1ISXBvaDB4?=
 =?utf-8?B?dDFMd0hocnFtWGNqblI5WTVEMXBxL2UzZ0ZqZ29DOFVsZGVpQjVPc2J6RG5h?=
 =?utf-8?B?dHZ6aEM2aHZoYUhIZ0l3VW8zTTcvWXdYN1VNRzRQbjlWZWpYYkxCbFFNVkJR?=
 =?utf-8?B?dk1Yekw2c1hGUVpNbFNva3JIdE5qT28rTFU2b3RuWHNjMm13RERGY0tLS0Fk?=
 =?utf-8?B?Wk16RmZvQWpLZnFjcEFvU2VsaU5zWHp6UWJBNUNybmN2SUF1amFJNmFWQVhJ?=
 =?utf-8?B?bGtpZHF6UyszL0JIT2ZnT2R4U081RTVldDVzWXdpRHhxVExuTnZBSVljK05q?=
 =?utf-8?B?S25mL2UxeWpzK0hTSElTNlAvZ09jSURybjY5d2xuVmFmZlJyVXVvMWU2Q2VU?=
 =?utf-8?B?L3RpZGkxNkF0cFF3SlFyYWtmd1JuNitqQkNJbVhZUGNJcHNmaXZhRHNzYjdk?=
 =?utf-8?B?QVREdWRTTHcya0tTQUtBTlgrT2QrRnZrbXREcmVPMGJWZWUxWjFwUVdTYll0?=
 =?utf-8?B?L2FTNUZQS2ZqRko4cGdpTmJEbmsvUU9Gdzg0ZlZ6RGE3QU9mNlRCUU1uWFlS?=
 =?utf-8?B?N0srWkNVVytkN0s2ZWR4bEdHQ21IN3hzZkZuS0U2eTRDMGVLT0JtbWE3dy9a?=
 =?utf-8?B?cHh5bnNiTGpBNmwwZW52bW5DUHkxT1RJazcwVkptNWZyL1ZrdUtYNFV4UTdU?=
 =?utf-8?B?TDhUdjZOdDBLM05OVVdlY2NkTDlLYW1XWWQzTXVma2RXR1lEdGp1TktsMUh6?=
 =?utf-8?B?ODdvQW5EcDhrZWJrbWloUGJNNW9wK1AxT1Z3eitiRFNoRU9kTnRaalV3Lzlm?=
 =?utf-8?B?aC9ETVNIVXdVZXdtcUw2TXNYVWg4cDZYU3FBQnZRWExHczJiN2R3dzN3YnpB?=
 =?utf-8?B?YThnbEhnRk9VZkJyQ1lZL1BqUE4yeitKNnFCZ2s2cTd3cWdaYzdXSUJLMExL?=
 =?utf-8?B?ZVJHRmdxNUVHOEFRNXpObC9Pd2ZWQXRoSVZZcFd6anpUYXZjQSt3UVZ6cm85?=
 =?utf-8?B?WmFyKzRiYmhSL1RlQlVKTVpHcmxsYTlMeGh4QnZqY2QyV015UmtTUWNLSllB?=
 =?utf-8?B?ZmRjbEl5Skwxdm1PQldoRXlJWEp0RVFLa0FydjlVUGs1MEZQejJwYUJ2enBh?=
 =?utf-8?B?S2FVY2xSNDZMV1BidDdMVmVSRS95U3h4Y3d6RFVhdHdpeVd6SFRFSEFSckoy?=
 =?utf-8?B?L3YraG42OWxUTjYwenpJNGRDRitha2FyTC9WYWtwSndWQkhUMGRyZ0UycTUw?=
 =?utf-8?B?eEJrY1pXQ0ZiK3lkUCtWbWxtOVlFRXc3dWxsNjRUbE5tWDZaYTZ2SkRXWHNy?=
 =?utf-8?B?THdMSnd6cFo3L2ZQaVBFS2NFbDlKSGxBUWZWa21TVDdCZEFWeGlyQzV2UXdO?=
 =?utf-8?B?MG5XS1FxdUliRXU4Q21PNVVMU1RCQlc4QzkyRVNDUlNDb1A5cityTlBPa1lZ?=
 =?utf-8?B?UzVGdUNTeTFOK1h6VlFVV3pWay8zY3l5YnFTMnZTV1diUHZSc0RCY2lueEp0?=
 =?utf-8?B?YkpCZ0tzSkIxYkYxVzVzd0FLakUray85YmVOSVNzTG5Wd25YUjE2U1NXTXll?=
 =?utf-8?B?VWVMV0llRWpoWEcxRVN4YnU0V0QvSlNwZ0NhQnJLNjB1UzdTeWdvODBkUEhj?=
 =?utf-8?B?VngxNjRtWmVqcnN5bWtlbnM3VS9UNTNwTExaWGpPY2JzeGtzd210VVNuTGRU?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C1C945F9673014594D1F57345B393E2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6395.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6a1d47-3178-42b4-6aec-08db8770dada
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 09:24:58.0832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LW151JA0mXzuJDLjKjDS1rE90h+lo7hX5iPRtlwPHA8dn1+nz+dNHOGqK0p5ddv3vonV5xoxWVg8qXnnpREVNbcl4kyMJvgAFPlWThUxuwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6780
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IENvbm9yLA0KDQoNCk9uIFNhdCwgMjAyMy0wNy0xNSBhdCAxMToyOCArMDEwMCwgQ29ub3Ig
RG9vbGV5IHdyb3RlOg0KPiBIZXksDQo+IA0KPiBPbiBGcmksIEp1bCAxNCwgMjAyMyBhdCAwNjow
MDo1MFBNICswMzAwLA0KPiBtYXJpdXMuY3Jpc3RlYUBtaWNyb2NoaXAuY29twqB3cm90ZToNCj4g
PiBGcm9tOiBNYXJpdXMgQ3Jpc3RlYSA8bWFyaXVzLmNyaXN0ZWFAbWljcm9jaGlwLmNvbT4NCj4g
PiANCj4gPiBUaGlzIGlzIHRoZSBkZXZpY2UgdHJlZSBzY2hlbWEgZm9yIGlpbyBkcml2ZXIgZm9y
DQo+ID4gTWljcm9jaGlwIGZhbWlseSBvZiAxNTMuNiBrc3BzLCBMb3ctTm9pc2UgMTYvMjQtQml0
DQo+ID4gRGVsdGEtU2lnbWEgQURDcyB3aXRoIGFuIFNQSSBpbnRlcmZhY2UgKE1pY3JvY2hpcCdz
DQo+ID4gTUNQMzQ2MSwgTUNQMzQ2MiwgTUNQMzQ2NCwgTUNQMzQ2MVIsIE1DUDM0NjJSLA0KPiA+
IE1DUDM0NjRSLCBNQ1AzNTYxLCBNQ1AzNTYyLCBNQ1AzNTY0LCBNQ1AzNTYxUiwNCj4gPiBNQ1Az
NTYyUiBhbmQgTUNQMzU2NFIgYW5hbG9nIHRvIGRpZ2l0YWwgY29udmVydGVycykuDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogTWFyaXVzIENyaXN0ZWEgPG1hcml1cy5jcmlzdGVhQG1pY3JvY2hp
cC5jb20+DQo+IA0KPiBUaGlzIGxvb2tzIGdvb2QgdG8gbWUsIG90aGVyIHRoYW4gdGhlIGN1c3Rv
bSBwcm9wZXJ0eSwgZm9yIHdoaWNoIEkNCj4gY2FuJ3QNCj4gdGVsbCBpZiBhIGNvbnNlbnN1cyB3
YXMgcmVhY2hlZCBvbiBsYXN0IHRpbWUgYXJvdW5kLg0KPiANCg0KICBJIGRvbid0IHRoaW5rIGEg
Y29uc2Vuc3VzIHJlbGF0ZWQgdG8gImN1c3RvbSBwcm9wZXJ0eSIgd2FzIHJlYWNoZWQNCmxhc3Qg
dGltZSBhcm91bmQuIEkgd2FzIGFpbWluZyB0byBmaXggYWxsIG90aGVyIHJldmlldyBjb21tZW50
cyBmaXJzdA0KYW5kIGxlYXZlIHRoZSAiZGV0YWlscyIgYXQgdGhlIGVuZC4NCg0KIEkgc3RpbGwg
dGhpbmsgaXMgYSBnb29kIGlkZWEgdG8gaGF2ZSBzb21lIGN1c3RvbSBwcm9wZXJ0aWVzIHRoYXQg
d2lsbA0KaW1wYWN0IG9ubHkgYSBjZXJ0YWluIHJhbmdlIG9mIGRldmljZXMgYW5kIGxlYXZlIHRo
ZSB1c2VyIHRvDQpkZWNpZGUvY2hvb3NlIGhvdyB0byB1c2UgdGhhdCBjb25maWd1cmF0aW9uIHNl
dHRpbmcgKHRvIGJldHRlciBzdWl0ZQ0KaGlzIG5lZWRzKS4gSWYgdGhlIGFwcGxpY2F0aW9uIGRv
ZXNuJ3QgcmVjb2duaXplIHRoZSBwcm9wZXJ0eSBpdCB3aWxsDQpiZSBjb25maWd1cmVkIHdpdGgg
dGhlIGRlZmF1bHQgdmFsdWUgYW5kIGl0IHNob3VsZCBub3QgYnJva2UgYW55dGhpbmcuDQoNCklm
IHdlIGRlY2lkZSB0aGF0IHdlIG5lZWQgdG8gdGFrZSBvdXQgdGhlIGN1c3RvbSBwcm9wZXJ0aWVz
LCB0aGVuIEkNCmNvdWxkIG1vdmUgc29tZSBvZiB0aGVtIGludG8gdGhlIERldmljZSBUcmVlLg0K
DQo+ID4gK8KgIG1pY3JvY2hpcCxody1kZXZpY2UtYWRkcmVzczoNCj4gPiArwqDCoMKgICRyZWY6
IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICvCoMKgwqAgbWlu
aW11bTogMA0KPiA+ICvCoMKgwqAgbWF4aW11bTogMw0KPiA+ICvCoMKgwqAgZGVzY3JpcHRpb246
DQo+ID4gK8KgwqDCoMKgwqAgVGhlIGFkZHJlc3MgaXMgc2V0IG9uIGEgcGVyLWRldmljZSBiYXNp
cyBieSBmdXNlcyBpbiB0aGUNCj4gPiBmYWN0b3J5LA0KPiA+ICvCoMKgwqDCoMKgIGNvbmZpZ3Vy
ZWQgb24gcmVxdWVzdC4gSWYgbm90IHJlcXVlc3RlZCwgdGhlIGZ1c2VzIGFyZSBzZXQNCj4gPiBm
b3IgMHgxLg0KPiA+ICvCoMKgwqDCoMKgIFRoZSBkZXZpY2UgYWRkcmVzcyBpcyBwYXJ0IG9mIHRo
ZSBkZXZpY2UgbWFya2luZ3MgdG8gYXZvaWQNCj4gPiArwqDCoMKgwqDCoCBwb3RlbnRpYWwgY29u
ZnVzaW9uLiBUaGlzIGFkZHJlc3MgaXMgY29kZWQgb24gdHdvIGJpdHMsIHNvDQo+ID4gZm91ciBw
b3NzaWJsZQ0KPiA+ICvCoMKgwqDCoMKgIGFkZHJlc3NlcyBhcmUgYXZhaWxhYmxlIHdoZW4gbXVs
dGlwbGUgZGV2aWNlcyBhcmUgcHJlc2VudCBvbg0KPiA+IHRoZSBzYW1lDQo+ID4gK8KgwqDCoMKg
wqAgU1BJIGJ1cyB3aXRoIG9ubHkgb25lIENoaXAgU2VsZWN0IGxpbmUgZm9yIGFsbCBkZXZpY2Vz
Lg0KPiA+ICvCoMKgwqDCoMKgIEVhY2ggZGV2aWNlIGNvbW11bmljYXRpb24gc3RhcnRzIGJ5IGEg
Q1MgZmFsbGluZyBlZGdlLA0KPiA+IGZvbGxvd2VkIGJ5IHRoZQ0KPiA+ICvCoMKgwqDCoMKgIGNs
b2NraW5nIG9mIHRoZSBkZXZpY2UgYWRkcmVzcyAoQklUU1s3OjZdIC0gdG9wIHR3byBiaXRzIG9m
DQo+ID4gQ09NTUFORCBCWVRFDQo+ID4gK8KgwqDCoMKgwqAgd2hpY2ggaXMgZmlyc3Qgb25lIG9u
IHRoZSB3aXJlKS4NCj4gDQo+IE9uIHRoZSBsYXN0IHZlcnNpb24sIHRoZSBsYXN0IGNvbW1lbnQg
SSBjb3VsZCBmaW5kIG9uIGxvcmUgd2FzDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8y
MDIzMDYwOTE4NDE0OS4wMDAwMjc2NkBIdWF3ZWkuY29tLw0KPiB3aGVyZSBKb25hdGhhbiBhbmQg
Um9iIHdlcmUgZGlzY3Vzc2luZyB3aGV0aGVyIG9yIG5vdCBhIHNwaS1tdXggdHlwZQ0KPiBvZg0K
PiB0aGluZyBjb3VsZCB3b3JrLCBidXQgaXQgZG9lcyBub3Qgc2VlbSB0byBoYXZlIGVuZGVkIGNv
bmNsdXNpdmVseS4NCj4gDQo+IFJvYiBvciBKb25hdGhhbiwgd291bGQgeW91IG1pbmQgY29tbWVu
dGluZyBvbiB0aGF0Pw0KPiANCg0KSSB0aGluayBpbiBjYXNlIG9mIGEgc2luZ2xlIGRldmljZSBv
biBidXMsIHdlIGNvdWxkIGF2b2lkIHVzaW5nIHRoZQ0Kc3BpLW11eC4NCg0KDQoNCj4gVGhlcmUg
d2FzIGFsc28gYSBjb21tZW50IGZyb20gSm9uYXRoYW46DQo+ID4gPiArwqAgdnJlZi1zdXBwbHk6
DQo+ID4gPiArwqDCoMKgIGRlc2NyaXB0aW9uOg0KPiA+ID4gK8KgwqDCoMKgwqAgU29tZSBkZXZp
Y2VzIGhhdmUgYSBzcGVjaWZpYyByZWZlcmVuY2Ugdm9sdGFnZSBzdXBwbGllZCBvbg0KPiA+ID4g
YSBkaWZmZXJlbnQNCj4gPiA+ICvCoMKgwqDCoMKgIHBpbiB0byB0aGUgb3RoZXIgc3VwcGxpZXMu
IE5lZWRlZCB0byBiZSBhYmxlIHRvIGVzdGFibGlzaA0KPiA+ID4gY2hhbm5lbCBzY2FsaW5nDQo+
ID4gPiArwqDCoMKgwqDCoCB1bmxlc3MgdGhlcmUgaXMgYWxzbyBhbiBpbnRlcm5hbCByZWZlcmVu
Y2UgYXZhaWxhYmxlIChlLmcuDQo+ID4gPiBtY3AzNTY0cikNCj4gPiA+ICsNCj4gPiANCj4gPiBG
cm9tIGEgcXVpY2sgZ2xhbmNlIGF0IGEgcmFuZG9tIGRhdGFzaGVldCwgbG9va3MgbGlrZSB0aGVy
ZQ0KPiA+IGFkZGl0aW9uYWwgcG93ZXIgc3VwcGxpZXMNCj4gPiB0aGF0IHNob3VsZCBiZSByZXF1
aXJlZC4NCj4gPiANCj4gPiBJZiB0aGlzIGlzIHJlcXVpcmVkIGZvciBzb21lIGRldmljZXMsIEkn
ZCBleHBlY3QgdG8gc2VlIHRoZSBiaW5kaW5nDQo+ID4gZW5mb3JjZQ0KPiA+IHRoYXQgd2l0aCBz
b21lIHJlcXVpcmVkIGVudHJpZXMgY29uZGl0aW9uZWQgb24gdGhlIGNvbXBhdGlibGVzDQo+ID4g
cmF0aGVyIHRoYW4gYXMNCj4gPiBkb2N1bWVudGF0aW9uLiBJZiB0aGVyZSBhcmUgZGV2aWNlcyB3
aGVyZSBpdCBpc24ndCBldmVuIG9wdGlvbmFsDQo+ID4gdGhlbiB0aGUgYmluZGluZw0KPiA+IHNo
b3VsZCBlbmZvcmNlIHRoYXQgYXMgd2VsbC4NCj4gDQo+IFRoZSBiaW5kaW5nIGRvZXMgbm93IGVu
Zm9yY2UgdGhlIHZyZWYgc3VwcGx5IHdoZXJlIHJlbGV2YW50LCBidXQgaXQNCj4gc291bmRzIGxp
a2UgeW91IHdlcmUgbG9va2luZyBtb3JlIHN1cHBsaWVzIHRvIGJlIGRvY3VtZW50ZWQgSm9uYXRo
YW4/DQo+IChBVmRkLCBEVmRkIGV0YykNCj4gDQoNCiBBbGwgb3RoZXIgc3VwcGx5IChsaWtlIEFW
ZGQsIERWZGQgZXRjKSBmb3IgdGhpcyBwYXJ0aWN1bGFyIGNoaXANCmRvZXNuJ3QgaGF2ZSBhbnkg
ZGlyZWN0IGltcGFjdCAod2F5IG9mIHdvcmtpbmcsIHJlc29sdXRpb24sIGFueQ0KY29uZmlndXJh
dGlvbiBzZXR1cCksIHNvIEknbSBub3Qgc3VyZSBpZiB3ZSBuZWVkIHRvIGFkZCBhbnl0aGluZyBt
b3JlDQpoZXJlLg0KDQoNCg0KDQo+IFRoYW5rcywNCj4gQ29ub3IuDQoNCg==
