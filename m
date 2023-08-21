Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C4178347A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjHUUjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjHUUi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:38:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4AB132;
        Mon, 21 Aug 2023 13:38:57 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFxfWL023973;
        Mon, 21 Aug 2023 20:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=MxC3rj65qtuICFWHCdy0PS6vJa4iCLKktYmhYKm8Hpw=;
 b=f63/bwVZbd6LWbxpFw83nOXo9EQHJcP+i86Z/hS+GjVD2tm36+2UgUYCiSLhxXRgyWq+
 BonCkDL02EAE42zIawOZZsWqbeWBKPXA/Kj6sryCQO/V32wRHXMY2FwBBEBD1y0waxxO
 IuPg59hfMYorFXzHMRAutV8dpmWgCDxSeuzHgKc2NMZTqHJ4Z2+hdj7UEmdcYyIlWWn6
 FjRrVjYDp8AEGdlyOjjXWVtx4i5/bpLS7soLdRdmrh0MFsMuuSx4rHWWt97L6AL3C5Sj
 RgyoqhT/B8FCHr9R0RtPy5DcgNMZrI6+OQhnR6CGxf9CuNdoq0WIC3A31Tq/2CB2EIvs Vw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjnma3sfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 20:38:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37LJxwnW026716;
        Mon, 21 Aug 2023 20:38:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm646q9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 20:38:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OM0Bzo/hvhMHCOYSvvdJYc6LlHjC/ol4AONmK6gEn6gUIOU4chWine7GAZsIhX79ej73aPp0GG5Xm698o9+Sw0WKCevjv7pDnR/pDqekFLRAVyfmfiCZkMdKcuTp1LsLiMyLI9h2K0s9k3pUKviQNFTsA+1Quo1IjPSZB/vFFXaGFlyoWAtxDrZmO1mjlDnuDemoQkAB1cn6IfTwwFBgmU/w2PW2iZEOArihjI9GwrLfRXi/PxPGQEM/tU+fH6k1HmEK2Swtv5Cu/zIqkye3/a0EzRdZFHD5Ax2gwXvDjUnVeAk8SypQAhIRkSBIoV6CuRXPCYooyIZ/j6vk/Tq4HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxC3rj65qtuICFWHCdy0PS6vJa4iCLKktYmhYKm8Hpw=;
 b=OT5eazRkhq9MMJiadaDlQ7Ep1gAeHDp3oeUHSUNJoE7iosBW/izbjhJb9OnAO/XGuEDGHguIgFng65jhk6FfZ0209fkmq56d4UeM1FXVyYxD+HdzhGt4AHzY13sjKLUJVejX/PMH/lSvHb5IeR70LbTDhoYjJNBT/13JP4QfXl/DYsfurTpJWq9B6pzN/sjm9yhetnPjvJbP9D3lFTOyavUXATrCOlu+eolLSzyrf2sMwdDAbU/c1GEtPmXBIbeNNmCN93AbcxEnxGe9eLnoi5EeuOzwdo8t6FaYlbRpG1MBp5PgD/nzaKKB3PiPgdq+KuSVpVoG+8c/I/Oz5Vhw+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxC3rj65qtuICFWHCdy0PS6vJa4iCLKktYmhYKm8Hpw=;
 b=ZwkQuT7Fn+K9ETHPyqP3sj354acHsqBsvyGHDNgSPqPUrT45qUbqKgQhWOltkofYtHth2fUy6smzvq5Rjw1eI/1wzH69Hw/elK0Ykceen6KIJHNU0pUcAoc2j9aKY5TkkeiUc2gkEBtI3AIvYlZzdwOblMZD/xqZLMmugrqJxWE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS0PR10MB6224.namprd10.prod.outlook.com (2603:10b6:8:d2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Mon, 21 Aug 2023 20:38:17 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 20:38:17 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 11/17] scsi: gvp11: remove unused gvp11_setup() function
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1r0nw872p.fsf@ca-mkp.ca.oracle.com>
References: <20230810141947.1236730-1-arnd@kernel.org>
        <20230810141947.1236730-12-arnd@kernel.org>
