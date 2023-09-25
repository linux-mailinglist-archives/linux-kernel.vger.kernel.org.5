Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA1E7AD29F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjIYICV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjIYICT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:02:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E45FE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:02:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5372C433C7;
        Mon, 25 Sep 2023 08:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695628933;
        bh=OGi7/VuDOOt0kJK/1Naj5b1F1uKD4LwLyqzc95rQlRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SwPGoePnsKTCSHlUY+m5iy6lOHChFkkibngne8gTbUF3MToOMbS85xpw0eQKck3lR
         SkMxcAuRDwQ0WaWay5H64WO57K4XU4U8oVzxtToqqvr1axOfVr1Ezrm0gra8QL4AJ1
         fh5vkvBpQ7lqxqol8dJlNiCiEVWr6yPjAxS8ABTc=
Date:   Mon, 25 Sep 2023 10:02:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Linux regressions report  for mainline [2023-09-24]
Message-ID: <2023092522-climatic-commend-8c99@gregkh>
References: <169557219938.3206394.2779757887621800924@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169557219938.3206394.2779757887621800924@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 04:17:40PM +0000, Regzbot (on behalf of Thorsten Leemhuis) wrote:
> (2) Nearly six weeks ago there was a report that 101bd907b4244a ("misc:
> rtsx: judge ASPM Mode to set PETXCFG Reg") [v6.5-rc6, v6.4.11, v6.1.46,
> v5.15.127] broke booting various laptops (many or all of them are Dell).
> This apparently plagues quite a few users, hence there were multiple
> reports (see [2] for those I'm aware of). At least Fedora, openSUSE, and
> nixOS have meanwhile reverted the change in their latest stable kernels
> [3]. I one and a half week proposed to revert the culprit when I fully
> noticed it's impact, but Greg wanted to give the developers more time.
> We finally have a fix in sight now [5]; someone affected replied that it
> helps. Not sure what's the right way forward now. But overall this to me
> feels a lot like "this is not how a regression should be handled".
> That's why I wanted to bring it up here in case to ensure your are aware
> of this.

We now have confirmed testing that the proposed fix resolves the issue
so I'll be getting it to Linus in time for the next -rc.  I've been
traveling all last week and this week for conferences so my response
times have been a bit slow, sorry.

thanks,

greg k-h
