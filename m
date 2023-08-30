Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111BB78DF93
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjH3Ttn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241893AbjH3TrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 15:47:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D1E7D99
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 11:53:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UInbgN026408;
        Wed, 30 Aug 2023 18:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ddZ9ZaIYlX96ohbL+L/v67ViAco4TJ28+TNGKpwzYho=;
 b=1wBBdaqQ5GFL5cad6b4FSqnuHoq7LDWxxhAdFA0xLN08Ix0cE05Qa/LycaHJEUCkPr/4
 kkGZBFeRtK/jiB1wryS1nYLbnshB+8GUQaeKG+cSKwWO7VdIvYy0UpcoIfGSNvJ8lJpg
 yArtJ/7Wo6mcFZnPPZjBfZOdCpJeQQemY7oxrVr0aeZcNO3R1bELzPxOoBLUghZHG66t
 AyD+V9gAQMNu7YA43se0kzJuvsq61C5fQ+H4y4zGUVp8IKt5JUPX2yk1hCmno8jBaGg2
 6eDys2CVLO+jjSArbsy2mgdPKuZnkXVhcc4nak4PHuOppycDtG1/mHWqcfJw5mrcu8b3 Bg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9xt86f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 18:50:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37UIJHaB009143;
        Wed, 30 Aug 2023 18:50:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ssepyapk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 18:50:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZ0Js+WxKxmUEtu7mp5B2tqGO88xK1aA6IGahKpAeE+i9Qi7MkD4WdD4KN/05av/1M6JbSDE60UBb/7+EwwnWaI2uv28mQF8SEssbuzek1KjWgHNs9UyrVMeA9dsB7ARR04/VXbxPv07NS1NOtRnaUWmUtceBGLcfXe2bd505yJ9xB5ZYReBJv9VvdUbg27uG3Q+hTw3tARNeVbH9RHQGJTwahf09YMMA2LVOcEypl5IcN1fB0t0fLHE32ENhLmi2lLp7nMjUH3qLqZFGr+ppaQN80/n8QHJomGVFv/lzmuHqAKK/iluszDz9AUzmMpChyJsm5iaLgx/k+DE6LFo3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddZ9ZaIYlX96ohbL+L/v67ViAco4TJ28+TNGKpwzYho=;
 b=KbFpeiIgkb/FTja0gNDh9SkAijxpzPl33gZXlRKgdPt+e1/tNHT/ef79dozHvLHx1jlkvKpUbltQ4eoAfEtl4fY7IZfDe5gGE3vIsBsIulywdvTJ4evbx0GhctITK/DbeLYKH35pE1tUaUNRiZ9uLhYDPXk4zRh3BCpGpph4XGgnh+io+yZgq1Ht4+guOwUF3uQZqGXXVOrnrFsuCsZQ5LzqmRGShvVJgT0WtwqJKRReiv53VFGhY1IlVx6gNe+ZDql8dTY7EgeLLUiSBVU9pZo/eiHQ0Doi3wiEBKDau3upIZ89I8sH0ROaj3iIcgcLLTLK+Y54AwExKrRxjYPBqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddZ9ZaIYlX96ohbL+L/v67ViAco4TJ28+TNGKpwzYho=;
 b=H0hRP/gR1/js6O3uoMs7LOXOkvTHHFPmuH2GNQesKEUeMBTh+Lg4puykUncycCbdQ9US8lqMvx1y7AB+eZywuUpITwVF3tiHeoo2Fcwws/ey4Ze08BEPzOoiGdz2/yC9Bg/d3fyM0H9jWQ5RiquzcTmPAVCEsMJyzqXOiAwfhkA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYXPR10MB7897.namprd10.prod.outlook.com (2603:10b6:930:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 18:50:07 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::238e:5e86:cbd0:7415]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::238e:5e86:cbd0:7415%4]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 18:50:07 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 2/9] mm/huge_page: separate clear_huge_page() and copy_huge_page()
