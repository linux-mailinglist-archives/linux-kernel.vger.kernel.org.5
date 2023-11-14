Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829B07EB0B0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjKNNRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjKNNRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:17:08 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417A1F1;
        Tue, 14 Nov 2023 05:17:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGFWxz0bh0t4IWwZxB+ld9cI7DygkGbfoeTXG4ZbnaSVbVDynY2hhP9Cya3l2K9TkLWMrQGPkU6cWRAhPVyXOBAI+Zkr/KfJPCmSiaRQvWyXU16GLF5df2Vu7+ARIQJfRX5bToT9d+wUbYiPnCXtDSCxPG5dcP46Xww8ud/sRb1EKHyhOxUOEmkSZjsRG7B88NO+Lq+8Jj604m0OryuGVA4i/7/yYLGh1h2hmhNqs1jiSvv+WnbLRu8YCisAcFXMc+Ud/Yv1voI0t1O7HQAwEiLh44CltjumMO8svooa/+pywYHrpsoDISa8djXa93oUy2/6QUTO+jIT6vXbmCI7OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKySM8axderqUF36ppd/y9BLQ+m9RHxr8QQ+Iu3DPjg=;
 b=QJ14X6b64L01Zw/AoAhXD3CMgzpiyii4350cq5tJoLT9RIxUf9xBkTfZkn5GDNx9erV8z0GwjjdVxMxhDoJ2kxoZEFaZKngUWMyqxJXXjJ0lbxFqhrDfRwwtLjzPo/sFZL03reVsUo9qdqIlNpCtCqsMM0tD85eRxHfn978raLhY2uTmwVx6lc1Ayd4I9IjRGr1y+UlFmF9au3LsW7n9bYLTuKY9sKjLlte44bVE/xlNM4kfuVr/KI/jhDkGkS+5GaQ1QQ4gtAf4BXRgkEz/uJYOq37P5E/H/wSKohaY5E/yshFjVQJzTxt4UOD+NuTt4AS9tQ82CMnHwTl5fqExSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKySM8axderqUF36ppd/y9BLQ+m9RHxr8QQ+Iu3DPjg=;
 b=Jp+lSLB+viRnwHUEhjUwY0DEgaUrRINR8IrjgVBw/rtjYfb5iTb7uUC85pwf6b0Kuv4fJBIvBzgoQ3Q/CFzF7v/AcxBxgjgpJE/c+lYLZRfQvjePWC/GP53b0uvDurdm+zjYfJZ/7M+0qP4Km+wQplj9ZzmUw1OlrzUSCkDLLEMmTA0QiNR0Kiwhw9UmOA6PqZmbH3wI0F7f1oqA38MF6AnOQnFmsGZz1R7Pa+gu2yU098H+D3hfwoiYYJvb8giCh6gBg5iBXdb5sJ/3yicvj1A9ChlenCRRFsHyq88KKzyKnHt9Db+Rz+TnIs0XLUfNNBxLz3CHJ0WFXJruHQr2vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7332.namprd12.prod.outlook.com (2603:10b6:510:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 13:16:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 13:16:59 +0000
Date:   Tue, 14 Nov 2023 09:16:59 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
Message-ID: <ZVNzS2EA4zQRwIQ7@nvidia.com>
References: <20231113130041.58124-1-linyunsheng@huawei.com>
 <20231113130041.58124-4-linyunsheng@huawei.com>
 <CAHS8izMjmj0DRT_vjzVq5HMQyXtZdVK=o4OP0gzbaN=aJdQ3ig@mail.gmail.com>
 <20231113180554.1d1c6b1a@kernel.org>
 <0c39bd57-5d67-3255-9da2-3f3194ee5a66@huawei.com>
 <CAHS8izNxkqiNbTA1y+BjQPAber4Dks3zVFNYo4Bnwc=0JLustA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izNxkqiNbTA1y+BjQPAber4Dks3zVFNYo4Bnwc=0JLustA@mail.gmail.com>
X-ClientProxiedBy: MN2PR17CA0025.namprd17.prod.outlook.com
 (2603:10b6:208:15e::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 681df35d-21cb-4515-29c4-08dbe513fbcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rEy8aSB8TXyTbKzTbMlCGN73MVMwLcoHi6MEzRsV6AfbxC86c8XX43QrqDx7E8cdBZYCfzU+21pV6DPPEj/t06E75pcW2Iwxzc8CN440/JBtn0YOgMSo/4pUL3y/GpLLtn0ktH6lSU+MryNAem2BH8gn11UO5Rr8oC96dakbeYZNUFikV4/tS4AU2vg1A8rS3JSpCILRgICIduoM1mToksd8GN3BASn29KtzvWtDYdtYPinioPjTXk4F6DtUa0XOMl/bozklE6KTMAFRguFI5AdrC7IOXlJjdDvUmKL7WNwjZr+pRFScjB+nABUNbJhIM+4V8cZSqY9gKj8MFdszIqauks/ppuDefeEXqO+w1TtUkwescwiSSVBUDXbpyx7wjGTc2ZZ8Lr4TJw9eJbFENNrzLpWIRbeFIqwAlqKx1qDy14cmsN6nLRnppAWREBw1z2OnU+5IWUVLDP4PsKqExMEhwW1ipGZkUtRuRKLUoImpRVDXdRsdet/7aPP5vzeChvC7tRK2Tnul3817J4CFXJ16lQ4ApmGLYpiIORjAevxJ+lA71Ak5MGtsxMw2xf5q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(396003)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6486002)(478600001)(36756003)(6506007)(6916009)(316002)(54906003)(6512007)(66946007)(66556008)(66476007)(38100700002)(41300700001)(8676002)(4326008)(8936002)(5660300002)(86362001)(2616005)(7416002)(2906002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LMyTwaf15arbkFLhMC8Wq0aiG83PmhT1GNLksFTQDHKle3LlhuGfoGxAUFk5?=
 =?us-ascii?Q?ftexRSwWX+Gy5DI90LS6YiBB1zHeDSRC5R2R1wTwsiO/0qDQs0mQwQYr2shx?=
 =?us-ascii?Q?KCq16FCQZLq0FZ2AGzzr1MZTE1DFNukhubq0VrVxQ/OS/c/5Hu/AWJYvMOCG?=
 =?us-ascii?Q?OmGXQp7f+PhleQJyx/Sy8Q2rVtmsubxBX8/HrlS4GOb3FrAdsS/2DZSOSLy4?=
 =?us-ascii?Q?csIJ9qNKTSLwQBQUwIlcQ8Su+CKLP0JNkLb+RyDfiQglzx9s27EuHhCkbNXb?=
 =?us-ascii?Q?RI1FjWozhmRHF4uHN8E+P/OiJ0TqPUrX6qlbCRrWb3OfHbWf3G8WZa21Zp50?=
 =?us-ascii?Q?ZW0Jqbt8KvEaQqjdvmp70nbR/w2791rh/IPiy6u+N/kVbVobdper70hdSEC9?=
 =?us-ascii?Q?EdLhh0GmdOjOB8+knbi1Sqgiynme2R1h09eYibX3A/5duKrM/LwBPjpEUgeC?=
 =?us-ascii?Q?K02Otwa2rngMicqGBSt5wa27MiC+Xs37ZnMKCilQ34gNdIpR7JfIhjHH7LrI?=
 =?us-ascii?Q?GgYPBdQjSLIua1frzhB4oIeXnDJ6tCHsgOmzr5CHFIe45fNZoTW0IOwunMbI?=
 =?us-ascii?Q?kkkZFgo2pwB6wLzQTtxMDhopjLJqDVcC4g0XTn//M0yutXpNqH7n4X7suZUx?=
 =?us-ascii?Q?rTDwN6QfyeCSpTJMuQIOlqncrYYGnpV20nM6TvXHKsbBoWusoSVk5MYSEwQZ?=
 =?us-ascii?Q?KGojnEEI1de1/JIZ2I8VLkw/3RcYwbeeSNztOOtSU+B4mmucRmRmgJC9escF?=
 =?us-ascii?Q?/qF/U3HQRM8xMFu8E1J94ReZHCOSObP0ENks4iDzoeKAUXk2TLg4Ku+8BBrI?=
 =?us-ascii?Q?lWRoqSpl3aOOmcZvYsnhgYsoJVxQfq5A/uMfKEaVhF///ox01wfsMdPnEWr4?=
 =?us-ascii?Q?7J2EAcZMNTgCzPtz/9pJ62/hJQvDqo3vVJc+xgvrv2GnSgCa6SOolwOiXwiI?=
 =?us-ascii?Q?zlm+tEpWdA3dj1WJJ8waa7nhUC62RbOEwb4Y+WIuhBhQ42CAxIcpldmeQwE4?=
 =?us-ascii?Q?0GM8ca050SSdquBFdsFuOrIaH9OtJN3iM/6gQl2TcpU/vMICqr2sStavBH+z?=
 =?us-ascii?Q?DWlVRJ0exLX3rHtcvCX3mqUTvUbD9Z5Wu8dCkO1rlqlwUJOk2eNy2RRiRfM4?=
 =?us-ascii?Q?SHnXd1/7WSm/JPXdWTiXNeX2nkUOFAlhquiJBZf9nq5qBgzEv392fifm4ROf?=
 =?us-ascii?Q?y9bKco8MjxXK7HQDc1SPmzPT+eGVFuMc1IAsTYkpINHlvaI9cpKXbrO4TVIG?=
 =?us-ascii?Q?nxM9N9dj9WGnEimPdK4/5ENYc8SdyxCXF6WyRNBc/PS3oFWqymv+cek7Jv1X?=
 =?us-ascii?Q?Wfw6Qm0hQeYeRMCNW4eBhLNs+Gn7YuDSZ7mOkMbeA7V7wVhXDcjYA5sMzPjA?=
 =?us-ascii?Q?BQJi9fvg2OqhUBKQyBvWLzNgZ1zIWEJnX78eORGD2808t/sYdPJu08LyPfDg?=
 =?us-ascii?Q?72iYBzAPsY83B78S4tbcrrpNpfEpumFwWXIU1q+XITSVtmvQPL8Yp15GhZZm?=
 =?us-ascii?Q?TiduvGIHVGRx+SDzRdAXj9rX94MDbdwDDg6KdbcAyfGz71GeMEFMrwxW04Wk?=
 =?us-ascii?Q?wqq7G2BZETn3GE3SduM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 681df35d-21cb-4515-29c4-08dbe513fbcc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 13:16:59.5803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qN8X/KasZ+/UrECFUunJt3TNALDiC+2J5oQm6t2kA7qRt+wAKc1FFrA/qB6ZMs8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7332
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 04:21:26AM -0800, Mina Almasry wrote:

> Actually because you put the 'strtuct page for devmem' in
> skb->bv_frag, the net stack will grab the 'struct page' for devmem
> using skb_frag_page() then call things like page_address(), kmap,
> get_page, put_page, etc, etc, etc.

Yikes, please no. If net has its own struct page look alike it has to
stay entirely inside net. A non-mm owned struct page should not be
passed into mm calls. It is just way too hacky to be seriously
considered :(

> > I would expect net stack, page pool, driver still see the 'struct page',
> > only memory provider see the specific struct for itself, for the above,
> > devmem memory provider sees the 'struct page_pool_iov'.
> >
> > The reason I still expect driver to see the 'struct page' is that driver
> > will still need to support normal memory besides devmem.

I wouldn't say this approach is unreasonable, but it does have to be
done carefully to isolate the mm. Keeping the struct page in the API
is going to make this very hard.

Jason
