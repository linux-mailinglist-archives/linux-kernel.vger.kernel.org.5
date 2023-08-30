Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D11B78E13F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240818AbjH3VOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240913AbjH3VOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:14:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578C5CE6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:13:42 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UInfdj032402;
        Wed, 30 Aug 2023 18:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=V2qBt25bpg2D3yMTQCWte8BlIlS/6RXGVrigjE6CaKg=;
 b=bU3ORyE+KcJVO19uIH+FQhex8iHbNXXa5L5qX6DsfGpOb0a98DzGaoPsxfWz8hyBa5TT
 ZRxIFdX+oT4AkZetf5YhruZEuz53uRR0kJpr+1HEArV4zl1C5GOOSw0h3P1T9PwUIvPS
 ILuM3PmuPOk5+qffLuzhKQDy21VJDAyPiCUPj4QjBYalMZQBHcauY8QF3HZghSe6HrTn
 dNDwA/AC9kKib3K+8gi3DmWjCR/9OVQCPCAtFpv072+jTTWbUgkPj6vywlq0smh++D43
 eJkZjNBzzpnD1cNi3ERUQh90Vxo3rXeHpyw8vy7tCgMSNnei0Em36DO/YxTjeax3OE/q /Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9k686b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 18:50:07 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37UIDu8g032772;
        Wed, 30 Aug 2023 18:50:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dqehd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 18:50:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7VkF1CkHtnnlqNDVASGby2tY35cKWDuAMphkRQ8rasG7WQhoZz6iGTwXihZlSk6vW09fWKtmC5f484TMkz07ebQ3QMkL9hOjIr/8XrQiy5UiK+EZNMoilVKK4B2fp8nHfo/6AK2yDeIs+H+WUzkJg4ahk9e7DpRo5aHcXu0cQyIu/oDwMh3BX2FvwfmVllDJzDlHufRGH9NeTLuFgXg7kuLxJnjmvy6MIMBwC01NCPR8B1LUtbfNX1IYRzJ5DNjd5IRyjAyzQVwo+u+3bxvgh80jKUSCWEBxrN5j8ns5aqBBDvra2jcfWiEmToMeDqUzopVxDrchrU8MPYfTrneMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2qBt25bpg2D3yMTQCWte8BlIlS/6RXGVrigjE6CaKg=;
 b=R+5JCffPlraidlcQKJnxugIBlmnyMJTSiDpDdKuA21vJE3ECHxGdM88dy9q5Kr6YRZ3wt/ve8pgb9fGQhjE+Q+t9MdvPr3WIDfn+hvuYacoU1Ulu3zn0ccKLyzobDkV9+14qGVmfL5Exb1oP/uXpwPUmf6vTa3Pu5RVMrAqeRIyNzOJTvqWlRbCzpkDtkZBTZDIyfgFtWW6effvN+HuoPPymXtXu92GtEPP3e0d+XO8PGr7XKqEzJ7b1RrvJsZWgzkkcna86vuq4FmGLkVRvGvfiFV1qc0EnyG5cbyfmkP8PZYv2VdAkZPJCyhm+wOh4MyK0lnsdomdDp5CtS3v1rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2qBt25bpg2D3yMTQCWte8BlIlS/6RXGVrigjE6CaKg=;
 b=XWE/IlpxOPoXMb3XV3UMEJUFNdck1zWvzDCS61Z5VksJOf49MOx6dgFpl2wSY+17KQQsJZBo5CH48ZanX0F3CdLFfOdP97E9fhqKfIDTw7aL6d1BbJr1ZgJMHt3qVBcg2gvKSt6GdSUedE/ZC+ih0JKeg909SKnyWMT4+ncOwkM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYXPR10MB7897.namprd10.prod.outlook.com (2603:10b6:930:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 18:50:04 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::238e:5e86:cbd0:7415]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::238e:5e86:cbd0:7415%4]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 18:50:04 +0000
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
Subject: [PATCH v2 1/9] mm/clear_huge_page: allow arch override for clear_huge_page()
Date:   Wed, 30 Aug 2023 11:49:50 -0700
Message-Id: <20230830184958.2333078-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:a03:505::28) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYXPR10MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 88e90712-dc34-4d15-c881-08dba989ec30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /cOrjgqvaWjaaJy8zApf+RRQ7Z1B61halLQvLIIyugbtv1qHf7lo5xY6yweRF+i6TVqZlnGyKY6mAweZgiaF5Nkdn9VZKK/TRFByyHuXgU2NsFwzFp4bnLWt5AzHBF5Hgg5NdE6iS+7/3RTbbgyzwrkemmm/2utCYZyK0b4+zVpFkhFNeqG8qc7nAxg+SyZ913n3HRhRduwdcEpxpCQbpa2tPT2iw8xFC0NN+AL4/AYf72ZDkctpFxH3/DbFSXbI2Zy83rvZQWIU9g8I0X1DrvhZk/151dqugQWrimSJrh3HDNb3lGIqlyBHRVdrHdDj1XYXcSkDHioRM5PkT/ITsTDTepxRpUieWU1qnVPWJBiLTNZz8lYjWjTthN31EX+/fKzWq/burIvoiaaI1ZTOUIx9awSiLDmZIh2/OmAk+BeNY3bVq55PA03alBGtWiFfylAt6hJ5i/IcMZ+JSMPUn6nfQ/BlHgJajm1UjckvcHvBF+CFMu/Bnh73LCtAqbiVJSJ8fQ/gcxQv7YvGqlE8IKoyyUiEyy1pbrszCQHAXNtBM5MQpXe2+piGCuwGNYOpb9lgwt3Meqrk2kIaKfxSAz5bDWk0BenXmAQSgT81M8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199024)(186009)(1800799009)(478600001)(38100700002)(26005)(1076003)(36756003)(66946007)(41300700001)(6512007)(83380400001)(2616005)(54906003)(66476007)(66556008)(6486002)(6506007)(316002)(6666004)(7416002)(5660300002)(4744005)(4326008)(8676002)(103116003)(8936002)(86362001)(2906002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X1wyC/J05XQmV7EsgVIks1cK2v0bSV5lOJWMxfKEPc+z3SiS/df7ICAbDSjx?=
 =?us-ascii?Q?CeTLtEjEfbjUhUb/r3md25xeu1iq5zIT+fLmpQrk8hiAxLASmGCi0ndRhWPY?=
 =?us-ascii?Q?ajxmmR0pekPI/cu+WNHMR2DuSZX/BbQ/lcimEI24Zy4XAmvLRQLbxrLK8q8T?=
 =?us-ascii?Q?4tnAOyv1sJNW2qzVsos+5G62qLJTjj+uRlKeHPipo6BjooZ/h0bYkFQCgNGz?=
 =?us-ascii?Q?ngMMiZ40wT/MNx3cCFtyn7L8GJLQ8id7lNmmrIrReL38DX+WR2PcQKEhVbXp?=
 =?us-ascii?Q?ilP+46fbg/MIiHktJoP2JVsp4PWEfow4XuJwfSkFJzmmxJSuzzgmL8txhYsK?=
 =?us-ascii?Q?qitGbRLLfLsxgEXbvJNBU2LeksfL083CI/5/FkLP58EJNp+AR71Uxgvzg0vJ?=
 =?us-ascii?Q?m8Cx8xpUTV7XF/JqFQaBJnGzChQpfj+ZVsToFWmasiva59dUns6xcYzf6V7B?=
 =?us-ascii?Q?4LgI+bn7wjpiaDnTZ7pizxP1SOUnJzICLNcI7SqLzCp/fkdiCZLtYVfefGNu?=
 =?us-ascii?Q?jq+OUkG7uuO1f7Gp4ERHWWE/iRgX+p64E1wqwIJm0iR7Z1y+3up+NFcmoMdP?=
 =?us-ascii?Q?b/C9L2s+F8aHmy1Wozg1EHR1ZZ6Bje9BiKN8ZX1C9ccLAnCiTpv4VSe2ZIG+?=
 =?us-ascii?Q?zcd0MpC//4NSKmZL/RIzumgEZGBMz1Vm9j2aUQ2xa9hCTikhD6fhofK4wfku?=
 =?us-ascii?Q?/Nl1lEu+hwU9EwHwWpUi+cX98HRvSIyimET7Lf2ABQoaT/NJEat7ZpU8bpzj?=
 =?us-ascii?Q?Gg1mNId8odfuoWLbDblimm36zzPViINDW0omKLjenqqwsgC35DmOzbimFclx?=
 =?us-ascii?Q?OhSAouAy/G7tdfhH5qkqZuCyd7m+c+lxq4cYQN9gjpnpKlSCTsRnFZkZL37g?=
 =?us-ascii?Q?xUDc3XQ02MzapJphR7YEUGYOMpr9YnECXS4zLTiys+nXN47pgSM8BFNi5Feu?=
 =?us-ascii?Q?dU7baHlBirrmrtKNSTrtwT2IGGXQ6IGTLiOYXlZK8AI+OupqbFsxvLTxyOvz?=
 =?us-ascii?Q?Qk1XHWuy8wxOm8HHKDi/Z8XQN74b/75eyBgHHQxSV78q59rLlkrDqP1t/shF?=
 =?us-ascii?Q?5Q9Gg7FKyUMkkN8pi7tsjPsedT3BTMwwg8u8HG1tvlBIg66p7Q6udK8lt55y?=
 =?us-ascii?Q?cLOIU5CIT8/ieC0oah2acgLituTmq/zLLEOG8U4U/sdSbya5mjXwrJGhTGw8?=
 =?us-ascii?Q?qipBtwYaeN9/yaYo0XAPA2Kfnj1X55m0hAcPSXZUU/ypq8cFp1DUMupoj1QE?=
 =?us-ascii?Q?EgSehNv5tYUrmUAqiZBug3Xa5vQ21GShOIxna/pSzHuaBSz+17pP5skIaExB?=
 =?us-ascii?Q?zddq1biCAs+nu5USZn7sb+9ksGM60jGobnQ7HLf0s1lpeDTr/pu26rQJZQ5B?=
 =?us-ascii?Q?pDuEGv3prlTpeQP1XYCB/OIZKaouxcaKCIarG2BGCIk/LYT5X6M+FUJyXQ+K?=
 =?us-ascii?Q?n4Xl/TncRnioR9fpKr0AR2EyOE0QjO/vSrouC3jSYoN+H+4mTrDthuiSqK23?=
 =?us-ascii?Q?lus86PRSd0zf4yHFTRHOl8TDNxOEAXPLWzR8FsBsgvAbVpYoM5LSfcV5C52n?=
 =?us-ascii?Q?8Jr3q12lxIAWf9QniIvh3YCw6/zr2lITe2MdpqfRiEPoUG6AnD0PuKR3d95k?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ixRomdRqZk7RzwTLspYovQbngCVoB77Yk4o4nI8zGN6a8ctr0a7qVXOreSdQ?=
 =?us-ascii?Q?HBWX9+4+fuI9Z5HG0tsquKV3rLrddCyY1wSyeBOhddXE8XBc9xu7kb53uD4k?=
 =?us-ascii?Q?rcf6A+m55i6A5RsgAiy27sILlD7yYkLv9IgckzSLD92GK9AN1krvcHDGHg07?=
 =?us-ascii?Q?Gnn9d/5d5qIPEDDyEe47lbqi8QZ2Iz6OnAhXgChi47qtQPpwqAumI3rL5r8B?=
 =?us-ascii?Q?c2spT4z2SSIziOoPmzSIYtaa+0c5SNAJ3accaR4PA1nQuJ9hzWdf9FsIQ+H3?=
 =?us-ascii?Q?gtKpA6ut2OQc9ZhMgpKnSgA3jsM51tUTvj8Vbwy3+KVgoy7WrCc3nhAfNyfU?=
 =?us-ascii?Q?TzRlhk8zpPrGpCtl60P+M/j7ZWjcuTGAJSaAr9HuLi//eXwwq6HX6hF+0ldv?=
 =?us-ascii?Q?cVAJNuY7XcNqwFzDdZir8IK9Rwr6CrBVPDUcy63KaqgVrd46g9ZY8m/5L+iF?=
 =?us-ascii?Q?9J0koHVn+S4xGuDqBJYA0Z+suyCMvzPj8zUTIWeNhXkXCs7EY4TZ0k9kVR6y?=
 =?us-ascii?Q?bWTeseqIQVciLh1wPGCR745y+GMYFsPyAupNepdTgLXrvVdW7fTRZkkkcKkd?=
 =?us-ascii?Q?fLNFf9aAyAAg25j3rjNVBpyuZm/0dn2tYqGJFAUuf9FUxIZIBG8zRZFTKuLY?=
 =?us-ascii?Q?2aR/ZvqruZq3/eeIZeFLTJ+I04xn8nwJdMEhJAzm0jtpIB4TX1U03xCNp5wM?=
 =?us-ascii?Q?gW3MjSOOCiHHeOz5LMTdUZ8rXXd2sbajnK1K5gFg4u199X9RFHZNVkbU7BRF?=
 =?us-ascii?Q?++VluQxJVRg3x39q9KAs3dfA6hZRk5gbFacVxWLwI5JT55eBOFhT2HtdS7fW?=
 =?us-ascii?Q?nWz9LXa/GG4U60n4lICO1cevi0ht8n5dfPe3QLHTILvRcd9eXstNcC/qsbjU?=
 =?us-ascii?Q?rkLBY6+yvW2Cbj86ONO6n179ENeEeRPqA7y1wVN5ZhexrhX2P3MlvZKFkLy0?=
 =?us-ascii?Q?lZwHCwhU6IQMWBGuuZgzjpk9/xjHqtO4uPwdCTMZTD4K8wcjjXgPZdEhL4Yp?=
 =?us-ascii?Q?9wfn7BMVN12AL54KQq69HAxaWNRiSbCq5Tw/hMJehsLd6v94exrx6MWB79Iv?=
 =?us-ascii?Q?jW65OpwFS6G60/pteoLuIMrxwjqe7CF/NbKBnD2q0ZDte87tpA0ECl88Y1L5?=
 =?us-ascii?Q?PWLrLvp5fsezgPd1afTU6e9buSSUwnzRe1gv/LrGXn6KVQPqJxMuNP8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e90712-dc34-4d15-c881-08dba989ec30
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 18:50:04.4151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0aIn4blNgYhZpYoip8ut2asFexK4l+AbHq7Wxv4B3GndIo9D0jIoiaFUdGL7M/IHkHecZhKkre6ONocfCEyTjfKFSHmK3MCT6XvcS2Q+O34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_15,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300170
X-Proofpoint-GUID: Gy16ycZ5fuBeDdzttyBSLeWGicyGRc8u
X-Proofpoint-ORIG-GUID: Gy16ycZ5fuBeDdzttyBSLeWGicyGRc8u
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clear_huge_page() is constrained to process a page-at-a-time
because it also handles the CONFIG_HIGHMEM case.

Mark __weak to allow for arch specific optimizations.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 mm/memory.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 405a483d2fd1..3854f0b9b3a9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5982,8 +5982,9 @@ static int clear_subpage(unsigned long addr, int idx, void *arg)
 	return 0;
 }
 
-void clear_huge_page(struct page *page,
-		     unsigned long addr_hint, unsigned int pages_per_huge_page)
+__weak void clear_huge_page(struct page *page,
+			    unsigned long addr_hint,
+			    unsigned int pages_per_huge_page)
 {
 	unsigned long addr = addr_hint &
 		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
-- 
2.31.1

