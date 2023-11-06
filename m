Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDC67E2EFD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjKFVeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbjKFVeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:34:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAB6D57
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:34:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D684CC433C7;
        Mon,  6 Nov 2023 21:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699306450;
        bh=lg8M4ZU0WKeEUMti2afp6mI1H9am+64JDctsVPEWQ3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tra7q/wC7sAJllKQsTDPF/BYwJ6aPrtzVwacWSwuJzOpq/qmotoFcWxnOMpEWg4RW
         cqK72ElIXTi2lc2nWkoCKVHCS/0uTzrlnrkdxJFhOJFs9sSgRvC2gpgD8aLxc3sUuR
         TtQ810xKB7lOSdTyS/8aTRmXCyEXVdLV0+Wf0G/zoMpCZaUiGC6Ix4OIIkCxYcvQLv
         i2mq050hio1bLfRN12aKVHObKH1KRUUIwnFHAwgq1fNEVem9+IPO2+acSP8N5XR+uO
         i0TZIqnYHGIvhkXgwIAfi7jyHzJzSIvX+Ot7i1Nj1PMmNSXBSp1ju6EpP/7U+HzkyS
         ihY3sjoc7LjKA==
Date:   Mon, 6 Nov 2023 14:34:08 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     ndesaulniers@google.com, trix@redhat.com, noureddine@arista.com,
        hch@infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, edumazet@google.com, davem@davemloft.net,
        dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net v3] tcp: Fix -Wc23-extensions in tcp_options_write()
Message-ID: <20231106213408.GA1841794@dev-arch.thelio-3990X>
References: <20231106-tcp-ao-fix-label-in-compound-statement-warning-v3-1-b54a64602a85@kernel.org>
 <a8cc305d-0ab8-4ff7-b11a-94f51f33ec92@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8cc305d-0ab8-4ff7-b11a-94f51f33ec92@arista.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 09:26:48PM +0000, Dmitry Safonov wrote:
> Seems like exactly the fix that my git testing tree had, with an
> exception to naming the helper tcp_ao_options_write().

Heh, not sure why I never considered that as an option... I am guessing
it does not matter enough for a v4 at this point but I could send a
net-next change later to update it if you so desire!

> But then I found* your patch-v1 and decided not to send an alternative
> patch.
> 
> Thanks for fixing this,

Thanks for taking a look!

> Reviewed-by: Dmitry Safonov <dima@arista.com>
> 
> *had to fix my Gmail lkml filter to label not only emails with cc/to my
> name, but also the raw email address (usually, I got them to/cc "Dmitry
> Safonov", but this one didn't have the name and got lost in the lkml pile).

Sorry about that, b4 used to have some interesting behavior around names
at one point (don't remember the details at the moment) and just using
emails avoided those issues. Maybe I should go back to names and emails
to see if I notice any problems again.

Cheers,
Nathan
