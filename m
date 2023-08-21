Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3097824AF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjHUHlQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Aug 2023 03:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjHUHlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:41:15 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAF5B5;
        Mon, 21 Aug 2023 00:41:12 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d63c0a6568fso3151891276.0;
        Mon, 21 Aug 2023 00:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692603672; x=1693208472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hsFytKs7RM1boPECWd9jHLIPKSZrzZgoCEhF2W97G8=;
        b=BcvyAWLs5YqlbfZVIvfo7V4Pz30ueEvX+7bWRhM2pu3uDZjzZGMkqJnplv/Zit4Cyr
         vT+ho6+UaKAAwuh2pNA6Uv6k5eFUR5Xw1mNBHnIK+oMPk35tiCcwxnAhxjzzPAsKeAAO
         ShI1BcpsZ+vc+qAZOBHiNBMYGOO/fomoFy0JriJI8u1dhhi3pFAtfI0L+E1ocjMrp0hl
         dlSCchZd9jMGMH0U/OvzkiUpx18aCbqM9hg4u9/xkLdVOnGIqBI8DQNp1o8wY2UhFlYe
         DEHp4o3EQPDGmgT4YlwtQ7JM7Gq/FqUBwLAJox7IGUZMBYE3ichr1FwBFHz/kZR2g3tV
         OwYw==
X-Gm-Message-State: AOJu0Yz+HmzrlMjr2DRhdEHZfUtlXC1nmwQXxC+dz6Ce/eVZbu8gvJ2M
        NfsePu7GPaaX9ybxHZl0VCHleXBtIEOwYg==
X-Google-Smtp-Source: AGHT+IF/fHKd6kuRm9zD2qlKZeEeh+9aQ50pbRjS87RS8CfyLVHXUi3hPo0ohkrdGkjwv8n9ws3ZAQ==
X-Received: by 2002:a25:e307:0:b0:d54:b34c:1c7b with SMTP id z7-20020a25e307000000b00d54b34c1c7bmr5742646ybd.59.1692603671773;
        Mon, 21 Aug 2023 00:41:11 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id v98-20020a25abeb000000b00bcd91bb300esm1775319ybi.54.2023.08.21.00.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 00:41:11 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d746d030a86so1971607276.1;
        Mon, 21 Aug 2023 00:41:11 -0700 (PDT)
X-Received: by 2002:a25:d807:0:b0:d47:47c0:d7db with SMTP id
 p7-20020a25d807000000b00d4747c0d7dbmr5751404ybg.21.1692603671215; Mon, 21 Aug
 2023 00:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230817220957.41582-1-giulio.benetti@benettiengineering.com>
 <20230817220957.41582-2-giulio.benetti@benettiengineering.com>
 <20230817232348.GC1175@pendragon.ideasonboard.com> <28289906-4fd1-26aa-b1c4-eb393ac52d48@benettiengineering.com>
In-Reply-To: <28289906-4fd1-26aa-b1c4-eb393ac52d48@benettiengineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Aug 2023 09:40:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVY7vaU8wpJrMD4HNkQwkJD0Rd9sL-xFDYXxJEcP91yuw@mail.gmail.com>
Message-ID: <CAMuHMdVY7vaU8wpJrMD4HNkQwkJD0Rd9sL-xFDYXxJEcP91yuw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] docs: submitting-patches: Add Sponsored-by tag to
 give credits to who sponsored the patch
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Giulio,