Date:   Wed, 30 Aug 2023 11:49:51 -0700
Message-Id: <20230830184958.2333078-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:a03:505::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYXPR10MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: aedf43d9-4937-4626-f1ef-08dba989edd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3dS8xJ/1R7CrPbD+dR6vZcgjWD8wA6bWGbSb2uBglyFyp+mvjvxGqq8boK3Ej9cV99fK0U3R3zr+WaCwKTwIpFuTx73pNp/zh6shFstUOvIKmKCGmKNrAmWGtT/MFxkS7qIrvnYtbfv2c/n9g3aC0GAAW+K0Uob2YETrkZ7+1rLSmp0XSw6OgSy34mnbkUvodNXUUsFeO/U+UCHjcchqTTve7v75rIiGbcfPwmeLZ7LkeYDVAmRY7v3rcBeX+nlZPeikMag795x/HG99kmWjZySPuZCDV9Qf+1oyUkEuV4qcM584edCo8pWFXab/oDXUuzybZDc7AicfTVPRkRdXAtBsNsG/6nLsputqkfOVIAt8Gj7wvb/hNbWmjBrJgreZ/LK/gb4FEp5mk8Ex8ZzMly1oPumFiS/O4osb02TQIyG1NU7y1Jk5v6n/jc2jQxJaN4jsWbByj2dNAAnx34udCgMIg6XV00yO9Wjzq5XEuRGlsnR5gdhwi6annh6oNBi5y0WqKiL5NNk61VM+dAHesTj2swToNTQCiLRH595AL8AX+0DpsmfsSg5pwYteh6Iq+jVHTE5SrpM/j/0UHtUxYi7RDB9WTWZNpTvp94oj7hE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199024)(186009)(1800799009)(478600001)(38100700002)(26005)(1076003)(36756003)(66946007)(41300700001)(6512007)(83380400001)(2616005)(54906003)(66476007)(66556008)(6486002)(6506007)(316002)(6666004)(7416002)(5660300002)(4326008)(8676002)(103116003)(8936002)(86362001)(2906002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cdBZC8AWzkNfx1uZVvbgG6AViaUhuYurjupZDuq56u6UIvG3lRELnSJd4zv/?=
 =?us-ascii?Q?0zUGUcaaRErtfTsHTbDi4cARiHHmNz0/ZdZwkSn5ATfeREB7JHhS9R/qU+PX?=
 =?us-ascii?Q?KTJV3Z1ALQKZgv+oTpYyh6ZOa5+ZoCdumtFdtlgJZnm3EUBxogw7HNRqoU5u?=
 =?us-ascii?Q?Xgw1UzeyDDEdDScoWGUP+qoSRuZHxJeNuMnBjG/S5xXB0lBrTCOsWTaRvVlP?=
 =?us-ascii?Q?8cocyMBh5qNe0Z1oDWUR+0KqscAIjSZLgQiAaPFHf2y2RDv2i5cjL6RDKWfW?=
 =?us-ascii?Q?5qGoxVkSYDj+dJjEtoosDAD4MqEu6lmRvTi/ttKR35CJQaEYbrNCjDg5AQ3Z?=
 =?us-ascii?Q?0tP7+MYxKY2xKkUEaYYaK7XPT7AAbjUi3oVY8OUxxuyYy4s26ux8JLU8Cv3/?=
 =?us-ascii?Q?yTd+3QxzdAuk2uDRkncp8IeHZ/5FFp/CSie76LSRCyY5FDkRi4Fg8gyDdCm3?=
 =?us-ascii?Q?Aee4N8IfRNacz/7vYrHe+DWeH/TzLdD6l7i/nrk4ee5TfVvSfxOagDxn1H3O?=
 =?us-ascii?Q?Wh6WnloHWyV9GMF+qvc6fMZx6xsqQ4oDlASZoQJF9NCNFU+YZ+nDxuT/QMuh?=
 =?us-ascii?Q?H2caO4YfslHZlc9IF7QIjwFCMFaMdssV+Izt/OhD3Nq4cz5JyzbhfyR8hrOa?=
 =?us-ascii?Q?K3NPst490g7F6M7mVjcM7cd2bdztvPgtmrML5iZhXMwUECG2BoMxPHrPQD2J?=
 =?us-ascii?Q?hmb6lC49XsvUVbrsJa+f136Mcnyv2BIRxQ3GQk7hkrJuBXZHP+SNQ2Ot6/dv?=
 =?us-ascii?Q?/aQJaOj5ShRt2lhD8T64/vFjR9gK522XSCIdBjGoPDRbGGKKCixQUONd3vfu?=
 =?us-ascii?Q?dWzJXWJVk6Nvag2fob1oA146RhNZwMOalDMobQxfBng4rAUklMcOKjbGzKpO?=
 =?us-ascii?Q?aoVfrVK3NTM0nK0Jb0O9Yf66Vmse0+Z5BNj/A17+wZUIaDLE/FrbDpktNGRn?=
 =?us-ascii?Q?Owl9nxefL0QxkKaaELK9MBkVUIT5PhTPMDsKe6TAO9umYCwN5LeGo/pOKiFj?=
 =?us-ascii?Q?KmgmBHMH4KtJnKrhwhJTmew7ZM12oKkCvoqTWd/gAkVMR0hzrMqKYaV1JpPp?=
 =?us-ascii?Q?n/BlVJcEug0fkYXIi1bDd0SJ6YMOo9orc1xY8XNBOiGtHnPmQXKjaYdRVck/?=
 =?us-ascii?Q?rTzB+8Ly+OVLFBILLUj6EUL8ginnym4PknX0LMyaNxBOny3S7zz1wLAg1Rru?=
 =?us-ascii?Q?eynxB28KNXHIEMuEht/cuzSA+FKlwK1S2IZ2iIL70TELg2yEGqeELYZ6LRoo?=
 =?us-ascii?Q?P36zBMlIjHMrnm5/OTMeLZveb+mNgFCnBg49gD9PI/21z8aXwahn5S291aiQ?=
 =?us-ascii?Q?VHeqBLjKP3E1T/dvvPoH375r0xutcF+5ky1CqBlUBM+rekt8D+yCWyWVi4WH?=
 =?us-ascii?Q?x9SRwM/XnSbE91gy7MOuc/fxkFCm5SlIpktFH8epj/1qFwIXRyJxYW+q/YIT?=
 =?us-ascii?Q?EYSmIGY3zzSkWlu1AY65udPOsn/gKc7ShFNte6/HQwhQaawEWWIiDPQjjZEo?=
 =?us-ascii?Q?/xdGCM7X7NoWJ8fv3KJgDgDGicoDNiDyP32V9XPI49HJb4IZ/QrBdyhypNt+?=
 =?us-ascii?Q?REOFkDNDYYrPu9XG8wLhP3FhOZdjj0mBBeP/0IX+GLl1cBvrUzgypk6hZMcv?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Ussg6HHf/gl5Zp3u1IKZC5E8ZuIwnbTwKehXwriNa1kJuwDQ6D166GaTRhAI?=
 =?us-ascii?Q?0/MOvexgjuB4FrMdG77QMliB5VuPsIzoBfJzThjnlOrmrbYCQHBdXjhLFk32?=
 =?us-ascii?Q?duMfoAJ3DLRKY69iTmNZdYFJI+lrXLZyU2xzJ2tBrIqpFJKNpFJe/zoS5uoE?=
 =?us-ascii?Q?SqLQPXCKqlgYtFs7k3JkZ99u0pHs5k7xuACEQFz/aB3FmWklCqG38/TvQmqM?=
 =?us-ascii?Q?0ptL6ERFvqDdwinz/h4boL/w8X8wZdKACdh7u1Kr3chIof5PLMc1YuMaYab4?=
 =?us-ascii?Q?DpS1gWqK2FnVyCCvK4z2eg2vzP4i4iWCTjwIumjm3MW2oDjwVR2jeyc9pDgW?=
 =?us-ascii?Q?O577C57DlmY0dgbOw1ZxxoKOuaJIKtjqs/sf95Ktoq5rkJqIngPlh1tN52y1?=
 =?us-ascii?Q?XS0G8sp69ypI6JNPQWUcLZx1odYPTV9f0bBttQrcoT7i6PsmqxqZVqqTigwx?=
 =?us-ascii?Q?gTSUEhRBYXJegUqqa12LOPWgllEk7rCB1yol2Omo9jzmTFHgeUUWVL2/57iw?=
 =?us-ascii?Q?QxoWeLSp0lVjVkQNpfDvnGbq7dkUT4var22eamVoh1k7/jBK7uMHpssgpcQu?=
 =?us-ascii?Q?U1IsoNvNWzDtaOn6ArSfHkDxc6yZrmewWAduGtfEUTr05oAGzwxhGMNJ1BL6?=
 =?us-ascii?Q?ARaKc0lfe5lt827uhnJO8pK+Ybsi642728bU746OVStm7KPLhr35uVQoH5x3?=
 =?us-ascii?Q?5Lw//yuF3a8bJ1r0QeTj+l6/H695Oh0xbo4oJwfLlXudJfTUWGX3Uz8nTiS+?=
 =?us-ascii?Q?Pnj1/QNAcY+iOyGN6tMEwCNVUq/63kKiH/YeAZdAHrwY3FjmjOvF9XB9OtjD?=
 =?us-ascii?Q?E2yxvnuHP/u33++wH7F56u1uifaqjKTm0++Cj4qveIYbh6G4wzokfRsseeXj?=
 =?us-ascii?Q?Nfvnez0CEYLEQ+uY73p/M1mI9N9xaBaZg+SPVRn+F/35qWD68UhrgVJh3GBy?=
 =?us-ascii?Q?Di5luZmclMVimzvNyd7OTnpRp0vkvjcggcSOlQ7GlRXI0tvO1UMciQw+PAS0?=
 =?us-ascii?Q?fU0A7nuTvQowDoJejO+5OTgGt1fsHBeixSyyWP+B66lq/jhUZ30xnGaZn+Bn?=
 =?us-ascii?Q?3oAnAy2qpLig0nmovq+A6vUaGfV6MD9Le+6iVk0q7pnij960CggbOSxEqA57?=
 =?us-ascii?Q?Ju/JFH9Mn7oDsD9B+hxWadW9jD6KxiyHchzH5MjC6AuyPsGua6E418k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aedf43d9-4937-4626-f1ef-08dba989edd1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 18:50:07.1748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zn+b98msFQF+j124tNb/cX4Xbugrpn3EBgr4FhjLkgZrg2y957FHm9kA2DRM3/jlKIQ3Om83d1FR5KL1BTgFsDHD7Igym/LtM1dgRsTaZH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_15,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300170
X-Proofpoint-ORIG-GUID: mgOw-Ck1q6pVxnALtk4nl9gdAuKwZjuY
X-Proofpoint-GUID: mgOw-Ck1q6pVxnALtk4nl9gdAuKwZjuY
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clearing and copying of huge-pages is done via process_huge_page()
which subsequently calls process_subpage().

This preserves the structural similarities while processing the
pages but needs some ugly casting and even uglier indexing: for
instance in the call for process_subpage(), we pass the indexed
address, along with the index so the handler can also do the
indexing.

Additionally, both of these paths have diverged since this code was
written: for instance clear_subpage() cannot fail but copy_subpage()
can fail in copying.

Note that there's no runtime cost in having this code be common,
as most current compilers inline process_huge_page() (though
some older, supported ones do not), but it's unnecessary complexity
for something that only has two users.

Accordingly, fold process_huge_page() back in its callers.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 mm/memory.c | 182 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 120 insertions(+), 62 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 3854f0b9b3a9..6e005b787608 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5899,66 +5899,6 @@ EXPORT_SYMBOL(__might_fault);
 #endif
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
-/*
- * Process all subpages of the specified huge page with the specified
- * operation.  The target subpage will be processed last to keep its
- * cache lines hot.
- */
-static inline int process_huge_page(
-	unsigned long addr_hint, unsigned int pages_per_huge_page,
-	int (*process_subpage)(unsigned long addr, int idx, void *arg),
-	void *arg)
-{
-	int i, n, base, l, ret;
-	unsigned long addr = addr_hint &
-		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
-
-	/* Process target subpage last to keep its cache lines hot */
-	might_sleep();
-	n = (addr_hint - addr) / PAGE_SIZE;
-	if (2 * n <= pages_per_huge_page) {
-		/* If target subpage in first half of huge page */
-		base = 0;
-		l = n;
-		/* Process subpages at the end of huge page */
-		for (i = pages_per_huge_page - 1; i >= 2 * n; i--) {
-			cond_resched();
-			ret = process_subpage(addr + i * PAGE_SIZE, i, arg);
-			if (ret)
-				return ret;
-		}
-	} else {
-		/* If target subpage in second half of huge page */
-		base = pages_per_huge_page - 2 * (pages_per_huge_page - n);
-		l = pages_per_huge_page - n;
-		/* Process subpages at the begin of huge page */
-		for (i = 0; i < base; i++) {
-			cond_resched();
-			ret = process_subpage(addr + i * PAGE_SIZE, i, arg);
-			if (ret)
-				return ret;
-		}
-	}
-	/*
-	 * Process remaining subpages in left-right-left-right pattern
-	 * towards the target subpage
-	 */
-	for (i = 0; i < l; i++) {
-		int left_idx = base + i;
-		int right_idx = base + 2 * l - 1 - i;
-
-		cond_resched();
-		ret = process_subpage(addr + left_idx * PAGE_SIZE, left_idx, arg);
-		if (ret)
-			return ret;
-		cond_resched();
-		ret = process_subpage(addr + right_idx * PAGE_SIZE, right_idx, arg);
-		if (ret)
-			return ret;
-	}
-	return 0;
-}
-
 static void clear_gigantic_page(struct page *page,
 				unsigned long addr,
 				unsigned int pages_per_huge_page)
@@ -5982,6 +5922,65 @@ static int clear_subpage(unsigned long addr, int idx, void *arg)
 	return 0;
 }
 
