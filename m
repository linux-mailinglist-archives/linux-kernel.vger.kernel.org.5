Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E657AA700
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 04:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjIVCdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 22:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjIVCdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 22:33:18 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2050.outbound.protection.outlook.com [40.107.215.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966A818F;
        Thu, 21 Sep 2023 19:33:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgMp4dQ0YC1A2aYMWLIZFynNqDG8soZiKUTgQ+1UEKctTpxhrWb2E00s06ZBEducYJOXgDterf5OtERLWScLOmf+cUIOKoIovSqvJOOTv86W3dStogljEVSFHzHy/s5VqIKhG+0YCwVraPBt91q0JT8yKh0SeTY0bpYBmeYOGkvSAYn1YUKtzAKqXwlKeEfojyijEC5NnsZMXXa6AM4qw1lPwxtLc8YhhTikvZy2W0xsi5n32b1cb7k5G3+gXPY+0hiMIidRsRId/2YGOpscUnOLRSKasulwgslDmVKsgPMa1UiM6qPv/aQYCf7u5SWm14nSqQD/EfsEMz8Ce/p3IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdF9B0sZxtbxnnzrqwZsRUq9sPLlMENSfNyIt/FGpv8=;
 b=n8RHKHHCYGt7qJCyaoUMzUGrGxlDXSMKv1HHQYllm8yQLpEC1jlMAmXzcpNQAKUWdClxtGlIy0DvnUC0GI/2UiAncfvNOZQjRIwXdcmaQT1AmJM02AlIyhGs9RqqEd0d4sat/wUpn0AEjNdGe7mhv48VWclj4CDyymzDkK++cdPCbhDjLe1g/9cXExk5f3BHTyh5GDwmq22INsK/VitmasVdoNiUbiIbpnvFvG2kw22A6g1q1eJGLXBx9DW0371fbe1rVVBOIcMzXzbzBH8gOzNMCUlnU0+wEnOG8rxTy9daHLVq7KD+/zCj4QN6Jz7+6FKez5rAPt8H4UfGZLLG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdF9B0sZxtbxnnzrqwZsRUq9sPLlMENSfNyIt/FGpv8=;
 b=Na41V9AQENzPVSEDDNa4qIrUtS898rNuF125Vc7Yw6oC73E6IAwQ65qFfDf1bEB9r5JYjUKAZp12VLybntpvEjp8r+VFu+ZWVYzNGeMqzoFIqoWQMMb/g7vseFrFKmRuhqpBPI9owVe1kpc+UqWOz/dmjivX5yfK+JrxTXVCH5J8qHTGLe0KlWsJYBr6fsb6Ge4gNYOGb8QZemXZQYBo2VWVsImlXDMmabVXtAs5QTE9UX4V3TccpzmfYu05JUEPDxSuMCXDEpeJQZkzAoJzkVTmCupxIj8uSmnE1NqVlPsrIFQLjd2KrQoRSFTkk0J/GcXkaf4mr5IsClxESAKKkw==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by TYZPR04MB5925.apcprd04.prod.outlook.com (2603:1096:400:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 02:33:06 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::5be7:ddc6:bdfa:73e4]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::5be7:ddc6:bdfa:73e4%4]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 02:33:06 +0000
From:   Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>
CC:     Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] dt-bindings: hwmon: add MAX31790
Thread-Topic: [PATCH v2 2/2] dt-bindings: hwmon: add MAX31790
Thread-Index: AQHZ5542XdKJDg3hSEKT23bdn2G/5bAb+LGAgAAIggCACilfkA==
Date:   Fri, 22 Sep 2023 02:33:06 +0000
Message-ID: <TYZPR04MB58530C4CB0386DF02D29E216D6FFA@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20230915062926.2460502-1-Delphine_CC_Chiu@wiwynn.com>
 <20230915062926.2460502-3-Delphine_CC_Chiu@wiwynn.com>
 <20230915-quench-left-8fbc1ca3b1da@spud>
 <CAL_JsqKWRfT71k56uMUJtU_abzFuicW01OBo-iScYash4Jrd2w@mail.gmail.com>
