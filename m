Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB38777CC16
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbjHOLw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbjHOLwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:52:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8A1C9;
        Tue, 15 Aug 2023 04:52:43 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FAbNG2022039;
        Tue, 15 Aug 2023 11:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=PTSSjSgdanlQ2BRLdGmnjGmOraXs/HieJrziVIdEdNM=;
 b=WmE0LiSxJEfO+oOd6dp1O7Zi2TYxIPS3+H8IBgXWUTNSlh2AcLuJmXa8dRXRf7ynqVhO
 5gN+hYaROA8K+wZKp5wdOrqlDpHW/bcsr6XiYkQZcn2TyeYXDdKONyE9pkv7f3b82pHF
 4fsnCcj1zFAAGnKwvgDLFwaRkW995Ms9f6mNk5/psJkeYg16mfnMbCjpDxI7H+BFVjJ2
 RUS9u4YXZxwRWtxQhV/7h0UPmzHvw9PfN/PsfMbjihIaSXOe3B5QyLjDe2YsGohZas2M
 1Fvd2ViE/gPy0DCz2jxvOqUqRTXxgc1uv1XJGSXSr3NHjOuUdoQQCObFvPoXK5gVl0CL oQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se30svgre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 11:52:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37FAs7YI040345;
        Tue, 15 Aug 2023 11:52:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0qquvp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 11:52:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnJfS6+gAMGV+aZspNu/fkzFdy7vh+LzdNFX4shwTv2O3m22+i9krFsX7/q4QQRGaAwDH1GFUFapLej/5vEjf8CIpVySxWfjzKJRzslzcg23mF7afknP2NloOP9f6fQsOYTWtLQrHxJc2Wk/ad8T5GoJWiYL/nLbYkaB3kQBdnbyrNVLmYPlFMbSs2xLsCCoLBzO3Q9rDFbutPoriPFWlCR6Mzckwx6vQ1PXtBGcSTXc9eKc+l1AQ54AWNdQHcYXXQp5VJ61jQzKINkEWGqkLRSsJieeobhFej9k5h+lTwXgEGtFiuYQAddOlgzCYN+OyloBQCJv6fDN4kOyfG792A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTSSjSgdanlQ2BRLdGmnjGmOraXs/HieJrziVIdEdNM=;
 b=GcB00X36sCNlTmSVaUsYWq79DLeONrr4GcjJcWPEZollBRT68NinJBMJ61ZjsNZi5H+2qkakrhwzu+1XoI8nJNBHnyvJb6Hfi2tQfwebIZRoQrK3qdk8RMwPLXUrKCKxno4Bh0es2bUf3bAmJFvbYJbv3VUfO3lBFHmjku/H5x4d/q6r9cyLN7vZLEGjPvV7hLDo0m6A2m7vDL/NZXmRLZPtScO2BnEyTLZBhVhySIlfzqiefhv8K9Q04BlXkFi2Dh60bfQ8/lzHo3mMsxcqF5LUePVX83CihphSL6lfo9R32SLEKzlji/mzmmQNP3EuF6kjVtAtpgRZY8LYttGfng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTSSjSgdanlQ2BRLdGmnjGmOraXs/HieJrziVIdEdNM=;
 b=yhukldPuC7LUBQgH4yilAswDxow0Quhiiy/rEezw2d5moOUXD4x/XaQLaw2WFCG4mp9cYaK7O3p1asdEVIJirXUtTzHRlwHNVwOWb0KD6BStWv5BAICHf/q7kKHV5+VwQ+fqWGuNrus2ftlkzSHsZfyZU5KXMYpIC1zjXRye18U=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6710.namprd10.prod.outlook.com (2603:10b6:208:419::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 11:52:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 11:52:27 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        chenxiang66@hisilicon.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, jinpu.wang@cloud.ionos.com, dlemoal@kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 05/10] scsi: libsas: Delete sas_ssp_task.retry_count
