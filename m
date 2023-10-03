Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0DC7B72BC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 22:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241087AbjJCUt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 16:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjJCUt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 16:49:27 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97895AC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 13:49:23 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a1f00b75aaso16412097b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 13:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696366163; x=1696970963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FJPUi+MyKd+dVlpPJp8bCnu+4EByJ0OLEwCa+47Woc=;
        b=iQuYNBszchRggbd6WjC55XwIUE+gyP/TU5N/kmIZaDYm70LI6NqGfn1UzzGQi/tXaC
         unkpbqBS7c5TR0yJ34a/OdFb6FwQGjNMHrtiChKmpUdtQCegM+xuJFjXIyxhogSnEOVx
         f26/hvizaKpAkmFIm1A/4kf2HJH2EeK6AnHz6qFCS4zZ0nSd4HzZaJKAsangJS+fKZpx
         NKdPdSMYeri8z2PiYed0NaWLcGBNQxM0in4EPXL9IXKevIrM+Hq9rt3RT78KM/x6JGBa
         Tb3y3iF37kLVIha2+xdHhdSURKn9Am1vl3H9Sis0/kn4+jXgoo9p7wHMJQaFZZFxHdBL
         Dspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696366163; x=1696970963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FJPUi+MyKd+dVlpPJp8bCnu+4EByJ0OLEwCa+47Woc=;
        b=UhQiZVKBt73lrH4jTcDxN4Tj/Le/77kT6pgm9QorPpQB7vPSZWtPpXvN0IR/IW+wwY
         KWZcVbZugA7TegFYdtJIkAEM/VCxSFCnQ9FBrJuTaPyUnJqfoZVOxsuvQi9ES5GB3Mn4
         QHnbTn9/ZFGHFWRh+WzzIFzZsRVMePZm0WIUKNDS6Q3nuZ6v1XXIK9oS/vvFQeZ/ij27
         kEIv7+Qv5IqK0hVToekaK1ARtNKHVyyE0gDDmbLxDRliDMfE3i5pLlQztbuNcWOjkQ95
         dAgCEG9jREyiMBT0Pny+pB3ggEH28UvNMq+zlhpl37kYVRn9S+ZtIr4PuZwdyLRoYQhX
         v6nw==
X-Gm-Message-State: AOJu0YxLuZCowrRCP2E4QOEJKRndzA78PypTXBQVhuyiGYhihO+19MJs
        b0I6gFDaJXNkPVJaqZDJODAhhLyyMejuCkRgH1QNqg==
X-Google-Smtp-Source: AGHT+IEreLlAAb1BEaIqmVOi80nv6yIE6GNZPrSiU+SaEd9snYNzmyb1GnIOcQcstQN89h5TnTmEDXhfiAWNkiQFVLc=
X-Received: by 2002:a0d:e215:0:b0:573:bb84:737c with SMTP id
 l21-20020a0de215000000b00573bb84737cmr740029ywe.26.1696366162811; Tue, 03 Oct
 2023 13:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231002021602.260100-1-takahiro.akashi@linaro.org> <20231002021602.260100-2-takahiro.akashi@linaro.org>
In-Reply-To: <20231002021602.260100-2-takahiro.akashi@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 3 Oct 2023 22:49:10 +0200
Message-ID: <CACRpkdZsQN5V0Nt46dQmUiQo-co81Z_TrzWW_9CPJEbF+X-vnw@mail.gmail.com>
Subject: Re: [RFC 1/4] pinctrl: define PIN_CONFIG_INPUT
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Oleksii_Moisieiev@epam.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
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

Hi Takahiro,

On Mon, Oct 2, 2023 at 4:17=E2=80=AFAM AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:

> This allows for enabling SCMI pinctrl based GPIO driver to obtain
> an input gpio pin.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
(...)
> + * @PIN_CONFIG_INPUT: This will obtain a value on an input pin. The retu=
rned
> + *     argument indicates the value.

We need to specify that this is the inverse of @PIN_CONFIG_OUTPUT,
that setting a line into *input mode* requires the use of
@PIN_CONFIG_INPUT_ENABLE, so the config can never be set
but should return an error on set, and that the argument returned is 1 for
logic high and 0 for logic low.

Otherwise I think this is fine!

Yours,
Linus Walleij
