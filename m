Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AAB7CDAFE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjJRLwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjJRLwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:52:05 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDF9111
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:52:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxxZCSdXqfTyVa4IjTtzKFgWZUBcbnuCcQy38PyfiRbY8kAksBTgD7xwNE2eVWNx7+5VMYTzv+cLHjs9Wg8/GrgKXsLUjJm/4v8/XqKQkB3N6Bs8VgL42t0PiyUup98K1+U7PcKJtBSdsUvd4aAmu14QMQr/7axMzwAuF1DhWTiV4TsyCsUVIx5dakQO2zcfjmG9zMs3dJUbWMVG88UXgB5zHIlVQEhQEyDFJr+PbKVjxiMcJ8kx4JP+nJzgbbAejK2nqOGUJhXrRGgb7lha3zzw69RQbx9p4jBDPqHzrTvXx33w7z3ldkrJ4TsA8njoNd/JHcDhrfxGhhnTXtRtxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ex1eWPcyl+QDr9oj2F1oLhzt0ZMktHGzBRhcCxiZtTI=;
 b=dZlfJywGgobAGImb2tQGaE5gdlAfpXUiQJYgsmQ8sMqEvl1APbHT5MwCv7mH2c0X2DC487ZdyrpPWxSLRvOk+/slBTFnfsBNg6FmdyBLi2s4Uuu2HYVTTAP6D5bB/fS8vgy0OA/jT01EIo20tLUnk8ad4HIlmrrSOJ4a2U3AsnNZ+GyH62RzpHe4HlLlZlTbbezopihvuV0fpMMc/jtAdgLncSnJr+N8M8/lJ66VxK+ZHV7wE+lORnxwDkKSy48/t+QCIuotVP9UVOTovaDgEm+dHUNboX0Ebsf7GHL9S9sMgvNh4X0acx21P+94Nhw+bYccK5PTca/d8XO4XdJGRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ex1eWPcyl+QDr9oj2F1oLhzt0ZMktHGzBRhcCxiZtTI=;
 b=PkRnRpnwU1TUp7YpkcG4sHxX2iHLilNLy+YmRf/Vubr0ENSnJJlNRT4JoBKSEGexclLc6vqpUTFqvWH6SHOjwevjqMBMbO0za61IkcH6fPGre8guneuO2w9le28yLYjeG/xuvwh22eSahpRlu/C3DndVREEVn2KVXQZbHI8DevNIM34xxKZuuRJTvA2vsxfRnVTbJGtX4rOE0X1S6H/YWg92LMe8HXtH7WWcm+1iJBfq+C0cTFwH1M5IxJ8fed2ow3PS6BZs20FgWvXiqEpBxbTKM0WQEA5SrDP/ZIOYU+nFdaPf3ifr7dxCce2Dv+xufk+ESQmFl+SPEkND09VA5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB6776.namprd12.prod.outlook.com (2603:10b6:806:25b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 11:51:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 11:51:53 +0000
Date:   Wed, 18 Oct 2023 08:51:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Saeed Mahameed <saeed@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH 5/5] misc: mlx5ctl: Add umem reg/unreg ioctl
Message-ID: <20231018115151.GP3952@nvidia.com>
References: <20231018081941.475277-1-saeed@kernel.org>
 <20231018081941.475277-6-saeed@kernel.org>
 <bfdc04b3-d776-4cb9-a95a-eec317e792e1@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfdc04b3-d776-4cb9-a95a-eec317e792e1@app.fastmail.com>
