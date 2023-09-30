Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1310B7B3DA2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 04:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjI3C31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 22:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjI3C30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 22:29:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DCBFA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 19:29:21 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38U263v5032593;
        Sat, 30 Sep 2023 02:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=aGTFbKjVuIJSDD9JqTdBKHaXckOomB/oscVcL9ZiNrw=;
 b=U6uZH2PAVwC1Yiujqh8s681IFUS7k9FN5DXfdnaixb/+kCyEjdpCMSX/4Dyku54P8JqA
 xjNuRCbGAvWswcCYMPTm9019qQXdTMy7a8cxdburdje+c/JPLY2yhFcUR3wBqh4s6ed+
 3lVEoeO5R1OkjtJKXNYpvzSr6MbT0n5aZvX86iWBUcAcf0r/LIgxJfan30f8xUOZvPcm
 bdRqyKPUNkila+c5nvT+q+FObkeaSl3GYSC9p5yXsi1WUNNvjijWNr4LDkEGdBbVLb6y
 k+Neptq/zesn2IbTvbO74IxS1b3BrBHfjJFZXsXc5vOJAF2ijIUQNSWLAUuVAfe37xw5 GA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teakc80dk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Sep 2023 02:28:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38U1XVD4035785;
        Sat, 30 Sep 2023 02:28:49 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea42s9p1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Sep 2023 02:28:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhDJgxtE4HDWv5x1YTlgYHZ58b4smCGSK3ODtkbr8SSVmbOx+6JTzgdy/Bg3DVuAA1FlF9WyhIezoUsgidix4sep0cKGYFbqFQzl8qAKTqdF/Hjxs98A+20OQ1lDFlpGQBGCWUnShYe3xmODJkQFgKgBFWivtH4XnJXT7IBgqXxZjqz2xRFtUBWqw7Ylkb0l2D/nIeEnp9swVR0Q8U94Ub0BpCWAHCHf6qm9Ot7ecmFglK0IR4E6Co5YlL+KdpJGejw4AXuyhb/kuXLH1ixqN8gpCp8UynFdd5eKbebAmAcJBq3ghmgz/xwJP2b8AV2JNgTHxiaePLMAME9j+eeE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGTFbKjVuIJSDD9JqTdBKHaXckOomB/oscVcL9ZiNrw=;
 b=BQ4wx5swOwA0WaIKuvOWCg1pMeSQn1ySgvyR+pY5RsAfvBoU3OqDFUFISAdbYlIuYvzJvyjDldj9cZ9bmLV8idLQNxpclBnUaKhGvkof1L+EtRO+Jge1/4x+UNaBTdqf2jX0q6wTUEKVANqkVk3eLfMXuKfE3P7MNVOQ6ZH+i4Kt7MRb+l3x6jAFatzzvN4JY/zeyKEKBUMlMAQUNPdYtrh7iY9v7ef+gX/gMWPM2fFBS1EYHgEjmnAyf2h09X24Iy6DbQZpCpvqN9aMFsjHpgdlUHRInh/UrDxP0ECRH6aIVjpIZMbtvu+CSVo0K2qG8wg45ctnHc+vOHmOD4vnoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGTFbKjVuIJSDD9JqTdBKHaXckOomB/oscVcL9ZiNrw=;
 b=SZUf1ELXvSpB740lKxlWFR2Jv6xwoDTUEa50Rl62sbJz/2MDiVf9n/Oh2Sah6nllM75n7KQz1VsFdgMk79StwdQt7hrjUlnU2HrPnkJamMdq9okar8oZgaVFn0QMFhbs6LL+Fk+CJK2ONhQF2/L0H9aqZdGfiwMXa7ouo7cZmwM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by LV3PR10MB7915.namprd10.prod.outlook.com (2603:10b6:408:21a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Sat, 30 Sep
 2023 02:28:46 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::94a0:adfb:6474:63bf]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::94a0:adfb:6474:63bf%6]) with mapi id 15.20.6838.027; Sat, 30 Sep 2023
 02:28:45 +0000
