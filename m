Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC52800FA9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379433AbjLAPc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379426AbjLAPc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:32:56 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309C810D8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:33:03 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-db544987c79so635511276.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701444782; x=1702049582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXJhsJ8O3q6xngbx8DndV1q5mG4v/r2JTE5ISK5oIYQ=;
        b=PbrgkW+DvjYddXeGF1IcqzoFY5FJ3zZX3m4JXPWzEXVOj1kpMvoMxvBPI/cJXWWIk5
         Z3Ob2uLDxA4eKAqDI+F0/3/U9R9/ZDucxIX7eL4QMKEdYmNYu2Rfli4pg/5UHQgs4khd
         jbMvZyozwNKV24yofD2VRZoFaP64pAETOldGr25ieaRfRwsp8VbwqHaGPaFc7MtZ4KyS
         tP3oBxjSndXGlazn0t3HLNdJdyM9JTfXEKnMjGl5WxA7clD8o1/+kgthMBW/tGHnnW/E
         qJf4DBcou6ZPW32UuHTQO8kQn3m+TAHxG0BSgJYCmOjpAj624CJCYJs+hTo4bzJ5z5n/
         sTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701444782; x=1702049582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXJhsJ8O3q6xngbx8DndV1q5mG4v/r2JTE5ISK5oIYQ=;
        b=PQCoWe8mclaJiSVxu3h+e8OZoQ+HM02TDKqE8DZHxVvY1jIVB3nrm/s9+l0mszjvep
         VSo4i8q5N3ihYIAHsuK4dIDdiiL+1VNjMnd3dPnswDD3Znw4YgeemGTZJjxZMpYG9C3t
         lYRWWh0yOLSk3vnenm4xBImJ+h/2ygXxk1qsFpue83YMAqMKi52ZT7PPatnIFu63jzYi
         Yoxro+K6AV/EKZkfbiN3OHdcUTqAH2v6AkOjEl25Wg2PYsF31RiIhUrxNI+32r+WU6Th
         1RtsijgkL7g2V2SkHkIwZffL00M7tyBxRLRtwc1pLC4wptDUja4UNJTwI6Z8hFYY3ZTF
         gYBw==
X-Gm-Message-State: AOJu0Yz5o6fJ4jLVhtJmiQgVhSezZCOwsqwiEHOgvnB5DLGVpIODGyTL
        +1XuMphKqDMCWWXCNSPiGKNU1iHXhxdYKISl/PE=
X-Google-Smtp-Source: AGHT+IFy7O1fM/EUHXyF9g9UIdmMd5P2MTuCqORmf/mHNBEfa+85uAHjssTm3F/XLFy5D+QFHRYTA283Usz6OVMhVsA=
X-Received: by 2002:a5b:291:0:b0:db3:fca3:76ea with SMTP id
 x17-20020a5b0291000000b00db3fca376eamr26324788ybl.0.1701444782289; Fri, 01
 Dec 2023 07:33:02 -0800 (PST)
MIME-Version: 1.0
References: <20231201053540.9534-1-2023002089@link.tyut.edu.cn>
 <ZWmB67THrLcztb-3@buildd.core.avm.de> <b118c12f-b94d-46aa-ab72-55ac2ce7813f@link.tyut.edu.cn>
In-Reply-To: <b118c12f-b94d-46aa-ab72-55ac2ce7813f@link.tyut.edu.cn>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 1 Dec 2023 16:32:51 +0100
Message-ID: <CANiq72krGxPJ948xp2=pEBXS==P_AKrHLYEUBc3M7482bbL9UA@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/show_delta: reformat code
To:     Hu Haowen <2023002089@link.tyut.edu.cn>
Cc:     Nicolas Schier <n.schier@avm.de>, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, masahiroy@kernel.org,
        ndesaulniers@google.com, ojeda@kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Dec 1, 2023 at 3:49=E2=80=AFPM Hu Haowen <2023002089@link.tyut.edu.=
cn> wrote:
>
> Just got a glimpse on the usage of Black and realized the convenience
> it provides and strictness of code style it supplies. It is pretty
> feasible for code style analysis series of Python scripts within the
> kernel source.
>
> However, here comes the issue that this tool binds itself to its own
> bunches of rules how the code should be formatted by default, resulting
> in some kind of scenes which do not match what we want when doing kernel
> programming, or more exactly this tool may not follow the rules regulated
> by the kernel developers or mentioned within kernel documentation,
> which means we are obliged to conduct a programming standard for Python
> coding within kernel source internally, and then ask Black to review and
> reformat the code accordingly. But this programming standard is absent
> currently, consequently it should be specified initially from my
> perspective. What is your idea on this?

This is essentially the same problem we have for C.

For C, what I did was try to find an initial "common enough" style and
document the tool in `Documentation/process/clang-format.rst` so that
maintainers could start to use the tool easily if they so wished, at
their own pace. In other words, the benefit was just having the style
around. Then, maybe, after some years, when the tool is good enough
and maintainers are on board, we can start to think about
`clang-format`ing the kernel.

Now, for Python, we have orders of magnitude less code, so perhaps
using the default options of whatever tool is a possibility. In any
case, it would be a matter of exploring the tools, asking for
feedback, documenting the choice made in `Documentation/`, providing
an example patch formatting one of the existing scripts, etc. The main
benefit would be having decided on a particular approach. I would
still avoid sending tree-wide formatting of all scripts until
maintainers of those scripts agree.

I would also recommend taking the chance to also look at linting and
not just formatting, especially given tools like Ruff provide both.
And if you happen to find an actual issue in an existing script thanks
to the linting, then that would be great and allows you to showcase
their usefulness (and maintainers are probably more likely to welcome
series like that vs. just formatting :)

Hope that helps!

Cheers,
Miguel
