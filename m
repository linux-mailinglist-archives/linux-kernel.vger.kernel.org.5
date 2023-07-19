Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C7E759E19
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjGSTCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGSTCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:02:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF6A171E;
        Wed, 19 Jul 2023 12:02:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6F3F617CB;
        Wed, 19 Jul 2023 19:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A56C433C7;
        Wed, 19 Jul 2023 19:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689793357;
        bh=er8PxxiNwe2IP17ixZnzil4chz2FvKc+APjSl+8TXDs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pWUtnTPNmsjwXTpPaBC0Z9/mOjq3LuTqKWfMBJoM6L1xaQ/6DutWUE7UihQWvrjOM
         Tlt/m2+k34AvI+OnS8IVwJYDIT7Wg1QUyb8RXm0qEZQclUPe4SquIXD/uYu1ECgdn2
         bWmah2eD6OzU11aRhHlX3HGADw5lqciv64BEL1LHHAXotNmJ+/B9NtXUYIGjDZmHFd
         VOZAQpM0VR9NqrwxtX4Ckh4Pk9aoqpQeKxog5vfZZcWFibfzbU7HmN/TJAzEKDyjOV
         LLFsk7yj+JYGrSCieAhp2GnCjBIk3OOOtrQvBED3x7PT6YjFpq0jz8/cpUWT/7Z8fg
         adGUALgXDVrAg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C6164CE092F; Wed, 19 Jul 2023 12:02:36 -0700 (PDT)
Date:   Wed, 19 Jul 2023 12:02:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH rcu 5/5] checkpatch: Complain about unexpected uses of
 RCU Tasks Trace
Message-ID: <de2c81f5-70c6-4e81-88b4-d412c58d033e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
 <20230717180454.1097714-5-paulmck@kernel.org>
 <04e74fd214a01bee0fb5ac690730cb386536cced.camel@perches.com>
 <8477fd32-38a5-4d66-8deb-a61b0e290df5@paulmck-laptop>
 <a0f6e131-a649-1731-b096-46313a0460a9@joelfernandes.org>
 <351d0261-210a-44a3-ade6-59289f407db2@paulmck-laptop>
 <67766eb5a995634e001b842fe988a423cf3d0eab.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67766eb5a995634e001b842fe988a423cf3d0eab.camel@perches.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 11:44:17AM -0700, Joe Perches wrote:
> On Wed, 2023-07-19 at 11:27 -0700, Paul E. McKenney wrote:
> []
> > > > > 
> > Given perl's tendency to have corner cases in its corner cases, I
> > am guessing that the "^" character combined with the "/" character is
> > causing trouble here.  Especially given that I don't see any use of such
> > a pattern anywhere in checkpatch.pl except directly in a "~" expression,
> > and there are a lot of those.
> > 
> > So I will keep it as is unless I hear otherwise from Joe Perches.
> 
> I played with it a bit and can't think of anything better.
> 
> Code is always something that can be improved later so the
> way Paul has it now is fine with me.

Then I don't feel so bad not finding anything better myself.

Thank you, and if nothing else this exercise refreshed a few of my
perl neurons.  ;-)

							Thanx, Paul