Date:   Mon, 21 Aug 2023 16:38:15 -0400
In-Reply-To: <20230810141947.1236730-12-arnd@kernel.org> (Arnd Bergmann's
        message of "Thu, 10 Aug 2023 16:19:29 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0035.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::10) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS0PR10MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: 836c1ca9-46e9-453f-1f23-08dba2868cfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xRiXPdAf0ksxJhxsmBaCbz59xktlNVtcO0YLFIxJ9+a+pJzpWc2Pk79FcdPm9M78wV0cOA+FzIOFkQP9Znew1hq1Di6Yvuih1lwGJ0xJbTvelpAdjTyg5B9YGtEW1jrSc/+wSX+KeVlp5x1BFA+Dg3/E9WTAv+QY0cS0t0cSDNFpN1WCvScK9mrYF1UVfT4BXmzq8fvShDbd99UWO4EwB0hnsBLUuiiIgXaA9GfLvsNEDp4bCfZvygLoJWGDlT4y+ZqKC/Q/jG289kGxNBzg+x5D5Id6MEz9f2ALHzrIiynAFL9HHN5hQgbjqjhz63Oaew8MSsVzyp73WFphGW+U4zYQx4uACqaj/k017B46ZqFsTNVWjaRLOK0xHujeR+DM65I+3ihrmTdVEPhAO50tVUR+5QvhXhC4nME1WBjfAFXFcTn9Qu8tAdn2si/rcf5bjfn7aFX3Iai43b/Btbjy6VbxqaW5dwiylaIAivEZnIHmy4foqNtc8U1SMT5eE2trBU53RwQE3OnxvsOJgk1b8kpDvUoM8oi+fXH/GBRIycnYSkXaSQ7+3TgJqdPwleJw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(1800799009)(186009)(2906002)(4744005)(83380400001)(6506007)(38100700002)(36916002)(6486002)(5660300002)(26005)(86362001)(8676002)(8936002)(4326008)(6512007)(316002)(66476007)(6916009)(54906003)(66556008)(66946007)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FxARST+4OeW4jIjf50X8wxa0YyQuErq7jwgfmtPBlmi06wmFfMHq1T2gsYMM?=
 =?us-ascii?Q?RF/kyRK5L919OMKYD+gA1A4qFLDCp8wDlE7bva5MSCYezIp42O/NT7VzkuCA?=
 =?us-ascii?Q?TBHCp1a6potwBggCva4sm9ORiaF1RseCA3RALUX6mefFV/k8EUo+OfvSeOGh?=
 =?us-ascii?Q?pnm/nIG/pM9rkabDn/gIcBOL6NY+pD27taHcJMFqMDdxM7uOcmWuTCGB+kIp?=
 =?us-ascii?Q?n48mJ9lsaHJVssHhFmSbH4naRoi6YSAyX1ZqQlGdEv0SqmYMrq/LRxZGyzm4?=
 =?us-ascii?Q?/zXCh/k15h8YJz5m+5mwLPgf6bQZffMdheJfIGyx2e0R7WzqExiFh5TPpmFD?=
 =?us-ascii?Q?0RBzcOHhTjVA8L4DlVVongCfilVuflONveT2tBAA3sTezzdgVu1KPi0vlEYR?=
 =?us-ascii?Q?MAU/a7jXSoxU6cWnzmDLznSn15fkGirhaLgsy3DW7ohndpEvSke0Y4sWNIKT?=
 =?us-ascii?Q?EyJXSoVPtrbUYMmwWZbTzXm4S8Gctfb3uCPZsaQtnKSTnE79hb4kLGvdhJ4q?=
 =?us-ascii?Q?131BPeDvL3/uLOHp7iGsJqJqR5e+vEk+g8sp33/dYdoYV+BTfXmXDgUTY9TV?=
 =?us-ascii?Q?H4Tak2TbWZQ9OTGoYQpWuhwUt7bWRkZzXyvJvxXH52RKC8o+8dGn/ri0kZtq?=
 =?us-ascii?Q?c+WHUrHlMROij/SHy11tUKgnedtgH86tmwGswbWa2x9mQo02Onoyrk8ToNb6?=
 =?us-ascii?Q?cJSSK6hbPQqkAw/YUtEMRwjR/ONCsUwJ1NKCVfDQ2G3T2L23CSYmQ012Uxys?=
 =?us-ascii?Q?uzzrC2mko1tW9vEsrMKrINZrxbypN+NvuY2HklQW8oVYx5bU4g1d8bf/fqNn?=
 =?us-ascii?Q?aI/J2DBIO8JhIeUUcfG1jrrzV/D4A2YTW2ijc54AuyI2+uEqUortaxd+k5DU?=
 =?us-ascii?Q?eBYTzXYz434/vCaFEi4m9rK+nTgWeHzkYyIMROtMp8pSxc8kQcSCFeivzgmx?=
 =?us-ascii?Q?Lx3esWvUr6o/rKwGwK7iqZ1EOOYTMf/caqH5OESIh3RSG+x8NudWgQJAWfuE?=
 =?us-ascii?Q?JpiX1M6ok3ARorFY1UoUy7M0pDZgWsiyRKJakbNb8FefUvYZEQkNvsjU3cdu?=
 =?us-ascii?Q?l2Q9my3ua+djFtzT1Vz6NWoRpF9Pn6CKhZPw+Rvwl6BHA0GxJaBFTeZL6Tna?=
 =?us-ascii?Q?CnlR2gxw6yjzwYQ8mdi62DDJC9Ep/sQHNngYwadmNdnQn+6aGlX7PKKmfQXg?=
 =?us-ascii?Q?1MtSpFFC2dEYGqxgqVkeaRmm/oawAzSG5w+HeVT/dpfwUal4N0ImEzjPfjPY?=
 =?us-ascii?Q?VgdX40C4AvKheYvW6SjVkL6kH2SvIZur4L4NU7y1iis7ihwdhoQUPgusjWWG?=
 =?us-ascii?Q?JlZkLXIPPmSRbXK++kCgcKd/lqfv8VUVGFX5YB4PrDSXFvR/HBAQHTRhRG3a?=
 =?us-ascii?Q?7B79fErpb2Z/TrRsLZf6lqYusuuk0Egodtp57zZEhgSEb/ZhOQNB4zjPgZda?=
 =?us-ascii?Q?bRoAoEcZEYRBQGQDmHkGPxt3mQ8jO6u3mZMONX1a+GQVybNlwMsItgLNLZE1?=
 =?us-ascii?Q?uG4I6W9CjHEpG2iOiW0/53lrvmbkDXdx6a7I6wfOQMCOW1VhPmTmeBmh7BVx?=
 =?us-ascii?Q?lqAZ3RyXTobzSWaipCutJe47xE6x1uNnPBExEofXaHx76/r3u4N5WFHCA3Ps?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zrjmD2B/wYCSkL/8+Vh8h0l3Z9PjbwHktkAVM1AQ4UN9q+qVKfndJypGAa3NziOWSoWjulS/fLGw6PDfUVU8NnaRY0LqGLtIgleNjgZZS/RulJpJyGF6Ri8TGKY6s3z4R4Ln86ttOCxo6XT4s3iRucnm229tWdNcXhbFd81vRpU9PvnCefkgwoyzCEJdL4x1+gC/b6SjyMfQyVdYpKIIslHYVv2G8uarj3cZA97t3gR/WKuYKHgapVyE1QNVY5tlQ2OcLhpcPVlhZsGhstC1jy/0kYslpTRMiz3LzARQkxjaVLP0vItO9snZKFjwwnA+03hB2lAHQjCzjCkeiOuZdDBbTWbtbcZxPSwi9ozzpGndJzYFNMn1zeMa9foJ7SeD3sK3RvU4bTJkAeZhXqjgNs6P5/GqGunLVB/PggDcyyoqnd7clthZoCtuWARK8P0wdEKMN0kUU82dKRsOm0oNqxS1jhLwxOG/Y/N2YW2cCrtw2KJcqxHeTUByTzH2tba/5AM+LBO7QQWpcbnpXZgjxyQ/5OPeL7wu67ECN1NfEu4u8a8EEhsJlNiqmaMs5OfiIAk4Ay3Y3HbZERqOuWulcNiELj6F4tdnBXQKDhDUnDUbrcMfVprgFS7oRAoCOYFRZnWMstNQqrEsxvLqNJUg9X3QStYzOMu3ppVCPy7QpgSZau2dLlsU2lYCF0dl9fvxQ9G1hC0sHZuKx9sIAtNSMbe0mIroj2/nVLB/WSiwkGhPmuPqHTsHF7wGj4wLmyZKkwNdKOIGFASfs2q2T3pE7TxInVCY/GUwsm++DKA+DxFGm1BGYsQ7lUc03OLsQeIjNvk+gZDqIOAf7NNYjOkmQ3Rz/tDV3VMwXvkUKpuCUdLZ9EWj/PsTou8hLfiNWxSeBnyVDXbCSpGCTLinNEYnKV73iI/UwNyIyD9k4ryKyoc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836c1ca9-46e9-453f-1f23-08dba2868cfa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 20:38:17.8539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vl0lPFRLQ/FG/eQCyZbG5EUv535Hm4E7x4EkIsiasGyvlqWmlFnSoljFZpx8y2AkFJWNP4r99E+0mfUUEWaaylgSSESpy69+Mxqlz7r1BtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6224
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_10,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=643 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308210192
X-Proofpoint-ORIG-GUID: nx5RDczIRAGuCtV52ly9eBt14he0lsgj
X-Proofpoint-GUID: nx5RDczIRAGuCtV52ly9eBt14he0lsgj
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> This function has no declaration, which causes a warning:
>
> drivers/scsi/gvp11.c:53:6: error: no previous prototype for
> 'gvp11_setup' [-Werror=missing-prototypes]
>
> Since there is also no caller, just remove the function.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
