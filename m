Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1971E78CA69
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbjH2RMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237662AbjH2RLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:11:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7621FD;
        Tue, 29 Aug 2023 10:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693329085; x=1693933885; i=deller@gmx.de;
 bh=Am0z4fpqq3gPWNH7evU/PjMIRGxd6gp6/fsCQ/0L66o=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=U4nedsHCoA/1LmSlRHSeHbWXHxCkCzF/0fMB5MMNEqbkl8Aq7pZFV3O13JP6z0lzBDPu78y
 eaiF+0agzmwjfKKGZ5PQ7lw9wDnC0irnyigLmIJrWgCUpsFNp9VKQqqn85kPj6748BRfbrlP7
 y1DVOVfAa5nmC5KXpZ5k5K0dXhnIp8+iG0W8okM3AcO/MP97drELEzqITWhyCYWKln8CKDyAf
 MRy37VFMc5DN2lFRzgrWR6JhrMxlg9hsojGEZcI+otkmNiuXM3xz4tcvK9So9hiqz8Da/Nt76
 PyDFQZV3AiR/Mq2W1bNlnYShwKCP5OJjn7C8i4FFBanF50GxKNQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.153.221]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5VDE-1pdHfz2KqY-016u5T; Tue, 29
 Aug 2023 19:11:25 +0200
Message-ID: <9d2bb495-0c1d-0d1b-96ea-4b1110d45b79@gmx.de>
Date:   Tue, 29 Aug 2023 19:11:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: truncation in drivers/video/fbdev/neofb.c
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-fbdev@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>
References: <CAKwvOdn0xoVWjQ6ufM_rojtKb0f1i1hW-J_xYGfKDNFdHwaeHQ@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAKwvOdn0xoVWjQ6ufM_rojtKb0f1i1hW-J_xYGfKDNFdHwaeHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nLhGJZGsPhbosIqFBHO4HTSsCDwh7B/34489wZUsEU4guozePTn
 iVOOt2b9v3YsEHpW1OfD88PAgAHTEbgFfXELfw2Ebm4znjRHVRWmhvb30OA9LZfWVLqEctA
 4i7B1n7/aiRqpcY2BV1834zhck4UJb5ZmSKJauk4jQlc8J8DDWkDxocVBO3wZc5Y606xQYk
 qFFgxBkyI0OWmLlJMksaA==
UI-OutboundReport: notjunk:1;M01:P0:NdvL8Q8qicY=;IRYB6GgUXLgy8IgJ3ESMKXhKypa
 khB8z5GixgdUdVJoaHINNn7L3sjLTdUwFpz4ml1HsEVwJK+tTpMgKw5YLNysd7U89fYcEqpyT
 Oz/r4xGSsObPFwEDk09fN62yK+pc26pTymOdTbnmCbNuyLj2Xd2ENaNGsvQEORVYafgu+6JM9
 fIElepZdS+WmmrPSxBX9jWqoj0dmVi585iCmWfGHC40jbgmqyBVGKHUv049SpZbBocTLwkXHK
 DtKllaqG8GPfLfoOM2rOQ07w2/IhgUpouqADoGRMLa60RgG2KWAYvzfatosiH62nGgXrhMvio
 BVnnIQhj0/dS3sWRpPYJPv0ez+FIJWnuydCzf6qpKn2IcYOEv4Tts+O3fLZSseSHQePrTJOT2
 CTfZbZS4MO6ThePqBbj3fyjPouhRtDXLs7xnigrNgcK9U+PNo9MGKNdc3jnb5p09yuUkt1oOn
 Htkz6eDrAqQ0hP5TZGb2Zf4E/BckybE4SQznt2FMV18OY5xja3mwlLx2k5ogCJTAy9+H+xXs1
 EBoNbTAz9mReLc9f1XEwEgd2ISsZHysnNCV1lzgil21B07cfwiwyONK0LnrcZJ/udfd01vsfi
 XxUFhCBgzFfXJh3lOlTpsq6I5R5XMzPkEuYr9LZVqAjJX36ie3iOhv2bhyrRZ3oKr0PAB3xZk
 flPHwr/AwLrYv48h1iEDvvkiRWQLhhBQaxDFmWqvptavPQv1WjsjDQNqo0U/DQOAr7lfwjRvy
 7yXoQ7PdUcNVJiYSBYGEvXFw/KqEl5ejG2CZoGnVnaKT4bhrxeyHdre/hkTbWjwWzqIu/XEAj
 L2GZawpRtuTA68msObmx5/dLj4RM4kEsBHMpXvZ/1j9/A8ej18clE6ujLJzMVBJauSrNeTSLr
 VE3R0z/1QSdcNwQZ6Tbo4rOM3TLpMxKIAk5wkT7ogK6IZCVcpnhJojsJmaycO0yKHVaXOBEA7
 2mjR+w==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/23 18:45, Nick Desaulniers wrote:
> Helge,
> A recent change in clang made it better about spotting snprintf that
> will result in truncation.  Nathan reported the following instances:
>
> drivers/video/fbdev/neofb.c:1959:3: warning: 'snprintf' will always be
> truncated; specified size is 16, but format string expands to at least
> 17 [-Wfortify-source]
> drivers/video/fbdev/neofb.c:1963:3: warning: 'snprintf' will always be
> truncated; specified size is 16, but format string expands to at least
> 18 [-Wfortify-source]
> drivers/video/fbdev/neofb.c:1967:3: warning: 'snprintf' will always be
> truncated; specified size is 16, but format string expands to at least
> 17 [-Wfortify-source]
> drivers/video/fbdev/neofb.c:1971:3: warning: 'snprintf' will always be
> truncated; specified size is 16, but format string expands to at least
> 17 [-Wfortify-source]
> drivers/video/fbdev/neofb.c:1978:3: warning: 'snprintf' will always be
> truncated; specified size is 16, but format string expands to at least
> 18 [-Wfortify-source]
> drivers/video/fbdev/neofb.c:1985:3: warning: 'snprintf' will always be
> truncated; specified size is 16, but format string expands to at least
> 17 [-Wfortify-source]
> drivers/video/fbdev/neofb.c:1992:3: warning: 'snprintf' will always be
> truncated; specified size is 16, but format string expands to at least
> 18 [-Wfortify-source]
>
> https://github.com/ClangBuiltLinux/linux/issues/1923
>
> Clang is right here.  `info->fix.id` is declared as `char id[16];` so
> indeed string literals like "MagicGraph 256AV+" indeed lead to
> truncation. But this is declared in include/uapi/linux/fb.h; I assume
> those headers cant be changed? Can the strings be shortened then? Is
> it perhaps time to delete this driver?
>
> I see AKPM mentioned alluded to this in
> commit 0e90454 ("neofb: avoid overwriting fb_info fields")
>
> (Also, snprintf probably isn't necessary for string literals that
> don't contain format strings)

It's just an ID field, so I don't think we need the full name of the card.
So using strscpy() and shorten the name, e.g. "MagicGr. 256XL+"
instead of "MagicGraph 256XL+" is probably the most simple solution?

Anyone want to send a patch?

Helge