X-ClientProxiedBy: SJ0PR03CA0385.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2a56e0-0abe-4b7f-7c12-08dbcfd09f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: obsVXKzVuwSu2Pjxae9jL+flJWt4mN6aiwignnqtEw+c2iCV2R0FXclM0dMvd0UL5Do9Z8LUiGuqa9hSkhSUVVO8Vd3H1IUn56Kqj/6CImFsdS7Jh87w8fwjp4Gk/l2tYS0IW+3Vw1qXXCpzvPwn9PltftJBggTyWobhnWuPK2pwlXCPVt6Rk9Slk1WiTLwV6onwAxgd6zaoc3MNwCdR80lLFOA226rI3yR4GaXWBAnnifCLzai4NRifdzulgaXKNQMyLRwQZq22FUX7MptTcDC/4yUP2X0y0kX93gNMypFBjCLElMStwqvYsbAx1G7heasTJC3kBqFQ1O2BY66Q3bViVpYITOMP2E7pifEb22q6iF8qdhOW3eduD8wwSa9kTS7Z05xHdZR87fgdzCtiL9KTiFhnA7ErFRQsJyTHMkFx7NG5Q0hFl5Z5GbX4ogeyvGkt7q95zvFyrELOyq7RX7llZJ50R3w+iZyfM6u4gFKnMcDkGX7IGF+UIDNc+iQGxa6UP6h0h8AaeYxSD3d3G4d7gThPrUiwhhi/PA0fL4BmexDMGXCmSekd6htjwlRnBVskxy35wjpzjm4myyZEnByccBix/x2I+iR306Yzx5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(26005)(2616005)(107886003)(6506007)(1076003)(8676002)(8936002)(5660300002)(6512007)(83380400001)(41300700001)(4326008)(66946007)(4744005)(2906002)(478600001)(6486002)(316002)(66556008)(6916009)(54906003)(66476007)(38100700002)(33656002)(36756003)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TGHMkXyV4YMF7fGlSjegfsDQtbkB2Nln0qLqNzQYW/wvavvU/p38zUqLk7/u?=
 =?us-ascii?Q?XVO2219ug6kFxgfobqd1TH7gtaTK9GMqJyLa7pQbkPBJvbzjfeNFjB9xzHDW?=
 =?us-ascii?Q?iCW5FSllGDl39MEo8C/VVJVVTvVthESrgogA3hYmH8AYo7ztlAjvMrV6jGOM?=
 =?us-ascii?Q?3ADCTMgk0yngTIwPzF1gDe0CQLsD1l3532cRHSoObfUZTxjBzSWW148TRIlV?=
 =?us-ascii?Q?ILscotKhM39ewLNfCbE4oIPL0i/tPKgfnnOJ9V3W0N1Sj0APhtagbJ+0u5Fj?=
 =?us-ascii?Q?oKY1Up3UWOu57BnpjVZxbIzRBpikaLEaZlw9NaCSzTb9zrF7ompONGHpTb45?=
 =?us-ascii?Q?F4cFpLgd44xqe0dkE9elu9OrmfWF11+cb44ptoHm0Q4g5BQbe2cuE7SamROK?=
 =?us-ascii?Q?KRUzSrCRo7VvutuhBBbX1U+O0nIgUijkPQnxu7Wj4PuEcArzD4whzGju0B5E?=
 =?us-ascii?Q?gYpcMbjc9kq7BO3w0asvkBkWa4qztb3TsxrH0DS76fUd3s1PIXFktRcyQzQU?=
 =?us-ascii?Q?wfwXAuJkFPeV9w8JhxfM7CDOO2nyynAvDMaddyDHBGSoIFCWC15GoKYOseYx?=
 =?us-ascii?Q?zEEjePJDgH7g5XXdk0u/mvAuDr9B8W51Ec2rp5BkUG1u+DN6JKFTEuk0oAzZ?=
 =?us-ascii?Q?xk3tY0psAlQrkXwQF5t5r1rQtGiiraClSjK7T6H9piaFlK5ZqPC+YwFBz3DL?=
 =?us-ascii?Q?G/PPvRd9Z+rcYJLusp49gHjEVmsK3h0T+4dF2bfx+KWP145GDWOPmHwA4nJq?=
 =?us-ascii?Q?Vvn1skffINyggtOQE+pZyzB4gLlmUqTnhw9SVD88nXrpzopD1og+JHg5R85Y?=
 =?us-ascii?Q?pvB07WBjiJorHQxdDEIvFLbosu255h/7PZbE6tNe2gh9VtV2CxLHJ89B4+Kj?=
 =?us-ascii?Q?iqzlxVWJFbZ5EnlwkcDlmD/PbREzgA3EsyGTk2kWIyo+TOTUgD3fEvLlJ8Og?=
 =?us-ascii?Q?9IFLY+pPvshVFYiy9WMzKPhFiyce/JxLiDOVWQPHeUVdY5Ume8Ro8ze1xh59?=
 =?us-ascii?Q?R0W8LOR5RjZivjBOU5WKIEfiEwZu94unDKX9Q/n1L7DCejRRdjOs4LT5WhdG?=
 =?us-ascii?Q?4mkOHuBy8BP4deseUc52BgG4Yk7wPI3VGZGesWOnxFaaV9dFRBBedYt9MEVd?=
 =?us-ascii?Q?Kd/MjjuicGmJANOaqp7Lb394elAtjUX9c/d4Gi+hm0LnqSjGf7Vwhm8xguO/?=
 =?us-ascii?Q?+ZwecMQwJAkWnwedBXT0O7+b5kr77OB4U/C9t32wTGHO/Wr9kmlDGl2G1ACy?=
 =?us-ascii?Q?WwV25PO+LRG/tynLqq95kEMvEavRhtW9jtpe7Edbw5ch9ImiivfA3FkcOuSS?=
 =?us-ascii?Q?kxVM+rmXOFBkGVMplNFO1GFgHKlXaicSV2F3xvV8Fpvkic6dFkaEVcjrzevX?=
 =?us-ascii?Q?ZxZAO2A55RV+461+m/dnPdWJjAve55Ypu1VCK8fuqKci8t68d0nPqxSKy3UR?=
 =?us-ascii?Q?WwdUY4D+MvWdrRsareBge/gBVtib7vkSBwoIROUuBJtDvjsinnvXjQnXtlvd?=
 =?us-ascii?Q?wCD9xEFNwKzzGjFMurR0mnga76848uVGOhoUfZ/JYud9H/4tK/pVSbbBJh41?=
 =?us-ascii?Q?o8liXjYuxCWotM94ZNP7zlQelWpd7X6H7hyL0OY6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2a56e0-0abe-4b7f-7c12-08dbcfd09f5d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 11:51:53.8159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0NnNhEoYbw1dl43lnfBsHAx6FbqnEwtEN4rzDjWy5q1+xYuh+ecAyA8FRUcC0dLF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6776
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:30:24AM +0200, Arnd Bergmann wrote:

> > +struct mlx5ctl_umem_reg {
> > +	__aligned_u64 addr; /* user address */
> > +	__aligned_u64 len; /* user buffer length */
> > +	__aligned_u64 flags;
> > +	__u32 umem_id; /* returned device's umem ID */
> > +	__u32 reserved[7];
> > +};
> > +
>
> You have a 'flags' argument that is never accessed and can
> probably be removed. If the intention was to make the ioctl
> extensible for the future, this doesn't work unless you
> ensure that only known flags (i.e. none at this point)
> are set,

Yes, all the reserved fields and flags should be checked for 0 in the
ioctl paths to allow them to be used for something else someday.

> and it's probably a bad idea anyway, compared
> to creating a new ioctl command with new semantics.

This has been done successfully quite often in the kernel.

Thanks,
Jason
