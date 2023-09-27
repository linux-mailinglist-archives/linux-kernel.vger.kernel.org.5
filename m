Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188927B09B0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjI0QLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjI0QLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:11:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EECC92
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:11:29 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RFsnr3010681;
        Wed, 27 Sep 2023 16:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=LgmYXPJwq8HCDhAcCWhVyynxAeSxo+9cJBy9UFsKdTc=;
 b=ln+nJIyVR360zDXCFP0YA7hgxISu3UVN/mjcr6yqjJHeEuK1Aj1FBwcR3/Q42+wDjrS+
 cRVxYL4804W2qY+6SLIUOlTX6ZFvJ1JmLTipDZUjHPVSeYwJ6To9YCQ/74tcMeQAnfym
 11NM7LhOSvBMbaWrx6wasAIVPoWJbMWDauYM1gC+ilkYv3fJ+ByWlt/QFXSfIf8jvE1E
 i9xzY1ZNSvuJQC06CpLWSKJu2BYjzQ1TgLDFO0OQ3vFd1O30/SizW4ef4oRSkZiIS4Yn
 8w7BJWR9nhymO2YPLobO05UU0ln9IrSEoP5XsWwrT/TbXYdwfl/59Oq8t5uGvwbGtiH2 JA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pm2a1v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 16:11:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RG4h0Z034933;
        Wed, 27 Sep 2023 16:10:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf8ejqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 16:10:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7WW6g6cBNTtEhEzzPf1EdTkDPqqtw+PqtP0lIUhypGNJNstjtyzBV1A90Zx4wYH+Zgv2tUo9WIwuEc8IATilYYPZzbhAt3BL/DgPWTRiwFKn8lardaIYZNf4eMxa9Io9anzv5auyEfjUlxkCrOWvX/5YsqB1Ris4/6laC9JdoRU4MJx5bkv8z1HmyFXboIqO+b353OZAt/E2cRGZvmta0oVGN/FtsQQV6KJ1grdE/TGMMVQTLjhcD8EY3dXntyyKytjeJH2ctNdZJ7MVxv8+83I0vnvqlQYjRDMVULwYbDxZvae8KhSSsibsGx5J/axv2UaHTNRTDzNOKcpy7/+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgmYXPJwq8HCDhAcCWhVyynxAeSxo+9cJBy9UFsKdTc=;
 b=mpVtVWgOBrVD5RJTm5la0MB9dELW9ljSNCxw+SRplJbrrC580jM5amqBLM093XX4Aj3U7g3GWye6C6Bf4KPRSk6o4TI7Af7zaRsTJxyrgOCvdNw71nEDJVuOhJDATha9OKzmZHaQ8vCdbApE0HbKhWJ8nxApngIJcLsi4JvrYbPD3IkH9eALVHjhbu+dYcEvjaWeIAy2cWYlz6ou+smIfIuM0/lq97rH59Vf6if1WBzpF962bwCN+UYgE5h8Fe6qdWiBetcc/Cwu94MpPHUcVIx3ga8TmDXP7LF8sZdWq1SN34Mj3Kbf6Sq4v65SkuDqfPmnAnJ5qdgB4XpxlJYJRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgmYXPJwq8HCDhAcCWhVyynxAeSxo+9cJBy9UFsKdTc=;
 b=fehqn68DTx0HAIx8a84pBePBneXgE1L5O7tGK+FT8HtrxJxGdXSdQwOfnk0HTNazWrLucJptMZCtkY88aEh+hF8BvlkGtYLSQtpJB3umSnqZHRjuWggDSjwSkqWzFPHMZmwLgqLAPn5REKvJFqbuvmDbNc03pGtaoiKWZwoTlek=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6122.namprd10.prod.outlook.com (2603:10b6:208:3aa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 27 Sep
 2023 16:10:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 16:10:47 +0000
Date:   Wed, 27 Sep 2023 12:10:43 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 0/3] Fixes for vma_merge() error path
Message-ID: <20230927161043.qujkerubdgivmvyo@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20230927160443.1927534-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927160443.1927534-1-Liam.Howlett@oracle.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0397.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::16) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: ecbd9e82-4f54-4ec2-18b6-08dbbf744f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3pzplfXlBfhDGGADON9FEO0PzsDGBwbl0ZEdCKCQJCz93EKPqotmabzmSwdsgD+zhkG5LtMFGLsn58BRq76045qp2o0ykKMSQI4zm/CVe+ml//AqLJRtBNM2lIl2amjgFbgGwBrtzwA1wx6bVl90pAaB9SM5xMhnDXDpwifY2/QHhrnbKUuNcPKqxRZdWQNoxJUvd+b9JIDqL+5c9zNjw4SVyw4XfrlTqUu8LzNNy/zflCfXduxtF4HZr0EgKVcLmx7BRc0cNNr3ZaH20F7+BIMwtte4IxR2rXj5CA+L0sOiBynu5eTJOBxjysIjZrCT2cJ8CBkv58xvpUqfQ9tHA5YUwJHYHJDN8neV2ZjcX3fHrW4hjB8RP7/KMgF8qJKzK+q33crjjnvTcEBc+IEWCUi0w+63FjB5wG5xRK/kFCSFZIMqboGp8X4vghCWXHIX9U7waw0/wqnJvwjD55Co6NPHPTPbORUiRjsUHsUJ46Gs0AKD6u9pBfBxFGP9TtBBtUVs/7t2+tast9Rr1KJfdI/Gm2ZHKBfu+DP4caNfso+XvE887iRJ5bB9eGSA6gY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(1800799009)(451199024)(186009)(66946007)(66556008)(66476007)(38100700002)(6916009)(54906003)(478600001)(558084003)(86362001)(2906002)(316002)(6666004)(33716001)(3716004)(5660300002)(8936002)(4326008)(26005)(8676002)(1076003)(41300700001)(9686003)(6512007)(6506007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KtAq7vY2DO2DdAyTgLzxi8tG2ceo3xhMM/WUyPgFSx8hR5Oa8NgKhT7bKW3k?=
 =?us-ascii?Q?qYCci8xNu5fPK/bt1UvunRxbTipyB1sa0phF2Z1BU1oL17XuwSQDqg2XRzP4?=
 =?us-ascii?Q?6y1pql9IMJhpn78T3htokURoDxtF9UDPDBV/Qqx/1Fj1u3chozpGZ12QvD/K?=
 =?us-ascii?Q?SOu/qavaWyv9lOJYDRQo4RnoHYRx7tZ5WIyWS2+ODkuepZ1KL9WYRdSMaM4H?=
 =?us-ascii?Q?Kfg3tL4OVx51bFY/hv3RGXJdcBiw1+YBToFbjE+yC9xIXKmkIhoz7030Ok/g?=
 =?us-ascii?Q?VsNQWurxxTN8BfMB4vIm1LqoWgJqe7NqQoTf3wh0HP2glpK/+IuIFggX1e8y?=
 =?us-ascii?Q?EhBBVVDHwJY4XUaYRkEhY0UVRvaKaE4x4A4wSB0JG9jVWa4QwiJIcvwFswLk?=
 =?us-ascii?Q?7RxHlIIZK/3MVMU9yQAnpoDwsLXwEiEzkFWYb3eM2i8CA6nEIoBPcF/XLlnV?=
 =?us-ascii?Q?p7o0oFlJ7LR4kihTttzwkePibarpLW1hVB07XCmcxnns4JMtir79UaaZSbPv?=
 =?us-ascii?Q?gbdkPyFgAB0ldK4U0yn4JJTGa6yF1WursnquTSrc/2zTMayoY0oeu8oGuULS?=
 =?us-ascii?Q?6PkO65E1ixRYhfIYQm9H9Uo9LXAqiXDTjSH35+1yInFq/CkrZghLkEn52zxY?=
 =?us-ascii?Q?ay50NV/1cbKmSX2+CjdYh/FsnVM9Pc9sxLkve4fiia1y07NSwaqU5xH9aeN3?=
 =?us-ascii?Q?klw1d9aslRUfdNiWA6jH2g7y4kAr4MGzwYDZ+swCjXV9QjkYjySP7R+SlJCx?=
 =?us-ascii?Q?WjjqmspGo7+AdHlJa7qceqn+5cDFoK9wMGFndTmIpJRVlUwHH0Y/8VvI9Kl2?=
 =?us-ascii?Q?4YjI+lVXu3f8nSLwXw7KOlIBZC/ix9f0++LuvWx/pphQV7a1BQICtaAslDwe?=
 =?us-ascii?Q?F6ZMX1eZfXinzjdPXU6kq4o+JCRQ60WsqBakxbj4NRIhtg6hkAeNmX2W4e4d?=
 =?us-ascii?Q?Z2n6WhZ7TQ7e7C1PrI//bewoPHAIsVx7wU2s4P4SGMCCHec5A+LeW80gWHfo?=
 =?us-ascii?Q?3bNbR7e3JUy8Yu9zRKR8Uh21bIoWca6oEu9J2dIk1OOcw9LKJNy8pw4vw8s9?=
 =?us-ascii?Q?zIvlYAN4zv/+qbAWLiE4Q9O9DLnbPbXyFc53XMRetFuzPh1emnqUZCuXWVoR?=
 =?us-ascii?Q?NObQWRYhMwFqwwx1tuZFpoG07aCkAcadop9TQaiAllH4/VQwum5GkPldpDWB?=
 =?us-ascii?Q?6wIPm6d+ntXD2IH/50iT4y0XF3y0xtjyyMNTYaHMv70Gq72g6cXIyLOi9A5l?=
 =?us-ascii?Q?4PxCawWy6iGcrRcuQ7iq5ehd6S61Ojn+VPkF3KfNTGIbIaRxATCDZ03w8mzq?=
 =?us-ascii?Q?ARbJEXsZihfCjyK5NmD0fQPmfyNWHK6ikZGpYz1nV9ELumvlLDjSnZxWP21y?=
 =?us-ascii?Q?aU/pUBoy+5dTll1XPdXtsX078CKHS81E3ZAsAVVtGb5YJ70GozauF0SfjKgj?=
 =?us-ascii?Q?hS46Nxik4O+OkWHfkwQpt2gBVAwO64w2TeHGzeJrt4fUFsM1iLEoAkzxCM8h?=
 =?us-ascii?Q?N+yvD+GrwdG4BZWnSzdg4/SDhy2vVnEdgu1gwF2FNWNCsIgKh2eRIaiREh6R?=
 =?us-ascii?Q?/zxLOb73wWFARHbdyWBHHdDsddmPPn4kTVMbdXqc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?eo8O839pGEcDM3hHfrAvP8RVW/+AfDhKO96Z6yqN0vVY0B0jid638H+QnCvk?=
 =?us-ascii?Q?4mqkit7EVI63VRpU1Uqi+Oj80oCoPO9eGV+sw6DkLl3nP1wiFaFTL/PhPqTv?=
 =?us-ascii?Q?m+uFyEjk/bRdENlwQnP8oKtuzU9okE2HVbUV/TDEQ+xdxeJJf1+2mueUlL4F?=
 =?us-ascii?Q?AOq0E+9mrB6XNpQM2/sTIfmUPCr46W+aApLBmflw7ii0nu7gDwnGiGhi3heP?=
 =?us-ascii?Q?sYnq+zYjGvf43A/Mifvb9KUf0pXOaP8MDP3rMmjBF/c/uuKuOZYwdb4NsiPl?=
 =?us-ascii?Q?wZ5tqFTCe+QcT2OkcsGuxr175bt6amb1jq4//mOWnkakLUjlncGyafQF8Dmx?=
 =?us-ascii?Q?jSK2CuLnk8/qXoNI3CQv+aa4xZrOxKS3AeqM5O9OqdGZeceCDG31O7ZJyZrM?=
 =?us-ascii?Q?bYbTfOpAsEiPG6/m0jbrFmldqcV8RgB2rAbY+CRz+Iev6WaWAqS0rmqDHyys?=
 =?us-ascii?Q?wHSlozq8e9VcQkZOBC+HlmbdkjT/LgTe+Edc/gBGeFTTdbvh0+qTnOs+5qVK?=
 =?us-ascii?Q?Rzjy8HknSd0fbkVCr2vdhR/ROTl5NcheawBNGXRowfxg2aJNJCGKa9dMUD13?=
 =?us-ascii?Q?svek3E9kUFg17KK2xp881ZQWrRKfzfIXVuJ9uF3yFjSwZTO+njcpOhSKXPy3?=
 =?us-ascii?Q?pwy36OgFcBnpkfOOnLbXJ6GzfEDofhFS2HfdE2DTP+4/JFYh5eheHBQ/EOf8?=
 =?us-ascii?Q?LPtA7OWQFnG4SJWvK08DJR05aeOzBHDlmkUFCJTJhVHTbtNVVwqZutcJh0iB?=
 =?us-ascii?Q?x3O/u0DVVVCewHB+bPQhnZ/rvXA1KKvdrPqUXMrpNYutdWRxZrbjIOU6NER7?=
 =?us-ascii?Q?Ra1e5OMLwV++gKtGdGJmKaQMh7mXbfBvEDtuZgYrY851BFNIdrAlIvhjw3jR?=
 =?us-ascii?Q?kCPF+xgncU7oGXhhtTrlUUtlQRwj66mtuimqAzq3rNtx/f9OKUa0p6Ey73wR?=
 =?us-ascii?Q?26mQC1N1DdUm46+V4LfMqyD4kl26Es0Oh7XgxYO7WtBQlDydhbGudHmUExa8?=
 =?us-ascii?Q?sArg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbd9e82-4f54-4ec2-18b6-08dbbf744f2e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 16:10:46.9370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liWRMY6tkHwpskuYEi/JhpXQ1Pi1Gi2fa3n40yZFtmeYEq7kYvPWLErIWFXoTD6mj9GCKGxF1us0swjMqyXFKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6122
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_10,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=659 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309270137
X-Proofpoint-ORIG-GUID: xKyE5ivVZms-CSjRWWWwGmHvUnr_WZxJ
X-Proofpoint-GUID: xKyE5ivVZms-CSjRWWWwGmHvUnr_WZxJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@oracle.com> [230927 12:04]:
...

git send-email aborted after the first email.  I've sent it again.

Sorry for the noise,
Liam
