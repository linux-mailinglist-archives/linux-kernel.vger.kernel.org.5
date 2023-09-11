Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BD779C211
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbjILB7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbjILB6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:58:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E358D31D87;
        Mon, 11 Sep 2023 18:29:45 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BJvcdF011055;
        Mon, 11 Sep 2023 23:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=DCpDqsAc/hUQrjIY8z2wgv9G02YdQ9ZB5YKRlaOVRMc=;
 b=V+AgZKfETxaEWngYtlb2DcDrpj9dX6BsAVani3Y2NpqHdDb1F6Q/sd8IlKzt07zLxT/b
 oyV2OYaYW3THp7Z49ifmG3JO+7UKhkxN6MgmUfYvEDZLLLHlJkRQPnY2yvU5sR67WOfG
 WB6WNbDxIN3gN824tygLXcTaosnlWzuLyumW8eIMe9eCYRSlXcI1Ee67o6MWWT67D2h9
 K9N3cGMziChJqf9g2PAPJrNzZqLfxElvwwQwGXR+B+tYas/fPuGGLQiqd/1y4+M6NF4X
 OPHXrMAvWWbh6VdYKzJRNP/58dc4voApT+vTa4P8VTpaDp3YvvtJuQRNqEfeijT+0c22 cA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1ju1tnvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 23:54:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38BNfIM1014676;
        Mon, 11 Sep 2023 23:54:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5b7cc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 23:54:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJETijzuSafB524YvR3drYt7uNtP+1gZMBGotw5WZ4fPrRgAICeM2PWIxagFPfjtlLapGwM2XZfInliBNFy8UQuveH327Srww5TSIsMuDpmfSzBStbv8qPnyfSZVbQh6WTthbWevZTZd10MH5HTmTZldrnTT6cYMscTBIrIxoZYeLLB83fKKbJKwEzo2uCTjtvG+E/HBeW5Ge8tJ9OmOzKVxYEHI8tiD7nqYohnPOxgSyRiuJzlAvkFvcob7H6Lix2U3KRUIICkEzsq0+ohjPDre9mAWsyup9o2ew6DDdwPTeljCLlZ2LKS4cZpiXCPQpxxmnwafjTODHvu7w7ZArw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCpDqsAc/hUQrjIY8z2wgv9G02YdQ9ZB5YKRlaOVRMc=;
 b=n8fphFrU4U7LJoTYuQclTov3ytYQvKE1rJh2Gy3coz/v3AIdkeDO55kRXI/72eVRMJ2ypAgCJqU2qs+zGIbnAF90nJtmezI7/OKJZ3E8uNCKKymo/ry3yKH4oRyjy3HLh1i9wbZsBmZQUxQjjWqQ73NA1dPWpcRTjxuLEwcFiLJ6z3d0IM5fRuhVbrPaOulkQDRVns2PIF+6Hc4/wah1nGkGfE+6XESsKwCZi2etmglQqdLCgjymMWNnUqPNr1/GC1b6I2KdtT10WbAekrfwT9hy/LzQ1epl9s6u4relD/Vy8ID9GljN4ctDXB7BQYG9BIZxina+h8sNihhRwEaoGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCpDqsAc/hUQrjIY8z2wgv9G02YdQ9ZB5YKRlaOVRMc=;
 b=hHhEn874jRzEAY5AEz0Zv/W/HVsXtZatU2W+ypRmYlOtYQSnLclwjzG7mfIgkzMhzyiDujDFK+GsIZzQj+ENcCtxSoxXL74DyuB+N+AHE4dbhs03Jl8GNzTs+bJyGOE89Uryn0YNbZRoIFvgvdfcqDv1OVv36XPdZHtsnfAcAyY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH3PR10MB7761.namprd10.prod.outlook.com (2603:10b6:610:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 23:54:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 23:54:55 +0000
Date:   Mon, 11 Sep 2023 19:54:52 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
Message-ID: <20230911235452.xhtnt7ply7ayr53x@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
References: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
 <20230819004356.1454718-2-Liam.Howlett@oracle.com>
 <3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m68k.org>
 <20230906152325.dblzauybyoq5kd35@revolver>
 <ad298077-fca8-437e-b9e3-66e31424afb1@paulmck-laptop>
 <20230906172954.oq4vogeuco25zam7@revolver>
 <495849d6-1dc6-4f38-bce7-23c50df3a99f@paulmck-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <495849d6-1dc6-4f38-bce7-23c50df3a99f@paulmck-laptop>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::9) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH3PR10MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9cbba8-76d1-4cbb-c2e0-08dbb3227f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1MreZyOQ54dKUCch3e/OBBD2Y/u3EyTHyjZGwbuVqFbsu9ms/sJQHtIg1tmsQqekru8RbgNsdJBfKhkhxt+sjBu6o6Xrmk5blSkHstVOb7Gt2eMRwWz7cQ9/dvo4Sa82UZqsZJi9sK+gh6YaWcx0KKq9ZuTf6Wn7Aw6oN2Km2SMghTWR3otZj6tmrUJ04wSE/sUALP47jALMcX2Nhj+rtIpBnUCi9v4asl9sl9mCV58WPy5JhpZEIeDLnRlKm/Z9lEvs/4defzSG7mW3XjZl6I5qKiHD8RgFrJx9LwkqbJ3ZtJqwXIbPDWTeA3FpPGQkC1qwm0T1ypPcOEJn2z35xG5sKiUlmes5hh0kxvjO7S2zTx24L+8dNU4WkeSscVjHsmpeztyU/wI1XJloGYZXzKUIN1ldUgvdsDORuaYQ1n0zvrKu7bh6+NIRvkeUIJMtig3WKiXf56ZpccWfp1+iE9pOrdBOS7VDzUaFk3IEOxZegE4bZ7XTYOv0rJCtSZY1H0AD0wYr3yej9isp8CtXToFJHC7QIjg6hKo3OtBFIZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(39860400002)(396003)(136003)(366004)(186009)(1800799009)(451199024)(2906002)(38100700002)(86362001)(33716001)(41300700001)(316002)(6916009)(9686003)(6512007)(6486002)(6506007)(66556008)(66946007)(54906003)(66476007)(8676002)(4326008)(1076003)(478600001)(966005)(8936002)(6666004)(5660300002)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O6SBMW5+BCcEXAy/sTaDMS7JAei1AqHPfbU0DbkEKpPkzHUQVXDwA54jdWWc?=
 =?us-ascii?Q?9QPrOg736VhsYwgmmcm/2EHuQ/S49ytfgiTHYsdTLHqW5ivT8DKVgRcL+/oh?=
 =?us-ascii?Q?wzKs6OJ00OC2JmMvWBx9RV68O0lOjdZ4CtPIJ3BUsX3Egz79ZiX7dc6m2vBw?=
 =?us-ascii?Q?nZYRapzxY6mc4W/6qwH0pxC3tJLyQTVmRi6oAAqYhyLfn9/Lg8jAV08ITJNt?=
 =?us-ascii?Q?3DC758BrhhZKD00Ng5Ovu3iUh33SkxOx9d7CAla4/uXUi1UeTmE8bb6RdJpM?=
 =?us-ascii?Q?4vspO+tUuw8FZneoiuQPB2e6gzGhbjDaYGWKzqGengxb5BjnagSAYCKuIPQj?=
 =?us-ascii?Q?LyTwDgj9GyHv8nub2h0sl0JTdQyATNNbtF/KpqCZjFkIE7L6UUJl8EKr1Ers?=
 =?us-ascii?Q?qW2JmxVtzLUCe0zHm5QQa2NAJRWMFGbwwuBQUNzEOiwNwjYYTaJsW8XFHtQz?=
 =?us-ascii?Q?pb3KAMeCK9z78Dv8fcZm40tEPwSbVrQKl42TDCC/oM2d5UIAlmxZZsow9MX0?=
 =?us-ascii?Q?eRT+sn5KwtXQn45GtGEWJ9FlN/Y+IU7STQ/F4eFXEMvw0KMAc0iO9NDjV5yU?=
 =?us-ascii?Q?r+isr6wlj+JUupGZGB2E5bLqKEBLaO7Tkiv5gdx8G7vS/q91/hAT1k3QV0dr?=
 =?us-ascii?Q?zTeO+uoaGduzyTvW76JU+s1U6MWTaYTVfaGRcXrgjYEoPEX4zvCxCVBs01EM?=
 =?us-ascii?Q?gLcXtn4Dnic75F5gNJninanPcDuBkmCZGJJ7Fd/6J9vKWSi9Lqo6apmK5nOR?=
 =?us-ascii?Q?ODKGMVvAXsBU+CmwJKQfhZTMWKK+wsglbvifWTadHsuUeLqVeOyWSudVcns0?=
 =?us-ascii?Q?vnofi2TfAyh6OpI0eGogjNExw/5R5J322yA1EWfHByq1zyEZUrupTrnPLDwa?=
 =?us-ascii?Q?XJUYj65mFsHyvcyKb50R8SFeQWsS7HrDZjLXUzGj79Kmvo7w6cU+mScS6iNq?=
 =?us-ascii?Q?BA9uoI1u1uyERa3AH2AGHr2nRihnZk7cJrMpWpl1yTmByaprd6OgOowLVhUa?=
 =?us-ascii?Q?NuL7KCe762F9WKosqQ+AeoPsDOGHJOvMs8JPx00rQr8ZapLgNyEyW7vr+t+V?=
 =?us-ascii?Q?t5MG9RhM2egAnHQL6aEYMsB7zXTRmrlIxBX0SshGv3ZjviuuzMXx2RWBLU76?=
 =?us-ascii?Q?lyOVmHbhYeaMt7ONTgcZqQOjHPUORjp83T3xa2eGUXtgz3uAAJMjT4/moRQ+?=
 =?us-ascii?Q?dEZlFuNg5fa9G2cg0jqbtmphBnffkJ32jNDhpttTD0Lcfa+Ieh0ZAWCgr3f3?=
 =?us-ascii?Q?Mz0kYvuWMic+K/FiJgCjc+QK1AsC06EOAs2LgI61fOkSiyTJNQ04Rrm2TFUZ?=
 =?us-ascii?Q?rYNYeKSTlH1PRSe98bP0UPxCGjWMvPsPr4eEi5S1NwTHJh+7GmebxrbF05ul?=
 =?us-ascii?Q?x91BnVGwckkP0ZfmQk5WpWsuFWLHiZMS8k4rgdfawZap3Yi2dbAQumlzdolf?=
 =?us-ascii?Q?5q6epRVnZFc2Pskd1spwvWVMAEoOmYC4c/lxzy4HxS8VIDDkCXuc8qOIcJ+z?=
 =?us-ascii?Q?j5AXo4Q5y3OHCSPH00J1KO4M5bJWMGxaMkeFAla2u2BdD57YebWrVJJ3l6Sh?=
 =?us-ascii?Q?CUBl/2hn1rCIr97e6YZsYgV7pt6JO1Sby9OObBY7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?jlJUf+A/xE+L+5B4VeQmUN3cjQ305/CTRx9kgKq0f36RodEWERI6hRXEdAMZ?=
 =?us-ascii?Q?mf33H9BMXfRbYAcEfq8POEH5rn663sSmOYFSRvGRFwVnaHXgxG7ZuCy1JMcx?=
 =?us-ascii?Q?vHJG2R4vUvfSTa+MkwqsSDxCeuxdDzI7ZADxZ+hJ/jKopSbJuwPJen9bA72t?=
 =?us-ascii?Q?9OF9HInkltHAg3kGja/69Jf5Bt8q5eJPMjyN6vAnuhsa1ZCQY8r4LPcoppf5?=
 =?us-ascii?Q?n7Ic7Kp0TZ0G5hBuB/SCWlNbm+VqdknAP054xOEQpywbBRc6epr4ZMt/L3mC?=
 =?us-ascii?Q?h3/UjG9rnvQyaCPDmEQ7dN/xeZEmgxjdhMYK7mMxuJUUz9By6cke52esF9KZ?=
 =?us-ascii?Q?hD2TokiJhf/5gjkUiNaMpRohFOLI575b4vKBQosWYIhNeZzq1OF1yp7RBNO/?=
 =?us-ascii?Q?P9OV6y2pq21tdMdLvs00F2lpQyTGeVyj5GVwczxXATTT4DPl7YNqlV6rlemv?=
 =?us-ascii?Q?gG4GrvZAqnVWc+ggzzp8i4W2Hgbn20xMaX6JW8wQ8FB3O3TIENPjsiiGjuyq?=
 =?us-ascii?Q?5WlNZL/PdeoeuOrdSb7Af3pLiryqVEma4N/Dd5lEMQUkKtY6H4jScU2kQ5cP?=
 =?us-ascii?Q?+lWPgjwDrda1MtmIHzuued3F924O8xVPRhPrE5yMtnEh9JMXNiIgeZCJ+f/3?=
 =?us-ascii?Q?QaJzqTygFZe4rHlwn+XvXP2aHLDy6vDTZRaET3DV34M0UTQZnR3psujZk461?=
 =?us-ascii?Q?JpptKO3xMaR7fZ9eDB6KRlguXsjvDxFAUn476ctCKv5NBEZ8ozvMTpxct5PO?=
 =?us-ascii?Q?RnyavKkP1HOeu2Q0YroPqBF0FI3zAKLZRIlmfw//9bcoWlfjDSVAFJSqUK2e?=
 =?us-ascii?Q?ITXdMT0Ddcylj3K6ySpjC5Ex63+lKGCQxGBskaacdejXnFCpz65mC02RaA/k?=
 =?us-ascii?Q?uNcuqKm/azJWmh3x/+Um5qMgkYUuEXhS3rq6m4TqmgkWkgdP+UUHJHPCP22+?=
 =?us-ascii?Q?4yq4dnAeUvdVHRuO1rknHz0XfD7L7TgfcUNS+AdW0+POnp8q1xxH6yAuwJOV?=
 =?us-ascii?Q?i5fL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9cbba8-76d1-4cbb-c2e0-08dbb3227f7e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 23:54:55.4931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6FqHhi8QcqWFJrcviAUo2Mv47jq8t5qmAG/T8H7GNG+5nQTQMdJyZoJrrXxhQW/pdGlFze1jKjGjLhG9UKxGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110219
