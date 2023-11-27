Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CC87FA460
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjK0PZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbjK0PZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:25:35 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7CD135
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:25:39 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9ffef4b2741so585341066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701098736; x=1701703536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFaRky8SH2nzDL09jU7hfFgInTA8lMAJYDsp98sTKqc=;
        b=nxQc9QJDNPT1ncUZNV/OPQmXCbjxi4E86Kf4QN8plo9rKoz9NUEZW3gAMOxv4lmST0
         szq9i9y1BrXLaDJHTSHE7xwQ+sd2C87snINveLPgOCddACHH0XuWH+OQB6wVDK0K+hEG
         522uUgmmlJVvCNC1NOVqP6eH7oL6j/4EUuy+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701098736; x=1701703536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFaRky8SH2nzDL09jU7hfFgInTA8lMAJYDsp98sTKqc=;
        b=nKIo5geZMTPbHIz57eWNJlgKyFHtLJjKj1a4F9UQfp0lb9uNWqc9pT7Om3S75d8eLH
         hx25YwpImnDZoUl38ONmCEx3LNOOHziz2FVkPvDh2pHzlLh9lnCsXnKL3PsN/l8rZ8Lc
         JSJduOetePYYWa1J76MMpdbWOCXhP8vyjEAMp3SbSEuH0AdjPNejmpD1+OYbYmzXEHbM
         tTinnwwCDGCCb8rroJJtEk/fVGQgPVNbA4qVItBa+loXFuKHQz1l+PUZ9bjtOrn8OutS
         QAGMW04GETTQJj5yQOcMemRiMrefcyiTUctJIIyezYB0Qj4zHGByscDR6LIxyB2FTwLA
         U3pw==
X-Gm-Message-State: AOJu0YwCatXtdKAZ/3hfSiEAIE4gFdb02zXA+mCx7pH2XZM8rMCNxa32
        khaPL5Q8BnCssN7tW3Cla1LXoXyTYO+budrXy/6jwA==
X-Google-Smtp-Source: AGHT+IEpfijGo4jeSvxOsd6OhkIwvo9WZxxHPkJkotADGrJkzFyK/VQHS/m21CmrMVKqfHi48weM/g==
X-Received: by 2002:a17:906:c285:b0:9be:d55a:81c5 with SMTP id r5-20020a170906c28500b009bed55a81c5mr9371946ejz.60.1701098736567;
        Mon, 27 Nov 2023 07:25:36 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id r22-20020a170906351600b00a0c01560bdfsm2998958eja.139.2023.11.27.07.25.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 07:25:36 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40b422a274dso75515e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:25:35 -0800 (PST)
X-Received: by 2002:a05:600c:3c83:b0:3f4:fb7:48d4 with SMTP id
 bg3-20020a05600c3c8300b003f40fb748d4mr587134wmb.3.1701098735390; Mon, 27 Nov
 2023 07:25:35 -0800 (PST)
MIME-Version: 1.0
References: <dfb1a9a26d7f974371ff1d3e29eba80ef075d465.1700913863.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <dfb1a9a26d7f974371ff1d3e29eba80ef075d465.1700913863.git.christophe.jaillet@wanadoo.fr>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 27 Nov 2023 07:25:17 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Ui9bpzkn1EP9VCWGkk5+Q2E9D7QHxPy=2x9avMuNqARg@mail.gmail.com>
Message-ID: <CAD=FV=Ui9bpzkn1EP9VCWGkk5+Q2E9D7QHxPy=2x9avMuNqARg@mail.gmail.com>
Subject: Re: [PATCH v2] kdb: Fix a potential buffer overflow in kdb_local()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Martin Hicks <mort@sgi.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Nov 25, 2023 at 4:05=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> When appending "[defcmd]" to 'kdb_prompt_str', the size of the string
> already in the buffer should be taken into account.
>
> An option could be to switch from strncat() to strlcat() which does the
> correct test to avoid such an overflow.
>
> However, this actually looks as dead code, because 'defcmd_in_progress'
> can't be true here.
> See a more detailed explanation at [1].
>
> [1]: https://lore.kernel.org/all/CAD=3DFV=3DWSh7wKN7Yp-3wWiDgX4E3isQ8uh0L=
CzTmd1v9Cg9j+nQ@mail.gmail.com/
>
> Fixes: 5d5314d6795f ("kdb: core for kgdb back end (1 of 2)")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Changes in v2:
>    - Delete the strncat() call   [Doug Anderson]
>
> v1: https://lore.kernel.org/all/0b1790ca91b71e3362a6a4c2863bc5787b4d60c9.=
1698501284.git.christophe.jaillet@wanadoo.fr/
> ---
>  kernel/debug/kdb/kdb_main.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
