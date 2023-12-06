Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E39807B6B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjLFWhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjLFWhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:37:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756A410C6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 14:37:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04672C433C7;
        Wed,  6 Dec 2023 22:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701902244;
        bh=SpHMtoBxIkmYrYXlggD/bi1zaqbK4AdCKk/C2BprrYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qW35m9mQvl/FxtFLb4vNeX3KAGURfIyLQFALthVHe3pChiNyjfjfmZezgHouAPoDA
         K2FLC+/OwqfM2goIgGuqWuXvu22A9VkKt1B3ZxsgDvo/SOww1F6vOF9UuBTYizK+Vu
         PKV8PqhoJ6SWA5jjs1xYc5nEyhwaZJvBndUVCYC4LrDs2g1oaMs5EPpBCE33e56Wgi
         j0wPZE4Se3xhKOPPFgLJW15egZLwnEJZWelNxeC9z4FTIM1ymwrOaUWtros2tsy2Wx
         9DBtKtBX6KcycNiL+sSWGBoP224WPg38w8PR7o+eZLH+QKLt2i+gJWaDLw0QT70Zn5
         +KFjh9f68sy2Q==
Date:   Wed, 6 Dec 2023 14:37:22 -0800
From:   Saeed Mahameed <saeed@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     saeedm@nvidia.com, leon@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] net/mlx5: DR, Use swap() instead of open coding it
Message-ID: <ZXD3orTxU0mxi5jH@x130>
References: <20231117071947.112856-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231117071947.112856-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Nov 15:19, Jiapeng Chong wrote:
>Swap is a function interface that provides exchange function. To avoid
>code duplication, we can use swap function.
>
>./drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c:1254:50-51: WARNING opportunity for swap().
>
>Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7580
>Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>---

applied to net-next-mlx5
-Saeed.