Date:   Fri, 29 Sep 2023 19:28:42 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com, willy@infradead.org
Subject: Re: [PATCH 1/3] hugetlbfs: extend hugetlb_vma_lock to private VMAs
Message-ID: <20230930022842.GA82828@monkey>
References: <20230926031245.795759-1-riel@surriel.com>
 <20230926031245.795759-2-riel@surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926031245.795759-2-riel@surriel.com>
X-ClientProxiedBy: MW4PR04CA0312.namprd04.prod.outlook.com
 (2603:10b6:303:82::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|LV3PR10MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aeea6b2-54cc-42a0-2c22-08dbc15cf83d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /PjfLVqTVdXZSVrZXHMddcK+TA1NmTPAlI9cEine5U8pc+osw7aNO2tuPtNp+ZWwq7nHPXsj5BbwtdcJ3HCRyoCCsHbc7exIAVHYX1k+6pKA1+0eRPZhzykqZoC8oKfrAYK4vGXLFfcjp1uc5zUnzPxvgH5nL7W1294FvbD/vGXvHinBU+hAAIzrA5tFznzDV5tN7rmRJH2RaltXaUEb42p4TLJhtL9dUjXV3pyd8BBFh+iZh4fzj/e0tu8q0tMDzr6w0u5JmehW8EVxl9V7Ov1eq2WTEpZ+y8KgyLu802EPrVZFV6WHLqxzI98DPlAsvXGImeSa2BuZY3BMYIPBTes4QhoumwoEAkJzKY3foBLvvRzcU6bCfpWtl7ip+8Mks8JgeXrlyIZS4L82FWgpBT965QA6z+LKABinfxi2HJZxcV+vFIMVaaiGtW+ZrgsiC1YXliKUli//2vEMOHSe6jMnpm8N28R759oebZ6lOki55n+wtP/TImJ70ArwNfvKAqcg47ooZWKHvGIWOJwc9frTYnk9PhkiTf0K5UJ6/P40d3PD29Ox+bSiuQMQZAvr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(396003)(346002)(39860400002)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(33716001)(316002)(41300700001)(83380400001)(6486002)(6506007)(66946007)(478600001)(6666004)(8676002)(26005)(66476007)(6916009)(66556008)(53546011)(6512007)(9686003)(1076003)(4326008)(8936002)(2906002)(33656002)(5660300002)(38100700002)(44832011)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nfVBSLAO/F/vNryarm/zWv+RgKpocu8i1YF/qb84EI/whEeNN6FQkDgBtJeP?=
 =?us-ascii?Q?XAa9vz1TZe3ILhhq1Zk9nhSqLBWqW0CS4KETQM4cYZEj5gxXkgTexJwbMmwf?=
 =?us-ascii?Q?20E5ruzG7qwarmCytH7TFsv4lhasL0JdaXYc2+7Et5HkGlk/EbGoDJD84S0B?=
 =?us-ascii?Q?mI5zRFDt3N5VjdEwn0dFzSh9H+xg/yM99NVQbZimdy3iBrd0N4UXpHwKYPtD?=
 =?us-ascii?Q?kULIlfTYSJ5T45k3dxaAOO4Yp8gWskKgE4TomHNuesL/BLHNkUSI57Ni+UTc?=
 =?us-ascii?Q?5nElhiOVDYEO0csG3CAm9ACzorDgkRgd0cYrhfkFI46pi5vx4PZBwhflsqaQ?=
 =?us-ascii?Q?Lh1R5hJcQEGCaM7nTvFU1smfPESaxETqO6hcWVYF2oaKJIUxnoS4i/HKXA2K?=
 =?us-ascii?Q?nhaLNeVnNuzLC2bc1D/I4eQr9Z2dVRqkOv1Bz+69Sh4kBCCo7mQKDgsDKykB?=
 =?us-ascii?Q?eEeG+mVYkWwoIdBqN3TYa+PFo4wGH1vPClISgkreynlHHtIv2ICPpesIDQe1?=
 =?us-ascii?Q?LZkvblo61NXcVf1dqNLK87mCoVcIy7KWj3sMr844NCyCRbMoIJ3tbPvX3OM6?=
 =?us-ascii?Q?UQ6hmIXFm8zrkH3Rc12bVb1114EpeVRo6SUYz15cFkKHdl679ZBLCm9FrGyz?=
 =?us-ascii?Q?CY0YygBIxTOCVFqDHqlP2AkS92UqUJUpyY4GTFQB8JJ8INWwctnzv1e2FmM4?=
 =?us-ascii?Q?KDI8oqncA3+f73slLi1lVrqGykneOyhylCqZrgXWZfI8fF3ep3h7dGRhbeXe?=
 =?us-ascii?Q?f4r7RjRp0afPyDC+RfIttBAUA4Qh27xY7LqlEJmnK5Oksw1I533J+HNJsqyF?=
 =?us-ascii?Q?+1QMBV+ydFM3HKTF2QUiJguqHs2SY9bR9q0dbyFrtNZEMsecDSap+QqobC0x?=
 =?us-ascii?Q?qkIxiWm3bqrMFvW0CsRFrLuVlu6YvLD3+JVGNgA6cHkw+ZnAq5/jaJrCB+YZ?=
 =?us-ascii?Q?35bhn0fTGUaLw9BZ4sHG7LufqM52bvliwxq/bEUDCzkxV/zyvcTsoumSveEm?=
 =?us-ascii?Q?GL8S9TotOoN1GeobGi+VlzQloyuGfhOi9dXo3SwFlEoizAdJoh4ygyJ1XKqY?=
 =?us-ascii?Q?J5xjECVYhQhuw9LTkeLREkZT49cb5Np8W3JfC5Ssof4bAs5M2+wOTKpuDgCu?=
 =?us-ascii?Q?5H4bmxsYloJHf36gzj/K353Rpt/8NJ+RvaXuPyAwBG23sPfo1bd5FPoLxvNN?=
 =?us-ascii?Q?7rVw0yTzWTv2CFTOuCjkr3TftAXzGPnj7+ip+lEhLtuyUqeVlvZlVkYHOlLb?=
 =?us-ascii?Q?JHS7yaHu+N9+Ku+1/1yhzA8d1cIu2xqZS/4rd5oVxe/ixiTqpiA/eOQ6uQ9h?=
 =?us-ascii?Q?A45ygF7lSQqOUhz3NAM42tAO29A0PfzfsLRcZOM/M3IOAPc3WH2P2ZSXpSBi?=
 =?us-ascii?Q?hZVNPEH4npWg6Za+/naYqAdc5/bfGhnTTuYHTAHmRado0kc36/kNh4PhBP9T?=
 =?us-ascii?Q?F/+8pBjMwSQCQ2vatG+D/v/2pYmDjqF7cdQuzh9s6W9Ai4CmE5szvcqxA9Nb?=
 =?us-ascii?Q?dGUTla+HM2OF8c6vu3WHDMD8V2fXxYXg+xE7aKgwqk6Wphsoi8ecJdgXXZSI?=
 =?us-ascii?Q?88BLw2O+ywNWAUPkBvWHABmCASm2OYd2cyhC2aR9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?jmXlM0DQr28NqPwAhMjYvpNzGi6VQAyjX9EBMi//2+MfFrvmHIxJX1/GC+bR?=
 =?us-ascii?Q?iHo5a4Ystt60V7hz2ereqEBmALqOJOs/UcLOEa/0pX1sje4chnCmStu8fw4q?=
 =?us-ascii?Q?6vxB48iPZa7I6JygKah7TAZSLguWL7xjCF2nWahN6bfjML5b25EW5RVvjTpG?=
 =?us-ascii?Q?j2+Djgi+M3357cuIvERwD0eRoQCzJ+AkXQS1BfORA84moCEvpUy54DQUUz+A?=
 =?us-ascii?Q?08ZYTl3zvAwpitl76nGStSRjjP0/WVr68q2g7iR5qwrqon9QGprqgSWK9N2a?=
 =?us-ascii?Q?6csIDln/WooWfnoTfz8a/iI24zhCyiOvTD19iokJbO8Ks/f/JfaWsl8+cSqL?=
 =?us-ascii?Q?s5QpzywjMqwRyf37YDsY1PFtDZ2fU4GbYF0zSh5JoeRoPZmEpalJ/cVs8Ap+?=
 =?us-ascii?Q?+E0pnvO7VjYvTtkkhXPVJr8jn0f81J0Rq+msUJGmREq30gy9kpQHt7G7dOtf?=
 =?us-ascii?Q?As/9SKpwcBRx9tz9dXMJuP7OVRkM6HZUPAhR/zPGw+eKAmKiv1ZEV8b3no0N?=
 =?us-ascii?Q?y+yHgK0rTaWXAhJgxOpTSIsfPaO1yTlP84Vj5dIyQKJohYus/GTjnp0T6rQf?=
 =?us-ascii?Q?DPYCF0ClTIKksAvf7mR+EWzLw8bX9roAQRBdm6RP4pQ9wIDK6Ati6oJPxJS7?=
 =?us-ascii?Q?eredb0lCsdxNB6vpt2ACcKM7XBPsqG94PHTbn5tVBBPAGxtKvXiqGMVK4ofJ?=
 =?us-ascii?Q?hRFzPywWa/jr4w5ZTxovP5ij93Bzxg+moS/wSurUdDr5NZr4eorR7Teb+VRT?=
 =?us-ascii?Q?oqY4DLWqV8rxUkAaedMtFiEEW7yxI6JZ9Axv0XePnRfCMvzJL4ft05jvcsRA?=
 =?us-ascii?Q?s1M4ZGLL3uqGsEHM/2OQlHvuEAWOKACJwGogx+P2ZCM5tPLBzkTSiaESSxUx?=
 =?us-ascii?Q?v8P66R0CxfsrN0rmKGWtJ+AOVwQq70im/BLHtgSZhO1SKPCfvSvHv/FYS/Zb?=
 =?us-ascii?Q?0eUDP/ImKNlM2cr0gvf3Ug=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aeea6b2-54cc-42a0-2c22-08dbc15cf83d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2023 02:28:45.7712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IIlLXSSfGqVd0DlcZRCqiPLusjgTErO06pKVgaCHW4b4adFq3pLxBf5dbuoiN2VGdPLqu0H+s+juQL64lVnRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7915
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-30_01,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=787 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309300019
X-Proofpoint-GUID: oCKs86kb_WppTywMGJL2cQaKKujvyW6i
X-Proofpoint-ORIG-GUID: oCKs86kb_WppTywMGJL2cQaKKujvyW6i
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/23 23:10, riel@surriel.com wrote:
> From: Rik van Riel <riel@surriel.com>
> 
> Extend the locking scheme used to protect shared hugetlb mappings
> from truncate vs page fault races, in order to protect private
> hugetlb mappings (with resv_map) against MADV_DONTNEED.
> 
> Add a read-write semaphore to the resv_map data structure, and
> use that from the hugetlb_vma_(un)lock_* functions, in preparation
> for closing the race between MADV_DONTNEED and page faults.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  include/linux/hugetlb.h |  6 ++++++
>  mm/hugetlb.c            | 41 +++++++++++++++++++++++++++++++++++++----
>  2 files changed, 43 insertions(+), 4 deletions(-)

My bad during the review of patch 2!

In reply to patch 1, I suggested the changes:

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f906c5fa4d09..8f3d5895fffc 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -372,6 +372,11 @@ static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma)
>  		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
>  
>  		__hugetlb_vma_unlock_write_put(vma_lock);
> +	} else if (__vma_private_lock(vma)) {
> +		struct resv_map *resv_map = vma_resv_map(vma);
> +
> +		/* no free for anon vmas, but still need to unlock */
> +		up_write(&resv_map->rw_sema);
>  	}
>  }

However, the check for 'if (__vma_private_lock(vma))' was dropped.

> @@ -345,6 +372,11 @@ static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma)
>  		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
>  
>  		__hugetlb_vma_unlock_write_put(vma_lock);
> +	} else {
> +		struct resv_map *resv_map = vma_resv_map(vma);
> +
> +		/* no free for anon vmas, but still need to unlock */
> +		up_write(&resv_map->rw_sema);
>  	}
>  }

So, the map_high_truncate_2 (2M: 32) libhugetlbfs test still BUGs with:

BUG: kernel NULL pointer dereference
-- 
Mike Kravetz
