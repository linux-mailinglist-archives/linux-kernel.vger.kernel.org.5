Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75F37BB07B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 05:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjJFDVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 23:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjJFDVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 23:21:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3A2E9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 20:21:19 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3962Npww013412;
        Fri, 6 Oct 2023 03:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=3vbONjsZvravfMZFWf/jFmc0JqQCVqxQwTo9QP2uYlc=;
 b=RIHQxFLLHl5pKCFIPm193UARpvxBBQlCG4rARQolbUZliJePDcnn41cpNVML1tkCcBJP
 ClYs55qYfrWgCI+6S5FKvFbM75qXA37l2KtA1jmzpTIAEiR5zF6tzveG7UGwuH/G50za
 JVFu79DPDw0oP73OrhL2im7upLY5b67R7sY96DO5LNIiTivC5VFa0BV2CnYr1yO16vvz
 g0M6aQQH77OWT360jRzNNYz/e/a3lPE0z9tyRmN+NhYPduChQ4hsM8nmaHHuRZ285N8b
 7F9ptB+rflHrE/nM125+wCGFPK4iUtywaa8bR7/X5w+8DnM86ppv/ZDGt9r3gjjBTuSA 1A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebqe31sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 03:20:42 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3961NaBS033628;
        Fri, 6 Oct 2023 03:20:41 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea4a7nqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 03:20:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JF7QJqvT/N4XkALqP5VrmaUkNdFaOaqxNZmPNWNmyqN+wtWY4onWzRZ3XVFMF3mXHEn0rZlfZiJMW+TKxlO6U8YcH0Wkdh7kJdUAjSoHzBH9Bh5MJCAqGvTg7kLzDABsfLXeMz30csMbA3B2MWZbm28damZCuPczq8vzf7teUuqpiA9iI2vn1uKpxikJVH0zuKjHnfbh7as3s0XId6G692A6ha/vd46d4argvk3ZzlpHhCu4hJUJyLXlBhe5slBcnXBF07qUL4QBLDp/Sapb0E6WevR1PEQ0JyPqZ9iuQMY/r+jEFk/UpW1JrEvm0B7Scf/JKZNrpZzrAszeA5hhTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vbONjsZvravfMZFWf/jFmc0JqQCVqxQwTo9QP2uYlc=;
 b=KJztZ1iVQ/tChimxkPXTczkJDp+8zOICDDsrIdlPj/3/FS4F1qNLJrza+zVne3u0sNK01e2x96uav90XwF1GZTmQ1bwnhu7tR+Y1td/U1S3VPuYwNQNg7AbnnDTZfD0N/vhJCM8HbxAYduGnZmhz6OiLa0j5BA3VwOOkIE05pEV2PEpPxk8ewhht4BLuZUhA4bbi8tg8T36ZnJ6zWYHfJAXz2r1wqSLibT1Bt0inQih6+6hn3U5QFOEiCUwerzy3AswCFs1YAO1ulx9fQrnBrUeJF0sFZnAsh/O8BQid38ttaLREJfzkjQ+aPny5ZnP5To67o+PLdxzWxGp+x0a3eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vbONjsZvravfMZFWf/jFmc0JqQCVqxQwTo9QP2uYlc=;
 b=IYLk0bXEC8UvdUcEnJQU/juSVLoQjMhGaQ4qnrQ/k1laGmMQRvTH5zqrh1pjEt8F7HQf3LrgYeSTGQnk9WjfFnBjpiM/Pd5+isA3Lpq495ctrFW/o/8XVnNyF/DRtmrpUt1Ib3CM23WjqQ6n/ejX3rcYtCWNFiF1sAtXO+hghQA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB5391.namprd10.prod.outlook.com (2603:10b6:5:3ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 03:20:39 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 03:20:39 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v7 6/8] hugetlb: batch PMD split for bulk vmemmap dedup
