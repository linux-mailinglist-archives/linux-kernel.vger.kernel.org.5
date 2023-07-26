Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E66A762FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjGZIax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjGZIaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:30:18 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2128.outbound.protection.outlook.com [40.107.237.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0257AA8;
        Wed, 26 Jul 2023 01:20:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDGtFdsobSqxNmdpAruMN7pJWgP4rZb8fJP+eUr7YDBNmSFdK8D61Xwc5Gx8KlJzWZLkI0maKNcuP7ejirtDWNqZ3admzJtBymKE+9vJjcHNdFxvwxU/9z34FVV0GnnFCa4JyHJqmadrJTrj5x/+HUErPSl0m4w1oQIBHoH/QPWtGgWOHM4GwRq59FjePlQlINMLWosjqqCGXVGAcls69JQs+F3fLkRuWQ2H50c8Gywrs1gSvkMrAWZsdxTmWMuGCpqQKTKpg1wS2uRL6hz+stRbuEjzlMi1OwNaIAgjVKKMyUvD+S9doj6FIL3/7knQvdYzyCICnrEDk3ob8slRoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IocOsjWMzXuxXjxtTbvg4GXNax1YhM/W4AYrC7klcRE=;
 b=R43+AQcI04MmCSRQV9k7vfxkDa0tfI8zX8d3n+eNQOhn+A+g9uKzEP4JYabBekzUTx++ooY2fvaEyLMJ+YO7ewJ1bB1Zd9CoBJN0d8dj5TGbPEDUq/ngm2xRwUvnDvp0mOepp/qHHd8Jkv+dw46P9AzhLNap7wdvySGe+3dsACV2M8cL68C8wl16X0bLxRgYPm0ZzGPiKvf2WfVXosoCaa4HMaDIUpOgZHtaorrzJn+b+EBIDyiSRJbUJth67Mt9c/l6SFFp3PDjvF3nYu+XpxyMnHORbwffOOW40UCuqXFFRCwCf/sbgX3jUKOAz/VaLivaY7wRgKoRx98mpymWYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IocOsjWMzXuxXjxtTbvg4GXNax1YhM/W4AYrC7klcRE=;
 b=DZPA3eIbblZ9wuCp2FYYTXhjNZOZ0mWH8UBPBoPSQ2dfwCPkB1eJSJvbzfdcmjum0fEgWxBNs+bVQIICcdZpu3Br8Z56fjlNFGVw+NWYxEtJ3r4Je1u88zdnhoxdDz9julDyS+7UYAqABgInj0tb1f1Vyuzn1k8ho5svfp5C8u0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MN2PR13MB3630.namprd13.prod.outlook.com (2603:10b6:208:1e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 08:20:03 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 08:20:03 +0000
Date:   Wed, 26 Jul 2023 10:19:57 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Atin Bainada <hi@atinb.me>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 3/3] net: dsa: qca8k: limit user ports access to
 the first CPU port on setup
Message-ID: <ZMDXLenEN/Mcspb3@corigine.com>
References: <20230724033058.16795-1-ansuelsmth@gmail.com>
 <20230724033058.16795-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724033058.16795-3-ansuelsmth@gmail.com>
X-ClientProxiedBy: AM0PR10CA0090.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::43) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MN2PR13MB3630:EE_
X-MS-Office365-Filtering-Correlation-Id: d579ecbf-00a0-44df-b8c3-08db8db11ce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RnqZ9PxkEhbd/nTzdTTD/A+ukxMKv6OK9+pi42SVl/1iLUNRI7O1t4jPIJowfZa95PYWi/f45jhwsJN5LDHqhYpLWV459VBOVaOHN/ctdeDv38uHGLFvD2kMarpj61+BH1ad20V32EGfNphp9esbybyzTshevy8kIJH8UGwOQknGcVf5hwIN28oA/hwBKFwzPuuoDhpRNsocAJK3tRwe/brLnFQPvZVDU/3rw3J+pknH2EkMXMcma4h1zIEEZFaWWduBcM4OstwWv0XeZIQipaOV+OH+yfKwlhaD6FtXYCvh6Dp71Sq74GKSeCXEvGFbagzSRNkjr4qxFvnj7T15UbqKWHX/FlWj8pMw+DdK9aYFsWMJ+k8RUmuGt7TYZ4bmBNdnA9/UoD9Yu9Tif0ksy3P1kYMgeMc+wBbzW1EVvPCgAVDGhU7dpctshrBXz9XELLyaoS7hDFoILbmoCgug6fBet+8/l9syQxSo9QBrEfDjraocicvKgXOnXEqekmwfApEToeIbi0A9b6iI9ANx+0GKq9aa2nUT/1jyliJicPPtSzVs7JHXl4aIzzweUk/j39HDF6ajjcoGNaGBRtbVHAFmpbuZ008kxxgJDojrc9evRodYYDG2KiKhdtNJANzzfK820SW0O+ng9ko8WIp3AXBY9sUbCau4u5sJpl1wAtM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39840400004)(396003)(366004)(451199021)(36756003)(86362001)(2906002)(44832011)(7416002)(4744005)(186003)(6506007)(6512007)(6486002)(38100700002)(478600001)(54906003)(6666004)(4326008)(6916009)(8676002)(316002)(66946007)(66476007)(8936002)(66556008)(2616005)(5660300002)(41300700001)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SBcEvquPqGNtqcppGmdOW9iwjMe6qgvnINK84Qru6tZ+K3yxB9cdpcItmW32?=
 =?us-ascii?Q?jckeDTSZ2WbMAb7eM6V9E9l5slBiU+mKY2BInafuzAim0GiIcEb3ybtZ1oCk?=
 =?us-ascii?Q?L59JfKQMv89O8/+I1whKy1PTqqXJeJsGwxGyqvujw3X97OwQXlN2L1R7Rqih?=
 =?us-ascii?Q?ojjyXVezorxw9w/gKD4lc5fpMFlrAmWbNR5UU1iU/9XdLcvW7OX6Vi8C+a8d?=
 =?us-ascii?Q?Gu2Xw+iYz5htNi4/9zgeZ7OlEVIC9QAIaF2dzL8O6bbJt+iV7sFqGnNh9gLE?=
 =?us-ascii?Q?/aJ4J74Nt2sMqd/jMGLwbkd717yrOqwzYxLpumn4pW0kKlvTMjv5IkksWEo7?=
 =?us-ascii?Q?0qVYDiELTq/WE1yHWGBJtgGhOBhOHBEhqz2sfnW3iHO3RSXtUW1lww6y8cfF?=
 =?us-ascii?Q?4c4Bl7h9yFhZ7V3x6TwsQECsAjJphtqClxyPmr8VeB2emz/C86fi5UKCVtmS?=
 =?us-ascii?Q?PLIgORgqZkzKxR43HYRI1uagLKm0yjdvy9kMekeWqLw3kxkQbXjTz9meVI0n?=
 =?us-ascii?Q?6Odgax903CmzPQeJqQeFILX60krWVchyeTtF9KZwU7bqEI8KUtWzf5GK9mF3?=
 =?us-ascii?Q?ZZLcguU50xSmu1C+LAd4DAn0GYvnLz086ZZQ8CREvxXBSfNnV3k6ivsRtTqa?=
 =?us-ascii?Q?kRKKJr23JtJa6/CVffSllUYL7EqCSyH6/wa5OVKc2Q0yaSIMloHM5Jb9XrnC?=
 =?us-ascii?Q?pECsUKE3xJyYUqCK2TRALqoFLbLmh8OWVFkVhxEWWQrBt0RrkZzl8An+UVNu?=
 =?us-ascii?Q?FIehv+EoXN4bBCYBkL4vYTKu/gfNjGL9BHmB6CBZv6n5eEykt7hcSmGU5fhw?=
 =?us-ascii?Q?n2q/OlKG6MnYvQqICN8eViASn9vz8mgnEIlF8EKxnLdxVZ9P1YzVcH7ZumAU?=
 =?us-ascii?Q?yNcl3noPz16+dIyf7F9zusjBnAk4p5zRIE4t4g7rRrTH8JrEGLfkKcEKDd/t?=
 =?us-ascii?Q?d5Q+NiHTIlO7fTZkzwwLqdfaMxPeO2c58aDd0WKaQyp+aPv10PzuKtB326LW?=
 =?us-ascii?Q?BQVY0GyGZxXgOcgx0zyN37XdlpfYOwBsSiJSso8j+xz2LrgG//kz65Cckm+K?=
 =?us-ascii?Q?SYMhEkCLzdKV/B0X1dILxKSnh3PwSIFF7qHneBNPK2ICq5CJR5AJINsib0wF?=
 =?us-ascii?Q?XoNEVxvQ/4i9vhJSnuytTLLu8Qd3UciZDn4b0QLNVjJFSCfoqk7vonv7tIl9?=
 =?us-ascii?Q?PXd45GNGXVMcJwYg8X9SkAAd4zPYhgNNCbak0iucHAFQSLhq07KK5KJv0/RG?=
 =?us-ascii?Q?X1snZpaxgy8pITX5RNZpVBxrHZW4YmibYImw6i4JXAC8lPRTBQ2r7ZkMS3Ib?=
 =?us-ascii?Q?3zthu9dAFCMQ1sRFk6WQofmQqO2NLMwIp0GHaxL7C88XOu+0IJkeLj11Qz2t?=
 =?us-ascii?Q?L1or0tdD2VmXGnfZORK7Gehxi1MqJw8mE0XKMCp2ec05NR5MRvSt2ulVhT+5?=
 =?us-ascii?Q?r380JKvmqSju3dhPrt9bRxP9xcn8kHHiqlNNKgiGPdfq7MKK4JsgtiacDTyT?=
 =?us-ascii?Q?vOvRCxrcv5ZWmdmunYMofsMN0rSLY/nWFYkU3ejfpfbieN67n2z+ItFgZ84x?=
 =?us-ascii?Q?ST94suufluqQUSRa9A9v44VlIKx5z715BPzXUOJj8YwbUoCU3XEYa2+RdSP1?=
 =?us-ascii?Q?1qAGlVHSepVkjUn+sulXEMXp/r0oXU2Cdue//XN0uZGofKA57Ycf53dr9iq2?=
 =?us-ascii?Q?zedTGA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d579ecbf-00a0-44df-b8c3-08db8db11ce0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 08:20:03.7525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlwO6g0Gdyw03dz3lzIWRO7cGN2VTRnmKmeTHGUH6kSuHAr1h4WXD3vTIpDYT/A2rs5to7ACh8ZuZ7kBZv1eojaH3dxgpBO1aIsjtNsBvfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3630
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 05:30:58AM +0200, Christian Marangi wrote:
> In preparation for multi-CPU support, set CPU port LOOKUP MEMBER outside
> the port loop and setup the LOOKUP MEMBER mask for user ports only to
> the first CPU port.
> 
> This is to handle flooding condition where every CPU port is set as
> target and prevent packet duplication for unknown frames from user ports.
> 
> Secondary CPU port LOOKUP MEMBER mask will be setup later when
> port_change_master will be implemented.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

