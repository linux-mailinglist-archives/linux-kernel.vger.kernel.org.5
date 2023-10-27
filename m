Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C848E7D92CE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345634AbjJ0IzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbjJ0IzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:55:14 -0400
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D15106;
        Fri, 27 Oct 2023 01:55:10 -0700 (PDT)
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39R8esvK012129;
        Fri, 27 Oct 2023 08:54:49 GMT
Received: from deu01-fr2-obe.outbound.protection.outlook.com (mail-fr2deu01lp2169.outbound.protection.outlook.com [104.47.11.169])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3tywsyrjjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 08:54:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faAgMNN1xtu0OxRxV/ERrz8iq4y1DXp+gxhmNtUer02vs3vw0uqwZ/vb10T4TJM7NXqx/xZhV8zVlgEJsPFpHySIxBRU3bA4z0fr+owlAHoKRxl7CH+Lm0RkQ50pue304ANgWxMes6Ugcn8vXDeRZFYEVMdivvcamvWw+qU9xEbuoZXuPovYVd+je7ItpzkLMB7R+NY6rXDYsmbWZVrr2VW3k7+fx6FbOfSYGeRietFJA8+LCYghp1iMOt/imNsfLXhL0JFxDh0f/3GVJ81qqz6sKonKvMCZYjT0B8rCZeTMos+IbzrYsuDbZ4JeHMgk9D32FZbNijzyV/qdTxWkpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M00xSE0YFP4FuTE5BJYnZ3Xzsa8YxlRMaXM9YbR9KMk=;
 b=FI+dQJCUNVa2ddOENgvBmzuNOu8mzE1wMk4iA7tQJtsWKUBO89KoUxRW4BP3XjGGf5yoUTTyl34APJrMuQB5AbmwxHR/vQHmhz5KgWxWpL6FSqFidU+vA3hUeznBadAx1XGy3C0qinunmc+MRiF0FRIKSxcApQmvYCiWAncU858Qt3aTQYFSbRlNLambhndFp0hL8IkVUBYvqvMMrLX0AR6Ujk7SqHk5fH9PIi2a0LubDKqfWiS9bW3CA/6ULARFt14CICWwsGP60IwrxSAEXtnLqL/cM3UiWVXfsS4pF3Ty36B5wTOyW2egWya5wQlJmPOhws5BjPtQB5AnFI2YtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M00xSE0YFP4FuTE5BJYnZ3Xzsa8YxlRMaXM9YbR9KMk=;
 b=kPGCyjQaCZNzAEw9aboJd5fD5qpqaEte2H7wYMz21Z6Op5o6XsUizHQGsZWQlHaYBeYx7Vx31lqJgHLWqY0k469rgehdS9DIGOJueNioRDF0qAHTAPxUKVZaAxJpJ7nLzDmoyUXispSf0yQe3MXi4V1vPPeVDZoJcThiOuWLn6RBTIH4N3wqh9rcu+RF4Pvtzf++6WWmvHf3vyfvqgWCmjfEWHE3zHRzVv8bKprqF8KtjXM7s8byS8LZN9mmG774FImY9piDcSZodMit8f+nfu5UfYuVfv8VLJ1QNDvI7hZKvjGQMbYVxB1uVi+hjZMMB/nCR86koemx5fOBjxr75w==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BE1P281MB2930.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:69::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 08:54:45 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4342:ef1e:e80e:196c]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4342:ef1e:e80e:196c%3]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 08:54:45 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio/imu: inv_icm42600: Use max() helper macros
