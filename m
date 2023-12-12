Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248C180F80A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjLLUkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjLLUkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:40:03 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA898BC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:40:08 -0800 (PST)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 81B043F16B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 20:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1702413607;
        bh=zm9xNCQJu7/pMzhvoTvEKcelCYpeWeFMTO+eCbHHAVQ=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=QkQ8nL6Fms5e4VEiJB2j5ffR8gMhvTUDAlCjYyw08uIRzctzG2no+UTl7T6HJ0Dlf
         WOKtI8NJRiOb+lRLGVh9g2ASS5MQPutM5UbsI8YefIMi5rrtTOf0lLRaSTmJz1QCH4
         ZLKGmGTVHqoep+i4r3STKVF0ajFGu/KoPA8AyAP8LeGetXNXb5iqTzcd4+MebL4Q0U
         7Udl3HNg/CyYDfhrT51egCvx5bQl+81HSUd7rx9WJ6Y0oTstbNSiRjmtDBPEu+MXBL
         0dgBcM+b6dB0N7NAp2FUNXbU1B/q1fCBVII4Op0FazZpKkujUi8d2yrPesY3HQJ2L+
         lHdgwzmMCG1Og==
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33335c6d495so4792734f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:40:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702413607; x=1703018407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zm9xNCQJu7/pMzhvoTvEKcelCYpeWeFMTO+eCbHHAVQ=;
        b=GEF7nrd8Tk9Hn6/bSszCEINvREqOcBoTFYIuTBuWgKs4I7kwOTJS4NobRY86LFurIO
         ppyGOXGdIckpYBxW/qSSLX9PNDf+Ig0vehNaJpy4DnqmeoASdoSfWXXUjmMHF2kvB7E4
         oou89qQ9Xljrl63/U0ksu22rdl/2MWxvfHfinWiYAWICWp+hNGmA/2oZQDavV6mYP3Ol
         V4Xx/Lpi4uCFnF8oQEOkB4n7CGdGl7pc34tsXkO1utDVypSx/7WZcfHlQ+19y0CTaFmi
         8zKvFKeX257W4vx+yaJB2dU9tZQNgRlru3wiafZA0+Btyz/cyp6s6fH6qyHahce6Q5yV
         L8bQ==
X-Gm-Message-State: AOJu0Yw9ikll+P7xfxlqhWQ7XmvAqHR3un5CcJVxve/rFHvAGrdTChUF
        VEuLCi/pKEJFgKHKO97IAvlD7Uu2lO5JzEKXkc0l2ST2tMyMXo2mjGIc2F+E6urbw3qlTRNbHoA
        529fq0dBXPASPLQB7eLZuymwQdyKKwtwA21NUcJtvSCLUoK76nchn+niIWQ==
X-Received: by 2002:a5d:4bd2:0:b0:333:429a:e4f7 with SMTP id l18-20020a5d4bd2000000b00333429ae4f7mr3596100wrt.79.1702413607162;
        Tue, 12 Dec 2023 12:40:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECLQ3Lt4fyDBhR1fObZVFqKwbCKSMfpAu1s+TDviYOwZWwcDCtS8i5/plWWVEEegVjIW1wiB3xCkgTA+aBt3I=
X-Received: by 2002:a5d:4bd2:0:b0:333:429a:e4f7 with SMTP id
 l18-20020a5d4bd2000000b00333429ae4f7mr3596093wrt.79.1702413606838; Tue, 12
 Dec 2023 12:40:06 -0800 (PST)
MIME-Version: 1.0
References: <20231212185339.1562967-1-dimitri.ledkov@canonical.com> <20231212203031.uudk57xhegi5yziz@treble>
In-Reply-To: <20231212203031.uudk57xhegi5yziz@treble>
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date:   Tue, 12 Dec 2023 20:39:30 +0000
Message-ID: <CADWks+aDuPcwmOCSmnQ4T-mKZ-N55-L+cS1ww2huEAXQnc_q8Q@mail.gmail.com>
Subject: Re: [PATCH] objtool: Make objtool check actually fatal upon fatal errors
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 at 20:30, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Tue, Dec 12, 2023 at 06:53:38PM +0000, Dimitri John Ledkov wrote:
> > Currently function calls within check() are sensitive to fatal errors
> > (negative return codes) and abort execution prematurely. However, in
> > all such cases the check() function still returns 0, and thus
> > resulting in a successful kernel build.
> >
> > The only correct code paths were the ones that escpae the control flow
> > with `return ret`.
> >
> > Make the check() function return `ret` status code, and make all
> > negative return codes goto that instruction. This makes fatal errors
> > (not warnings) from various function calls actually fail the
> > build. E.g. if create_retpoline_sites_sections() fails to create elf
> > section pair retpoline_sites the tool now exits with an error code.
> >
> > Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
>
> We had problems trying this before, but we can try again.  Maybe we'll
> have better luck now :-)

Well there are two classes of things - positive warnings count &
negative fatal errors

And yes I do want to add a toggle for making warnings errors.

>
> >       if (opts.orc && nr_insns) {
> >               ret = orc_create(file);
> >               if (ret < 0)
> >                       goto out;
> >               warnings += ret;
> >       }
> >
> >       free_insns(file);
> >
> >       if (opts.verbose)
> >               disas_warned_funcs(file);
> >
> >       if (opts.stats) {
> >               printf("nr_insns_visited: %ld\n", nr_insns_visited);
> >               printf("nr_cfi: %ld\n", nr_cfi);
> >               printf("nr_cfi_reused: %ld\n", nr_cfi_reused);
> >               printf("nr_cfi_cache: %ld\n", nr_cfi_cache);
> >       }
> >
> >  out:
> >       /*
> >        *  For now, don't fail the kernel build on fatal warnings.  These
> >        *  errors are still fairly common due to the growing matrix of
> >        *  supported toolchains and their recent pace of change.
> >        */
> > -     return 0;
> > +     return ret;
>
> Here it should check for ret < 0, since orc_create() or some other
> function might have returned non-fatal warnings (ret > 0).

Yes that's true... I had it in, and then removed, but I didn't double
check if each of the possible last ret assignments are guaranteed to
not be above 0.

>
> Also the comment is no longer relevant.
>

Well, I'm hoping to add --error option next, and yeah, make warnings
fatal. Or for example at least make the retpoline, sls, rethumb ones
to be fatal - because i found myself in a very surprising situation
where retpoline enabled build of kernel, had non-retpoline paths
remaining and not otherwise silenced as safe.

Maybe I should finish that second patch and make it available as a
config option.

At least right now, with Ubuntu Noble (development series) and
v6.7-rc4 everything is squeaky clean to enable CONFIG_OBJTOOL_WERROR=y
and make all warnings, fatal.

Also i think having it as a config option will result in various
automation tools able to flip it on, and submit bug reports when
something somewhere regresses.
-- 
Dimitri

Sent from Ubuntu Pro
https://ubuntu.com/pro
