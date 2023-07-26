Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887CF763FA7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjGZTbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGZTbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:31:01 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52C3272A;
        Wed, 26 Jul 2023 12:30:59 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 651D9359;
        Wed, 26 Jul 2023 19:30:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 651D9359
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1690399859; bh=dsJxPvwqZe8zXKEvc6QkO8wpGMltaVf8thuTWXhtQZY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pOA0IJm98VuGV4JWI8+ZqgCAVwc+3pavlc2hyQ+JIgjbi3ghYoupHOGb+qi+r4KLE
         hobSQ7kPcO/f8pyIrwcF1xkQtWKs1ii3kPfxTbOgJKK4FqvOKGxa5ay+/Q3Fl2sN7L
         /I2TOBdbHuH7piNx2uMQBypYOztK9208QJZVYDwWOnfaqdXxp4Bz1DBnSu9z4ujsom
         5pCSuj31iV5sPEp6GlM/dutCL1o/Zd3eo7b0qUdYiJb0AsxiiAs7xdWCfsw6kbrTPv
         Z+3A15zxXib/TZPpnwy2nYOvfY9Xowep4tvfxyT32i7eVzuuADDItkhsDGAx113UnM
         16yPUiPG2AGWw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Costa Shulyupin <costa.shul@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>
Subject: Re: [RFC PATCH v2] docs: rework "Working with the development
 community"
In-Reply-To: <20230726184939.3118350-1-costa.shul@redhat.com>
References: <87ila9atuk.fsf@meer.lwn.net>
 <20230726184939.3118350-1-costa.shul@redhat.com>
Date:   Wed, 26 Jul 2023 13:30:58 -0600
Message-ID: <87edku8o7h.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Costa Shulyupin <costa.shul@redhat.com> writes:

> Mission: Make the documentation more readable, organized and maintainable.
>
> NB: no information content is lost of changed on the rendered top page.
>
> This patch demonstrates rework of the only the first section
> of the top page for review. The proposal is to rework all sections.
>
> Summary of changes:
> - Heading "Working with the development community" is converted into
>   branch of toctree and visually moved after the text
>   "The essential guides for interacting ..."
> - toctree list is split into separated file. Please don't worry, the
>   content of the list is incorporated to the top page because of
>   `:maxdepth: 2`
> - vertical bar '|' add empty line for better visual distribution

I will repeat.  I do not support carving useful stuff out of the front
page in this way.  The front page does not exist just to make a
nice-looking sidebar.

> Technical explanations:
> Template {{ toctree(maxdepth=3) }} in
> Documentation/sphinx/templates/kernel-toc.html
> uses directives toctree and doesn't use sections on the top page
> Documentation/index.rst
> to generate expandable toc on the sidebar.
>
> BTW, other template {{ toc }} uses only sections, and doesn't
> use directives toctree.

*This* is where the problem lies.  I have started looking at it again,
but digging deep into the Sphinx code can be painful at times.

jon