X-Proofpoint-GUID: 5yGmJGDbxMlQaVtclKK7nbg-ADJoumTo
X-Proofpoint-ORIG-GUID: 5yGmJGDbxMlQaVtclKK7nbg-ADJoumTo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Paul E. McKenney <paulmck@kernel.org> [230906 14:03]:
> On Wed, Sep 06, 2023 at 01:29:54PM -0400, Liam R. Howlett wrote:
> > * Paul E. McKenney <paulmck@kernel.org> [230906 13:24]:
> > > On Wed, Sep 06, 2023 at 11:23:25AM -0400, Liam R. Howlett wrote:
> > > > (Adding Paul & Shanker to Cc list.. please see below for why)
> > > >=20
> > > > Apologies on the late response, I was away and have been struggling=
 to
> > > > get a working PPC32 test environment.
> > > >=20
> > > > * Geert Uytterhoeven <geert@linux-m68k.org> [230829 12:42]:
> > > > > 	Hi Liam,
> > > > >=20
> > > > > On Fri, 18 Aug 2023, Liam R. Howlett wrote:
> > > > > > The current implementation of append may cause duplicate data a=
nd/or
> > > > > > incorrect ranges to be returned to a reader during an update.  =
Although
> > > > > > this has not been reported or seen, disable the append write op=
eration
> > > > > > while the tree is in rcu mode out of an abundance of caution.
> > > >=20
> > > > ...
> > > > > >=20