+/*
+ * Clear subpages of the specified huge page. The target subpage will be
+ * processed last to keep its cache lines hot.
+ */
+static int __clear_huge_page(
+	unsigned long addr_hint, unsigned int pages_per_huge_page,
+	int (*process_subpage)(unsigned long addr, int idx, void *arg),
+	void *arg)
+{
+	int i, n, base, l, ret;
+	unsigned long addr = addr_hint &
+		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
+
+	/* Process target subpage last to keep its cache lines hot */
+	might_sleep();
+	n = (addr_hint - addr) / PAGE_SIZE;
+	if (2 * n <= pages_per_huge_page) {
+		/* If target subpage in first half of huge page */
+		base = 0;
+		l = n;
+		/* Process subpages at the end of huge page */
+		for (i = pages_per_huge_page - 1; i >= 2 * n; i--) {
+			cond_resched();
+			ret = process_subpage(addr + i * PAGE_SIZE, i, arg);
+			if (ret)
+				return ret;
+		}
+	} else {
+		/* If target subpage in second half of huge page */
+		base = pages_per_huge_page - 2 * (pages_per_huge_page - n);
+		l = pages_per_huge_page - n;
+		/* Process subpages at the begin of huge page */
+		for (i = 0; i < base; i++) {
+			cond_resched();
+			ret = process_subpage(addr + i * PAGE_SIZE, i, arg);
+			if (ret)
+				return ret;
+		}
+	}
+	/*
+	 * Process remaining subpages in left-right-left-right pattern
+	 * towards the target subpage
+	 */
+	for (i = 0; i < l; i++) {
+		int left_idx = base + i;
+		int right_idx = base + 2 * l - 1 - i;
+
+		cond_resched();
+		ret = process_subpage(addr + left_idx * PAGE_SIZE, left_idx, arg);
+		if (ret)
+			return ret;
+		cond_resched();
+		ret = process_subpage(addr + right_idx * PAGE_SIZE, right_idx, arg);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 __weak void clear_huge_page(struct page *page,
 			    unsigned long addr_hint,
 			    unsigned int pages_per_huge_page)
@@ -5994,7 +5993,7 @@ __weak void clear_huge_page(struct page *page,
 		return;
 	}
 
-	process_huge_page(addr_hint, pages_per_huge_page, clear_subpage, page);
+	__clear_huge_page(addr_hint, pages_per_huge_page, clear_subpage, page);
 }
 
 static int copy_user_gigantic_page(struct folio *dst, struct folio *src,
@@ -6038,6 +6037,65 @@ static int copy_subpage(unsigned long addr, int idx, void *arg)
 	return 0;
 }
 
+/*
+ * Copy subpages of the specified huge page. The target subpage will be
+ * processed last to keep its cache lines hot.
+ */
+static int __copy_huge_page(
+	unsigned long addr_hint, unsigned int pages_per_huge_page,
+	int (*process_subpage)(unsigned long addr, int idx, void *arg),
+	void *arg)
+{
+	int i, n, base, l, ret;
+	unsigned long addr = addr_hint &
+		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
+
+	/* Process target subpage last to keep its cache lines hot */
+	might_sleep();
+	n = (addr_hint - addr) / PAGE_SIZE;
+	if (2 * n <= pages_per_huge_page) {
+		/* If target subpage in first half of huge page */
+		base = 0;
+		l = n;
+		/* Process subpages at the end of huge page */
+		for (i = pages_per_huge_page - 1; i >= 2 * n; i--) {
+			cond_resched();
+			ret = process_subpage(addr + i * PAGE_SIZE, i, arg);
+			if (ret)
+				return ret;
+		}
+	} else {
+		/* If target subpage in second half of huge page */
+		base = pages_per_huge_page - 2 * (pages_per_huge_page - n);
+		l = pages_per_huge_page - n;
+		/* Process subpages at the begin of huge page */
+		for (i = 0; i < base; i++) {
+			cond_resched();
+			ret = process_subpage(addr + i * PAGE_SIZE, i, arg);
+			if (ret)
+				return ret;
+		}
+	}
+	/*
+	 * Process remaining subpages in left-right-left-right pattern
+	 * towards the target subpage
+	 */
+	for (i = 0; i < l; i++) {
+		int left_idx = base + i;
+		int right_idx = base + 2 * l - 1 - i;
+
+		cond_resched();
+		ret = process_subpage(addr + left_idx * PAGE_SIZE, left_idx, arg);
+		if (ret)
+			return ret;
+		cond_resched();
+		ret = process_subpage(addr + right_idx * PAGE_SIZE, right_idx, arg);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 int copy_user_large_folio(struct folio *dst, struct folio *src,
 			  unsigned long addr_hint, struct vm_area_struct *vma)
 {
@@ -6054,7 +6112,7 @@ int copy_user_large_folio(struct folio *dst, struct folio *src,
 		return copy_user_gigantic_page(dst, src, addr, vma,
 					       pages_per_huge_page);
 
-	return process_huge_page(addr_hint, pages_per_huge_page, copy_subpage, &arg);
+	return __copy_huge_page(addr_hint, pages_per_huge_page, copy_subpage, &arg);
 }
 
 long copy_folio_from_user(struct folio *dst_folio,
-- 
2.31.1

