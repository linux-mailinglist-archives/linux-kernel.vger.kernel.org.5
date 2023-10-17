Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5B47CB9A0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 06:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbjJQENm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 00:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQENk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 00:13:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE0E8E;
        Mon, 16 Oct 2023 21:13:39 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GKO4wT027764;
        Tue, 17 Oct 2023 04:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=GnNB+HYSNbiX4OrSfDvumXflmzL76xkQvBq1D3GYUlQ=;
 b=O0Y69dY18455KLsfy6v62tGn4UsKebpCs5QTpRaM4AHp7VLtz9g+fMW0sGoHCB2fZ0cX
 WtDSgfFb+kiAvM4VwhNZ0enR+NU9Ed9TvnoRXuZytmwZaj37f964HcNgeJDtZ2KxhP1P
 uvAi1hvCBVCGTi6EYwrUI/sNywjwaOaZmTjNyQZknXmQn63jd7HfPxkw7FBUMyYOiRvZ
 bdzeD7qDulajcy1+zAAC67dcLLM1n5sPlQE0ZhckafCSadE2HCzdSHSsX1KKwEumRBrM
 Lxtxhc/jw8bfT+vEBYqbSAdqB+L2sJZFYeTboeDu+T1ekuzv0iGSDv4pnPDBFI9ChWCB 1Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1cc7hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 04:13:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39H26S5G026887;
        Tue, 17 Oct 2023 04:13:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trg539v0g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 04:13:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0yr89jVe88YxW+UTeqCLo53/DFSV5xu4rSB/hMuprhArRAto04ip0lgBG9046RS5172kXQ8wGXAFwFLQyoPdDl2UeQx2GKlaVbJTQT5bfUnaizJJGrkWQfBrXh7QWFas6a9j7Pu36ZQdDb9wg6k0jLisrDn0Rjkm87KDxvFlzOFe8WGyTPrVuzoPH7gy3j4BMt/kHoGP29MLIkG0zGQOpfT6ElxmB1ibbP+eJAcqrJ7fiyhNr+f+WduBj9RUinFISPwyOhMMFe8IrY6DyogPPIyQ4CmdhsSjz+xcsKxwXa8Nv2MidgNJdxTZJIcWYZIzMJy5raJJMVvxMS64MTXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnNB+HYSNbiX4OrSfDvumXflmzL76xkQvBq1D3GYUlQ=;
 b=l2N5C5EdeoDpnzx4hlUR3y75mZkDdzrT4VCmYP85BzMnL25KAoNLqyw1kOaq2koanoLA9IAO5U+A4aHNxF24JcYzpdassL6WthPzVyvYPmEj1eNzJ0JQho48WTXrCys4XcTa2ul4nUspgCpNYffXDNCwthBIYRK+lQ6joB1dEKAwjvn0+jSEnBNjWSKneWDb6livApA5C6/mQnSULHXW8CF0YalthCQHa2EAPFve9N7UnQDEs4dHCOGWOqUX5ep17ZwYXLuy+hCCkn3M4SnmeXRCfPBTVfEe1KK3nMOfL6UigKqLIe0N5WwqHqHr2i50/Ci48L/3pk0ztdz/nbdEXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnNB+HYSNbiX4OrSfDvumXflmzL76xkQvBq1D3GYUlQ=;
 b=vh+SO+Y2bQY+ec8oDdNeNwgZbKVTD5pDkfogZQi+HEYmHE1A4VYz1JYIO8S2d2Eov8VsaF9ZkzIsIzuhCDn6ibAOoGUB8f90o1en8lFpfTroBfZjCFEpIKzmoWrPF2/7eD/KK4OtsK8BOiGr4ikiU7kyovhMf/z1KlYGy1eYieA=
