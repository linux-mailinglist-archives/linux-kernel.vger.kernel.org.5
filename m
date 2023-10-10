Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAAC7BF6D9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjJJJJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjJJJJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:09:00 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62739E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 02:08:58 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d84f18e908aso5720003276.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 02:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696928938; x=1697533738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jEqkMdeti3/W7asExaM9e6RjY0pKBFJER3TES4A1Is=;
        b=DBq4SWQ08unPLaN9XsjfjRECOUzfr5cljl/e3fnsZJBm+UUBle6SRqkD5pFLN1xvmA
         WvZSWd8tTgpwQ1ilrHgoEbbQPtD9yBhlJp7eRSf+w4EXkLFy2Uszqi3xrqay8g82lpSM
         8FrpMbWP8x+Ift4vkRWpuPuqG4UzMPz9H8A33z2TRK7bTO7jlIeBtHlX01lKhhJfUszy
         yo2YjWbO+dawxg83FRWTAoA57LXmJzCpyUIDtv9wjjamre+EY/fQmwErFhU8wVIlkmZB
         PiTV/6RtqzIc/gw/TIs8MJU7hQRyH4ASYaOeQHfpXS2xy08GhVbLArxVD6BYQOTwC64I
         Ti6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696928938; x=1697533738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jEqkMdeti3/W7asExaM9e6RjY0pKBFJER3TES4A1Is=;
        b=uTypFn7HDjCSyK87T/YoRtlS7SmAyvbAXMNtBlKDVtj03HFU9xJXu+Rici9oRfjYeF
         2sm6VLYIrfsrKAWLlJ50orgvKd5ofReVUVvhqvh3jT9UgfHJhHP4f2X51hq1ST49BALZ
         cL8ebyws6Mnsfcw7tVEgYL91xT0Y62AUzLB2nfmFYZ0l+sCDH+Ozkrr+Bw7fW8jxr5Ya
         RttMmRKvaqTEKvqKnv/jIx0s1vbbIAzPmqikA+RR3IUhsQVn1E6DgWsnigvDIyz6Bt/O
         O3AkWtRgZTplij2I6HgDMf+mf/62BGXevoaLC+0gnv4nqujcXTfOnWfFJWPt7ZPeXTAE
         rkGQ==
X-Gm-Message-State: AOJu0Yy6nIVEfPHOcWbkwHRJAS9rKkPtwalC5yyaLgGEq9uYOtWzIUF4
        aIQ2MNgEvy+jUiLF6tYQePNfh9yf7NCBaFcy4rtopg==
X-Google-Smtp-Source: AGHT+IEr03R2VHLnNmgsuzntFl4LOazSy5LqhaQqB8IedsfEF3OGb4A0GJMrSUBOxjapz9jpzm8eXqKGDbKWo0GoSnk=
X-Received: by 2002:a25:6a85:0:b0:d99:d1b8:672f with SMTP id
 f127-20020a256a85000000b00d99d1b8672fmr6036146ybc.33.1696928937928; Tue, 10
 Oct 2023 02:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231009-strncpy-drivers-net-dsa-realtek-rtl8366-core-c-v1-1-74e1b5190778@google.com>
In-Reply-To: <20231009-strncpy-drivers-net-dsa-realtek-rtl8366-core-c-v1-1-74e1b5190778@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Oct 2023 11:08:46 +0200
Message-ID: <CACRpkdbkhQZn5zF1Qx9JyoW8p6KMuMx9PkOrYEzKVs2xAOzH0w@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: realtek: replace deprecated strncpy with ethtool_sprintf
To:     Justin Stitt <justinstitt@google.com>
Cc:     =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 12:47=E2=80=AFAM Justin Stitt <justinstitt@google.c=
om> wrote:


> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strn=
cpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.h=
tml [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
(...)
> -               mib =3D &priv->mib_counters[i];
> -               strncpy(data + i * ETH_GSTRING_LEN,
> -                       mib->name, ETH_GSTRING_LEN);
> +               ethtool_sprintf(&data, "%s", priv->mib_counters[i].name);

Not only does it harden the kernel, it also makes it way easier to read!

Way to go.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
