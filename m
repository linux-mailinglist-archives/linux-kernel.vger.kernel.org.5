Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795BF768955
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 02:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjGaAN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 20:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjGaAN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 20:13:57 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605DFE1;
        Sun, 30 Jul 2023 17:13:56 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-cb19b1b9a36so4123145276.0;
        Sun, 30 Jul 2023 17:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690762435; x=1691367235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxcxzYh+eRe0jLj17RGPzPTU9bsNELCXWRjDPqz5Xds=;
        b=iIX3rm27Srf9Kp7m4EZr5m4I5D8l2keT3jNRf1MtDyaC2p2aNg25S7WXO9GPJlxumN
         A1qXNtJ6D9+gLiwvUWIVcKu3Nnjc2JYr9VkTfGH1JDHNS0gVvF3iYwikBmvg/dlMQOHE
         rOjLSHxxEE7N7+9KdzfjI651X6ZcMv7VYWAKgIqLVqvOrv4WtLEgMw6UI8J5lDHHM3vk
         pvxOgz6qzHvl0rfl8SNznjTcGz5ZeYb7uPG+Zmqz6Xa3SBwYQYcaxGz7dLNaggNpGE/E
         9QQkj9682Mr+dQfgz9s37/s+eDWrYM/lAbSnlWl9ME743mS7xsjOspwa2RUIuFBHVf5n
         mZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690762435; x=1691367235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxcxzYh+eRe0jLj17RGPzPTU9bsNELCXWRjDPqz5Xds=;
        b=bMNnL624OtEdZP8MoIf5IjgnmzoRUQbmOjKMy19j0tHl28fKTI5XT3pDlCfGbREMhR
         oNj8eeDcRpYGBEOASNoNlJoCWXh3BdcWOb3S9JjS2CAK5J4mIjtUDgZUA3l7tQp0PNkc
         Voy/GNlOisJEzXf/Pu7qOaoJ4/4URd+c6N1d6UBpvSPsVyW7W/PJxYM7jXy31blnZJSm
         qTzIcY8udIqMbgbSPIklVqwHrQBT/Qdbo4OXuw7Z0kVyDunep0ycGtyvDT+OdtXxJlWv
         27F1qTlgU8ZmR8iOqKC7IUNawy/tBOdhsaJdaT6HZ4y/KPvvRN+GGl+OW8FP7ViURXqt
         zYOQ==
X-Gm-Message-State: ABy/qLZo09+NtOJBti/pcAN7VjTTiJsSAdaCY+mZgL6php3XwutHmDzo
        tSoHHgGW5Eynm6O2uZV6ZDTe/r2CrG06AogyjyM=
X-Google-Smtp-Source: APBJJlGsIy3HmZ1rOv1QWKk8I7vFIuCtffLci+mjycRk1R/nR0bx1Cpc3iOx+dyG8M6B5F30izeTav6/m9uTk4xlwDE=
X-Received: by 2002:a25:e758:0:b0:d0e:b924:8e20 with SMTP id
 e85-20020a25e758000000b00d0eb9248e20mr7598351ybh.22.1690762435501; Sun, 30
 Jul 2023 17:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230730012905.643822-1-boqun.feng@gmail.com> <20230730012905.643822-2-boqun.feng@gmail.com>
 <CANiq72nf4N_HXOAZupM_Gq=c0jg-L__YUQtx4fSRpNuRqt4JAw@mail.gmail.com>
 <AWaNaTAJOJWWnEqJGgGsUTg8NiFGODsiRHl2OJRPb6XvWdXR8IuH7AjLgFn0OH1m_UZKHAcDFoElSPNXKQvgahydWGy3sE4lGEH2W9S-Kdg=@protonmail.com>
 <ZMbqBfEI9CuT0FUe@boqun-archlinux>
In-Reply-To: <ZMbqBfEI9CuT0FUe@boqun-archlinux>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 31 Jul 2023 02:13:44 +0200
Message-ID: <CANiq72=iUJ7WT7BFJH_U3AGg=7a5=zA2VOv=LOycR_XRph1Qdw@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: allocator: Prevent mis-aligned allocation
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Fox Chen <foxhlchen@gmail.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Andreas Hindborg <nmi@metaspace.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 12:54=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> =
wrote:
>
> Good to know, thanks!

Yeah, thanks Bj=C3=B6rn!

> Agreed. It's better. So reword as below:
>
> // Note: Although these are *safe* functions, but they are called by the
> // compiler with the parameters that obey the same `GlobalAlloc`
> // function safety requirements: size and align should form a valid
> // layout, and size is greater than 0.

+1, thanks!

Applied to `rust-fixes`, but please feel free to send `Reviewed-by`s.

Cheers,
Miguel
