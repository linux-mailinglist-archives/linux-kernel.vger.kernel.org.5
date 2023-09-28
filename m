Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5587B17FD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 12:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjI1KAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 06:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjI1KAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:00:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D09C122
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 03:00:16 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38S8q84J030713;
        Thu, 28 Sep 2023 09:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=x7ReHe3AHT4kiEatJ9iZkW12kDZ78/mzMm50sBAnJtU=;
 b=aY3dK3jnV8kqSa1/pVJ4PM2wPqxUVHDf7yOhjpe3t7H8Eoniq4EEHZPD9qNc5UfTPlOa
 jqLm+s5oFgfWQyy3NAdXYu6VjLD72v7WYZkUiGPL+8rIEhTM5YkaA2hqlDtC5SSEeQ6N
 X1sQ/1L7gIVudGaA/2zzttGAHjQg12a+xvAedwdceZX7Wixypsne0TAvVDYFrOyv1CWy
 BXBKGKmU8eUI2V6COKH9doZ4ygows88DjCaidg0k9/N5zvISsEFoPqxsGnd95ri7qnX4
 dT10qva8NUdFXbzRPeEp8QrsFtMYGn7pIBdoTD9kMbdmmpy4x6EM8w8Z9Sdm8L2lyV3t +Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3v12b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 09:59:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38S8s83x032806;
        Thu, 28 Sep 2023 09:59:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf9fcap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 09:59:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4qOkpuMrQtIqzrlXoHZe4d8iq0zlTb96cMvEBmEnXOndJhGxCu/ZMx1vfJtrQcuNIKsXH42YdNoWHYDE1E8nOXcr8nRlhDCB7pMzBP1NvYF7RYwCDKHagkS50kBobz96rygLnyEBT4l6C8piSDstley+1W1St+1NM1ee943QvpHOkK1zHCpqtCjjKwyXSUoL23pI+PNkm1afcRL7hlp1+faQV7I3tqdJm5z6rS0JheGytNrf5twSi/OlheFGP5asJJvIvRf9EJwNDo81K6pQmWgvdS8VACJM7oz2JRvkQbchi8e4BCZv5musPzb19HAg3XxUEmMh+lcTyNoRPY3Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7ReHe3AHT4kiEatJ9iZkW12kDZ78/mzMm50sBAnJtU=;
 b=PVmZorUu5KsJriB01o6YbU/dLSUnbol/85lfKXMJOTUsqwCW+jq4iw/M1xkrGuLfxuKzWgnAOPgwdRihETizKnUincntxvakRdcwFZjlbN81zitdynrOznsRME8MsDQYXpui4VKtVsXu2Bi7q6Ej1DVzSWc4uUhtk2PXyjaqADJmQj5vw2INHfkQjD7DgcqjNqpZxx9SbNohzdXrOcLKkTw9D48+89k9mabDlBEcrogHuAQwNI+Yj4nxBvvVMyloaRk2jvqgRxFfsMJcdj9ZZwX2bDq1JaN86PZe5bC6SmFAx+UitQMRcFdCd4qIZgd5VmBpv4NxMILph93SkEtGvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7ReHe3AHT4kiEatJ9iZkW12kDZ78/mzMm50sBAnJtU=;
 b=B3OX79LKM+S3h2OoVA1q8aEHrKyEQ1Jz1NpwLGUkRWxO3bmgJcTnf/W4KDVSankNnh7eIdjS6Lw3+4MGgGMbvlfMlsoL2NuOfpiDTbfxMNF7+Ausr7CUnWsSnVNH4oGerIGTXr1QHVip0x7X/G6ZF7+tlS0iutWp8QpSpT1CkU8=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by BL3PR10MB6235.namprd10.prod.outlook.com (2603:10b6:208:38e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 28 Sep
 2023 09:59:26 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3%3]) with mapi id 15.20.6838.024; Thu, 28 Sep 2023
 09:59:26 +0000
From:   Miguel Luis <miguel.luis@oracle.com>
To:     Eric Auger <eauger@redhat.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>
Subject: Re: [PATCH v2 1/2] arm64: Add missing _EL12 encodings
Thread-Topic: [PATCH v2 1/2] arm64: Add missing _EL12 encodings
Thread-Index: AQHZ78xt+tLPd3gYu0Syfj92EogrWbAv/7sAgAAFjIA=
Date:   Thu, 28 Sep 2023 09:59:25 +0000
Message-ID: <4B5AB721-959C-4AAF-BB2B-41638700FA0E@oracle.com>
References: <20230925162057.27548-1-miguel.luis@oracle.com>
 <20230925162057.27548-2-miguel.luis@oracle.com>
 <ec8ffc8f-1f53-61ca-8268-f13616a658d7@redhat.com>
