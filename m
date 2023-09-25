Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B29A7AD483
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjIYJ3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbjIYJ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:29:41 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2111.outbound.protection.outlook.com [40.107.117.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1365AA3;
        Mon, 25 Sep 2023 02:29:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIm6SiOZYYRfTUx839tI0Mnj/4eL7hC65FV/RhYq0/1fb3OjwbSW9w+dQlSSWf6mZ1k9Itx33ZbFKhkl+LzhnKEPOX/RMtH6XzoAMEy5/OEpujejVJFmhfoWEUma5qNpvfP3QrKfRe37RS7yE3CiU/OeoESPw2hwo+2TJZWpvoU9CXUJKtdb0k0UDrmrBICB6xjEezp0qphl2I/k5kjru9f2ep84zOMF9D5KGFF9midup0ba+Yptq4P5jib1CShp5H3gD2TLU1UEyePc5XY7s1I10ikJzAT+GlKWWBgROJuoMHAp+U70wds7bqsuthJXFDtKldKoZxbQcxMMv3GZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEJHSjyC3C9CJWwHrFuVRHFWdVU0j8XWdyxeGP6Vbi4=;
 b=nEa22SQ15RAx2UpEe6x7gKUBL5KZ/7E51CoDNJiJ6D5Clgir6uoMnlWCTslSzPjRMVkRbqfNtmXFWdTDDYwu54d37iWRiVz9+cRUlePlD4YyOWFr2ILxD7NWmIeQbnVFv1sdQ9c+O5cNCaPA3PDg+aCxUeeb+mAqtujtvAN62UJq9GRNMUGRT7QfoiR+EoreM8xP4cFm+kHdWcYb9JCwu/fwi4xterTJjnD7MTtGVvTYrquFejO+RjvLEAnK7qGRgZPZz15xxaDEgGcff+UXpR9M/MZMQSaZ0v3P7Pc6GQpx2UwSsC7n4WCbQTHWwcsiguoJ59j14qFNJHvlSU5ueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEJHSjyC3C9CJWwHrFuVRHFWdVU0j8XWdyxeGP6Vbi4=;
 b=TXs+yYGJEPjqGGfrxRE0Rbt0xDAa2hu4XqmQCqRhTYipm54csKas4PSRBLtVGulhRQHnKXaIsm8zvJQSnBJosIMVUKDxydt86O3Ae8oMfVgxkyeCwrz+NwOuUicepmq+5Pibq0J72fms2C8Wxc+cTW+6cEssNhx85VMyk2N6WZtBIoeJsZSiXOZMgwLSOBJbRjUI42Kz9gn/0+WjhJerEMpjtyz7vYa2pTWUinUaGY3xb3t7/QC5YEQVKQZU4YmTf+7/uwJ2K0+itMoiQLVKxo9geF26fEzhgMUvUDkRYAXkNJjDGbJSBGjL8MM/yytTI6GFBvWMC/4BT7l/xGWTGA==
Received: from SEYPR03MB7046.apcprd03.prod.outlook.com (2603:1096:101:d0::15)
 by TYZPR03MB5966.apcprd03.prod.outlook.com (2603:1096:400:126::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 09:29:31 +0000
Received: from SEYPR03MB7046.apcprd03.prod.outlook.com
 ([fe80::59de:bf6b:c22:4f8d]) by SEYPR03MB7046.apcprd03.prod.outlook.com
 ([fe80::59de:bf6b:c22:4f8d%7]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 09:29:30 +0000
From:   Cancan Chang <Cancan.Chang@amlogic.com>
To:     Oded Gabbay <ogabbay@kernel.org>, Jagan Teki <jagan@edgeble.ai>
CC:     linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: =?utf-8?B?5Zue5aSNOiBrZXJuZWwub3JnIDYuNS40ICwgTlBVIGRyaXZlciwgLS1ub3Qg?=
 =?utf-8?Q?support_(RFC)?=
Thread-Topic: kernel.org 6.5.4 , NPU driver, --not support (RFC)
Thread-Index: AQHZ7TUhgs72H8AZFkqdmOUY4AB+vbAmlr0AgABcLACABCyLjw==
Date:   Mon, 25 Sep 2023 09:29:29 +0000
Message-ID: <SEYPR03MB70462A385A52A317427E93B59AFCA@SEYPR03MB7046.apcprd03.prod.outlook.com>
References: <SEYPR03MB704641091854162959578D7E9AFFA@SEYPR03MB7046.apcprd03.prod.outlook.com>
 <CA+VMnFyhp9D8cjtvLVzdKGETouOuH=MKgjOu1pn00WDRB=5oUg@mail.gmail.com>
 <CAFCwf12sUL5bcXhYKwRkMxLtSDtLfTK003oxkRDVmThx1ARV-A@mail.gmail.com>
In-Reply-To: <CAFCwf12sUL5bcXhYKwRkMxLtSDtLfTK003oxkRDVmThx1ARV-A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7046:EE_|TYZPR03MB5966:EE_
x-ms-office365-filtering-correlation-id: e26933e1-c34d-4faa-5e0f-08dbbda9eb42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I2q0JNmJn28FPeQzan4alUdp3mlzxCL4FdAYrZTys9wK8DLYmiln83AeXhBOrdAXclIYSgBE7fzS8fihOSR+CM4XBmrfad4LJJWQarVWLN92D6OCEjP0ave1gNGzu17x7AOWGv1JxBCbcbzKXEk76i5uXRjTpUV0Nqx+Cu2Gfq1jIoObQ6hhhOxRxf6YyQ5y2LeBIHPY/p4mUF1HTo3Bb+MK3aFNTYjoeWMre0knDUbmiBkaxK289etwPBAx1vTMMS0xNbtX1HWBhqF4ln/hj0xUp7bRjoafnw726NlUQ9N4DQtmkkER5Mf91nSa7x57/thANAcGVRitlevhn6sc45uUJ517OJMfe99SLaT7iWLZjI9aV1BeiEPsaRNBD/xO9ACw393zAFFlW+/du7JwN+YrrRE9cjeHFJSIWocHY5yAI4SBWYSau47X9lkBMlBmby5CQ/c3SIcORAVcIyS33W1N33f14XupZb6CfLEgH04YuCVKX4g5vTARhc+uV8QZNGRwOOvC/4jXvYzbwwcK6wzc3raUJ9SAK+5PgbtCGau18tmEHYEZCbuK2cIjDLem3/IsTbrzwIJ9r5BDJisRUjkRO56SUqUT2rzTr6jE2eGcV1cW85hy2BCYM2c3NkPEu1YPZXZPrC1wpOsGyx0meQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7046.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39850400004)(396003)(366004)(230922051799003)(186009)(1800799009)(451199024)(7696005)(6506007)(9686003)(53546011)(26005)(71200400001)(33656002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(86362001)(110136005)(966005)(91956017)(478600001)(122000001)(38070700005)(38100700002)(83380400001)(54906003)(55016003)(2906002)(8936002)(4326008)(5660300002)(316002)(224303003)(52536014)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkRyZ2tOUnV5bngvTE43VXBjd1FLbTBPaU5SN2R1TUNmV1p1RlMySUQ3S2h1?=
 =?utf-8?B?SnN1NzBDaTFYcWU5NG01OGg0em5SRlZSc1VDY3R5bFlueml0TG1GVGlDaEhD?=
 =?utf-8?B?L1U1dTlzZ1hGd3VKeUFvYmRqUENlbjJZU0ZFYWJ5b0FKVS91VE84QmEvV0ZU?=
 =?utf-8?B?YUFRd3pFWWN5SFp3Ry9DTWdoaU90REx2K1cwWGplZEV2aytldGI1MUtmYk9a?=
 =?utf-8?B?YW1qWHRLTkhrcFEyOFBlQkx5Uy9rdlhXUlFsZ3BnSUdNSVljTUJYY3NLVS8v?=
 =?utf-8?B?N3M2cnZmRUdra3FGUHRESG9TZURiN2lUWnNTb2U4ZnlXaVM0SE9pK05LcWRW?=
 =?utf-8?B?RFUrcGRvV2JkVWlUSFN4T0lvb3JYNjNrbmptNlJZUDlkVnNZREZNUVg2TTdn?=
 =?utf-8?B?dHBxamtmNjRhWDZuWlh1Skg5NUhOWFJPNlhoaWhuTkhneE9nUjJjazAzNXg4?=
 =?utf-8?B?eldITnQwMUJ3bVl0NmFuTnQ1b2NLZVlMUjgzQ1BqeVVBcHJTMW5FUkxWY1Bs?=
 =?utf-8?B?Rk5TYUlmczg2MGVEdFFSM0c4Q0hNbGs0MGhlMUJBelNiVXJRTHJoekJncnVB?=
 =?utf-8?B?ZG1QRmhhTTN1RGJ0WDRMNi80bW16UFNuRDI3clpMUzhPS0Q3TDlHejZLdEF6?=
 =?utf-8?B?OGh2K1lveTVoUDNGWUkvaW9HVmluOFRKUkVQelpYaStwYUpOU1RXSE82MCtZ?=
 =?utf-8?B?RnNOeDRBMzFlN2VrOHd3VnUvYkpmakN6OEtsNnJ1cktIY3ZPMFRzRmxuRlR1?=
 =?utf-8?B?QncyY3pSUmtRK09GcS9XaEF4WmNFUnpCV1Z3d3Y5RHBjSGZOc3JzaTZnY0hN?=
 =?utf-8?B?enl0UVhFaVR5cElQOUlIRHcvbEpKOFdTN1BJaDJKNURsSE5Na2VvM1RyaTZK?=
 =?utf-8?B?R3ROTWhoOUYrcDhFMzQ2eWVDWS9YL3gvcHpkT21aeFRMU0xmS3dCcUxUSHgz?=
 =?utf-8?B?czJKcVBvNEpGb2phUGZGS084di90WkdNbzZWNkFoZlpnRkw2THdhT1ZIbjZS?=
 =?utf-8?B?MjZ4bGd1akducmI2T3kwaW5pb0ZSbm9ENXE3Y2hOMkFMQndrTGFBNzhLc1Jx?=
 =?utf-8?B?bmF2Z3VMRnRFTVcyU080WHJVYy90aHFzbXpodCtjd3FDUUFDL0svUnZjZWw1?=
 =?utf-8?B?UXB2UllRWEdMNHh2bnlZSk5aQ2dTMTJVUGUzSHY5QS9LcW1HcEdUYjNLSGxr?=
 =?utf-8?B?UkYvVTU4SmhsTGp1NFFiT0tjeGt5ZnBkcTZIdnB0WmN3bmU4VGp5ZW1hNlIr?=
 =?utf-8?B?c2JucFFBWWhYQ2p1V01LUGhmRFNwemZWQ3h4SS9rMlF1SHhjbDhSUWZ6R0VC?=
 =?utf-8?B?a0k2QllGQzZSc000UVE0ZTM2OXBUVmNDb3o0Tm5BTXRuVHI3eGdHeU9jVWdQ?=
 =?utf-8?B?d1o0Y1dCYWlsZU5NOThuMW8yMGR5NTJrYVhTbkZCQTRHZFVreFN0NGtTZEtw?=
 =?utf-8?B?d3FZY3BqTnJuM1A1RnArcGFXQllUcXp6NXpMNmlrQmR4Zk1RUVpVUHJjWU51?=
 =?utf-8?B?QlQ4V2oxSnJCUjJWYjBxeVM5ZjZSODE5eWxmUE1qQXVOSktTYkg4WjR0enZv?=
 =?utf-8?B?Q3hUNnRJVWpUSkFBL1B2RlBubFkzK0UrMHA1S09tRWtCSzNmNE5naTZ2SEhD?=
 =?utf-8?B?cWhBZzMremp1Q1lYMmtSMFhNM3BrdEovZkQvNjBMbCsvbURwQVM3bHRNSnNo?=
 =?utf-8?B?Q29SZ05SZVFlSjVwY1p3dkhwRmNGOUNnOVFFTkFQRUk5NzJ3azFiYU9YUlla?=
 =?utf-8?B?c21GUkdMZUtGVGNNWXFIUStBRTgwaWVVbVBja3B0cUVxZUs5TXZKQVVXZW4z?=
 =?utf-8?B?b0VONjdHNG4wYmNZcEVpeHVVdWNxTmV1RmxhVWFmVmJKWTRYZ0l1TEtxUXRB?=
 =?utf-8?B?UkJGcCs1VTNDQ1Z6YjVIZC8yR2cyOUJvSGNEcnZkYXV3OXVzZ2paZWN6NTRZ?=
 =?utf-8?B?RDJqSTZIcnpjL0IveTNnV3hwa1BrM1drak9SeDIramtGVEJmanBaK2NJZDY0?=
 =?utf-8?B?eFRrK1NDNlFPZ0grQmN0VFJBY3E5ZEoycWlrUFdOV2YxTzIvY3lNMkx4WEZm?=
 =?utf-8?B?RGkwK1k1bzh3NmJmWVdDdzVRSWwvQXVrMHNQc2hjZ2hubnpSQjZmeDFOVzR2?=
 =?utf-8?Q?umdJinWCkIA/hCaKyZlgAJpBm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7046.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26933e1-c34d-4faa-5e0f-08dbbda9eb42
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 09:29:29.6910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gc5yN5+Ox8lD07JO+5JN2jubceoaMrjtgvI/DGdMDyg3fQdNSMoaE0Lis9TOSeIr1+FBMyBcGwolBN3n9ptrxWzbOPKA5KPFyxvLZH5H+z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5966
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91IGZvciB5b3VyIHJlcGx5IGZyb20gSmFnYW4gJiBPZGVkLg0KDQpJdCBpcyB2ZXJ5
IGFwcHJvcHJpdGF0ZSBmb3IgbXkgZHJpdmVyIHRvIGJlIHBsYWNlZCBpbiBkcml2ZXIvYWNjZWwu
DQoNCk15IGFjY2VsZXJhdG9yIGlzIG5hbWVkIEFETEEoQW1sb2dpYyBEZWVwIExlYXJuaW5nIEFj
Y2VsZXJhdG9yKS4NCkl0IGlzIGFuIElQIGluIFNPQyxtYWlubHkgdXNlZCBmb3IgbmV1cmFsIG5l
dHdvcmsgbW9kZWxzIGFjY2VsZXJhdGlvbi4NCkl0IHdpbGwgc3BsaXQgYW5kIGNvbXBpbGUgdGhl
IG5ldXJhbCBuZXR3b3JrIG1vZGVsIGludG8gYSBwcml2YXRlIGZvcm1hdCBjbWQgYnVmZmVyLA0K
YW5kIHN1Ym1pdCB0aGlzIGNtZCBidWZmZXIgdG8gQURMQSBoYXJkd2FyZS4gSXQgaXMgbm90IHBy
b2dyYW1tYWJsZSBkZXZpY2UuDQoNCkFETEEgaW5jbHVkZXMgZm91ciBoYXJkd2FyZSBlbmdpbmVz
Og0KUlMgZW5naW5lcyAgICAgICAgICAgICA6IHdvcmtpbmcgZm9yIHRoZSByZXNoYXBlIG9wZXJh
dG9ycw0KTUFDIGVuZ2luZXMgICAgICAgICA6IHdvcmtpbmcgZm9yIHRoZSBjb252b2x1dGlvbiBv
cGVyYXRvcnMNCkRXIGVuZ2luZXMgICAgICAgICAgIDogd29ya2luZyBmb3IgdGhlIHBsYW5lciAm
IEVsZW1lbnR3aXNlIG9wZXJhdG9ycw0KQWN0aXZhdGlvbiBlbmdpbmVzIDogd29ya2luZyBmb3Ig
YWN0aXZhdGlvbiBvcGVyYXRvcnMoUmVMdSx0YW5oLi4pDQoNCkJ5IHRoZSB3YXksIG15IElQIGlz
IG1haW5seSB1c2VkIGZvciBTT0MsIGFuZCB0aGUgY3VycmVudCBkcml2ZXIgcmVnaXN0cmF0aW9u
IGlzIHRocm91Z2ggdGhlIHBsYXRmb3JtX2RyaXZlciwNCmlzIGl0IG5lY2Vzc2FyeSB0byBzd2l0
Y2ggdG8gZHJtPw0KDQp0aGFua3MuDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NCuWPkeS7tuS6ujogT2RlZCBHYWJiYXkgPG9nYWJiYXlAa2VybmVsLm9yZz4NCuWP
kemAgeaXtumXtDogMjAyM+W5tDnmnIgyMuaXpSAyMzowOA0K5pS25Lu25Lq6OiBKYWdhbiBUZWtp
DQrmioTpgIE6IENhbmNhbiBDaGFuZzsgbGludXgtbWVkaWE7IGxpbnV4LWtlcm5lbDsgRGF2ZSBB
aXJsaWU7IERhbmllbCBWZXR0ZXINCuS4u+mimDogUmU6IGtlcm5lbC5vcmcgNi41LjQgLCBOUFUg
ZHJpdmVyLCAtLW5vdCBzdXBwb3J0IChSRkMpDQoNClvkvaDpgJrluLjkuI3kvJrmlLbliLDmnaXo
h6ogb2dhYmJheUBrZXJuZWwub3JnIOeahOeUteWtkOmCruS7tuOAguivt+iuv+mXriBodHRwczov
L2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb27vvIzku6Xkuobop6Pov5nkuIDn
grnkuLrku4DkuYjlvojph43opoFdDQoNClsgRVhURVJOQUwgRU1BSUwgXQ0KDQpPbiBGcmksIFNl
cCAyMiwgMjAyMyBhdCAxMjozOOKAr1BNIEphZ2FuIFRla2kgPGphZ2FuQGVkZ2VibGUuYWk+IHdy
b3RlOg0KPg0KPiBPbiBGcmksIDIyIFNlcHQgMjAyMyBhdCAxNTowNCwgQ2FuY2FuIENoYW5nIDxD
YW5jYW4uQ2hhbmdAYW1sb2dpYy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRGVhciBNZWRpYSBNYWlu
dGFpbmVyczoNCj4gPiAgICAgIFRoYW5rcyBmb3IgeW91ciBhdHRlbnRpb24uIEJlZm9yZSBkZXNj
cmliaW5nIG15IHByb2JsZW3vvIxsZXQgbWUgaW50cm9kdWNlIHRvIHlvdSB3aGF0IEkgIG1lYW4g
YnkgTlBVLg0KPiA+ICAgICAgTlBVIGlzIE5ldXJhbCBQcm9jZXNzaW5nIFVuaXQsIEl0IGlzIGRl
c2lnbmVkIGZvciBkZWVwIGxlYXJuaW5nIGFjY2VsZXJhdGlvbiwgSXQgaXMgYWxzbyBjYWxsZWQg
VFBVLCBBUFUgLi4NCj4gPg0KPiA+ICAgICAgVGhlIHJlYWwgcHJvYmxlbXM6DQo+ID4gICAgICAg
V2hlbiBJIHdhcyBhYm91dCB0byB1cHN0cmVhbSBteSBOUFUgZHJpdmVyIGNvZGVzIHRvIGxpbnV4
IG1haW5saW5lLCBpIG1lZXQgdHdvIHByb2JsZW1zOg0KPiA+ICAgICAgICAgMS4gIEFjY29yZGlu
ZyB0byBteSByZXNlYXJjaCwgVGhlcmUgaXMgbm8gTlBVIG1vZHVsZSBwYXRoIGluIHRoZSBsaW51
eCAoYmFzZSBvbiBsaW51eCA2LjUuNCkgLCBJIGhhdmUgc2VhcmNoZWQgYWxsIGxpbnV4IHByb2pl
Y3RzIGFuZCBmb3VuZCBubyBvcmdhbml6YXRpb24gb3IgY29tYW55IHRoYXQgaGFzIHN1Ym1pdHRl
ZCBOUFUgY29kZS4gSXMgdGhlcmUgYSBwYXRoIHByZXBhcmVkIGZvciBOUFUgZHJpdmVyIGN1cnJl
bnRseT8NCj4gPiAgICAgICAgIDIuICAgSWYgdGhlcmUgaXMgbm8gTlBVIGRyaXZlciBwYXRoIGN1
cnJlbnRseSwgSSBhbSBnb2luZyB0byBwdXQgbXkgTlBVIGRyaXZlciBjb2RlIGluIHRoZSBkcml2
ZXJzL21lZGlhL3BsYXRmb3JtL2FtbG9naWMvIO+7vywgYmVjYXVzZSBteSBOUFUgZHJpdmVyIGJl
bG9uZ3MgdG8gYW1sb2dpYy4gYW5kIGFtbG9naWMgTlBVIGlzIG1haW5seSB1c2VkIGZvciBBSSB2
aXNpb24gYXBwbGljYXRpb25zLiBJcyB0aGlzIHBsYW4gc3VpdGFiZSBmb3IgeW91Pw0KPg0KPiBJ
ZiBJJ20gY29ycmVjdCBhYm91dCB0aGUgZGlzY3Vzc2lvbiB3aXRoIE9kZWQgR2FiYnkgYmVmb3Jl
LiBJIHRoaW5rDQo+IHRoZSBkcml2ZXJzL2FjY2VsLyBpcyBwcm9wZXIgZm9yIEFJIEFjY2VsZXJh
dG9ycyBpbmNsdWRpbmcgTlBVLg0KPg0KPiArIE9kZWQgaW4gY2FzZSBoZSBjYW4gY29tbWVudC4N
Cj4NCj4gVGhhbmtzLA0KPiBKYWdhbi4NClRoYW5rcyBKYWdhbiBmb3IgYWRkaW5nIG1lIHRvIHRo
aXMgdGhyZWFkLiBBZGRpbmcgRGF2ZSAmIERhbmllbCBhcyB3ZWxsLg0KDQpJbmRlZWQsIHRoZSBk
cml2ZXJzL2FjY2VsIGlzIHRoZSBwbGFjZSBmb3IgQWNjZWxlcmF0b3JzLCBtYWlubHkgZm9yDQpB
SS9EZWVwLUxlYXJuaW5nIGFjY2VsZXJhdG9ycy4NCldlIGN1cnJlbnRseSBoYXZlIDMgZHJpdmVy
cyB0aGVyZSBhbHJlYWR5Lg0KDQpUaGUgYWNjZWwgc3Vic3lzdGVtIGlzIHBhcnQgb2YgdGhlIGxh
cmdlciBkcm0gc3Vic3lzdGVtLiBCYXNpY2FsbHksIHRvDQpnZXQgaW50byBhY2NlbCwgeW91IG5l
ZWQgdG8gaW50ZWdyYXRlIHlvdXIgZHJpdmVyIHdpdGggdGhlIGRybSBhdCB0aGUNCmJhc2ljIGxl
dmVsIChyZWdpc3RlcmluZyBhIGRldmljZSwgaG9va2luZyB1cCB3aXRoIHRoZSBwcm9wZXINCmNh
bGxiYWNrcykuIG9mYyB0aGUgbW9yZSB5b3UgdXNlIGNvZGUgZnJvbSBkcm0sIHRoZSBiZXR0ZXIu
DQpZb3UgY2FuIHRha2UgYSBsb29rIGF0IHRoZSBkcml2ZXJzIHVuZGVyIGFjY2VsIGZvciBzb21l
IGV4YW1wbGVzIG9uDQpob3cgdG8gZG8gdGhhdC4NCg0KQ291bGQgeW91IHBsZWFzZSBkZXNjcmli
ZSBpbiBhIGNvdXBsZSBvZiBzZW50ZW5jZXMgd2hhdCB5b3VyDQphY2NlbGVyYXRvciBkb2VzLCB3
aGljaCBlbmdpbmVzIGl0IGNvbnRhaW5zLCBob3cgeW91IHByb2dyYW0gaXQuIGkuZS4NCklzIGl0
IGEgZml4ZWQtZnVuY3Rpb24gZGV2aWNlIHdoZXJlIHlvdSB3cml0ZSB0byBhIGNvdXBsZSBvZiBy
ZWdpc3RlcnMNCnRvIGV4ZWN1dGUgd29ya2xvYWRzLCBvciBpcyBpdCBhIGZ1bGx5IHByb2dyYW1t
YWJsZSBkZXZpY2Ugd2hlcmUgeW91DQpsb2FkIGNvbXBpbGVkIGNvZGUgaW50byBpdCAoR1BVIHN0
eWxlKSA/DQoNCkZvciBiZXR0ZXIgYmFja2dyb3VuZCBvbiB0aGUgYWNjZWwgc3Vic3lzdGVtLCBw
bGVhc2UgcmVhZCB0aGUgZm9sbG93aW5nOg0KaHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcvYWNjZWwv
aW50cm9kdWN0aW9uLmh0bWwNClRoaXMgaW50cm9kdWN0aW9uIGFsc28gY29udGFpbnMgbGlua3Mg
dG8gb3RoZXIgaW1wb3J0YW50IGVtYWlsIHRocmVhZHMNCmFuZCB0byBEYXZlIEFpcmxpZSdzIEJP
RiBzdW1tYXJ5IGluIExQQzIwMjIuDQoNClRoYW5rcywNCk9kZWQNCg==
