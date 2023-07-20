Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C6675B613
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjGTSEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjGTSEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:04:00 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD9C2709;
        Thu, 20 Jul 2023 11:03:59 -0700 (PDT)
Received: from pps.filterd (m0174676.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KEuUZU032015;
        Thu, 20 Jul 2023 18:03:47 GMT
Received: from eur03-vi1-obe.outbound.protection.outlook.com (mail-vi1eur03lp2104.outbound.protection.outlook.com [104.47.30.104])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3rxgcw5jj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 18:03:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltnROa3M0M4rDhtkCVuQyDpiXHdZgUbGdmfBZuU/TuFSQQ8eLtdZgXjvU3oHoNfUqkcnY5HknmkNp6P9LoTFZeItgjD1O/WcJbDGgK5gc1gNVY9vPxRpeGGqISAEHRUcOnYcFXB9D3huLUKVdrJ1+IA5vnSiroaQhrnpOQTlUJI+GrV6H+c5FqR5IfH3iDFoZSdKCEceRYIj6nnFvPMS21HbfsXGy761ngM88MpviYAwK2y16RFc4TFuUABpi8aPfZgb5s3jCh/N7cXSAAR2sLapCSHO79d4uV+yC6IEhYAWFQs+vFOdgLi/UasOV+yas4rMVP2MrmAlsRQL0779Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/H2zFeIYSVRE8Mja27n9ia9I7WaW3rNC1HnbQZqmwk=;
 b=lfZO4XR+Q5Jx5anLU8GEHg6nkws6Ny/gVbmv5J2mFM0E/LmRCWlcuuFmqyORtTKfpAoxKIJXSckkSpLLlvxSFpph/ZJz46K7V/bf8SgZwcxz8yZ9oVjnfM8O37L9iRiTONKq1illkgFGAsAYqTKWCSTQiSFns76KzELk5mfIGb9ZuI8oTepDH4BzOmjmjDTRY87Pmx4FvIsmAOLkskvuDKA7JrDEMMlw1KCeHUXKB0JAs68ZeCTuog0XvAarnnFltrLbuc1wqV807lZwfAC1pIPYj5+DKpVEdr1tDgorAEDxmsUojkhdICPsjqyZLrjpftCZ9B2+jV6l47Iao1SUSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/H2zFeIYSVRE8Mja27n9ia9I7WaW3rNC1HnbQZqmwk=;
 b=HYXEQc62i/PuFbJrMiZ0qrvc7pDpA8uJhMRUnxvLJzjp5W4or3Sf1nzVxj4zCMgjcqyBwYI0V27xzE+IO5zCyEdP4UTS5mXSyHiMT3gg4VGUeWrZTBNcjksWJBvyvM9Myr0qmV6Byw8Hbs0EXn4WEQAW8hVJcdCvEUvY8xGZ0ykWhauz2Nm1+QfG+LcQbmH2B+t0k/7AQySPoPxWiYqR9C8UjK/LX09a9s0NYGJunCOeqLAgXPAFvM5sUGfy9kgfZfoZ6p26Y4tDZBX+P0XE5qd5yotrggLiWzMf7gf1R5jXYnwKW94/GueJ822wfLQlDNbANwnztIfWZXAoh0HDvg==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by AM9PR03MB7428.eurprd03.prod.outlook.com (2603:10a6:20b:264::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Thu, 20 Jul
 2023 18:03:41 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::ccb5:5aee:f10d:ab26]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::ccb5:5aee:f10d:ab26%4]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 18:03:40 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Thread-Topic: [PATCH v3 3/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Thread-Index: AQHZmJMWFmItseqHB0qRWKbh+9Pp/K9+8aOAgEPuLACAADi0gIAAE8+A
Date:   Thu, 20 Jul 2023 18:03:40 +0000
Message-ID: <87o7k6h344.fsf@epam.com>
References: <cover.1686063941.git.oleksii_moisieiev@epam.com>
 <43109a0f2f362222fca79e2afd15c46ed9a32977.1686063941.git.oleksii_moisieiev@epam.com>
 <ZIAxLdexyKBnMOmU@surfacebook> <87sf9ihfc7.fsf@epam.com>
 <CAHp75Vf+H_wnhT=2w=A9M7wFeOkf_m1M1gmL9vd8WHNid7+YBg@mail.gmail.com>
In-Reply-To: <CAHp75Vf+H_wnhT=2w=A9M7wFeOkf_m1M1gmL9vd8WHNid7+YBg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|AM9PR03MB7428:EE_
x-ms-office365-filtering-correlation-id: b2b1ff31-58c7-4fd8-5d0c-08db894ba63d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: reDhBhwRrzANqoa7TxTccP1bV25l4/jPWAfY5yIeY2vosS6YHKU/UOBgXc5E0ObAOeTHUNANHzRyS+n8bNGb6En594xDJdV9kYMsca/j6dbef/K0zh52qmQnu+ZR0SDAO1pZ3wGi8wW+56qlXXElIFhFrEMKDD6vRLWiClygJTUST+0d0o00cCfuNgXc5jW+BSZjoF2REqWtHLVMoym25bj0bNGwYDNtz3jp6NIAk94RXIkbVT9h7ZwUgfQe9WtoPjdJXhgdakCSifqfkTaKyMzVwi2grSzu634aFQG2wFxzkG29EKo+umnkAYU30Wj9I2qLlHbUGyUWV81C1E1Z5wnr/Q02zjBRtDwJ0BrAP/3hMPqZVK2xAc3dr/YvWassmb1nFSSwbvBSQLU43fl+jrLgOWfxXgRcWsunOcl/6kM8D7Lhx5brOm/7dRqiN1t8TrsrC0gGnqWJiw1cUoRbTZ/8UBAVh2r4pZ5gXSTQYFI7hHA2UEFPe5qolA/KQ8UO76hp4LJBxvR56PrKXb6pk3tVvoqfouXp1ezaaJRCm64xK/sCO7Smq7AkaQQAXmyfQhVmgXy6fYwCKw+0rxMHNBtyqb7fDl2Y+4qRx8qZpAUs2AJvFCYsIKck4IPJ0xUIA7+TvRVghUii3qPtNBEo4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199021)(316002)(64756008)(2616005)(4326008)(6916009)(66446008)(41300700001)(66476007)(66556008)(54906003)(6512007)(6486002)(478600001)(71200400001)(91956017)(66946007)(186003)(76116006)(53546011)(26005)(6506007)(86362001)(2906002)(36756003)(5660300002)(122000001)(8676002)(8936002)(38070700005)(38100700002)(7416002)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFhPWTIrT3RJQmczN1QwUWJ3VlBWWXF5Vlk2QlFITXBUMUhSUEZmN21NajR3?=
 =?utf-8?B?aW1FYVlCY2dsUEFBcXROKytjbXVRekhlLzIydzg3Z1dVMll2Q1pyblNneVlE?=
 =?utf-8?B?elVmeTg0RjZCaTFRM2ExcnJXdk12V05FNUxZeUx3SUlpSnlyVnVna29xMWNW?=
 =?utf-8?B?S1N3K1djbkU4VWdpb3VVUjhJa3VtZEpHN1R1bU5jRjFHQnlXNmZHamJHVVdp?=
 =?utf-8?B?elJBQWlOcXdyZVh5aHJGZnpxbEF5djRGY0g1eEtRM045elNWUXhFNGV3RUpp?=
 =?utf-8?B?N3ZGcEE1RmU5NDNoUElpVUhHWVppY3lGZGg0eWo5OUh0YjdwL3hKODIxc25F?=
 =?utf-8?B?Z0xzZ1M3bXFwd2RnQTdTOWxNY1UrTjhrRHM2VUszUlI5TlN0YlVQeGRIWnM1?=
 =?utf-8?B?K013TUh3Z3ZkRFVQVGYzQm9MTG83d255NmpVenVGbHNHZGRabXF0RGVIcmVY?=
 =?utf-8?B?OC9rZkQybFVISHpkVGFHUzIraVVpajcyQXB5ellFTVdoWStpYTB3bVFCeG1U?=
 =?utf-8?B?andYWmxpZWVUZHorL3Q3WERKWGs1RWlDdzExRVB2NERVRXhNT2xYUk0yQlFz?=
 =?utf-8?B?ak9NZEQ2Y0k0SzJFbGJPK0g5bnY4YmJ1LzZnTXpVeDFncEVQK1h4QjB6ZmJJ?=
 =?utf-8?B?b3dHR0ZGK2tFZUpqcG1UQzIzdTBvOTMrakRzeTBGSFBtQkF0VFVPVjhINElM?=
 =?utf-8?B?Nk9HcFdsKzNUSnN3RlE1WTRla1dxaGdvZU8zRlUxcW5TUHhRbHRxNVFSVEEw?=
 =?utf-8?B?RFppVy9HdW5XWmVCY01HK01LczlXQjdIMVdNTWlkT1lrQnkrZjdGdG5Ga2hv?=
 =?utf-8?B?UlZDOFVWTFZpY0dmU3ZCbzVUR0VpN3JwMVN6QmduMitJUmphR01uOURENmV4?=
 =?utf-8?B?bEFYeVVnOVNuZWRLQTUySWNJSFk2UjRUVXdjU0lzK2IrbUF3TmlhTlRQRmJv?=
 =?utf-8?B?RUcweUNyeDJIU0QzbnFWNUliUnUxb0d3cVVSOEs0cFRFeGNGMFF5anAxMXJU?=
 =?utf-8?B?eVpacjRRWHdSRm83U3k2K0FabUFKaEF6L2p1VHZ4N0V5VkF1Qi9xUzcvWUhi?=
 =?utf-8?B?MU1ka0dyVVp1UHpIQlVLOTh1eEpNUGlkc2RQTm9JMnF0dlBHMmI2dzZlN1pC?=
 =?utf-8?B?N0JpQzJ2ZnQ2aTM3czVBNEVQTGxpNmRvWGJmVFhEbjg0ZWYxYk5LeWFEUi9u?=
 =?utf-8?B?UXFHMWtTTEpJTXRkYmJ4R3dVNDYwNXFSN1c2eXhrbEVuM3NXZVhqOWw5djJE?=
 =?utf-8?B?YUtGMUI3YW82VVhRUHNFa0ZwamdYTC9raEIxM2ErdjkrWmQ2dnlDcUUzd0tk?=
 =?utf-8?B?MGhVaFNyOHdxUVFVeTltUXJZbVp5c0NYYnNrUkYxVWNERENJTFFpOTcxNkV6?=
 =?utf-8?B?UlZTTUhwV1Y3RmFhVjFlTUVzNVZyRVdiQ1l3ckRTMVlYVjlrdHJCNVJUbUJo?=
 =?utf-8?B?NitXL2M2MmZEb0QzRVNtTWVHUlJIQ0x6aXhVMnlVdHROeHk2UVRka2RVbUoz?=
 =?utf-8?B?Qnh0QzF2ZnRKaDFKUWViRGdERk96Sm1LSkRDTWFydlpXbGV4Rmp1QkVJWWQv?=
 =?utf-8?B?WmlpdGFKYWs5WGZrYWlVMGtJMzlaaEhpaXJKS01GNHVzZ1lzcUVsQm00QkhQ?=
 =?utf-8?B?STlEVXc0UU42ejB0OWVYUnpiVElmOFNjWXVNZ3g3VHQ1NEdmT2hyTlNsNVJl?=
 =?utf-8?B?RkE3VWI3K25NaUVyUitGQU41N1VhR3dIYTVPVDVEK005aXJveEJ1dk92RFp4?=
 =?utf-8?B?YjJOU1dLRTBHQlo4cnVQdE4rdjBvOTQ1WDFTQnYwdk1EVjBJcEhjSVNZRFdF?=
 =?utf-8?B?Y3Jxb0lXcU56TXVNYkVUc2toN0hpL21QMUpCa2lkT0dZeXVHdFdLRGdJWVR1?=
 =?utf-8?B?aEtYTVpXVCt4TkNXZXRHaityQittcWV6VzFvaVZaR3Z3U0FWUXZEZWxmdGgy?=
 =?utf-8?B?Mlg4Z2F2VFZJclBaS0c5WnlPRlEvRitRSVFsYUp2Y1hNVHJiQlcwN0I2MUJN?=
 =?utf-8?B?WUFxWUhqdzI2cXR2VlBlTTVZcW9WUjVPR1RWMWtXd1FoQzM3cklVd2VjRGFp?=
 =?utf-8?B?T3U3SStEZXlHNTltRmpFbE1aWkF1WVhNOEFhR3ZNaEhGdVJoUVV3QkFmVGJT?=
 =?utf-8?B?SnUvMnV6bkk0UkQ5bEZpc05TUlNZTi80ZGwvbml0ZzE0UXpEK05Sc2tTY2Z5?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8ED62130FF626C4387FA04C545FCD5BF@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b1ff31-58c7-4fd8-5d0c-08db894ba63d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 18:03:40.7380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tv7Sy6HHKkN1JjhwyTEAndurWPV+F0HNf4Z/Sck9HINuN9X7L1NTcRFNRv6dsAQKfTGSn5UZHNDCBdYTty/5o3X+CeBJ5utb1oDbVWfTLMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7428
