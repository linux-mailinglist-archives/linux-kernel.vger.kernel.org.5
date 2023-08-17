Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25E27801F8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 01:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356164AbjHQX5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 19:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347544AbjHQX5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 19:57:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1802C35B6;
        Thu, 17 Aug 2023 16:57:19 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HN4g99000471;
        Thu, 17 Aug 2023 23:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=uiCAa54FMhyJq3J47n4SziVkmMZALOtTY0/AGQi28+8=;
 b=NSHitHEbgTwCc6XfpESSgREhkKO5cssvw6wMyKAaiFfuNmGDoJtQi81kGgOzsqcyu0ZO
 El4UlMc+8xFYEfuoMvw6Igdo/Z1zSjCaQhPoB9xS/PnrKuCJO8OxdOdEka8gFVG+41bU
 adt23NHPxi3d7hmLoutZoEGMULVtgzQnyXzb9hgfneGfuxovZzy/7qn8fmBkrcOPtOWs
 cOcKgKqad69Qwi0fOlqf6TZaz1xf7JVF/gdPSZYPexU7Jt143JEAfJ1urfXqYm/3/Z1q
 boblI0vkr/SmhoElV7ge7+uRU/8p59lIQsmwSKzMrbwc1cs/P9m/vqsk7ldwtN0nr+nd Jg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se30t2tpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 23:57:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37HN6xGE019784;
        Thu, 17 Aug 2023 23:57:04 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey3ysd6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 23:57:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwoWm70bMAH19eZBIst8kwEkLptfvxWi4prxITLFecjaBPUFhuZwg+a6+VnWvi2oqX4W4uPZTwZCHdUEMJQZ+facriRKVUhquhEzuziVOZyBOXY8ti9tpYw0yAkN8ZyTCrfvXIKXnSbxLR/O72HHGH/1YuCvyCZ3nAHWWt3h9996fvh1zgBUDM4zh3irX2kVAhj70uGgw2qzhwNSBD6bb5NAZYMgjhvZyNWQcuKgZknXz/suU9v+T5QkVewKZsoLNHFTmEF7bbQDMaA+nwbatQb6FBeSGZ5yvG2qRkOLkJiaVpG43VZl0uqbCA/cBro/ipqglwTWigMBz4Vq9wxqOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiCAa54FMhyJq3J47n4SziVkmMZALOtTY0/AGQi28+8=;
 b=iKEXAkKYfyBIzO1A12v4y+HaCGoRbZdYCVk8/9xd09gOpsNzGOpWHoiCXWQr9kY15If0fj78CK55PkCOfARnefaibFp7gw9jkCW6Zgv1Lag75iyGjwqSZEQxpq2hQwmtmDIu+dMChyhNVAsQxyr2JtVS8A8jqSgRJRLd5zXx3Mih9UggL+uNzwP3bQgaiYnLRlO9yno/Mlpp/4bSxGjGyhDZYG1jfUmWqBdLcZs39AlfdiSZLiYIt4gAyrDqOB+ES35SudxXd/sE0hwMBd4Z5AMKMJ4NqsHUSp3iEG5dsMA2eTzKLMUFltroBFGOeHt8gkqn8m+c8cg2OiccBGvEVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiCAa54FMhyJq3J47n4SziVkmMZALOtTY0/AGQi28+8=;
 b=FS8BDghu0rWsuJFscg/gzIfSxd1i3HLHPeOfJ21bfLeky5BwxB8PHzkqUcK5KYZQ58kM8Fzcj+sVP3X9+YopgnZFt0AH0pHuKiYJy3EAwfFiRXnCU4HHQVU6nI4phsfrvGIiJt5CpSMTOn0/Zlg+pBu6CZCqeWsqpJcjB+XSIbg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB4945.namprd10.prod.outlook.com (2603:10b6:208:324::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Thu, 17 Aug
 2023 23:57:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 23:57:02 +0000
Date:   Thu, 17 Aug 2023 19:56:54 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
Message-ID: <20230817235654.z7e7fi2gofnsxniw@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230817191505.1170876-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817191505.1170876-1-Liam.Howlett@oracle.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BLAPR10MB4945:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd7bdd1-fa47-4fd0-11fb-08db9f7da6ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GMRf/mwWtBOKzMI1NRo4FKMNG+HPLcEYTrOJVDZRpP+NauehU0P7TLQeWD1XvxaPTPG2Ho/XaDa1bSJpNNo/B0pIy8NkkiCq3m5pN3pUKOG3OuwAxVFt8dZNNpaY6S+A7M9GOWz0cQRKSHopOYQxGAt2kYD6n2WXLL3q3rL4dKA9lFrOLiG9IgTa6zzfqN+4FIlTTar7Qy6YiMxP/agTLGF4yxI20lj/ophK2hjAfsilCbL8IH7gO30yA9MN3pLshVGAPLhigTHB2skLCoLEA9Xogt7zFHzFx1cfFFVgMIrdn/0hsnpEKbOg5IB/eTqLf6oEthDvrMfO1I2tFns8aQqC6RTXJh+0a0tjA3Nv7xZWwMApiGxHa0vTtzSGJJbVs504yjmJyV7rC/vtyRykb2OvfKPe+d7XR7sqJF9ch8XSUfIc0AiTwahTcjY8vJUaV3sbTysRp4rmfMM4PJormDjUchjfj6cXSiOVM672Mlg0QqKErLDFavdUCTnGVLTrshXhuDac0SEohw2HaGJSswvROw3zPOHz/SJbYUdcouS3ZxiL+fbpFIXmz+wzvp7p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199024)(1800799009)(186009)(1076003)(26005)(6666004)(6486002)(6512007)(9686003)(6506007)(33716001)(83380400001)(5660300002)(4326008)(8936002)(8676002)(2906002)(478600001)(41300700001)(66946007)(6916009)(66476007)(66556008)(316002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ViSxmDXo6vKtcY2YaX+mE9dmRYZ1SWDTFKnjhSdjwCcYxzCyF7f+0I+k0zKG?=
 =?us-ascii?Q?S5X20wcf0CK2Je6mJY82mYi09cshLk1QjOXmcqOBvrMuXwe9VZr0jw/ptmWY?=
 =?us-ascii?Q?ZwqqUmpOt7wad+cfvriYSBb88+LxKmxMIbwwCnZ50maeePJUAZEfpHYX1FmD?=
 =?us-ascii?Q?basvCc0mKymvRJbE/P0i2p7hiMecxeZ+7SM7agrAZrUYBbbrbGd0jnRr8uWx?=
 =?us-ascii?Q?TegBVaqmuSzsXUX5NHiIUdljySGlDJBsWKynYU51exJLlw6KYTbPauBpT2mg?=
 =?us-ascii?Q?qomCxfGxOhw15UqqyqrtvVE9h9SptU6YyFfnZUlOifZzy7cZEkdxbVGy1OQz?=
 =?us-ascii?Q?vRSLjtJQL13mPoyEhqR7i+XPErZWvSiezGbmwG40IXbhdiVQZO7FzO5QMnzu?=
 =?us-ascii?Q?fmv20sO3/Cp6YkQQak+JfhhZW0GfTw/Mmfmcb2FSu0lO3+jPRsTcASda0hDJ?=
 =?us-ascii?Q?Qspi14nZcko8wXAmRy7LOmFSqv8aojyPsLRSwJSUS6eNh6Z1BAEPBqmvqrex?=
 =?us-ascii?Q?Ws7jOOfTcKCbU0sXjwuc09d1ftBHWkQcSW4R4o3k1pkgMdK6jJgEwxBR7U3d?=
 =?us-ascii?Q?uE2yIxtOQXQMAKkgf9GFH5UzAoZ6LOTh1tvgu7i10kYRPmOXwGAIe1c3Z+ih?=
 =?us-ascii?Q?e1vI/Hpx+yM5i/4CiVZeqcbwMOsIk9DmdZq0SvnumvbF0tw9pNbPVj9eMfB7?=
 =?us-ascii?Q?CBPPOxUveof/fM2tem9DCs8Hqdwufx0Y2PnMw1qVtNn+Vp3hKwtZSJNPHYPf?=
 =?us-ascii?Q?DqK4cNTFyYoLMO8O9Fdvebu7hZNfnxMRqTb88Xq8fDjARKAkrsHR7TriGeKU?=
 =?us-ascii?Q?NhSGo1wZBMesVXIZKH/4OTM1Rf8kObFSBTJ473MyBu6msZF7Jo2nQ+ilFYyj?=
 =?us-ascii?Q?2I4OWTuKoKf5SsS4eSfn1BCT0biSkgeDOvc+NXnLzfxq8vn3bx3YVvO1UCnP?=
 =?us-ascii?Q?awFqDczj/zTcvG+B9X4sOEbPmBuikes1E7vFds+HgCoTj+OEHGtX4GqtCgrj?=
 =?us-ascii?Q?2sBITf3Ut6RWEC9xXBPUaVV9hK6vghHleveKNwNLweYK8iJyNaLpLlKsJXJc?=
 =?us-ascii?Q?gk0niBjwzKWmx+dTGgFfqjcsdWYiJr+n40AH8JWF0NWrN1GXgK/A7uIF8/2J?=
 =?us-ascii?Q?RPQIDx9/fE1+yyr2Y/KwltjMqCawPJahYCbuqSdEJqmMm765sJV9nU258N5E?=
 =?us-ascii?Q?xao7eM1LQH4yaMaRi6KYlwAlheijPWiEPJOzKWh7oyQCjp82lhUUp6+2Vp7W?=
 =?us-ascii?Q?6tdm1X7cZRCkk4s1mJnJ0+UefRohdR9j8s49Z0K3jnVjO7V6Q9vCyhh1UiFj?=
 =?us-ascii?Q?ncwXD0tO03ITbZI8vInj5ZfiNJKRSvARbDiaiVCfJRP1S7luecQ0wBbiR8PJ?=
 =?us-ascii?Q?07a1K5/bBAK8Cua0ApdSmUcnvUy+krBPhOixkTmcBsHeQ81ULIdepUHG3KNr?=
 =?us-ascii?Q?A33htm1mus/zD2ZgY0K4JchDtUGtN4ttm/oItRFyod8385Om5iRh243M62SZ?=
 =?us-ascii?Q?8fu1HA1UyCVDl+BmyPIFgXBeOcpYuhhiJuv/7iiPlTjTic1+SVtdr/ms8u5j?=
 =?us-ascii?Q?zzx4EbQH6HcljB09uxRijnAhvzzD9+oD8+H/7et42Dr5zp4N2VEfZJAAMjFw?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IV3FtZFhIIOjJ36gPjlMKQJH0ZlV7fC0HziGsrCeoE6QBwPyVd2WYMRaBkBNHnY99oUesytjr0heWSs69Av9j01mFug5desIyPXLExcUm4Ue3Sp1Evy+PsTlAg6LDETjpfRF526di0vR2Z0j4wQd1kD9tPXW9kV/nGld7xcqMHt1Xo5PmtNgR6TmJBsNzT4X2e5bvrT7otudi+Z7oTqLcFj0QdwzXbtfTlWjYMw88PYXt3PTBbIojS4i3rok1X+U7USDz+xvDf9lyXePMs2Oy4hzVeVlM1V9LZQX+0i3yujLEo1QjJ9ewBGopUpGzUQWKKCy9ZYbyvs7EQNwUbbytfUjropniINI/yZ2qlLJ7jGsKnI6X7Rz/bbZ/wgB+YQ7X5VvSg1/1PPX7e1NZG6f9w0WoXeizp+7wjBXkgkWBz4Mh3WS6gKRstQc4gFP6Dxr8DfKzrsPjLHBjAFiQbrevbM8sC57QpcPDtDq8LSljo28uTq8NPEa1Mtm0+m70W3xQsbaog30mJs78bREj+FC+ppLoto4IeCuXP7O2tIdWCvjOiL1euKVtSSCzYZ1fPpge+pWnxlI5/rqDoW43J+fgjXbx0Kq4radBzcVKUAqG1UgGOTWODVMn4GGJTfV7RzlWBD23Gm3WFSyJsC2lX9oKxspQH28Fzo4tVEkNHpsLZZ0W5er0OiCvKLjbrFLSEW7GCW5+7168TiyPPO6KAX1wPHPzEIQ2uGWE1igzjhjt4Jd4SAvy1jTpbFVpoZhtidEq0xgOtMFmBx5Z7dJQ6BBiUvz1ABISEh/E80PYbEQeyblygLHjsuFRj+ReWhrAtg/ZXQDz6vuvGsBoiNLkCJFVx66LLDQzfs5Q9hlSIpzqvIkKvjAZPUZbIHfk3IVc7TdUCI40YQedlg+sgaWV8plwA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd7bdd1-fa47-4fd0-11fb-08db9f7da6ed
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 23:57:02.4818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbDNR5nUlIF8MBMKqe1nA2XKNbDcQGElbHXqoBJY078Vyr3R1IU6htu2/DtdMu0I8B3k5LJZFaC/l5Ic895r7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4945
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_18,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=913
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170213
X-Proofpoint-GUID: 3PZUfSgR2L0n5N_nlFhGosSPwZdKHUsb
X-Proofpoint-ORIG-GUID: 3PZUfSgR2L0n5N_nlFhGosSPwZdKHUsb
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot the fixes tag, I will include that in v2.

* Liam R. Howlett <Liam.Howlett@oracle.com> [230817 15:15]:
> The current implementation of append may cause duplicate data and/or
> incorrect ranges to be returned to a reader during an update.  Although
> this has not been reported or seen, disable the append write operation
> while the tree is in rcu mode out of an abundance of caution.
> 
> During the analysis of the mas_next_slot() the following was
> artificially created by separating the writer and reader code:
> 
> Writer:                                 reader:
> mas_wr_append
>     set end pivot
>     updates end metata
>     Detects write to last slot
>     last slot write is to start of slot
>     store current contents in slot
>     overwrite old end pivot
>                                         mas_next_slot():
>                                                 read end metadata
>                                                 read old end pivot
>                                                 return with incorrect range
>     store new value
> 
> Alternatively:
> 
> Writer:                                 reader:
> mas_wr_append
>     set end pivot
>     updates end metata
>     Detects write to last slot
>     last lost write to end of slot
>     store value
>                                         mas_next_slot():
>                                                 read end metadata
>                                                 read old end pivot
>                                                 read new end pivot
>                                                 return with incorrect range
>     set old end pivot
> 
> There may be other accesses that are not safe since we are now updating
> both metadata and pointers, so disabling append if there could be rcu
> readers is the safest action.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  lib/maple_tree.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index ffb9d15bd815..05d5db255c39 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4107,6 +4107,10 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
>   * mas_wr_append: Attempt to append
>   * @wr_mas: the maple write state
>   *
> + * This is currently unsafe in rcu mode since the end of the node may be cached
> + * by readers while the node contents may be updated which could result in
> + * inaccurate information.
> + *
>   * Return: True if appended, false otherwise
>   */
>  static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
> @@ -4116,6 +4120,9 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
>  	struct ma_state *mas = wr_mas->mas;
>  	unsigned char node_pivots = mt_pivots[wr_mas->type];
>  
> +	if (mt_in_rcu(mas->tree))
> +		return false;
> +
>  	if (mas->offset != wr_mas->node_end)
>  		return false;
>  
> -- 
> 2.39.2
> 
