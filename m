Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5918012BE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjLASah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjLASad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:30:33 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859E3131
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:30:39 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a06e59384b6so356558866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 10:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701455438; x=1702060238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cv2Uee2oIziALezonnt1Q9SYpgaVQLza5Azfx+pJao=;
        b=DPIsJR1TxC9i/XKb5UNCALzuewCVdiNO0BAxxBk8zAb2wUfLfUGLu6vk02sF5NBGT7
         hVTQVUZZaetlZEaCkTRg1ln/Xk9FHdJfr39K0TWamJloEBu/5yoaa1M7v90Fl+nS3HjA
         eKdbLG2geqq40z6qCpo+zNbFGfHcrs3C1BjIyZ1r842LkwAts7tcG8XEIsQU8KeuU9TA
         rtYtC29Ou457Yh5Biux9LgH2kwva58bPbwDDskuCqN3eBhsDQVnuT4N9XpuZi4eaqyXn
         YPMobU3dhwacS6RLputzP7GjhJQH08LlUc8+1RvecLdQOJY5JAMZNNsB8lqbI9HmuMcT
         xc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455438; x=1702060238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cv2Uee2oIziALezonnt1Q9SYpgaVQLza5Azfx+pJao=;
        b=uNzAj+/4vT6z1e1LgklUNc5BZgd+zQ9FoatNy54gALt11GsjDBRrUtsBWc/nNx/UCF
         luogYFYnfolAZK6cAyQhHdKh9N5/NP3jVIhMJ03MvP3jl3mBBB3D2T9sITTV/o+MaNNX
         Oxqdtq41GSu9h5YWPFHgE8TziLJU+33D7BC6LEeM1fuwbv1K0mu3MpQbbAemzEjqd0NJ
         4nOLvbwr+MvATYxyrMkxzb5z5Wm8dM2bedOdTzBOWK67AZ+OlFMA4RFsMVDufyRoeJoA
         2paLVwvsuw9jhuevpWKewnmXiMbvGbCHMKjv/nJKaVJJBJHo6Hby1e7imz2pS0o9X6/i
         473A==
X-Gm-Message-State: AOJu0YwZHZ1UO5lZXkqyvfpa5a8KuJ5gBZYhKXNdq3NdNhuRG+vfLNPa
        mXchAwMLC010EqZ4SoTfka0GUolitUR82/OSA7JCqQ==
X-Google-Smtp-Source: AGHT+IGWSDZTLPUhUxs9cJ/sDJr5Poc0NUX2A6DsxCgLTqdYrxJewgcmhq31tvPFbnQaRKG9qX3tYM7yIjoPY8ai5eU=
X-Received: by 2002:a17:906:c9c2:b0:a19:a19b:c704 with SMTP id
 hk2-20020a170906c9c200b00a19a19bc704mr883176ejb.84.1701455437997; Fri, 01 Dec
 2023 10:30:37 -0800 (PST)
MIME-Version: 1.0
References: <ZWobMUp22oTpP3FW@debian.debian> <CANn89iLLnXVBvajLA-FLwBSN4uRNZKJYAvwvKEymGsvOQQJs1A@mail.gmail.com>
 <CAO3-Pbq04ZphnB42bSoVDc8sgQ+GbRaqPtXOscsSMC5tXm8UdA@mail.gmail.com>
In-Reply-To: <CAO3-Pbq04ZphnB42bSoVDc8sgQ+GbRaqPtXOscsSMC5tXm8UdA@mail.gmail.com>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Fri, 1 Dec 2023 12:30:27 -0600
Message-ID: <CAO3-PbqD5Fpf9ddYFt4OvaT-4fq505X9LfBK0oKareJB+z65gw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] packet: add a generic drop reason for receive
To:     Eric Dumazet <edumazet@google.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Jesper Brouer <jesper@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 12:19=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote=
:
>
> On Fri, Dec 1, 2023 at 11:51=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > >         bool is_drop_n_account =3D false;
> >
> > Why keeping is_drop_n_account  then ?
>
> Good catch, thanks! Will send a v3 to fix up.
> Meanwhile, I noticed it is compiled with the
> -Wno-unused-but-set-variable flag, is there a reason why we disable
> this warning?

I found the answer in scripts/Makefile.extrawarn. Good to learn how this wo=
rks!

>
> Yan
