Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483297786F1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 07:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjHKFUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 01:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjHKFUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 01:20:42 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395672D69
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:20:42 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9923833737eso217673166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691731240; x=1692336040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8cYlwrRaSF/zKzc5TC0jLD+97834wyo6L2H6kEGojaI=;
        b=FEUK1OLz9JahRHaIkJh/Uy4K1qGoMOXtSDrnGB4u7hY0E0lxDjpYirXOU6e+8XD32Y
         53Fl7mnPazPoIri6lRx8roZPc8Lm1q2PC8uS/PIzupAVPCm7aVFirExBmcMDlBcoBGtO
         QaB0FLOmXWgTu5lDFqaekvJD1+OGeoPNnQvEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691731240; x=1692336040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8cYlwrRaSF/zKzc5TC0jLD+97834wyo6L2H6kEGojaI=;
        b=TcyOYA2Nf7WGkX5EZ7gGKgN30cSPZp/pRYslSkgj6qFU9Y5xNhGcFTE6cQ/bvxiBOV
         8pHhQmRpihaLMU7iVQVhXIvIXk2sXE+A+AHsyAw252aA2UKb9+4ank5QNFyt+Vbyp1kB
         LtQOgrmiQ+K91vS70HpeFQiVtrprINzFZjzz0Lhi4FOO6TXfc4ShtwGHdvSiVBO07NaU
         p2J37eeItVHIdy1cWl6c7DjkwhW6CXYA4rJ8bRp72d9iUv7zjAQQT1j7IkPFpMAf0VcU
         jAcgj1jUDLDORtrVgOggawrFb20JtPVLC6juQgsz2AvJC6rGqhXS8myAj93ZxElmsrWm
         OiYA==
X-Gm-Message-State: AOJu0YxmvN6/Ape4cgDzMJm3E4Bf6XCELcsv5S5vV6Mf2xZ6M7LxzroY
        OxY4bNCz9do7GR5u/QC5A6A3tSKefgoEjibB44Ce3McK
X-Google-Smtp-Source: AGHT+IHUWkb/HYdsq/AZ+l62bhNaaOP45Kae2TFMRLnZrqH/nn+5gDQCKeMff4s70WMv4O103NblvQ==
X-Received: by 2002:a17:906:3105:b0:99b:507d:dc05 with SMTP id 5-20020a170906310500b0099b507ddc05mr783236ejx.16.1691731240647;
        Thu, 10 Aug 2023 22:20:40 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id g11-20020a170906868b00b0099bca8b9a31sm1761674ejx.100.2023.08.10.22.20.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 22:20:39 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-52340d9187aso1967389a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:20:39 -0700 (PDT)
X-Received: by 2002:aa7:c382:0:b0:523:22f6:e8a5 with SMTP id
 k2-20020aa7c382000000b0052322f6e8a5mr817276edq.39.1691731239420; Thu, 10 Aug
 2023 22:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan> <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
 <20230810155453.6xz2k7f632jypqyz@moria.home.lan> <20230810223942.GG11336@frogsfrogsfrogs>
 <CAHk-=wj8RuUosugVZk+iqCAq7x6rs=7C-9sUXcO2heu4dCuOVw@mail.gmail.com> <20230811040310.c3q6nml6ukwtw3j5@moria.home.lan>
In-Reply-To: <20230811040310.c3q6nml6ukwtw3j5@moria.home.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Aug 2023 22:20:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whDuBPONoTMRQn2aX64uYTG5E3QaZ4abJStYRHFMMToyw@mail.gmail.com>
Message-ID: <CAHk-=whDuBPONoTMRQn2aX64uYTG5E3QaZ4abJStYRHFMMToyw@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, dchinner@redhat.com,
        sandeen@redhat.com, willy@infradead.org, josef@toxicpanda.com,
        tytso@mit.edu, bfoster@redhat.com, jack@suse.cz,
        andreas.gruenbacher@gmail.com, brauner@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com, snitzer@kernel.org, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 at 21:03, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> On Thu, Aug 10, 2023 at 04:47:22PM -0700, Linus Torvalds wrote:
> > So I might be barking up entirely the wrong tree.
>
> Yeah, I think you are, it sounds like you're describing an entirely
> different sort of race.

I was just going by Darrick's description of what he saw, which
*seemed* to be that umount had finished with stuff still active:

  "Here, umount exits before the filesystem is really torn down, and then
  mount fails because it can't get an exclusive lock on the device."

But maybe I misunderstood, and the umount wasn't actually successful
(ie "exits" may have been "failed with EBUSY")?

So I was trying to figure out what could cause the behavior I thought
Darrick was describing, which would imply a mnt_count issue.

If it's purely "umount doesnt' succeed because the filesystem is still
busy with cleanups", then things are much better.

The mnt_count is nasty, if it's not that, we're actually much better
off, and I'll be very happy to have misunderstood Darrick's case.

              Linus
