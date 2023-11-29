Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D17C7FE3A8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjK2Wyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjK2Wym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:54:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D43F4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:54:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A223C433C7;
        Wed, 29 Nov 2023 22:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701298488;
        bh=CauGVvFZVP32vkOcY5cg2nLN5FTRx/mzqnRb1nHXFlc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RC3w4GIHEwQjkkuvoTWz4fw14yQ+ovAGzFRxTkodMdNtrM9xLvm/G6DnafvnzT6i4
         j2aH6CmQq/zITzVrtKTMeNM4XzbQ6MkR9S40ngp8DIgUvgRdyZKiOolEQgkAxtgAl4
         uPYAOIMSYsaxlWzfI1yJoDtqOH+w3o8d678Hf96g=
Date:   Wed, 29 Nov 2023 14:54:48 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, eric_devolder@yahoo.com,
        agordeev@linux.ibm.com, bhe@redhat.com, kernel-team@cloudflare.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] kexec: drop dependency on ARCH_SUPPORTS_KEXEC from
 CRASH_DUMP
Message-Id: <20231129145448.8cea3323a7eb19b8f6c6a18a@linux-foundation.org>
In-Reply-To: <CALrw=nF-zfmT+JNk9OKe7P3oRa7q820ATy3x4yc2A0z8j6_+AA@mail.gmail.com>
References: <20231129220409.55006-1-ignat@cloudflare.com>
        <20231129142346.594069e784d20b3ffb610467@linux-foundation.org>
        <CALrw=nF-zfmT+JNk9OKe7P3oRa7q820ATy3x4yc2A0z8j6_+AA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 22:34:13 +0000 Ignat Korchagin <ignat@cloudflare.com> wrote:

> On Wed, Nov 29, 2023 at 10:23 PM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 29 Nov 2023 22:04:09 +0000 Ignat Korchagin <ignat@cloudflare.com> wrote:
> >
> > > Fixes: 91506f7e5d21 ("arm64/kexec: refactor for kernel/Kconfig.kexec")
> > > Cc: stable@vger.kernel.org # 6.6+: f8ff234: kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP
> > > Cc: stable@vger.kernel.org # 6.6+
> >
> > I doubt if anyone knows what the two above lines mean.  What are your
> > recommendations for the merging of this patch?
> 
> Hmm... I was just following
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1
> and basically wanted to make sure that this patch gets backported
> together with commit f8ff234: kernel/Kconfig.kexec: drop select of
> KEXEC for CRASH_DUMP (they should go together)

I see, thanks.  I don't think I've ever received a patch which did this!


