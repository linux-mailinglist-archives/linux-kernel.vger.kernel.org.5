Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29809765914
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjG0Qqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjG0Qqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:46:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEE9273D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:46:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70A9E61EDD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 16:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAC3C433C8;
        Thu, 27 Jul 2023 16:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690476401;
        bh=M2LZ36F+lMlPv7IbDxr9OkG0Nwl5lPobXvBwSQLLr24=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dXwF4lEy0vQ59liIabwJF9pBaFgr5QDk5/GC+zw7rs4EJCG7qEGgXWuaahd+ypOzr
         4rBjcSA++KtiZAWDRQnFzl99b36qAUG/2Q4Yi6Fs8bSOJQvn/97T5C6nb5zTpwM3rq
         uNyoWmJwOChwe+ZlIU+pFwufZ2BBzhwFX56dybZCEhBDrjJtsX4Hp4zLc1o0FGCpFL
         EZc1Vu330NUAMW9RbpL9Fd3A5rU2bR7k2oNlzzOmhK0a0dT4aBt23PSB2co6Tich94
         +NzT+0DKKrPRUYxdimC2QG+5Cn3fqlqbUrBAvVEmPvhGLYNGsrnWk2nxzw1m0Kz5sF
         XhO7vqDXVkDVw==
Date:   Thu, 27 Jul 2023 09:46:40 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, leit@meta.com,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next] netconsole: Enable compile time configuration
Message-ID: <20230727094640.09c17f48@kernel.org>
In-Reply-To: <20230727163132.745099-1-leitao@debian.org>
References: <20230727163132.745099-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 09:31:32 -0700 Breno Leitao wrote:
> +config NETCONSOLE_EXTENDED_LOG
> +	bool "Enable kernel extended message"
> +	depends on NETCONSOLE
> +	default n
> +	help
> +	  Enable extended log support for netconsole. Log messages are
> +	  transmitted with extended metadata header in the following format
> +	  which is the same as /dev/kmsg.
> +	  See <file:Documentation/networking/netconsole.rst> for details.
> +
> +config NETCONSOLE_APPEND_RELEASE
> +	bool "Enable kernel release version in the message"

We need to say the word "default" in a few places, to make it very
clear these are defaults.

I'll defer to others on whether this option makes sense, as I'm
probably too familiar with the problem you're solving to be impartial :S

Also the posting is pooped, the diff is listed twice.
Keep in mind the 24 grace period for netdev postings:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
-- 
pw-bot: cr