...

> > > > > RCU-related configs:
> > > > >=20
> > > > >     $ grep RCU .config
> > > > >     # RCU Subsystem
> > > > >     CONFIG_TINY_RCU=3Dy
> > > > >     # CONFIG_RCU_EXPERT is not set
> > > > >     CONFIG_TINY_SRCU=3Dy
> > > > >     # end of RCU Subsystem
> > > > >     # RCU Debugging
> > > > >     # CONFIG_RCU_SCALE_TEST is not set
> > > > >     # CONFIG_RCU_TORTURE_TEST is not set
> > > > >     # CONFIG_RCU_REF_SCALE_TEST is not set
> > > > >     # CONFIG_RCU_TRACE is not set
> > > > >     # CONFIG_RCU_EQS_DEBUG is not set
> > > > >     # end of RCU Debugging
> > > >=20
> > > > I used the configuration from debian 8 and ran 'make oldconfig' to =
build
> > > > my kernel.  I have attached the configuration.

...

> > > > It appears to be something to do with struct maple_tree sparse_irqs=
.  If
> > > > you drop the rcu flag from that maple tree, then my configuration b=
oots
> > > > without the warning.
> > > >=20
> > > > I *think* this is because we will reuse a lot more nodes.  And I *t=
hink*
> > > > the rcu flag is not needed, since there is a comment about reading =
the
> > > > tree being protected by the mutex sparse_irq_lock within the
> > > > kernel/irq/irqdesc.c file.  Shanker, can you comment on that?
> > > >=20
> > > > I wonder if there is a limit to the number of RCU free events befor=
e
> > > > something is triggered to flush them out which could trigger IRQ
> > > > enabling? Paul, could this be the case?
> > >=20
> > > Are you asking if call_rcu() will re-enable interrupts in the followi=
ng
> > > use case?
> > >=20
> > > 	local_irq_disable();
> > > 	call_rcu(&p->rh, my_cb_func);
> > > 	local_irq_enable();

