Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A7E7B1D4E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjI1NEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjI1NEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:04:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FAE1B7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:04:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11F8C433C8;
        Thu, 28 Sep 2023 13:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695906255;
        bh=JuiGqphlzi+zpVMiN/0CFYkzc2zHSO21pjDawbVduIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BfZdbE/d88ZSxbSf3ugJGDmyLrrX/+qvOAAwh7bNHjAPd9LXdVy5UtL//J3aJHhbO
         4gWJsnPjPj/WQeWS7+nQ31RBYNyBtR1Fptn7RSRoFQj2WAgAHF4lSBdHyxULh55HgB
         Pmi4aEk4MtPeP2e8RHDI/ixIEAo10tmifKFDOsXE=
Date:   Thu, 28 Sep 2023 15:04:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux regressions report for mainline [2023-09-24]
Message-ID: <2023092846-envy-underpaid-cd36@gregkh>
References: <169557219938.3206394.2779757887621800924@leemhuis.info>
 <2023092522-climatic-commend-8c99@gregkh>
 <0efa9992-c2f8-4ae3-943f-9b17d0e1b1b7@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0efa9992-c2f8-4ae3-943f-9b17d0e1b1b7@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 11:11:51AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 25.09.23 10:02, Greg KH wrote:
> >  I've been
> > traveling all last week and this week for conferences so my response
> > times have been a bit slow, sorry.
> 
> No worries, I already suspected this[1]. The major aspect in this whole
> episode that bugs me a lot is different anyway:
> 
> Wouldn't it have been much much better to revert[2] the culprit quickly
> once it was known to cause a regression that annoyed some users a whole
> lot[3, 4]?

Possibly, yes.  It's a balancing act between keeping the pressure on the
developer to provide a fix, vs. the severity of the issue and how
wide-spread it is, vs. my ability to do anything at all due to
non-development issues (i.e. travel and conference work.)

Trying to pick the best thing with all of those is hard, sometimes we
get it wrong, sometimes we get it wrong, usually someone is upset no
matter what we pick, including a lack of sleep for the maintainer.

So "it's complicated", as you know...

thanks,

greg k-h
