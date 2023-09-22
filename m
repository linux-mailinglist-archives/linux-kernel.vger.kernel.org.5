Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E267AB897
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbjIVRzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbjIVRy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:54:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CD41999
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:52:47 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MGNuDO002260;
        Fri, 22 Sep 2023 17:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=lwYSyjcB9OnV1gHVtelxTv4rSvzQzMhKSeA4r+yzYZo=;
 b=P6oSmkx4u2i9kdg9bsZx7eq3it+r49oE3wkEXShfk7viagj6kKrWctZsaZnDmwltnGjV
 yDCauw7L8k1MXP4HyHICnRTY+gCL+7rjs94scuDgeHrVaQefw3kGllNPlpDK0SS55zZp
 2VAha10LyQv13fK7D6yTy5eEQVdwEYu08HGbnUi+QuZG3FhDup9ZomDI67BFMUV4qlUh
 waPQqYCBmvckhTX0aJITzH54sWjJ2Rgm1n5ANZlXHuGQPDuR0uaaw37VEl3BwfTOzdKu
 PwHdP/IhRJTxGBO+Lz4aG0m+77iQFXzsjZ58Xx5YFuomnA96yvln0BfxS0xgGIrS8u3H Jg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tt02das-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 17:52:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38MH0lgJ010166;
        Fri, 22 Sep 2023 17:52:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t8u1actbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 17:52:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+Rkq1uhJpV8cmi31fEYA2zkdB5nJuYwq7h47972Ipr+4HHr7SoJ419V+rIvso2oCtH8BHQ6oOd+xG3tJ7JK+WoNSYopzb/Gl93RHQNTnaxrq4+p/jNsLK/mVbnDlaGIVlih+ZWaeTZJ6BN1wJzRZsQu3qUfzb+qZAZ+Lgk2w7PWp0fn9NLzUoE+XMam4iBUouc8AyrTAONIVDeDRJhlwgiWo542FR4wuIcm2dVf3GhMOYg+cdm+agjyLJw2NpdkVDw6ZcPgHQmeh1wPq8klgl3zphTOrYmnsatYbCwfLrTfoziEuNi7wAqMWL28j5No2LhRR/s02usqESubUszT/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwYSyjcB9OnV1gHVtelxTv4rSvzQzMhKSeA4r+yzYZo=;
 b=Ea6awuxe/HdMWQkYbJhpGsVrOV0msSD6Vs3Gwjw6QFJF60E3NOo5IptljBo56yzXvbeXnXyp4YCzt+uF/Vv0SagPI4CE9tR8GCpw39A+Ed5swG6AKC8x7PPo/94kNfn69UVYaTXANi0WAMxOrgSbYBqYD6OcdGa24EhiJ/dIkzA0MyZD9fOlGi5CfnBNQWaVHXtx1chJs/AG35fmoex4qlWOZn9q0wsMCXyedAIr07pIK1KdxEUwMsYaLMVisSEVfF+yTCjlKm6oV3Dom3nLJeG1XOwKXGP118FSYzKVU7mVdflkURfxkdHS4TAIlDM2bW2FVBFQqynOP8P5uwBcgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwYSyjcB9OnV1gHVtelxTv4rSvzQzMhKSeA4r+yzYZo=;
 b=TwK6tFiCnj0RmVMUa2tH+j5pKfPz1qZfSZZZYk74gcRRWlUNDxTJHuxyFiqjaKtWeY6snTSso5uJfTkHcKbnwX9jF1SyjYXEdcdntQcvMIUn/U36Q36poraPBWh+lfAizEDhLOwKRz/+r0P6cfR69EcFMKVo+qG1GndHgQfz8G4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB4352.namprd10.prod.outlook.com (2603:10b6:208:1de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 17:52:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 17:52:35 +0000
Date:   Fri, 22 Sep 2023 13:52:32 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: maple tree change made it possible for VMA iteration to see same
 VMA twice due to late vma_merge() failure
Message-ID: <20230922175232.gneuhwhzs4moql5u@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com>
 <20230816161758.avedpxvqpwngzmut@revolver>
 <CAG48ez3mcH-ms0piv7iMcB_ap+WDgkE_ex6VHSZw_Aw30-Ox8g@mail.gmail.com>
 <20230816191851.wo2xhthmfq7uzoc3@revolver>
 <20230922161919.6ct5c7tj35r4ex7m@revolver>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922161919.6ct5c7tj35r4ex7m@revolver>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0217.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MN2PR10MB4352:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a780757-8dcc-4c9c-614b-08dbbb94b3e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUDgtnLhsTt76HKqWU/Y8Nx1SBnTGHIuM6i5EjnshLmHX7/qrq83HwlNn3igipCeTyPhTU3oKkbbr5vN0ybg3uGwi48BSXV5zjbvYfm3b/+fAZZKo2XbJQoRiYPiM+caE7HvIclYNxD7tfiy1ccP6lF2EhPyd4WHWHElaapW5gGsEPnMW3m91W7CIY7DdQE8rNjygmFFWo/rbItiwoWHtWqAcYPOXPT4Dx/EyDH8YW8VXT3/N0M+LtlTDRYS9uSF2+bJYMmpRwSb6v25BjSSMxoZ1YoDQ+neRtUkcLdgHIGliJ+woD44mQk9zrTGBPSlZaaD0fiG4NkUPjmu94+sH9kLACPwhGb2m3KZOBxuPVOK4CGHKWOz+Zm/Uyy38AZ6L8A9+KfkcKAEoQ0eqEHCrs5IQthOs/7VX3jVQLtduTjK/7JeK1b+Qwf2Ud2bf78sUfTGLscgC6YuX/GRUmdyKGh78lm+F5EYDfr0Om/qSuOCFoJDFRGGdh4dJrlAaNFAavUrVDYAEEAGI2TRoVsEX5ajmNiDmGw+U1U+0l36/NVchXJE1LNWP2+2yV1sIHUC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(366004)(136003)(39860400002)(396003)(186009)(451199024)(1800799009)(478600001)(6506007)(26005)(6666004)(6486002)(38100700002)(83380400001)(1076003)(6512007)(9686003)(66946007)(66556008)(66476007)(110136005)(316002)(5660300002)(2906002)(33716001)(86362001)(41300700001)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2KK3VXwyOc8FEs+5PSz30uqGT/4HlAi3hUntJTT2Gss/m97tZMg2mZnXvaoR?=
 =?us-ascii?Q?5y1WiEEPQPvLKar7jw0w+D4r2Fmpf5x9loCSbBAG5GVEy3Q9F07t2iiM8KoZ?=
 =?us-ascii?Q?Hy08iesBs/oVKfyzmAFSOKyKUyFkXZc2ovHGHrMz4P9o3L+pMZbfGBgWASTR?=
 =?us-ascii?Q?zc7N+t6sePdQpZgc8/dkbGKZQ3FRaJChA2iJlmRCSkIipH76pwgOiVeDELJx?=
 =?us-ascii?Q?z0eVXfJiGWD+lzhDSCItV6S0/7QkYXUkxEGDXlIjMxvJ1K0ohs4qiG9fUww8?=
 =?us-ascii?Q?oFSlSvgsYGNgu3AygfoVepMgZYUALTqjjTCI8wuKNKbZ60cu7YUm26WwPQ0o?=
 =?us-ascii?Q?X6Rl629MeC5fURKyw7b1rqmVksazpQhJgVyWVxeMKmX5WwXgj5QEWt6uuBVr?=
 =?us-ascii?Q?xKiqUNWbjX/2L/tfEtn4jnI2Z2PcRYNR9kScTGvOvbW6u0CUEX6fJ+QxHuQB?=
 =?us-ascii?Q?XlT31gkqFzxH/7nF+YuC2RZuNms27UZBVrJLdXbM0IP3vTpYDGPu6oCcy9Xz?=
 =?us-ascii?Q?ePTgS+AxQh3cW6tTrq4nBuyQBpq6JYaYxu8lCgcLxonCl7jSXqHYdXuhSx1A?=
 =?us-ascii?Q?RhNzVK6yt5EKkoHYAGypjAxc0YWnGB0i1FTG1gJdo/uTWI/y1IPS2LKM1223?=
 =?us-ascii?Q?8337vcBguwopIYZsg0jDuxKg14Ba5dQXEAuTLNqYv2nPv3sxHkEq+o93bEym?=
 =?us-ascii?Q?+1tXgYYishvX3Wh15wx5PqDnoog4vyCfy+lGHcavzjTxWG4XX1diZiYzhwng?=
 =?us-ascii?Q?drwXtiogPK/dHj3QA99cA62XqYpU0+x/aR+es2VaNiAH2Kma3UG2Hsw47VUM?=
 =?us-ascii?Q?J5lDlPblEFW/Sfv38dIFddCnhxUaqVwdEX59NTlmOmI3seY3yYDvM6gdGNOL?=
 =?us-ascii?Q?fwKMhgOOOIfpGkwk4tiynBQc+1jXz7IFXXU3D1Gl65oUJvHxkl2sQo896k3f?=
 =?us-ascii?Q?MzWvxUtn63p6xawbnJrtrBpCo4BS1XgWGOlnGsYe3m2GZZY9SUIN/f7iR1S7?=
 =?us-ascii?Q?JlZRujYKu9ZPepFbLxhW3boV1jCcPBsHQlVJ3TOggTnxuH87naDAdnTm2wE7?=
 =?us-ascii?Q?1A+RcvuT8ye70zyC9ySF4AJqIMZFXJSFCJWhxOQnUiqwUwSrcMQLH4uz3VTA?=
 =?us-ascii?Q?jdF80PboYL2Rr67BITOs5RK1zzuMLNnSSnj2yNGXv9bKTd097tgCyxoi1GqQ?=
 =?us-ascii?Q?cQwRuSC3hGiqeGDENJQgVBotkHzgmRBn96xBj6p/6EgSA7aHow/fMQFrZSlx?=
 =?us-ascii?Q?4RUrPGPhYWYOkIn5KGj+8QUCQ9jfoFIqfEqEDV357NNXSIKFGppVSSBSyV05?=
 =?us-ascii?Q?qsYBGN5iFchQkAoBahOjf5EY81dZCvxhBotpQJETq/vZnq5WtsZOz50Xt85p?=
 =?us-ascii?Q?1qzKvXfokRMkcxWcyNlRd4PEXF7CGZJh5aXAihsFkf5VjjmnnxxBMLOAT6Tg?=
 =?us-ascii?Q?bQfYIkBEToU9497ETj21G+H6nMjbHptfnbUu76r7XUI7BYq7+pCSmc4zwBxz?=
 =?us-ascii?Q?KFsK8P6RKMx6nNHYhAg4UbGlSOJYUV/uVAkt0L7owzKW0c86PwGox0HKKHxv?=
 =?us-ascii?Q?DXmc20yf8SS7YIxu850ImX96ZFE//V6W0F0U1pyMjQWhorBEiXEUT31vUhuV?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J87nNkKsWKReZAZSvKYVO3h5UQ2mjwDLL7ZU28L6vKlGiRObTcCGRp7SzD5PC4+nSYNI4YtgzsVBMzCzlDShmagMBROEv1SxtkKYSq2f9zV89VLzU0FFJbKXp8FbcxXEfYMbosBGSLxGI0mrwhM1Efak7DCQ0NRUss7igVZUdzHr+cGPhsXdiRKYS/9LFQ68TCOJQcWrHm4EZ+N9iLnGjXrGFMNUA9B0xhGvnqj/0dFEs/uDeQak+H9KNPrWtJynT/YR56+hwBuHwjCklDGPfSI81nK8OB0Zwwg6nGrPlLt7G+ueGSZ6zQpDFyTelcMfML4+56r+dLhxJ+S59OuJeMsUfM+x7r7KCvY3ebNBt/PiUQKGA0rl5CV+Fke83INsjxpSP4phowk/rc22jDsOPGITp8t35ZmXcpdUtMrVsNvsNFDBvfKn/H8/GiW73suF8QwLqrR5BMLDFzlMz/6NjeFMCDuDIKpfh6UmicPqjE+0Y2G6kgongo+7Bl/VUSZNU5XxcwIAGphdJV2Y2sZse5Q9evKGV5/HsVVpSGJcU3+HBFzCNuTRy64hVv5qkJZwUeDmM46mRpNrK2VE/kAjXTPuQmw+1p+4PdbRHnFETbq5yCB/ac30qyL+BIoyh20uSr7fXPBxah3M+r/Gdof/u6284KAE5e6/0CfWEhRlxOHNKsKEIeXTDYSGXr1iJ4Y2lA2JOoFHNTALtpE9cFWIUWIV6gjDiEP+bggqaW6NPTFFbV5dumMjl+jw0/dz3vJ0SZOlMJ0AKBo0/heQuCPHl8shJjWqkwDY2UtljP0r17Xm4CQ1/t6puNRVFoB6ZOiHFJFugF8SgGsbbRj5keU7zcD6xZGd5bKrmNlQ5BmzUB9i+gR2CgM+P9ZJGzY5P6wO9865KWK4T5/3i8gDUg6d7IW/WOuQA+0RF7n9CGQDQaE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a780757-8dcc-4c9c-614b-08dbbb94b3e1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 17:52:35.1701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Q85FvTNsRQgw67WAeiQiJh4xvLmVA9HcTbhUhnk6I6S+zSaWmwqapClCn1XJNa5qmpOAFQXiXeiamsOB287iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4352
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_16,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=560 phishscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220153
X-Proofpoint-GUID: alKOHHyXWgAe2tidZc6Amfc7EvU7WfCX
X-Proofpoint-ORIG-GUID: alKOHHyXWgAe2tidZc6Amfc7EvU7WfCX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...
> 
> Looking at this, I think it's best to make a label and undo the
> vma_prev() with a vma_next() - at least for now.
> 
> I'm also reading this for the error path on dup_anon_vma() failure, and
> it appears to also have an issue which I'd like to point out here before
> I send the fix for the first issue.
> 
> -----------
>                 vma_start_write(next);                                                                                  
>                 remove = next;                          /* case 1 */                                                    
>                 vma_end = next->vm_end;                                                                                 
>                 err = dup_anon_vma(prev, next);                                                                         
>                 if (curr) {                             /* case 6 */                                                    
>                         vma_start_write(curr);                                                                          
>                         remove = curr;                                                                                  
>                         remove2 = next;                                                                                 
>                         if (!next->anon_vma)                                                                            
>                                 err = dup_anon_vma(prev, curr);  
> -----------
> 
> Since dup_anon_vma() can fail, I think here in case 6 we could overwrite
> the failure.
> 
> That is, we will fail to clone the anon vma and mask the failure if we
> are running case 6 with an anon in next.  Once the first dup_anon_vma()
> returns error, the next call to clone curr vma may return 0 if there is
> no anon vma (this, I think _must_ be the case). Then we are in a
> situation where we will be removing next and expanding prev over curr
> and next, but have not dup'ed the anon vma from next.
> 

I think I am incorrect in the error being overwritten because we won't
call dup_anon_vma(prev, curr) if the source of the previous call (next)
has an anon vma.

Thanks,
Liam
