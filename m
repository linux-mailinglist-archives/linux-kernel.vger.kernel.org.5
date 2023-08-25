Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE57787DA9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbjHYCdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238995AbjHYCcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:32:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0191FC1;
        Thu, 24 Aug 2023 19:32:52 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37P2T1BU008612;
        Fri, 25 Aug 2023 02:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=zrR0LLK+qEQ0MLFuqjB9tw8/5G/mvp4XZ7i7q3spcIk=;
 b=bWaEHtmaXVYt1t75/jd+ccjyHXKzj3MveJQB5t0uFFEj2TiKq8JG8ONrX4Emn/6Uzc3F
 5f8VTDULRJhW1y4A5XgeXVrAwkSTBXc1qXeSi0DAB1AIRv4iAHsuJ6QjgJFjPel00fdt
 0SdZsmL3EW/hn2+I/8ER35tCFGUHy+o8qZ0SqYd8QdUrJsq2TxNC2XhOozAbafByo9WU
 ziEm4sbV2SO/mM35dnY9symy6KcrBWAlSiFOaBbnMPI3Pn023oVQjkqscRCcXPtaq15a
 pF/y2I8BLKjRYIbEn6f7a0EU1xzo+1+lf2pX4heAc6jIKFRb+Y4ZvqU/nSbRKHQGSoD8 cQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yvwhec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 02:32:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37P02D95002194;
        Fri, 25 Aug 2023 02:32:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yxhq94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 02:32:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUr31jaOy03ybpJ6K1QtZIzAGjTG0jdapkb2GmEFh9yDOyNy5RIfnzhvIjXEJrzJ0+8qj2UDtY1m+W6JnKGwBf73U3BjI3n4nAHVSe0WYL/bLjQ35x58O5h72YfkB18hrwO3qrPusD0DaY039ytNS5nqurmqZks00f2eeDoHAXQAS4aM+3PRYd2YP2/2qCwztytUVKiuKQxWxwxzlnxeGj6IhNp2UD51J9g7wdJd5rDwXA7D3/DHDEYFYDgaHOUEFmuKtXWndp/2OTylk3lmWSYmFCfzEFxUrPEBCZEmSOyc+wxDMt9Ba77poZ+jNyRj+WjkgEQ9GBaj6tuv81pFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrR0LLK+qEQ0MLFuqjB9tw8/5G/mvp4XZ7i7q3spcIk=;
 b=QstsLyMIywp5KCtgq9cPWD36EYTEwY+/Rs56m1k3FUsCqHnv/MQQh3JAgJ1uszMkqnf3PoGUBT3d33oguU9EKuSmj1jXUYWd5XJ2yqutMuh2WHzoRT1SfZtzu2Z9KT7krkC/uwQZIZt83wmKIbhPFSJQRrfNDpUNGJFnx2PhwTTVmOOiWo9k/ahsNSlDOv3ItljohvqZ+k5JNEP3tsclTz0sNGtPcqeEin0M5/JOYKbAyITcJwk7Mbb4nAANmThVU1WZzHhrU/ijsnu8wweovWDJBKWGGoKQ8JmTQ7fdbIG2xBc9QbFsuEBisohpuX5e11ijJE7pTZMcen2x3sTzDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrR0LLK+qEQ0MLFuqjB9tw8/5G/mvp4XZ7i7q3spcIk=;
 b=hXo4szFoyGvJKINS7KqWYk/RcOeq//INvROtGXcibgC3VFLs8FVRsviy+58FWEUH3h/eGsg+L+O2ejU98ReJm6dSRBo4AV9Ejpbbzvrc9PGz+j4y4IDz0inybYIOQhDWRATxv8+50iK87lLAUHKPDK8vlT7dWrdfPmSLoaWau7I=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM4PR10MB6814.namprd10.prod.outlook.com (2603:10b6:8:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 02:32:06 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 02:32:06 +0000
To:     wangzhu <wangzhu9@huawei.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        <kartilak@cisco.com>, <sebaddel@cisco.com>, <jejb@linux.ibm.com>,
        <nmusini@cisco.com>, <bvanassche@acm.org>,
        <dan.carpenter@linaro.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] scsi: snic: fix double free in snic_tgt_create()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1pm3b26pe.fsf@ca-mkp.ca.oracle.com>
References: <20230819083941.164365-1-wangzhu9@huawei.com>
        <yq1ttsn3mnz.fsf@ca-mkp.ca.oracle.com>
        <54e80365-21c4-47ed-8b38-8cead6271163@huawei.com>
