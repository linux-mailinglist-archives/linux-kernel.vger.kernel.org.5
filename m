Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C567DD4A2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346779AbjJaRZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345576AbjJaRZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:25:22 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409FAB7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:25:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKF8fkBQFi5LCqKIplk/FnkzY7CulAb3MumkVEdMgXEs84JpFqkrifpULrXYnlpKBEjkDCtCZTVoUHxBXTSB662BOpKn9XM1UWbRcVfyEjfNljLnnhe7vVz2O53zpOSQk2ZxeZf7IhsuWMQrzTZt+1mAXiRRl++jWrX2E5VAyLb9RGnRTM7HIcBepvYK7wVHjJGiBc3DVPwme9Ke0mGuBlNPtWcng1veAJVaLI/uh9ltlsqo/KFCVCeJZRsCeWoSHBgJ+NiYJTXuv3L0riaQebwEPIEOMoZ4AHjkNIVUglkxSvycuQtYEsgBHplTmMgo58odF6BkDzG0gifKrZJtgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/D1zT0oYYo6v7JpntNk/I+i/XpILslEkyw1ESVl5mY=;
 b=G9izcNO1CRZl6CSCHWC2E0C4NC81AE1wOmbHjd9TMsO3iSU1kww/zUSITA0iWeU9fGBxPQi6zhNTqRt6wvgQp4pjBo5qssCX7gwb+wMA6yQQaO07OxJHY1wXjyUjN+fV59MigCSl36huKzACLROErhzs8mesuUP3lRvAY5hC6awLxCZqXt+myy3iDeacRKQwBCKpTGcR75KEfsqfolxwvGKdLAy9JR8m3pEPfvTsReQ/9omu95L/BUO4nyRBC1Z2fAGHmCGhApb77Z+INN7vjNkN0IJ3RoE6YCCT8s8aMvRezOncjsqO90PhkMJOf2cauB1Cqo9VY9dj2qdJHz5Dew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/D1zT0oYYo6v7JpntNk/I+i/XpILslEkyw1ESVl5mY=;
 b=uWSRAxKDJqOrawVu8uVUBcBphvrYYPnTAn3WlVUGwCYGLoFnuRgNjFa3jRGBMb2Ix8TKxPScQSyVffeKFXwkyTKUsRBInIoaWNf56NGKHN6Wcoj8xTjX0TUWRsUbIXLiU/kYula7ZohxVxWyNDrUDaJf9QjZECyARXJRLJo9rdA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DM4PR17MB6245.namprd17.prod.outlook.com (2603:10b6:8:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Tue, 31 Oct
 2023 17:25:15 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%4]) with mapi id 15.20.6954.015; Tue, 31 Oct 2023
 17:25:15 +0000
Date:   Tue, 31 Oct 2023 00:58:54 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH] base/node.c: initialize the accessor list before
 registering
Message-ID: <ZUCJjpQtgGbT8Z0P@memverge.com>
References: <20231030044239.971756-1-gregory.price@memverge.com>
 <2023103129-coming-geometric-8ac0@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023103129-coming-geometric-8ac0@gregkh>
