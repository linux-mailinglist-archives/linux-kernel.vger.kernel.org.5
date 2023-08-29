Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF40E78BFE5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbjH2IIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjH2IIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:08:16 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84439E9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:08:11 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-407db3e9669so146601cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693296490; x=1693901290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NP6mlrN9y/6rTYN1qRkwBxymC+PSvzPXFyt+wAfKj8w=;
        b=aX4Gav6iftUvb8C02Czjd0psp7yQfGOGgM/clNB0RpL5PRSWgzQ8vaMWPsIYO1jjja
         T0SjSy0CmHXSnYIpxwANbNjgqpAVj1w3FXouhaR8OjruLKNnUoNopGPfYQkKO5QDl5W0
         A2xYOfI7Gp1EBQhT6rfcuZGonaPXRH5KRduFQJxIw2RTgVWaAa4+RUX7QNzjIQ/l6AZ/
         KkNPupYMaru1MUatDRA9OXLTHtTOsS7emuyS1tW/e7sv0m+RW/Dk4FClGgc3au+zN+uU
         5YpF3Q0eQsOc30aR5p+az3n554nCfg9rmXuJMQ5144FIUHeBumF6v0b9kt93Kpfldo0h
         C2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693296490; x=1693901290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NP6mlrN9y/6rTYN1qRkwBxymC+PSvzPXFyt+wAfKj8w=;
        b=a1wkexaHobXi+ht4/GSQ2OmSgv5Poy0+UZUbEK9a3J+/etJhqbrGn8WRwfCtBliDil
         CAsgcmjN6gK3r7mOkKyvWqjyJMm1FzvfQC4Jf58a2yGKydRC15GZBwv4wr20YwbxP9oq
         dJ0MTPUGgEtZgqOOs6UooRsfHmb6iwAXL4pgvTuTKs19KUtzj5c8ZlDXQZIiVBYwpv+w
         Qkw5kaLpjw4EM4c9JMMqW1FJkpF6Nxw5ZPGUq5Luzp6LiVoJIRx6nsBSB2pMzI/tgkni
         tuXjP89IgfgNJcmzWVzQY+78w67coUvEO7lJEad30b1L9a/3eXZRx04lYmFGrS2xXh8K
         CZWQ==
X-Gm-Message-State: AOJu0YyzwnAxjINdjbEJPT3oHgOAwjKOFiOiM5ZQ7ePokS/miwMbjhjk
        N/zN1PKvfYkKskn3Vg82nT/2vvVGHhqsXMbyLDiKAA==
X-Google-Smtp-Source: AGHT+IE0THKdYMtTQgHqn0R9jaTA4fsl3ueWMJa5qIeaY9FE0gez7qFPFqKV2+BW5SyKjnqGCkYb3zCZRkkHwlaklbQ=
X-Received: by 2002:a05:622a:1788:b0:3f8:8c06:c53b with SMTP id
 s8-20020a05622a178800b003f88c06c53bmr213454qtk.0.1693296490403; Tue, 29 Aug
 2023 01:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230828233210.36532-1-mkhalfella@purestorage.com>
 <64ed7188a2745_9cf208e1@penguin.notmuch> <20230829065010.GO4091703@medusa>
In-Reply-To: <20230829065010.GO4091703@medusa>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 29 Aug 2023 10:07:59 +0200
Message-ID: <CANn89iLbNF_kGG9S3R9Y8gpoEM71Wesoi1mTA3-at4Furc+0Fg@mail.gmail.com>
Subject: Re: [PATCH] skbuff: skb_segment, Update nfrags after calling zero
 copy functions
To:     Mohamed Khalfella <mkhalfella@purestorage.com>
Cc:     willemjdebruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemb@google.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        David Howells <dhowells@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BPF [MISC]" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 8:50=E2=80=AFAM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> On 2023-08-28 21:18:16 -0700, willemjdebruijn wrote:
> > Small point: nfrags is not the only state that needs to be refreshed
> > after a fags realloc, also frag.
>
> I am new to this code. Can you help me understand why frag needs to be
> updated too? My reading of this code is that frag points to frags array
> in shared info. As long as shared info pointer remain the same frag
> pointer should remain valid.
>

skb_copy_ubufs() could actually call skb_unclone() and thus skb->head
could be re-allocated.

I guess that if you run your patch (and a repro of the bug ?) with
KASAN enabled kernel, you should see a possible use-after-free ?

To force the skb_unclone() path, having a tcpdump catching all packets
would be enough I think.

> Am I missing something?
> >
> > Thanks for the report. I'm traveling likely without internet until the
> > weekend. Apologies if it takes a while for me to follow up.
> No problem. Thanks for the quick response!
