Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD597A2492
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbjIORXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbjIORW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:22:59 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B9BC1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:22:53 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-59bbed7353aso33433767b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694798573; x=1695403373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g2RWBQs5T7WlFgpSGFhWkY3V6/ADmjD9odSx9zwtedk=;
        b=BKqeG12RUC2P6P27TdIGj2kcFAKtz0V1WMD4fw7YQBhg6a/ISIfhIPexmxFw8KtxUO
         FKfAanKwp4kZ35JtRWlbeeMojHCzExkqVHirUC9qwtB9eVu0HAFecunUZQuWEHACHCbL
         8Asnl8Is0LpZ9TrT8hwoPVziChX8/1e4d5uxzuTc7DuJfOnZ9kwRVg7dwqOufMyknRyK
         VczGBgRiUFM6O7eZVVmXlJKzBFcI4kiKw8Vp3d/VRJqp5ppDsDan+LI5kkpzGhl7DVDN
         KqGTb+vVZCX1qwlAuixGVY1l2/CvXSRCeWDnZcDmKUXSowL/+60hL/ZUWPAPYpPqpZs7
         dctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694798573; x=1695403373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2RWBQs5T7WlFgpSGFhWkY3V6/ADmjD9odSx9zwtedk=;
        b=Jk9Jsr2oQplxnvPnqGfHooT4eUZkLPeLjSCrveB39Rr8KYevGf/n4P0cv8zgEE7TMU
         Jjt1ahg/OnvCUtJAGemSuyN5FL+M7m9Rsx2cZAbscQmfF9IDo34Qjiy31754AhE9Lvt7
         eikEzF7T4OrXT0pmDDzn6rCgjkh4HxFMx6T/kd+qaFiBr8WpXfnOlkwasKo0ATkEi07x
         e1CY0L/arJB8C396VPZFQPTO5pTN5TGiYFVxLbEROHHVOXHYNArJNH0O3OxVfSzCELyd
         BC7FogYjXRq0lm/OQ+jGTPXp8GJ7yxj+hq23eymSqWFuaD4FuB7HNt6Heh+q7uqwO817
         vIjQ==
X-Gm-Message-State: AOJu0YzBPiu4MWntBnETgYIbN7efperBqS5HJb7U6PWsz77QTQjRm/Eb
        iySRP9RTmkqPwdM31iiipO3dFCU/2zjjm8UFQcqJJ+fW95R9I349
X-Google-Smtp-Source: AGHT+IEH3oyPJB6QRNmpFNv17Lsy4u+2YFb7tHTfo1hIUqWNwwlxVVYFnU71LiQ5pZupfJE3oQ1KkAF8wseVhhS8n3I=
X-Received: by 2002:a0d:d653:0:b0:59b:cf74:ee8d with SMTP id
 y80-20020a0dd653000000b0059bcf74ee8dmr5997877ywd.10.1694798573063; Fri, 15
 Sep 2023 10:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <07c32bf1-6c1a-49d9-b97d-f0ae4a2b42ab@p183> <CAHk-=whO1+-4ALjFWSE0kzytz1kEbWPvy3xWvcUP1dJ4t-QqkA@mail.gmail.com>
In-Reply-To: <CAHk-=whO1+-4ALjFWSE0kzytz1kEbWPvy3xWvcUP1dJ4t-QqkA@mail.gmail.com>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Fri, 15 Sep 2023 19:22:42 +0200
Message-ID: <CACMJSetxQi+t3SBXu6OvBbmxV8AbX2CfdSA9JvF1chLJSU9Ppw@mail.gmail.com>
Subject: Re: Buggy __free(kfree) usage pattern already in tree
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 19:04, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 15 Sept 2023 at 02:56, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > __free() got some usage and some of the usage is buggy:
>
> Yeah, that's sad.
>
> I think the '__free(kfree)' thing should *only* be used in the form
>
>         struct obj *p __free(kfree) = kmalloc(...);
>
> which is what our docs mention. Anything else is simply buggy.
>
> But how do we *notice* this?
>
> I do want to stress how I was unhappy about this conversion to begin with
>
>     https://lore.kernel.org/lkml/CAHk-=wigZt6kVkY0HU1j_LJ5H1KzwPiYnwwk6CbqXqT=sGenjg@mail.gmail.com/
>
> but I reacted to the wrong issue.
>
> This stuff needs to be done *way* more carefully.
>
>               Linus

This is why I started with a *testing* driver. It's got "simulator" in
the name for a reason. It doesn't deal with real HW and is mostly run
in VMs anyway. Few people even build it at all so it makes for good
testing grounds for experimental features.

IMO this feature has much more potential at fixing existing memory
leaks than introducing new ones. I agree, I should have been more
careful, but I wouldn't exaggerate the issue. It's a bug, I sent a
fix, it'll be fine in a few days. I hope it won't be seen as an
argument against __free(). It just needs some time to mature.

Bartosz
