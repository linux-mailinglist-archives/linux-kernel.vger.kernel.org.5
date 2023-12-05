Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAE38061AA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346281AbjLEW1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346259AbjLEW1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:27:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F91188;
        Tue,  5 Dec 2023 14:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=E7AglM1sNrEzVXvgP3Pr0r6mYMdRh2+F/SBHIShk58c=; b=zY4U6y6lQoUZxswY4qHKuuGtMg
        sJixHP0HaCF1NRUNLbKQx1Rts5JMMIgCdPSJbRfX00//4xM6Rse/f/usqrGcuYKcMVvwuLbL61DbH
        r9U6ocd0dSC2Vwn77w3LWy3ggQ5Dadje/DKxf7gV9zlQQDQU85DTEjlt8pXW0Age0oNooGsLvm0Tl
        owIo817B6mI00r8rk7Z13PhEpztn1kflJRzQimIIEOrXsFQxN9FBrtW7thGCgsrDmJkrZnIq7FBKa
        n9UL5MU4XbUSdbAI5KwcRyLsoK/2MT7NP3vE9nJ0EJFBzkiVWUKrHByR86Lo0l2B5wJcnoUGi1poy
        DJ8rTlUQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rAdse-008Vj3-0o;
        Tue, 05 Dec 2023 22:27:04 +0000
Date:   Tue, 5 Dec 2023 14:27:04 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Joel Granados <j.granados@samsung.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <ZW+juEWLSTybbujk@bombadil.infradead.org>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <ZW66FhWx7W67Y9rP@bombadil.infradead.org>
 <b4b0b7ea-d8b3-4538-a5b9-87a23bbdac5f@t-8ch.de>
 <d50978d8-d4e7-4767-8ea7-5849f05d3be1@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d50978d8-d4e7-4767-8ea7-5849f05d3be1@t-8ch.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 06:16:53PM +0100, Thomas Weißschuh wrote:
> Hi Luis, Joel,
> 
> On 2023-12-05 09:04:08+0100, Thomas Weißschuh wrote:
> > On 2023-12-04 21:50:14-0800, Luis Chamberlain wrote:
> > > On Mon, Dec 04, 2023 at 08:52:13AM +0100, Thomas Weißschuh wrote:
> > > > Tested by booting and with the sysctl selftests on x86.
> > > 
> > > Can I trouble you to rebase on sysctl-next?
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-next
> > 
> > Will do.
> 
> The rebased series is now available at
> https://git.sr.ht/~t-8ch/linux b4/const-sysctl

I've applied this to sysctl-next as this all looks very sensible to me,
except one patch which I'll chime in on, but I'm merging it to
sysctl-next now without a promise to get this in as I really would like
this to soak in on linux-next for a bit even if it does not get merged
in the next kernel release. Exposing it on linux-next will surely
iron out run time issues fast.

> Nothing much has changed in contrast to v2.
> The only functional change so far is the initialization of
> ctl_table_header::type in init_header().
> 
> I'll wait for Joels and maybe some more reviews before resending it.

It all is very trivial stuff, except a few patches, but it all is making
sense, so my ask is to address feedback this week and post next week
a new set so we can have changes merged as-is for Linux in case this
really doesn't break anything.

For some reason I raccall seeing som hacky sysclts that shared and
modified an entry somewhere but the exact sysctl phases me, and I just
cannot recall.

> > [..]
> 
> For the future I think it would make sense to combine the tree-wide constification
> of the structs with the removal of the sentinel values.
> 
> This would reduce the impacts of the maintainers.

Indeed.

  Luis
