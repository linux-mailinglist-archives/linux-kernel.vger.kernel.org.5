Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF7F7DBBD1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjJ3O3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjJ3O3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:29:44 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA23C6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:29:41 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a877e0f0d8so47430667b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698676180; x=1699280980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7wCCUpKRrJS75YLiT/U9xTHRv00wzxQlN/INc0kfAw=;
        b=q66Nu931ktcoJb0N2QYBo9Ao0W67q7tEqUw6LQbwsHZOZz+twX1F++Ae51QCDZ2bgk
         3EEKXlpj0hJoD737EFr5AiNXfd7m7UE9Bax3+1kODV3YLLzV0/3EgaPA8wPmaQigSXdD
         mLuZd290mW9I/NG3vLUKAJKE+eAoh6PNLyToyFoBY9iRtMHXbWJ0YXRWts0vQtKrEwS/
         7AIUywYr/JMDY6mSa/AVkwZyD4srqHei4grCWk2hSlu+d9CAG7x7xmPiPG0yX6pJ4uTD
         cQz3EyQEAWO9djWz67XSJNqMj4symljq+HCrvJrUCQmNw1bbWIY9bn9GWmhdvjq1+GMz
         dTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698676180; x=1699280980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7wCCUpKRrJS75YLiT/U9xTHRv00wzxQlN/INc0kfAw=;
        b=hvBpNUPTUX5DLjA7GkArWssDU9W4z5x83hG+7VkemJ6PJmXq3IowGzc7r3Q6XLwbeb
         ondnIorMFlyfLuG9S0HP27HjuvNEWpkg9sBYr4bUji3kVMrxExGNZ62JFb/1Uv7Adp0V
         YCpCYVWtAM7u/nAFxCunI7Wba607MIr1SPIjgvS48gccVXOxnTbQAj3LrE6vdl6LxUFv
         ZlIrkNn7Ku1YiIl00wgdyCLAROI55Ji90nf67bGQjHemdEI02bR74mAiKb2lf7aW6WfD
         vfhG+JYKXSMAyl5D5U1X2niUaJKTyStELhrNo3HxHgI8wtxTVfrCw7AogUX28ZlSOnp8
         sUyA==
X-Gm-Message-State: AOJu0YxiJTnUbdd1b+V9a3CXJzah6C4anXjXuapLtxsuD4Fl2HZPtCpt
        i2SbK7SJ7Tp33FDMxrWoo/GYd9NpL8s2I+GM6GRczA==
X-Google-Smtp-Source: AGHT+IHEuY8or3WBjzxVCMAjxo8ALWrphZ5RqsKs5y+czx7cWMwRa6pCbEzNckPHRz8dE0gKHScUmwC8orxs0sVozbU=
X-Received: by 2002:a25:dcd4:0:b0:d86:4342:290 with SMTP id
 y203-20020a25dcd4000000b00d8643420290mr11467610ybe.21.1698676180428; Mon, 30
 Oct 2023 07:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org>
 <95f324af-88de-4692-966f-588287305e09@gmail.com> <CACRpkdbyMEqjW1a9oK-GM2_XL0famH1RgSXW-fQLszn9t9UhWw@mail.gmail.com>
 <20231030125127.xccqwct3jgg6o2rl@skbuf>
In-Reply-To: <20231030125127.xccqwct3jgg6o2rl@skbuf>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 30 Oct 2023 15:29:28 +0100
Message-ID: <CACRpkdaPqg4X5HrLn_Nt3_FYNtd0bL4wAKWFfRXStvX9bWagYg@mail.gmail.com>
Subject: Re: [PATCH] dsa: tag_rtl4_a: Bump min packet size
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Oct 30, 2023 at 1:51=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:

> So, what Florian was asking is whether the conduit interface is not
> doing its expected job properly. You clarified that the problem is big
> rather than small packets, but we still need an explanation for the
> existing __skb_put_padto() call, given that it seems that it was placed
> there due to a misunderstanding rather than due to an explicit need for
> an exceptional case.

Hm Deng added that and it was because the same was needed for
some other tagger IIRC, let's see what he says.

I will do some tests to just remove it and see what happens.

Yours,
Linus Walleij