On Sun, Aug 20, 2023 at 2:35 AM Giulio Benetti
<giulio.benetti@benettiengineering.com> wrote:
> On 18/08/23 01:23, Laurent Pinchart wrote:
> > On Fri, Aug 18, 2023 at 12:09:57AM +0200, Giulio Benetti wrote:
> >> Sometimes it happens that a Company or a Physical Person sponsors the
> >> creation and/or the upstreaming process of a patch, but at the moment
> >> there is no way to give credits to it. There are some commit that include
> >> a sort of tag "Sponsored by" without the dash to avoid
> >> scripts/checkpatch.pl to complain but a real standard has not been defined.
> >> With this patch let's try to define a method to give credits consistently
> >> including an acknowledge from the sponsor. The goal is to improve
> >> contributions from companies or physical persons that this way should gain
> >> visibility in Linux kernel and so they should be more prone to let the
> >> work done for them for to be upstreamed.
> >
> > Just adding one data point here, without judging on the merits of this
> > proposal. I've been requested previously by customers to increase their
> > visibility in the kernel development statistics, and the way we found to
> > do so was to sign-off patches with
> >
> > Laurent Pinchart <laurent.pinchart+customer@ideasonboard.com>
> >
> > (where "customer" is to be replaced with the customer name).
>
> this approach works good for the developer because of the +customer
> mailbox capability but in term of appeal for the final customer I've
> been told(by the customer) he would really like more the "Sponsored-by:"
> way. To tell the truth while I was looking for an existing alternative
> I've found the commits with "Sponsored by:" pseudo-tag that look cooler.
>
> This is my taste of course and the taste of one of my customers, but
> to me it's like having a brand shown:
> Sponsored-by: Sponsoring Company
> vs:
> Signed-off-by: Giulio Benetti
> <giulio.benetti+sponsor.company@benettiengineering.com>

Personally, I would respond "I'm sorry, but the only advertising
space we offer are Copyright headers (for employees) and
"user+customer@..." or "name (customer) user@..." (for contractors).

And this is a separate tag, so it's harder for the analysis tools
(whose output your customers must be interested in, too?) to
match the tag to the actual Author/Reviewer/...

> If I am the customer I'd really prefer the first option.

You are aware this will cause lots of work for the customer, too?
(See below).

> >> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> >> ---
> >>   Documentation/process/submitting-patches.rst | 38 ++++++++++++++++++++
> >>   1 file changed, 38 insertions(+)
> >>
> >> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> >> index efac910e2659..870e6b5def3f 100644
> >> --- a/Documentation/process/submitting-patches.rst
> >> +++ b/Documentation/process/submitting-patches.rst
> >> @@ -600,6 +600,44 @@ process nor the requirement to Cc: stable@vger.kernel.org on all stable
> >>   patch candidates. For more information, please read
> >>   Documentation/process/stable-kernel-rules.rst.
> >>
> >> +Using Sponsored-by:
> >> +-------------------
> >> +
> >> +A Sponsored-by tag gives credit to who sponsored the creation and/or the
> >> +upstreaming process of the patch. Sponsored-by can contain a company name or
> >> +a physical person name. If a company sponsored the patch this is the form::
> >> +
> >> +    Company Name <mail@companyname.com>
> >> +
> >> +where the Company Name must be a valid Business Name at the time of sending the
> >> +patch until the confirmation of the Sponsored-by tag, while the e-mail can be
> >> +either a generic e-mail the company can be reached out or an e-mail of a person
> >> +who has the rights inside it to confirm the Sponsored-by tag.
> >> +
> >> +If a physical person sponsored the patch the form must be same used in
> >> +Signed-off-by tag::
> >> +
> >> +    Physical Person <physical.person@mail.com>
> >> +
> >> +In both cases, to prevent fake credits, either the company or the person should
> >> +send an Acked-by tag placed right under Sponsored-by tag using the same form
> >> +described above. So for example if the patch contains::
> >> +
> >> +    <changelog>
> >> +
> >> +    Sponsored-by: Company Name <mail@companyname.com>
> >> +    Signed-off-by: Developer Name <developer.name@developername.com>
> >> +
> >> +The result including the answer from the sponsor must be::
> >> +
> >> +    <changelog>
> >> +
> >> +    Sponsored-by: Company Name <mail@companyname.com>
> >> +    Acked-by: Company Name <mail@companyname.com>
> >> +    Signed-off-by: Developer Name <developer.name@developername.com>
> >> +
> >> +This way the sponsor agrees to the usage of this tag using its name.

This is also causing more work for maintainers: now they have to check
if any Sponsored-by tags are present, and track if there is a response
with a matching Acked-by tag...

And obviously they should postpone applying the patch until a
confirmation response is sent... which may never happen...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
