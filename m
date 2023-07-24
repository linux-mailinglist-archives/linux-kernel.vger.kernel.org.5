Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBEC75FBC2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjGXQUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjGXQT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:19:58 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB3210C0;
        Mon, 24 Jul 2023 09:19:58 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AB320359;
        Mon, 24 Jul 2023 16:19:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AB320359
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1690215597; bh=2Mh7lM0TPt2ygo2ZM+oJY+bparIzFNpASC4Yp7GYdR4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bTcex0i7z6WWriQNqF9598os6nLFKZ5fuufbKlAkd31Hwv3njsxGCcq7StjKP3Mt+
         ISdVu7OSAc/LXPM8CxCrMELNrih+FKVaB/2FDR9nALAtehLCfEFw0lGcautUKPYFa7
         cfrW2S3sLmnbfndNTiv8XOXstbYAx+eda4lUMIUuskIZHzmsV2tPNy4LvrSY+tbSgK
         emL2krYvEZ8A/bQpJ6vdDnmoeSNZEEy49HC2/B27uXiQVlcb082e8iy/QjgbMWgL3b
         +8y4uAOGcXPaEu+n0+1jktToFgelw9lckAPCws2fJCZytDAvhiY8EY8gSsFVHrRaJW
         H3+xcaWW3pOmA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Costa Shulyupin <costa.shul@redhat.com>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs: remove tree links from the main index
In-Reply-To: <CADDUTFxu4owj_aXo2OBug3qBLbmS8boNXzcra8qLsqDYwN5Kpg@mail.gmail.com>
References: <20230718185156.1015753-1-costa.shul@redhat.com>
 <87y1j9ca42.fsf@meer.lwn.net>
 <CADDUTFxu4owj_aXo2OBug3qBLbmS8boNXzcra8qLsqDYwN5Kpg@mail.gmail.com>
Date:   Mon, 24 Jul 2023 10:19:56 -0600
Message-ID: <87mszlb7tf.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Costa Shulyupin <costa.shul@redhat.com> writes:

> The left column "Contents" is overloaded and hard to use. The value of
> this patch is to make it more usable.
>
> Sections of the main page are not displayed after patch "docs: Add
> more information to the HTML sidebar". So sections don't work now and
> should be fixed too.
>
> I have in mind to reorganize the main page so the left column
> "Contents" becomes usable.

No, that is not the right approach.

Much of our documentation is just thrown together in haphazard ways, but
the front page has actually been the target of a certain amount of
thought.  It is, after all, the entry point into our documentation.

This page can surely be improved.  But thrashing it up for the purpose
of making the sidebar better is getting the priorities wrong; the front
page is far more important.  The way to improve the sidebar is to change
how that is generated; that almost certainly requires digging into the
theme code.  That has been on my list for some time, but I haven't
gotten to it.  It would be wonderful if somebody beat me to it.

Thanks,

jon
