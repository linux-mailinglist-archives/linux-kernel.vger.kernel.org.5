Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58167A3121
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 17:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbjIPPeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 11:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239417AbjIPPe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 11:34:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE62BCE8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 08:34:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3217BC433C7;
        Sat, 16 Sep 2023 15:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694878459;
        bh=RdDZPLFEo/rep3G/EYR6iQccvFHq02ff6Uft8SoULpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fRV5fOA5i/oiztva45eZ94ZEA0D3UIS0T+UqpJ6uIsRHFSlGPpGy3byGJQIMua+rp
         b7RmMzyimhWgDo/JhPx5S5WVRyK5/8CXkTKnER/NyeHYl8p+JiP5mLUV52L9NGHsoz
         cil37iOIsJs/iKTGTJcOQixj7zPHmt6ZtCJ8Nec6dirQXV3G7Glvos35VOuKvFv0Lz
         R5iWfrXjB8opxqnuvEfVAw7g1J5gyq8efsZiD57GG0RSjWeJQmwvAt9FtcPqN7kjG6
         P26Txzp58GOxQfxcngWYznW4ktfjS/i/PofTI3EXLrbrwl0IbHLQxKf1Ly7g75ISrp
         JLnbbghPvcUEA==
Date:   Sat, 16 Sep 2023 17:34:15 +0200
From:   Simon Horman <horms@kernel.org>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/5] net: hns3: add cmdq check for vf periodic
 service task
Message-ID: <20230916153415.GF1125562@kernel.org>
References: <20230915095305.422328-1-shaojijie@huawei.com>
 <20230915095305.422328-2-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915095305.422328-2-shaojijie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 05:53:01PM +0800, Jijie Shao wrote:
> From: Jie Wang <wangjie125@huawei.com>
> 
> When the vf cmdq is disabled, there is no need to keep these task running.
> So this patch skip these task when the cmdq is disabled.
> 
> Signed-off-by: Jie Wang <wangjie125@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Hi Jinjie Shao,

if this is a fix then it's probably appropriate to include a Fixes tag.
