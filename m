Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0827DE22E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 15:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344269AbjKAOJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjKAOJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:09:50 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA12F83;
        Wed,  1 Nov 2023 07:09:44 -0700 (PDT)
Received: from pps.filterd (m0174676.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1BWboW005768;
        Wed, 1 Nov 2023 14:09:24 GMT
Received: from eur02-vi1-obe.outbound.protection.outlook.com (mail-vi1eur02lp2040.outbound.protection.outlook.com [104.47.11.40])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3u3nw0ggeg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 14:09:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOdzHbpSUEBYESD3pbHv2ozZM9nZOnYOBu1oWdP0b/QM9XnyckTcmJb9I5fkcc7Dr9Mcz3eiVm6rzXH9/k3fPEcwGyZC3SQaFfYxRxThetCJAnxNv/w5VY44dTxm9lhRA5QemxomItLc7mjU8f822GFnHieL0FJ7/VdeHZWOvDsavVkMGA6K9aY4Jc/xcDKFMlVFDbGN6u6LIVFTvLbt46oB0hrA7nGQr0+oMaxGWYK0551ysJdlN5k8Ej35PMcXVlDLibQPzdOKqnd0mEDn7NpTH4ScK2bxArODgKic8KBuZjA/hOI5OHwxPtL6s6UHNzNaMmqfo03Brq9AZJBYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtkpp/q+9AcsV5T0/CoEMQssuWn9Za+/KyN/EdnQf7g=;
 b=EIeGboHwOfr9xm16hyULhjpBl/Z+ulLOyU1wS8pRw/daAuoQkEITJ37sHIuySyWp0CBQ4+FRaUUcPUodP8xVAw/6NYr7bAECxpHRhxb8M4TGi6CHO++2hEf+NGWQHkDdIKeX+4JeTFE5IIVChRMr2mc+ZpM5F+OVFb2Vug1wX7mS6Avl5Wkye83dJIUAruqQbVbbI5qWOjc8ATwpt63dRf2/cI/TyGfXUWZT4+NvrWIgZfuhdj3xJOdpe2LkqGwMD4xdTSIHRH4tZJKhMFdqrRpymNUpw1Q550IsndW/RYEI1TIqhVTIZyI2j5hB75uhQvoh+whmIw3kCZrIA3lMWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtkpp/q+9AcsV5T0/CoEMQssuWn9Za+/KyN/EdnQf7g=;
 b=BFU05VfT86k2tb329iELxb6DAJS0dbMp0dpQmPYG+8LFbCrLzBOUkM5l0xt0VOKexNilZj6TQfLzZ25ErYBn3SbClZhZWHEgz/qXz/HO9qrOh2QWN8Nz8/x1igisGVmi4uvFHnumL4YVE2LqyGImsem+QFMowSPgxaSkpL2ZhJIs+z8rzRb2aj8y/I3r6NOfkAeBJbYJ+qGuD28FAG2Hv+qlDUe5nPN8glCq1wPEU9E6NvMTSD09iSmaaGB872ZvVAsip4N3iUATzU8ebNqtfGMwdKjXitGoSwkDPCnuvuYtyH2u8hsJE5pbZAgqKcLHhzRivZLc5WXkeC/eKYKx1Q==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by GV2PR03MB8584.eurprd03.prod.outlook.com (2603:10a6:150:79::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Wed, 1 Nov
 2023 14:09:02 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::2211:9053:228e:4e40]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::2211:9053:228e:4e40%3]) with mapi id 15.20.6933.022; Wed, 1 Nov 2023
 14:09:02 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [RFC v5 5/5] dt-bindings: firmware: arm,scmi: Add support for
 pinctrl protocol
Thread-Topic: [RFC v5 5/5] dt-bindings: firmware: arm,scmi: Add support for
 pinctrl protocol
