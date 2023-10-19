Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA7F7D057E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 01:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346711AbjJSXt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 19:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbjJSXtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 19:49:55 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AEF114
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 16:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Okdjm8Ty365qaYIEKMsX4NT8WbN4VM0C17tZcfA2gV7JQbtdKWCyGTmZiRigXHfIXe6Z2ETL9ffwLYJRuIoYE969Lz4M4L4ARSUckltBSAx6OBvwhg933dMCieanY6O1BwM2KtYHLTWUqu5Xi0LK8iDsGgmlCSNnRe5avEIJslaWYhNJdvjKiLv50v4H6zdypxlz1kP1RcykBJxgClV1dQsOzQFHAsCFsDVX/qetiOVCB1nTl8vCaoXBFeIKp7akZux4Z+vbe4AG2/YGaKwtwN7M4RAd8Gfw9bfkcyopLp7HXBq4NDkl/xyiLRtawl7gcRLlqZDI7LVprfKnMFsqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCrETM31xkFKakZbRUdkCaKq8CEdJkQ6V2xmnCVNdpU=;
 b=MwCwjU5xO6H9l0PK45FB7ma2V8qQsO8T43x+bkKk7wL+Axor3un5xQmsflB/z8IdTluBuc3U7L7XZhkh/xMvQWpRT0nL0yXDaFT8cJTb/i+JuF83pHWnqmtuoQ4A4QeDg0tQnayxBkB4proqsRCMKkYn1ChK5CBLGIYz4qzG008UKKV8N7yu+3wDt9bVq+0xNHy9rORlAPP6Uzf7cGXalvAnxvk3MkZDwlE17VS2k+sfq3FPqICIcTtHoCv1G80j4Ik5IQOUTV5YA1+Vk/ZFopWImbuBPi6+J3PZ9gdm0g2sSHiotDqfzK/B9baCfYTY2A1Q8IUqQ51CCG4zT3sx9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCrETM31xkFKakZbRUdkCaKq8CEdJkQ6V2xmnCVNdpU=;
 b=dELQSq4t3+4cdQHRjAtXe91vDk+xtFNU73GU9DabKXG8pb4F2Xae8oxroJAWHxmvxXlkIwk8fiSyfhJu/UK5fGHgoKFACmR8UjD37c1MKUsXQy6k5A4FZTAsaFAnZac1/eQJoLLX/2VIW9u8fS8XwPb9voS1wj08xa/XGcBOiBSDQ2IStE8ziyvkeIc4L0mWG2LMCn3DY8ZWGfAWMhf+fay7vKZJBrOqN1rlDxpCVfZPhndow4ybBevusC655HWpZfBE/NsKoqvYlXvVDOubvUAhc2oaT0o6Nw/LgQkLYBtleVQiopiA2aghfuzHUUqqpTAbbvSGJdi2n9dMxiPDmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Thu, 19 Oct
 2023 23:49:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 23:49:50 +0000
Date:   Thu, 19 Oct 2023 20:49:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <20231019234947.GX3952@nvidia.com>
References: <20231018081941.475277-1-saeed@kernel.org>
 <20231018081941.475277-3-saeed@kernel.org>
 <2023101835-trapdoor-unicycle-788a@gregkh>
 <20231018180128.GA719006@nvidia.com>
 <2023101808-quicksand-roman-0da7@gregkh>
 <20231018185629.GD3952@nvidia.com>
 <2023101913-owl-showman-5858@gregkh>
 <20231019190046.GV3952@nvidia.com>
 <2023101902-upturned-pledge-3a35@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101902-upturned-pledge-3a35@gregkh>
