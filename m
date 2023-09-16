Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396987A311E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 17:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239171AbjIPPbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 11:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238134AbjIPPbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 11:31:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C52CE8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 08:31:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C61C433C8;
        Sat, 16 Sep 2023 15:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694878271;
        bh=bwbdn6mceJx6nwNkmrcHaUUVzKQ7uA631d88CdeBgX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=efIRaBcuNeqRcMDsP8VUYJsZFR5VXy9Jakyd1yGl3ICbfrUfsFd6/cZMWpdS6GeGz
         l+NtKd1WNg3Sz5vu4wYduVD8YAfKhW0RSwvwKgSk0hju6387fIzPfl199oYZgxy30+
         bmiHwQPSbz4r7reLlATaWrZndzMU688JfQFpytZXkvReXrIRw/xkQxgWheCZCaQSET
         /L4rMmnIAMOynBR2xo1TM27IKwcIJwgXxFxnjY+SgxP2HyD5WZx3IQruh3nUhOU0NP
         z8itMWZswbbI/zbKVG5yLJ+JjamlYAxd3r1ZwR7tFJOykc/e3Dyj/QsTGpgzRx7Wjm
         2BvVXOtdIsOpA==
Date:   Sat, 16 Sep 2023 17:31:06 +0200
From:   Simon Horman <horms@kernel.org>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 5/5] net: hns3: add 5ms delay before clear firmware
 reset irq source
Message-ID: <20230916153106.GE1125562@kernel.org>
References: <20230915095305.422328-1-shaojijie@huawei.com>
 <20230915095305.422328-6-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915095305.422328-6-shaojijie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 05:53:05PM +0800, Jijie Shao wrote:
> From: Jie Wang <wangjie125@huawei.com>
> 
> Currently the reset process in hns3 and firmware watchdog init process is
> asynchronous. we think firmware watchdog initialization is completed
> before hns3 clear the firmware interrupt source. However, firmware
> initialization may not complete early.
> 
> so we add delay before hns3 clear firmware interrupt source and 5 ms delay
> is enough to avoid second firmware reset interrupt.
> 
> Signed-off-by: Jie Wang <wangjie125@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Hi Jijie Shao,

is it appropriate to add the following tag?

Fixes: c1a81619d73a ("net: hns3: Add mailbox interrupt handling to PF driver")