Date:   Thu,  5 Oct 2023 20:20:08 -0700
Message-ID: <20231006032012.296473-7-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006032012.296473-1-mike.kravetz@oracle.com>
References: <20231006032012.296473-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0210.namprd04.prod.outlook.com
 (2603:10b6:303:86::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB5391:EE_
X-MS-Office365-Filtering-Correlation-Id: fe40a5e3-3a64-463d-e971-08dbc61b36fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b4Usg4BblSwYPNntvFmGcxx8MIDmg//lWw9CXWQ7S0hj6lDrni6y2Qq6fe91ka6eT1M314z/tjNumkHa264VaGiWHh98fbxpwuoXJhFoS2Pzeh5sN6vhfObZnANwS0FD4E1NRtw8KHQC9bLJEV4UFDhUxX2a+OXmJz05wbyKSJ6Cu2YqLpBAukUwb9ZJhLHuSyDRJtZMmPSm8WQ/tXHCtFeTd3T0lOJBJJBXz4qtm3tmLzy/w5/Nynns2ipy565Loo7dxYEv+E4tepfsYr6nf2DZftnZ+s3Xj9+2n4qggWZZ5Cxu8RQnPtiUtzZzIDGmLrSIUEJBEgLkb9vxQ1pV8O/xtmYcua9PLD0qSNR9VKENloW+v42BzMin9g+SXuFM9z4Ee0+vyCAGXLGUAmbsocaj3tkOFa/Q1/3CHpbzqi6CBcnqWU2ibQQkEhyiv3dnvB4yY8Rf32lVvqiI/TLM7diP8bMJsq5fjV8zAynAoJ6iXapu4g9rgLg6xAvujLUkIGV97pcIU0pEkrbfHzvkm0YflQraPgrfn5XDjycKdKCSWKL9CPMm4Ttiy9b7dfi/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6506007)(6666004)(6512007)(6486002)(478600001)(38100700002)(86362001)(2906002)(7416002)(316002)(41300700001)(2616005)(83380400001)(1076003)(107886003)(26005)(36756003)(44832011)(66946007)(66556008)(66476007)(5660300002)(54906003)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rypyXgOsNl+2WmRYsTx3N/O/2jQQBxON5VOUTmr+1rHG2LcFtKbsGjHmilkc?=
 =?us-ascii?Q?ibcfVYjAsmtTCNf2F9Pl9bnkia8an5aKOnoxYTg/Dvo0RcJaU9L9A8Ny+ZIe?=
 =?us-ascii?Q?FYMToafgb0d+0hglVJ9EUoWfKvWwKjdZV8iX1bG3njh1sRyhLZAeBn9sMaag?=
 =?us-ascii?Q?yIP4FuYwjV1ZTRbxWZTqMVtDx4YkXYgkmL0pK634JnLx0r4thMOhwiUXmInl?=
 =?us-ascii?Q?q6PEC79ACzuTUuW0Vyr7h/2/3bk/1LnbsTSdEQ9ifXZ4tBoHYx1Yet/rcWQO?=
 =?us-ascii?Q?JWoZgl2JB2wndt2RqEH7+bfRKh4ADHUfYwdsiaH1T4vZF1+8JE6KDuMglwjb?=
 =?us-ascii?Q?hX0rCnZyqFkjPmxAYGiTfKj8dsBMAaWeaAa4KTa/f+qZFKJtLM4cmFWWhBl+?=
 =?us-ascii?Q?YdoHDIX+zBcNldO7go+jYrRVpSZFB8tvpYifKmbPjlrg6i1Ip2XHJ9NRgoxg?=
 =?us-ascii?Q?sYgz8nVW8bEAtxDVx8Ur0c0yyBfZK096qTva3YEvB6OKp1FMFurCLC0xbloi?=
 =?us-ascii?Q?wNIrTkBv6sqtOaNog4fsDoce34LEqVRid7k5c3j1/T3ju4iCGraOCxxQBeLH?=
 =?us-ascii?Q?6USU/sTq2SCpSJF638M609+35Rcmmmgf/ewUOfnUDbOlypdbs2bZQObjh7Ft?=
 =?us-ascii?Q?VHwWZlg5m384KwO374PyNjJUWmRCfW2q0+9H4PBfXtqmiU4Fc1pIx+1xs/Nm?=
 =?us-ascii?Q?jURvdbFxlGwgu2KcyynEqf7iW5n7d7kDwSF9qjVIhdpRDFzsBlAOh6KYO3y4?=
 =?us-ascii?Q?et03NoUOU4aDZf86ohFwhs6/4SyM75jWwGMLhU37PioDGGQoHodw9K15eKzc?=
 =?us-ascii?Q?HFFCcggbk1YoynRLTYXHLTXIUPd5LYPnw5sW+876/tacLxozCRkcKFb1QzHo?=
 =?us-ascii?Q?UM3ainlquANYa5di3IaBbKY0xmRHJPVDFvS5x5VoNN1lYMXwmkIxO/PMKJIO?=
 =?us-ascii?Q?Se9exqzl2Xg7zVnP7TCisWEsGMApX3kSNdSzmqLKS7nNgyNs4lssVc2gR2F0?=
 =?us-ascii?Q?RjqTe5W6HJIM7pVNJSzxLr65XxVc1al6C/WHRZAAhSBNlnwmhlt8LzUTcVsH?=
 =?us-ascii?Q?a2bw8lLmXWS9AL3XVLbwO95vtTrz8SXX1UHJAdKjtbqYAr72o8oWpYVG9fHU?=
 =?us-ascii?Q?1e4h+ufJZO+WbnoSxUXSxQYOovYH7E5o1UTRunIuyLkK1t8WxOJY9wneRoL0?=
 =?us-ascii?Q?omWDmmhItLCbcNgu+jJCsQuHjdljYQUwCOpV+pgCGHP0vxVGspTBXwh647iz?=
 =?us-ascii?Q?+nGo8Dwwvuhz3cEN2im7rmx2arjYCUgQBqw77Wx2A9e3M7vuaAEzM1bmUPBk?=
 =?us-ascii?Q?CMPBQXE5E6TDB4GZ141xAkwY+hosZ67Pokvc/TnL0IK27uD/8XOwWcRMFh+Y?=
 =?us-ascii?Q?bL3zPFQNGY8yooKpRPl7ZghmEsJ8jfQ+pO5evvZv6gKBJW161/iWnjI4qGnL?=
 =?us-ascii?Q?uWXmFmdKkXZVAJnhoPa3mQree2FNRHZCfNxvZ3k8HynqFAO3YyxRBcSHHBK/?=
 =?us-ascii?Q?h8vWrtl2o1TUyDHXk8qqba89/jWqY2t5KHka9mCzwnWSBuRacKiPIoTomltd?=
 =?us-ascii?Q?I4EsyqnWhdya9PMTySQUdL8XrJhdUa1h4UpT6n21jZuEoYOn3QsjiVusMBga?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Q7lV0ctfdbqGzNz/gU9A+PORtmUHHIM+KhDj5AX7z4EIxAkZQIDvmSw3MzYh?=
 =?us-ascii?Q?W7QMdkFnUMBoyNKZ//a7JbIDYKqeYZVFf26WAEiuUi+p6R1MRoOWALMs41E5?=
 =?us-ascii?Q?20E87MhM9N7qcF3N/gH5EIUzbwSUihbZFontTgY7HcS9mFvixabpy8KJ/kiI?=
 =?us-ascii?Q?hs05nqUJOClacebqzkEAzuBemZ8Z3v9/upU4ZtcAno2I6fFXzHis6bJM1jmw?=
 =?us-ascii?Q?lgVEo7VYNVdQyEjkZUcPK/bZfLSf3czucwMEmkrH1scVxKzHC5gdPuxpRDB3?=
 =?us-ascii?Q?8p58qIl3ON0n5hJNUW/6LWgcx68zwXuy4igycw0+vfaM8ku8SOjhINET1/w6?=
 =?us-ascii?Q?RFG1w1HhFqjqjydDCcGkiJoT9O0m31WrsuqliBEdIw22gD8DHjfrUkLzncXm?=
 =?us-ascii?Q?cxGzWqXGpCr8YVt+D8ZJwdX1ovoawJez9D0Ej8DOCSkdn19MeqxNR/M5EUD2?=
 =?us-ascii?Q?kTfFmxfpA2s31zqgn6F2aV5AybA65KAurVLen5jMeUEh2j2vH1ZYzBh/pw87?=
 =?us-ascii?Q?zI4p3kdCitcbMnKlkNvMg4N3rU4vrShpW/jVziVThRNIdiPlzz6AJgEoa/f9?=
 =?us-ascii?Q?y6uXz2L4Qy3WLYMKQ1ZqBE7xrJ1DQl17ONPWeyLAOrDc/PRLRW7CGWXmLviJ?=
 =?us-ascii?Q?JHtFKxtoYY0ALUelERWZ+BobmxmKJCxItXAaO9LmVGYHH2XLYT6qapPR31ux?=
 =?us-ascii?Q?oC0ldjImQU1CAn+Ter8xlfIuLfhyIAcWz0iBcQ9hLiQzD/aSUe8Te9hiINwv?=
 =?us-ascii?Q?wBxmEjov8UTyt2cW2GzTaHbD/Tuu5txDVyp7V00YXUrNBVdkmA3eblLhpc/0?=
 =?us-ascii?Q?gkaHCH1QG0MFifVLVqq1CbXHY3SS0P4JruMuNCuP1yBJ5xvCioONtaD+ijpv?=
 =?us-ascii?Q?NidtnqfpnhyzH/JZYhzHwD6NR5a7aovu3mFTUbepvruUqdy6A62luVK9n21L?=
 =?us-ascii?Q?fDGbXBU22lIEYeZrr9gw2fc5mrYWBZeZTEB+ASnbGjhAzQ/yOhhIMedJY393?=
 =?us-ascii?Q?UAWmdtNdVboIChIUK/7V4mBsWjj3OFXUX+xt0NIsIWFCXAEZkyfUdPSqiplD?=
 =?us-ascii?Q?7J8m3OFQvvOLogmkyzt0yohI1++AqrXH6nRR27NTlWn2ttGroE597+4QBj8t?=
 =?us-ascii?Q?LZfbv1SghKB0XQpj69tl9KKnOLbloXJHrg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe40a5e3-3a64-463d-e971-08dbc61b36fa
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 03:20:39.3096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Nfx8HTC1QPerFR71z5946NfhDqERJ76yvjAZF3OrR5DU7YQjypmVCBSZ+wd+9o4FHJO5VuHUVGg2qls0pfRYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5391
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_18,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310060024
X-Proofpoint-GUID: 1CKExVxtulfT3Z_6BHhInhqEFdyED7GQ
X-Proofpoint-ORIG-GUID: 1CKExVxtulfT3Z_6BHhInhqEFdyED7GQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Martins <joao.m.martins@oracle.com>

In an effort to minimize amount of TLB flushes, batch all PMD splits
belonging to a range of pages in order to perform only 1 (global) TLB
flush.

Add a flags field to the walker and pass whether it's a bulk allocation
or just a single page to decide to remap. First value
(VMEMMAP_SPLIT_NO_TLB_FLUSH) designates the request to not do the TLB
flush when we split the PMD.

Rebased and updated by Mike Kravetz

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 92 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4ac521e596db..10739e4285d5 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -27,6 +27,8 @@
  * @reuse_addr:		the virtual address of the @reuse_page page.
  * @vmemmap_pages:	the list head of the vmemmap pages that can be freed
  *			or is mapped from.
+ * @flags:		used to modify behavior in vmemmap page table walking
+ *			operations.
  */
 struct vmemmap_remap_walk {
 	void			(*remap_pte)(pte_t *pte, unsigned long addr,
@@ -35,9 +37,13 @@ struct vmemmap_remap_walk {
 	struct page		*reuse_page;
 	unsigned long		reuse_addr;
 	struct list_head	*vmemmap_pages;
+
+/* Skip the TLB flush when we split the PMD */
+#define VMEMMAP_SPLIT_NO_TLB_FLUSH	BIT(0)
+	unsigned long		flags;
 };
 
-static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
+static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, bool flush)
 {
 	pmd_t __pmd;
 	int i;
@@ -80,7 +86,8 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
 		/* Make pte visible before pmd. See comment in pmd_install(). */
 		smp_wmb();
 		pmd_populate_kernel(&init_mm, pmd, pgtable);
-		flush_tlb_kernel_range(start, start + PMD_SIZE);
+		if (flush)
+			flush_tlb_kernel_range(start, start + PMD_SIZE);
 	} else {
 		pte_free_kernel(&init_mm, pgtable);
 	}
@@ -127,11 +134,20 @@ static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
 	do {
 		int ret;
 
-		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK);
+		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK,
+				!(walk->flags & VMEMMAP_SPLIT_NO_TLB_FLUSH));
 		if (ret)
 			return ret;
 
 		next = pmd_addr_end(addr, end);
+
+		/*
+		 * We are only splitting, not remapping the hugetlb vmemmap
+		 * pages.
+		 */
+		if (!walk->remap_pte)
+			continue;
+
 		vmemmap_pte_range(pmd, addr, next, walk);
 	} while (pmd++, addr = next, addr != end);
 
