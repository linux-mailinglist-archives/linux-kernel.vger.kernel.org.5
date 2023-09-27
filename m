Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DAB7B0C60
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 21:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjI0TH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 15:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0THY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 15:07:24 -0400
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51769DD;
        Wed, 27 Sep 2023 12:07:21 -0700 (PDT)
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R8oNA5002390;
        Wed, 27 Sep 2023 19:06:40 GMT
Received: from deu01-fr2-obe.outbound.protection.outlook.com (mail-fr2deu01lp2168.outbound.protection.outlook.com [104.47.11.168])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3t9pcw3cq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 19:06:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYbom7JNr6fn/qtOul9dr4WjqD3Fk8znjqeLfWg+yy1oK6HESnN1zx7kgrE6AxukurYqs5Shy0KRs0yN52n0me5/ONDfJjDXG62MUAeJsKDipNpGYB1xAQgEdDAyqg8xMQEjFyoicyYuT39hcr4Ybhd0sabD8+gew6KtikTBcCKZNqmr/vMVI/90ukGuspORQCKqFAE7+LXISkkZxMhC3mXSriDHsz0gzbB98R3W6dhH2IqtroqhnicU2PJtYFmd7RjL3Y3vSO48MMowT+BpZnbhd/iXn6brrEOmu6VCYeXi/DTF+rWbt7TTyKuOIB38Hg1hsK0XWyZtNjAT8IhTfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NowRbFf/7ivZADqwhYihskqxGTjqHMfVmH/YW81Yrg8=;
 b=H4r/4KuTzX1tY/eRjYeDbjs7Lex12bcMZ5zfE2NLdRirWQktRy4lc9+Oakt59dh9blt/kSxmwXFYPgxfjvu3EgnPp9l0VPGKKlVza6EOcndMRVZJg3BxeCVQJNaaY5ai1w2lQq1XHgBAsSKoa+H3UUfxFd4C8pJ0W41a9ZFbt4GDK1Gn0HQjkPErEeZXjiBqnj31Q7Zhg4Kk8mj2t1JgZYajLHIb+PSzD3gBNElDvHXMkeVs7r5R6B8wMtww2kkzu+Cvv3vt0FVxoo/iTO9l3prxCmjUSkpU84f9x+0Ka+5CeFPmgHK2imBvaN78IAe8vhRexXdS+j5bS7ZpQZgDbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NowRbFf/7ivZADqwhYihskqxGTjqHMfVmH/YW81Yrg8=;
 b=eVxw5wfu0nMA+1q2pN4KJzdLasqzVcWVN3vX5Zsdb+px+G+EcILqnRcrfK4iE2v9YU1Nt/3yOoyjJyTlNESBxuvt48EhxqXAXMxbqtEyLPHmZH1bgmesWmv47nLYCChOS/ffyjxyskvRIVjvtgPtvKD4dP6uiBjUI6jfRHfdnDX8aStqoIoyGBIF7XWk7Z6FMKqzz9+QrG4Z7UDdOXllKF6hOIg55nv27zf1HfkCNkYJYEfpM2gMleYgEc4tg5eCsxVZJBOBLI9DaqDqw/G8FIwIhm6BRsDcQDsHbi1jiYda9BTFsItcNcXb8tttZgvziNjhkH5WRZ584B6bwZQgnA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BE1P281MB3318.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:48::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 19:06:32 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae2b:f2de:3e65:280f]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae2b:f2de:3e65:280f%3]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 19:06:32 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Andreas Kemnade <andreas@kemnade.info>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "bcousson@baylibre.com" <bcousson@baylibre.com>,
        "tony@atomide.com" <tony@atomide.com>,
        "chenhuiz@axis.com" <chenhuiz@axis.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: imu: mpu6050: Add level shifter
