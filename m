Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842DC7E2EFA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbjKFVdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjKFVdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:33:51 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80655BB;
        Mon,  6 Nov 2023 13:33:48 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6FkfC9008589;
        Mon, 6 Nov 2023 21:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=cdxLMUnG7uL7qMCY3v9q5mHm2umoZwbvnfcKngrF30w=;
 b=ccTxxIYJDTUM8sO2oJwqgUW0Cfl6tgMK8i7GitpU8SNXYcL07Q4V1hottOGfKbzJr5fd
 89xLYxs3dkv/iZQy3vWjh5GrCi5nTouzZI2WX9lR/s6Zcju5sq5d7aO1p/6ErE4/xV2k
 yqu8Oj8Wxs6sbSdh8YsEm7uKJkyHjQGSPqZAIophfxWn43JBWE1NM7TyF6X2nDZVnH3Y
 GqJ1MWPoyJuDBtAbhSyyby062Q0xM1XykibtpVWdE0W7NXVEkOyJsQvPmaHQHYigx2Nb
 GDI4T2sxyvV8HHLgSYDGgd5TGw+bNAhK0fzh5cDB3V7Ik6b4M5jLdsNxVXCrwVwlfCrf TA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u5ccdvf3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Nov 2023 21:33:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6KqaqL038335;
        Mon, 6 Nov 2023 21:33:31 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u5cdchrv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Nov 2023 21:33:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+EC8eM4Q3DTLa06LX8LcTQfnclQRX8YU3uSF7zKETKdu2SoKalr47cC78wJJFIvLPxoFJzDNAWaQRQ3slEIfJ7C9nrUsz2pU8jR8tDcbt/xIiyFbcyaSbUJLKyo7VrnSHUC4i7LzONkCwJds4h6wlgvFxzA82LNkNq/fcrmpyM/uZwMaNqv6vzp26R6MhN0gBvlY8BbH4G8rIbXJESZnyZZQGbQKyGT4KpEHFBLk6uIKoITtDkEZrIiwRaycIth4JxXfdBGnJZ1Y4cJTYCHP2O6jYE3nMI4mOu35NJR7Yi0MEV+hOnQ2RToiyI8caDnj0JaPue+GlHrIqF9/A3cRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdxLMUnG7uL7qMCY3v9q5mHm2umoZwbvnfcKngrF30w=;
 b=LELtAkLosRJNnvvFFv408cLdzZpoHKfhic6Y++qSwSsaSZ/ds4rlvhaBERtCHRyUU9L9yVOrxwg8f5ZXP0iFxeWzLzSshzDaacxo+O+gSPQKhyb3mTWAdJX+XjfW286A5dZxbyP/xb3TEFzdLNq5Xe96OtcWDWVvav5L3M+wFLYT5/lkQFdmjxwlYuL8fiu9tYqGbdNhIcS4uuxDXWA0zUHixrgqE7cM2SFtCErmSNz4QiavlLJQbutvL45aZkgy4fILDo63iPqqqLw96iPH0exUyMgpVbM0UdzyppszqIsGyZlR8weqB/FBX5CkSwy7CBuf6zuq7n0ASD00A2TMIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdxLMUnG7uL7qMCY3v9q5mHm2umoZwbvnfcKngrF30w=;
 b=Mq4N2x2D2Lf/0nUjBEjIgOL+XNsvJJEFutPon6RBoErRMdUtYxvr6QFvLrv8+JyMwKIJiHnpYGaviuuJ8phVtWPeP0uxnyis5cFVlXd/hpVyTPBymnnC2mAUYB2DBXV41R+V3JForhH8qyGxkDOaVBZgr8mdy70v1+DN+zjnztg=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by PH7PR10MB6084.namprd10.prod.outlook.com (2603:10b6:510:1f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 6 Nov
 2023 21:33:28 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::adf2:9029:9b90:56f0]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::adf2:9029:9b90:56f0%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 21:33:28 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] ima: Add machine keyring reference to
 IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
Thread-Topic: [PATCH 1/2] ima: Add machine keyring reference to
 IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