@@ -198,7 +214,8 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 			return ret;
 	} while (pgd++, addr = next, addr != end);
 
-	flush_tlb_kernel_range(start, end);
+	if (walk->remap_pte)
+		flush_tlb_kernel_range(start, end);
 
 	return 0;
 }
@@ -297,6 +314,36 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
 	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
 }
 
+/**
+ * vmemmap_remap_split - split the vmemmap virtual address range [@start, @end)
+ *                      backing PMDs of the directmap into PTEs
+ * @start:     start address of the vmemmap virtual address range that we want
+ *             to remap.
+ * @end:       end address of the vmemmap virtual address range that we want to
+ *             remap.
+ * @reuse:     reuse address.
+ *
+ * Return: %0 on success, negative error code otherwise.
+ */
+static int vmemmap_remap_split(unsigned long start, unsigned long end,
+				unsigned long reuse)
+{
+	int ret;
+	struct vmemmap_remap_walk walk = {
+		.remap_pte	= NULL,
+		.flags		= VMEMMAP_SPLIT_NO_TLB_FLUSH,
+	};
+
+	/* See the comment in the vmemmap_remap_free(). */
+	BUG_ON(start - reuse != PAGE_SIZE);
+
+	mmap_read_lock(&init_mm);
+	ret = vmemmap_remap_range(reuse, end, &walk);
+	mmap_read_unlock(&init_mm);
+
+	return ret;
+}
+
 /**
  * vmemmap_remap_free - remap the vmemmap virtual address range [@start, @end)
  *			to the page which @reuse is mapped to, then free vmemmap
@@ -320,6 +367,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		.remap_pte	= vmemmap_remap_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= vmemmap_pages,
+		.flags		= 0,
 	};
 	int nid = page_to_nid((struct page *)reuse);
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
@@ -368,6 +416,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 			.remap_pte	= vmemmap_restore_pte,
 			.reuse_addr	= reuse,
 			.vmemmap_pages	= vmemmap_pages,
+			.flags		= 0,
 		};
 
 		vmemmap_remap_range(reuse, end, &walk);
@@ -419,6 +468,7 @@ static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
 		.remap_pte	= vmemmap_restore_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= &vmemmap_pages,
+		.flags		= 0,
 	};
 
 	/* See the comment in the vmemmap_remap_free(). */
