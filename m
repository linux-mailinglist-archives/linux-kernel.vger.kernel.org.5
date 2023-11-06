Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B157E30C4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbjKFXMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbjKFXMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:12:06 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916F3D77;
        Mon,  6 Nov 2023 15:12:03 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6N756k007811;
        Mon, 6 Nov 2023 23:11:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=PAevKEeXQ9i/AUHrqB9hgF2cqpZPyD6T76WQfhBsS4M=;
 b=p20lEcV7oXqkxXklJa6/7H3sq46PcLCoNI0FmyiyT+xtDSz9wcxs0KAHZDiGAn2rWcTU
 ZyBWAson6yJWlte++infNS6tYTqIE95RVNyBcb1YQzc6yF1QKj9SZ8F32fZrUm3MHMGu
 Zlr5fWNiFq2AdnkB8o2X76IbOmg/1fLj+iY5QJEBPHJ8v8psqHkMKMMKjZjZrVAifoiM
 MX6Vj9FN9GHhUBY5pMrVGai8ss164TEExCZxcITp1Txpa7rHJfkNtR92xOmCQTK1IOzG
 HRJVWQTAosB1EacIUeNT7Kq2PucnXBUV51W31UVcztZ5ZdHOLwc25BZZBH4qF9rDaNrU Aw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u5cx14mnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Nov 2023 23:11:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6Ms9hL038323;
        Mon, 6 Nov 2023 23:11:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u5cdcppkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Nov 2023 23:11:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZXCWBOE8K8YtX40JRAnJyqUehAIZxgv9u/6cjuDbFd59SlRkXc3ucqOoNBxIsXO/IFYIbxb9tWP683vBXlk7mviKlz9AVsX4GwHK/xCN+VuSvNrWwmfJnDaRntxN04rzGcVDFKJ+so7JVT6M+iEB7mrb+G3R5aIPzrmrDQOJ63/mbDIxY0sjxpbK0mgSkDJBQkbmGI20YaS/Ha8VtStLQBq/sPpF6YgnUy2zWTKNiydXZzbxnTQzGGQDfYY+tYio0DpQQ9t2x1LnOAjF6wi8wSmkMGqQcDs1RdSAaBiMSVr7WLjKNY0bzW3rzO5V5TdtbisVRLczMU5Lt6Ht6kUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAevKEeXQ9i/AUHrqB9hgF2cqpZPyD6T76WQfhBsS4M=;
 b=DsinV10ANufpHUTEU29jTGLFHQYhBvhIjoeyrUIkpkPVV7Nv30xujg2URLvt9jNyMqDfHkgRU092hT/YCogRvEqMhpsd+AVpyFOY+zEB1EcJJuz8e4Bfb/XC3V2Tu9Kx2DmCx9dgfOAYB8JxXnIVBwmdcZkKnenxSwh7YMT+gsjiunhhUqIIUt+G06ZvSEictJO/lACPpFeUnD2bnOuc83vHSgy2hDFJUT2cBq6f/nuJQUzMXPpXZwlMhS3qV9W8sF9ao28IPUeZApoYIoPdltpsJ8NStqNafd/P2cMc1m5jfAj+KPe85GBU6x3nZfJpTk8HDh10a2OwKtEZ+CWtOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAevKEeXQ9i/AUHrqB9hgF2cqpZPyD6T76WQfhBsS4M=;
 b=J6do0iqwBEv7mBZxDfd73sBcMO911V2yTIO4j2XE+GqlBQdHdbw4cQll6d1i6WcgnhxnbQFmN+c/2l1TfBsZdKBJV9FAF87DnFveLh2TOSezSfd802Yp0uw2gyy/KF20sjl5eUFbXNaDoAUScLjzSCByyDxv8fIhfwItVY1+b2U=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS0PR10MB7479.namprd10.prod.outlook.com (2603:10b6:8:164::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 23:11:52 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::adf2:9029:9b90:56f0]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::adf2:9029:9b90:56f0%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 23:11:52 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     zohar@linux.ibm.com
