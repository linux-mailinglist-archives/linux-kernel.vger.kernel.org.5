Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DC4801AE4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 06:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjLBFTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 00:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLBFTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 00:19:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D39B123
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 21:19:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0BBC433C8;
        Sat,  2 Dec 2023 05:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701494368;
        bh=8jxISvQ5wiTf3w6KBQZeRqJTOGvH0KRxM2w8b45bfMA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Iyejulx5+mDAzZyu8k24nmTJNMPk5Jxx1kk4pBT2LJlmyZgxGil1tGXpjbSgwCK02
         rCIoNsXhMl/RJJ0zaa4hjJzLtDZ4u4Ru5htP7OVow0Ucr+c3soW9Kpfzh49rKkWN7U
         JaKRfv6e5TK4mvdaOGF3AEWqio3jdvltcKZlCEm/AyJ2vqqa7oKSxWc4UpBCIBcs/O
         AH7Kyw112jFpF4d4dZg4G2CworjT0m6T64BggAN/FMTUtkeoZtWqfHZYKQP4PATe8N
         nuiGTEIM8WMnzjR4aw2p75M080by+9Qg3h+uMcXJtiocqyP7O4EHgdlKM9UQ8rw6Wy
         fkwYy5rWxEnGQ==
Date:   Fri, 1 Dec 2023 21:19:26 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/2] net: hns: fix fake link up on xge port
Message-ID: <20231201211926.3807dd7f@kernel.org>
In-Reply-To: <20231201102703.4134592-3-shaojijie@huawei.com>
References: <20231201102703.4134592-1-shaojijie@huawei.com>
        <20231201102703.4134592-3-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2023 18:27:03 +0800 Jijie Shao wrote:
> +void hns_mac_link_anti_shake(struct mac_driver *mac_ctrl_drv, u32 *link_status)

drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c:69:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   69 | void hns_mac_link_anti_shake(struct mac_driver *mac_ctrl_drv, u32 *link_status)
      | ^
      | static 

-- 
pw-bot: cr
