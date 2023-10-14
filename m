Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AD27C91BC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 02:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjJNARQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 20:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNARP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 20:17:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F11AD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 17:17:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6733C433C7;
        Sat, 14 Oct 2023 00:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697242634;
        bh=vLvOaEPuC1BYwKAmpu9Nz8KcUbjUhS1EcNVCw0Qexxs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tcMBcBB5FCHwKhA9dv9Ovo+nzv7iNSvxGgpV4RLj/xfH6Dc6IeE8xvyZDpaPKDt9l
         KuwdfIU1UNuDoirqn45ByYsQIqP3x7XhlDWQxFzSGea8dwZjScPDhQ6qFg1sfd+WxU
         /XtGBrRqDlLaYr5D6wFvZYJZI7Ff42UXNkOn2lCotsOYsMDzTGnJmHOFQQPJqmP9Mn
         M95E7kOjkxfQya/m502KrF4vc6KntjsDYHaxrCxbJkIMY3VW+LDuMZv7nxhmAHpwpr
         fMzLm9QWcnV/BCZ+1DjYls4SWwjU7ea4NlcVybyGvxYrMyw+kFb6fPOyTBhTdaDd4O
         uk+sZAllHckXQ==
Date:   Fri, 13 Oct 2023 17:17:12 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ma Ke <make_ruc2021@163.com>
Cc:     jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tipc: Fix uninit-value access in
 tipc_nl_node_get_link()
Message-ID: <20231013171712.0817d810@kernel.org>
In-Reply-To: <20231013070408.1979343-1-make_ruc2021@163.com>
References: <20231013070408.1979343-1-make_ruc2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 15:04:08 +0800 Ma Ke wrote:
> Names must be null-terminated strings. If a name which is not 
> null-terminated is passed through netlink, strstr() and similar 
> functions can cause buffer overrun. This patch fixes this issue 
> by returning -EINVAL if a non-null-terminated name is passed.
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>

You have now sent 14 incorrect fixes to Linux networking. 
And not a single correct one.
I would like to politely ask you to stop.