Cc:     dmitry.kasatkin@gmail.com, jarkko@kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, eric.snowberg@oracle.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] ima: IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY cleanup
Date:   Mon,  6 Nov 2023 18:06:24 -0500
Message-Id: <20231106230626.2730342-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:510:174::8) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|DS0PR10MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b1d6e5-e4f3-4cbf-2aa7-08dbdf1dc330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1bPu5x2nmT0sFndwwu7c5IBr1l89ebPJ8dPuK2xxfasZEQ7phPgn6tmpPhpbPamj36JC+S26D/QpB4NHDXR42iPajMP/zdBn57vgJJEZ000/OvKcy/x4hfZAEQNZlPYntWeQUwu2LQ9LxaG7CMrUD6hQLcImq1VhO/kK+boaZ/PEmDBpJPUYwketc0fzI+nsYJ0V09vu6f8yyXaIZe2XX8Cb6pnP6DAlffKoO1LvkAPQD108DI4NV8YMpvEpcesZJuga840WtAUJkNNNiWcNZXIcGXiQBKMWCVD/9AcdkqalhagUGG/W76e7SlCNfox/QblN/5rxkCXDEAwJG9iDE+Cp5ov26uZ7+JuwZpN/6pVaOyT/n1M9+91ILGE4RrOGsD2LmvOET/iqah3zQxyN0b1aPJOCR7dzLoxfEMecqpNAOhi/qwLF/4xrjIbW8Vo/TXPWZnXi4wU0kgksHwUIYctkkIA8yPcE2oL7zy9E+tCth9ebXPqDs5IoBeTFdQEKsb3B/rFuXnO+eVvwHgj5yVYwiqcLzjR4pXLK/NicdpZJjXwkKFM/UU7qEnYN2lsI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(366004)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(8676002)(8936002)(4326008)(2616005)(6666004)(6506007)(6512007)(5660300002)(1076003)(4744005)(2906002)(6486002)(83380400001)(478600001)(41300700001)(66556008)(66476007)(6916009)(316002)(66946007)(44832011)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9TISmgHYUZDaEJSgdLVbrdMQg1cjv+DQ2ycwDbSFk3wogaHIjiCWnuGJPwj2?=
 =?us-ascii?Q?Py485lQnYXpJ/hTgvWnOTAZ8Y4erAzgF0N0QDvgRQ7b7fJSLwvQKaaAY1mIb?=
 =?us-ascii?Q?OMkC+lHT6ulIOSPlZoWe9CEJibhc5PqSxUGrETMgHL915MuvkJ4S0zGOzZjr?=
 =?us-ascii?Q?LS0TYDGy6Yb6L436/1sKF3U12JHsLjGskif2m3W6+MmcOUp5NdGXuERUMNY2?=
 =?us-ascii?Q?KDPxkStRS12Kk1IXC5r0fiaEbCNGSCx5sOmWR3Z4UMvLB/jhuL3VSQ3iOAdt?=
 =?us-ascii?Q?ALldr/ylYTGTg3VX/TtlK+pZZFNAI6uzBuM57Z2wCMP676AElyO4t2HkRPlf?=
 =?us-ascii?Q?3BMSKysaOaNKqCpb/ASk59YOz1Sau8OcuIXtVzXXMqa6xKszqJ1Ibfg/GaO4?=
 =?us-ascii?Q?LSSeILK0fIG2KpVFu/BOdA+s+LDa2w3/r2FjEdO92f2k+n7KSxzLoC5+uDch?=
 =?us-ascii?Q?4GtLKtN0ZICK598KXkoEo8L5KylOfyLANDGMuM/c90oq5X4XNpt6q2ngtgwx?=
 =?us-ascii?Q?GbsQcUWr1pwbcaUFG0W21LtfLu0yWzAklW2bqTFmiWBy+EvvAdwHYQMKjgKp?=
 =?us-ascii?Q?1bR11XwIqOtHwXaPbmVSYzffIxu/0LrwsSsywJDEBqkEQUw5nRtkQISWjXa/?=
 =?us-ascii?Q?7b+fOfG8EJCtnWmoWtjQXXksIDt/YbnGEbp3rPAUJB1L1cEpGPujvFVwFfKj?=
 =?us-ascii?Q?RB7Uda1cFUI3iwz8XmsjSOF/okMQvtGSpfbAkWqH9c4VeNCgKmEodsId7JOr?=
 =?us-ascii?Q?1aW9p5omeVjh6uVj85sVDm+50T+lLOwPRQ1TW3scg/lmI3FGJ8AtPmJQGHO7?=
 =?us-ascii?Q?yCFXo9tiwNxt0OoCF6uKFk0WnD+aXpNIGSqHi5lfyM8f0ul/FCiPEBrCsTtq?=
 =?us-ascii?Q?aplBtXBoB9mgdr6jydkxoVEGSmZ/pO7K+YOJ7kgzVojw4+HdiL/YIqTjTYIn?=
 =?us-ascii?Q?7y6Dfx7C0xOooX548EHOjQLsVe2e6wVUEPQZwULM/sK4GDi+EgCViCk5ZM3w?=
 =?us-ascii?Q?aVubjyW6ogtBr2GUods+3r3jh+XIVbD46aCma1Ps3YlGNHSvZeUEvVV5M98Z?=
 =?us-ascii?Q?UtjpLonHDx/reQ3k0S51M8FRRecnKFguG+A564/k850cr77SCSD9kQ1xxP3e?=
 =?us-ascii?Q?ekW0bdw9oFPWh9mhDapxYBCUKCK7WJ4B8XVbtlRM8v35PzjM6OatBeg9yIIX?=
 =?us-ascii?Q?oR2xZp9O9FfyeUP1Y9jrYgawfy6HnWT6NoBA7ZoPYhk+RettpMNyEH+GFgeP?=
 =?us-ascii?Q?TR5mE7jyqmhRY3x8Vwnl6khApfRKF29Si9hQi0L+9rk7gHnONKgUaqwxs092?=
 =?us-ascii?Q?LuATwFvP3WzWsFU+5lX1mx3Sk+w5KZm6osSojD6iDIpMkrTi7oYxID2XI/ZQ?=
 =?us-ascii?Q?5IF3/jpebkXWb75efHv0kLxEcuyZ7cTLoN4swbq5jVvm+WxqKR8qAbZ0mYs1?=
 =?us-ascii?Q?d8rQ74gnQIIL8ao4BBw99Adq9ss1MRh7XFwZUjTeLvu2ruCuRAOcG4TrskSm?=
 =?us-ascii?Q?sjHSASageXLX8GF0Sofwqh9ibqyiBETuu1ANFwW8EhdWHpODu0Oovb4dXCn1?=
 =?us-ascii?Q?z4R8/QpF3ISJi+CTQ879588TChDyYTB1DaSnCxypF1IcPW7rSjh81TguSecB?=
 =?us-ascii?Q?7InitE5ek/0Q9FkZhhCLG4E=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3oVAHiNPst+I0v1A5OPVBP2tgnDdeyqCctdhFlEeLO1RbQHiEFwDBdkwq6pO?=
 =?us-ascii?Q?Lk4P4wCa3fEVX9dQc2JETe8WrCsEL8Fhv2QPz2zW/cdGHHJIsZnurRIWz6gJ?=
 =?us-ascii?Q?5qNTh+/1the5WtX2Jyv1GJZKBBIviBlDd3NUpvOFLtiGjkcpE5hOAqXp0QX/?=
 =?us-ascii?Q?wdvko9kWPvunGeIypu/A8IX/+e6u1I3ClkgPJNHfAoXPqbMQGalm0lnfX9A9?=
 =?us-ascii?Q?5C+aRW+UShIgsKRlqmTXFRTLnrFAKvifx4Ea78qQd8U9/VJYiCHYw0cPUsRe?=
 =?us-ascii?Q?z/Wlm/pAejFFG3R0iyqwLJpipv3MFodvnA3d/YTHB4G/JZvDhtZohDKmzUDb?=
 =?us-ascii?Q?ZZbW/AAB5AB86DAzmkEzglIs5328rxVeTg30QHw2r3lZ6VVqndT7Ihchu79w?=
 =?us-ascii?Q?Oa51YDSibcrgdPVz3T7JirXebQJwTZDno7xk6Z/supPpz+oXmh4uYhHECG9p?=
 =?us-ascii?Q?ZJaeF28AMMVECqEMSCeNGXtxZqFVmiLxPQEZ0PTDYL7NNxrvSO5FgRed10Op?=
 =?us-ascii?Q?IsF041i7Y+pfkdDmQXMU7AXKrFXCWeLXnwD1MXKIa9Q04/YJv6byG5KmFbKj?=
 =?us-ascii?Q?1WjxbGxkMRToLzI8mEM4NYOJocQ8riDu2m2Df8py/iHVZ5S1fdoZHKlBXXPq?=
 =?us-ascii?Q?3X5bcGgugxFMpaD6uT8JkRyc78QUZnD4xcM8nSm3l0g0P8CDUBHyhpGJFua7?=
 =?us-ascii?Q?pkjfpfa1QB1CizbYQTstV8sXDSxtOy2voQk5l/s+9AXny6VM6Yr93IGCBBio?=
 =?us-ascii?Q?zJtyoio87WhZRyPgsXyUe8F7zjavDhhhlY/m6TqpmS6TSymq657a2LlrEx5J?=
 =?us-ascii?Q?DpR5GQGFReEcxnW35zZLGKkLby9s58CPZMlEmYvCRaI/hqOHlmOjZv5sm9Id?=
 =?us-ascii?Q?BY69fikTqT6dw4ads4iSkminyK9gh3/sK0/h4Xd7nigr8bTuRNwz83JxgPJ4?=
 =?us-ascii?Q?A5QG16dQ3WKtbkGSFn0Q3A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b1d6e5-e4f3-4cbf-2aa7-08dbdf1dc330
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 23:11:52.6000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRnHo/pLJu8zfsBdsqoxoX4rFynm5PwXkVqhBaH+ns0xu72RGshJzakSEMgzH4vjyE3F8VoXnZaJn+tqnw13ecqYrfNw3By6BHq+KO4bors=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 mlxlogscore=811 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311060190
X-Proofpoint-GUID: IGLbYrwUftf301mnteKw4z1GhmcFYeI9
X-Proofpoint-ORIG-GUID: IGLbYrwUftf301mnteKw4z1GhmcFYeI9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the information in the
IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY Kconfig.

v2 changes:
	Shortened subject length and reworded Kconfig description

Eric Snowberg (2):
  ima: Reword IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
  ima: Remove EXPERIMENTAL from Kconfig

 security/integrity/ima/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)


base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
-- 
2.39.3