I am not.

...

> > >=20
> > > Or am I missing your point?
> >=20
> > This is very early in the boot sequence when interrupts have not been
> > enabled.  What we are seeing is a WARN_ON() that is triggered by
> > interrupts being enabled before they should be enabled.
> >=20
> > I was wondering if, for example, I called call_rcu() a lot *before*
> > interrupts were enabled, that something could trigger that would either
> > enable interrupts or indicate the task needs rescheduling?
>=20
> You aren't doing call_rcu() enough to hit OOM, are you?  The actual RCU
> callback invocations won't happen until some time after the scheduler
> starts up.

I am not, it's just a detection of IRQs being enabled early.

>=20
> > Specifically the rescheduling part is suspect.  I tracked down the call
> > to a mutex_lock() which calls cond_resched(), so could rcu be
> > 'encouraging' the rcu window by a reschedule request?
>=20
> During boot before interrupts are enabled, RCU has not yet spawned any of
> its kthreads.  Therefore, all of its attempts to do wakeups would notice
> a NULL task_struct pointer and refrain from actually doing the wakeup.
> If it did do the wakeup, you would see a NULL-pointer exception.  See
> for example, invoke_rcu_core_kthread(), though that won't happen unless
> you booted with rcutree.use_softirq=3D0.
>=20
> Besides, since when did doing a wakeup enable interrupts?  That would
> make it hard to do wakeups from hardware interrupt handlers, not?