Received: from CO1PR10MB4563.namprd10.prod.outlook.com (2603:10b6:303:92::6)
 by PH0PR10MB5869.namprd10.prod.outlook.com (2603:10b6:510:14b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 04:13:32 +0000
Received: from CO1PR10MB4563.namprd10.prod.outlook.com
 ([fe80::b0e5:a37e:64a0:6866]) by CO1PR10MB4563.namprd10.prod.outlook.com
 ([fe80::b0e5:a37e:64a0:6866%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 04:13:32 +0000
From:   Gulam Mohamed <gulam.mohamed@oracle.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] Consider inflight IO in io accounting for high latency
 devices
Thread-Topic: [PATCH V2] Consider inflight IO in io accounting for high
 latency devices
Thread-Index: AQHZ/hoaiR7GZT8ggkid9oX8ZtKxUrBM2pawgAAVLICAAHNRMA==
Date:   Tue, 17 Oct 2023 04:13:32 +0000
Message-ID: <CO1PR10MB4563AA8AE670E9EDBF3AF32B98D6A@CO1PR10MB4563.namprd10.prod.outlook.com>
References: <20231013195559.1306345-1-gulam.mohamed@oracle.com>
 <35e3e173-8018-42d8-a6e8-7ba994ff6b17@acm.org>
 <CO1PR10MB4563B1B650C89FA32B60AE1298D7A@CO1PR10MB4563.namprd10.prod.outlook.com>
 <d10c329b-85c9-4bc2-be00-f156c48639e5@acm.org>
In-Reply-To: <d10c329b-85c9-4bc2-be00-f156c48639e5@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR10MB4563:EE_|PH0PR10MB5869:EE_
x-ms-office365-filtering-correlation-id: 2dd2b1e3-e7b6-45c3-4fa4-08dbcec76cf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sT8PIoX2B4aLDslbYCD6I5RF8y3DYLAyW21vk1FcJIt7N/bUerWBaRsyjFW69oj31KcisWt75gTGyvU4fzgM59X0GcyPmbJH0ZyG0V6yO/dBrtW5s9gycGWeEd77mV5/sg71myez/63SypXcjCkbtjIAuNtKOhY3+RVvWYFwKYmWjvuzK0uvjmcQbXn+OCGB669f3shIjaNmLOoa3grAXZFUtEdeCBvR7rNiL8qOMYx4hMEwcwV7V6tnK81qTFpm4rKZZY2U+8go5PwIRXTwmzfqhckB9igR0XPKCBDf5qnawdOZZPvZPVQmvMNcQGtRlS3mibxuNo4g2GvLUqiuNUDHI+P/dk/fvSfFox83cUK3rinsOU5b9OkQ1ug9wESt8wThwoYiZ+sjMroQNlfn92lm0P+O6sQ4sUzRtRA0oNGBEgPcH4rK9j0BTm7DfxDDvIe71Yy+sBGUqNylEV3ueticlKIMSmRtV7r8ThFt1lK1H2YWNGzbE78lrjRpedNMgoXdlSqcqPwpvgFd4iO0W1j2mi+25OKUmD/BcPmAFCGjTgldfx3kH9kaDLpZMxLnhsTLxO4ZnAKXRwevFt6Zzbe+Fl8fMfyMioJZ/Qsh3uLiU5UNWe4C3UnU5F6tX/2c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(38100700002)(26005)(53546011)(7696005)(6506007)(478600001)(71200400001)(76116006)(66946007)(110136005)(83380400001)(9686003)(38070700005)(66476007)(66556008)(64756008)(66446008)(316002)(122000001)(8676002)(5660300002)(8936002)(55016003)(41300700001)(52536014)(2906002)(44832011)(33656002)(86362001)(15650500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzdabjRDZXEyUVhTWHlkKytQclRybVdUNFBmSUVMVEpEVERWZDdJRlNMRGdB?=
 =?utf-8?B?d05xVU5TZWo2WnpLOXRIVytpNWQ3NnVqOXI5ZDBVTm9DcU8zOHhYRWhIOWRv?=
 =?utf-8?B?M2cyZHV6TXZTUUxIaWxPaFZVZXdneEhuZkFsNjcxcW1ITkdMbUx0bFpETndw?=
 =?utf-8?B?UTZ1T0JzSUpiMWQzdE93blNZVWRtUm9UaVNoSUJNWjZLc25MUythZWhNV09E?=
 =?utf-8?B?SG9QSzQzU1lwejBwa0xPNHFuVm9MZVA1RlZVWWx4UGlvUEtCYWplbVlKajcw?=
 =?utf-8?B?OUxwdG9lQ0h1eVBvblpOUGMzMDA2WGtOVUhxQi9DVHVmWTdXRFp1UnlpRVR0?=
 =?utf-8?B?U3hnaGw0VU9vSWs0QWJYZFFhOXcwWEJXYkVNNFp3RDFpL0w2Q0N4MS9Ld1pt?=
 =?utf-8?B?bHVEUzBPUVhTTHc2Y3I0dWdYcWpiVTVKcTlnUXAzQXg3eWJSZTF3dDYrUXBT?=
 =?utf-8?B?a2J0dzdSWDBkYTUzZ05XakxnSk0raW1aaUczOTYyMUlhMXZSTEtxMlVzTk1V?=
 =?utf-8?B?Yys5ODhBYW14dzI2NFAxSnFJZGVWRWZBa3hzSWlVTE5RS2RqK2lqVWNVRnJx?=
 =?utf-8?B?b3NTWW9sOHI5OWtnWU1OYnN1VVRHbUUzUXhIMUFzRGdvZ2tVZVpsY0tLaXVa?=
 =?utf-8?B?VHpmOHY2RWJ5dUM0NW5pRUhWUW8rc0xkS3Rmb21IdW90OXJzZXFIN0JxZHJ0?=
 =?utf-8?B?cFh2ZGl5WlJjOElrOTBscjI4Z3lPeEs0MEVhbXhNTTJ0bkVYUnZ1ZXR0aUgx?=
 =?utf-8?B?Y0J1VkNjTmI4Z1ZmdXZUMHN0bGdkRnVoUVJza1FhM2dXMXI4cUFVTjZwRGht?=
 =?utf-8?B?Y3pkQ0J1RCtSb3FUZGE0NFBnK2lOcEE4em5QMlpQbTdwKzRHQklySEV0aTdC?=
 =?utf-8?B?R0U4U3ZzV1UrcXFkeFZBVmI5ZG5KYXovVkRoWk5GTjlONDZxN1I2VjdweG56?=
 =?utf-8?B?K0JtbmhISm9MNzcvTm9jUHdSWGhNaU9ZeGRQSjM0dlBFZ2ZEa2RZcUk4eVlj?=
 =?utf-8?B?dWczU3htNkVoa0lEb0tSVTl3cXovSHVxMFdTNkhYSERudEFIWU9uMGZUcDVj?=
 =?utf-8?B?SkJRbGx2SWxoNitKVzB0S25iTTlSdlVGMHd5bFJsVUFFMENzQzZacGlRYlZl?=
 =?utf-8?B?QkdEZzJvRUxFV2hyNmxmS2c4T0VjSUZQL2lmenowTHh2bldmZXlYOExCTUNh?=
 =?utf-8?B?UGVmNTBKdTJrMkpWWkpLV2JzZDA3bGJMZjA3SGVaQkNSWWp3MjFxMjBzbmZl?=
 =?utf-8?B?VDF6OHlXZEgyVGszQmZ0OTcyRkNTUEEyRGdoaVFTUWRlY3hQQXJ2ZVpEZ1NL?=
 =?utf-8?B?S01jWThWTU5nMXJoUUxqZWJqWUhYT2ptdTIwRFppSDMveHgvdk1Ddm1QcTlm?=
 =?utf-8?B?K3ZBb2tvaVh6dGFpMG8zUUVXTXdScE1hOTY4eldkTEF0M0U4MDl4TUtiZnJt?=
 =?utf-8?B?TXRycWNuWTUyc2NKYVlWbkVYODNqd21SblF3aGtSS01oT2p1MnhpRGlEdFZM?=
 =?utf-8?B?aFF2ekwraUg0RnRDZ0V5ZEd2Z0MrNC9UVHdVR2F6N01HWWJVUmVHY2tybVRT?=
 =?utf-8?B?ZVNXYS83VmV6eno3SVc0SkVEczE4UmNHc1dIZ0hzZjBnd0tkUGNkL3hjZ2pm?=
 =?utf-8?B?YVhTNzN3Ri82RDRzYVBiSHE2dWlNb3Q2UnYraG1wZDUzM21oOU90OWRNdGpy?=
 =?utf-8?B?ZHc5Zm9aR0RDZjJkbExFME9lbnliVTl5NFhnUFhDcDFtTlVwcDNCTUxhWDhD?=
 =?utf-8?B?YktCY2Fidjg0Um13RWhkMVN5M1RmUHZ1RFlEdjYrQVg1ZGxrTzdPM0lhb1Zn?=
 =?utf-8?B?K2hYYStRdEk2NTJvdVY2bVFLU3FtQXhQV1pER0hYY1dGNHR4T2Z0UEYzbFZz?=
 =?utf-8?B?MXord0JQZ0JEcjR6cjZyV0FTWXNZaENORzlHUzJRQ3RtcjhUKzBGSWMyMVg1?=
 =?utf-8?B?dHhDeUZVNW1QcjZkbEdhZzU4d2NBaW9yTWlOK3dsL0FrNlRGd2Vwa2tJc0V1?=
 =?utf-8?B?bHIyRnVMVHorSnFqQTVQU2dzRGFLUXNTeWNYMWJWSjRKZlVFRXlyeUp6Mmdq?=
 =?utf-8?B?d2t0aWJFVE5OQk1VT01iNmlLT1VJVnduL0h4US9uZzU4ejB2Q0RlYm5veGJF?=
 =?utf-8?Q?PWLBQOaJ/0yvj7ocpvuv2I8S5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5Gpxbk5Z+x/qwUl5pO0rbMV7cEAiDzn/bQDvG2nmDK4n2tLKNdMAvKmhYLzGjw7QQIlG56ccjNAG4aJbZ8+T00XAAoLxQ/dopw0VZ2/7PHJP3LtT4Ub6BqoYZ6na/sT0Hp2CpfhRGzAbbSLb5wv0Rk7w/MsUvKFUucG4RUnUtHDCgSI6aWkeuk4kHBWrn4TmBFUiJhtYz9Zup2NYeWdtK+HbvAnNfm+XUZBCEKy35I9H0sutiWsi+G0tAkyx4sQKBwxFxtlLvQ9gXbUkjxRYypskZ1mXAfW2R7KWLAAYFvh3rO2pq6q3R51dWNMcxiKMHDYBWX/sBUOSm/lKf2z1k/n9N+VYYYF1eEctxIeKt/aJ0ci0/wLQhdYONGXehOps40j9Y3AT8W2b2ZxUZBUYorwMsu/s9XLRHkyYX0YLHqf01NiJlnmyCXLuUGUetRKB7Wx3EaxORUGFdR+RrZiqoIgVR2D72rBTQH2/aq8/V2OsecuvlFdm67SOy+JgSsZYmAnSMJ4ggNgV3y0BOC5r2vyrWk2rtYMW+n8Im22qotx2UgHabsBduLj2XIyzsF0iNL75e5ih+PwJ2iWx+ejc9L6L53e36QCdHzDEaeAJSstEeUSoN2f6IJCCnsNPuLH/zbk5mywcs1I7OXGkkV85D975V/iPcU+1cLb6XyDkbxPbCNbMBRgDyblwTgvJmX26bk+CsUxcPV/5MJwPCkhG76Py+IwOiGpgP9R4tOSJN85QuV4MQNUt0shw9f9p4kQrDRk1xy0zJ/YBFbbCFHTKOPtVdap+fxH3Y/wURFDoVkFIx3egLS8VUx1gbd7LzTtv
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd2b1e3-e7b6-45c3-4fa4-08dbcec76cf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 04:13:32.4532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TLNI9s92Dvh+gK5HpLyw3TpMWsEhS0bnbsYzpsuXiNDAt4fdwrV5S18ahBIMmeDJHxqFtWCDVWRvhcQ29FK30tRPQeMGy3Y3pCY/5c+Eddw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5869
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170035
X-Proofpoint-ORIG-GUID: NFcTNQqY0Z-bCjuRN_nqw3wJiC_Ng63K
X-Proofpoint-GUID: NFcTNQqY0Z-bCjuRN_nqw3wJiC_Ng63K
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmFydCwNCg0KICAgICAgIFRoYW5rcyBmb3IgdGhlIHJldmlldy4gSSBhZ3JlZSwgZm9yIGxv
dyBsYXRlbmN5IGRldmljZXMgaWYgdGhleSBoYXZlIHNpbmdsZSBoYXJkd2FyZSBxdWV1ZSwgdGhp
cyBwYXRjaCB3aWxsIGhhdmUgc2lnbmlmaWNhbnQgaW1wYWN0LiBDYW4geW91IHBsZWFzZSBsZXQg
bWUga25vdyBhYm91dCB3aGF0IGtpbmQgb2YgbG93IGxhdGVuY3kgZGV2aWNlcyB3aWxsIGhhdmUg
YSBzaW5nbGUgcXVldWUgKGp1c3QgZm9yIG15IGtub3dsZWRnZSk/DQpBbHNvIEkgd291bGQgYmUg
Z3JhdGVmdWwgaWYgeW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zIHRvIGZpeCB0aGlzIGlzc3VlPw0K
DQpSZWdhcmRzLA0KR3VsYW0gTW9oYW1lZC4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPiANClNlbnQ6IFR1ZXNk
YXksIE9jdG9iZXIgMTcsIDIwMjMgMjo0NiBBTQ0KVG86IEd1bGFtIE1vaGFtZWQgPGd1bGFtLm1v
aGFtZWRAb3JhY2xlLmNvbT47IGF4Ym9lQGtlcm5lbC5kazsgbGludXgtYmxvY2tAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENI
IFYyXSBDb25zaWRlciBpbmZsaWdodCBJTyBpbiBpbyBhY2NvdW50aW5nIGZvciBoaWdoIGxhdGVu
Y3kgZGV2aWNlcw0KDQpPbiAxMC8xNi8yMyAxMzowMSwgR3VsYW0gTW9oYW1lZCB3cm90ZToNCj4g
W0dVTEFNXTogWWVzLCBpdCB3aWxsIGJlIGNhbGxlZCBmb3IgZXZlcnkgc3VibWl0dGVkIGJpbyBi
dXQgZm9yIHRoZSANCj4gaGlnaCBsYXRlbmN5IGRldmljZXMgaXQgd2lsbCBub3QgaGF2ZSBtdWNo
IGltcGFjdC4gVGhpcyBpcyBpbmRpY2F0ZWQgDQo+IGJ5IHRoZSBsYXRlbmN5IGZpZ3VyZXMgSSBw
cm92aWRlZCBpbiB0aGUgcmV2aWV3IG1haWwsIHdpdGggYW5kIHdpdGhvdXQgDQo+IG91ciBwYXRj
aC4NCg0KQ2FsbGluZyB0YWcgaXRlcmF0aW9uIGNvZGUgZnJvbSB0aGUgaG90IHBhdGggaXMgd3Jv
bmcuDQoNClRoZXJlIGFyZSBtb3JlIGRldmljZXMgdGhhbiBvbmx5IGhhcmQgZGlza3MgdGhhdCBo
YXZlIGEgc2luZ2xlIGhhcmR3YXJlIHF1ZXVlLCBlLmcuIGNlcnRhaW4gU1NEcy4gSSdtIHByZXR0
eSBzdXJlIHRoYXQgdGhpcyBwYXRjaCB3aWxsIGhhdmUgYSBzaWduaWZpY2FudCBuZWdhdGl2ZSBw
ZXJmb3JtYW5jZSBpbXBhY3QgZm9yIHN1Y2ggZGV2aWNlcy4NCg0KVGhhbmtzLA0KDQpCYXJ0Lg0K
