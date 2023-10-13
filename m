Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E300F7C86DF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjJMNcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjJMNcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:32:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADA9BE;
        Fri, 13 Oct 2023 06:32:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D09BC433C9;
        Fri, 13 Oct 2023 13:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697203929;
        bh=DhytyWf9r70HDQpbmpsWHC93xt7Fy8vbyRUtfXeflTc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EusY58ZCxADgEd2xpLoFqztaZCmT+WNUpkUbBwn2bqlctR0CL6Hsm9OlPYhN8X/Zl
         Ac8t6+X8CyzBhxXlp/eDH/Zgl3jIVhKaEPMFPqqXavICJC7oWcM1Hqb9LXSVzJqAUf
         yzGOINdJ7sPG35rerHRB7QhZ40WCJcHsa0D10PnWcgYVhNKkFfRk1UJPN9PW2dcOmL
         9uFc1HpnqWg3p6dAFA+GSsF8PwhAaCQXXfG9L8xoT5I28cmB9p6QZ9QsfsNamIF+x1
         QbumY2s4Dk20hevKJKl2bsC25KmbKN24a7wpcTeeDFzxvo3km+bzzOvtqf4Ed888Wf
         6u9K3LFVJdpIg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BB221CE0869; Fri, 13 Oct 2023 06:32:08 -0700 (PDT)
Date:   Fri, 13 Oct 2023 06:32:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the rcu tree
Message-ID: <be143b59-251a-4390-ad6a-0694fa38bddd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231013153730.2adf28b9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013153730.2adf28b9@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 03:37:30PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the tip tree as a different commit
> (but the same patch):
> 
>   8bf4aa582b16 ("x86/nmi: Fix out-of-order nesting checks")
> 
> This is commit
> 
>   f44075ecafb7 ("x86/nmi: Fix out-of-order NMI nesting checks & false positive warning")
> 
> in the tip tree.

I will remove it from -rcu, thank you both!

							Thanx, Paul
