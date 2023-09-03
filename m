Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F781790B39
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 10:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbjICIcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 04:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjICIcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 04:32:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD7DE3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 01:32:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F6A1B80968
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 08:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE34C433C8;
        Sun,  3 Sep 2023 08:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693729946;
        bh=DKXHukNv76TX4xgH1FR1Ej7VyaIkYsLp5fg1pE3diIY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AXG/fDeDdBC9UL4uy3YyQtYG8qVAcWgJE2uJDHW7Vz36Nkgy2sMiVqdlgwljIehI8
         rgwSYLm0iYMKKI+KlmpyyIjN8lCLMZxPP/OIvKheB7d6UPoKL/gD011eEqkdkEOpq8
         v9n42Mc8x9OmZ894vJmXO6NHzaM/Cz6ePuDdE9mSs8JaKr0FIDrVbEJNjIbEIJ6gc3
         eJVrpuWQNEJMFLz39b5q+Il+cEQuHqr5cZabjHZ1EmgpyOavtEL4MYB4XzlApQV/jM
         +4InyfxrN2Aa3NdLxrt+MEAChpLGH7UDDdSkJrbkp3v4Hwuvpo4MaI5WnqBQ6JSBxy
         KqhTAXn7u/OYQ==
Date:   Sun, 3 Sep 2023 17:32:21 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [GIT PULL] bootconfig: Updates for 6.6
Message-Id: <20230903173221.0865154b21b7d72c35d37d10@kernel.org>
In-Reply-To: <20230903131619.8b17a76a6f733c1361e102c5@kernel.org>
References: <20230902101046.bfe957bc51ecd91781200708@kernel.org>
        <CAHk-=wjpVAW3iRq_bfKnVfs0ZtASh_aT67bQBG11b4W6niYVUw@mail.gmail.com>
        <20230903131619.8b17a76a6f733c1361e102c5@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Sep 2023 13:16:19 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> If the user need to know the bootloader command line string when the
> bootconfig is enabled, what about adding a special line to the
> /proc/bootconfig, e.g.
> 
> bootloader.parameters = "<params from bootloader>"
> 
> In this case, it will be only shown when the bootconfig is enabled, and
> normal /proc/cmdline user does not need to care about that. Of course
> bootconfig can drop "bootloader" items.

Or more better for both bootconfig and reader, it is easy to add bootloader
parameter as a comment.

# Parameters from bootloader:
# root=UUID=ac0f0548-a69d-43ca-a06b-7db01bcbd5ad ro quiet ...

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
