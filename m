Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421917ADA0D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjIYO0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjIYO0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:26:39 -0400
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13E0C0;
        Mon, 25 Sep 2023 07:26:31 -0700 (PDT)
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38P8iPck001920;
        Mon, 25 Sep 2023 14:25:44 GMT
Received: from deu01-fr2-obe.outbound.protection.outlook.com (mail-fr2deu01lp2168.outbound.protection.outlook.com [104.47.11.168])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3t9pcw1cu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 14:25:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ja4FWuPXrgR4eSFH9LH0O1vKxFMnTqV0jObu9xNINY5Bdz4SGaW2lfWRPyikpjbJOjX5gxAX/ofRkwuDe1T7gAhPduJ3pJ6xceu+uHX5RMPmulNG4AlO231qkFJTmNT+QkAjuZFFrRkYSeRmygqXGUx9xVMteup38LpBXNmhcE1BF4lXbDPMTIUpELA2gLfdai25KmGQNM+yNiOF+gmkNv8PBc56hW0fEB30pSAKNoZxVzj/bvbuLPFzp7FDs/0iCSp5nZuI8a4cFjQFtj6Nz4CObaedONT0pg7joH3bOhCKqsAkK+DeBXZFBmQgfmatC3dfmYK/DcdNmha6F1fZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Eq0THYRt1kEnHaqb1QBgE/dfpIvgpuGQs73Qs9WPw8=;
 b=cdvrukNGu2iQ9WvjtQtbXROq45aDLo2Fa/L6xj1GDkprLCK7ydOZ698TxlurdiwdOJzcanVUdyPJUqnRVv14AprZKqdN9YxXsc4vFrllEbFY6dadgPUX6PjnLMkNZluHitU6sF8sAK7thY3uZFg6l6YC9coFgR8LUo+tqIdwVcw3ECrM04J3SpGCVPpPBRfzDxVWALZ/1a++IWbXaZ7iH3pwykmoIf10Uy/ZM6h1BYS5iXK9tjE+6/roZiarRueXrNYRiKXeWa+QY79EgnAxrg6yIWvQbugHuMKNbVcHyd0kV+Oaj2T0gDzbLdSmX1teqze8POTfldGPVdEhV6ObJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Eq0THYRt1kEnHaqb1QBgE/dfpIvgpuGQs73Qs9WPw8=;
 b=O7QtPw0EIF5YS2cJVG7YlarhutGR3NDJtg9h/0eK6OanepZJTRSOVJ+p1j7nM5GsLGwRSGVtqdpMHF4RCpR68auF9I8DV+zAn9/0Jr1T4KhjQZ0OjGt1xg0G9l5IDvGrh/nt7vwlDgOUTK25NhgxbDqZeIfP/LxXUnUt4XdG0rDFUyfhn9VHWVK7QI8J9vk7I1uumhuxAzc3QvD9ANhmJXXW70+0EQ7UiCm/1p7xF1FDn66k6oX5R2yi1+Wnh85mmCcD12P/kZSgRM+O7bbu3PgzRFVkyhQXSZfu2Aa9o204RJNC/5LfTEAdAMOIbyk36KXH+aV1hJeCcmRDZKefgg==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR2P281MB2653.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:62::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 14:25:39 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae2b:f2de:3e65:280f]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae2b:f2de:3e65:280f%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 14:25:39 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Andreas Kemnade <andreas@kemnade.info>,
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
Subject: Re: [PATCH 1/3] dt-bindings: iio: imu: mpu6050: Add level shifter
Thread-Topic: [PATCH 1/3] dt-bindings: iio: imu: mpu6050: Add level shifter
Thread-Index: AQHZ7zY18eaVCDRPzkSVjIkr8riWnrArG7wAgAA7/wCAAAlggIAAFvEAgAAQC4CAABGDdw==
Date:   Mon, 25 Sep 2023 14:25:39 +0000
Message-ID: <FR3P281MB1757332D4B5C004ED3CD2AA5CEFCA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20230924222559.2038721-1-andreas@kemnade.info>
        <20230924222559.2038721-2-andreas@kemnade.info>
        <6db5b758-2ae6-46fb-a699-d73a2b98b4c2@linaro.org>
        <20230925112852.00007d34@Huawei.com>    <20230925130225.55fe6fd4@aktux>
        <3b81a9a7-69a3-4fd6-875f-7a5170c5c872@linaro.org>
 <20230925142157.00000914@Huawei.com>
