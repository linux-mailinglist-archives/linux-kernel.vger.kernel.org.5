Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D799F7F3A70
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbjKUXqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjKUXqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:46:42 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20405194
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:46:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6fUwabp3FXu0Uqan8JEwoKA29ONh3YZ076ZdjD9pqXJRnG/kNeVPAzL03tbT4x1KY3DWdbAEsLDtjM+mXXyLc/l4MGAZzyj2aCpAqAN69OriwoNwGbut9qMU+4C2pEhe9wu4UWFqZbjLsKFxln1iiwA2J+GPVEYixa6S3NKm+ZN4hxv6ar/opASt5Qf2F6rD6vXH7czHDKyjG54E2nIQQbb252Uud5Fu3jntJyjtSKvdkaGS3OS8Ujpec8vP2dPNWjwsgjYu9SYeB77FzuXeXnw6KVPpZPMRn+GMotoIC471Evs3RUYpfI2E+C5Sf54farG9S7Q3DU5mkkpG0xB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vb+e4R2iyWbxNjzuoU6jrU+1nzNKIiGgZngLJ/gO7ko=;
 b=O+BzE4ci1939PuiPuTb/GGqda8H1dB3wjkmwed29AJ8d3Va2hQJKKKYE3uyW1q8dmbqP4gL9Ar0MTwJSzMB7SMpAjELkSqRfUcu482wcIoHWWL61dKt2dhmKfHEld4ZSNILN/wOUnKMiV19XtI4pBQ8X3S1R5OoQLkThDGCk8M2uLjR0EzssX/2Ao/94QvxBi3K289pSwTdOjVTwnzoXs06d855Q7KXEDrl7Z6YEQUuMt6q+s4dha4pl2ido8aoQhLiAY5Oxr6CQkmkaQQwhiXc8q6gEggO/ijgUxI3zL1So4QTItJOcPmus1wHlGMffcBTaGk616Q+WXdTb9BT6/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vb+e4R2iyWbxNjzuoU6jrU+1nzNKIiGgZngLJ/gO7ko=;
 b=ln/3D+5Z2CVOQPCbX99l9vn2bQWftFq+MrUmxngInQKZhFsP+M4vOzy7Wmwd8abJ+Rn3R3KJ/+eywGfM1U4U3VcUO5f7ZrArm/XIHhSEuYb5qo57GS92EQSIyMtdcJ1sX7YZ+XjmFkm8EWhgrvzCwFO1oKxlr0qW2skRGpx0kEnBpOpLlvLPqNdMDnbJt4u9+96yNipjBMuY0/vGkeit5PS0rxpthw7+n+r1RKGDJ/OAXpXNlqqH1YiOsP+qoc+JzmP55bZzdBRgq2rwzY+vgxAyHs7thHLxd6DSqg3HR/n+AZDDzdgcz1Ynl9ozJezN4LZ2grzRU5qKVt7JWMySOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4895.namprd12.prod.outlook.com (2603:10b6:5:1bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Tue, 21 Nov
 2023 23:46:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 23:46:32 +0000
Date:   Tue, 21 Nov 2023 19:46:30 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 5/5] misc: mlx5ctl: Add umem reg/unreg ioctl
Message-ID: <20231121234630.GJ6083@nvidia.com>
References: <20231121070619.9836-1-saeed@kernel.org>
 <20231121070619.9836-6-saeed@kernel.org>
 <20231121124456.7a6388c6@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121124456.7a6388c6@kernel.org>
