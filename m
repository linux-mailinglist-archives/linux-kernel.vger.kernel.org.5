Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3C0802F7E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjLDKCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjLDKB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:01:59 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA64E5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:02:03 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-da077db5145so1950995276.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 02:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701684123; x=1702288923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SeMPuNVhMcd+i2tV7F9jz2bOkHeS41/F3Z4FqdTOpc=;
        b=H9Z4qpzOy6oJDjg1tYNhhni9E/+swN+m/qXPt1VtOJlkA/BhXeDhPQ+2kFtG/Yf+EW
         15xvpspm2Ob+URYM+Ta8S0flJ3NKQxY1+yborf0CbXN4uBlRghy9Vem8F0NdH1Dvq/U0
         aFwafjHMoOl3ZvYABglfYJnVgBYwEK1kXgWlL/JV7Sf3PE1XrShTOLNLKxNC1B58cFgH
         i22pq8nsObLfHk6PE2FEpWtOBPGQ02DCmcnsYBs7hEUsxlj2LAEM47LpFeey+GTn//mv
         ytIzuN6Snkm+00X31XvmIWOSz29JE23TwYOXicFFGmauYGRrcqpj3w9s8vGXYR7uGEVS
         1dnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701684123; x=1702288923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SeMPuNVhMcd+i2tV7F9jz2bOkHeS41/F3Z4FqdTOpc=;
        b=ieLSyFXGRLKjA/xW/MT9SVC8TXMBn2VgXG88d3DhIb+CqHfp6WdWrYIkszoq63wUh3
         +c+r1sL9kmGxDt2C6+tpnUO0pslY8Uq5agmyTEwEIlnxUsnl2vvMlhJi0ex/F1vt+eT8
         gHBeNDDB02du7bg7gVxk0o9oVn2lj8ly/wF+ht26abHfaPj3rzD+FMwPgUYWSQYvLA73
         QTq3nQoC+Nr2z/0cgULODf3SiKcfRHYbyclVkmk9OKpxu6zlp18+tbHfKpLQfSa61y88
         TLXfxEmN8SCJ/eRGd70qngWnxTBe87YJtlSJoIQc/cTR3RJ/4mPfx5h6GJecEStV/tBi
         XKTg==
X-Gm-Message-State: AOJu0YxMnr4aHLySRFwDoLHLS4zPlv9pEbjB6ZHf97rB459TUTXKM/Rh
        FXA+DsHGdsWJjEfY8MhxwTW9Ays+WQ9nTmRouo6CDg==
X-Google-Smtp-Source: AGHT+IGDPWlnysLzm5EzUFh7UJTkRuai9dGFsoVIWTFX6lFcQzCAL9alL/1PxDiLEf44P7pIIhXKR4a4ne7rrwBReqM=
X-Received: by 2002:a25:40d6:0:b0:db7:dad0:76b0 with SMTP id
 n205-20020a2540d6000000b00db7dad076b0mr1684590yba.76.1701684123130; Mon, 04
 Dec 2023 02:02:03 -0800 (PST)
MIME-Version: 1.0
References: <20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com> <20231130-mbly-uart-v5-5-6566703a04b5@bootlin.com>
In-Reply-To: <20231130-mbly-uart-v5-5-6566703a04b5@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Dec 2023 11:01:52 +0100
Message-ID: <CACRpkdYMKv1EFWZtSe5iya-_gpdr3mVxVv2665A0=FEspGdjoA@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] tty: serial: amba-pl011: avoid quoted string split
 across lines
To:     =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 3:07=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:

> Remove all instances of quoted strings split across lines. Fix four
> checkpatch warnings:
>
>     $ ./scripts/checkpatch.pl --strict --file \
>         drivers/tty/serial/amba-pl011.c
>     WARNING: quoted string split across lines
>     [...]
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
