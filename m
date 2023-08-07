Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84ED677309A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjHGUpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjHGUpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:45:16 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5F310D8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:45:14 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d0728058651so5277318276.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 13:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691441113; x=1692045913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rE1MWVaat/AiNtyFh/LjesZXl9uJfxK9Zc1szYm1w/c=;
        b=Kgk2aYszqQy41q1ZUVv94elAKhN2boLrcVajcKDI27FomlD7fI1FgkUh/l6pkpYtLb
         PCJx/6jdy06kQlTn4ky+T9m4cwmEpycvBlDex0GgcnAHGxl1Say/z7hsapnYgl8L9Vsw
         O4c6CENLA8DoGzzg5TH6zJmmhWc5HmKwYbqqODwQ5zEb5vbzptwDYuDv6CXLOZfDQBas
         OLiZeylF3JMo51omqs/HudQBr0VnB95lwF6kQcP9Zv0RuxgVXvUIAp5Ye3uOLNtYfQKZ
         LkvGHV6NLp6w78DCkZrSO/JkM7ML6dN+hhscQ5EeTg9GDt3IBbnwtCd1njIDd6SXcmKE
         LiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691441113; x=1692045913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rE1MWVaat/AiNtyFh/LjesZXl9uJfxK9Zc1szYm1w/c=;
        b=YL0NZDENr3cxi37lEVrJCHU5SxI6Ww7mp8L3EGLqGzx4GqL0C7EYfyqej7tYadbv37
         xhDBOwNqQ5uq9XurU5mwO9oASZ/fRFCLjDfhNhmmJzMBRXZDR6YkWslgWW94RnP1Kwbr
         oU8o7IsKwL4tAyp+QB4slACkK+Sm16+yWJfUtIFCi/saa1xLOsIfE8dCrpKvJNbeGF35
         ED3eBSOBNzkVVjLfwP+ithYIZkXCwxuB0wUfr8ZV9fTTITrMFnq4574pFdWQQdPlR4gX
         /U2lwnaWJjBVSkVwNPT108bOY3eJkFPKxlMs3eSLslKnqGVyMA0aokdtSaVMGXi+XC6B
         x2Pw==
X-Gm-Message-State: AOJu0YwlY24OHOOzqrgH/82/VNGpRcLiB7dl/eZ0acepDzDsqwhNjf5T
        FO6c7wF1Kt4EArkpO+er7K03rj8v28bqzvXgpDqd9w==
X-Google-Smtp-Source: AGHT+IFLElI8ebV0rp+YGdgbtvDnbtDTc41M6AdOaK7Ioap0j8cOz4gPwnVdYVhs+HohtNkdzYvuZcOzHyo2Uv5q5M8=
X-Received: by 2002:a25:8c88:0:b0:d51:e4d7:e061 with SMTP id
 m8-20020a258c88000000b00d51e4d7e061mr4727293ybl.7.1691441113283; Mon, 07 Aug
 2023 13:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230717201652.17168-1-mario.limonciello@amd.com>
 <CACRpkdYoxoZ0G7QzQ7XV2FPh9gUJG-CKfpFY1xNQdbBcJOQ=3w@mail.gmail.com> <87eada13-004a-4dd1-91fe-901cfdfd7992@amd.com>
In-Reply-To: <87eada13-004a-4dd1-91fe-901cfdfd7992@amd.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 7 Aug 2023 22:45:00 +0200
Message-ID: <CACRpkdY8cH3pAcQZCEOV=QN+iAE6hBoD+3ZJ2C4VGD0R5FP2Jg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: amd: Don't show `Invalid config param` errors
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 8:17=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
> On 7/23/2023 14:41, Linus Walleij wrote:
> > On Mon, Jul 17, 2023 at 10:17=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >
> >> On some systems amd_pinconf_set() is called with parameters
> >> 0x8 (PIN_CONFIG_DRIVE_PUSH_PULL) or 0x14 (PIN_CONFIG_PERSIST_STATE)
> >> which are not supported by pinctrl-amd.
> >>
> >> Don't show an err message when called with an invalid parameter,
> >> downgrade this to debug instead.
> >>
> >> Cc: stable@vger.kernel.org # 6.1
> >> Fixes: 635a750d958e1 ("pinctrl: amd: Use amd_pinconf_set() for all con=
fig options")
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >
> > Applied for nonurgent fixes.
> >
>
> Just wanted to check if you'll be sending this out for -rc6.  It
> backported to stable and a few bugs cropped up because it's noisy.

No, nonurgent means I queue it for v6.6. Fear of causing regressions
on mainline is the reason to not send fixes unless they are urgent.

Yours,
Linus Walleij