Thread-Index: AQHaCJ7CNWHZc0R0IUas1KWQRTDeQ7BdVa8AgAgy8QA=
Date:   Wed, 1 Nov 2023 14:09:02 +0000
Message-ID: <d8214641-1762-4cb5-81cc-e6e2c1a8c887@epam.com>
References: <cover.1698353854.git.oleksii_moisieiev@epam.com>
 <e9285b4377242e4d888391be987cbb99caf8c573.1698353854.git.oleksii_moisieiev@epam.com>
 <0ce0c283-3c1c-4dbe-8b0c-ff2e2d5420c9@linaro.org>
In-Reply-To: <0ce0c283-3c1c-4dbe-8b0c-ff2e2d5420c9@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|GV2PR03MB8584:EE_
x-ms-office365-filtering-correlation-id: 4d033cfb-6032-4363-7ff2-08dbdae419dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DcOPYFYGL3l1m7F+aMkLDXmT17YxR815Fl2U6p7or52bjdlg2jxQ0Fy/+jJ7iHhAWew3dc5vC2xSckKe//KDZYwsfmOhufwMVWd5Smpr0UNT2tzv/hj2O0PN0IZ2EvWYxQzFyGGGvDgL9ukIkmhBUqc4G8pNlZR+vq69itoxZjuVE5wy3vNvBDJLCJkReElkv6RAUK6w34lBUE7kIa8owpLwPcUdqeIn/msS6OY7qswYdXRrFzay3v6vf43UYXHJ3y89jM5P/R8YZYpF6D2a5+cVKLrhS/RTKtv0OnHilcS10NPxHwgrKkDNpBMjAVQnuoSJUgCgVghn1fMmm8lCKnfbbt5lrTAdO0SFOg5qJornZzcejj3SNtiZ0T76PlLhm3tbTXenscljc2Ga8qZ1BSBEWXCdjs6nGgyM5ALFqNh5HZFh4Bb2xxipCCm8LCmT09ksRF92N4iASOumENenqYLd1JL5zkJ4CdAUoGyibmJRI32JLK7zUNULpHaTQqzqy4/sfZUAfweoRv6ptopJ7zVsbXYt56h9M8LWsy0u3nCRagWIWjEYr6i0mZSQC81PLACMP+KE/jLUY2wXFusiT84JCJDe6Ol+1xZofKRKG8ZjruR3Go+zmHOoWqGioHARuuGuwa5or32bAFGc3GcI6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(366004)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(6512007)(2616005)(55236004)(71200400001)(478600001)(6486002)(4326008)(91956017)(83380400001)(7416002)(2906002)(5660300002)(66446008)(8676002)(110136005)(76116006)(41300700001)(6506007)(66946007)(54906003)(53546011)(66556008)(316002)(8936002)(66476007)(64756008)(38070700009)(38100700002)(31696002)(122000001)(36756003)(86362001)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekxpeHhjRXM1SGYrQUpQZnl4QTQ1TWdBN011Y012cndib2RMZGVHSkV6cFYr?=
 =?utf-8?B?Vi9YMUdVWDBqaTZTQ3IwNmNrR0RXa0h1eVhYWGxBeWNWdm11dW1XQWxjcGlh?=
 =?utf-8?B?ekFjV09YMUdKaG9OQlBGY0kxZkhmSy83ZkxSY3lhbC9ScUk5T0owVldPRW1T?=
 =?utf-8?B?TUJoS0wyM0RlRjNraXpBWWx1bE5pY3JtZjRvNG5pVDkzckFHRUpKSk9Gb3FN?=
 =?utf-8?B?TEE4QWxjcHRVOXoxYmVVNHFoc0Uvc1BIUGI3c3dBZ1FDMVY2eEwzbmZTTHAx?=
 =?utf-8?B?WmNLbTBGOUdFVmo2SUNmS3QzWGQrUVprbmtFRHJUTTlrZTg1bW1PdFZvVnRt?=
 =?utf-8?B?c1I5WlhvVVdCZytRNWlmZTIrYjJPSXRjTmIvK3pIUHpVa2hIalByUTl6MVBk?=
 =?utf-8?B?QzZwUEs1bElNTzZhMi9iaEhFNDJCS3hYL21DNzdmS1cwMEhNTVNoL25RTXlY?=
 =?utf-8?B?eHp3UnRNZVBYdStUU0IwVEJZMEgxN3FJcWN0ZjM5dmlpWGNmOGgzcDdET3d5?=
 =?utf-8?B?WmZTaGFydDRoS0RvUVZZdjl0Z3RKdWswUXF0SVBmVHg4c284d3BqYURGMklr?=
 =?utf-8?B?Mk9UVzVSTi9rbDNTT09NYWlyd1hsdXZVNGVOOGtOT2VZQW9QY0NuYnhxSk81?=
 =?utf-8?B?WUwvc1haQ3FIdDd5ZzI3RnEyMk51cW1GblJQVGF5V1pqYTlIS1FUVFdwQWdG?=
 =?utf-8?B?Zkt1TE01aDNqWnR0TlZtQkRFeXVvT3VBSjRscTlKcTFlQUF1Q3c5N1VhSUxJ?=
 =?utf-8?B?NXF5RGZMcDgvc1MvbjVBZ1VxM0tvNk1pbjhuYjMxMzRnZCtpL2NDcDMrWEcx?=
 =?utf-8?B?N1ZJa2J3WHcreVN4N0lkWFpZT3BjV29yRnNlWlFwQW9TVmZqZGd0cmN3S29X?=
 =?utf-8?B?RHVoUDJPSXN4K2RWd1FKZUVrOUZBS0gxVVVQcEp5MTR4a0YrYmhwc3VpbnVO?=
 =?utf-8?B?RmdROWVSY3NPTnRlNjlMaU5MWG1PTTFiK0VGUGZ4dVViQmIwajBPY0Y3SmRL?=
 =?utf-8?B?ajNYelE5VWNSNXdNN09VSkw0UVZlOFhxdzBjNGphV2Jud09XU3hiM1dxQS9a?=
 =?utf-8?B?OGdUalFqaURXMGhGM0RmZStWWjJBSnBVdE9ZOXloZmxFREtTalk4R3FKNFN4?=
 =?utf-8?B?Z1dnWGJXM0M0TDJBWW1RUUdHbnFab3VaZUMwVlJRd2FzZ3R5TCtnOG91RVls?=
 =?utf-8?B?cEs1ZkM3ZGZiczdFK0lhME1zd1pBTW1VeUdFZjl1bTBQL21yQ0NxbWJBNXZP?=
 =?utf-8?B?MVg1ZXRZRTFpRk1sM0hDeVB1bEJrdHphYWcrK1FHejdOMDFFN3RlNDRKYUpp?=
 =?utf-8?B?REdMeHdMSWw1VDBCTFlabDlSWDJjS28wdk42RXFPaWIydTFGVGpncUI0Y2ZS?=
 =?utf-8?B?R1F0RmI3K3JMUmhJNkFqS1RWZG9oRHNQakcxZlJxcHM0endGd2JweGtFeVdB?=
 =?utf-8?B?NEpsdWlJVDljaVEyY1hDZ1ZDZnRHbVA0enhBUGljRGZDR054QjBMQTJSNW5o?=
 =?utf-8?B?Z25IeGlNVWdtcHd0djBjcVVzTWNUNEhvVk1YSTBsT3paQ2lobW9ReWEyd0h1?=
 =?utf-8?B?SldkNWY5R1JFdlhRN0xXNGVyWFgxNkV3Q09uRUVnZnJLWitkcXQvcGIwc0FT?=
 =?utf-8?B?c3V3VWg1Q3FXdlo4bGlVZERGZ25KeENGZjFWOXlhZXRFMWhaM2ZiOWM5ZExh?=
 =?utf-8?B?a0NBSmQrRGRYZ3NzWTZHY29FaG1aVXFCdFVwWUJFYTVud1JYdVNFMWNuKzB6?=
 =?utf-8?B?UEtnU2U1ME5iQW13UjkrR2EzaS9QaG9ock0wc1lrSVJmREs2L3cvd2YyY2Uw?=
 =?utf-8?B?c3E1OHZWM2U5WHVQTVFVQk5yN1Erc3pWWUliNkRhZXJTS0c5akI2VmtrMWxU?=
 =?utf-8?B?eWNkTUlLeC9MTHVBM1UyOU5EWDVRTzJmM2FoZlNhQUU5RTFpRFNpeGtldUxL?=
 =?utf-8?B?Rlpubk11WEJmNEhIZXZyOG5WeGtuQmovVmJWZFVyRUtuTEp4bVpmOThwWUhQ?=
 =?utf-8?B?VlJuUE92N0VRbW1DOU5rd0FQSFlTV2FnT3o5aVk1OE12RTJlWk4xamNHOGZT?=
 =?utf-8?B?R09SZlRlU09uWFNLWVBvM1FERmJwc3N1MUV0MFpmUEorcDdGODl0Z3ptWVBY?=
 =?utf-8?B?aU1tanQrbHNmUzhpYXZGK1BibEQxbGVDRCtKQzZGN0FIejN1SjNWZDllUWdj?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC1D4B1A08764F4E817454EB0AE0A7E9@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d033cfb-6032-4363-7ff2-08dbdae419dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 14:09:02.3927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f7Rvsat18MgiKhhboSMHrZUe7U6GtorC+vRNBimDXpHy9683/ILBlj1QvohoI/pQmi87ptwkAxXsRmwmfZjCYFUssFzY4jkbWDppdd3Lxkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8584
