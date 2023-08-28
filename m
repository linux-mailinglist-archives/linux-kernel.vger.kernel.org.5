Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E417E78B41E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjH1PMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjH1PMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:12:14 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FB9FC;
        Mon, 28 Aug 2023 08:12:08 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6C4252CD;
        Mon, 28 Aug 2023 15:12:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6C4252CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1693235528; bh=bUKrXr8zVw9kjHDHioHUxchgQkRfrQ+AevoZbUABL5k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HJxgz8aK9MC2QKOD8U0DfryqN1jAGrDtbX82ZiyP0Ac+Kok9Epk/tDCL96kf9cZq3
         XDYl0Buz9cEtf327E1BpdhXM8gZJ4ZRB9SyVqPSjWVKQfrBQvRUGm6JuVUnYe+WBXh
         zy9cBeFUE1OLi6wUe4eW+oDQ3CYHhZlBui2nlNxWBZYJJ3U5pfo5mEeoGSyetr9YVJ
         1xJlq09922pB6BAPnBfbLi5c3rykjzMKQrTumGq3feSduw0fSBIEXDF4HxzztiWICG
         JVYOEsrCa/aYFUz7w54E75gRYf3KTzZoqfvo6NAGgwKr1qHzjw87xeMiuFPRXRBlPl
         Z0I9z4lz2XaZQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Nishanth Menon <nm@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bpf@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
        Neha Francis <n-francis@ti.com>
Subject: Re: [PATCH 1/2] Documentation: sphinx: Add sphinx-prompt
In-Reply-To: <ZOyqhL32tuiMlS23@casper.infradead.org>
References: <20230824182107.3702766-1-nm@ti.com>
 <20230824182107.3702766-2-nm@ti.com> <87h6om4u6o.fsf@meer.lwn.net>
 <20230828125912.hndmzfkof23zxpxl@tidings> <87edjn2sj0.fsf@meer.lwn.net>
 <ZOyqhL32tuiMlS23@casper.infradead.org>
Date:   Mon, 28 Aug 2023 09:12:07 -0600
Message-ID: <87wmxf19rs.fsf@meer.lwn.net>
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

Matthew Wilcox <willy@infradead.org> writes:

> On Mon, Aug 28, 2023 at 07:41:39AM -0600, Jonathan Corbet wrote:
>> I appreciate attempts to improve our documentation, and hope that you
>> will continue to do so.  I am far from convinced, though, that this
>> change clears the bar for mainline inclusion.
>
> I'd ask that you reconsider.  Looking at patch 2, I prefer what is
> written there.  I don't think it adds cognitive load when reading the
> plain docs.  I find the "copy and paste from html" argument not very
> convincing, but I do like "copy and paste from rst", which this enables.

Do you really think that the benefit from that justifies adding a build
dependency and breaking everybody's docs build until they install it?  I
rather suspect I would hear back from people who feel otherwise if I did
that... 

> I also have a certain fond memory of how the plan9 people set up 'rc'
> (their shell) so that ";" was both an empty statement, and the default
> prompt.  So you could copy-paste lines starting with the ; prompt and
> they'd work.  It's a small usabillity improvement, but it is there,
> and wow is it annoying when you don't have it any more.

Ah, OK, so what we really need is a bash patch :)

Thanks,

jon
