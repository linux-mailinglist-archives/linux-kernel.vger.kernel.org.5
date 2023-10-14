Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7FC7C955F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 18:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjJNQ15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 12:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjJNQ14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 12:27:56 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0511A2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1697300873;
        bh=nm5vaH8wqz2KtVFvf8/sXaByrLu5icSBJtXFT6rHxfM=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=rzhx1bbxK8MIA64B5sc0dIhy1tTc48wLZiWZETWJU/NjaQ7pzX9PvCNypAhUP4KVJ
         Mpba6tpW+CprLJF92e9fCLnDz9rwZryTtCsFfMbTViDbHDF6D+Q9h9BRNuiLEfR6cq
         GfFshXACuXlGdkXm+kZfuIhhZ4F+o3vzDV7nOHuk=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 41692128690B;
        Sat, 14 Oct 2023 12:27:53 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id fuch52DO0cbc; Sat, 14 Oct 2023 12:27:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1697300873;
        bh=nm5vaH8wqz2KtVFvf8/sXaByrLu5icSBJtXFT6rHxfM=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=rzhx1bbxK8MIA64B5sc0dIhy1tTc48wLZiWZETWJU/NjaQ7pzX9PvCNypAhUP4KVJ
         Mpba6tpW+CprLJF92e9fCLnDz9rwZryTtCsFfMbTViDbHDF6D+Q9h9BRNuiLEfR6cq
         GfFshXACuXlGdkXm+kZfuIhhZ4F+o3vzDV7nOHuk=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 79B6B1286909;
        Sat, 14 Oct 2023 12:27:52 -0400 (EDT)
Message-ID: <721f24eb6532290c6c4ab4e6d5a50bf8637fcd94.camel@HansenPartnership.com>
Subject: Re: [PATCH] mm: Fixed multiple typos in multiple files
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Muhammad Muzammil <m.muzzammilashraf@gmail.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 14 Oct 2023 12:27:50 -0400
In-Reply-To: <ZSq3iuuGy7zSl4sz@casper.infradead.org>
References: <20231014123349.11294-1-m.muzzammilashraf@gmail.com>
         <b72324e4-75d2-4d90-9e6d-342d10bb947b@infradead.org>
         <ZSq3iuuGy7zSl4sz@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-10-14 at 16:45 +0100, Matthew Wilcox wrote:
> On Sat, Oct 14, 2023 at 08:31:35AM -0700, Randy Dunlap wrote:
> > >         /*
> > > -        * The caller from rmap relay on disabled preemption
> > > becase they never
> > > +        * The caller from rmap relay on disabled preemption
> > > because they never
> > >          * update their counter from in-interrupt context. For
> > > these two
> > 
> > I don't know what that (partial) sentence is trying to say...
> > Maybe someone else does.
> 
> s/relay/rely/

relies, surely, being the correct third person singular form of the
verb to match the nominative noun "the caller".

James

