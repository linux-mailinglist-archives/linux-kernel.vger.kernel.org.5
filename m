Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766BE7FC2D0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346160AbjK1P4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346145AbjK1P4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:56:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A611790
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:56:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311AEC433C8;
        Tue, 28 Nov 2023 15:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701187010;
        bh=ErOez7LtTIIlU6uCAGYZae93iSfxpHNPOaxqhC3H1FM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J3utn8bTcJ1cmN7Bvm3YfgFjGz08H29IA5GdCAsIqol/Dwe2eltl2dwCjTlyI8JsH
         FFTXmB+EDNxEmtYPUmOdCKEfDyQrmcj7oBdr7zc+G4QmeAl/oZz8BERw2mDhr70Vhm
         nGtJE5HFDnb5CbJ/jXjkxuQEOAeMeDH8JiVtftrkrNHaL3T2G32LzuOjGIQPMoq8VM
         BOOkZEhNjlH8YVLKLHvJkmNruZ/xDga3NWglGHFPpZmiF0IuCfXEmiuE5SZPocz0JI
         GwD3fnHOY54fJ56pLltUsxsiXWifjER3mQfEWXMjhrvsMUZ19nxiPPpZHpk+JWDPvf
         wa4Q88tbBf6pw==
Date:   Tue, 28 Nov 2023 16:56:45 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] docs: Raise the minimum Sphinx requirement to 2.4.4
Message-ID: <20231128165645.2dbe416c@coco.lan>
In-Reply-To: <877cm2uegr.fsf@meer.lwn.net>
References: <87sf4qvkmc.fsf@meer.lwn.net>
        <20231128023015.0e446a06@coco.lan>
        <877cm2uegr.fsf@meer.lwn.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 28 Nov 2023 07:42:12 -0700
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab@kernel.org> writes:
> 
> > Em Mon, 27 Nov 2023 16:31:39 -0700
> > Jonathan Corbet <corbet@lwn.net> escreveu:  
> 
> >> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> >> index 1fb88fdceec3..db75b1b86086 100755
> >> --- a/scripts/sphinx-pre-install
> >> +++ b/scripts/sphinx-pre-install
> >> @@ -32,8 +32,7 @@ my $python_cmd = "";
> >>  my $activate_cmd;
> >>  my $min_version;
> >>  my $cur_version;
> >> -my $rec_version = "1.7.9";	# PDF won't build here
> >> -my $min_pdf_version = "2.4.4";	# Min version where pdf builds
> >> +my $rec_version = "3.0";  
> >
> > Please don't. 3.0 version has a broken C domain, not properly supported.
> > The fixes arrived only starting at 3.1 (I guess some went to 3.2, but
> > 3.1 is usable, as far as I remember).  
> 
> So you're asking for 3.1 or 3.2 instead of 3.0?

Yes. 

> 
> Honestly, I just picked 3.0 out of the air in the hopes of eventually
> deprecating 2.x.  Not lots of thought has gone into that
> number...perhaps we should recommend higher yet?

Well, we could recommend a higher version, but I can't see much
differences between 3.2 and the latest version: for what we use,
both will work on a similar way. Ok, layout may be different, there
were some improvements on PDF output, etc. but they will all produce
a decent documentation.

Yet, while most C domain bugs introduced on 3.0 were solved in 3.1
and 3.2, there's one still pending issue[1].

Once C domain finally gets rid from this long term bug that having:

	.. c:struct:: foo

	.. c:function:: void foo(void)

Produce warnings that "foo" id duplicated, then we'll have, IMO,
our next recommended version :-)

While Sphinx developers don't fix such bug, it doesn't really matter 
what version user will pick, so I would just pick the fastest one
as a recommendation, starting from 3.1 or 3.2 as our currently
recommended version.

[1] https://github.com/sphinx-doc/sphinx/pull/8313

While I didn't make any benchmarks, I remember people reported
poor performance with newer versions, so, without thinking to
much, 3.1 or 3.2 seems a good candidate for the recommended
version.

Regards,
Mauro