Thread-Topic: [PATCH v3 1/3] dt-bindings: iio: imu: mpu6050: Add level shifter
Thread-Index: AQHZ8WiyqB9JTxxGJ0O624s8YqFgR7AvCAbo
Date:   Wed, 27 Sep 2023 19:06:32 +0000
Message-ID: <FR3P281MB1757C2EDF7BF36418A1B0169CEC2A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20230927173245.2151083-1-andreas@kemnade.info>
 <20230927173245.2151083-2-andreas@kemnade.info>
In-Reply-To: <20230927173245.2151083-2-andreas@kemnade.info>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BE1P281MB3318:EE_
x-ms-office365-filtering-correlation-id: e38df28e-0496-4f96-53da-08dbbf8cdd11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vdk26oFnFMhDw7tKprfGSZ20BQAA4XKY+CYDXvO1KBO5fGvEJ/jFQmzImyVGP9Xc7K1AhamZaChmItyVbbV0atbtaxBCXinQndtKqHg4g4sCdJJJmN7De+TtNzYHE+cq+merM+iNUnOS0X3U8iEF4uu7SovQV4J+J7l+1EBg2MajAUgsDWktrzL/yitbRWUY2BQjcPktnQyZKlmBiUYEaoPlHZOCkzCXBG3J8Nkrf120uNgPjEP1Sioqk4qyQenNxgSZ2eejsi81Rbsnjy/jVeocQoAEYdrcNaeAe+28X1sY2eswW7vdtcmyj8RY1JPO3eUDIRbaSX59h/qRgoY1BqYe//g7Z2Sm+5hv04TFXDxrYl2d1hwDv0EuNejAYNwyI18A97xkWzA6kvyJc3mb0GYDWVBhFolASjQ81PTCnTe1swIhAsXsrZw7OoKwjPbzTraT2kaZPKsiXyKopGioKoCBeSKh+nTpi4ps3ByL0cbFCoqKrlnYcbW16uEq7qNxWZ50crdEHlD7Jg0Hyn6mtPY04qpHwuXB+nz08pdLC+9RHTWTr4jkm8OF9yXnF3bpSRhESLH2wG7gHoESKTor1jtxj5zJd6xGf0AEgIDTL5sQdhk4W81X9gB8oqGOdxpDzZ+aYmzj5g4TEaCdITa8jFkNKQvVBRNxrjb+fa3FPtfAF1NqPM5KDFisShpWVViR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39850400004)(396003)(366004)(346002)(230922051799003)(186009)(1800799009)(451199024)(9686003)(7696005)(6506007)(53546011)(83380400001)(921005)(55016003)(86362001)(122000001)(38070700005)(38100700002)(33656002)(7416002)(2906002)(71200400001)(478600001)(8936002)(52536014)(8676002)(5660300002)(41300700001)(316002)(110136005)(66946007)(66556008)(91956017)(64756008)(66476007)(76116006)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVJrbmF6ekt5aEx6MmxyR0ZPNFY5N3BRMW1mUC9ZSnFzWGdvNVR1K01PSU5N?=
 =?utf-8?B?S2pEMXpoN2hGV3NuaDMrRGFITjlsSkt0SkJPYVJzVEwxNzhSSFFuZDR6RFZt?=
 =?utf-8?B?OWQrSEVuV3ZaWkE3K3o1R0RyZ1FkazREc1pqNTJobm91SXJpcWtzWk5vZ1g3?=
 =?utf-8?B?MllQaloyL2ZPUkF0cWNnR0c0ZVFDQmNCd1ZmV3dIN2diQ1dNb1RaSmF3MEN3?=
 =?utf-8?B?a1YwNjRPNS85Y1UzVXBGTE1FQVB6dWcwTUl3bWhET2xHWFA5NCszN0lxMm4v?=
 =?utf-8?B?ellsUjMwdmY3THc1Z2xoamV0R3VUK3duL28xRitlYWpjTm9HM0NnSmRDb3ov?=
 =?utf-8?B?MjFHUFF2NG5RTlZMOGxVMnFUbzRIM0ZkU09KdTlCdG9vMjEvT1JVQ2lTUzlO?=
 =?utf-8?B?d0RMK1NqQUJRWGc3ajlSYU9VYlU1UVRQRUovWStJUG5KTEp0dGowdERTL29V?=
 =?utf-8?B?Uk8yeHBPeDFrUUJRVER1Y1ZMSjlpMnNZSkxaYVVUZlIyVnZMZDNKN08rQTdp?=
 =?utf-8?B?RVYyTk1LUjM2bGlrN0tKcndsaTl2RS9ZaW9nVCtLZ01VOWYwSlkraW9RMjVW?=
 =?utf-8?B?M0VQcFJWM21UZG95TkJlbXo5cWFwWjI4aHBBWUJyQmtDOTI5UnczWkEwZUVX?=
 =?utf-8?B?Ym4wUU5EYnA2ZlBOblR5VUtNQU5idjdWNnBKSnZQNXozLzZnN05XR0RhNnJU?=
 =?utf-8?B?Y2RaVGNLQUVCSmJ2YWJYTU5KbTNkR0oyd2J0MTVId3pIUmdiTjdFQjRGMUEx?=
 =?utf-8?B?WmJOdTE2a3FwVU9QamF1RUlrR1pGN2pJS2JVTFI4TUlRb2hWZllHVUJkMWVs?=
 =?utf-8?B?YTFZL1hDbzIyUFRTdm1td1FxL2F2SC9uWGRnZmlrY01wQ051L3B4TldMZVA3?=
 =?utf-8?B?aGdQNFJVL0o0aHJ2NlJQK1p5VDZUZERLTGoxQ2JINGpodlVSeDljdzBnYnVr?=
 =?utf-8?B?WGNSbmZIV0JkNDY1enZKZUhRRC9iZkJRbWg0T2NtWDRWQ1RTNXpUK3NkZUIr?=
 =?utf-8?B?elZBVlp2dXhuT2lLNXpJcXBHNFdaaUh1RW4rNWVvamxDZUpiR1RSZ1F6UFk3?=
 =?utf-8?B?bGJpK0lLbWo3MmhzZ1pOVFArbXl2dkZJVXdhZ280enRDczlWNG81bzNyQk1K?=
 =?utf-8?B?VVpkc0h0SlVLb29wV1ExWisxSUdpTGZGUDNLdG9IcGRVNHdPeUw4aHBkZFVz?=
 =?utf-8?B?K2xIUlB1S0F0d3l5Y1dmUHhFM2FwenZzTHpxVkV3eFFYSWFkaUM0b0RJVTdO?=
 =?utf-8?B?WncyTUVqYkU0aTlMazBOQkoreC9wak9SNWFXc2FzRlB6R1hubzVQZ1NlT0x4?=
 =?utf-8?B?bEhvWk5IYzFmeGVqUWxuNm1YSWRQQ2ptS0RzWGk1dCswN2tBNS84cW9JS1Uy?=
 =?utf-8?B?bzBUeG9YYndPakpEdlZPVVFOcktkbjE1N0J1VkdiTTFTOS9POTE0K3FYNFlu?=
 =?utf-8?B?aFJzdFBjbXdRbXRwNFlBcGh6TXZqUGlxcktmbEFWZUlKWC9vYXdyNkdZT25x?=
 =?utf-8?B?NnZJOXZreXBVZHRBN2tjV2w4TjZob0N2QjhDWEd2dE0vc0U5KzB4L3NNYXFQ?=
 =?utf-8?B?VGxKWlpIM09za0c0dVZ6am41V3dPWHlQKy8xN1Y4Q0IvWEJSS29jNlZ5L0lJ?=
 =?utf-8?B?RVBQeGNKQTgzQ3lnWUFobEZXQlZwTFM4RmdWSkdsMHFKdHRTdEJnQzVIV0R3?=
 =?utf-8?B?OWl6T3grR2dhN1JheW9wWUhMSEZVdDZqOVhMNEx4em9LVllQelAvY1dGUUZO?=
 =?utf-8?B?Vk51SmhyejJRdnpDTk1ZYTFCQ3dPcVJ1aW5sQ2s3bk5vRlA0Z3ZFYzNNaWpi?=
 =?utf-8?B?b1NMNTJQSjNCK0pKRnljNWVkOG9Ta2RVeHV6UHhLa1MvRUhnV252OVBJK0dD?=
 =?utf-8?B?NExpZjdWVG0xM2JNUkQ2MEhyOGNlM2NEM0gwM2NRQ0QvN2p6RG5PTHhadk43?=
 =?utf-8?B?TFJTK3I1dXFOZENtWXVGWitvbnhSRGdLMk9FOGtpeVNUczhlb1AxWTJzU1NZ?=
 =?utf-8?B?QXNDQ0NRTVJoWWRBd1VieVlBa05DdUdFQUFJTHJ5OFlxYmdMZ2tqamVCTCsr?=
 =?utf-8?B?MVVTL2pyczdBZzR6aU1JM2F1RFlxb3M2R3grT0hZRUdtTkU4WHhKQXpLSnVj?=
 =?utf-8?B?V0ppdHRuZzNWVlU2Q0lRckIxZ21CSitPdUI5VlRNRkRFakVxamFJTjN0WGJ1?=
 =?utf-8?B?b0d2dnBiNFBZOHJ5N2VqUWZIWURMdWlVUUNENUFNMkozSi80Rjh4LzNyWkY0?=
 =?utf-8?B?YmtpN0RUNEthVVlBVnhDcUlNRkJ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e38df28e-0496-4f96-53da-08dbbf8cdd11
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 19:06:32.7957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HT8jMkRL0PbOiFa2PDfA9WjmsjS7lu+kn0qrovIWg2J14N8ZRTp1U9W6bhwUnljTFYWLpB1ZGOAW/2wEoRrRqz7xNDoctTgjIB+p+sGg3RE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB3318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_12,2023-09-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sCgpsb29rcyBnb29kIGZvciBtZSwgdGhhbmtzLgoKQWNrZWQtYnk6IEplYW4tQmFwdGlz
dGUgTWFuZXlyb2wgPGplYW4tYmFwdGlzdGUubWFuZXlyb2xAdGRrLmNvbT4KClRoYW5rcywKSkIK
CgpGcm9tOiBBbmRyZWFzIEtlbW5hZGUgPGFuZHJlYXNAa2VtbmFkZS5pbmZvPgpTZW50OiBXZWRu
ZXNkYXksIFNlcHRlbWJlciAyNywgMjAyMyAxOTozMgpUbzogamljMjNAa2VybmVsLm9yZyA8amlj
MjNAa2VybmVsLm9yZz47IGxhcnNAbWV0YWZvby5kZSA8bGFyc0BtZXRhZm9vLmRlPjsgcm9iaCtk
dEBrZXJuZWwub3JnIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBrcnp5c3p0b2Yua296bG93c2tpK2R0
QGxpbmFyby5vcmcgPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz47IGNvbm9yK2R0
QGtlcm5lbC5vcmcgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBiY291c3NvbkBiYXlsaWJyZS5jb20g
PGJjb3Vzc29uQGJheWxpYnJlLmNvbT47IHRvbnlAYXRvbWlkZS5jb20gPHRvbnlAYXRvbWlkZS5j
b20+OyBhbmRyZWFzQGtlbW5hZGUuaW5mbyA8YW5kcmVhc0BrZW1uYWRlLmluZm8+OyBjaGVuaHVp
ekBheGlzLmNvbSA8Y2hlbmh1aXpAYXhpcy5jb20+OyBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIDxK
ZWFuLUJhcHRpc3RlLk1hbmV5cm9sQHRkay5jb20+OyBhbmR5LnNoZXZjaGVua29AZ21haWwuY29t
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPjsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZyA8
bGludXgtaWlvQHZnZXIua2VybmVsLm9yZz47IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnIDxk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcg
PGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1vbWFwQHZnZXIua2VybmVsLm9y
ZyA8bGludXgtb21hcEB2Z2VyLmtlcm5lbC5vcmc+ClN1YmplY3Q6IFtQQVRDSCB2MyAxLzNdIGR0
LWJpbmRpbmdzOiBpaW86IGltdTogbXB1NjA1MDogQWRkIGxldmVsIHNoaWZ0ZXIgCsKgCkFkZCBh
IGxldmVsIHNoaWZ0ZXIgZmxhZyBhcyBmb3VuZCBpbiBhbmNpZW50IHBsYXRmb3JtIGRhdGEgc3Ry
dWN0OiBsZXZlbF9zaGlmdGVyOiAwOiBWTG9naWMsIDE6IFZERCBTaWduZWQtb2ZmLWJ5OiBBbmRy
ZWFzIEtlbW5hZGUgPGFuZHJlYXNA4oCKa2VtbmFkZS7igIppbmZvPiAtLS0gLi7igIou4oCKL2Rl
dmljZXRyZWUvYmluZGluZ3MvaWlvL2ltdS9pbnZlbnNlbnNlLG1wdTYwNTAu4oCKeWFtbCB8IDUg
KysrKysgMSBmaWxlIGNoYW5nZWQsIApaalFjbVFSWUZwZnB0QmFubmVyU3RhcnQKVGhpcyBNZXNz
YWdlIElzIEZyb20gYW4gRXh0ZXJuYWwgU2VuZGVyIApUaGlzIG1lc3NhZ2UgY2FtZSBmcm9tIG91
dHNpZGUgeW91ciBvcmdhbml6YXRpb24uIArCoApaalFjbVFSWUZwZnB0QmFubmVyRW5kCkFkZCBh
IGxldmVsIHNoaWZ0ZXIgZmxhZyBhcyBmb3VuZCBpbiBhbmNpZW50IHBsYXRmb3JtIGRhdGEgc3Ry
dWN0OgpsZXZlbF9zaGlmdGVyOiAwOiBWTG9naWMsIDE6IFZERAoKU2lnbmVkLW9mZi1ieTogQW5k
cmVhcyBLZW1uYWRlIDxhbmRyZWFzQGtlbW5hZGUuaW5mbz4KLS0tCiAuLi4vZGV2aWNldHJlZS9i
aW5kaW5ncy9paW8vaW11L2ludmVuc2Vuc2UsbXB1NjA1MC55YW1sICAgICAgfCA1ICsrKysrCiAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9pbXUvaW52ZW5zZW5zZSxtcHU2MDUwLnlhbWwgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2ltdS9pbnZlbnNlbnNlLG1wdTYw
NTAueWFtbAppbmRleCAxZGI2OTUyZGRjYTVlLi4yOTdiOGExYTdmZmJjIDEwMDY0NAotLS0gYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2ltdS9pbnZlbnNlbnNlLG1wdTYw
NTAueWFtbAorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2ltdS9p
bnZlbnNlbnNlLG1wdTYwNTAueWFtbApAQCAtNDgsNiArNDgsMTEgQEAgcHJvcGVydGllczoKIAog
ICBtb3VudC1tYXRyaXg6IHRydWUKIAorICBpbnZlbnNlbnNlLGxldmVsLXNoaWZ0ZXI6CisgICAg
dHlwZTogYm9vbGVhbgorICAgIGRlc2NyaXB0aW9uOiB8CisgICAgICBGcm9tIGFuY2llbnQgcGxh
dGZvcm0gZGF0YSBzdHJ1Y3Q6IGZhbHNlOiBWTG9naWMsIHRydWU6IFZERAorCiAgIGkyYy1nYXRl
OgogICAgICRyZWY6IC9zY2hlbWFzL2kyYy9pMmMtY29udHJvbGxlci55YW1sCiAgICAgdW5ldmFs
dWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQotLSAKMi4zOS4yCgo=
