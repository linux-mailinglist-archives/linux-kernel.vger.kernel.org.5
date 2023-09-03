Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D83790BB4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 13:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbjICLvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 07:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjICLvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 07:51:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D4A11D
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 04:51:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F0086120B
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 11:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E50C433C8;
        Sun,  3 Sep 2023 11:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693741873;
        bh=WGab5EAMtJOfILoAycIKgO9a74bp0eFUcJCKAr1nTNA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EFyxuKOJz7h4LQH8xSOL/clOIO4TTS+1LepQvK98GC6ncpxLAh2fNZm7rQmEpKEPb
         LUx8mQLAAyfQKK5X21rIrtQ+NUzcFGao10kOtHbCh/5iD594WyaptFGdPD0+r0+i1a
         0DcjEdkUPwOOb1f+zuXH0gqTNCXGw/zX2jujqtS8FWiV+eToIPZeC72ZPWQYiG5UxE
         T1iZ4B5SGuaYwpO3a8qfOuS5nQASdqMLSQPR5vk1jzTzT6CmUjereMc3a+ykODG0cC
         W7FfUV709CGHM+3btLphYDtVmfhqhBR8bZocsZoNb25M/XSnkaor0JjOtJSHLqOG1r
         27O1a7Ewyul7g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 89709CE0C90; Sun,  3 Sep 2023 04:51:13 -0700 (PDT)
Date:   Sun, 3 Sep 2023 04:51:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] bootconfig: Updates for 6.6
Message-ID: <7622d631-9ec2-4507-acd7-c57d398366ec@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230902101046.bfe957bc51ecd91781200708@kernel.org>
 <CAHk-=wjpVAW3iRq_bfKnVfs0ZtASh_aT67bQBG11b4W6niYVUw@mail.gmail.com>
 <20230903131619.8b17a76a6f733c1361e102c5@kernel.org>
 <20230903173221.0865154b21b7d72c35d37d10@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903173221.0865154b21b7d72c35d37d10@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 05:32:21PM +0900, Masami Hiramatsu wrote:
> On Sun, 3 Sep 2023 13:16:19 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > If the user need to know the bootloader command line string when the
> > bootconfig is enabled, what about adding a special line to the
> > /proc/bootconfig, e.g.
> > 
> > bootloader.parameters = "<params from bootloader>"
> > 
> > In this case, it will be only shown when the bootconfig is enabled, and
> > normal /proc/cmdline user does not need to care about that. Of course
> > bootconfig can drop "bootloader" items.
> 
> Or more better for both bootconfig and reader, it is easy to add bootloader
> parameter as a comment.
> 
> # Parameters from bootloader:
> # root=UUID=ac0f0548-a69d-43ca-a06b-7db01bcbd5ad ro quiet ...

From what I can see, this would work quite well!

							Thanx, Paul