X-Proofpoint-GUID: fx4a8d-2NqLEOK81gI_ilWOLDHff0jun
X-Proofpoint-ORIG-GUID: fx4a8d-2NqLEOK81gI_ilWOLDHff0jun
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_12,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010119
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDI3LjEwLjIzIDExOjU2LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBPbiAy
Ny8xMC8yMDIzIDA4OjI4LCBPbGVrc2lpIE1vaXNpZWlldiB3cm90ZToNCj4+IEFkZCBuZXcgU0NN
SSB2My4yIHBpbmN0cmwgcHJvdG9jb2wgYmluZGluZ3MgZGVmaW5pdGlvbnMgYW5kIGV4YW1wbGUu
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogT2xla3NpaSBNb2lzaWVpZXYgPG9sZWtzaWlfbW9pc2ll
aWV2QGVwYW0uY29tPg0KPj4NCj4+IC0tLQ0KPj4gQ2hhbmdlcyB2MyAtPiB2NA0KPj4gICAgLSBy
ZXdvcmtlZCBwcm90b2NvbEAxOSBmb3JtYXQNCj4+IC0tLQ0KPj4gICAuLi4vYmluZGluZ3MvZmly
bXdhcmUvYXJtLHNjbWkueWFtbCAgICAgICAgICAgfCA1MyArKysrKysrKysrKysrKysrKysrDQo+
PiAgIDEgZmlsZSBjaGFuZ2VkLCA1MyBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9maXJtd2FyZS9hcm0sc2NtaS55YW1s
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Zpcm13YXJlL2FybSxzY21pLnlh
bWwNCj4+IGluZGV4IDU4MjRjNDNlOTg5My4uNTMxOGZlNzIzNTRlIDEwMDY0NA0KPj4gLS0tIGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Zpcm13YXJlL2FybSxzY21pLnlhbWwN
Cj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9maXJtd2FyZS9hcm0s
c2NtaS55YW1sDQo+PiBAQCAtMjMzLDYgKzIzMywzOSBAQCBwcm9wZXJ0aWVzOg0KPj4gICAgICAg
ICByZWc6DQo+PiAgICAgICAgICAgY29uc3Q6IDB4MTgNCj4+ICAgDQo+PiArICBwcm90b2NvbEAx
OToNCj4+ICsgICAgdHlwZTogb2JqZWN0DQo+PiArICAgIGFsbE9mOg0KPj4gKyAgICAgIC0gJHJl
ZjogIiMvJGRlZnMvcHJvdG9jb2wtbm9kZSINCj4+ICsgICAgICAtICRyZWY6ICIuLi9waW5jdHJs
L3BpbmN0cmwueWFtbCINCj4gDQo+IFRoaXMgaXMgYSBmcmllbmRseSByZW1pbmRlciBkdXJpbmcg
dGhlIHJldmlldyBwcm9jZXNzLg0KPiANCj4gSXQgc2VlbXMgbXkgcHJldmlvdXMgY29tbWVudHMg
d2VyZSBub3QgZnVsbHkgYWRkcmVzc2VkLiBNYXliZSBteQ0KPiBmZWVkYmFjayBnb3QgbG9zdCBi
ZXR3ZWVuIHRoZSBxdW90ZXMsIG1heWJlIHlvdSBqdXN0IGZvcmdvdCB0byBhcHBseSBpdC4NCj4g
UGxlYXNlIGdvIGJhY2sgdG8gdGhlIHByZXZpb3VzIGRpc2N1c3Npb24gYW5kIGVpdGhlciBpbXBs
ZW1lbnQgYWxsDQo+IHJlcXVlc3RlZCBjaGFuZ2VzIG9yIGtlZXAgZGlzY3Vzc2luZyB0aGVtLg0K
PiANCj4gVGhhbmsgeW91Lg0KDQoNCkhpIEtyenlzenRvZiwNCg0KSSdtIHNvcnJ5IGZvciB0aGUg
aW5jb252ZW5pZW5jZS4NClRoZSBpbnRlbnRpb24gYmVoaW5kIHNoYXJpbmcgdGhpcyBSRkMgd2Fz
IHRvIGluaXRpYXRlIHRoZSByZXZpZXcgcHJvY2VzcyANCmZvciB0aGUgY2hhbmdlcyBJJ3ZlIGJl
ZW4gbWFraW5nIHRvIHRoZSBwaW5jdHJsIGRyaXZlciwgYWxpZ25pbmcgaXQgd2l0aCANCnRoZSB1
cGRhdGVzIGluIHRoZSBERU4wMDU2RSBiZXRhMiBkb2N1bWVudC4NCg0KSSBhbSBzdGlsbCBhY3Rp
dmVseSB3b3JraW5nIG9uIHRoZXNlIGNoYW5nZXMsIGFuZCBJIGZ1bGx5IGludGVuZCB0byANCmFk
ZHJlc3MgYW5kIHJlc29sdmUgdGhlIGJpbmRpbmcgaXNzdWVzIGFuZCBhbGwgcHJldmlvdXNseSBt
ZW50aW9uZWQgDQpjb21tZW50cyBpbiB0aGUgZmluYWwgdjUgcGF0Y2ggc2VyaWVzLg0KDQpCZXN0
IHJlZ2FyZHMsDQpPbGVrc2lpLg0KDQo+IA0KPiBJdCBkb2VzIG5vdCBsb29rIGxpa2UgeW91IHRl
c3RlZCB0aGUgYmluZGluZ3MsIGF0IGxlYXN0IGFmdGVyIHF1aWNrDQo+IGxvb2suIFBsZWFzZSBy
dW4gYG1ha2UgZHRfYmluZGluZ19jaGVja2AgKHNlZQ0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvd3JpdGluZy1zY2hlbWEucnN0IGZvciBpbnN0cnVjdGlvbnMpLg0KPiBNYXli
ZSB5b3UgbmVlZCB0byB1cGRhdGUgeW91ciBkdHNjaGVtYSBhbmQgeWFtbGxpbnQuDQo+IA0KPiAN
Cj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4g
