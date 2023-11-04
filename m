Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0608F7E1064
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 18:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjKDQd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 12:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKDQd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 12:33:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA25FBD;
        Sat,  4 Nov 2023 09:33:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBC3C433C7;
        Sat,  4 Nov 2023 16:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699115635;
        bh=e4QQlFAxSGhj3jwYBmB3+pfSiYHMJrLFy6FKplzgwW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=InxKZ5rShROXQtrsH7Y9oylUaQBgmsjiCspRz/qGI3aMWFhvWSd7pnn75eIOQSMZP
         c/LtCMGgp+26G8S1hzQywotKV8ZN4gTaT6q8YVvjbBthxaHkFD0mRz95VrZQdRY/md
         umrBYKp0a927rK9UD3CgNIE4v3ZgCI4lvOwqYtr9A7CXR/VlXnkAhQp82DFlQ1KcQ/
         RpQbp0+dE+npW9+oZMBVBa9MZxfd4ED+gZH+7iLriorqoAimK7JCa58eRYYwlaVAJj
         fGRyAVrJglpHTUasqfIsZ5rtwqBSs6VD34bugv69pRP7Qw1nlOM11IOHeGKtPOb0Qv
         lsbEX34Di2khw==
Date:   Sat, 4 Nov 2023 12:33:38 -0400
From:   Simon Horman <horms@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
        pabeni@redhat.com, fw@strlen.de, kadlec@netfilter.org,
        pablo@netfilter.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH net-next] netfilter: nf_tables: Remove unused variable
 nft_net
Message-ID: <20231104163338.GN891380@kernel.org>
References: <20231101013351.55902-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231101013351.55902-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 09:33:51AM +0800, Yang Li wrote:
> The code that uses nft_net has been removed, and the nft_pernet function
> is merely obtaining a reference to shared data through the net pointer.
> The content of the net pointer is not modified or changed, so both of
> them should be removed.
> 
> silence the warning:
> net/netfilter/nft_set_rbtree.c:627:26: warning: variable ‘nft_net’ set but not used
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7103
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

I think this is for nf-next, rather than net-next (which is closed).

But as for the change itself, I also noticed this, and am glad
to see it being addressed.

Reviewed-by: Simon Horman <horms@kernel.org>
