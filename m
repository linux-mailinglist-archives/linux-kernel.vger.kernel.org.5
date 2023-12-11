Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECB880D114
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343865AbjLKQUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344569AbjLKQUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:20:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A63A9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:20:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF513C433C9;
        Mon, 11 Dec 2023 16:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702311618;
        bh=f34i4VhyRZUjDAajQpSHCeFwPQZ+XgmGAVH4tNjvo3c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ERb/Rsw429zUhv9WVNiilZX16VWlBlVlH4lJ8ha748ZQ4JlBztO3FVRIypPa5S769
         j0f7zen95GgGtstlvNXCD77Cw+ER+5XHX28KAd7/sZf8jnaUbmlnGSXrVtBrRgVW/x
         6u99I2vp9ih23wYUNW7cVBegnRZXZp1l+9MhYygQxuHxmpC+pQthtRsK1b5XrnIj5i
         DaCUNkR8iU6IJgHlFnYKLTBNLYMEbQBUs41LahhpvKAuYX8VYFAZe7YDkVn0tUD81b
         cjITCYfBv/2QdDIs5kwWJdbQbhUqEDSwYKvbi1ZdjCFZfsqCX6rzeenJZiX/qr32J5
         XLMBUW4UeKiqg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 67B8CCE0569; Mon, 11 Dec 2023 08:20:18 -0800 (PST)
Date:   Mon, 11 Dec 2023 08:20:18 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, WillyTarreauw@lwt.eu
Subject: Re: nolibc changes for 6.8
Message-ID: <ec6bb811-90b6-4d7f-bdfe-f9b0e183df07@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <4208adae-d185-44a6-a564-ec9bc4c6eb2a@t-8ch.de>
 <25a20ebe-e5af-4ba7-890a-6a9ab121e184@paulmck-laptop>
 <3e0ea1fb-e16d-4a63-9991-fde6a146f07d@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e0ea1fb-e16d-4a63-9991-fde6a146f07d@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 08:26:00AM -0700, Shuah Khan wrote:
> On 12/8/23 17:02, Paul E. McKenney wrote:
> > On Fri, Dec 08, 2023 at 06:09:59PM +0100, Thomas Weißschuh wrote:
> > > Hi Paul,
> > > 
> > > The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:
> > > 
> > >    Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
> > > 
> > > are available in the Git repository at:
> > > 
> > >    https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git/ next
> > > 
> > > for you to fetch changes up to b99c3b15310e7c7cd5f2d843289fe115ab3f8043:
> > > 
> > >    selftests/nolibc: disable coredump via setrlimit (2023-11-26 11:39:52 +0100)
> > 
> > Thank you!
> > 
> > I pulled this in and got the following:
> > 
> > make run:
> > 162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > 
> > make run-user:
> > 162 test(s): 160 passed,   2 skipped,   0 failed => status: warning
> > 
> > This looks like complete success to me, but please let me know if this
> > is not expected behavior on an x86-64 laptop.
> > 
> 
> Paul,
> 
> This is my turn to send the pull request. Would you like
> me to take care of it?

It is indeed, apologies!!!

Please do take this round.

							Thanx, Paul
