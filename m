Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7A38088E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjLGNJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjLGNJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:09:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2070610CC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:09:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39501C433C8;
        Thu,  7 Dec 2023 13:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701954576;
        bh=48aLS5I+TtNzeyW6P7Yexq+zuarJ1sJ5BXyuvMLL6Zw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KCdmiMr/0tb8P5XITPQcLvjetDTInc5Fb0xC9CcgdC9zNirWR5iZw08onnLnnJv+h
         yjsCNSAXbqnlxGx18iIdvspyjHB/STA8dxNOjt2tEts7pNr8OwhQvjktCjnFLLSeIg
         BHXGbDDeihIhsNLZDhAcYuhiTFHjGvwTlwsvun0EUXLb2x09lRjWVk9fOLbgamCefn
         xQ7NR7IZE7nCrIfEDEAFi54AET26S4i2eakq3OfxKVtbLnBOD+EZPBO+Zue4fCzHRH
         mqW/oBfTXbfTVHvzvAT8i0pztm+WFijYEgIBiC6xEt+m3ydOrHDtBlirpzexKsEKZh
         J4MQJzB0NKmdw==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231207114231.2872104-1-huangjunxian6@hisilicon.com>
References: <20231207114231.2872104-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH v2 for-next 0/5] Bugfixes and improvements for hns RoCE
Message-Id: <170195457200.56392.17516506336430835094.b4-ty@kernel.org>
Date:   Thu, 07 Dec 2023 15:09:32 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 07 Dec 2023 19:42:26 +0800, Junxian Huang wrote:
> Here are several bugfixes and improvements for hns RoCE.
> 
> v1 -> v2:
> * Change applying target from -rc to -next
> * Drop patch #6 in v1
> 
> Chengchang Tang (3):
>   RDMA/hns: Rename the interrupts
>   RDMA/hns: Remove unnecessary checks for NULL in mtr_alloc_bufs()
>   RDMA/hns: Fix memory leak in free_mr_init()
> 
> [...]

Applied, thanks!

[1/5] RDMA/hns: Rename the interrupts
      https://git.kernel.org/rdma/rdma/c/95f6b40082aaf3
[2/5] RDMA/hns: Response dmac to userspace
      https://git.kernel.org/rdma/rdma/c/d3f4020a213e1c
[3/5] RDMA/hns: Add a max length of gid table
      https://git.kernel.org/rdma/rdma/c/7243396aaf1238
[4/5] RDMA/hns: Remove unnecessary checks for NULL in mtr_alloc_bufs()
      https://git.kernel.org/rdma/rdma/c/f31683a5227b1a
[5/5] RDMA/hns: Fix memory leak in free_mr_init()
      https://git.kernel.org/rdma/rdma/c/288f535951aa81

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
