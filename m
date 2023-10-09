Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4007BEC6F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378602AbjJIVNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378151AbjJIVNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:13:04 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA008A3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:13:03 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40662119cd0so133165e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 14:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696885982; x=1697490782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqbHq0ttFKvzPDwgSW9g3cAaws+68PDkrZBukLsrYPg=;
        b=DHBCRYD1GpZ8BuBLvYBRa2hJglIPijQ2KiY7S6hTL2AYMrkC1yaz4lmVULicDw1Y5f
         an3fRQW4XwjJAEZyLRwNVS6IZO1paYcNO+PN5TWqZt+xd8QKSSwAAqQJWyXEbuljJ6ZC
         Q0wkMXWx2hRWaqnQIgIy2w8/9nE7qfcWcdNwMH0jifx7amFU/DA4K3SnBmwpHN5GTx1Y
         6St0P5ym7YfKaNyDQZjTQwinOSviAj/WQE3/M1DgvyHoL+kyrWqV1oQByGAavxR3gbdW
         itvOlWH3OXxkz3MjER4fkKGWXi4juBqhu+RcDqiHusqSHYGu+506gRAQ8qJKhpfrlD+Y
         emnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696885982; x=1697490782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqbHq0ttFKvzPDwgSW9g3cAaws+68PDkrZBukLsrYPg=;
        b=uSIhtl5iXLH3VMRqwqUO/zEpGlpJgiSqpzRUAacwyDtInrc7Mh1aH7Y6wuZIuFvSV7
         7l8O8pKqmSjglQey25dlKUFiIKHks18QKnMmqa1dWZb5YixtGvGA9IP677XxYw/+Azsb
         zNH+bcF4DhxajMHERuWeabz4YS4vUnZ0ahLmPwNPZ4+YrRj//1j0akNtunFztU2I1SSH
         yLpKEax7I25cYr6mo1JozQR91ClLme5T/D6SVTt48SHu5xp5cgDXT5nZkTF5OeZ6atWd
         PapScdRJT/OrSfDRWV+jFBfhnGR5EPhLSDFTtMcfKcYqUelsCyX0T5lfF9o5ZvfwVLDY
         KgbQ==
X-Gm-Message-State: AOJu0YyxJKpi3B0ICguXbjAR2lBw2Q8wnrpRVJN4gaGyPXLZeBtkc+Kh
        GA/VQnPii/caB7O9w4RveDMQH++5j2yYNnpHtWs1Jw==
X-Google-Smtp-Source: AGHT+IEc1Yipf+guyltWqLmMAGO5WEoyxOts2zEN1XQRauRZYshwjhFYg1hG2ydPwgb8BE1UULsUeAEXoI4qSh8EO3Y=
X-Received: by 2002:a05:600c:1e25:b0:406:5779:181d with SMTP id
 ay37-20020a05600c1e2500b004065779181dmr383034wmb.2.1696885981988; Mon, 09 Oct
 2023 14:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231007060639.725350-1-yangcong5@huaqin.corp-partner.google.com>
 <CACRpkdbek0-Vhk4_34qY+0=EGrQxJS_CfLuF_5fRozMMyc+=Kw@mail.gmail.com>
 <CAD=FV=UFa_AoJQvUT3BTiRs19WCA2xLVeQOU=+nYu_HaE0_c6Q@mail.gmail.com> <CACRpkdYrFhTCa9rJ4savOcqRxcnyqoojCnwaCk6cnJv=aWxo4A@mail.gmail.com>
In-Reply-To: <CACRpkdYrFhTCa9rJ4savOcqRxcnyqoojCnwaCk6cnJv=aWxo4A@mail.gmail.com>
From:   Doug Anderson <dianders@google.com>
Date:   Mon, 9 Oct 2023 14:12:45 -0700
Message-ID: <CAD=FV=U5mX49s5yp+5uy+OfnkNrQgTJPf6E8fGHf=_Nn6M5f9A@mail.gmail.com>
Subject: Re: [v1 0/2] Break out as separate driver from boe-tv101wum-nl6 panel driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        hsinyi@google.com, swboyd@chromium.org, airlied@gmail.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 9, 2023 at 2:02=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> On Mon, Oct 9, 2023 at 10:53=E2=80=AFPM Doug Anderson <dianders@google.co=
m> wrote:
>
> > Also: just as a heads up, Hsin-Yi measured the impact of removing the
> > "command table" for init and replacing it with a whole pile of direct
> > function calls. She found that it added over 100K to the driver (!!!).
> > I believe it went from a 45K driver to a 152K driver. Something to
> > keep in mind. ;-)
>
> Sounds like Aarch64 code. I would love a comparison of the same
> driver compiled to ARMv7t thumb code. Just for the academic
> interest. Because I have heard about people running ARM32
> kernels on Aarch64 hardware for this exact reason: so they can
> have thumb, which is compact.

Yeah, thumb2 was the best.

I suspect that in addition to the aarch64 vs thumb2 part of the
problem is that mipi_dsi_dcs_write_seq() is a macro, so this wasn't
just a whole ton of function calls, but a whole ton of inline function
calls. ;-) Still, even if we fixed that, I'm not sure it we'll ever be
able to beat the space efficiency of command sequence tables.


> OK OK we definitely need command sequence tables in the core,
> what we have now is each driver rolling its own which is looking bad.

Agreed. I'd love to see someone tackle this (though not blocking
Cong's series on it). Hsin-Yi took a quick look at it and noticed that
some drivers have slightly different cases for how they handle command
sequences, which is a bit annoying. For instance, at least one driver
had an extra NOP between commands and said it was important not to
remove that. ...so we'd have to figure out how to abstract some of
these differences without it getting too ugly...

-Doug