Thread-Topic: [PATCH] iio/imu: inv_icm42600: Use max() helper macros
Thread-Index: AQHaBzdtn14Q6Y2a9k+48ElhB6yjgLBdV6/m
Date:   Fri, 27 Oct 2023 08:54:44 +0000
Message-ID: <FR3P281MB1757821128DD28BD9F2742A6CEDCA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20231025113544.4954-1-bragathemanick0908@gmail.com>
In-Reply-To: <20231025113544.4954-1-bragathemanick0908@gmail.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BE1P281MB2930:EE_
x-ms-office365-filtering-correlation-id: 17cecac4-c3a5-4294-24dc-08dbd6ca5dea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GAZJvjj/7EHd00qSbtBUHiigm/7j/Imi5Uf/JW56zxsXJoPZ6H+Uxl+QMVcAogPkvb+Z+oyW1GvzlTyISFSuCJ1Yqvexic70xW06yF4tbv4QclVHuLDcizw07YbkDILtHAcHkngG3ontqDSGl2N8ZtPanLt9kSZL9sbAzkU9LhtziF5htK3CBpSY0GlEEJB2XPX7dx9VGErCICxM5dm7SH9gb18g0+fevJZgTXnoETdyej6eiUj3wG291fK293oIIKInZr49D28bH/6lXVIecyIwG/A6ix8ENshtzjPI8A4uxx8z7UkpacaNX1sWe6dr01ACRkw/XIXoyjY737fa1LTuOjdStrLy1UG3Jc7Lm3MQQrtSCC1O/lIpOQjrUaC1f1xtrI+cjsVzwvwC55BpdqqfAkcCkAxat96nQBLeE6JSjWBNkMNP44WoeGkv21bCgvr4MyQb4qLUTR8x0QGqAth3wmhh2m5jfZnZsw+oPRQ8gd8iPhw411uU7PboBMSxhTLAJg3wAVqbh9cpLdzVTvuqOTaIBXgeUbDDXwOoVsXpD7o8SQb0Z3yyKdiFiFsFDIe+VbqO36+ofKpZsVHBRAVW5f2agRQ1W8k1p36LkPQgNy0KQRNAHjn0jyWAprUYx7KlL6CFJmkUA10QET8jZ+6DCf/R8ShuSUOaKZyg1t+Va2ouhq870V3z27cUsi8Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(346002)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(76116006)(8936002)(41300700001)(66556008)(66476007)(53546011)(66946007)(64756008)(9686003)(316002)(91956017)(110136005)(54906003)(8676002)(52536014)(5660300002)(66446008)(38100700002)(3613699003)(4326008)(86362001)(2906002)(38070700009)(71200400001)(478600001)(6506007)(7696005)(55016003)(33656002)(122000001)(26005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cU5WVWhpb21Qdmt2alhVRXFSWVB3eEVuZlE5aXhBMUxEWVZlL0xiSkRqK1VB?=
 =?utf-8?B?cm1YeUphWFZJNjB2S2toOXk3MWVsenpZd0RHTGQ0a0doSEducTU0SEZIUXVp?=
 =?utf-8?B?Q3kzaWkzNGt4RmtjOXJIUVZISEVxQ2d0dldER0RmUkNqSUEwbktFL1d4MitZ?=
 =?utf-8?B?U1lybjdFd3p6Wm1rd01XYjNyY3A3M2F6L3cyRlBuVm1kams1bWtVSUdrSCtV?=
 =?utf-8?B?dkcwRVVrYkxCZ1R4Y2JTS2p0RDJDUTVpZm9xZnFUdVoxV3NXNTFCQnYwZTNm?=
 =?utf-8?B?OWhBM1YzOWVxeUh5cWVVRW1kMXBncFhNSmZIS3J0NnJOZ0ZXcnZzeDg4NmRQ?=
 =?utf-8?B?bFRJT25UNnhuZkRpZWRoTElRQWxYMDltenZXdk5ZY3c1TkdvdU53SEhDYnRn?=
 =?utf-8?B?aVJITGNtakZ1am9mdjdRRWhwNksvcGN4MHliTTV4RjVmenlvYUlFbnRIZWFL?=
 =?utf-8?B?eXA4cHEyUFJ4b1VmVXBmUWZnaTVpajlNckk1aWpjZkQycGFDRk80WDFlR3F2?=
 =?utf-8?B?UFFuWlhQWUw4Qjd6WUlSVlFRdnlUY0lEczJRYkhJK3RJQlZuNlR2YSthS2N4?=
 =?utf-8?B?WVVaZ3FmOUFLSi84cm80VlNqalZwWlNMbHYzcGUwNWtQQ1Q0WVlFZzc2bk1p?=
 =?utf-8?B?RnROcC9qRTFiUkNKcVpnYVJFZEIzR2VsZ01TREpWT1dUOFlGVHdZVUF5VTVt?=
 =?utf-8?B?aWVKOTh1cW5kOE5BR3d0cmE3K0JPQjliZ2FxbjRKa25TZDA3YmNvRkhrSGNE?=
 =?utf-8?B?SEFpZXA4NS9uRnNHakhsN1p0bFpVSnhSQXRWVkJ3aXExU1JLSUNHRGRGUEEx?=
 =?utf-8?B?SW5vc0lNbWY1NTBoZ1VIN2gxYTBMb2YrRnNPK2p0cVNwMGlaZGMwbHpYWjlq?=
 =?utf-8?B?bHlLSlFBanN1aTE1V3llMndMRTNwUEdhT29sRTM2U3hJK3RTclU4OWVUZUV6?=
 =?utf-8?B?elZSTGprVHRnSkk2M1l5V2F6Tkt0dkNwWkF3LzRCL1FITGxiWGZnMU5Scmsz?=
 =?utf-8?B?akFpT2lrMjRmTE1NQmZnZXBSWmZwREZIR1dqUWNGUXNhZXhGay9JQ1MxMllV?=
 =?utf-8?B?RFd0dWludk5mUVdmUm1mc25EdjVaWnMzVlpoZERoN1dWeVBWbTJRWTN1R1Uw?=
 =?utf-8?B?TTRFYTZLbytVTmp3UENxeGZzS292bExCNzNpVGg4dzJOckFNOUpYaDlVSlA0?=
 =?utf-8?B?WDJYZEl0eGh5bysrTzAwSGlydEVvWDlWWUJqR3FObmQ3ZjRpdnlGdlBMQjNR?=
 =?utf-8?B?dDNvWTZENlhLK1JWOXRhUFA1RXNvZkZOb2l5amV2MVVpUnpERDg0NzFsRElH?=
 =?utf-8?B?eGNGSjM0WUthTTF3RUYzZWpVN0gvUk1nYlp1c292ZnFGWGlIMHMwMFVoMG1n?=
 =?utf-8?B?RGR0bG1uWkFOY2d0dkt1UE5NajJpbG5QLzdLZjVuQlZidTVYRS94L1pUYWQr?=
 =?utf-8?B?d2kwMDY4SlZ6b002UGtZNjVVUmRLMHB6aGNmMy9scHVVYUlyS2VNcThRZ04y?=
 =?utf-8?B?K3NUNEZHb1FXclVVODZQd1JuU3IzK1Z3NUp2N1lUalhsMFhlcHRtREFlR1Z0?=
 =?utf-8?B?VGszMXB0YWJydUFraW50bnY0NVBwUmhhZ3FTSHp5Nk9sMllCWG9DUmczY0cw?=
 =?utf-8?B?dVNoZlN2QnlIZE5tOWd0OVpScjFyNVBwb3lUU2JMWE5VNzgzcW9WMTFxWEFR?=
 =?utf-8?B?cGJtcjdqb25pU1k1NS90dml4bHJHYnlvOG4rcE5QOFVzaW5nN2RIMHZCaURL?=
 =?utf-8?B?aFM2SkZsOGZ2ckpHUUlQTk5TZkRjTUVYVkhVYk45TjBFWFRFNUdmSGhUTzlS?=
 =?utf-8?B?U2pacFR4TkFZTFV6R2dQaTRWUTVpTWxQdERzVDJTYkROOTFBMzdwR3JVSWgx?=
 =?utf-8?B?b2kzZUIwWnZzeklDYUMyclo4a1dXRmgvVWtsYU41WEQ3anVjVHRLTVZZUXRv?=
 =?utf-8?B?ZzlBYVZFUEVRR2MxcFpDUUVQSzlVL1NudFZ4SncxamZKT3k5dkI0L3RGMFV0?=
 =?utf-8?B?ejVxL2Z6Ly9pN0J5TlZTbUJ5Q0NZNC9TcHl4NUgyWWdLMDlJbFdUN0dwd1Bv?=
 =?utf-8?B?SkRhNnh0eUpmWnljak4wR2tYNUpiVnAzT0JDYk9hVEF1UFFoSUdzTG85akp5?=
 =?utf-8?B?WkM3ZGFCOCtmK0pJZXZLa1JYTzkvL1Y5dWZkVnJQckJwblpMK2FqL2IrOUho?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 17cecac4-c3a5-4294-24dc-08dbd6ca5dea
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 08:54:44.9920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OIOnFRa2rY+E4FJ8nxBGSEm7t9VpdCfGoiSl1ty5+vmeW93hpL5JXAqjnQkypaVdoK3zTDNQsnFku/k+JLHKJ3hwzEVYVFvb4EryWmlKsns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2930
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_06,2023-10-26_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sCgp0aGFua3MgZm9yIHRoaXMgcGF0Y2guCgpUaGUgc2FtZSBjb21wdXRhdGlvbiBpcyBh
bHNvIGRvbmUgaW5zaWRlIGludl9pY200MjYwMF9neXJvLiBDYW4geW91IGRvIGEgcGF0Y2ggdGhh
dCBpcyB1cGRhdGluZyBib3RoIGZpbGVzIHRvIHVzZSBtYXg/CgpUaGFua3MgYSBsb3QsCkpCCgpG
cm9tOiBCcmFnYXRoZXN3YXJhbiBNYW5pY2thdmVsIDxicmFnYXRoZW1hbmljazA5MDhAZ21haWwu
Y29tPgpTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMjUsIDIwMjMgMTM6MzUKVG86IEplYW4tQmFw
dGlzdGUgTWFuZXlyb2wgPEplYW4tQmFwdGlzdGUuTWFuZXlyb2xAdGRrLmNvbT47IGppYzIzQGtl
cm5lbC5vcmcgPGppYzIzQGtlcm5lbC5vcmc+OyBsYXJzQG1ldGFmb28uZGUgPGxhcnNAbWV0YWZv
by5kZT4KQ2M6IEJyYWdhdGhlc3dhcmFuIE1hbmlja2F2ZWwgPGJyYWdhdGhlbWFuaWNrMDkwOEBn
bWFpbC5jb20+OyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnIDxsaW51eC1paW9Admdlci5rZXJu
ZWwub3JnPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZz4KU3ViamVjdDogW1BBVENIXSBpaW8vaW11OiBpbnZfaWNtNDI2MDA6IFVzZSBt
YXgoKSBoZWxwZXIgbWFjcm9zIArCoApVc2UgdGhlIHN0YW5kYXJkIG1heCgpIGhlbHBlciBtYWNy
b3MgaW5zdGVhZCBvZiBkaXJlY3QgdmFyaWFibGUgY29tcGFyaXNvbiB1c2luZyBpZi9lbHNlIGJs
b2NrcyBvciB0ZXJuYXJ5IG9wZXJhdG9yLiBDaGFuZ2UgaWRlbnRpZmllZCB1c2luZyBtaW5tYXgu
4oCKY29jY2kgQ29jY2luZWxsZSBzZW1hbnRpYyBwYXRjaC4gU2lnbmVkLW9mZi1ieTogQnJhZ2F0
aGVzd2FyYW4gTWFuaWNrYXZlbCA8YnJhZ2F0aGVtYW5pY2swOTA4QOKAimdtYWlsLuKAimNvbT4g
ClpqUWNtUVJZRnBmcHRCYW5uZXJTdGFydApUaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBVbnRydXN0
ZWQgU2VuZGVyIApZb3UgaGF2ZSBub3QgcHJldmlvdXNseSBjb3JyZXNwb25kZWQgd2l0aCB0aGlz
IHNlbmRlci4gCsKgClpqUWNtUVJZRnBmcHRCYW5uZXJFbmQKVXNlIHRoZSBzdGFuZGFyZCBtYXgo
KSBoZWxwZXIgbWFjcm9zIGluc3RlYWQgb2YgZGlyZWN0CnZhcmlhYmxlIGNvbXBhcmlzb24gdXNp
bmcgaWYvZWxzZSBibG9ja3Mgb3IgdGVybmFyeQpvcGVyYXRvci4gQ2hhbmdlIGlkZW50aWZpZWQg
dXNpbmcgbWlubWF4LmNvY2NpCkNvY2NpbmVsbGUgc2VtYW50aWMgcGF0Y2guCgpTaWduZWQtb2Zm
LWJ5OiBCcmFnYXRoZXN3YXJhbiBNYW5pY2thdmVsIDxicmFnYXRoZW1hbmljazA5MDhAZ21haWwu
Y29tPgotLS0KIGRyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwX2FjY2Vs
LmMgfCA1ICstLS0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDQgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vaW11L2ludl9pY200MjYwMC9pbnZfaWNtNDI2
MDBfYWNjZWwuYyBiL2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwX2Fj
Y2VsLmMKaW5kZXggYjFlNGZkZTI3ZDI1Li5mNjdiZDVhMzliZWIgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvaWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwX2FjY2VsLmMKKysrIGIvZHJpdmVy
cy9paW8vaW11L2ludl9pY200MjYwMC9pbnZfaWNtNDI2MDBfYWNjZWwuYwpAQCAtMTM3LDEwICsx
MzcsNyBAQCBzdGF0aWMgaW50IGludl9pY200MjYwMF9hY2NlbF91cGRhdGVfc2Nhbl9tb2RlKHN0
cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsCiBvdXRfdW5sb2NrOgogCW11dGV4X3VubG9jaygmc3Qt
PmxvY2spOwogCS8qIHNsZWVwIG1heGltdW0gcmVxdWlyZWQgdGltZSAqLwotCWlmIChzbGVlcF9h
Y2NlbCA+IHNsZWVwX3RlbXApCi0JCXNsZWVwID0gc2xlZXBfYWNjZWw7Ci0JZWxzZQotCQlzbGVl
cCA9IHNsZWVwX3RlbXA7CisJc2xlZXAgPSBtYXgoc2xlZXBfYWNjZWwsIHNsZWVwX3RlbXApOwog
CWlmIChzbGVlcCkKIAkJbXNsZWVwKHNsZWVwKTsKIAlyZXR1cm4gcmV0OwotLSAKMi4zNC4xCgo=