X-ClientProxiedBy: BYAPR11CA0101.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::42) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc9e95f-e438-40e9-19c9-08dbd0fe153f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C0eVkNj5j3ucqynz3hVlD9MAz4gCCEBOxjM+s2/YLPZuLz9ETPrA+IqcIx31JkXhLtR2+lMq7xZmW+EM8UpAT2qtCBkluLHpI7MIRWa0+EuMu2MuLtwltSYe2x5WWmoRXV5ieEbvVkxOF3wqXFTLH7YhI5EZJvwJvB282pwXOKFaLrnK9E5Z+HOmb+32aDjEiDlOMayxeEGHTzeILRXXnLV4wGQrluB6za8StoR+zTNBDuBrhrPEsp/xOz7XfC71lGO6gLTWedf7x8uwiVyhX8YZIHcY2NY3JHw5XJbox90apNHtToJgfJtX28zGrexzEUd+ANE8ANnv2GhMfvuLvzmnHnp1DOInIIoMaMY+5Oe0yJGs/w7RerNY1AKayO9n5wFwpaEq8h6vBxvQXEA11vtHPloB7+3Db+lys8jII0ixZwuf0IHy/HEssGmDHwHaPV391kLTZ043fGTM6XjpoMUzFvDlsiTHjSSFazyb4jmIbgudBq+6OtPwHX0l58I1UAgr8GMVS9cvPtiOlKWDQxUaNdmEvreR303WbCwc97Q/3Qk/VmHrqoWlYz/UwsPpj/RJ0Ks6L+iKQQkXQLN1j09wxMkB4FV2C7feS7mP9TqdCRAYbTjo+34H99AV/JrHXtLE0V1k8kB8ZFTEhfUAtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(396003)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(478600001)(6486002)(6506007)(6666004)(6512007)(6916009)(316002)(5660300002)(66556008)(66946007)(54906003)(66476007)(36756003)(2616005)(1076003)(26005)(2906002)(33656002)(41300700001)(107886003)(38100700002)(4326008)(86362001)(8936002)(8676002)(42413004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NrEn6dG+oW1fbGQn2MCiodhWrizRfat+om57nRmMfR+AplHkcIz/Qb4zW1Ij?=
 =?us-ascii?Q?CrNLYj0wdOU4SCCldcfpOP7cE18agg/GfHnoVbygPHoQ5KmA1f9XgxObZSI7?=
 =?us-ascii?Q?vVoJr2OrsAGSvdUaFecD2wqtwJCiPsZnE/5HgQq3aQXJjKP7YHvYmPoa/BgJ?=
 =?us-ascii?Q?gSzXH3qW4QqSeEfEn6926KdBbgueXh97NgtyM2O3iWKS/pi8YBcqxV0KxxJV?=
 =?us-ascii?Q?rY9uWuczmYCVyM8oOJnECZFh9Bg1DtxZQztZ14fAGJdXeDv8q7mkVHsUseme?=
 =?us-ascii?Q?ySNBUAAkgt9kmEqzF8p2r+5uEGO4YUOdl+TGKlSl2/3F5qhyDw8WTv3nVAib?=
 =?us-ascii?Q?OmRj9LirbM/7goLAOM4XopqJCaaKltoMSiVMU/zkZmRmv74V0Rwa46Kjl6Ev?=
 =?us-ascii?Q?LezmWCJjTChVmIze5cKxwNYK0yE/MahvbJkFCrHfV9JdS2CEiG91nvjNRYpD?=
 =?us-ascii?Q?sgoJ+DlrcPvgjh+ZnnWpCRJNhMWvv00iUX+boyeuJ4JTTsc/bXyMnCY2ddgM?=
 =?us-ascii?Q?jDf3mWOmKxeNYOabpbBaMM/SWKpjBe7SCp313Ahx3j4ZgLf4tnUH9JXAexOR?=
 =?us-ascii?Q?kqE3l5NwAklzqWOG4xw8ncyBceFB/S7SAXI4Ls9bZaUZp0NSsNDHavhGkbO6?=
 =?us-ascii?Q?nYq3ShVJFiIN2ZyGg24HLh8Zg5X2wte4pFMTcYPHI/hvPQsNaAFOLaEsCSvK?=
 =?us-ascii?Q?q43tdGd9D1SBOuF0L98E3ooHcuQYNXEcQr9+IEf/6airmNwA34u77bgfGe+l?=
 =?us-ascii?Q?uDwoS7ZhXqCE6OmIdHAW5zrrs3iZhJ6xjJAN7INkdBI2pzHIBSU1Q+cs3vDC?=
 =?us-ascii?Q?vFGF+n5BUUVXORuQnnpKaLHePHiOlOxdIDeo7/PSeeSezn0mo+OnXl2Ahp9p?=
 =?us-ascii?Q?ZX2L4G3L/7vL6chkXw1/lE+LrSqHwCQADr+BNtoZ6Xfp4YDGd1aGqBqb4YLL?=
 =?us-ascii?Q?B94Iyuru2lTMpbtNqqQ5P9g2ifanNsyA1Km2zc8wL9DL0nUKKpzIj/fBp5s3?=
 =?us-ascii?Q?YDLN0ROdpMgpx5/M2DEqH8Uhhs2V93c2bCVIqWllM0pcPoYUA8tASsEjkN+w?=
 =?us-ascii?Q?Xb+fRe90T/DGhB1f1SqiO3FIYKyRYxFqAeaAkjK2gEEM1ttTEgZVMRulsaZM?=
 =?us-ascii?Q?8W1ZbugxC2ncYGuAweXV8EH7LTMv7IuA1/EnfFAhAGnSGLwXMgDu0DQQA6DQ?=
 =?us-ascii?Q?0vcaIkuTRr9HSoDFbOwlAEduZv1nxNfSHKCOknDAIFpDDgcN0thk7DHJ8dEw?=
 =?us-ascii?Q?7YOYk39aT6Xd4jLOfHowKQJsGqZ3feBQD3l+44Bmj5IGsjIiRC6Qbgi/gZvp?=
 =?us-ascii?Q?ysxHli0Vx1yJurkVpYgAYafM5gXaDYJwPPQvCsd5mNCli9F3GeCvW3o45z6i?=
 =?us-ascii?Q?xWUH3ejEAB2Lv4GJth4K2BgvKtgm9qLiGIzD3Hm5XRjcjptQ+bzGgCMAX1nz?=
 =?us-ascii?Q?TfvV0OFBaytKKppNJxopwaTvtSxNLx7cxQQuuyD3eTG1z69SG6nxjP5O9Hlh?=
 =?us-ascii?Q?pnBUfAikZ/jaRSNGPwBBov6UjLxERX1yftIQdTGD5zdD5qXXgTNq77KoE8ZU?=
 =?us-ascii?Q?m8pA6gVbpeh1BMEuAih8B0YI7qIy7hvSBJKQNvXb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc9e95f-e438-40e9-19c9-08dbd0fe153f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 23:49:50.5498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1kJWs2tkC6yKXnizj5CFvCXe3DWvmO0BfnJJZK7uxznwxg4li+LgDhukfF+Pl2s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 09:46:29PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Oct 19, 2023 at 04:00:46PM -0300, Jason Gunthorpe wrote:
> > On Thu, Oct 19, 2023 at 07:21:57PM +0200, Greg Kroah-Hartman wrote:
> > > > All of the Mellanox driver stack (over 400 files now!) is dual
> > > > licensed because we have a large team of people working the Mellanox
> > > > driver for many operating systems with many different licenses. We
> > > > want the certainty of a permissive license for the driver code we
> > > > supply to Linux as the team routinely references and/or re-uses
> > > > Mellanox authored Linux driver code into other scenarios under the
> > > > permissive side of the dual license.
> > > > 
> > > > For instance I could easily see the work Saeed has done here finding
> > > > its way into FreeBSD. We significantly support FreeBSD employing
> > > > maintainers and develop a sophisticated Mellanox driver over
> > > > there. This would not be possible without the Linux driver being dual
> > > > licensed.
> > > 
> > > Yes it would, you can take the work that you all do and license it under
> > > the BSD license and put it into FreeBSD just fine.
> > 
> > Sure, you can do that at day 0, but mlx5 is now about 10 years old and
> > has tens of thousands of commits. Many non-Mellanox commits. (mostly
> > non-significant, IMHO, IANAL)
> 
> That's not the case for this specific chunk of code, so it's not a valid
> point at all, sorry.

In 10 years it will be in the same situation as the rest of the
driver. You are saying we can't plan ahead now? Why?

> Let's stick to just this new file, please keep it one-license, not dual,
> it makes everything simpler overall.

Simpler for who? It seems to complicate Mellanox's situation.

More importantly it seems to represent an important philosophical
shift for Linux that touches on something we have a significant
investment in.

I would like clarity here, on a going forward basis. You do set the
tone for the whole project. I've made my case for why we are doing and
why it brings value. You are saying dual license is now effectively
banned.

Previously you said you would agree with a sign off from our legal,
please tell me what statement you want and I will go get it.

> > Remember that Leon created auxiliary bus so these complex multi-system
> > HWs could be split up cleanly into their respective subsystems? This
> > is an aux device driver for the misc subsystem as part of the giant
> > cross-subsystem mlx5 driver. Ie Saeed is adding 3 more files to that
> > existing monster.
> 
> Yes, and as the auxiliary bus code is EXPORT_SYMBOL_GPL() attempting to
> license code that is a driver for that bus (i.e. this new contribution)
> under anything other than just GPL is crazy.  Go talk to your lawyers
> about that please, it's obviously not ok.

The entire mlx5 driver makes free use of EXPORT_SYMBOL_GPL(). Our
legal has looked at this in the past and they continue to give
instruction to use a dual license.

You keep saying go talk to our lawyers like this hasn't been a legally
vetted approach at Mellanox for the last 15 years :( Mellanox has
300,000 lines of code in Linux with a dual license. We have a good
in-house legal and they take license obligations seriously. I don't
see any new information in this thread that makes me think they will
change their long standing position.

Tell me what you want and I will go get it from them.

Regards,
Jason