Date:   Thu, 24 Aug 2023 22:32:04 -0400
In-Reply-To: <54e80365-21c4-47ed-8b38-8cead6271163@huawei.com> (wangzhu's
        message of "Fri, 25 Aug 2023 10:09:08 +0800")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR18CA0035.namprd18.prod.outlook.com
 (2603:10b6:5:15b::48) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM4PR10MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c078762-41d2-4b48-de75-08dba5137975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gVi8486cdy6a8udlDjmgoGKrtakzunpw1unnUVAN3wHChk/ata8XbdcD6P7R5nkl3evXp68kjjUBEPIbj5kl6jUjLLdBAwjJ1SIOWQ8QKZsCx3dwcYe4ktGljDKWoavFmWbptaIP7RrN85OBc1uEewdwICoJgO5NhHXmrAZG5LqdWzPRhL+zQ+aJHILZNbwiCAHurox6Pn5lUUecLFLEEcyb6sETvMKZePIs3J7TQvZXHOPuxkP1Ick4sNJiTJE4RLF/ptl/Lf4YwKHC6AGSdTKCR9dQcQMECNcLMyrozH5cQv78rmD+YOcVng+d/L7Jw9spS1y2gb1esLRWFpW2TcK+pRWIUdngNfmbPQMn2x+mpVK/cz7T5UpObXQoAfVWrcla5aPRJpfksMxUyiIchJYEHR26YPdYOkbatUMRp4+OYGFC8LXAnccQLK0PAe9wWx0o8JKtNy0e2tUL7fFJTANoHzwGfniBuTRE/DvX4EkQG3YnR7Wgiz1yRt4vXrAniB1TWRnnSjfzpT/nJXWzLrVSjnfYlALtW7HeewD39K7r4Yfu0FbM7rYEeFkqHmSN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199024)(186009)(1800799009)(54906003)(66946007)(66556008)(66476007)(316002)(6916009)(478600001)(26005)(38100700002)(41300700001)(36916002)(86362001)(6486002)(6512007)(2906002)(6506007)(8936002)(8676002)(4326008)(558084003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jdpcg76bQPhInSM/bCvg/c3Zp1nmihCSXakv0ox9W+/Y9quqsFbYtobYTnN1?=
 =?us-ascii?Q?lwd9xnHtslSC3IW8oHn/EJHnfsYZ3AHZD9VN4504u8HbBeLkGRT0AR0mIYFI?=
 =?us-ascii?Q?iz4UZJFbdxSqfM4k0hZqjhEpVd2roDhM+J4X9YIC1OA+PLOk7W4WwykYFN4Y?=
 =?us-ascii?Q?DbRgLWsZMHCRamY+rh/A2ReJWmlNGmkFKT4AkkWViguNnkFF0F0atdWrQY+7?=
 =?us-ascii?Q?/EkU1Fwbs1rzSqxN/LsSj3V/VV5au7cAwAxuZWo+vCJbF6lUhcDIFQhX7URo?=
 =?us-ascii?Q?TgzKDuoqTA+XZWCKkQClaE2d6XvMiHJhL31Eda9DCmHWUvWPdr6ZkO4TB3Kb?=
 =?us-ascii?Q?9SZWnuXc/j9vQfr2l/cKxyvPYDvg1Bm3viXZn9qZnVSF2v5/XOYc6qqRUp0g?=
 =?us-ascii?Q?wP9hzwxUk/B/eezM46dTSn3AjO4Xvr008GJP8DPOEqgGGSdme+LLgNDytW3w?=
 =?us-ascii?Q?Sb9hExiSO1kJl+eLuZBJ62F5NAfKl1Onv1tajbHd9MkTD8WHeC9HFNjZcfwu?=
 =?us-ascii?Q?j7430EgWEhb1qrv0uJkM5JXf8HGMPXk/bfBL5Az801TvqN2wqvu3fbymY7xh?=
 =?us-ascii?Q?eHD4iL6stAK1rWaGxkhgNkZr20TCxnNs0nm/29u+KdpbEFwE9lcb+gCBaoOf?=
 =?us-ascii?Q?kekMuopq4yxJqw9K9P1jS818sZfKv6I5pefzkdsZOYACdE99fG4sWyUkDXsN?=
 =?us-ascii?Q?wBHu12Jl4HO/9IzzDmwPryVjKIEV9R41PnIIFH9aU3iRdqkmNOo6bzlFwUb6?=
 =?us-ascii?Q?QgfYF7pQH4TjBSzBCCt9lF4UvnFAkmY92gx/jRnbhzG8EGRBFyXYPu9dVKSJ?=
 =?us-ascii?Q?hKLs/UlevowIuKi9XQtTozPuzifWx+OBFi4zD2//awZJPVoPQakddk+6Jj9u?=
 =?us-ascii?Q?NYPHPS0dS0WnHkl190EtgHX8z6/+fL6u7puffquiqdBwlFe5+yg2uB20qz+3?=
 =?us-ascii?Q?M3EMqEGxLNAb2opj96xIz9ngs7LcPWXr3/Cv2PpclIXGvKFz7gVF+I+vHM8s?=
 =?us-ascii?Q?YeYruGGXcuDetKxHXGB6F/LiE6nshVT6V8Z8r9ahFQZl2OiMYZXu22e8zlP4?=
 =?us-ascii?Q?sRzpKPg94x8ZKGrv6bs4Q1zfp+IsUCDh3F4je/1XAwCyXO1FJVk4T7yWgv1c?=
 =?us-ascii?Q?rB0fW/0DNdu851rAvUoJ5b6WT/K1SNh3RN6I3MMyjq2HzrvCGp5gh4tHYQE5?=
 =?us-ascii?Q?S+1Z5ntszPFcfaPMrooox0nNx5oXJU0X2NWorL+JTdVf5Uvpk5kR+AoVW+8T?=
 =?us-ascii?Q?Qr1UX5ubhtRPTZHRHfMHbGUuAGFFJgfsa7ZS4MuIupRnwLCVcvVBkFKaPKTh?=
 =?us-ascii?Q?bzqrleQI0VFAdbQ4Qf5JBVdbRtnrhj08RjWIjq7rqg7v3Y+3gT85z1vAh+qJ?=
 =?us-ascii?Q?4iJjToQgjLsNLPMLvlrWOC8CkkB/FKXNhIQ9zR7GuPixkFPldj1wP8HPykj5?=
 =?us-ascii?Q?bw3ODZnOUgicBj0LlbvvmnSP38lyk8H5rNSK+WZQ7rKK1pLMwh/RP0cvvyFz?=
 =?us-ascii?Q?QQAhdULHfauXJw3DNtGDwcwgdICpDsGSYwnVwdYqZtrW4KMf7IyxOxv1gAqA?=
 =?us-ascii?Q?vgK5+EkhwthVDhyZiWfTZQO9Q99kklXXYIy7dOziIup2S8iKlIwVXl1OrlYk?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RXkKp4jkf3BtfsISiYCnMaHLrtx45NXfaXR4C2rRETLAaYkaIVZJfo3LFRQ7trmSl5U286U98RIcgv2r6L6LFu0HG9Z6IGwmIKAK/Ln/RoT5B+Puboi4iQFpLRMuU2Dnx8Ny57GF1I/8dWuRc2Qw6BoJxh/ynzY+PjZb9NeiDVIRAzhQYamO+5ujXDABkHzVZnkuKzA+qFPpzhN4d7XwDUk9KdeUtjrcrSDPsiFicFJqEZ/JClNjE/tQQTHh0GI29IVWo+SYxMRxn3oCfc1lwjJ202x3XwieXsgkSfJZy72fC2fmjlbg0RY9TLYEvfNDMGlqarn4nlzge+ZDs8GA1vpGcOTyuGyIB0XTBAT3okR+vNY8ov74YraFj8h4lJ0eH7/cIs5GF7mT9NAXAMMnf4Kd5bbinK1Fe91fP9Ne0t61/X/Kkvoe7mtqGBW8CLY1EVrhQza4j+Kx7ovoowoYYHMnKYVz7rl0Zpcvwc8Ma7gotQbTdTaNMV9MU2YCxcg/xA8c7lS2hQn7PwKNx558RLAZ8VTJaH67yhBX4O4qFkavVvNIvOX5GSW8/MvxQdMImyVULUnEoKMWvCRLamb7CJtJ8ctrQOr9LTZLkOeioayAFd25FEDPszzKncy4ujdFC0QyfNpHu16ofGdobzQL5IPER8LKe3tO96VpIn2gPDXeTTcpvdJz7aAmZl7Qepais96+iXMtRkU16F1mjxBBP4wgcEDlVP5NNF/HEQvGjXt4mgMuCWm+f49u91xO3Rul622BOKwiJrFTfkLs0fbddoSPHWSFQ1Vlgyl2C486X590YngaR6M1CGHahWm6/f3kqcUtjw/jCTTpXpF0CrT2BY66F2G0HY508sWtg2ZxLp01ALwn+68rB/72FU6/kffGyVytPF0QwbWTsjssCGm38g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c078762-41d2-4b48-de75-08dba5137975
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 02:32:06.5108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpPvnjSDtHnm3vBof1Rapt9tkZFuCQr8DnCiPTvNSMEzgUUV2UoeL/kzinqGUeCqkS9LtdxWCNe2+HB0QxOykZxDWmBwyf6jmG6S6CNW29k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_01,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=714 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250017
X-Proofpoint-GUID: ta9p8PeOn5ni0SjsoWEHXcfhkHvTh1u7
X-Proofpoint-ORIG-GUID: ta9p8PeOn5ni0SjsoWEHXcfhkHvTh1u7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> put_device(&tgt->dev) will call snic_tgt_dev_release() in which
> kfree(tgt) is called, so tgt is freed twice

OK, I get it. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
