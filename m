Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DA47E1BD3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjKFIUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjKFIUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:20:45 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D039FBB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:20:41 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-4abe6a78ab2so1357406e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 00:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1699258841; x=1699863641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3T4kfamSxdgUWeGX07iWKCV1k5yLjv63beDfNBxqvQ=;
        b=Yh/jGR3iF+HcxqFK0uiotjoKgFyBFJYIpMOjp0AVxLohi6BwFKdkNBqB4w986CcgpA
         NFItXJXoq2J+yXqUfw6S9CqyBA1qN0Xjo9TlrEGferikhKeKDmFEMEx4yu1lC09kensi
         jl7HFwRaeNJcf7l3t07B6NyxES4LQZOJpQYnBOCi5OrYszvSaSUIq8zqRso95D/4ccxY
         ZMTRLpsM7OEffMvTKh4Nc0PG1jinxTlD9n8kssQE74adnMUvckU0jDQj67xrJo4ZAh7y
         we4WofnMAwZe/Yv8iClU0oCGLfU5dNBmNYxsMAFcMnxi1utMLcitPbqi1zS2XUplnpav
         czxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699258841; x=1699863641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3T4kfamSxdgUWeGX07iWKCV1k5yLjv63beDfNBxqvQ=;
        b=sbw306An8eivzKmETJGmw63l2s9fZhhzDl2UsHOZRVi56ECRiLfk8YXXYfSqswi1LF
         TpUxlM/XTDBC879zaf5G8s+Ub2QhrvodoUIjWCvZuUlG82tMqQAEskeMRYMZjtJBanNp
         7VzfvfCH1p4QNfmioGwRu80ahh8iPkSm5vLGQ4SpsCvl9JI+Wp5j7OknIjhNWuiY+9Xs
         Wd0j3EF/++xddzRKQ3Zm31e1XvFVyW6m4ul7q6g4/DDTnP4hlhbNkqgFTNitn0vSLPL4
         R4sHMd9HPOFzoeWxxRQdPEcgHSN/II7Rycdo2ytOTDDraQRQ3Hc9s52xZGuueujrwEvt
         Z4Gg==
X-Gm-Message-State: AOJu0Yzk4cg8zL0+ryjaTyoYazdTi0ZnGCKcsKhvN9IsRxJqO6fpCEWG
        0wUzQ4PE4AKsSUWlyF78OvxAgt0UBW8kowo3zVj4VQ==
X-Google-Smtp-Source: AGHT+IGR1qosCgU2eR2zoO1d7hC+PXzFV8HkqWsrwoHyGwmWKxItKjbLbhKSDU331sk57pkSXY5sZbKztne/A5P1+Oo=
X-Received: by 2002:a1f:1305:0:b0:4ac:49ea:9156 with SMTP id
 5-20020a1f1305000000b004ac49ea9156mr1800150vkt.2.1699258840912; Mon, 06 Nov
 2023 00:20:40 -0800 (PST)
MIME-Version: 1.0
References: <20231104-no-y-uapi1-default-v1-1-f60d318b6fbe@linaro.org>
 <ZUbsAhXyk-d4R2M9@rigel> <CACRpkdYP7kO99wV2q8=2q-Q-jgDQf9JHHVdLZEs1tN7AmQF5EQ@mail.gmail.com>
In-Reply-To: <CACRpkdYP7kO99wV2q8=2q-Q-jgDQf9JHHVdLZEs1tN7AmQF5EQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 6 Nov 2023 09:20:30 +0100
Message-ID: <CAMRc=McZGW698rCECoNGw32mroT=_cNtFTpE4XN_zbHDY81ibA@mail.gmail.com>
Subject: Re: [PATCH] RFC: Do not enable the v1 uAPI by default
To:     Linus Walleij <linus.walleij@linaro.org>,
        Phil Howard <phil@gadgetoid.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 5, 2023 at 4:39=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> On Sun, Nov 5, 2023 at 2:12=E2=80=AFAM Kent Gibson <warthog618@gmail.com>=
 wrote:
>
> > If you want to provide the end user with two years to migrate, and give=
n
> > that libgpiod is the major consumer, you might want to hold off for
> > another year.
>
> OK then, just testing the waters.
>
> Probably we need to encourage libgpiod 2.x a bit.
>

Thanks to Phil Howard's work on python bindings, they should soon be
more widely adopted. They are now the first thing that pops up in
google when searching for "libgpiod python" and now have a proper
homepage in pypi. Running 'pip3 install gpiod' will now work on
systems with no libgpiod installed too as it's vendored with libgpiod
v2.1 sources. I also plan to finally get around to using breathe and
exhale to produce proper sphinx docs. So hopefully we'll start getting
traction soon.

Bart