Date:   Tue, 15 Aug 2023 11:51:51 +0000
Message-Id: <20230815115156.343535-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230815115156.343535-1-john.g.garry@oracle.com>
References: <20230815115156.343535-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0067.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: 804f001d-886f-4131-2111-08db9d861900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JO8rYtTsBCw0mJxqSRctSh0eZIT80/NYHzxn7Y2rkzM0FVEICUcwRhwFKXIthpTURaWeDzQJBKpw/Mr+Xd3uwmgw7Bqs81imeCX5Y4R5A+HZCHi21f/2PcJswuqIx88S+TLpfI0vYOh/OJ/tm+kRoUnERMN6nrx9esuhFiyuVnbnjcMSyH0rJD3npq1plZ4WaFFIZ9O2WMjghtjya57a3yuCG1LseWg7eyKUumHnr1SNbJb8RzNsK8V2AIjBVUCnQlOtuRILR8lRnlAVIrMf8nHS/TbamDYclVUc9f3LCoMiR++R+PMLPTSvi3toshrPu4Ol4SzLRZhZm9FgpZ9Oqn0I8HfluKFk4Zkf9btzWWbyjS6Icefxi6LjmN8ubD6EAO9LeoT/z6LvFEqHWwmcsfL8DgiXjVJnynhaVCqmUqYY+Md9T5ncjwFmN5tg/RoldpjrUU9nARhTCY41vz3vvQUd5AGuGa1weVflvlbw0G2TXVq5ulqAVZP3+Ci/heQ+0SLEO1POK+ewWULLkC6qzYOLOSlaAH/fHUdSII1hmhgm+yAzNj4hNndop2uu0FZK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230030)(366004)(346002)(396003)(376002)(39860400002)(136003)(1800799009)(186009)(451199023)(38100700002)(41300700001)(107886003)(6512007)(2616005)(5660300002)(103116003)(2906002)(36756003)(4326008)(316002)(66946007)(66476007)(6666004)(83380400001)(478600001)(8936002)(66556008)(26005)(1076003)(86362001)(8676002)(6486002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hNhyjdhpbB9Wymf38jlmnHc73XXog/+oUka+Pm5oa+py8Xm3/Pc1/Y5P9zdm?=
 =?us-ascii?Q?8vuQNTQD1m3k+eT5a7ss2oMgxN7ILVP9I4w0yXX79VhKYr8HuSDDTtjv2wR4?=
 =?us-ascii?Q?0mMoMe669v/EDtdXBYX4rB0oJ5SxJNT9qu0TivEBIfHNjrAof0t2VsrdkNki?=
 =?us-ascii?Q?6NMUsucoPI8UbA92AfCQ+bmAQzyXi5xzIEUoDHAmg1oamAscYixM0ulqFedZ?=
 =?us-ascii?Q?u5Jz4PPmyX7B0a0TSBGl7aZ8HjLL+3NP+y54iS1ibRSQEjt3j3MuMf3hlOeE?=
 =?us-ascii?Q?I8WDLBwqUA3lHp3F/+nqwHq8W3Dbzj6uZcrSIzmKaq5UJgyNV83CwW8MTpBH?=
 =?us-ascii?Q?tuHOOuKPSMpulSWlV0Geq/Tj1WQKLb45i4y5I3pFW9/hs2GxlosnKkkluVFa?=
 =?us-ascii?Q?xvaY+CseZRDS4wYeRiXXxUQ3rtQeNhpCjnY8DUr1qswuGx9W/bk+kEZWTrww?=
 =?us-ascii?Q?J51WYKf6vg5/z4QS4zODbhLRZZZYqy5VOhbwuhXEsS5RC1i5/xL++4YRByMn?=
 =?us-ascii?Q?t8nCbtAMMHdhebniSd+CjjUGiz1XjxEAT9baTL8qwGFgTSA78K3ySk70axqZ?=
 =?us-ascii?Q?wqi7lISdUv8EEoVEhj3oPGJoy5apdNoR2SgY8oJAxn3BtDWKQWIAm7JpeqCh?=
 =?us-ascii?Q?iNOt6RU2XoxLq5YOtPV3xWs/qjzf3IoRMs1HmR85r7KYLCmaHuVhUgX9GvDm?=
 =?us-ascii?Q?77HHXn0VIVVVix2R8nK/i0wQlQXEa7UDWF/aMtafrtfYhioPwQ8AdtrsYcXy?=
 =?us-ascii?Q?D3B/KA3Otrr4ZXZbdQUUt3AEPWrRCtrtg126CQrZRstL2DW4mO6lLtNFuEOI?=
 =?us-ascii?Q?fYbAGdIUk4XWMYUuH5ARm4wA0IN8NnHADOMzMQmXOtMnA9jHY4IK6+n5Iqpu?=
 =?us-ascii?Q?cBhDvDToOQK95tWtAeR9rE/6pdDzrT8e5r+XjuOFoeAdm+fQ5lc/yztgvL+K?=
 =?us-ascii?Q?/spHTFAKbM9InB1wa9gEIBsbluDa6ec1NLHXzoCxAGg1TFBvDzDNBzfuqQOB?=
 =?us-ascii?Q?9pbo1GG3tcLbeVQVqlNXZwsNCPh0M5wcrJkMK4na9IbZ+Z+6ULVxAOdBWlKB?=
 =?us-ascii?Q?lqpYiZ0ciWycq6FOsASw0p/MMgasQ5/9OMsJTvuNpJiPpsQ0dS/tLI79Ti6r?=
 =?us-ascii?Q?fbqK8eFH1pX+wKQs3HwVkDronspyvgUJE1E3ftekhHkK7878EI02k3sudFsT?=
 =?us-ascii?Q?rHV+N+fuz9NFw18yTPtxWagHGe+WYuOhX5Gqp2ME/EMK2uKx+2E9d+Jo95O7?=
 =?us-ascii?Q?27qnyyAZhf7rJm8Lzj3kRP6eid0CGI+5cqyfuBbEwSKGU4xyzhhfpZ2IF9aS?=
 =?us-ascii?Q?0+auJu5qD0Jc6RmskMBiOeoZhh1K5Bbw7VAZm9uyTF5B8fDANYBI+EaSBh/a?=
 =?us-ascii?Q?E2R6uwLDA7Wb3+LDyHSjOMMHUHDMTb3c5xjG1xYoh7+WHlFj+v+YRiL5azV2?=
 =?us-ascii?Q?Qj7DCIWNmlNvh9tqOixUHuifVb1TVp7NVuLiDpS/ccyQwshMZrAFgXTSw9IY?=
 =?us-ascii?Q?7bKL7ssycmcKZlYUpLrZddCiZyv+PuJSESk2PQy57fjNt4OAL2ygW6rTEsLA?=
 =?us-ascii?Q?qF22ylELcGOap2aSiWk68MZkO9/3XapgizIZiVMR1KMn9l5yoUHoEVDhwfFR?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mm5zFuHqUsQuRWNZSbZW8zX6zdNOQFq7MTTMV8UkaKtRRndwSq5mE+9LfVYL?=
 =?us-ascii?Q?ckNQ8+e1jpj4lpq1O3X2ELDWJQS4tReB+6ucEgG08A5z6M2aezL++Vea/2iT?=
 =?us-ascii?Q?u2dZ57Ny2d/aRB3csyhVcEkfJ8430ShT6Ckm9q0742my++j1BpDYynLF/cdK?=
 =?us-ascii?Q?mWJvBKrKr0doD3rGHL4YpW9t8ZspyZvCJiKmVNDe+pF2g0Ni+Hk+FSIY0ZR9?=
 =?us-ascii?Q?08laNwuPW5EhX6QZowOMIe3Z1LBlPVzPbzpTqZwsni81cM0fQolSAyIhiF2A?=
 =?us-ascii?Q?zD83kCy7wnuH2jl2TJ4CqYrh/AtY28pAWSJm/2smceh8nYk97OuhDG8PW+jO?=
 =?us-ascii?Q?rgoHSyiOmzLQZ1yqmUmxNxU3f5kaYjtHP+95ZhCgZb0JEaGQTIEqDqn4zJOu?=
 =?us-ascii?Q?5l3uQHOsgf5cy30NAir361dxkWz1XE3pBxkRh2QV/JJmvPsdXQDueoNx3Sxj?=
 =?us-ascii?Q?m6Pb/IjCnMjEy+eBfUvPo0jTm8RhrCf+fUTrS33IXERgg+qDuf/aWTrjXYrf?=
 =?us-ascii?Q?7qR1VA0mfpR0wqWKH9VBKldXDwj0hNVo7vDc4A9p0gu2YEVsuqKkGDUBTQmA?=
 =?us-ascii?Q?jtPBSmyd/IE+fhQNPUCBoZHfXuvCwxdxXHAQPYPOBU9NMoXENe3H8txLXky0?=
 =?us-ascii?Q?7ODggzBC3nUGwVtZebGITe2vD1YLkAcB6BkvShCB4QrTPoKU88xPJfn59bRK?=
 =?us-ascii?Q?CBICnrdydnvA1lH3eEiIvbSC+1uSEZ2LE/By4KIRkX09dKcb1VcXUs33A4jH?=
 =?us-ascii?Q?pAzO6XElUPSxwYFesyuKBPZr72zCdGJumfdI05NWZViR6+wxtTVl+87Sdhh8?=
 =?us-ascii?Q?IvfRJ/pyBoMXZB/A6l/+D9BPrXsqN+5wB5gT9r4RNJLAXsvPI+Xxgezvc6UU?=
 =?us-ascii?Q?SToHMkWt1z8EruU08Ng/TJB4x5e7WlP3IU+gv+84ROCeTcZZB/nxUym2h0QA?=
 =?us-ascii?Q?ZUwCpGrNYeZ6yAX9d9+5iQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 804f001d-886f-4131-2111-08db9d861900
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 11:52:27.5023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRnb+CcpnMhpdUHBZE2r9SeYcYx3kmvJZP07JokZME+X3VRPuDLdse9KR+CtA1TLh/oelJK2fLlxwtifVj6KiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_10,2023-08-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150106
X-Proofpoint-GUID: wrsA0_ZDIIE2ri4QLEZKjpuedy3lvwpp
X-Proofpoint-ORIG-GUID: wrsA0_ZDIIE2ri4QLEZKjpuedy3lvwpp
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since libsas was introduced in commit 2908d778ab3e ("[SCSI] aic94xx: new
driver"), sas_ssp_task.retry_count is only ever set, so delete it.

The aic94xx driver also had its own retry_count definition in struct scb
sub-structs, which may have caused a mix-up.

Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/scsi/libsas/sas_ata.c       | 1 -
 drivers/scsi/libsas/sas_scsi_host.c | 1 -
 include/scsi/libsas.h               | 2 --
 3 files changed, 4 deletions(-)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 2d29154ca8ef..ed9af2b401ef 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -201,7 +201,6 @@ static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
 		task->data_dir = qc->dma_dir;
 	}
 	task->scatter = qc->sg;
-	task->ata_task.retry_count = 1;
 	qc->lldd_task = task;
 
 	task->ata_task.use_ncq = ata_is_ncq(qc->tf.protocol);
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 86b5d6b87282..0c103f4523b8 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -142,7 +142,6 @@ static struct sas_task *sas_create_task(struct scsi_cmnd *cmd,
 	task->dev = dev;
 	task->task_proto = task->dev->tproto; /* BUG_ON(!SSP) */
 
-	task->ssp_task.retry_count = 1;
 	int_to_scsilun(cmd->device->lun, &lun);
 	memcpy(task->ssp_task.LUN, &lun.scsi_lun, 8);
 	task->ssp_task.task_attr = TASK_ATTR_SIMPLE;
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index d42bfdff7812..d8222c442640 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -563,8 +563,6 @@ enum task_attribute {
 };
 
 struct sas_ssp_task {
-	u8     retry_count;	  /* hardware retry, should be > 0 */
-
 	u8     LUN[8];
 	u8     enable_first_burst:1;
 	enum   task_attribute task_attr;
-- 
2.31.1

