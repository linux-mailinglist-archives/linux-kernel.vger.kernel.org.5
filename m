Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8EC79D2A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbjILNrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbjILNrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:47:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE4810CE;
        Tue, 12 Sep 2023 06:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694526432; x=1726062432;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5HRNi4GdCVc5zALMqIygKO3t486RkOi+H57/R8mKAVg=;
  b=mN8lD7ajCcqg79wyCsThB5MjEYfOrWfgFkEwl6GfWSH25D0IugtAEglK
   gsUeUeVVMzo1jTZ6eMA5mL7VP3QF6dMQr7STLExk4FsO+faR6ut+RIZJX
   zoBf2lyWIM+rTcX+GgRc2MTk3tK9qO3XkLD1fpsd0L9ZJfPgSNGWIkZUl
   9aNNpga60kO9Vch87OYZTgka4/wI9Lbf+4/h6J+s9jMKyuvHwJK2O2KEr
   e9ezaBsY9bb/CVba0tyiNQBybZmBlfwrSKPmtDWx9FLEmSKHR7njOdz92
   NiNd8RfOXNU5ek4Y1GOWsUNZ0r6UH68PgRWBPXu2pyH2yFLKa8bkkX8av
   g==;
X-CSE-ConnectionGUID: S1ZHUOPWRVKj3k6l8IH+2w==
X-CSE-MsgGUID: SK7ArbxeR9OlB1F3AU2AUQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="4253649"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Sep 2023 06:47:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 12 Sep 2023 06:47:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 12 Sep 2023 06:47:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCZRSXyoA0ri+h8JESJ8ETFMo1w9izEH6P+M+rtvSzi1Rtu3vH/ekgXEdJouIYwnkKMLHgY/r8irCkxjdl7cSOE49RbsuLYTQTTWMzH4v7NLd40Je/BVXGeaKNSF4Xv9UiPn4ZXSS2OpaEU2nXBwj51jd1TPGKF5tiDO/VxNaKX4bxMNq7F98Lgnd7Pi7OoAvGbz1F0nMjCq6J0iYyMPYFzeZuNEQcOv/+4HwglHFSM+khZPISYDQlp39IhNK7sTR9BJZdmqWhGdWv4e1B2CqTNAfLyMN65hUKMVw6KAn/9Z32/bGoTrmffnZd2yBwoM/ms5n5i3RLSlvjdelV5ULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HRNi4GdCVc5zALMqIygKO3t486RkOi+H57/R8mKAVg=;
 b=E4LMGB2NUeddgHp1r3mxzHQfaAFiuhueqZGFf9tyg+2UFOqRkZhs7VjzNIEQA8Wikp7mwhY3t//5iVWVg0oZDouEmn5W201xIBwk4AYcmwByQ2dq9fvClDZ4u3enYwR9SZScOTmvML4tIUSHTItyIApqTr7sCsKO7btV5O26N5qvyT3vvedahSqQXCwLbOHkDncW6uomia+yXAps1dad6nZcUhDoYZ3MRikC4/6wI+ufj8deLFcLjlSvbYCHStCGB8XcGNn9CU4/ezMD2MZ0K1aCDcHrQwpJuulMrKG0Og/O3KgO/EEnYZEkL35MVSyayaUNHHoADxy8kd9iAczLoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HRNi4GdCVc5zALMqIygKO3t486RkOi+H57/R8mKAVg=;
 b=X3HK0P+vFYsu5jnuVa0SbS2mX4i+y3e7d1xL639ffM9Kd++uiNlB9+XINvcF8KveXJrsh6Z2Tj/jUdoKMkHY081J4OJcoDLZLWQuIswoo8UjESJUT/XxjnKUsFx+FqcqKSKg4jAlDgQPRWj//FYbPkEtxO9eJPffZKp8sAAoKMg=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 MW3PR11MB4601.namprd11.prod.outlook.com (2603:10b6:303:59::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.37; Tue, 12 Sep 2023 13:47:09 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::eb5d:6623:d0cf:d5e9]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::eb5d:6623:d0cf:d5e9%3]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 13:47:08 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <horms@kernel.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <Steen.Hegelund@microchip.com>,
        <rdunlap@infradead.org>, <casper.casan@gmail.com>,
        <andrew@lunn.ch>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
        <Woojung.Huh@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>