In-Reply-To: <ec8ffc8f-1f53-61ca-8268-f13616a658d7@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|BL3PR10MB6235:EE_
x-ms-office365-filtering-correlation-id: f8ae379c-41ae-4601-323c-08dbc0099927
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xt035QBd23XxyOz5xLzRWuJJPvWnkFPgBjTFX357AgTQued5H/PdGucgks1UVOYawWiWlKsFeThPcDw/zyChOtnwj2LF7jRIzjfpou4oUSWyFuGdsPTl/eJTJMxWHEuGDH4J/X/2zSMpMm9mwDRBS+uIQSPPpZsu/Dvn9tQXQ1VQhw8efUvYL7q3DvySGqfotIYKVLrXjguQ9rtWe2k0h8g/yOZk7nLY0t0j0+3FB1VUIH0pL0Ac3NMg1vcry0FA6lu0sTn8LUjx88nGcwUc7MCN+icvaedl8nSKxtfW7qjIPkueO9JVe77QAmpCRvArqm3iQcftbbfeuQdp2IcCDV7suir/CiPocLzr/IfODt3f61Sha6vMX0/XRCvpqkrGigvyODhcjaKNMarDByNtP/qNo59/+oLcrzsOTqyU0YM5B5LNztXLGNu2nVhY4l8PMqB5gOCNO8njYQP7fF7nJaV5cGDxy0DrFmBjaHZoojJgLUckktX899Qej4AZPwljfQlkWWhwE5DSKkxKsAfqIobZ46PnILEPwsGm89+1UyXF3j+7bFwcspORxNTK3WU7DVlF8yLnF6LDV2iMBmN3wjH81sJcbROD8zAvs+M4uTNzB11N5+nb4up2eS3iUFaKU+XoO2u7/oBkppuu7pj6MA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6512007)(6486002)(6506007)(122000001)(53546011)(26005)(2616005)(44832011)(8676002)(8936002)(5660300002)(4326008)(7416002)(86362001)(38100700002)(33656002)(2906002)(36756003)(316002)(41300700001)(6916009)(66556008)(66446008)(91956017)(54906003)(64756008)(66476007)(66946007)(76116006)(38070700005)(71200400001)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tlrmRvR/2dMw4YH4pRSfAgpO2egiEw0/kX/a5IZ1M10TRIK6lmST08s4v6CC?=
 =?us-ascii?Q?+8BTSALa34CpRTGQbgWbSaUo5AqRMYSusE60hLAm9sm+HCO0C/K8lKfBnR2u?=
 =?us-ascii?Q?MqHzHCKHtI8pozWSTRyB3BbOm1A09k4wBW1VZgbUbn8L44348PTkAw6wTn6o?=
 =?us-ascii?Q?FKcaqUiFqSg7yMCyC1t5yvu29KyPA/G8St35NLKrika4B8DEgyIMQ7Vl8tmq?=
 =?us-ascii?Q?HMlGlaSz/olw2k7dECNhs2MQRvNgBE9eBdgKGCNI9Np9eNKHjYT3llN376sS?=
 =?us-ascii?Q?IcGLVGeIWIjNEW79d6RvOsEeSya57QKNobNuZbT/HMRmAIV/82DqCOu9H60r?=
 =?us-ascii?Q?/E2nUzB8VjmCOJLYkG6jsDsODHDUJpNRxYkS0unD8uLg/pbdZKus8vPTb8dO?=
 =?us-ascii?Q?N7yA2I+wttpIRYBQ37sNYTiH//kGTS+QLPWm9Jp5eeCDbvZjKpXW3Fpv7+8N?=
 =?us-ascii?Q?Q/kQ3MHSpzQ1MzAC3kn8KQB+CIqiKTDBfxYWz5MCbqFXg3u2RU550zoUo/e1?=
 =?us-ascii?Q?6FcOaPQU40RqNPWxUI6FrlSaNOt2f6K26HrymonS8vBweUp1bDZD8/o76Q9Q?=
 =?us-ascii?Q?VTWiGjMuhxoe+eY3M32OY+Qiq+CEP+nOrP+aWbtHlkWNPUR8FOizOtX3mAIo?=
 =?us-ascii?Q?nt/B5VUAuyt2gW7EaXPg7jVupZNpdLMAuCuJhKUvX5bFjjspxMenv6SNGEmS?=
 =?us-ascii?Q?svm8r9AG7CwWExrH+r5lRhCUKsLxHg7zjrD4iLzRudRn7OSPtL+gd4k/L/fg?=
 =?us-ascii?Q?D4pgcfJAImj2z2NuZAfrwzkaK8qIJsmSR+pS/QfBHMS8rXV5iNSw6JgR8OmP?=
 =?us-ascii?Q?PVAbok1+F0zrlDNynmP3XaZFxCTibgF8dBJxFgvHeo6tROQ8lVrsbtqmbbNU?=
 =?us-ascii?Q?1mMMq8Yp9lDWGr96ZM8Q9jXxYY+2bXEi9nB2dbh3P/1pp+Vi8zA+MT4P1GoQ?=
 =?us-ascii?Q?F77EPzDhQPoMr6xBXsQcN2y/jLLRGAFuPgBAoAPFZVOcjst8HJlh062sYSMc?=
 =?us-ascii?Q?w4fsvIBqHjXMWqUNesZg4tQF7dnQFIqk4yeMjWj/U7PHjx5qZML+H1eVy518?=
 =?us-ascii?Q?0Zhnzf3Jqqs+m2SeOQiRqzMBPwruIu6AeRCyn0Rsh7bLMFdcslFUEFUUpDBe?=
 =?us-ascii?Q?VZOriavRtds4ePhe+0OyWXGJ+sbCz/8V3231VTI86SPj2W+G+e2SZ7farbKr?=
 =?us-ascii?Q?Y5crvuO8ShDfToDMHCaqfGfllI7lyCoYMRkJHX8Jhzo07X5RxgIyT3jGXXiW?=
 =?us-ascii?Q?audnz0q8GILXbHqjf2kLXMq5ADdE2BaKZCRIARYkS7Fui9waCfBmxnGwbnPl?=
 =?us-ascii?Q?2gxOLo8dEl6azHyYj3Qmkd8P6k6D7+flPXE06Y9kgB5WAJBWYkHd+/q2Pi9s?=
 =?us-ascii?Q?FQkxyP4QiAu3sQzi8nTBQ9tyXSHziDtNKt6ZU1Dz6NLkfTDd4wmj4RXmljFr?=
 =?us-ascii?Q?hff3MlINoOJDru141a9fjrr6Vxfdbwrm+j7pMMsFFVnD5jN65K6zDbdyT3qx?=
 =?us-ascii?Q?IeenaZZI76KGqdz0+Z60CJ8iqfDCO/Ngg5Yac3vqmOZc63fhWrSbLnRDcDLS?=
 =?us-ascii?Q?efa3nIqtxETsor6F+Do6tpls//X7M9CqHJeu48XQfKnPho7INMUccp07V4fs?=
 =?us-ascii?Q?Iw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B6D5D63A868FC246B9BEA00D97F2F23A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?5t8ygYEETBH1keq/AXzban3xBhpt/0ckB6udneZrFvWLpHtW9KeFwIRfqyig?=
 =?us-ascii?Q?GsvDD+WB5xvQAh9hW4XieVzotICAlLDzaMOaMNRis1+vmeq0ysOGByTyAnUM?=
 =?us-ascii?Q?o1d9w5efoPfNBU+PT19qbjaKHL4SpWaf6TkIr0Ss6oCpNpVyVzGwJAqBqak3?=
 =?us-ascii?Q?uHO7TqM5aU76QoZErD6SWtEyth9Sa0+o7Epuj1vfU1NdKXMTokxhd1qBeRhi?=
 =?us-ascii?Q?IJHzcSmEvznPiMLULmVkGNAUdKCMl9SY6c9YSNn1DnEIjkFjLnlJpXonPnJN?=
 =?us-ascii?Q?1ZcP5zS5bBf99dMyeuZ7QQu6WTfB3y23rTdHA79elWRb2axf0qDgtVltytNa?=
 =?us-ascii?Q?MdehS92waLXaKac25tWKeL8rQquUFPD1INxrAWXyUW9UD298kMd2t+/EfSaj?=
 =?us-ascii?Q?ry8jfa5Wjz29ipFMbUR9sYP7FKlfg4i9nQtUdY3OR89XtUiFEbLk9S4DUWX1?=
 =?us-ascii?Q?z4ZDQm6TAnlId+chyE72me/CjsWDjMJneuGewFIgXAb+KwrudZdkw84DpJqy?=
 =?us-ascii?Q?Lzdz+6512OywAtdtetF0dZFVsTHIh9AnknYqCXDNmJmmaNdqMMdsVX/PuLyd?=
 =?us-ascii?Q?LafXBUZWxNs/+6GIt6v69bFAVIZ45SzexcS36oyY3gdA8ik60qwqVHYze3PR?=
 =?us-ascii?Q?pwEAovRoL5KHXlNLxigMXkjga16pLtDjzrEIxAWWJsmhfHh898VPig2fZWTV?=
 =?us-ascii?Q?UwZVyBKKfSCRuK8HINZgqz7Ny0Be6pX3QaIL0IeagCOxgs46LqtksNGWjSq5?=
 =?us-ascii?Q?MR5QdOk8tXUdRaQjLOsNk6++S99fO3c/RdAXzSJRJLhQXEBYu9+55jUdBFUr?=
 =?us-ascii?Q?YjPNW6wkX4aQYGKQSk6p1rjneFZKx7BrdyMDzojzduIidudNxHOjV7wELabW?=
 =?us-ascii?Q?Xmgir7nOvvySYtZq98rNyJhtxC+A1GSob6XZmSJ8cHi8fVKNTicnifPLmilc?=
 =?us-ascii?Q?JN5bsAtl1muFjB07bGKoTOireR6IfNytV4VoQbr43kaPS840LVSfQJ7UKVTr?=
 =?us-ascii?Q?NDJP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ae379c-41ae-4601-323c-08dbc0099927
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 09:59:25.9777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bw3OXfpNwAzTwT1fVlRNgTHNX61TuH9yukGLbPT+eS/gp58O+daM3w32IYhTTDhlPbG6zOQmS7j4OSaP5aIEsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6235
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_07,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280084
X-Proofpoint-ORIG-GUID: ZZQmtU5UAyTssMAFzgU_05a1Il50tW_x
X-Proofpoint-GUID: ZZQmtU5UAyTssMAFzgU_05a1Il50tW_x
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

