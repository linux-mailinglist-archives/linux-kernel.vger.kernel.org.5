Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C287CA1BF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjJPIgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjJPIgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:36:41 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2041.outbound.protection.outlook.com [40.107.117.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FA6114;
        Mon, 16 Oct 2023 01:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UncQVXgz6NIP9tneUB3wZO3HaEAIqvDthDn2OrBaQfpKCIx/KQd9yQlv8oZx4cocPCExA4wVRxBCsQcWg5MzhRAmatsZXkU13V5I3D418nwV5yTueQF4bLPIZvUIzl3RBJ6dplOzgAuYvcFo0lnSIEq0l79H+bxuPWDNq/+wrNLHmrl/cVaEz82r7deJeMUw8yE4Fh7+1QzXZ+BNDjz625Jp3CGX8byWDzLl6BiiwEnX/8NiR6wDPNU/K1ud8tn5PDuJ9DWVjL+46qW1PlcV5/mbuxhagvsFNwcNx5c8za/T8dAXkoNkMMBQwopPSkwRTg4KxqHEqEkKEWr557q6xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZpUUHy/rS5Vjh1yhlKxYP5lyugMp+MSO7L5tdM54Dw=;
 b=i20Y31ua5uAtGUad8mmcO+j9B+PaRIyWd6MPJx6dHV8PskT9kotvgbS5llswNXTh+s/acIDvV3pe1A6v065RoEQZlQUSWtQE1vsABrtuYTZ8Gc7QQbCR2nTvIb9J+HR66gyLxHuyk+Ln9EhbKIIy8s6D6Iit2DhCnoMzqZflV0W2DFzMpIGVDTTN+PXDdSIEyN+x5LB0THs1lk/Cfc/iPekXxTEEpnIZSwWy0xfZ5KVfGWhhQT10kHwOQLyEofqwvjyAnpZDx01+bB7t34ADYoPwHDy4OeQmfBNcboECygUzRMwwhvQPTpXFD1X4P4/PCAnD6mY3mUAw/Le7oCLj0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZpUUHy/rS5Vjh1yhlKxYP5lyugMp+MSO7L5tdM54Dw=;
 b=lur5Nosve3oxqBMSwKMDSW5cy9uAzW6hG+GZcuVtRoL/6emMUyZRA2obfZyIsH5Q6Y9rMXEoqhIxmuxLzB/Y8CYskPfrIaX9lDyYqvwFi25STLJMUGYP7wlb2QicWXmdR+WIGo6i58TuEGUry8DC0BwAeLBGVYncTZPdF7H66nc=
Received: from TYZPR02MB5088.apcprd02.prod.outlook.com (2603:1096:400:71::13)
 by SEZPR02MB7038.apcprd02.prod.outlook.com (2603:1096:101:19e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Mon, 16 Oct
 2023 08:36:31 +0000
Received: from TYZPR02MB5088.apcprd02.prod.outlook.com
 ([fe80::21da:6305:19cc:e3a2]) by TYZPR02MB5088.apcprd02.prod.outlook.com
 ([fe80::21da:6305:19cc:e3a2%5]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 08:36:31 +0000
From:   "Puliang Lu(Puliang)" <puliang.lu@fibocom.com>
To:     Johan Hovold <johan@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] USB: serial: option: add Fibocom to DELL custom modem
 FM101R-GL
Thread-Topic: [PATCH] USB: serial: option: add Fibocom to DELL custom modem
 FM101R-GL
Thread-Index: AdoAC8neuvNF559JQeKhKfAD3poYzQ==
Date:   Mon, 16 Oct 2023 08:36:30 +0000
Message-ID: <TYZPR02MB5088B70C88A3751EC69819E289D7A@TYZPR02MB5088.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR02MB5088:EE_|SEZPR02MB7038:EE_
x-ms-office365-filtering-correlation-id: 3d0e5fb3-62f5-4e36-89ec-08dbce22ff48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7dCP9fNkcHR3oYM004J/ByS9bdA8KwgNPbRuxxIFVJt09sQCCWRqZ7qtycAkLE2OHI5a3MtT1IrzT/s+SHqZNHlILZrrdYIIlFvvTNgjboiYTw514iFAzXw3aVG8CrSl/7nb/vrEpt0QYsKMrkEKU/iaxpB650gwWsC/YIFlxYCR23bysBMb1TNahW2QQOeVW6abAXB5Ztlaw/d8aXIgbvV8VZlTFA/agylT1U6sa/YiDVaxq1hPXA+mbMWKoqjLPcWqgK5eEiKXOM+DB3mcnv+7isHVj61dFVK4F7SH6jMSjT7yHD/7o6k0n070UgQfj+00GxlLryBvUX8RskWIjx5qNf7FkxUcILnS4TrG5u1N2+F4sIpAYNCawTzafYtBut/qo7QDbVryQUsp6iPAdRaATriUkN4yoP40nk757TXspO61ZyBSBAJAy+sdPPLZJkQp4JEN2fkhemKcijQR8K0VMaE6pi1xgYt1nXZ2KUqtyvzb1Glqm1F6JJav/Dpc2HOTDBDO6y9J5O6+iV6X8lzg09xLMxrIMF7+Fw8shxes6Ebntc4bztJfmPvt8DRHNNW58hoa3kpq8wAPgeowB4pkQ6jDngxOAuIMkuKXLJF0w13YYZqjBTjFAXliO3Jt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5088.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(396003)(39850400004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(55016003)(478600001)(66446008)(76116006)(66946007)(66476007)(66556008)(6916009)(71200400001)(7696005)(122000001)(86362001)(54906003)(83380400001)(316002)(64756008)(9686003)(26005)(38100700002)(6506007)(38070700005)(33656002)(2906002)(8936002)(52536014)(8676002)(41300700001)(5660300002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkZtUEhtM0VGVEdGWXpLMUVhenJNakZOTWhGUmpUS3ZYSkxZOEZlaUVhVE1k?=
 =?utf-8?B?Nmg3dXFjR0g4S3lzOGtvZzQ3T0NtdWRVMklxN3NvTlFpNXZ5dm1hQ1BEdmla?=
 =?utf-8?B?WENVQk9aRGwzSGJWS1J1eS9lN2dsYXNQZUYvSmMzTWNyM1MrTEdMVlJhSXda?=
 =?utf-8?B?OW4weGNOaWsyckc5RmV6b0hJSndnMG5jeitXU2lmN0lqNTdMMmo2UVFqTzZz?=
 =?utf-8?B?RW9wZ3ZxN3RHWlNHMi92NGR3WHNFZE40QWJMQTlGdDNYM05jTUlyOGtTaUZX?=
 =?utf-8?B?N0RPbUFvd0FoZjdwdGVtZUhFRVE2dVU1cTFxMlk1dy9iUDZpbkZudmdPMStX?=
 =?utf-8?B?NGg3bENuTDZIUTljSi9FdFQrTElSaXMrbmJjckFJU1lEYUpBckppdERrWjkw?=
 =?utf-8?B?Nkp4V3loODBjZWtuVmxKUnJLdGphaWt1NEtEV2lGUFh6L3E1M0dVRWRrZWJC?=
 =?utf-8?B?N081NXkrbE1EWnp2Vjg5UzZNRUVvUGt5SHB6NmJTSnl3dGYyOTdMYUlDNVI2?=
 =?utf-8?B?TWVVNVRFZWhpdXRSWnBRZ0QyYm9rWWFrZGcrUThiTFZIN3dqUVAzeHlkQzFs?=
 =?utf-8?B?aHZkNzNyK1VPM2d6Rno5UnpZbEJRZ3RMV0dld2cvemRKTytoNUE0SHlOS291?=
 =?utf-8?B?RmNwNHYzM051REN1R09qRktKcFUvZi81UjRFbVBnRkZpVDJjR2hiTkYvd3Bu?=
 =?utf-8?B?WGY3NzlmdFVWZWo2cHJaWlVMQ3JONm9pL2hoUFJ0VDQvVTFKNXhXUWRUa3Fv?=
 =?utf-8?B?U1ZCQXpseXZBakU5MjM2dnlDTk9UZWJBVUtpbWV3Wk9WQS9uNVNpVWgwd3or?=
 =?utf-8?B?OE8zTVBvUGlIK0ZKOGtDQW4rRWtsVHdEbnJYa0dsbFJTM0Y5VVFKcndJYVNE?=
 =?utf-8?B?a3JueDJGaVFiQnpzeWt4YXdwT0M2aFhFZk9DdlM4dXFWYmxMaFVucEI1OEt1?=
 =?utf-8?B?QkdYZVFzL25aTTJyKzcrWWdOZ2U3dzUzWStFby9CRDNMd3VYdXgzdStPamFp?=
 =?utf-8?B?ZHIvWXoyZGljbWRRQWNFejd4ZmFEbkU4dFp3YktrTG1ISjRDU1BINm5wbWQx?=
 =?utf-8?B?bkdEUng3UTh2eSt5aWJNSDcrMXNGM3dCQTI0dndvS1hiWDh6OFpML0ppRUhh?=
 =?utf-8?B?ZndsR3JzclJScjhwZEtZUUNSM0xGSkFCMG9kcHFUb2wvU1A2OHVSOE1CejN4?=
 =?utf-8?B?WEtINEQxb000c3MweUJOOFdPcVVPVnlteXFkUlVrNmplclVvaXRybEVkdDZ3?=
 =?utf-8?B?TVp3OTc0NDh1OVp0Z2dWMjIwVUVNUmRuL09IMFhsRGgyYjI3OWN2eU1vYU9a?=
 =?utf-8?B?ZHBlNVJOMEppSVdNa0NvOXRFWFlPT2xzUnladWR0OVVLRlFpU3I4dTl1U1Y1?=
 =?utf-8?B?M2pEOFhld0E3bmV2WXZ4ekhPNmhmRGhBZUx3VFo1WlhWcEV6Qm9aR1JWeU5n?=
 =?utf-8?B?alJpaVVxaUNKZ3lQVTFHd2lLd2lxWnZaaG4wMW9DRElCN2xMT1pJTDEybGMv?=
 =?utf-8?B?cEc2WmliNHhka1Y4K2UxMW5sQU5yTXo1cGpTWWFWY2FobThPalZJQkIxMWw3?=
 =?utf-8?B?cC93RlhIVUk3cU1lakZsakdNc2NZQ3dsOFZZaVpyV0w5UEtJSXArSUxoMzJE?=
 =?utf-8?B?SkJ6bDhvNDNrTFZWdlJLSkN0dUdPOWhRV0NzeGFiWjBDcEpuZkt4SzRXQmFt?=
 =?utf-8?B?Q3AwY21LdlBYU2NObEZwWTVXck0zNVdMajU1Zy82SDllQTJGTHArdU9WZ3dw?=
 =?utf-8?B?eWt6WVdKVlA0QzYzczFqQ1FqTVhDQTIyOU9lSTlzdXZNNFFQcWZiS0ZIeG5T?=
 =?utf-8?B?U3N0WGhWcFRMQlRvQllnQlozM3FBTmhHK25SNWhOektDM25VOHhQdmVhWGc4?=
 =?utf-8?B?bUxZS3g0UVdzd0VML2pQQ1pPUW5zcmZuUGM0MDlGY3NSZnhTeFdoekhvMTZh?=
 =?utf-8?B?MHJTYzY1QTVaYVcycnhYWWVBTG9TbFAzV2pzMTM5L2xVRWVNSWVwR0p2YlYz?=
 =?utf-8?B?N0VaSlVUYUxaZUU3QklFbjkxSkdBTmd6TWk5UXNPZU5ZOEJ4V0JaWGpmUE1O?=
 =?utf-8?B?MFQweHNhQUFna0ZqdkJ2M2VPTlAzbTJudU5Wd2EvekphN0tqSStkUk9TSW02?=
 =?utf-8?Q?A8sisyCu3fkhtM9/FngN5oYYg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5088.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0e5fb3-62f5-4e36-89ec-08dbce22ff48
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 08:36:31.0207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x8ws7Rp7UiYo9VDhwpq0FGYto+/lSy/uSWJ3qP1/rdOaSaezm4By/GxxdEjKBZwmHoWP728Wq0wwSE7tlxxb8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7038
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBNb24sIE9jdCAxNiwgMjAyMyBhdCAwMzozNjoxNlBNICswODAwLCBMLemygeeSnuS6riB3
cm90ZToNCj4+IEZyb206IFB1bGlhbmcgTHUgPHB1bGlhbmcubHVAZmlib2NvbS5jb20+DQo+Pg0K
Pj4gVXBkYXRlIHRoZSBVU0Igc2VyaWFsIG9wdGlvbiBkcml2ZXIgc3VwcG9ydCBmb3IgdGhlIEZp
Ym9jb20NCj4+IEZNMTAxUi1HTA0KPg0KPj4gVDogIEJ1cz0wNCBMZXY9MDEgUHJudD0wMSBQb3J0
PTAxIENudD0wMSBEZXYjPSAgMiBTcGQ9NTAwMCBNeENoPSAwDQo+PiBEOiAgVmVyPSAzLjIwIENs
cz0wMCg+aWZjICkgU3ViPTAwIFByb3Q9MDAgTXhQUz0gOSAjQ2Zncz0gIDENCj4+IFA6ICBWZW5k
b3I9NDEzYyBQcm9kSUQ9ODIxMyBSZXY9IDUuMDQNCj4+IFM6ICBNYW51ZmFjdHVyZXI9Rmlib2Nv
bSBXaXJlbGVzcyBJbmMuDQo+PiBTOiAgUHJvZHVjdD1GaWJvY29tIEZNMTAxLUdMIE1vZHVsZQ0K
Pj4gUzogIFNlcmlhbE51bWJlcj1hM2I3Y2JmMA0KPj4gQzoqICNJZnM9IDMgQ2ZnIz0gMSBBdHI9
YTAgTXhQd3I9ODk2bUENCj4+IEE6ICBGaXJzdElmIz0gMCBJZkNvdW50PSAyIENscz0wMihjb21t
LikgU3ViPTBlIFByb3Q9MDANCj4+IEk6KiBJZiM9IDAgQWx0PSAwICNFUHM9IDEgQ2xzPTAyKGNv
bW0uKSBTdWI9MGUgUHJvdD0wMCBEcml2ZXI9Y2RjX21iaW0NCj4+IEU6ICBBZD04MShJKSBBdHI9
MDMoSW50LikgTXhQUz0gIDY0IEl2bD0zMm1zDQo+PiBJOiAgSWYjPSAxIEFsdD0gMCAjRVBzPSAw
IENscz0wYShkYXRhICkgU3ViPTAwIFByb3Q9MDIgRHJpdmVyPWNkY19tYmltDQo+PiBJOiogSWYj
PSAxIEFsdD0gMSAjRVBzPSAyIENscz0wYShkYXRhICkgU3ViPTAwIFByb3Q9MDIgRHJpdmVyPWNk
Y19tYmltDQo+PiBFOiAgQWQ9OGUoSSkgQXRyPTAyKEJ1bGspIE14UFM9MTAyNCBJdmw9MG1zDQo+
PiBFOiAgQWQ9MGYoTykgQXRyPTAyKEJ1bGspIE14UFM9MTAyNCBJdmw9MG1zDQo+PiBJOiogSWYj
PSAyIEFsdD0gMCAjRVBzPSAzIENscz1mZih2ZW5kLikgU3ViPTAwIFByb3Q9NDAgRHJpdmVyPShu
b25lKQ0KPj4gRTogIEFkPTgzKEkpIEF0cj0wMyhJbnQuKSBNeFBTPSAgMTAgSXZsPTMybXMNCj4+
IEU6ICBBZD04MihJKSBBdHI9MDIoQnVsaykgTXhQUz0xMDI0IEl2bD0wbXMNCj4+IEU6ICBBZD0w
MShPKSBBdHI9MDIoQnVsaykgTXhQUz0xMDI0IEl2bD0wbXMNCj4gDQo+IFRoYW5rcyBmb3IgcmVz
ZW5kaW5nIHdpdGggdGhlIGF1dGhvciBhZGRyZXNzIGZpeGVkLg0KPiANCj4gWW91IGRpZCBob3dl
dmVyIG5vdCBhbnN3ZXIgbXkgcXVlc3Rpb24gd2hldGhlciB0aGVyZSBjb3VsZCBldmVyIGJlIG1v
cmUNCj4gdmVuZG9yIGNsYXNzIGludGVyZmFjZXMgKGUuZy4gZm9yIGFkYikgc28gdGhhdCB5b3Ug
c2hvdWxkIGJlIHVzaW5nIGENCj4gbW9yZSBzcGVjaWZpYyBtYXRjaCBmb3IgdGhlIGVudHJpZXMg
KGkuZS4gVVNCX0RFVklDRV9BTkRfSU5URVJGQUNFX0lORk8oKSk/DQoNCjB4ODIxMyBhbmQgMHg4
MjE1IGhhdmUgb25seSBvbmUgbWJpbSBhbmQgb25lIHR0eSwgVGhhbmtzLg0KDQo+DQo+PiArCXsg
VVNCX0RFVklDRV9JTlRFUkZBQ0VfQ0xBU1MoREVMTF9WRU5ET1JfSUQsIERFTExfUFJPRFVDVF9G
TTEwMVIsIDB4ZmYpIH0sDQo+PiArCXsgVVNCX0RFVklDRV9JTlRFUkZBQ0VfQ0xBU1MoREVMTF9W
RU5ET1JfSUQsIERFTExfUFJPRFVDVF9GTTEwMVJfRVNJTSwgMHhmZikgfSwNCj4NCj4gSm9oYW4N
Cg==
