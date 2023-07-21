Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B37675D543
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 21:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGUT4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 15:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGUTz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 15:55:59 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644A830C0;
        Fri, 21 Jul 2023 12:55:58 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0447E733;
        Fri, 21 Jul 2023 19:55:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0447E733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689969358; bh=I2l90GdPKkhxv7pPDdSpTL8nL2bkIs23UDoazXLAmJ8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=atxr2zkBvUIinEKAOYTVLiKF6/Lk7zHXKuf0DdkXyqy2VDxuXO46tGxbdTt6Zmeme
         CXO5rVI9yDTbqJg/r3XYGY2Lvouub9kHvo+TydTlft8ld45MxUzWnMvP1FGPeiGKRr
         YKRTTDVzlvHfI569HIJtOxnFIk3slTSN/3iFF7F1nWzqlpIH8w5SL5XSm3MUVC5Flp
         paF9F8V+HApLzaMyceg8wgT6307GAvWswd1lyYTMxVYrvxJ+mvGDMIUurEaqphOmDX
         zopQ7h3gfaZHyYxocYxN6e9thigbsSy4tE7ZHNBm9Z6S8OWEvTCiER/CHfMO+xJ33J
         CswWHjqDe8/3A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Costa Shulyupin <costa.shul@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Costa Shulyupin <costa.shul@redhat.com>
Subject: Re: [PATCH] docs: remove tree links from the main index
In-Reply-To: <20230718185156.1015753-1-costa.shul@redhat.com>
References: <20230718185156.1015753-1-costa.shul@redhat.com>
Date:   Fri, 21 Jul 2023 13:55:57 -0600
Message-ID: <87y1j9ca42.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Costa Shulyupin <costa.shul@redhat.com> writes:

> and leave only their neighbor subsystem-apis
>
> because these links are already listed under
> section "Core subsystems" of Documentation/subsystem-apis.rst:
>
>     Core subsystems
>     ---------------
>
>     .. toctree::
>        :maxdepth: 1
>
>        core-api/index
>        driver-api/index
>        mm/index
>        power/index
>        scheduler/index
>        timers/index
>        locking/index
>
> Reference:
> - https://www.kernel.org/doc/html/next/subsystem-apis.html#core-subsystems
>
> Motivation:
> - make the documentation more organized
> - increase consistency, observability and maintainability
> - improve balance of ToC tree by reducing overly populated lists
> - avoid duplicate parallel links
> - escape tangling of links
> - intention to fit the main index into one page
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  Documentation/index.rst | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index 9dfdc826618c..8d8b7eab1131 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -38,10 +38,7 @@ kernel.
>  .. toctree::
>     :maxdepth: 1
>  
> -   core-api/index
> -   driver-api/index
>     subsystem-apis
> -   Locking in the kernel <locking/index>

So I don't really see the value of this.  It takes away some of the most
important links from the documentation front page, leaving the "Internal
API manuals" section nearly empty.  Why would we want to do this?

Thanks,

jon
