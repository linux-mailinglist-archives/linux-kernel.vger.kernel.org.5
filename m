Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7F37E2031
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjKFLlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFLk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:40:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB9C90;
        Mon,  6 Nov 2023 03:40:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2812EC433C7;
        Mon,  6 Nov 2023 11:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699270855;
        bh=+YlEmHVb4VpY2xPIie+34II2npAZ3LMtsvIAKKGYxd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2MXlT2GRZgvi6DZI7EXG+rCMLklpcnDzp4AQzE3BZ2XXPSruQKJFNUjbUinZEefSf
         TzhsZd0pDfUOR+2KDNxc5XIlFDRU7s7li74l7VOz9sFj2OsAkiTE5J2J6w8LDAZzuI
         NL+rn0yckNDKWE3L4F2m4ciiLKzocVl0jSKoSolo=
Date:   Mon, 6 Nov 2023 12:40:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [v6.6][PATCH 0/5] tracing: Backport of eventfs fixes for v6.6
Message-ID: <2023110620-wildcard-chrome-0d72@gregkh>
References: <20231105155630.925114107@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231105155630.925114107@goodmis.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2023 at 10:56:30AM -0500, Steven Rostedt wrote:
> 
> Greg,
> 
> Friday before the merge window opened, I received a bug report
> for the eventfs code that was in linux-next. I spent the next
> 5 days debugging it and not only fixing it, but it led to finding
> other bugs in the code. Several of these other bugs happen to
> also affect the 6.6 kernel.
> 
> The eventfs code was written in two parts to lower the complexity.
> The first part added just the dynamic creation of the eventfs
> file system and that was added to 6.6.
> 
> The second part went further and removed the one-to-one mapping between
> dentry/inode and meta data, as all events have the same files. It replaced
> the meta data for each file with callbacks, which caused quite a bit of
> code churn.
> 
> As the merge window was already open, when I finished all the fixes
> I just sent those fixes on top of the linux-next changes along with
> my pull request. That means, there are 5 commits that are marked
> stable (or should be marked for stable) that need to be applied to
> 6.6 but require a bit of tweaking or even a new way of implementing the fix!
> 
> After sending the pull request, I then checked out 6.6 an took those
> 5 changes and fixed them up on top of it. I ran them through all my
> tests that I use to send to Linus.
> 
> So these should be as good as the versions of the patches in Linus's tree.
> I waited until Linus pulled in those changes to send this series out.

All now queued up.  Note, patch 1/6 needs to go to older kernels as
well, according to your Fixes: tag, so if you could provide backports
for them as well that would be great.

thanks,

greg k-h