X-ClientProxiedBy: BYAPR01CA0019.prod.exchangelabs.com (2603:10b6:a02:80::32)
 To SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DM4PR17MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f42f4c8-6f3d-48fe-41af-08dbda3658ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KiZwdTk5qmeOHP4bb/5GjtrjsSaZ15WbjX0zVCaozqe9NYe/WwgM2DINPq5JEeWwokDMB3cLgYvxQpOXjio+YTC+oLYQDBGoGdzKCdUxRCJY0nZ4V76tMMy8LG3+/+q7GWRGTjLLCMtVMv1qOqTQp81xXqJnwBSE4YjC0kri4bKnp3h+st+ZU5lRLN60kHXo2RaTTOCeo0JXjdoETlqI1sl/xgoPaqGZAICupBQzMKw/dOy64ZqzwJSC0UMP8mNSai78DQAU6gku0I5S81Nv7Yg/HxiiIATlM29e9H2/jSsGxwXKKc6jIdCUftwo4vZtGdFk8rqTzFuiONpfWbPImXRJIMue/NJcMHStYKV6TwNA+vRoNdfo2UMlcizJBOBCnB074e+ZQ9AgMjDrpdDvixS6f+C/tHpSh7fO3YkqBzox+72peXatxoYTb/or3Gy3mzDpOdf8WMvL3s3M1eEYFRxJTi/2WLqJH7411Jjmai7xquie9ckb5YfhjZx9cxf1LGx+T4dyE5YvKH2O0YjdtrVWEw1rgVG2XWbibjAtWGo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(39840400004)(396003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(8936002)(8676002)(44832011)(4326008)(2906002)(5660300002)(41300700001)(478600001)(6486002)(966005)(6916009)(316002)(66476007)(66946007)(66556008)(83380400001)(86362001)(36756003)(38100700002)(6666004)(6512007)(6506007)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HWF/MhTAsBhaxf8jkJvP3OcnO3J/jh5S84JcfExq9o7G47vhRP6NYRj4Cghm?=
 =?us-ascii?Q?uPp4MgP2Qkn+YxRC+Y8um7lxuy1LUd44DuAkj3P44Qm+UkLlxBzlD3w5FjEo?=
 =?us-ascii?Q?N+kIveB5vp7xpJBFJol8a0t7jIc6N1pRdLST4HDr5QKb89TrUDKYyUVh19B8?=
 =?us-ascii?Q?YnLnsoXXHDLypiDfCDSGkpc8RAI0pMjY5fqMSuwS7AfEiodjVWkWyVr6ala0?=
 =?us-ascii?Q?I+lA4+dULWggW/TRQcMNzS924YviuIFRywa+Gx7By9AEg4116tTaPo+JZc7o?=
 =?us-ascii?Q?x8jMJOsicgMFFTXEAhtbqMWdEuSBcsYNgRfCNPFyk0679TPuS9ZlypCcvttd?=
 =?us-ascii?Q?p2FcW2zJYRZIInRDJDPC4F0Spv+RbtRbtSZcku+6gYtIfacdhJK4MSP/Z98v?=
 =?us-ascii?Q?tgHMaCwbr3o+XB0GZdot+ERdv8FWBokoivIZrwKf/iCoHkzRl/Oxdkl1bKv6?=
 =?us-ascii?Q?kIWpX0YgaL2rlVFvWJ0EW1g9mgeHfkfzu2U4sZ4aWTIM2M5izG4KpQyyZbA+?=
 =?us-ascii?Q?69gsBw8s9hBcYEe7Q9cqM7krxmozMpOrYfVzELsDRC2w/s0lgqStm4nZen7l?=
 =?us-ascii?Q?l1u79gEO2ZkwQkAkiymNBKtDwGnLUtokzmkSnHUqvS6Upvx2hVW4mGjqAPzD?=
 =?us-ascii?Q?Semu3vLiqqAvCygP7jpucfkfcRRmcojMaUIfUYSEA7NYc6d/3MEmpqyN0K2M?=
 =?us-ascii?Q?g+ZF2UWuOHumLoS3xyxTLzN/jHOqMgIg4iILvlHQaeegssI2o5GZ49SPzMwF?=
 =?us-ascii?Q?/RjTpDMdDuaXDPKLhGIPPqHmC1Z/CO2jkke9FwlBiDjgiqm+9tNOzTwb4/+4?=
 =?us-ascii?Q?CIuyLtbe/jKwGLME50fHmNlStdb03tzouL7JgEhySo5t6LnCUGF5XREWD2JJ?=
 =?us-ascii?Q?vD8JiF/P1I4vFEmtjOKTCWotaXyXbgoOWAKpkgY0UBxrQEGi90ZlquTHg8ET?=
 =?us-ascii?Q?HHcIKL17yPzn9LhRYqF8TcBbSzTVxo6jvZHn9BtoQW9mq/iWDQZE3Ze3Yff+?=
 =?us-ascii?Q?EB/aAOlXSFmELtISyyj99gWSwzrVYt81/E6J+9vLGkEQMNd3mEhjsHu61bcp?=
 =?us-ascii?Q?XcFpbAoYw8LbgHIr3m8gc3RtEW1D+p0vHkCvJwi4RY4PR/gaxenq+7cxXMCj?=
 =?us-ascii?Q?+6EA+PxUdQfuWHgfeMu5SKn3xVeAUiIwlO3enRTMmMoVnSHFqS0pj4GUnR27?=
 =?us-ascii?Q?RS+LCYDx7fqyUPsbaPx/xo6CWD820qawtKKBc48y+cRVSFphfL8T4UKQKTek?=
 =?us-ascii?Q?GeC5B4zgeCDjyY1hXn2MHxeSnP+1si1+muBsbJbW4+cq1F4AnMgliY0XN44j?=
 =?us-ascii?Q?yQtkaDhzyS+1OHa0xx9L2zniP5yR7j2gylP5nCghjeyxeppTBxE4COBb3ICb?=
 =?us-ascii?Q?k5237Xg0Vf4DbQmzXwrF1VVNWsi+GeCkNxBTz+vjwP8JAHJoFhhh7vet8CPr?=
 =?us-ascii?Q?sveeB978XsYn7yQgh4BoEEPU9aNDXxeQC1ypEiMb23plFzwk0GGw3mqOMrdg?=
 =?us-ascii?Q?CFKzMo/BO7J2e7Otfvu0ICd13yVbkThIzpr8mhz/bnQMJqf2r2XUfBZI7Ozc?=
 =?us-ascii?Q?wY6ulLhC8BfkhDqsYlljjtpAPyvN6GKYmKR+l/Kk8AQ7Ddsre40yoCdmWrVb?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f42f4c8-6f3d-48fe-41af-08dbda3658ba
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 17:25:15.7004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyP3/aKshjNQWvJwG6pIOaI6Phjb3eagZFNtg2Gl+szzehWsir5rIUsM1BQHSP0t7tGCQp9negCVV/RRiQhWXplfuDleXkdMSCTpNyFAQVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR17MB6245
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 07:03:17AM +0100, Greg KH wrote:
> On Mon, Oct 30, 2023 at 12:42:39AM -0400, Gregory Price wrote:
> > The current code registers the node as available in the node array
> > before initializing the accessor list.  This makes it so that
> > anything which might access the accessor list as a result of
> > allocations will cause an undefined memory access.
> > 
> > In one example, an extension to access hmat data during interleave
> > caused this undefined access as a result of a bulk allocation
> > that occurs during node initialization but before the accessor
> > list is initialized.
> 
> Is this an in-kernel driver that causes this problem?
> 

I discovered this why testing an RFC:
https://lore.kernel.org/linux-mm/ZUCCoCRS3cohf9OE@memverge.com/T/#t

However I noticed that there are two exposed interfaces which may
allow a caller to hit the unitialized accessor list.  I haven't
explicitly demonstrated this, though.

1) register_memory_node_under_compute_node
2) node_set_perf_attrs

Since `register_node` calls into device_register and inevitably hits
allocators, it seems like fully initializing the node struct before
going off into the aether was appropriate.

> > 
> > Initialize the accessor list before making the node generally
> > available to the global system.
> > 
> > Signed-off-by: Gregory Price <gregory.price@memverge.com>
> 
> What commit id does this fix?
>

Sorry:
Fixes: 08d9dbe72b1f ("node: Link memory nodes to their compute nodes")

> thanks,
> 
> greg k-h
