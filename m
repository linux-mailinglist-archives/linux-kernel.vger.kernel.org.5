Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651FE8036A9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbjLDO3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbjLDO3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:29:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54ED1FFB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:24:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D96AC433C9;
        Mon,  4 Dec 2023 14:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701699892;
        bh=lQIIqL2wdZXrciPp+cezt3cQcrkR+8je2L8ls5BrqDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ay0U0EyNA+fLdFj/tl8A4T2d0kg+1CGshBUaBla4+FH0wGGyMdR6gaqK4PmnUKLJf
         /0z1tpzD6y5JjsbSWV5+0Gu14nawZS5LnR3ZDB5bQZc7w51mMZRyOSeWu5atLqtfwh
         zaSxJ7czgbYB+h8aRpA0QkXWSMeoHrynNXpS7xD12fLo2hbY+deFPAdVsyqQ9MhUza
         xEvd2JKkyVp4veBmkiEFLcqfCGE9cM18TIlomprwD9urLmW3yB5q9YZDLDr3H1IJaG
         JewcM+N49DTrsmM846LRiMvKnwXWCkD4JAv3MUIPoSehnkgfAL/94MvYerlFrR3+Km
         qR2mavpcuamYA==
Date:   Mon, 4 Dec 2023 16:24:47 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-rc 0/6] Bugfixes and improvements for hns RoCE
Message-ID: <20231204142447.GB5136@unreal>
References: <20231129094434.134528-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231129094434.134528-1-huangjunxian6@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 05:44:28PM +0800, Junxian Huang wrote:
> Here are several bugfixes and improvements for hns RoCE.
> 
> Chengchang Tang (4):
>   RDMA/hns: Rename the interrupts
>   RDMA/hns: Remove unnecessary checks for NULL in mtr_alloc_bufs()
>   RDMA/hns: Fix memory leak in free_mr_init()
>   RDMA/hns: Improve the readability of free mr uninit

1. The series doesn't apply.
➜  kernel git:(wip/leon-for-next) ~/src/b4/b4.sh shazam -l -s https://lore.kernel.org/all/20231129094434.134528-1-huangjunxian6@hisilicon.com -P 1-5
2. Please drop patch #6 as you are deleting the code which you added in
first patches without actual gain.

Thanks

> 
> Junxian Huang (2):
>   RDMA/hns: Response dmac to userspace
>   RDMA/hns: Add a max length of gid table
> 
>  drivers/infiniband/hw/hns/hns_roce_ah.c    |  7 ++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 87 +++++++++++++++-------
>  drivers/infiniband/hw/hns/hns_roce_mr.c    |  2 +-
>  include/uapi/rdma/hns-abi.h                |  5 ++
>  4 files changed, 73 insertions(+), 28 deletions(-)
> 
> --
> 2.30.0
> 
> 
