Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483387C9D64
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 04:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjJPC1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 22:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjJPC1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 22:27:13 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783B9AB
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 19:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1697423229;
        bh=mveNhZTIXp4iyrkGMa7+bazcZa/dDAHIqdJLAUjn824=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=raQlwlooeNE5D0yPF9izh52sPNFHAAeeGcQP8X3Ydrr9HZdkCyN4S/4Qnzz8+gBic
         cBVSf7QEikkxn0ARJIL+oOTWkWzEMPEBbfndwf0KKMGza7bAqzCRIF4DxTz+3iiLEA
         zEeCUvBrFcBPD0NBiKc9N5ZZbzk/17r5OZBmeaRo=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 500A61286169;
        Sun, 15 Oct 2023 22:27:09 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id gQOr5PhV5zUU; Sun, 15 Oct 2023 22:27:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1697423228;
        bh=mveNhZTIXp4iyrkGMa7+bazcZa/dDAHIqdJLAUjn824=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=g4m4a4ytosr2kuI8BkH7a6QUJGdmRVLimJ00q9ckWpW2HRSamgiV9hn1E3UpKCR1o
         hRRUIYQBfo6xZXrhEz4GOVaJMSkBS1VjYK8BLAmE/gi4sBT0DgjmSPHqYjr8WZQKZE
         i3YGAtnFJcIrcmTlcYNv426Wfp0Pxqs5rYnqdGHY=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 161A012860F1;
        Sun, 15 Oct 2023 22:27:08 -0400 (EDT)
Message-ID: <5cd5b88ec8f4500a716aa8b96d27d44e96ed65bf.camel@HansenPartnership.com>
Subject: Re: [PATCH] mm: Fixed multiple typos in multiple files
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 15 Oct 2023 22:27:03 -0400
In-Reply-To: <CAJHePoZVMMCcUNKbg5f9VrYo-x5E_rU1piQGHi67ZuY4Pyj4bg@mail.gmail.com>
References: <20231014123349.11294-1-m.muzzammilashraf@gmail.com>
         <b72324e4-75d2-4d90-9e6d-342d10bb947b@infradead.org>
         <ZSq3iuuGy7zSl4sz@casper.infradead.org>
         <721f24eb6532290c6c4ab4e6d5a50bf8637fcd94.camel@HansenPartnership.com>
         <CAJHePoZVMMCcUNKbg5f9VrYo-x5E_rU1piQGHi67ZuY4Pyj4bg@mail.gmail.com>
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

On Sun, 2023-10-15 at 10:45 +0500, Muhammad Muzammil wrote:
> should I create the v2 or this patch is fine?

Personally, I don't think anyone cares about misspellings unless it
obscures the meaning of the sentence, so, given the interactions in
this thread, I'd argue the only one really worth fixing is relay ->
relies.

James


> 
> On Sat, Oct 14, 2023 at 9:27 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > On Sat, 2023-10-14 at 16:45 +0100, Matthew Wilcox wrote:
> > > On Sat, Oct 14, 2023 at 08:31:35AM -0700, Randy Dunlap wrote:
> > > > >         /*
> > > > > -        * The caller from rmap relay on disabled preemption
> > > > > becase they never
> > > > > +        * The caller from rmap relay on disabled preemption
> > > > > because they never
> > > > >          * update their counter from in-interrupt context.
> > > > > For
> > > > > these two
> > > > 
> > > > I don't know what that (partial) sentence is trying to say...
> > > > Maybe someone else does.
> > > 
> > > s/relay/rely/
> > 
> > relies, surely, being the correct third person singular form of the
> > verb to match the nominative noun "the caller".
> > 
> > James
> > 
> 