In-Reply-To: <20230925142157.00000914@Huawei.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR2P281MB2653:EE_
x-ms-office365-filtering-correlation-id: 58a89761-6627-4b3b-d475-08dbbdd34ad9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o5Ph9MZAGVlq/HE+CSHCCvQZt8sjZr0WAIuSO9nJ0WUIfH5ebXujOyzE1XMvl9jCGDSonKPbneSU5YDzNW/pdk3dwhUbaOxHypRRXi2hOMkXfn2x8jMl9Wqp6v+x1VHqcv/lobCoQtt78rkhFtUAwnBBpTXiRXcqdxncmFZJJtGaaCCL0zU8918PYixrsJPBIGmxxZmlZNxGhI5Yi7X0PjNnkemNEufyKq7SO7EbGkL5s4fOe9OKusZhCrrFo9PhDaPe0dZW4YYXp9/W/vHoeScPI5jrMLSf3GDOVneUu3uesiig+E/Np0hOA7acMmANiKQ59NTMMmkIYp2jEUEayiTqm9FCzxwqArgWQFdBlHj8HV+hkULWFdOU+5wPRhDAo/D3he2+kxzSaKvdaC2pCyrnzqn50cuCawOVIvtfln8lYMqUwxtZXMJJcSLO01wY9dQ8I2eAz6WhQFZyf/R3AxrATrmR8Mo/aeUvwtB/x27oHVtpfAmol+H325umlY1KxhGTCPNl+A/XdlQSm7iDHqQlKbZjJmphFX1W/1U3Z2WCdLWylawqVJEbDQzTEq86TFdpmi8yBvPMNUKh40AE0+DRx7uQmurCeyLcihkn8bwU4qwN0K7kHA50jcldxPCR8oMMsPUqBUsuD81yx3R0ndkkOzMv6Eo4Kd2wscMBqtAL6mNZRdTazNISc7cZQlsR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39850400004)(346002)(136003)(230922051799003)(186009)(1800799009)(451199024)(38070700005)(33656002)(38100700002)(86362001)(55016003)(53546011)(9686003)(2906002)(5660300002)(66476007)(478600001)(52536014)(966005)(41300700001)(316002)(66556008)(76116006)(54906003)(64756008)(66446008)(91956017)(110136005)(66946007)(122000001)(7696005)(7416002)(6506007)(71200400001)(83380400001)(4326008)(8676002)(8936002)(15398625002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDlTOVd6bUZQRnE4bGJDSlRlVU1ZdXd4aTR1aVk4TzFpRzVWS3JJTWV1NEsz?=
 =?utf-8?B?bmtkcC9OWnVlL0VGRFdNNzAxSExlTlozczJvRitOd2JIamFtRDRpNU9nNnJI?=
 =?utf-8?B?SjFCb3AvaWExZlVzR1lJM05BTEhrMm51dnJKb1c0RkQ4b0ZPNS9tbEdBUUlX?=
 =?utf-8?B?NnRNR3pBaFpmUTNvUEhWTERSN2tXcnF6OE1FVEFJSGt5RXoraFl4TlBEd3lU?=
 =?utf-8?B?RTg0a1NQL3kvdU93ZXZiOVEzcyt1eHprUTJvNXMrN3NGQllFa0V3VU5jeE5X?=
 =?utf-8?B?bDg4a0c0a1VCRjJxS1lneStZMXp0L1NrWDJSSDNjMGZkZlFxS296MmRBMTht?=
 =?utf-8?B?Wm5LaGg0bUNaOXlsSkErLzE1U3lvTU4raXFrL2FnZmhRd2pPYmtCaTBKaDMv?=
 =?utf-8?B?bFg2MzJ0cXdKTDZ4NVgvZTNNWjVQMmw3aUF6V29FUkU5TndQVXJ2ZzJCVDBh?=
 =?utf-8?B?enJzNGtCTjBLTXlveWtrOVV5cmZ1dEdNcktTUm1sZkJxVTM1MTBqOFBBdFQ3?=
 =?utf-8?B?WHJFc3ZQLzlzV0VTZThmNkIxc1h3VEY4djlaaHlNVkFxb3M0K2prYTE1T2xT?=
 =?utf-8?B?RGpyaFpTTVduUU1wT0U3Zis1UzNHRFVpVWZMZHVwNlUvbHMvWDJ4RWtsSU5Y?=
 =?utf-8?B?UXVEcHRwUHJvaEs5WXlsRTFwajBZRlorWXJDNnpTeDFCYU13eDlNSFI4eUxN?=
 =?utf-8?B?U2VqTnJiemM2dFFaRFFOeTVGREdmMHZUL1U5OUQ4NDBmUnVUS2JHUEhmRlhu?=
 =?utf-8?B?MVgydGYwUVNjVzlYMG1uUVFXRTVOUFNGV2EvVG5KZjhXRDh3bnNWWG8rVUFP?=
 =?utf-8?B?QTJDWm1wbUk4YmxXeWlzN0F6TndBTVBhdFdBVFc5b0grVXN5OHJnM0RUbnNt?=
 =?utf-8?B?LzlMOThIMTZqbGU2MDNNMGlVWUgzREtUUjdlUFJ6TEQ4RHdPSWo0ZE51T0ZU?=
 =?utf-8?B?UkZJTFVTNW5FY2FOMnU2cGNHU21xVVFDU09VQ2xwRU1Qb0pSUklGRE9QcFRk?=
 =?utf-8?B?SGd2ZUx5c2hQb2Y5bk93em1oV2VYZXBXb0d4UWFKY2c4VUlHWmc4cG1JWTRG?=
 =?utf-8?B?TzZXNUpubi81c0hEUnpNaXk2N3QwN1lBcDUrcC8yZzNBRkVrWk81S0FJTjRQ?=
 =?utf-8?B?N1M0VHFxOGROWnNSVmVOMnI3SGU5SkVUUU4yS1h5cDdLM2s1eUtWQTFmOExm?=
 =?utf-8?B?VTFzUkhraEpjMTJ6TGhrdjF3WkNOc2QzL21qNVBOWENpNURjY25lZ2lVdHZu?=
 =?utf-8?B?Z2JWbDVrQUJwR2wydjNzVlZTNVIyTnNrcTlQbG4vYXpDOVNiNWF1Zzh3N0hj?=
 =?utf-8?B?eUpsdGRqeGxLa0lhb2E5WEE1Q3UyMkJFNVJ3Vm1xbTh0eVVaaUdwNEVpRmxy?=
 =?utf-8?B?cDFWWHZqUGREbERXMHVrN2xKZ3pVeEJQSkJJYmxqenFDeFJBMXpzZGVuTFN0?=
 =?utf-8?B?R2VyNktkRERLWm9pVlVqeVQ0ZkJUZHJTVEJYL2M0b0FqdWx2dzVhb0Fvcktn?=
 =?utf-8?B?L2pxUUxvWEZkRlZ1c2VxcmdxKzVMUU1qalhzYTlxM0VuSFowTUt3TVZUVWN2?=
 =?utf-8?B?MkVEUXpGV3dCVzdvcEl5L2tXcElyOW5BQjJDUkhoR21Sc2FqL1BSd3lUS3U0?=
 =?utf-8?B?OEZOdU9WSmFlejhCUlR1MDQ4eXpSTVk2bG13bnNOZ1I4b0hmd0RIL0xSM2Ju?=
 =?utf-8?B?dFVwcDkzOEs4alFXaHFaYmNpMjhLTHd3TklveUs2VmlJcWRObXJWMEJTaTQ0?=
 =?utf-8?B?ZlJLS3BBUGNrdDlTc0xvK2NsNGNWZFZ4WXpuaFdVRmJxMnl4QzZZRWIvb0tP?=
 =?utf-8?B?UFZrb2dOUHV6cENoM2l0Z2FMa21RN3B1ZXFUQmtHN2diRjBUTm56Zk42QWhk?=
 =?utf-8?B?Y2lST2JTc3R4emxGODlCaSt6M0lOZGhqQllBTUZwY2N0QU9KQlUrZFhZYm80?=
 =?utf-8?B?M1lFQkMwdWN1MW56WGtJOE9pSnc2OVljbkdXWlFVVDA3NWlxaTNTUXBFVHNw?=
 =?utf-8?B?NVVJSlJWTmhhUHBzUUErUURBMW1IUXJyNWF6REpNZWViUUFHNTRNRDAwTTZS?=
 =?utf-8?B?RGppK044d1E2bzFkS0FOVmxDeFpLM1BBM0hHUlZ4aWR2eWVkSUtBdUJ1eEJ6?=
 =?utf-8?B?SWRJbERZM25ONmhtZjh0QVRTMDV1VkNYczlITXJySHo0YTVUVzZmeFR1Y2tL?=
 =?utf-8?B?MXJxT2NheUZORk5YZlVWQWl0WmQ0VHZZM3h5TGZzQXVmMVFuUDEwMVNLTWli?=
 =?utf-8?B?SVovZXJuR2tXUGR6eVpjR1QrMTBBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a89761-6627-4b3b-d475-08dbbdd34ad9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 14:25:39.4223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CGDI7ws3PoTrbEzjOGdxQ4jp1/niqoM6uuJCaGM+XXjuRS1zPgR+ohY30u+Q8CyBR31zdO+Tr43lZg3xLc3CJfJCEThBak5lVD+K9YHE318=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2653
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_12,2023-09-25_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sCgp0aGVzZSBhcmUgdmVyeSBvbGQgdW5zdXBwb3J0ZWQgY2hpcHMsIHRodXMgdGhpcyBp
cyBub3Qgc29tZXRoaW5nIHRoYXQgY2FuIGJlIGVhc2lseSBmb3VuZC4gRXZlbiBhZnRlciBkb2lu
ZyBzb21lIGFyY2hhZW9sb2d5LgoKQnV0IHdoZW4gbG9va2luZyBhdCByZWdpc3RlciBtYXBzLCBp
dCBzaG91bGQgb25seSBiZSB1c2VkIHdpdGggTVBVLTkxNTAgYW5kIG5vdCBNUFUtOTI1MC4gSSB3
b3VsZCBmZWVsIG11Y2ggbW9yZSBjb21mb3J0YWJsZSB0byByZXN0cmljdCB0aGlzIGZpeCB0byBN
UFUtOTE1MCBvbmx5IChieSB0ZXN0aW5nIGNoaXBfdHlwZSBhZ2FpbnN0IElOVl9NUFU5MTUwKS4K
ClRoYW5rcywKSkIKCgpGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQEh1
YXdlaS5jb20+ClNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDI1LCAyMDIzIDE1OjIxClRvOiBLcnp5
c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+CkNjOiBBbmRy
ZWFzIEtlbW5hZGUgPGFuZHJlYXNAa2VtbmFkZS5pbmZvPjsgamljMjNAa2VybmVsLm9yZyA8amlj
MjNAa2VybmVsLm9yZz47IGxhcnNAbWV0YWZvby5kZSA8bGFyc0BtZXRhZm9vLmRlPjsgcm9iaCtk
dEBrZXJuZWwub3JnIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBrcnp5c3p0b2Yua296bG93c2tpK2R0
QGxpbmFyby5vcmcgPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz47IGNvbm9yK2R0
QGtlcm5lbC5vcmcgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBiY291c3NvbkBiYXlsaWJyZS5jb20g
PGJjb3Vzc29uQGJheWxpYnJlLmNvbT47IHRvbnlAYXRvbWlkZS5jb20gPHRvbnlAYXRvbWlkZS5j
b20+OyBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIDxKZWFuLUJhcHRpc3RlLk1hbmV5cm9sQHRkay5j
b20+OyBjaGVuaHVpekBheGlzLmNvbSA8Y2hlbmh1aXpAYXhpcy5jb20+OyBhbmR5LnNoZXZjaGVu
a29AZ21haWwuY29tIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPjsgbGludXgtaWlvQHZnZXIu
a2VybmVsLm9yZyA8bGludXgtaWlvQHZnZXIua2VybmVsLm9yZz47IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnIDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1vbWFwQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtb21hcEB2Z2VyLmtlcm5lbC5vcmc+ClN1YmplY3Q6IFJlOiBb
UEFUQ0ggMS8zXSBkdC1iaW5kaW5nczogaWlvOiBpbXU6IG1wdTYwNTA6IEFkZCBsZXZlbCBzaGlm
dGVyIArCoApPbiBNb24sIDI1IFNlcCAyMDIzIDE0OuKAijI0OuKAijMyICswMjAwIEtyenlzenRv
ZiBLb3psb3dza2kgPGtyenlzenRvZi7igIprb3psb3dza2lA4oCKbGluYXJvLuKAim9yZz4gd3Jv
dGU6ID4gT24gMjUvMDkvMjAyMyAxMzrigIowMiwgQW5kcmVhcyBLZW1uYWRlIHdyb3RlOiA+ID4g
T24gTW9uLCAyNSBTZXAgMjAyMyAxMTrigIoyODrigIo1MiArMDEwMCA+ID4gSm9uYXRoYW4gQ2Ft
ZXJvbiA8Sm9uYXRoYW4u4oCKQ2FtZXJvbkDigIpIdWF3ZWku4oCKY29tPiAKWmpRY21RUllGcGZw
dEJhbm5lclN0YXJ0ClRoaXMgTWVzc2FnZSBJcyBGcm9tIGFuIEV4dGVybmFsIFNlbmRlciAKVGhp
cyBtZXNzYWdlIGNhbWUgZnJvbSBvdXRzaWRlIHlvdXIgb3JnYW5pemF0aW9uLiAKwqAKWmpRY21R
UllGcGZwdEJhbm5lckVuZApPbiBNb24sIDI1IFNlcCAyMDIzIDE0OjI0OjMyICswMjAwCktyenlz
enRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4gd3JvdGU6Cgo+
IE9uIDI1LzA5LzIwMjMgMTM6MDIsIEFuZHJlYXMgS2VtbmFkZSB3cm90ZToKPiA+IE9uIE1vbiwg
MjUgU2VwIDIwMjMgMTE6Mjg6NTIgKzAxMDAKPiA+IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFu
LkNhbWVyb25ASHVhd2VpLmNvbT4gd3JvdGU6Cj4gPiAgIAo+ID4+IE9uIE1vbiwgMjUgU2VwIDIw
MjMgMDg6NTQ6MDggKzAyMDAKPiA+PiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296
bG93c2tpQGxpbmFyby5vcmc+IHdyb3RlOgo+ID4+ICAKPiA+Pj4gT24gMjUvMDkvMjAyMyAwMDoy
NSwgQW5kcmVhcyBLZW1uYWRlIHdyb3RlOiAgICAKPiA+Pj4+IEZvdW5kIGluIGFuY2llbnQgcGxh
dGZvcm0gZGF0YSBzdHJ1Y3Q6Cj4gPj4+PiBsZXZlbF9zaGlmdGVyOiAwOiBWTG9naWMsIDE6IFZE
RAo+ID4+Pj4KPiA+Pj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJlYXMgS2VtbmFkZSA8YW5kcmVhc0Br
ZW1uYWRlLmluZm8+Cj4gPj4+PiAtLS0KPiA+Pj4+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9p
aW8vaW11L2ludmVuc2Vuc2UsbXB1NjA1MC55YW1sICAgICAgICAgfCAyICsrCj4gPj4+PiAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+ID4+Pj4KPiA+Pj4+IGRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2ltdS9pbnZlbnNlbnNlLG1wdTYw
NTAueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vaW11L2ludmVu
c2Vuc2UsbXB1NjA1MC55YW1sCj4gPj4+PiBpbmRleCAxZGI2OTUyZGRjYTVlLi42YWFlMjI3MmZh
MTVjIDEwMDY0NAo+ID4+Pj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2lpby9pbXUvaW52ZW5zZW5zZSxtcHU2MDUwLnlhbWwKPiA+Pj4+ICsrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vaW11L2ludmVuc2Vuc2UsbXB1NjA1MC55YW1sCj4g
Pj4+PiBAQCAtNDgsNiArNDgsOCBAQCBwcm9wZXJ0aWVzOgo+ID4+Pj4gIAo+ID4+Pj4gICAgbW91
bnQtbWF0cml4OiB0cnVlCj4gPj4+PiAgCj4gPj4+PiArICBpbnZlbnNlbnNlLGxldmVsLXNoaWZ0
ZXI6IHRydWUgICAgICAKPiA+Pj4KPiA+Pj4gSXQgZG9lcyBub3QgbG9vayBsaWtlIHlvdSB0ZXN0
ZWQgdGhlIGJpbmRpbmdzLCBhdCBsZWFzdCBhZnRlciBxdWljawo+ID4+PiBsb29rLiBQbGVhc2Ug
cnVuIGBtYWtlIGR0X2JpbmRpbmdfY2hlY2tgIChzZWUKPiA+Pj4gRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3dyaXRpbmctc2NoZW1hLnJzdCBmb3IgaW5zdHJ1Y3Rpb25zKS4KPiA+
Pj4gTWF5YmUgeW91IG5lZWQgdG8gdXBkYXRlIHlvdXIgZHRzY2hlbWEgYW5kIHlhbWxsaW50Lgo+
ID4+Pgo+ID4+PiBCZXN0IHJlZ2FyZHMsCj4gPj4+IEtyenlzenRvZgo+ID4+Pgo+ID4+PiAgICAg
Cj4gPj4KPiA+PiBBbHNvIHRoaXMgb25lIGlzbid0IG9idmlvdXMgLSBnaXZlIGl0IGEgZGVzY3Jp
cHRpb24gaW4gdGhlIGJpbmRpbmcgZG9jLgo+ID4+Cj4gPj4gSSdtIG5vdCBzdXJlIG9mIHRoZSBh
cmd1ZW1lbnQgZm9yIGNhbGxpbmcgaXQgbGV2ZWwgc2hpZnQgaW4gZ2VuZXJhbC4KPiA+PiAgCj4g
PiBJIGhhdmUgbm8gbW9yZSBkZXNjcnB0aW9uIHRoYW4gdGhlIG9sZCBzb3VyY2UgKHNlZSB0aGUg
Y2l0YXRpb24gZnJvbSB0aGVyZSkKPiA+IGh0dHBzOi8vaW52ZW5zZW5zZS50ZGsuY29tL3dwLWNv
bnRlbnQvdXBsb2Fkcy8yMDE1LzAyL01QVS05MTUwLVJlZ2lzdGVyLU1hcC5wZGYgIAo+IAo+IEkg
Y291bGQgbm90IGZpbmQgYW55IHJlZmVyZW5jZSB0byBsZXZlbCBzaGlmdCBpbiB0aGlzIG1hbnVh
bC4gVG8gd2hpY2gKPiBwYWdlIGFuZCBwYXJ0IGRvIHlvdSByZWZlcj8KPiAKPiA+IAo+ID4gZG9l
cyBub3QgbGlzdCBpdC4gQnV0IHRoYXQgYml0IGlzIG5lZWRlZCB0byBnZXQgdGhpbmdzIHRvIHdv
cmsgd2hhdCBhbHNvIGRvZXMgdGhlCj4gPiB2ZW5kb3Iga2VybmVsIGRvLgo+ID4gCj4gPiBXaGF0
IGNvdWxkIGJlIGEgYmV0dGVyIGRlc2NycHRpb24/ICAKPiAKPiBJIGRvbid0IGtub3csIGJ1dCBz
b21ldGhpbmcgcmVhc29uYWJsZSB0byB5b3Ugc2hvdWxkIGJlIHB1dCB0aGVyZS4KClRoZSB0ZXh0
IHlvdSBoYXZlIGluIHRoZSBjb21taXQgbG9nIHNlZW1zIGJldHRlciB0aGFuIG5vdGhpbmcuCkkg
c3VzcGVjdCBpdCdzIGludGVybmFsbHkgd2lyaW5nIFZERCB0byBWRERJTy4gTm9ybWFsbHkgcGVv
cGxlIGp1c3QKY29ubmVjdCBib3RoIHBvd2VyIHN1cHBsaWVzIHRvIHNhbWUgc3VwcGx5IGlmIHRo
ZXkgd2FudCB0byBkbyB0aGF0LApidXQgbWF5YmUgdGhlcmUgd2FzIGEgY2hpcCB2YXJpYW50IHRo
YXQgZGlkbid0IGhhdmUgZW5vdWdoIHBpbnM/CgpJZiB5b3UgaGF2ZSB0aGUgZGV2aWNlLCBjYW4g
eW91IHNlZSBpdCBhY3R1YWxseSBtYXRjaGVzIHRoZSBwYWNrYWdpbmcKdHlwZXMgaW4gdGhlIG1h
bnVhbD8KCkpvbmF0aGFuCgo+IAo+IEJlc3QgcmVnYXJkcywKPiBLcnp5c3p0b2YKPiAKPiAKCg==