> On 28 Sep 2023, at 09:39, Eric Auger <eauger@redhat.com> wrote:
>=20
> Hi Miguel,
> On 9/25/23 18:20, Miguel Luis wrote:
>> Some _EL12 encodings are missing. Add them.
>>=20
>> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
>> ---
>> arch/arm64/include/asm/sysreg.h | 11 +++++++++++
>> 1 file changed, 11 insertions(+)
>>=20
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sy=
sreg.h
>> index 38296579a4fd..6e167bbf44ff 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -568,18 +568,29 @@
>>=20
>> /* VHE encodings for architectural EL0/1 system registers */
>> #define SYS_SCTLR_EL12 sys_reg(3, 5, 1, 0, 0)
>> +#define SYS_CPACR_EL12 sys_reg(3, 5, 1, 0, 2)
>> +#define SYS_SCTLR2_EL12 sys_reg(3, 5, 1, 0, 3)
>> +#define SYS_ZCR_EL12 sys_reg(3, 5, 1, 2, 0)
>> +#define SYS_TRFCR_EL12 sys_reg(3, 5, 1, 2, 1)
>> +#define SYS_SMCR_EL12 sys_reg(3, 5, 1, 2, 6)
>> #define SYS_TTBR0_EL12 sys_reg(3, 5, 2, 0, 0)
>> #define SYS_TTBR1_EL12 sys_reg(3, 5, 2, 0, 1)
>> #define SYS_TCR_EL12 sys_reg(3, 5, 2, 0, 2)
>> +#define SYS_TCR2_EL12 sys_reg(3, 5, 2, 0, 3)
>> #define SYS_SPSR_EL12 sys_reg(3, 5, 4, 0, 0)
>> #define SYS_ELR_EL12 sys_reg(3, 5, 4, 0, 1)
>> #define SYS_AFSR0_EL12 sys_reg(3, 5, 5, 1, 0)
>> #define SYS_AFSR1_EL12 sys_reg(3, 5, 5, 1, 1)
>> #define SYS_ESR_EL12 sys_reg(3, 5, 5, 2, 0)
>> #define SYS_TFSR_EL12 sys_reg(3, 5, 5, 6, 0)
>> +#define SYS_FAR_EL12 sys_reg(3, 5, 6, 0, 0)
>> +#define SYS_BRBCR_EL12 sys_reg(3, 5, 9, 0, 0)
> isn't it sys_reg(2, 5, 9, 0, 0)?
>=20

Oops. It is indeed.

>> +#define SYS_PMSCR_EL12 sys_reg(3, 5, 9, 9, 0)
>=20
>> #define SYS_MAIR_EL12 sys_reg(3, 5, 10, 2, 0)
>> #define SYS_AMAIR_EL12 sys_reg(3, 5, 10, 3, 0)
>> #define SYS_VBAR_EL12 sys_reg(3, 5, 12, 0, 0)
>> +#define SYS_CONTEXTIDR_EL12 sys_reg(3, 5, 13, 0, 1)
>> +#define SYS_SCXTNUM_EL12 sys_reg(3, 5, 13, 0, 7)
>> #define SYS_CNTKCTL_EL12 sys_reg(3, 5, 14, 1, 0)
>> #define SYS_CNTP_TVAL_EL02 sys_reg(3, 5, 14, 2, 0)
>> #define SYS_CNTP_CTL_EL02 sys_reg(3, 5, 14, 2, 1)
> Besides
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>=20

Thanks

Miguel

> Eric
>=20
>=20