Taking the mutex lock in kernel/irq/manage.c __setup_irq() is calling a
cond_resched().

From what Michael said [1] in this thread, since something has already
set TIF_NEED_RESCHED, it will eventually enable interrupts on us.

I've traced this to running call_rcu() in kernel/rcu/tiny.c and
is_idle_task(current) is true, which means rcu runs:
		/* force scheduling for rcu_qs() */                                      =
                              =20
                resched_cpu(0);

the task is set idle in sched_init() -> init_idle() and never changed,
afaict.

Removing the RCU option from the maple tree in kernel/irq/irqdesc.c
fixes the issue by avoiding the maple tree running call_rcu().  I am not
sure on the locking of the tree so I feel this change may cause other
issues...also it's before lockdep_init(), so any issue I introduce may
not be detected.

When CONFIG_DEBUG_ATOMIC_SLEEP is configured, it seems that rcu does the
same thing, but the IRQs are not enabled on return.  So, resched_cpu(0)
is called, but the IRQs warning of enabled isn't triggered.  I failed to
find a reason why.

I am not entirely sure what makes ppc32 different than other platforms
in that the initial task is configured to an idle task and the first
call to call_rcu (tiny!) would cause the observed behaviour.

Non-tiny rcu calls (as I am sure you know, but others may not)
kernel/rcu/tree.c which in turn calls __call_rcu_common().  That
function is far more complex than the tiny version.  Maybe it's part of
why we see different behaviour based on platforms?  I don't see an idle
check in that version of call_rcu().

Or maybe PPC32 has something set incorrectly to cause this failure in
early boot and I've just found something that needs to be set
differently?

>=20
> But why not put some WARN_ON_ONCE(!irqs_disabled()) calls in the areas
> of greatest suspicion, starting from the stack trace generated by that
> mutex_lock()?  A stray interrupt-enable could be pretty much anywhere.
>=20
> But where are those call_rcu() invocations?  Before rcu_init()?

During init_IRQ(), which is after rcu_init() but before rcu_init_nohz(),
srcu_init(), and softirq_init() in init/main.c start_kernel().

> Presumably before init is spawned and the early_init() calls.
>=20
> And what is the RCU-related Kconfig and boot-parameter setup?

The .config was attached to the email I sent, and it matches what was
quoted above in the "RCU-related configs" section.

[1] https://lore.kernel.org/linux-mm/87v8cv22jh.fsf@mail.lhotse/