Subject: Re: [RFC PATCH net-next 4/6] net: ethernet: implement data
 transaction interface
Thread-Topic: [RFC PATCH net-next 4/6] net: ethernet: implement data
 transaction interface
Thread-Index: AQHZ4mEwIcqRhP4AnUasVDHVhRaf3rAUXAYAgALea4A=
Date:   Tue, 12 Sep 2023 13:47:08 +0000
Message-ID: <86a014d4-e187-8e51-c635-a0c90e14d226@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-5-Parthiban.Veerasooran@microchip.com>
 <20230910175824.GL775887@kernel.org>
In-Reply-To: <20230910175824.GL775887@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|MW3PR11MB4601:EE_
x-ms-office365-filtering-correlation-id: 9be54a7f-72cb-45cf-ad64-08dbb396c225
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FvPTun2mKxw/+tOwofaMuiDXo9NBHoMXpJ9Uw+R4EJbBr6w0LpMKb6xSckFye6zAkTe9l/E2tVbAK6VjoTdu9oxUFU+i2MM7GjqPc4r2fTp/etwC3ZE9mUhiz8tJnnajd/+03hVDLSB7uj4CJ8QYMpAM87CztziA85OH6fAAwIPaiHFKmIhtKaSb5h52P49h79bJu/y1KJSGkbm2Vez6bXixEgy60lGF9TTGUkBYD7svNIVWcMshTzxEvHBwolHCzsvPIiHL9zD+06r/1PYisjE1uwVr5dTMol43+9zhuC0fiCobgtUP7QcJhAJHvVdIroLswwjvpr80ZjKZdAPo6FhinGgNJCtHuhebu+VrH+LPBnT4AVol5MYdgK22gFaObXTXdlu9yKaHjJfk26FmbbTwYH6CX58uHFJYaMRHb4jk+6DhUy5QSIf0Wc6vlMw9+4NremtbkA7wPQdWfONjCl99P1LSJrG6qXEsAAeZN6e+1kM5ldcfL2hl//2AAu7ImMDdmsguCzXNgFhOQkr8kKPY80B4RUBf/MqSK2Ll3HTWZlnE4UTFH5C+HpxB0ht0YDqrbEUAK5qE1GL71vAKkPSEyHK+ZIWAsCcjv/A/MwjM7jCberAMGKgJW9MyzwFpU7LAHlepYFm6EMM3aT2SKq0vv1h52OGUE2i+YiYOVk8s5FBSMQloFsz+lubg3tPO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199024)(1800799009)(186009)(83380400001)(31686004)(26005)(66476007)(66946007)(64756008)(6916009)(66556008)(66446008)(2616005)(41300700001)(122000001)(54906003)(6506007)(53546011)(71200400001)(8676002)(76116006)(6486002)(107886003)(91956017)(478600001)(38100700002)(8936002)(4326008)(316002)(5660300002)(38070700005)(7416002)(2906002)(31696002)(86362001)(36756003)(6512007)(66899024)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzNpSmhRR3ZtZmJvRG5kYk9sVnlDVGlVaGVkNzBWeTNOMlVhWG5uR2Q3VjZS?=
 =?utf-8?B?RXQ2a0V2NGpVWW4xaUN2cXZ4M2pHZkord2QwLy9BYWFOWG5PcEVLdStzcmxN?=
 =?utf-8?B?eXZFSE9rV2czTHk1dDUrUVN4NHN6UGtqNDg5MHFpMFRlUnJEL1VocExROHk5?=
 =?utf-8?B?bjhrWWZua0hiQ3NrRnl0NTA5bmRVUkYxOVFSOE9DdG00REw3Q1RzRzNPU043?=
 =?utf-8?B?ejdpM2pYSEY4RGFFZUw2dFVQYUhadDFIZGV2T0NGaW5mRE9CU2psV3lYdjN5?=
 =?utf-8?B?MG56Zmd2YmZiNFFTWlNBTzhSdFdmcVRFUTB1S3g3aitrQXE2VXlKVmd6V3BS?=
 =?utf-8?B?NWp2L2xxWUlrQXU4ZGM5TGdpa2RPYXhXdFU1UlNMdTVPY2V4ek9XSSswZmpC?=
 =?utf-8?B?dkI2VEVpVENNZUQzS0s4eHBIZWR0NTRyZnE2bElTeG5pUmI0d0xTQ1Z6Umc1?=
 =?utf-8?B?VmNvRis4Z1YveFhKdHcvNDFLSEVSb0U3blUzWFpiN0p0YkVyM3lacFdMR2dX?=
 =?utf-8?B?MGhKUGFSVFVkSlNRVCtMMXNQa3UyK1N6RUlRZ3ZhamJEOEZqMWZscWVyQ2Fy?=
 =?utf-8?B?WlZoTEcrUjNiQkVLZGVXdkdOdmhnczJBYUdDSHkvdk5iclZVVmUyNGlobk9U?=
 =?utf-8?B?WkFySTBLbWRDdlZHWm9GRlZaeTVLVktHSC9tVmlnUENkZUFMZk1kdE9YUnBL?=
 =?utf-8?B?NEdJYVlsWFA1NWVIYm5sRTJLRzUyaVlMUEJtZ0ZQV3JwVFdVb3lESk10M0Zh?=
 =?utf-8?B?d2pjT3llaVRzSGcrR2RIZjVpZFNxb2xKalh5TjdjT2JIMVF1K08zTlVkSVk3?=
 =?utf-8?B?VUtRbUd4OUVTSDJWbEpxODhiMEIvRjdZY1ByQ29HVFJ1MGZINlhXUVVaYmVk?=
 =?utf-8?B?QU1neGJNU2NYcW50UERZc3M4QVltSjZyVmxYc3lEeDFsYTlVdmNCT3V6NFRq?=
 =?utf-8?B?ckdsQXN5dHJyeTBMYWJlR3AzVGE2ZFlSTVJ0L0g3U0JkbS81TWNFQlNLcUxw?=
 =?utf-8?B?OU9BNk9vNzBjaS9oaUNBVVc3amxMc2tWWFNNcGg4THdwemtsNDhaVndVVGtM?=
 =?utf-8?B?RkNYWVBuQlNOVVVDeFF6RXVMUWxJRkFQY29pMC9TajY4S2RtUlVTU3pqenhN?=
 =?utf-8?B?L21ma1F2Q3NqQVVDRmNnQ0tQT0psbmdBY1lUcm5KYTZXTWVIU1h2OFZRTDdq?=
 =?utf-8?B?NEFzSnVSa2JZb2dud0lKc05jOWJ1VlBFUjg3MTYyeHU0dlRkeU5nYlN1QVh1?=
 =?utf-8?B?TEpBT3pIWVBpRWZyNTUwWEo0blROcDZpYkNISzFDMnJKbzVhTEdjK3JseCt0?=
 =?utf-8?B?QWE3NHhzMVhYQ3ZlSDQ2bUFKK3ovbUdiM3grRlgvMXRqTmNYeWNWT2VvUHlS?=
 =?utf-8?B?WFBFVFVEU0xYZ1MxSVpDN0dNbE04VXkvUTJTRXZ0SWRiT0s3ZHo4TjI1ZUtV?=
 =?utf-8?B?dVVMK3B3Q2hJdXkwbGg4Y3lRUEVyNVFaSGVxTEhVaFErWVFoQ213WGJkc1Mz?=
 =?utf-8?B?YWxqeWlPVnFwS2ZyYml2Y3R3cWZROEorc01OREJuNkptUm9Mem1pQUFZYUpo?=
 =?utf-8?B?SXpTYldNanAraS90dFJneU9KMG45MVRqVmtWQlVPSGY2cmltMm1IY3lKNFlY?=
 =?utf-8?B?Yms0NGhNUmxpbEVCKzFNK0Y2c1Yvc3JWT01FamNIVkNreFljQ2xpeE5vVkpw?=
 =?utf-8?B?UDZjRjJ4RFVWejFtT1VvT25haGxRS1YweEh2RDdoN3EzZFMrUWsxbVA5UWNF?=
 =?utf-8?B?QVljSjBIN0Mwa1RPRUU2c3hGQS9ZNHppWCtpcE1ucUZudWJ1ZjFDVDZxdDVt?=
 =?utf-8?B?VWdseFFnYXluNFI4dnBNS3J4eGw3ZFJROUtmRGZuZUF0QWdoZHBlcENFYXF1?=
 =?utf-8?B?SVZMZnpmbUVEUUFpVDRoSHZUaGRGUjM5SlYyeCttU0xLOFB0aXREN3VYTU56?=
 =?utf-8?B?M3ROSDAvSUdqVFJwVnJpa2hqUDFnODRJRVV2Z0F3UGtwZVczWm1FQklzVkpX?=
 =?utf-8?B?eEJ6OFZMRDUrbXpOU2EyMVpHRWw0NThuYStXdjlOQWpxcXRmbWtLL3FrSTJt?=
 =?utf-8?B?b0dnazBFSG5LNFo4Zjh4eFAyREV5WjU1d1pQZHZFaFUwVXNvbndmVE1YL0Ji?=
 =?utf-8?B?NnovcmFpTjAwcVo4cFFlR3NyaXl5Wjc1cEtkbWM4UXRYNVkwbExkUWR6T0U5?=
 =?utf-8?Q?57ZKP1rxvETOf8oGpj2fFB0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16435B62C8DD004DA7276B4DCEDA4DDF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be54a7f-72cb-45cf-ad64-08dbb396c225
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 13:47:08.6591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R1wj4VAEQJIySf/vlGc3FyU5IAlwBWtstS0gIVXJ9krJFaKG1oBIs+aOfTTcaAvCUc7QqwelY2gA2rPh/B/PzEgSC9WOluLh/xWht90U/PuTPdhZx9FMLBWTE+RAUs8T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4601
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2ltb24sDQoNClRoYW5rIHlvdSBmb3IgcmV2aWV3aW5nIHRoZSBwYXRjaC4NCg0KT24gMTAv
MDkvMjMgMTE6MjggcG0sIFNpbW9uIEhvcm1hbiB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBGcmksIFNlcCAwOCwgMjAyMyBhdCAwNzo1OToxN1BN
ICswNTMwLCBQYXJ0aGliYW4gVmVlcmFzb29yYW4gd3JvdGU6DQo+PiBUaGUgZXRoZXJuZXQgZnJh
bWUgdG8gYmUgc2VudCB0byBNQUMtUEhZIGlzIGNvbnZlcnRlZCBpbnRvIG11bHRpcGxlDQo+PiB0
cmFuc21pdCBkYXRhIGNodW5rcy4gQSB0cmFuc21pdCBkYXRhIGNodW5rIGNvbnNpc3RzIG9mIGEg
NC1ieXRlIGRhdGENCj4+IGhlYWRlciBmb2xsb3dlZCBieSB0aGUgdHJhbnNtaXQgZGF0YSBjaHVu
ayBwYXlsb2FkLg0KPj4NCj4+IFRoZSByZWNlaXZlZCBldGhlcm5ldCBmcmFtZSBmcm9tIHRoZSBu
ZXR3b3JrIGlzIGNvbnZlcnRlZCBpbnRvIG11bHRpcGxlDQo+PiByZWNlaXZlIGRhdGEgY2h1bmtz
IGJ5IHRoZSBNQUMtUEhZIGFuZCBhIHJlY2VpdmUgZGF0YSBjaHVuayBjb25zaXN0cyBvZg0KPj4g
dGhlIHJlY2VpdmUgZGF0YSBjaHVuayBwYXlsb2FkIGZvbGxvd2VkIGJ5IGEgNC1ieXRlIGRhdGEg
Zm9vdGVyIGF0IHRoZQ0KPj4gZW5kLg0KPj4NCj4+IFRoZSBNQUMtUEhZIHNoYWxsIHN1cHBvcnQg
YSBkZWZhdWx0IGRhdGEgY2h1bmsgcGF5bG9hZCBzaXplIG9mIDY0IGJ5dGVzLg0KPj4gRGF0YSBj
aHVuayBwYXlsb2FkIHNpemVzIG9mIDMyLCAxNiwgb3IgOCBieXRlcyBtYXkgYWxzbyBiZSBzdXBw
b3J0ZWQuIFRoZQ0KPj4gZGF0YSBjaHVuayBwYXlsb2FkIGlzIGFsd2F5cyBhIG11bHRpcGxlIG9m
IDQgYnl0ZXMuDQo+Pg0KPj4gVGhlIDQtYnl0ZSBkYXRhIGhlYWRlciBvY2N1cnMgYXQgdGhlIGJl
Z2lubmluZyBvZiBlYWNoIHRyYW5zbWl0IGRhdGENCj4+IGNodW5rIG9uIE1PU0kgYW5kIHRoZSA0
LWJ5dGUgZGF0YSBmb290ZXIgb2NjdXJzIGF0IHRoZSBlbmQgb2YgZWFjaA0KPj4gcmVjZWl2ZSBk
YXRhIGNodW5rIG9uIE1JU08uIFRoZSBkYXRhIGhlYWRlciBhbmQgZm9vdGVyIGNvbnRhaW4gdGhl
DQo+PiBpbmZvcm1hdGlvbiBuZWVkZWQgdG8gZGV0ZXJtaW5lIHRoZSB2YWxpZGl0eSBhbmQgbG9j
YXRpb24gb2YgdGhlIHRyYW5zbWl0DQo+PiBhbmQgcmVjZWl2ZSBmcmFtZSBkYXRhIHdpdGhpbiB0
aGUgZGF0YSBjaHVuayBwYXlsb2FkLiBFdGhlcm5ldCBmcmFtZXMNCj4+IHNoYWxsIGJlIGFsaWdu
ZWQgdG8gYSAzMi1iaXQgYm91bmRhcnkgd2l0aGluIHRoZSBkYXRhIGNodW5rIHBheWxvYWQuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogUGFydGhpYmFuIFZlZXJhc29vcmFuIDxQYXJ0aGliYW4uVmVl
cmFzb29yYW5AbWljcm9jaGlwLmNvbT4NCj4gDQo+IEhpIFBhcnRoaWJhbiwNCj4gDQo+IHRoaXMg
cGF0Y2ggc2VlbXMgdG8gaW50cm9kdWNlIG5ldyBTcGFyc2Ugd2FybmluZ3MuDQo+IFBsZWFzZSBj
b25zaWRlciBhZGRyZXNzaW5nIHRob3NlLCBhbmQgaWRlYWxseSB0aGUgd2FybmluZ3MNCj4gZmxh
Z2dlZCBpbiB0aGUgZXhpc3Rpbmcgb2FfdGM2LmMgY29kZS4NClN1cmUsIHdpbGwgY2hlY2sgaXQg
aW4gdGhlIG5leHQgcmV2aXNpb24uDQoNCkJlc3QgUmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0K
PiBUaGFua3MgaW4gYWR2YW5jZSENCj4gDQoNCg==