X-ClientProxiedBy: DM6PR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:5:174::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f49ff2-e82e-4ff6-02db-08dbeaec16d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1OEBEJuYHpSBk1WpE/defiS1Ed3m1kOvUNKoTsviOlj2It82KWCF0II9zvxRqFQ0KFLxW51nV0cDOJQC2bZO0XQmjU2f9YW/OaPFoHBDfrsjPKsWZCq1+io4LSwIiTKVc+DPu6+spQ6O7mP2pGm8i5Z+rOtyZinVelYfPkDDqic43qpG+2U7bHTobUzzwAGZcXkKr9Noxw+rzAzVZC61lW7y/2JBrLyepR87OEQAk1fyu267jmir4KFH5YODKSPy6mBOMSr/LAanx7tWjudL3aIxueA3Heq4ybwePzTmHXfhmmc1JjBT78zCRd0f9YFPo/DMt8okRpEdLEBXLPxfCHUvHPPFkcFarBSLgqqqz3YmM3mzDKxfqgO/GZ7wS64hdmC6zNLZ0QvsbOcMk5/u0hlp1R4i6Byf7/KSCQbzAZapglkBbTJYpnBUU8C8qj6mFfZMc10/0eqMja7Qs9X5mI4RmznBo0tc7Da8XR/cYp366oRUwl9Dv5h2mVpf+/KJWAJl10EAAUOBmZqTbAYXe28yi9FMxmzaSE7w8b38WEEYhZJGd7x5ZAl0Y1/3o6TpJ4aJAHVSeTj2l6cQPXzi6/CpkfpPfbELFbkb4pfkwqA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2616005)(1076003)(107886003)(83380400001)(6506007)(6512007)(26005)(6486002)(478600001)(38100700002)(66946007)(4326008)(8936002)(8676002)(54906003)(66476007)(66556008)(316002)(6916009)(33656002)(86362001)(5660300002)(2906002)(41300700001)(36756003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tPOULwuh4LnXup1uFeoN5WGE3nQ4ux6MXXM/Dx8/2uVtpEBLYFnnVZbtH5fB?=
 =?us-ascii?Q?XHSNHywyZcR+NB2vPNvObDaHP2NFH4wPHdszl3iNgRzw3ytd9cYREaB8bgeY?=
 =?us-ascii?Q?zFjKdMszt39rUqoS8yerOywiASRSphy30nOj5ca5MS4nAltbCodxXmKnNDGR?=
 =?us-ascii?Q?Z8teK5axx1Z3VGXCPlCtJD+SOgJ/cGXb/CaCgqCsQm8uk3oY5rHr7400n+WC?=
 =?us-ascii?Q?bWQK82KpmGrEAEEcT4yUau40ltL2yXpRuEu0uqOwflQuBq882HylNQFOSeGr?=
 =?us-ascii?Q?rTowmVMo/quhlAbe665Zrs2R0UTNowF1kCEoLFeNhg9C21RMRzKlpM13nDNm?=
 =?us-ascii?Q?xXii/kVvkilRj5b2AuwETNTs6zgFQx0yfXf1aYcyY8beFOawoBmpUHBHuPoh?=
 =?us-ascii?Q?m1Oc/sJQJPgpmKGsStSaC0BGwzrccO68fcvU5QPvoRofSM11hGvt6EwR6EnV?=
 =?us-ascii?Q?e2eVa/PWU2ZCu0q/nGO9xlZIkRgzJyJSHnqnfN03iqXEU+Y4tPP4hfM3Hna5?=
 =?us-ascii?Q?oqZTRunBrSNYYgLt+P1iOm8TIxaVLo3ff6JOQlT8/2mrrjzxbbWcwJM3qI9L?=
 =?us-ascii?Q?feotJyWDl5oERbMAyk5JnQtZlyhW7P+LXRu318fjWkbAy5J/tkexss5Payfl?=
 =?us-ascii?Q?W5XORe8o9PBMCipTm1D0j8OgZoxdEOsO1N+U5PRzqJvni3lS8rUrpRl0nn99?=
 =?us-ascii?Q?8yRY5VXW4vNshejsYvAVZx234sEKIM/gMLkEGMnyxUKLuVhPoJebQ4oxtkrE?=
 =?us-ascii?Q?kLigfi3oJXnFh8jnaC9LKYjwLoe2loIHO4npJTeuplK+h/GGMwT0bH3pBLM+?=
 =?us-ascii?Q?q9SVNh5CbZe6iaIU902Zi/1m6hqKAkObAfRli9GCVTDsxB5z/v2EgXua6LO6?=
 =?us-ascii?Q?+9tplgBR9PP60zXx6W/B3ES/P853BsN1stUTJGFJ0o5SZJ613eTpIiTLbem8?=
 =?us-ascii?Q?xEVBqz7DHh+MdphsFELcsuV8GHWw0SqUuHLfQgsCT4T73wX/MTt5BlBY/ffu?=
 =?us-ascii?Q?NrFBqrXWUzOzqpH80IrqIx7Y+baZQgNRm4vzruWJC+ur/7teeGnvcaAySHGK?=
 =?us-ascii?Q?wVYWkeIL54aafR5m6Nk30wgbljXQH+k4NI16YT5W10LwIEuXcdlCwUbK71Tg?=
 =?us-ascii?Q?KDujY2l5/1sXam1N+IQsjb5TVGsLxFFBjwliJagu4K63D1XXhdqmL2sFismE?=
 =?us-ascii?Q?Itzp++ESV0GSkqNBgo2xdb7Nib+YdAc+pADeqcz0h3jH2XhUqmCtWslKj1a/?=
 =?us-ascii?Q?pLe3/1kAZkjMuVg+Akf0nF94tnm9ncRm240gThGSIEi9oQFuVcvH4CUF/qiw?=
 =?us-ascii?Q?0lBlpXqn0JbCxeR0fiAIZY7wh+LEhCNubT03HVIgno9FBTYK55Ot7tBY+lfW?=
 =?us-ascii?Q?UkJKmoidCf/F5qGTSOqb1BTUKcM7eo5+imYIzxdTGS18jyqD69Oj0gq7UVfF?=
 =?us-ascii?Q?qbk2/WPLdtjy+K6xRyutagsF0yxEpeHAIIL0/h8vKGJDl1G5RzwauHokez91?=
 =?us-ascii?Q?6hG/pqCNVl1zGfnYjYamDteVHhWP4RZ+JSa00TTzyjflQs6MmJAe5LsJvVQc?=
 =?us-ascii?Q?4JENPd6bMmbZP6KyJPw+5Tl1S9gl7JdkHf/FUed9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f49ff2-e82e-4ff6-02db-08dbeaec16d3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 23:46:32.0674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPPwVdo+ST8Xesn+Q+N7qBp8hwq5XEpZBmnf4ohbvJR4kxsvpT3KzsaTLIreJ5eL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4895
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 12:44:56PM -0800, Jakub Kicinski wrote:
> On Mon, 20 Nov 2023 23:06:19 -0800 Saeed Mahameed wrote:
> > high frequency diagnostic counters
> 
> So is it a debug driver or not a debug driver?

In the part you decided not to quote Saeed explained how the main
purpose of the generic DMA to userspace mechanism is to transfer FW
trace, FW memory copies and other large data dumps.

The thing with generic stuff is you can use it for lots of things if
you are so inclined. Saeed gave many examples. I think you took it in
the wrong way as I am not aware of any plan for actual high speed
netdev relavent counters in a performance monitor application. It
isn't that kind of "high speed".

The main interest is for micro-architectural debugging
information. The kind that are opaque unless you can reference the RTL
to understand what it means. It is "high speed" in the sense that
executing a FW command per register/counter would be offensively slow
compared to executing a FW command to bulk DMA a cluster of
micro-architecture registers/etc in the device.

The design is so generic because it is a debug interface that we want
to be always available and always fully functional. Mellanox ships new
FW and new chips at a rapid rate, we do not want to be changing the
kernel driver every time we do anything. That will never get
backported into production kernels across all our supported customers
fast enough. Debug features that a field support engineer cannot
access simply do not exist.

Debugs are challenging. mlx5 is the most popular datacenter NIC in the
world. We have so many insane problems, you wouldn't belive it. I just
spent 8 months leading a debug that turned out to be a qemu defect
(thanks Paolo for all the help!!). This debug data and flexibility is
critical to making these hugely complex systems work.

Jason
