Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0607E2EC8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjKFVQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjKFVQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:16:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B174A3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:16:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4821EC433C9;
        Mon,  6 Nov 2023 21:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699305411;
        bh=k2iHsevdylVfNnzq7vpSFHrz7HmQmltAVDcN12lB57M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rXYeTCNVWqISuAwfrqkINqGZUcV4qtcxPGdhwjgQXWbySb/hqmbVlZ3jbClBYSZcU
         Z31DK2I3f59Tkv9EeDg1BGoAw8jf8EOPv+IPNxHcD7X5DSpCwql8fODXsgvOIHSXug
         uBF0ZvmhqKP8nlLwdZ1Iw1PZdcChZ9Yz+TqjrmnAHfZ6K9W2LFLlF+rz1gxZa7Gz+o
         erGJBRBZ89WPxVdDsrVDn/c5v9y80iLmnVMz7wDhMkvv+ngMA1R6LfnRJHEeB7Qu87
         Bd1KkuoRe1uPJaS7ncTHNi2LxqjkKfOFkp1e9AJLyLz67rvCKdFP5rhfI+WQI/5VV5
         P+5LCDGNU27Rg==
Date:   Mon, 6 Nov 2023 14:16:48 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
        dsahern@kernel.org, pabeni@redhat.com, ndesaulniers@google.com,
        trix@redhat.com, 0x7f454c46@gmail.com, noureddine@arista.com,
        hch@infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
Subject: Re: [PATCH net v2] tcp: Fix -Wc23-extensions in tcp_options_write()
Message-ID: <20231106211648.GA682811@dev-arch.thelio-3990X>
References: <20231106-tcp-ao-fix-label-in-compound-statement-warning-v2-1-91eff6e1648c@kernel.org>
 <CANn89i+GF=4QuVMevE7Ur2Zi0nDjBujMHWJayURR9fbcr+McnA@mail.gmail.com>
 <20231106155806.GA1181828@dev-arch.thelio-3990X>
 <20231106125257.43f52b1f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106125257.43f52b1f@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 12:52:57PM -0800, Jakub Kicinski wrote:
> On Mon, 6 Nov 2023 08:58:06 -0700 Nathan Chancellor wrote:
> > Ah, this suggestion is much better, thanks. I'll make this adjustment
> > and send a v3 later today in case others have any suggested changes (I
> > know netdev prefers waiting 24 hours for another revision but I'd like
> > to get this warning cleared up by -rc1 so it does not proliferate into
> > other trees and I sent v1 almost a week ago).
> 
> Definitely, sorry about the delay, feel free to post v3 ASAP.

Done, thanks Jakub!

https://lore.kernel.org/20231106-tcp-ao-fix-label-in-compound-statement-warning-v3-1-b54a64602a85@kernel.org/

Cheers,
Nathan
