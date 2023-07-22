Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA5B75D9D6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 06:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjGVEul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 00:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjGVEtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:49:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA6246A2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 21:48:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8B2760AEF
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAF6C433C8;
        Sat, 22 Jul 2023 04:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690001318;
        bh=3UrDfCU4Ssx2uq6WCXoWnIuFnW0aBDsC7jDFre9FjEc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RiPWltHhsHeZJ0Gn6cSfj+2cb8lMw/zObP3RHjatyd3twrTp75mHF0hD70sDRZ69m
         qiHCDShNMjDY0sbHebqyxzfrAnR6faUKNI30WRlzTmzbdKI2oZIPZFCiEwU4D6y/b7
         AdTBEiiIXzimz4cj+LMbNf42nqE7tYgZL/0m9LdxvVtk8BHaU930wmOiR/xN4dawh1
         NcerXHwI5tQQTdWXE05tSkTiVf7qrM/56dxEe5aNtVFwh0NHsoCovRJpU0n8WmaZMg
         jK1/liRiW/kPopi5q2GqGyyHwJEGLMo4ncOqPiCEcOCpLfDltDzhAYqzXTcUBl+Bgk
         j5saN/XamS3hg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D7909CE0347; Fri, 21 Jul 2023 21:48:37 -0700 (PDT)
Date:   Fri, 21 Jul 2023 21:48:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Upcoming nolibc pull request for the next merge window
Message-ID: <2c54d017-226e-41c3-a767-a607942ecba5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7afafb6c-9664-44a1-bc8f-d20239db1dd5@paulmck-laptop>
 <20230722130120.6e4c0eab@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230722130120.6e4c0eab@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 01:01:20PM +1000, Stephen Rothwell wrote:
> Hi Paul,
> 
> On Fri, 21 Jul 2023 10:39:48 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >
> > This is just to let you know that Willy and I are adding co-maintainers
> > for nolibc.  Shuah Khan will join me as administrative maintainer,
> > and will be sending the pull request to you for the next merge window.
> > 
> > Similarly, Thomas Weißschuh will be joining Willy as technical maintainer
> > for nolibc.  With luck, this won't affect you, but in case you come across
> > a nolibc issue, please reach out to Thomas as well as Willy, Shuah,
> > and myself.  There will of course be an update to the MAINTAINERS file
> > in the near future, but just to let you know in the meantime.
> 
> Would it make sense to add a separate nolibc branch to linux-next (and
> no longer merge it into the rcu branch?  Or are there dependencies
> between the two?

Dependencies between nolibc and RCU are extremely rare, so it might well
make sense to have a separate branch.

Maybe nolibc/next from either the -rcu tree or Shuah's tree?  Shuah,
would something else work better for you?

							Thanx, Paul
