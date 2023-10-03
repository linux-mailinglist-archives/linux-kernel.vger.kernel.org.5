Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819427B6CE2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjJCPTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjJCPTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:19:17 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A1183;
        Tue,  3 Oct 2023 08:19:13 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4209F2B4;
        Tue,  3 Oct 2023 15:19:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4209F2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1696346352; bh=VKedhyMIgkQjXvL+hZvItrCFqi/RzTxxfS8XYS7wSfQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ca7PDA0a4sWmOp9W17zjZ/0mH7IU4T6U9NYrx1gKDWUM6JxfQOCoWleWJtYCcDdu7
         mrb7r+NLJoXF7/qJrfgeqmGSd3prExOfJCxSGXSKwtduSW7ntD+ickEEQqqGIPNTBe
         3P+DXO904F5gfkckwGTpeRnwJY36vp8wml0z0TeSsZHGe5VEyP8M0kV6ZNYLNUhwFm
         CaRq3zBHCpWSLG4Y+lKv+aVnC+m8yniFFPY1KGFrnDfcAurRAH4ZRfCdFX9+VevxDS
         fgKgBr1qOethWdjN6ljNc6LmP/KF7ETVXn0wo8JxgmSSir26nEX0MYTMlzmEBWI8Sf
         Au+HSozBeSI8A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, backports@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH v2] docs: add backporting and conflict resolution document
In-Reply-To: <20230824092325.1464227-1-vegard.nossum@oracle.com>
References: <20230824092325.1464227-1-vegard.nossum@oracle.com>
Date:   Tue, 03 Oct 2023 09:19:11 -0600
Message-ID: <87bkdfg2ds.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vegard Nossum <vegard.nossum@oracle.com> writes:

> This is a new document based on my 2022 blog post:
>
>   https://blogs.oracle.com/linux/post/backporting-patches-using-git
>
> Although this is aimed at stable contributors and distro maintainers,
> it does also contain useful tips and tricks for anybody who needs to
> resolve merge conflicts.
>
> By adding this to the kernel as documentation we can more easily point
> to it e.g. from stable emails about failed backports, as well as allow
> the community to modify it over time if necessary.
>
> I've added this under process/ since it also has
> process/applying-patches.rst. Another interesting document is
> maintainer/rebasing-and-merging.rst which maybe should eventually refer
> to this one, but I'm leaving that as a future cleanup.
>
> Thanks to Harshit Mogalapalli for helping with the original blog post
> as well as this updated document and Bagas Sanjaya for providing
> thoughtful feedback.
>
> v2: fixed heading style, link style, placeholder style, other comments

So this seems generally good and useful.  I have a few small comments,
none of which necessarily block merging it in its current form:

- I would like to see an ack/reviewed-by tag by others with experience
  with this task if possible.  The lack of complaints is a good start,
  but not always indicative of a lack of disagreement...:)

- Might this be better placed in Documentation/maintainer?

- Colordiff looks cool, but I'd at least drop in a mention of the Emacs
  ediff mode, which offers (I believe) a lot of the same functionality.

Thanks,

jon