X-Proofpoint-ORIG-GUID: rC1ussPr-n-8EVsI3rBYK3W9ky0t-lHP
X-Proofpoint-GUID: rC1ussPr-n-8EVsI3rBYK3W9ky0t-lHP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_09,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200151
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBBbmR5LA0KDQpBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+
IHdyaXRlczoNCg0KPiBPbiBUaHUsIEp1bCAyMCwgMjAyMyBhdCA0OjQw4oCvUE0gT2xla3NpaSBN
b2lzaWVpZXYNCj4gPE9sZWtzaWlfTW9pc2llaWV2QGVwYW0uY29tPiB3cm90ZToNCj4+IGFuZHku
c2hldmNoZW5rb0BnbWFpbC5jb20gd3JpdGVzOg0KPj4gPiBUdWUsIEp1biAwNiwgMjAyMyBhdCAw
NDoyMjoyOFBNICswMDAwLCBPbGVrc2lpIE1vaXNpZWlldiBraXJqb2l0dGk6DQo+DQo+IC4uLg0K
Pg0KPj4gPj4gKyAgICBkZXZtX2tmcmVlKHBteC0+ZGV2LCBwbXgtPmZ1bmN0aW9uc1tzZWxlY3Rv
cl0uZ3JvdXBzKTsNCj4+ID4NCj4+ID4gUmVkIEZsYWcuIFBsZWFzZSwgZWxhYm9yYXRlLg0KPj4N
Cj4+IFRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCj4+IEkgZGlkIHNvbWUgcmVzZWFyY2ggcmVn
YXJkaW5nIHRoaXMgYW5kIG5vdyBJJ20gY29uZnVzZWQuIENvdWxkIHlvdQ0KPj4gcGxlYXNlIGV4
cGxhaW4gdG8gbWUgd2h5IGl0J3MgYSByZWQgZmxhZz8NCj4+IElJVUMgZGV2bV9hbGxvYy9mcmVl
IGZ1bmN0aW9ucyBhcmUgdGhlIGNhbGxzIHRvIHRoZSByZXNvdXJjZS1tYW5hZ2VkDQo+PiBhbGxv
Yy9mcmVlIGNvbW1hbmQsIHdoaWNoIGlzIGJvdW5kIHRvIHRoZSBkZXZpY2UuDQo+PiBwaW5jdHJs
LXNjbWkgZHJpdmVyIGRvZXMgZGV2bV9waW5jdHJsX3JlZ2lzdGVyX2FuZF9pbml0IHdoaWNoIGRv
ZXMNCj4+IGRldnJlc19hbGxvYyBhbmQgZG9lc24ndCBvcGVuIGRldnJlc19ncm91cCBsaWtlDQo+
PiBzY21pX2FsbG9jX2luaXRfcHJvdG9jb2xfaW5zdGFuY2UgKHRoYW5rcyB0byBDcmlzdGlhbiBk
ZXRhaWxlZA0KPj4gZXhwbGFuYXRpb24pLg0KPj4NCj4+IEFzIHdhcyBtZW50aW9uZWQgaW4gRG9j
dW1lbnRhdGlvbi9kcml2ZXItYXBpL2RyaXZlci1tb2RlbC9kZXZyZXMucnN0Og0KPj4NCj4+IGBg
YA0KPj4gTm8gbWF0dGVyIHdoYXQsIGFsbCBkZXZyZXMgZW50cmllcyBhcmUgcmVsZWFzZWQgb24g
ZHJpdmVyIGRldGFjaC4gIE9uDQo+PiByZWxlYXNlLCB0aGUgYXNzb2NpYXRlZCByZWxlYXNlIGZ1
bmN0aW9uIGlzIGludm9rZWQgYW5kIHRoZW4gdGhlDQo+PiBkZXZyZXMgZW50cnkgaXMgZnJlZWQu
DQo+PiBgYGANCj4NCj4gUHJlY2lzZWx5LiBTbywgd2h5IGRvIHlvdSBpbnRlcnZlbmUgaW4gdGhp
cz8NCj4NCj4+IEFsc28gdGhlcmUgaXMgZGV2bV9waW5jdHJsX2dldCBjYWxsIGxpc3RlZCBpbiB0
aGUgbWFuYWdlZCBpbnRlcmZhY2VzLg0KPj4NCj4+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBh
bGwgcmVzb3VyY2VzLCBib3VuZCB0byB0aGUgcGFydGljdWxhciBkZXZpY2UNCj4+IHdpbGwgYmUg
ZnJlZWQgb24gZHJpdmVyIGRldGFjaC4NCj4+DQo+PiBBbHNvIEkgZm91bmQgc29tZSBleGFtcGxl
cyBvZiB1c2luZyBkZXZtX2FsbG9jL2ZyZWUgbGlrZSBmcm9tIGR0X25vZGVfdG9fbWFwDQo+PiBj
YWxsIGluIHBpbmN0cmwtc2ltcGxlLmMgZHJpdmVyLg0KPj4NCj4+IEkgYWdyZWUgdGhhdCBJIG5l
ZWQgdG8gaW1wbGVtZW50IC5yZW1vdmUgY2FsbGJhY2sgd2l0aCBwcm9wZXIgY2xlYW51cCwNCj4+
IGJ1dCB3aHkgY2FuJ3QgSSB1c2UgZGV2bV8qIGhlcmU/DQo+DQo+IFlvdSBjYW4gdXNlIGRldm1f
KigpLCBidXQgd2hhdCdzIHRoZSBwb2ludCBpZiB5b3UgY2FsbCByZWxlYXNlDQo+IHlvdXJzZWxm
PyBUaGF0J3MgcXVpdGUgYSByZWQgZmxhZyB1c3VhbGx5IHNob3dzIGEgYmlnZ2VyIGlzc3VlDQo+
IChtaXN1bmRlcnN0YW5kaW5nIG9mIHRoZSBvYmplY3RzIGxpZmV0aW1lcyBhbmQgdGhlaXIgaW50
ZXJhY3Rpb24pLg0KPg0KDQpUaGUgaWRlYSB3YXMgdG8gZm9sbG93IHRoZSB3YXkgb2YgaG93IHBp
bmN0cmwgc3Vic3lzdGVtIG1hbmFnZXMNCnJlc291cmNlcy4gSXQgYXNzdW1lcyB0aGF0IGZ1bmN0
aW9ucywgZ3JvdXBzIGFuZCBwaW5zIHNob3VsZCBiZQ0KcmVnaXN0ZXJlZCB1c2luZyBoZWxwZXIg
ZnVuY3Rpb25zDQpwaW5tdXhfZ2VuZXJpY19hZGRfZnVuY3Rpb24sIHBpbm11eF9nZW5lcmljX3Jl
bW92ZV9mdW5jdGlvbiwNCnBpbmNvbmZfZ2VuZXJpY19hZGRfZ3JvdXAsIHBpbmNvbmZfZ2VuZXJp
Y19yZW1vdmVfZ3JvdXAsIGV0Yy4gV2hpY2ggaGFzDQpkYXRhIGFzIHRoZSBpbnB1dCBwYXJhbWV0
ZXIgYW5kIHNob3VsZCBiZSBmcmVlZCBvbiBwaW5jdHJsX3VucmVnaXN0ZXINCmNhbGwuIFNvIHBp
bnMsIGdyb3VwcyBhbmQgZnVuY3Rpb25zIHNob3VsZCBsaXZlIHVudGlsIHBpbmN0cmxfdW5yZWdp
c3Rlcg0KaXMgY2FsbGVkIChmcm9tIHJlbW92ZSBjYWxsYmFjayBvciBmcm9tIGRldm1fcGluY3Ry
bF9kZXZfcmVsZWFzZSkNCg0KVW5mb3J0dW5hdGVseSwgSSBjYW4ndCB1c2UgdGhpcyBoZWxwZXJz
IGJlY2F1c2UgcGlucywgZnVuY3MgYW5kIGdyb3VwcyBzaG91bGQNCmhhdmUgc2VsZWN0b3Igd2hp
Y2ggaXMgdW5kZXJzdGFuZGFibGUgYnkgU0NNSS4NCg0KcGluY3RybF9zY21pX2dldF9mdW5jdGlv
bl9ncm91cHMgcmV0dXJucyBwb2ludGVyIHRvIHRoZSBhbGxvY2F0ZWQNCnJlc291cmNlcyB0byB0
aGUgY2FsbGVyLCBzbyBJJ20gYWxsb2NhdGluZyBtYW5hZ2VkIHJlc291cmNlcyB0byBiZSBzdXJl
DQp0aGF0IHRoZXkgc2hvdWxkIGJlIGZyZWVkIG9uIGRldGFjaC4NCmRldm1fa2ZyZWUgaXMgY2Fs
bGVkIG9ubHkgaWYgc2NtaV9nZXRfZ3JvdXBfbmFtZSBjYWxsIHdhcyBmYWlsZWQgd2hpbGUNCmNv
bnZlcnRpbmcgZ3JvdXBfaWRzIHRvIGdyb3VwX25hbWVzLiBJIGNvdW50IHRoYXQgYXMgYSBsYWNr
IG9mIG1lbW9yeSwNCnNvIEkgY2xlYW4gYWxsb2NhdGVkIGdyb3VwcyB0byBnaXZlIGNhbGxlciBh
IGNoYW5jZSB0byBmcmVlIGFkZGl0aW9uYWwNCm1lbW9yeSBhbmQgcmVwZWF0IHRoZSBjYWxsLg0K
DQpTbyBJTUhPIGRldm1fKiBmaXRzIGhlcmUgZ29vZC4gV2hhdCBkbyB5b3UgdGhpbms/DQoNClNv
cnJ5IGZvciBiZWluZyBhbm5veWluZyBidXQgSSdtIHRyeWluZyB0byB1bmRlcnN0YW5kLi4uDQoN
Ci0tIA0KVGhhbmtzLA0KT2xla3NpaQ==