In-Reply-To: <CAL_JsqKWRfT71k56uMUJtU_abzFuicW01OBo-iScYash4Jrd2w@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|TYZPR04MB5925:EE_
x-ms-office365-filtering-correlation-id: 7c3b61ac-d1bd-49c4-fa27-08dbbb1440b1
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h21R79mWW2UpUdQjyTs3jBtktLAuqxsR5774h9deStcKR4Xkaj9Zgj1CXpBt+rMgucME7qv5I4h08QXwQFF98fVLYJGSvDIfFUQreir1k+RB4allUuOi+H3vut/+hPxbKsNf6G50WG0JD17Yjk5PvVgrFdjV621+cWTIAY0ty7JiokKXWMCxkmzYKSKCsIrQfpSCq0W1GulcOA//OiGWVQfM/Ks7xuahTOx8zVaQ/jedMQHmH9FxtlUbKnRo4ZNtgLwrgBtPVDRTCUtzOrO2vcfG8oTdUteaqOmLKQue7IuGjV/DcnD7YPC9UlhDgmOd8KAjYgcwNxSdMpmENhzAZRxJWnVzJRVypf/x0vkanLWlm6DME4LfLtU2ijeGGR2Bfqbkq1f6Hdt6x1ZUCHOhnJ7Ss+t/LImMh+RuwwjXyh0O1twa39fWz6Ak1GzCPdjIg9wSfdyDGFfuOE5mrv1V6BCuxQz8DRg9SIsnCzdY4vbdQSJDVG6uv7RpPmJMgUD8tttrtsA3Q/zGJ4Mea7aZoOuoNEP7AMuYHF9ruaKp+fwE3xdkHTjz4fIUf/UwLNHqcwyNnso8xe1Gpfj9Fq7ki9zGk0we5OMkqGYrZQK8EHM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39850400004)(136003)(346002)(186009)(451199024)(1800799009)(110136005)(316002)(66446008)(76116006)(66556008)(478600001)(66476007)(66946007)(64756008)(54906003)(52536014)(7696005)(6506007)(8936002)(5660300002)(8676002)(71200400001)(4326008)(9686003)(33656002)(38100700002)(38070700005)(86362001)(966005)(41300700001)(45080400002)(7416002)(2906002)(122000001)(26005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ky9lN1hwbkc0MGdVVERnZ1phUjN4blpFT2RKYVlKcVN6ckRzTm1RYlNIdTN3?=
 =?utf-8?B?YnhkZXQzUzNvc3pyOXFlTTdOSUpTNmFaaS9zREsxdGNFM09vRHZtYytyQW43?=
 =?utf-8?B?RWJ3S1lIU1ZSWmdzVTQyWTFJdU5zUS9jTXF3Tm16YjJvV21qTVFCUU1pRkdC?=
 =?utf-8?B?TXl0bGZIbTNuaDNpUjNkWWROVmFQNHN5eVAzd2R5S05ma25MVmk2N3cvRGYx?=
 =?utf-8?B?TnFEVGNnUDdFTmNVNjQ5M2tuNFhhWXFkeWROUFhRT1NnWVNKVlk1YmNHSGZn?=
 =?utf-8?B?YklDbnNGMTBjZFk0VlNUem9lbTRjQ080TVFrRlJmR0dPd3cxckZnMzZwaGlY?=
 =?utf-8?B?Z2VOVy9QUk1uM3FxaTgxbUhZanZwb3lXUnlUa3QzTDdpMUI5MnpHMUkrMHFD?=
 =?utf-8?B?VWxZZ0pIMWZrS3JQZGsxWHBhMVkvZVpVYlRKNU1JeE85TEhNS0N1VS9PQWJm?=
 =?utf-8?B?Ly9SOGRQSEN5Q1hHQWFqb3pmeUNqd2d2V0cycUVwK0lOdlpjOHJrUEM1eDB3?=
 =?utf-8?B?TDQxajNTR1RnTmdacU1reENMb2VWR0xnTUp3c3JXK1VkZVFUa2huWWV5ZVB0?=
 =?utf-8?B?T214Q3JmdU1LMDRKWTV5OGtlZGFOTkZVdm53dzUxOHl1aGR3bGo1Y3BwWlBG?=
 =?utf-8?B?N29waUFKVEpGajF2eEVHOTl3RCtmYnl4bmVzVmZ6VXQyc1NYWUhkYlVJNThJ?=
 =?utf-8?B?WWFCbVhZMjh5bFFpU0ZQd2J0Tk0zN3dhVmZEVXY1SHJnY0lGSHRQd01tdGU4?=
 =?utf-8?B?NDFTRmFCN0pFZjV5SUdGQm15bVJFVlNqeE8xalVmdkVaM1o1YVNobVZQZElh?=
 =?utf-8?B?T013SCtnRFE5RU92MW5abEhDa3ZDcVhlakg1aWNsbi9DMFJXMW1vbGZWNTk1?=
 =?utf-8?B?UGhSdFZwSWkzVDkrUWpnNjA1L3RDcDBoZHFraVFmandtcERMU3VpMkF6MXB3?=
 =?utf-8?B?Vmd2RXc0NkgxTXh0dHk5OXdPOTJzeFZvbDlDYll4S2YyU2FaOXE2ampPOERj?=
 =?utf-8?B?Q3lCL0MzakdlU3ZsdnpZRGE5L1VUelpaSEtFZEdKSE5CTk9UeDZneG9ZalBH?=
 =?utf-8?B?U08vT1dhWWZmUnBpTHNZQjZEejdmRGp6OVI3RWN4d21yQ2RxMytNTFo1MUFX?=
 =?utf-8?B?NjljYVRPZ1pWaG5MdTdiblhaN1RWQjJBcVRFMUJaOE9TakxyaUZIVlRIYzVB?=
 =?utf-8?B?dkRTWHZ5c2t2N1VwamlZQjlmMmkvY0kvMjZ1OS9CL1FBR2FWNXo3SGlCZ1NN?=
 =?utf-8?B?T2JxUmRBRjN2ZVphM0dLQkNpYzZlaXNuUjVJNEF3RlNaSlMydEJiM3k4NklK?=
 =?utf-8?B?WDl0a1RTd1RZK1ozelNxemdWMFV6Ni9XQkNaNjFpaktWRGFUTVFHb0ljdXJj?=
 =?utf-8?B?S3V1YWdwaDZXY1JzODIyUWduS3VURkNvZzZ1WDMyRkFxRlZlMUY3eUZlUCtQ?=
 =?utf-8?B?bVJSUTNOR3YrS3RmY3FJSFlnNGd6azkvNnJzamdCZWFmTm5TcW5sOTZ4T2xs?=
 =?utf-8?B?bGtyYjhRNUduQmNjZWZ3VU9qMFdjeVhleHJEY0EyaEFPdU1DQWFrT0hwU3pW?=
 =?utf-8?B?VDNCdjYwTWJvbkFTak15S1JsWDNrb3NvTFpNZHlmNjZ3VGprUCt0cndOYUpk?=
 =?utf-8?B?Y1BrSnFMbmpvOGI3d1BLZzl5OUZVTmc4NWE2WkRmcEV1emg5L2VnMk5tRjVI?=
 =?utf-8?B?cU5EYUU4ckdPejIrTnZZK0FTVmhkeHBxR2tsNUR1RDV6NVJEODF2bkxPTHJq?=
 =?utf-8?B?bXRpZmVDMVFBcjM3UTNpOExjTXMxZmxDMUVoK3JrK1gxVkRuQlRkTGRrRDZy?=
 =?utf-8?B?dDQyOW5GOGRRRW84T0swMTFhc0ppVEVRVnYvdjRIZ1NQcUpTMk9CL1h2ZWps?=
 =?utf-8?B?WFptOTcxS2h1RThxVUhOYUNZbjNRTEh1YzM2NFpWdVBuVXZEUjhOelU3TXRQ?=
 =?utf-8?B?SHZYcEVtZDZ4U1daNG9WcnhzeUtpNmUxR1JydEdNWjBuc3JDc2JqUnoxaG1j?=
 =?utf-8?B?allHdUhodEdTdFRiK2R1UERtdUl4MHRWZ3FzNDNMRGU4ZmFxdnFEVytnY3dQ?=
 =?utf-8?B?cnBwVjZjR0R1eVptenBlWVU4aDQvUTQzWlFtc2VjaEErSEtSandrTGsvc3U2?=
 =?utf-8?Q?0ckBDhVIF3HwAXuSmUGDKpxDr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB5853.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3b61ac-d1bd-49c4-fa27-08dbbb1440b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 02:33:06.2172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n9C8cQsgVrKq/infXVEaqwCutoK0inYbtQSmVGw0y5CuzXq/e7v1l+1/90kWtZUB8lcJ3itoe248xk+tdIcJnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5925
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gWW8sDQo+ID4NCj4gPiBPbiBGcmksIFNlcCAxNSwgMjAyMyBhdCAwMjoyOToyNFBNICsw
ODAwLCBEZWxwaGluZSBDQyBDaGl1IHdyb3RlOg0KPiA+ID4gQWRkIGR0LWJpbmRpbmdzIGZvciB0
aGUgTUFYSU0gTUFYMzE3OTAuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogRGVscGhpbmUg
Q0MgQ2hpdSA8RGVscGhpbmVfQ0NfQ2hpdUB3aXd5bm4uY29tPg0KPiA+ID4gLS0tDQo+ID4gPiBD
aGFuZ2Vsb2c6DQo+ID4gPiB2MiAtIEFkZCBkdC1iaW5kaW5ncyBmb3IgdGhlIE1BWElNIE1BWDMx
NzkwLg0KPiA+ID4gLS0tDQo+ID4gPiAgLi4uL2JpbmRpbmdzL2h3bW9uL21heGltLG1heDMxNzkw
LnlhbWwgICAgICAgIHwgNTkNCj4gKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gIE1BSU5UQUlO
RVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA2ICsrDQo+ID4gPiAgMiBm
aWxlcyBjaGFuZ2VkLCA2NSBpbnNlcnRpb25zKCspDQo+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0
DQo+ID4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaHdtb24vbWF4aW0sbWF4
MzE3OTAueWFtbA0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQNCj4gPiA+IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2h3bW9uL21heGltLG1heDMxNzkwLnlhbWwNCj4gPiA+IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2h3bW9uL21heGltLG1heDMxNzkwLnlh
bWwNCj4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gPiBpbmRleCAwMDAwMDAwMDAwMDAu
LjJiZDQ1NWIzNmIzZg0KPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ID4gKysrDQo+IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2h3bW9uL21heGltLG1heDMxNzkwLnlhbWwNCj4g
PiA+IEBAIC0wLDAgKzEsNTkgQEANCj4gPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAo
R1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpICVZQU1MIDEuMg0KPiA+ID4gKy0tLQ0KPiA+ID4gKw0K
PiA+ID4gKyRpZDoNCj4gPiA+ICtodHRwOi8vZGUvDQo+ID4gPg0KPiArdmljZXRyZWUub3JnJTJG
c2NoZW1hcyUyRmh3bW9uJTJGbWF4aW0lMkNtYXgzMTc5MC55YW1sJTIzJmRhdA0KPiBhPTA1JTcN
Cj4gPiA+DQo+ICtDMDElN0NSaWNreV9DWF9XdSU0MHdpd3lubi5jb20lN0M1Y2VmNTI3ZjQ0MjU0
YTNiMDhkNzA4ZGJiNWZmDQo+IDY0YjQlNw0KPiA+ID4NCj4gK0NkYTZlMDYyOGZjODM0Y2FmOWRk
MjczMDYxY2JhYjE2NyU3QzAlN0MwJTdDNjM4MzAzODgxNjQ1OTkwNDkNCj4gOSU3Q1VuDQo+ID4g
Pg0KPiAra25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJs
dU16SWlMQ0pCVGlJDQo+IDZJazENCj4gPiA+DQo+ICtoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAw
MCU3QyU3QyU3QyZzZGF0YT1XcCUyQnU5UXlGeWp2OGJoDQo+IFpSR29LOGdhag0KPiA+ID4gK1M3
aGlrWGJ4Tm9laGRPekxCRCUyRkklM0QmcmVzZXJ2ZWQ9MA0KPiA+ID4gKyRzY2hlbWE6DQo+ID4g
PiAraHR0cDovL2RlLw0KPiA+ID4NCj4gK3ZpY2V0cmVlLm9yZyUyRm1ldGEtc2NoZW1hcyUyRmNv
cmUueWFtbCUyMyZkYXRhPTA1JTdDMDElN0NSaWNreV8NCj4gQ1hfDQo+ID4gPg0KPiArV3UlNDB3
aXd5bm4uY29tJTdDNWNlZjUyN2Y0NDI1NGEzYjA4ZDcwOGRiYjVmZjY0YjQlN0NkYTZlMDYyOA0K
PiBmYzgzNGMNCj4gPiA+DQo+ICthZjlkZDI3MzA2MWNiYWIxNjclN0MwJTdDMCU3QzYzODMwMzg4
MTY0NTk5MDQ5OSU3Q1Vua25vd24lNw0KPiBDVFdGcGJHWg0KPiA+ID4NCj4gK3NiM2Q4ZXlKV0lq
b2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2DQo+
IE1uDQo+ID4gPg0KPiArMCUzRCU3QzMwMDAlN0MlN0MlN0Mmc2RhdGE9dXlxcDJiUkklMkJUV053
aWxvS2Y3NlI2VGlMNjFPaVcNCj4gMmFxeGdaa04NCj4gPiA+ICslMkI3OG1nJTNEJnJlc2VydmVk
PTANCj4gPiA+ICsNCj4gPiA+ICt0aXRsZTogTWF4aW0gbWF4MzE3OTANCj4gPiA+ICsNCj4gPiA+
ICttYWludGFpbmVyczoNCj4gPiA+ICsgIC0gRGVscGhpbmUgQ0MgQ2hpdSAgPERlbHBoaW5lX0ND
X0NoaXVAd2l3eW5uLmNvbT4NCj4gPiA+ICsNCj4gPiA+ICtkZXNjcmlwdGlvbjogfA0KPiA+ID4g
KyAgVGhlIE1BWDMxNzkwIGNvbnRyb2xzIHRoZSBzcGVlZHMgb2YgdXAgdG8gc2l4IGZhbnMgdXNp
bmcNCj4gPiA+ICsgIHNpeCBpbmRlcGVuZGVudCBQV00gb3V0cHV0cy4gVGhlIGRlc2lyZWQgZmFu
IHNwZWVkcyAob3IgUFdNIGR1dHkNCj4gY3ljbGVzKQ0KPiA+ID4gKyAgYXJlIHdyaXR0ZW4gdGhy
b3VnaCB0aGUgSTJDICAgICAgICBpbnRlcmZhY2UuDQo+ID4gPiArICBUaGUgb3V0cHV0cyBkcml2
ZSDigJw0LXdpcmXigJ0gZmFucyBkaXJlY3RseSwgb3IgY2FuIGJlIHVzZWQgdG8NCj4gPiA+ICtt
b2R1bGF0ZQ0KPiA+ID4gKyAgdGhlIGZhbuKAmXMgcG93ZXIgdGVybWluYWxzIHVzaW5nIGFuIGV4
dGVybmFsIHBhc3MgdHJhbnNpc3Rvci4NCj4gPiA+ICsNCj4gPiA+ICsgIERhdGFzaGVldHM6DQo+
ID4gPiArDQo+ID4gPiArIGh0dHBzOi8vYXBjMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwcyUzQSUyRiUyRg0KPiA+ID4gKw0KPiBkYXRhc2hlZXRzLm1heGltaW50
ZWdyYXRlZC5jb20lMkZlbiUyRmRzJTJGTUFYMzE3OTAucGRmJmRhdGE9MDUlDQo+IDdDDQo+ID4g
PiArDQo+IDAxJTdDUmlja3lfQ1hfV3UlNDB3aXd5bm4uY29tJTdDNWNlZjUyN2Y0NDI1NGEzYjA4
ZDcwOGRiYjVmZjY0DQo+IGI0JTcNCj4gPiA+ICsNCj4gQ2RhNmUwNjI4ZmM4MzRjYWY5ZGQyNzMw
NjFjYmFiMTY3JTdDMCU3QzAlN0M2MzgzMDM4ODE2NDU5OTA0OTkNCj4gJTdDVQ0KPiA+ID4gKw0K
PiBua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16
SWlMQ0pCVGlJDQo+IDZJDQo+ID4gPiArDQo+IGsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAl
N0MlN0MlN0Mmc2RhdGE9S3JtR2lKMlZGb0pFNSUyDQo+IEIlMkZleVcNCj4gPiA+ICsgaHJDcUlY
YmNTTVprNVRvQ2lpVUhVUUNScyUzRCZyZXNlcnZlZD0wDQo+ID4gPiArDQo+ID4gPiArcHJvcGVy
dGllczoNCj4gPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gPiArICAgIGVudW06DQo+ID4gPiArICAg
ICAgLSBtYXhpbSxtYXgzMTc5MA0KPiA+ID4gKw0KPiA+ID4gKyAgcmVnOg0KPiA+ID4gKyAgICBt
YXhJdGVtczogMQ0KPiA+ID4gKw0KPiA+ID4gKyAgcHdtLWFzLXRhY2g6DQo+ID4NCj4gPiBJIGRv
bid0IHNlZSBhbnkgb3RoZXIgdXNlcnMgb2YgdGhpcyBpbi10cmVlLCBzbyB5b3UnZCBuZWVkIGEg
dmVuZG9yDQo+ID4gcHJlZml4LiBUaGF0IHNhaWQsIEknbSBvbmNlIGJpdHRlbiwgdHdpY2Ugc2h5
IGFib3V0IGZhbiByZWxhdGVkDQo+ID4gcHJvcGVydGllcyBpbiBod21vbiwgc28gSSB3b3VsZCBk
ZWZpbml0ZWx5IGxpa2UgUm9iIHRvIGNvbW1lbnQgb24gdGhpcw0KPiA+IHdob2xlIGJpbmRpbmcu
DQo+DQo+IFBsZWFzZSBzZWUgdGhpc1sxXSBhbmQgY29tbWVudCBvbiBpdCB0byBlbnN1cmUgaXQg
bWVldHMgeW91ciBuZWVkcy4NCj4gT3RoZXJ3aXNlLCBvbWl0IGFueSBmYW4gcmVsYXRlZCBwcm9w
ZXJ0aWVzIGZvciBub3cuDQo+DQpUaGlzIHByb3BlcnR5IGNvdWxkIG9ubHkgYmUgdXNlZCBpbiBt
YXgzMTc5MCBkcml2ZXIuIFdvdWxkIGl0IGJlIG9rIGlmIHdlIGFkZA0KdmVuZG9yIHByZWZpeCBs
aWtlICJtYXhpbSwgcHdtLWFzLXRhY2giPw0KDQo+IFJvYg0KPg0KPiBbMV0NCj4gaHR0cHM6Ly9s
b3JlLmtlci8NCj4gbmVsLm9yZyUyRmFsbCUyRjIwMjMwODMwMTIzMjAyLjM0MDgzMTgtMi1iaWxs
eV90c2FpJTQwYXNwZWVkdGVjaC5jb20NCj4gJTJGJmRhdGE9MDUlN0MwMSU3Q1JpY2t5X0NYX1d1
JTQwd2l3eW5uLmNvbSU3QzVjZWY1MjdmNDQyNTRhMw0KPiBiMDhkNzA4ZGJiNWZmNjRiNCU3Q2Rh
NmUwNjI4ZmM4MzRjYWY5ZGQyNzMwNjFjYmFiMTY3JTdDMCU3QzAlNw0KPiBDNjM4MzAzODgxNjQ1
OTkwNDk5JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXcNCj4gTURBaUxD
SlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJTdDJTdD
DQo+ICU3QyZzZGF0YT0xZHJlMDVtbm9ZOVkyJTJGZFEyJTJCMm5WcTZ3UnVmZW1iZnhFSEFNZzFC
WHNNYyUzDQo+IEQmcmVzZXJ2ZWQ9MA0KDQoNCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+
ID4gKyAgICBpMmMgew0KPiA+ICsgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiArICAg
ICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ID4gKw0KPiA+ICsgICAgICBwd21AMjAgew0KPiA+ICsg
ICAgICAgIGNvbXBhdGlibGUgPSAibWF4aW0sbWF4MzE3OTAiOw0KPiA+ICsgICAgICAgIHJlZyA9
IDwweDIwPjsNCj4gPiArICAgICAgICBwd20tYXMtdGFjaCA9IDwyIDU+Ow0KPg0KPiBUaGlzIHdv
dWxkIGJlIDwyPiwgPDU+OyBubz8NCj4NCkkgcmVmZXIgdG8gdGhlIG90aGVyIGJpbmRpbmcgZG9j
dW1lbnRzIGluIGh3bW9uIGFuZCBtb3N0IG9mIHRoZW0gd2VyZSB1c2luZw0KdGhlIGZvcm1hdCBs
aWtlIDwyIDU+IGFzIGFuIGFycmF5Lg0KDQoNCj4gPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMg
Yi9NQUlOVEFJTkVSUyBpbmRleA0KPiA+IGM4ZmRkMGQwMzkwNy4uOTdlMTNiNmJmNTFkIDEwMDY0
NA0KPiA+IC0tLSBhL01BSU5UQUlORVJTDQo+ID4gKysrIGIvTUFJTlRBSU5FUlMNCj4gPiBAQCAt
MTM3MSw2ICsxMzcxLDEyIEBAIEY6DQo+ICAgICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9od21vbi9hZGksbWF4MzE3NjAueWFtbA0KPiA+ICBGOiBEb2N1bWVudGF0aW9uL2h3
bW9uL21heDMxNzYwLnJzdA0KPiA+ICBGOiBkcml2ZXJzL2h3bW9uL21heDMxNzYwLmMNCj4gPg0K
PiA+ICtBTkFMT0cgREVWSUNFUyBJTkMgTUFYMzE3OTAgRFJJVkVSDQo+ID4gK006IERlbHBoaW5l
IENDIENoaXUgIDxEZWxwaGluZV9DQ19DaGl1QHdpd3lubi5jb20+DQo+ID4gK1M6IE9kZCBGaXhl
cw0KPg0KPiBUaGlzIGlzIGEgcHJldHR5IG9kZCBzdGF0dXMgZm9yIHNvbWV0aGluZyB5b3UncmUg
bmV3bHkgYWRkaW5nLg0KPiBIb3cgY29tZSBpdCdzIG5vdCBnb2luZyB0byBiZSBtYWludGFpbmVk
Pw0KPg0KV2UgYXJlIG5vdCB0aGUgYXV0aG9ycyBvZiB0aGlzIGRyaXZlciBidXQgd2Ugd2FudCB0
byBhZGQgYSBmZWF0dXJlIHRvDQpjb25maWcgUFdNIGFzIFRBQ0ggdGhhdCB3YXMgZGVzY3JpcHRl
ZCBpbiB0aGUgZGF0YXNoZWV0IG9mIE1BWDMxNzkwLg0KU2hvdWxkIHdlIHNldCB0aGUgc3RhdHVz
IHRvIG1haW50YWluZWQ/DQoNCg==
