Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1079880725B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378923AbjLFO1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378885AbjLFO07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:26:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9E81A2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:27:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA92C433C7;
        Wed,  6 Dec 2023 14:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701872825;
        bh=gZmkfp/8EvEecsWevDjlZmPAEEatR59FqduEUvnfoxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OAyPGFsc/VqFh/b5manPEhp5W+bdj0jUtVNddzkQWhQqvBRorF2zU2aKDujv8tBuV
         zBSURisuX7LzEUSOtHCkLE07gNwnFC1RLKZJTyIPI2BEr7z6ykzzc413hN/gghBdGj
         faLJGSUX1lAo4iMETiD5K8f1Sp3Up+ZeEuK5ava7fG59Am3cP45xw49U8BLolYUWX6
         G29JgTlwQ7LHBlHqagvfCkYYPcTqVCrurabrGrlyeX9Vd8tCYfl+lwAMWGp7y/aDiv
         LwXWCv/RMjYhyADqyZmKfGnbJe/igUASfg6KhudqZmkoz2mpIlDbA5LTQeq63ncJZP
         Jq2/sIaxl9XaA==
Date:   Wed, 6 Dec 2023 16:27:00 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-rc 0/6] Bugfixes and improvements for hns RoCE
Message-ID: <20231206142700.GA18960@unreal>
References: <20231129094434.134528-1-huangjunxian6@hisilicon.com>
 <20231204142447.GB5136@unreal>
 <d8a453b1-c77d-71b3-72cc-eaac51ef8cb8@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8a453b1-c77d-71b3-72cc-eaac51ef8cb8@hisilicon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 10:05:46AM +0800, Junxian Huang wrote:
> 
> 
> On 2023/12/4 22:24, Leon Romanovsky wrote:
> > On Wed, Nov 29, 2023 at 05:44:28PM +0800, Junxian Huang wrote:
> >> Here are several bugfixes and improvements for hns RoCE.
> >>
> >> Chengchang Tang (4):
> >>   RDMA/hns: Rename the interrupts
> >>   RDMA/hns: Remove unnecessary checks for NULL in mtr_alloc_bufs()
> >>   RDMA/hns: Fix memory leak in free_mr_init()
> >>   RDMA/hns: Improve the readability of free mr uninit
> > 
> > 1. The series doesn't apply.
> > ➜  kernel git:(wip/leon-for-next) ~/src/b4/b4.sh shazam -l -s https://lore.kernel.org/all/20231129094434.134528-1-huangjunxian6@hisilicon.com -P 1-5
> 
> Is this series going to be applied to -next?

Yes, I planned to apply them to -next, they don't really important Fixes for -rc4.

> 
> > 2. Please drop patch #6 as you are deleting the code which you added in
> > first patches without actual gain.
> 
> Is it better to drop it directly or merge it with the previous patch?

Please drop.

> 
> Thanks,
> Junxian
> 
> > 
> > Thanks
> > 
> >>
> >> Junxian Huang (2):
> >>   RDMA/hns: Response dmac to userspace
> >>   RDMA/hns: Add a max length of gid table
> >>
> >>  drivers/infiniband/hw/hns/hns_roce_ah.c    |  7 ++
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 87 +++++++++++++++-------
> >>  drivers/infiniband/hw/hns/hns_roce_mr.c    |  2 +-
> >>  include/uapi/rdma/hns-abi.h                |  5 ++
> >>  4 files changed, 73 insertions(+), 28 deletions(-)
> >>
> >> --
> >> 2.30.0
> >>
> >>
> > 
