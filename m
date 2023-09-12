Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E1579CED3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjILKtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbjILKs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:48:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A70E19B9;
        Tue, 12 Sep 2023 03:48:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AD9C433C8;
        Tue, 12 Sep 2023 10:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694515721;
        bh=hyPH65s4f4/VZ9P/CAtBIH80ACdiyXIzT7HTVAtLpEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fWaD/3jerbbhLKfg2mYq4A5FG9fTTj3v5Ocj2/fBVsoOjJiwl5lRUnQ+P4UdcByJQ
         S/qMPUEFMmuDN2NeBspiJp/1/TUWIXKBCX0mkKwGgWfWL/syRbPRjSYP++vQ+FOgZ6
         BnODvBFjgKRll5ZvbydxkdcLyPNKyo9UK4nfktMg=
Date:   Tue, 12 Sep 2023 12:48:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     H Hartley Sweeten <hsweeten@visionengravers.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>, stable@vger.kernel.org,
        Ian Abbott <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "comedi: add HAS_IOPORT dependencies"
Message-ID: <2023091244-sprung-polio-6a37@gregkh>
References: <20230905090922.3314-1-abbotti@mev.co.uk>
 <76acff7e-3959-4193-9531-22a5e5a68221@leemhuis.info>
 <2023091226-foe-reanalyze-b859@gregkh>
 <516005ff-636e-4aa9-9bcb-76902c09f855@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <516005ff-636e-4aa9-9bcb-76902c09f855@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:39:28PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 12.09.23 12:13, Greg Kroah-Hartman wrote:
> > On Tue, Sep 12, 2023 at 11:44:39AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> >> On 05.09.23 11:09, Ian Abbott wrote:
> >>> This reverts commit b5c75b68b7ded84d4c82118974ce3975a4dcaa74.
> >>>
> >>> The commit makes it impossible to select configuration options that
> >>> depend on COMEDI_8254, COMEDI_DAS08, COMEDI_NI_LABPC, or
> >>> COMEDI_AMPLC_DIO200 options due to changing 'select' directives to
> >>> 'depends on' directives and there being no other way to select those
> >>> codependent configuration options.
> >>>
> >>> Fixes: b5c75b68b7de ("comedi: add HAS_IOPORT dependencies")
> >>> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> >>> Cc: Arnd Bergmann <arnd@kernel.org>
> >>> Cc: <stable@vger.kernel.org> # v6.5+
> >>> Acked-by: Arnd Bergmann <arnd@kernel.org>
> >>> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> >>
> >> Hmmm, that fix for a regression from the 6.5 cycle was posted a week ago
> >> but didn't get a single reply afaics and hasn't hit next.
> >>
> >> Greg, is this still in your to-review queue and just delayed due to the
> >> merge window? Or are you waiting for something? A ACK fromn Niklas
> >> maybe? Or a newer patch to address the kernel test robot report in case
> >> its relevant?
> > 
> > The merge window "freeze" ended on Monday, give me a chance to catch up
> > with patches please, this is part of my very large todo mbox:
> > 
> > 	$ mdfrm -c ~/mail/todo/
> > 	1637 messages in /home/gregkh/mail/todo/
> 
> Well, I know that you deal with a lot of patches and often wonder how
> you manage to do all that great work, but nevertheless please allow me
> to ask:
> 
> I assume that that not all of those 1600+ patches are fixes for
> regressions, so should a revert for a very recent regression be in a
> different mbox with a slightly higher priority[1] to get handled before
> the others?

Nope, I lump them all together into one mbox and then sort them when
processing.  Works faster overall for me.  I'll get to it by the end of
this week, hopefully :)

thanks,

greg k-h
