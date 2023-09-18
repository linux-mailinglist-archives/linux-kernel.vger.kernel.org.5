Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136FE7A4639
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240993AbjIRJmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240912AbjIRJmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:42:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CDDE56;
        Mon, 18 Sep 2023 02:40:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1BCBC433CA;
        Mon, 18 Sep 2023 09:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695030022;
        bh=uRfOQOB0II5sP8GPpDWkYX/vEwWZ4Q9wf7azPLUxnI8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=W+/CFp1VkUNvrkW4WOXwUNjeLGGda4LOtdSOhfnYStHDdLVlHuZgUtGJ6PmPrATSn
         s28+YAtvisNIxRfYRakr/TdDBQfPOITm9eY2KLuKlhFf7fRLLzxAzCpIU8BVq4gMlA
         2m5g/NqQxmPK2TaBf3uef6ajyji2hvUJpAgnrzw42gtp6JqVnPPfl/n6qfFIe1v+z/
         rOdSMU1EGbXcYtaU2Arp8vi41mRQEEuUBclAnxxeff6oAvSXhlA1PyrTDKyEWfLYBV
         IvBBO6M0C/3vulS+/41rNhmTpdXm3y0oi6nheA43JyCMotdTmfRmL0g+5Rzr/Mhuus
         +MIjX3Y5F4oiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C78EBE11F41;
        Mon, 18 Sep 2023 09:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ceph: Annotate struct ceph_monmap with __counted_by
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169503002181.24344.5873701629214587241.git-patchwork-notify@kernel.org>
Date:   Mon, 18 Sep 2023 09:40:21 +0000
References: <20230915201510.never.365-kees@kernel.org>
In-Reply-To: <20230915201510.never.365-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     idryomov@gmail.com, xiubli@redhat.com, jlayton@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ceph-devel@vger.kernel.org,
        netdev@vger.kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 15 Sep 2023 13:15:10 -0700 you wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ceph_monmap.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [...]

Here is the summary with links:
  - ceph: Annotate struct ceph_monmap with __counted_by
    https://git.kernel.org/netdev/net-next/c/1cb6422ecac8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


