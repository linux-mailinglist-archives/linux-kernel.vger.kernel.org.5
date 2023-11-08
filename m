Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140D27E5935
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjKHOho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjKHOhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:37:43 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406C81BC3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:37:41 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7c011e113so85382767b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 06:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699454260; x=1700059060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pLSEcA2VjED8h8cG+iJ0qpM0EKkiOxsur6HDc4UGXc=;
        b=ORh2+4K988j+MAmJWIUWRmvI6fBRKSTeI851p/58f5nqTcfM1y67km1wUMJW3iWiL7
         s46pV2O4/mNCdiO1iMop0taAEbkTVKA2RIaMv0Abh70MqDdKqFV3XbbwpFk6xeEdKANx
         9fINI+jZwldgd045rTGFBC6GpDep3PJJ9JUWl5N49UQaz6Z0CL0DJrKjwA91oJmrCSyr
         aYhjM7y2O0v1P7rOpYDWYRSn6PtzxNOEw72cNofQ0iqnFsM9TSS2qLmZv8Mh4MRvxyKq
         5c9eMh/6C5EtG6wLPeV3taimaWo3rXmJUHHxvtxZt0KUbi1bWyQuAncM/Li7FIcjDwle
         mtpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699454260; x=1700059060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pLSEcA2VjED8h8cG+iJ0qpM0EKkiOxsur6HDc4UGXc=;
        b=iXdDfX3pOQrQLfg3C8ShSN3J1nrgwjgFu4vjXuPhU96uNKuCrEyUxpdwhbH4WpwIsQ
         qq6t+y0gqcfxV/NkICkYdzQzF6mGyUwqDmazYCFkWQeKLsluqwn5gAmkuv7YZxWL1XFf
         4y4nd4Wl/2gb+4BftQqT/D1kw/T+UUFjVh/nYnaEER01qsJNCbEPrCseQnzBcsCewPrw
         xFWBSgrmqhDL31R7Fd9NDWnhbo2WiOL8DL+KBzMSotNeIDRaUhQdgrK09C9WMlA0IItN
         Affu7reUCtMYdS3BMzAOoZzjTQYMPfSylbGdoj1n52ZdcvuwGKa0u/Ymh1IatmfGBi2h
         01sQ==
X-Gm-Message-State: AOJu0YzM0kTB8Vjq8Q8jLJqYZFZkKG68T4luSXkZrQlNG6K+lUzM9Xtt
        +/oUlFpHPrn7hIb15wMVfIERibInaJ06/wNnbVzBJQ==
X-Google-Smtp-Source: AGHT+IF55MrY2C8gUy5UEgkOtPKa6Oi8mTKtSV1L4rKV0gjIZlPg1ZoEvJYa2FVQjNUppNOqvXM7P0/6857Jez9ndOc=
X-Received: by 2002:a81:48ca:0:b0:5a7:a81d:e410 with SMTP id
 v193-20020a8148ca000000b005a7a81de410mr1971187ywa.18.1699454260465; Wed, 08
 Nov 2023 06:37:40 -0800 (PST)
MIME-Version: 1.0
References: <20231107-gemini-largeframe-fix-v3-0-e3803c080b75@linaro.org>
 <20231107-gemini-largeframe-fix-v3-1-e3803c080b75@linaro.org> <20231108142640.tmly4ifgsoeo7m3e@skbuf>
In-Reply-To: <20231108142640.tmly4ifgsoeo7m3e@skbuf>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 8 Nov 2023 15:37:28 +0100
Message-ID: <CACRpkdZ0zH6i8xuZGXq2VEd7brp-dmY89KXmKfxMTk=9eX1EQw@mail.gmail.com>
Subject: Re: [PATCH net v3 1/4] net: ethernet: cortina: Fix MTU max setting
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 3:26=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com> =
wrote:
> On Tue, Nov 07, 2023 at 10:54:26AM +0100, Linus Walleij wrote:

> > The RX max frame size is over 10000 for the Gemini ethernet,
> > but the TX max frame size is actually just 2047 (0x7ff after
> > checking the datasheet). Reflect this in what we offer to Linux,
> > cap the MTU at the TX max frame minus ethernet headers.
> >
> > Use the BIT() macro for related bit flags so these TX settings
> > are consistent.
>
> What does this second paragraph intend to say? The patch doesn't use the
> BIT() macro.

Ah it's a leftover from v1 where I did some unrelated cleanup using
BIT() but Andrew remarked on it so I dropped it.

Maybe this twoliner in the commit message can be deleted when
applying?

Yours,
Linus Walleij
