Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C36A75B8B9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 22:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjGTU1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 16:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGTU1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 16:27:21 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869199E;
        Thu, 20 Jul 2023 13:27:19 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KI1wAW009088;
        Thu, 20 Jul 2023 20:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=WeSb93xc7ng0y5N8IU/zFiuSO2hMFiO1EMivOrysgMw=;
 b=jv+9VPLeb8Nv7PrUjoMaHlisKZ56kp9IcrNT/3v1Ae26LcxaEcESRZh778cB1qqg3Njt
 FSjEb1AUBJgVV+Vb7z7fMQ04bBhMus8GR+/XQbJkwfNlqni91QlLmjko5taXsovVmb2G
 O9mtm7JUup+XjNhxF4NgQ8rLBcF4nbSiWw47N9RHj4NqohRxF4+lcsBbH2KspKWetHoq
 ZaGUnMMysrDraKHGtrMin/ysfZOBL082QzyUXGYDDmHj20WQq6FdyIoYHF+/enUTOU03
 cNzDgKl0BgzYcU2d17BfNzfCwa24o4nnX5jO/EpuHXsqpkVre9/MCCBD7qx3ObVI9h26 yw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3ry8dt1xfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 20:26:53 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 4F3CCD2C8;
        Thu, 20 Jul 2023 20:26:53 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 20 Jul 2023 08:26:53 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Thu, 20 Jul 2023 08:26:53 -1200
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 20 Jul 2023 08:26:52 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFzquXnlxs1jRMYZihCKBaof6pSM9Bkto6jMcLEKk+8ZcqPjYaHRwrkp0i+LHaZIhEbGDnIrKEKe5Erow+9veE1/KZ5p6PAnCp6eOV8lT6mEd37rcE5t8eLR2zREXjb9L6HbA5DaUJ5bGSGQmgPzhstNLhvYSMAU2YC0EdAykUHT2o16IW9zsnO23rYixw3LTuR2bZ7Rts9VNHad4Tuad0fwyJpyXjFeEbRLrO3Ln4mnL+Qwx7GEtOAyRbAiTN0hsiBEj7HA9+aM1mj7MMyTar+4Tk9QuUErqyLOgbxXdMi7NCR4RavF9m3EgFbRDcBsD+k1oLbd1+kBBeLpDpeiTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WeSb93xc7ng0y5N8IU/zFiuSO2hMFiO1EMivOrysgMw=;
 b=U2ekmn80D2DBYYW7TO4/fcZsol+HMwxsseNNknyyKmYU1ubXAao53Tls8uePjElA3PakTveq1cGxVBZ73fVmn/QE9lZ/eS1I1B+tUNPRZCfmCMDEDt1jewIT+xWKCLJy/vOLFMgRmiB1IgzuJTrAHih03EUZMuYkwhCV0+Qi6bRHAJCNLr95RDf86MByulKZObn+yEX5cQB2uqrWnY9V8JXXH6vJo24hNhHLQ5DgNoCGpeox89eS2Hey5rlGrqQdEf5CVRyNgyuLQuHn0akDIn72IGshrCdfKMUTRzHF4vccriRVDLuXfKyM+WFmalU7PsQMi4G+BmK2Yz+v6F2v0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 MW4PR84MB1705.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Thu, 20 Jul
 2023 20:26:51 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20b7:769e:3974:f17e]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20b7:769e:3974:f17e%4]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 20:26:51 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v5 2/5] gpio: gxp: Add HPE GXP GPIO PL
Thread-Topic: [PATCH v5 2/5] gpio: gxp: Add HPE GXP GPIO PL
Thread-Index: AQHZr3nkvwU+fup1gkuuDGe/x7XoX6/C2kcAgAAD+gA=
Date:   Thu, 20 Jul 2023 20:26:51 +0000
Message-ID: <9EABEF68-9261-416F-87FA-6DFDF7A5376A@hpe.com>
References: <20230705194544.100370-1-nick.hawkins@hpe.com>
 <20230705194544.100370-3-nick.hawkins@hpe.com>
 <CAMRc=MfaEfaZ7yYrFtc+XChzPX1C1AV1xAZPRZyJKA+z7D6-vw@mail.gmail.com>