Thread-Index: AQHaDa+pZZRsKpDWhk+qRUJ4DEESTrBttPqAgAAhXIA=
Date:   Mon, 6 Nov 2023 21:33:28 +0000
Message-ID: <E078E14A-C743-446F-9F78-7F3DDA8A2815@oracle.com>
References: <20231102170617.2403495-1-eric.snowberg@oracle.com>
 <20231102170617.2403495-2-eric.snowberg@oracle.com>
 <3bae86a2572e1ced0ad069ed6ecd2c0a7d33e11e.camel@linux.ibm.com>
In-Reply-To: <3bae86a2572e1ced0ad069ed6ecd2c0a7d33e11e.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|PH7PR10MB6084:EE_
x-ms-office365-filtering-correlation-id: 74a8b45d-7eba-4fa8-343e-08dbdf100438
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j3Ja46KdYBT/QPrgvCuTnHLFU+XNigQyBZJusI+dYXE7CJp8KHGMxuAOuFCzxpJuXSISWmfMsNdKFbuiWA6M6o8V9FFMFG1cLhXMoUUF4zAt27LkHUw39CzbryiI+llcHR5VU2nlajmogPQzD1NPREoGxwhRU8SWx3Fmyz0IPhQu692zzEDVhIBhW5N6XKmGCMu83txuXSiQsSRshqsdcwcB2gzrvxlXdyGGgqS6csw1Ymic7iZR6JaHEWsS0h5K7aI76fmA0RjuZuddahNylj1Nj5X5SiaavCQw2HYKdxyxCECHcrWbwMpQM4iIHFjv2ug4IAM8UE/FCF8lSbC0Eij7kC9il4C6lWbN/J4mcEcybGv7Lnpl7QkO9EZsOz/APgXmKC2NCjJznHDi9OdvWoLnrjih80OJbAy9g9TdwaOWi/Xxz03X0Ys455+vXUiJNHSp3xeTvZG5jknklWRZt9EOmLGGKIa0loatAyMsnH4qZQykKDCdBGoGwqvpPeoprTYS1m61z8ceFrhBgXzkzlqS8PBKTvIrnm27UlLmyHg/797NnGtIiUSzFsxLLvXuewfeglh+lDcsM1Zmk3DWgwp9HVTg0tOQPNDGb19XWkJbGLQgP0ZNky6f0mCsf/e326wXHp2bZ7f5FkIr6WrFpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38070700009)(2616005)(478600001)(86362001)(36756003)(33656002)(38100700002)(6512007)(122000001)(5660300002)(66946007)(83380400001)(53546011)(26005)(71200400001)(64756008)(2906002)(6506007)(41300700001)(6486002)(8936002)(66446008)(91956017)(316002)(66476007)(66556008)(8676002)(966005)(6916009)(54906003)(44832011)(4326008)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wsZVZDUipdwSGZq6JTH9UNSVEQa2Uds/C+tTf0wqEx8ZWXkoDwmhHl/ue6sh?=
 =?us-ascii?Q?W40nNBWBd8i25XvWH8lYLqUyt88Kj6hvSKiZNp/lViC96tAtQ9sLsWZ4+mo+?=
 =?us-ascii?Q?pB7H5s9gRjD4nQBWJRTKS81g6bzwK+k6JOhKF+N3MqLxsW09if0tUBrfxNwP?=
 =?us-ascii?Q?h0RvZz5NIrO3CKzvi4wLfKPcsWkE1o538be31CAWZjbf8awBu0Y3kKHMoxzo?=
 =?us-ascii?Q?6QxutLyf6dUW0WxOBZZyTRcvn72PtWeYRMHpIqQTE8M/P4xgXfl4RbgGNcjy?=
 =?us-ascii?Q?nhroGGEWphOARAdElhfz0xfRV6ZaLGDm8xzb7sW9CwECOCBRhjPNdsqjwUYp?=
 =?us-ascii?Q?XNcSCooANFiXa1+xZtAsiLMDAhLEn4a/SzNimz7TyA3VNH+ReCRlUT5GzxzY?=
 =?us-ascii?Q?Vjk3spxhFDhS3nrW11SL4Gq1wO5Lekm47zxbRHm6WPJ5cre44dqMkB1q5kKO?=
 =?us-ascii?Q?RDvnmUklDzf11u7DFJAN5nWzNWkvwpdIEg8kTnIJPFfQtzY8yo/xsQK3Xn/7?=
 =?us-ascii?Q?VanJYPVYbNIg9bs785b21O5ciu3jP5yefHtFRj82QPv5JYJ63Vb2eMixVr0d?=
 =?us-ascii?Q?SgwMwjk7CtLZX6k9rOJIGLKei9q0ED1cmPebLvGJDmVDmtV+A03kRex/QEvQ?=
 =?us-ascii?Q?nkt3baHiKBt0oRV+nOLp8ySYR0sdFS8/bpuClXZjUtWPpAtFp0QUs/tVoljs?=
 =?us-ascii?Q?SwUEHNWJsOEU/c6h/p6Qea24lI7yh0J00nznPOlREd150ZVCrrLcgQ0y52Rb?=
 =?us-ascii?Q?xCsczAbBgiSrYN9srCHk4I1hlQkxwOIeZ6iSvd0U6R18LT9776lWGSWL45BU?=
 =?us-ascii?Q?BtEVhJ/iECKLb2fvpTYrBbXhR2n6Qmj3hbO9q7Q1lAZ179bhFJwRwvJ0dMv6?=
 =?us-ascii?Q?IS5alpKoUmLX9/lxG/jtwy8VGOOVgMsJvi7NnydKe1FJzzJvPW/NmcVNaX+I?=
 =?us-ascii?Q?mt/IXeAWHsSstsHwGPGkkpTqmdlqdyHFUaCTcjkarJmrjyL0HDq+FyPJ8DtU?=
 =?us-ascii?Q?jIjXu72+vQDZTGVnPG7urpL1xBCNr1fsyxQW+YwUlfH/2L8axow4m9tekKUO?=
 =?us-ascii?Q?ng0y039udy70HwC+tkKmepZNAFqhsmZQMddhsqDVYBOhz2wl8I7RXlctEr/2?=
 =?us-ascii?Q?Q6+oP/fYNjugLbfGzGg/dmJIfakoUetzeeDbNKAu444Jdk/rjz3dMl96lorW?=
 =?us-ascii?Q?hysyMkB0f7X2wMMx6dGuUrGkqvSuE4ysDttu9cKGePy8WqImSntyZXPbqIZA?=
 =?us-ascii?Q?b4j6WKod+PgmhZ2Iy5n6T2L3i57hcPtGokHy2Xr6wB/ciaBSUgwLBQrDpjEj?=
 =?us-ascii?Q?vjBwZPAiqMTgEARixXkvyrO2FV+QNWIG+8WBau9B8gDzk63wBQFg+Kbj5sdX?=
 =?us-ascii?Q?efv7osAvVkM10LVa36UVu4y6D5Q0y3wjpdwDzs5o4tZyUvGAHmiyq1AJpGLd?=
 =?us-ascii?Q?Z4NMM06spMaHmzRENa0wBNuo1tL7aaBH/iAuIzEkwa33hkdAGpZdnovgmPmu?=
 =?us-ascii?Q?wieaZ/CVNY9eRqA4NjgK0hsRQpzXddHPFtemzhth4Nm4O/ejBnC1UsyQ4qm0?=
 =?us-ascii?Q?avXeopM8kMk4KeFW5bjWPwxuq/J43ggsA9kPMDV8IwlfvI9fmZNDtvjllbWL?=
 =?us-ascii?Q?wg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9BFA86D0397FB4479E5A21E99AD08495@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nNE4ZWo7LpONunXw8o+dfJN6HshynYGzduNE8mOINDxhSIqW9u4TU68Rc8EV?=
 =?us-ascii?Q?XiUHhRJn6s4zrz9u5Ko/H/rTYCejf3AwkJRPm1XOMcnnb46c7zwqBgvBr6J8?=
 =?us-ascii?Q?kk0B2HDsfiAtJ2obQo/8VEaBS7rN7dp7B1yM+Mi2TtHKuV8RFsSo+D8ZW0Nj?=
 =?us-ascii?Q?JlYi6/UE3VJVOsqIWM4PS8hM9DClL6LItt8xEkyki5N+YsW1HPeii9yIgNia?=
 =?us-ascii?Q?GpfPgwxdBbqs0jFPybUMaOWWtgrfE5fi+MgYhfW9oIPTzR7OncJSdTL0W8Sl?=
 =?us-ascii?Q?5pdups12PUzLsfJtX3eUzBAgc4/0AT6bGfspa2zNaP8Po59f/hJfxyKq1a3j?=
 =?us-ascii?Q?XV48rhcF3nyQC6bcrPmO84l6lBm/gmFDwgIoBXstXW+xyICOv16otcgs4dUH?=
 =?us-ascii?Q?X8hq6XtvCDm7jxv9JdisgWflqEKzCKsQp6d5f00Xj/giIJpV3133Aopb4YYi?=
 =?us-ascii?Q?zthFp6Yz19cE8GnXzpvaHfK6HQ08pJJDavOuH+W8j//OIiTvjCyAXwS76rdj?=
 =?us-ascii?Q?hFn6h9qbSZ0pOkvV8C1/sWBvFyHq+GLRTqNUsbN6Vdcm5sZov1n6VI4ocjf2?=
 =?us-ascii?Q?VdA/izlE7pQ3oOrcCGq7WLOYUgNdZ/PMNEAp0KHbfk+ShjtOhXg9rtVJrsfh?=
 =?us-ascii?Q?ShdcuSPUN60AJkFosJ0uTRXsrk0rZT7OhW2ShY28eKBdPrCTYH57bruawiP4?=
 =?us-ascii?Q?bKIGw7zrSBdwMTmbEiFFgVKu2ZQXliEGkvN99BcHa0sUGlKRzhhqPevNPC17?=
 =?us-ascii?Q?MzweYkTdvFiYwm27G40fdPsEc5qvkuy7N+eCKffjG62d2zJI0hpA2GlrQZHU?=
 =?us-ascii?Q?JpkrJK2O2iv5M5YlxtGQsmkhFKi2Digdlt5pI2CBQHkvutKENY2aJaJX5GEV?=
 =?us-ascii?Q?YzcZ+tG7/uNUuUXaYMwo8dvxUWLkHe7Mst2BHNyjsIFxY0OkFuFGghOHx3/j?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a8b45d-7eba-4fa8-343e-08dbdf100438
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 21:33:28.6258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IFD4bNfZU8ukjDgXkzm1wrNeP/8fTzCVs/Vy1RLcVwmA4AGT2CpbiaQXMLVRpFaa/tUlOOEIQm9a5Xpz+jyNnCEJYZjQbY7kJUDQJ5jnv/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6084
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311060177
X-Proofpoint-ORIG-GUID: SdVmS7z77vSQeQXXk5q_U_Q76repO7PC
X-Proofpoint-GUID: SdVmS7z77vSQeQXXk5q_U_Q76repO7PC
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 6, 2023, at 12:33 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> Hi Eric,
>=20
> The subject line is referred to as the 'summary' phrase.  As far as I'm
> aware the length is still between 70-75 charcaters.  Refer to=20
> https://www.kernel.org/doc/Documentation/process/submitting-patches.rst
> .
>=20
> On Thu, 2023-11-02 at 13:06 -0400, Eric Snowberg wrote:
>> When the machine keyring is enabled, it may be used as a trust source
>> for the .ima keyring.  Add a reference to this in
>> IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY.
>>=20
>> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
>> ---
>> security/integrity/ima/Kconfig | 10 +++++-----
>> 1 file changed, 5 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kco=
nfig
>> index a6bd817efc1a..c5dc0fabbc8b 100644
>> --- a/security/integrity/ima/Kconfig
>> +++ b/security/integrity/ima/Kconfig
>> @@ -243,7 +243,7 @@ config IMA_APPRAISE_MODSIG
>>    to accept such signatures.
>>=20
>> config IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
>> - bool "Permit keys validly signed by a built-in or secondary CA cert (E=
XPERIMENTAL)"
>> + bool "Permit keys validly signed by a built-in, secondary or machine C=
A cert (EXPERIMENTAL)"
>=20
> Please add 'machine' in between built-in and secondary, like described
> below.

I'll make both changes and send out a new version, thanks.

