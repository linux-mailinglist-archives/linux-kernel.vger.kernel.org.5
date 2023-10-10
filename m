Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EFD7C0413
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343755AbjJJTH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343741AbjJJTHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:07:25 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71435B4;
        Tue, 10 Oct 2023 12:07:18 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0AB022B2;
        Tue, 10 Oct 2023 19:07:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0AB022B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1696964838; bh=QcrWmIbuO0bfjdymUW0+w4/E5+y0kH/MzSz4CPcAOWI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dgbxMIAvJFG8AnvBsNgfjni4ZarPDi6QsxS3Z5cPLZGGfwPCGj6s8jWqBzyGoH4UY
         uvxHuAzl0Cm79jWF2ynkwvyjr7BeAFogam20+5A+cB9gWvTlK9TViW/jlAtXR9FJKt
         n0coW73+LPpPRJR6DRJwfGBbzUm4xqimkTt3yLBfwk9bJ822f9EddgDcV0E0OV5dmO
         7AyKwSfkCh8XKAegz7bQr9t7MwiDzGxcm3MIA3tqU2j5cIq8v1BclgUOIZHa3APKTV
         jXzUXvTLzQAu4m4tHjwSkG6jQlLeGI5ZbtyGiuyKPQvSZ7tCPmqhHB6vC9pQwFzC7z
         EHLvvjzKIKnyg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <src.res.211@gmail.com>
Cc:     Hu Haowen <src.res.211@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH v3] docs/zh_TW: update contents for zh_TW
In-Reply-To: <20231010050727.49212-1-src.res.211@gmail.com>
References: <20231010050727.49212-1-src.res.211@gmail.com>
Date:   Tue, 10 Oct 2023 13:07:17 -0600
Message-ID: <87a5sq70uy.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding Konstantin]

Hu Haowen <src.res.211@gmail.com> writes:

> The content of zh_TW was too outdated comparing to the original files.
> Consequently carry out improvements in order to both keep track of sources
> and fix several grammatical mistakes in traditional Chinese.
>
> This is a thorough rewrite of the previous patch:
>     https://lore.kernel.org/linux-doc/20230807120006.6361-1-src.res.211@gmail.com/
> in order to get rid of text damage and merging errors, created based on
> linux-next (date: Oct. 9, 2023).
>
> Signed-off-by: Hu Haowen <src.res.211@gmail.com>

So this patch still isn't showing up in lore, with the result that b4
will not work with it.  The thing is, it *does* make it through vger,
and has landed in the LWN archive:

  https://lwn.net/ml/linux-kernel/20231010050727.49212-1-src.res.211%40gmail.com/

Might lore be dropping it because it consists of one big attachment?
Putting your patches inline would be the right thing to do in any case.

Rather than force another round, I've tried to the patch directly (but
see below), but it would be good to figure out why lore doesn't like it.
Konstantin, any ideas?

[Hmm...even weirder...v2, sent on Sep 25, wasn't in lore when I looked
on October 3 - but it *is* there now:

  https://lore.kernel.org/lkml/20230925052311.20992-1-src.res.211@gmail.com/

I'll admit to being entirely confused.]

The patch itself adds a whole bunch of new warnings, appended below, so
I've unapplied it again.  We have been through a few too many rounds on
this, please do not resend until you have verified that it applies and
builds correctly.

Thanks,

jon

New warnings:

Documentation/translations/zh_TW/arch/index.rst:8: WARNING: toctree contains reference to nonexisting document 'translations/zh_TW/riscv/index'
Documentation/translations/zh_TW/arch/loongarch/introduction.rst:325: WARNING: duplicate label loongarch-references-zh_cn, other instance in Documentation/translations/zh_CN/arch/loongarch/introduction.rst
Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst:25: WARNING: duplicate label zh_contact, other instance in Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
Documentation/translations/zh_TW/process/submitting-patches.rst:54: WARNING: duplicate label zh_describe_changes, other instance in Documentation/translations/zh_CN/process/submitting-patches.rst
Documentation/translations/zh_TW/process/submitting-patches.rst:137: WARNING: duplicate label zh_split_changes, other instance in Documentation/translations/zh_CN/process/submitting-patches.rst
Documentation/translations/zh_TW/process/submitting-patches.rst:270: WARNING: duplicate label zh_resend_reminders, other instance in Documentation/translations/zh_CN/process/submitting-patches.rst
Documentation/translations/zh_TW/process/submitting-patches.rst:451: WARNING: duplicate label zh_the_canonical_patch_format, other instance in Documentation/translations/zh_CN/process/submitting-patches.rst
Documentation/translations/zh_TW/process/submitting-patches.rst:556: WARNING: duplicate label zh_backtraces, other instance in Documentation/translations/zh_CN/process/submitting-patches.rst
Documentation/translations/zh_TW/process/submitting-patches.rst:575: WARNING: duplicate label zh_explicit_in_reply_to, other instance in Documentation/translations/zh_CN/process/submitting-patches.rst