In-Reply-To: <CAMRc=MfaEfaZ7yYrFtc+XChzPX1C1AV1xAZPRZyJKA+z7D6-vw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.75.23071400
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|MW4PR84MB1705:EE_
x-ms-office365-filtering-correlation-id: 518d8e5e-5c19-468d-3cd8-08db895fa69f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JIkfPpxFRdBRFCCxNtKlYvCafi89H7Yj1zW7cWv3Ua3vXmdKKYXzcEiAlX9uh4zh2WvQ1UBm5qOT0IG035tR9ciDc6RAUOD+nukXmdYq61khcz8c2imU0KGjEPe8q7GeYpP6Ru0lUqr5HAoAwMcYA+bLFE/jf70zp+1Q+9Uv6rLFEjuFmuWw2/9UkvzBFHyGvR+Q71xkTdPlex6QHsHrHhJb0LhmVCwT/3UPxyymwKmgsAfXXfJFDjt0ZtB4t8XH2xbr9PjsvI6GXnso5tNDLZFCNDmH0a/9UL0uvX3H+8Od4sweqBl923G1IxMJZY0VwCdMpOau9UR+jUv3+RRI/uXIyoJPo359zST+KHWRd7eCN1nOoL8VKPc7HsYeI/OvPcAuq585WxfrxUnITV026j9R1WuEZ2667OJh7WGd2afZqhSZpLI0AhwZTxZcIabKjT1QOo/Bd+0VwCS9f8b7DGcrqWqMRNb+g2tWdZA3jCDJuyxyhZtlDfd65WBH84c9vZT7W9QIXN2HX0iOtNRJtHXrhAf3YHwLPBH4ZhYS/HJ1UuHP77BqUCJ1KYJ7OySvkGoKFkY7Uf3nrBYNsl7KbiEKIHOTduaaEdL6E8f5izRxno26rBTu7NeL7nT5caLIl00GP+VROgc393ZqwOPJ/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199021)(82960400001)(478600001)(122000001)(83380400001)(186003)(2616005)(6506007)(71200400001)(6486002)(6916009)(91956017)(76116006)(4326008)(64756008)(38100700002)(54906003)(6512007)(66556008)(66476007)(66446008)(66946007)(4744005)(7416002)(5660300002)(33656002)(41300700001)(38070700005)(8936002)(2906002)(316002)(8676002)(86362001)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTJoV2g3NjRhMXNhQ1dJY1QyTGZKODBqVzZuQlBOSGlwOXpmeFhTcDltd3FU?=
 =?utf-8?B?Sy92cEt2ZUhJaytHbWxOb3ZtQnErWjdEbkt4OFMxVFNDcVdXaHU3a1NZZHJl?=
 =?utf-8?B?cGhxTGswLytJMmsvdmdJRVYyRXpLVmlNTy9tQ2JPMDRnT2JIVlQ1elpxUkhM?=
 =?utf-8?B?WWVqTUdhOFBJYjQ3Nm03MGNqZnkvRFZ6NVJXL3VwakV5YURtd3I3Z3pFd1dB?=
 =?utf-8?B?N21ROWphRzFkMlNsc3NSVGVWNjN6WkhrQllBTEIwTHpVMlhFK0tnRFEyM2Ir?=
 =?utf-8?B?WGJmbGZ0U0VmR1Jhakp0VVIxMGJhdEd4bkFwUHF2aExMWWprTXdQdFllblpD?=
 =?utf-8?B?SytwWE1qdENmSThEWFlXdTVwem02QVVqdkFldmYxRWZQRDIvVS8xNFpZMGlz?=
 =?utf-8?B?SkNQR0dIUytEWXZCeEF5QTZHdWU4bUp6WkM1UjdGVjhMbXphdE5ZaVB2S0VJ?=
 =?utf-8?B?blNNZDFxajJMWWZpK3Q3QUhLaU5waWFyejF6ZzBsRGhxVktYdlNPaTg4eDNx?=
 =?utf-8?B?S0xmZ1U5RTJEQ01rNWRkVzFBTkx6ME5ITXNpNVZCTkxoalB3YkVLeDVOemNM?=
 =?utf-8?B?cFRjYWZuckdlRUh0cjViRFNqMjBpZzhNZk5IenEzamRxVEJJc2V6TGxWR3RU?=
 =?utf-8?B?SU82WlBiM1RWTHBWK0tiTnIvTll2SjliUG0zN1FzeUdaNUJRRkU2Y1pIZkJ6?=
 =?utf-8?B?QzAwa3FPMHJ5MDBoZm9aVVVjcTQzRENtQW16OVJ5Zjd5Wjl6TFJ3OGVOdU5x?=
 =?utf-8?B?NDhoUmQ4RUJRVFZ0WjF4UVhuR1hkRnpFaEd4QWtob0NvQTZhdHhWU1BrN3Vs?=
 =?utf-8?B?b1VUMVNxQVRnUE0rZDcyQm9sWU1lamk0K01WWVB3RWRCK2hmUFQ1cGtwcUtr?=
 =?utf-8?B?VUJZQlZ2UjlNNkZ5QVNFcW9MWE5NL3Q3MmJhT25rNnlZRkhWVkY2Q3JkejdL?=
 =?utf-8?B?UWpGcGtlOTQ3Y3cweC9ZODhZemNnUVAyeks1dDN1UnhJZWRmWVc5aldJbnBD?=
 =?utf-8?B?Uk1FWEV0TGxPQ1djdHh1UWg3TGFENExTcnc0dGc3OUZMMXU1QzlYT2pJTVJN?=
 =?utf-8?B?UTlZb1JRdDljMGg2aXJDTFFNTzg1QXExUUFOVndlOXowUnpFekVSaFNaS0cv?=
 =?utf-8?B?QWVIWmR5UTZZSTVmZ0o4R3dNMEdxM1ZqTXBua0laOGV2TjMyM0kzS2U1QU5H?=
 =?utf-8?B?K0lTZ3F6WWdhcTlFekdvSjkyNmRCaldwNjBGWEZLaGZLMlpHSEZqd0paS1p1?=
 =?utf-8?B?Q09id24xbS9SODJ0S3ZlZjFiMEZWRkxsN0Z5aE1yVG5obTZyUjVNR0tGV2hN?=
 =?utf-8?B?VlZzNVpMbGhrb0RSUFRobEVHVzJaeHRPZnRBOHNZSHdIQ3FPQkdyOUpFbG9K?=
 =?utf-8?B?Sy9vcnphOGFacnRnT3lvY08xVkN2TFFNVDFRQVhrWG1HQ2hIblVWbE1ia0Uy?=
 =?utf-8?B?S3dITlk5NFVUZk9wbE1DYXExK1ErWVNrZ2hDSU1Ub2l5ejI0MXFzMWdSZHow?=
 =?utf-8?B?MzE2bmdUaXl0ZWpIVjF3OUtHZmN0UjF2ZkpSckNmVCtLL3hiQVdmd2FRZmZN?=
 =?utf-8?B?VFF3QXkvN1ZDQmVpZGxhaUx5eEJ5ZVJ0R1lQOElCRy9QNkVybjBtenFTM0lh?=
 =?utf-8?B?aDFaMW9TVTk2UmU3MWh1L2lnWXdGQVVtY2tYZmlXUldjb3l2NXpXUlNwUkNG?=
 =?utf-8?B?a2p6RlNYd2xmaFdPTyt1eTZiM0xXTDdtME1KcEgyYWtXaEwvOGxwKzg3QVRQ?=
 =?utf-8?B?M0l6eHNFOVpBZEp2YndNUnRVTk9JQnNzNThCTTdHdVRuZlpBbFVLd1NaVTAv?=
 =?utf-8?B?dm0zRjF4eVNVd21YdHFBRmtFRWlmcE05K3VtUWdjMDJicnVTS2dDcUVmb0Ru?=
 =?utf-8?B?ZWV6MzYyZkxrTEJaK3RTbEZUUEUwSmV0RkEraFFBVjEyZnFVNS9TQ0d6M1d6?=
 =?utf-8?B?bERJMXJnWFdWL0ZmVTE0Q00zTkQ3bjNTdEtpSnlrdmU4QWN1MEg2LzgzaTJq?=
 =?utf-8?B?Q3Y0TUdhay9ncTk5bHpPZ21TYXVRdFBDbldGV1VkWkthR3VEYzVKL1hGdEJy?=
 =?utf-8?B?dzIyMTk5ZmdWSWtlQjFJa29TYmJyOFUvZWV2QWVkbjFESEN0QXlKM2loSTh5?=
 =?utf-8?B?NkpXWkJ2R1lEdWFNNVplRVZ4MFoxL2ErbnJ1VkZLRFkvbEhUM0gvOFp3cTdM?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91C052A11B740D4A897EAB1C87D5F34E@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 518d8e5e-5c19-468d-3cd8-08db895fa69f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 20:26:51.3185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OGA6dpUvw7P/xF1LlV2taQvXbsL1eEAiTW459SaFxstqOI0wSZq/kUdv6v+Ti9u2ZPLJT56E+ec2gC7JQjT2Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1705
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: zTF2PCVqcmcjwKBnMk8SYkO5SWa_ySai
X-Proofpoint-GUID: zTF2PCVqcmcjwKBnMk8SYkO5SWa_ySai
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=594 clxscore=1011 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307200174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gKw0KPiA+ICsvKg0KPiA+ICsgKiBXaGVuIGFuIGludGVycnVwdCBmaXJlcyBmb3IgYSBQ
U1UgY29uZmlnIGNoYW5nZQ0KPiA+ICsgKiB0aGVyZSBpcyBhIG5lZWQgdG8ga25vdyB0aGUgcHJl
dmlvdXMgUFNVIGNvbmZpZ3VyYXRpb24NCj4gPiArICogc28gdGhhdCB0aGUgYXBwcm9wcmlhdGUg
Z3BpbyBsaW5lIGlzIGludGVycnVwdGVkIGZvcg0KPiA+ICsgKiB0aGUgY29ycmVjdCBQU1UuIElu
IG9yZGVyIHRvIGtlZXAgdGhpcyB2YXJpYWJsZSB1cCB0bw0KPiA+ICsgKiBkYXRlIGl0IGlzIGds
b2JhbCBzbyB0aGF0IGl0IGNhbiBiZSBzZXQgYXQgaW5pdCBhbmQNCj4gPiArICogZWFjaCB0aW1l
IHRoZSBpbnRlcnJ1cHQgZmlyZXMuDQo+ID4gKyAqLw0KPiA+ICt1OCBwc3VfcHJlc2VuY2U7DQoN
Cj4gSSdtIG5vdCBidXlpbmcgaXQuIFRoZXJlJ3Mgbm8gdXNlciBvZiB0aGlzIHZhcmlhYmxlIG91
dHNpZGUgb2YgdGhpcw0KPiBjb21waWxhdGlvbiB1bml0LCBpcyB0aGVyZT8gSWYgdGhlcmUgd2Fz
IC0gdGhlIG5hbWUgc2hvdWxkIGhhdmUgc29tZQ0KPiBwcmVmaXggYnV0IGV2ZW4gdGhlbiwgSSBk
b24ndCBzZWUgYSBuZWVkIGZvciB0aGlzIHRvIGJlIGdsb2JhbC4gV2h5DQo+IGRvbid0IHlvdSBw
dXQgaXQgaW4gc3RydWN0IGd4cF9ncGlvX2RydmRhdGE/DQoNCkhpIEJhcnQsDQoNCllvdSBhcmUg
Y29ycmVjdCB0aGlzIHNob3VsZCBub3QgYmUgZ2xvYmFsLiBJdCB3aWxsIGJlIHBsYWNlZCBpbiAN
Cmd4cF9ncGlvX2RydmRhdGEuDQoNClRoYW5rIHlvdSBmb3IgY2F0Y2hpbmcgdGhpcyBhbmQgdGhl
IGFzc2lzdGFuY2UsDQoNCi1OaWNrIEhhd2tpbnMNCg0K