@@ -628,11 +678,45 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
+static int hugetlb_vmemmap_split(const struct hstate *h, struct page *head)
+{
+	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
+	unsigned long vmemmap_reuse;
+
+	if (!vmemmap_should_optimize(h, head))
+		return 0;
+
+	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
+	vmemmap_reuse	= vmemmap_start;
+	vmemmap_start	+= HUGETLB_VMEMMAP_RESERVE_SIZE;
+
+	/*
+	 * Split PMDs on the vmemmap virtual address range [@vmemmap_start,
+	 * @vmemmap_end]
+	 */
+	return vmemmap_remap_split(vmemmap_start, vmemmap_end, vmemmap_reuse);
+}
+
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
 {
 	struct folio *folio;
 	LIST_HEAD(vmemmap_pages);
 
+	list_for_each_entry(folio, folio_list, lru) {
+		int ret = hugetlb_vmemmap_split(h, &folio->page);
+
+		/*
+		 * Spliting the PMD requires allocating a page, thus lets fail
+		 * early once we encounter the first OOM. No point in retrying
+		 * as it can be dynamically done on remap with the memory
+		 * we get back from the vmemmap deduplication.
+		 */
+		if (ret == -ENOMEM)
+			break;
+	}
+
+	flush_tlb_all();
+
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
 								&vmemmap_pages);
-- 
2.41.0

