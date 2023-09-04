Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CB3791D63
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbjIDSrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245229AbjIDSr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:47:26 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0671CF6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 11:47:20 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-27373f0916dso920140a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 11:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693853240; x=1694458040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eom3OuBdDLG8xLYbovI7UUXs/0ndjlGbg2m40m7XFI=;
        b=d+d76ZA4iYMqvBoIfanonlUsoP85wIl9fuBjFwZlN4rVdFHWCBzAgyy0H6vatiCjoJ
         ddgsQHW5r2+6FLlhOetg+R4HhSqkYGg5YdnZd9+ACfgkkt6JxPHWG1+PGc77J7LKBKeX
         JSrqtcAaad+YmfijABK80M0aNxc4tF16ldkJir1TUL63iw8QmM+MRY01puJhuFe1uOrG
         JATUpCCT7EKiZbSulS+89brgwfIJEdLmmE+tZU+qzqqCZZKeFHqEusJL8fe1ZHAPF4PE
         NRXsLtpVFh/c7qfbml2xtcBTEm9QlVhsmWA8SQDGB43Wqc0eUOtE3ysjOLo5lKWqTt83
         cEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693853240; x=1694458040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eom3OuBdDLG8xLYbovI7UUXs/0ndjlGbg2m40m7XFI=;
        b=E1b1umvHRpFsbPFl08IdgSWbKWIbRBKBjllZ809B2sA7ew7lvL4TiUjfiANxCkB0Ju
         8h7uC59vGtv9Hiy6mv3uU+Lx1Lr9Ag6HP72zzcUfgppQKYSkbET6AjxIpG9n/TOIMdZ3
         BxxJm05OHzEvu+D8qO6j73lgHr8/k1CS0xam9owBTplllkmn/86nEC+n13ZIe5osueXR
         WtG8AFB1+mRjrilo56XFZDLCyoQD0Ubc18eGU1X7JBjYAbdTYAGEVxmFmMNbJv8RIT8x
         FgglKTXSnKzn76YIBuEZ6DVhOY83IBDJQeN6JopGqVV5mGhgJJcyFmv1Nh0Tjih4i6E2
         Fc1w==
X-Gm-Message-State: AOJu0Ywsbc7ZqbEYoRuaT2mQh8eU1O/iqIs8KjJ/c6X91dtcZRFmkIYq
        mcC6RrM3B7BGOwH18LWaz4sMSBGwuVEGs9dMA5E=
X-Google-Smtp-Source: AGHT+IHvsM9Kb3RWFbjqKxPWBosQ0fYxuk4IjDaSwud3ruWYzaXm8YrY+dkDDpO8xJM62drUKAAXrPZp5K0OQ5JqrWA=
X-Received: by 2002:a17:90a:53a6:b0:269:621e:a673 with SMTP id
 y35-20020a17090a53a600b00269621ea673mr7908690pjh.1.1693853240128; Mon, 04 Sep
 2023 11:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693328501.git.andreyknvl@google.com> <99cd7ac4a312e86c768b933332364272b9e3fb40.1693328501.git.andreyknvl@google.com>
 <ZO8Jwy5SAgkrQ5Qz@elver.google.com>
In-Reply-To: <ZO8Jwy5SAgkrQ5Qz@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 4 Sep 2023 20:47:09 +0200
Message-ID: <CA+fCnZcwftJtROmUzhvqczxHvCxTEUmhoONPXPzX23OWMNm_Kg@mail.gmail.com>
Subject: Re: [PATCH 14/15] stackdepot: allow users to evict stack traces
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 11:20=E2=80=AFAM Marco Elver <elver@google.com> wro=
te:
>
> > +/**
> > + * stack_depot_evict - Drop a reference to a stack trace from stack de=
pot
> > + *
> > + * @handle:  Stack depot handle returned from stack_depot_save()
> > + *
> > + * The stack trace gets fully removed from stack depot once all refere=
nces
>
> "gets fully removed" -> "is evicted" ?
>
> > + * to it has been dropped (once the number of stack_depot_evict calls =
matches
>
> "has been" -> "have been"

Will fix both in v2. Thanks!
