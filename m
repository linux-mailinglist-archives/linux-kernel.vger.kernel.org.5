Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1E77C9909
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 14:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjJOMu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 08:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjJOMu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 08:50:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1300EAB
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 05:50:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB52C433C8;
        Sun, 15 Oct 2023 12:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697374253;
        bh=DcgxkIYZsMPY4HuUkYYrrImJhC13skqc0B+si2SPaMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vUAMFCEwwURYpNXvfZUqu8XZVw31wCE4N6z2dHc2YdTtD4A1T2oTbB6K7leOa+qJi
         goCEUFgj6BRDi1CxJbluz6I1p+WBF4ZdWzMfVqzA8hA1NffONVqEQrVYax+52P3+wz
         L6eiZ/Lr5ePyQ6jTdQSRwTriG3daFVGmQco36FQw=
Date:   Sun, 15 Oct 2023 14:50:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Soumya Negi <soumya.negi97@gmail.com>
Cc:     Jonathan Kim <jonathankim@gctsemi.com>,
        Dean ahn <deanahn@gctsemi.com>, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tty: gdm724x: Add blank line after declaration
Message-ID: <2023101508-curry-disorder-1b10@gregkh>
References: <cover.1697184167.git.soumya.negi97@gmail.com>
 <3b24ca9976cf873dbaadb499e09d7b545e9db89c.1697184167.git.soumya.negi97@gmail.com>
 <2023101551-placidly-garnish-3ee7@gregkh>
 <20231015060716.GA31326@Negi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231015060716.GA31326@Negi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 11:07:16PM -0700, Soumya Negi wrote:
> On Sun, Oct 15, 2023 at 07:37:30AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Oct 13, 2023 at 01:26:35AM -0700, Soumya Negi wrote:
> > > Fix WARNING: Missing a blank line after declarations
> > > Issue found by checkpatch.pl
> > > 
> > > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> > > ---
> > >  drivers/staging/gdm724x/gdm_tty.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > 
> > Why do you have "tty:" as the prefix for a staging driver?  Shouldn't it
> > be "staging: gdm724x: ...."?
> 
> Hi Greg,
> 
> Thats what I thought too. But when I looked at the git history for
> gdm_tty.c the last few commits had "tty:". So I went with that.

That is because those commits were tty-wide, and they changed things in
multiple drivers all at once, not just for the one file.

> Should I change it to "staging:"?

Please do.

thanks,

greg k-h
