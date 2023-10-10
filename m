Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927527BFA67
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjJJLyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjJJLyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:54:11 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAA69D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:54:09 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a7af52ee31so14899947b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696938848; x=1697543648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDIZK2JgNL/4fmh5x4TEGivcbBKztGUQajvuvg54oRA=;
        b=a3VQbTEnJC+7cQjfm4S3VJSjObAz82XvDeqHRINZQaneF6XoXRHsb485kTU/hN14ri
         b7ZvpsrLHqs76+NuIoB4aCxDTmv7Vg1eJWgNYdGRfkt0QeUAOrkEOOzB/NfYa6U1EdTt
         nEDluPz5zLj49F6p3MHDvgXNJ7v55epocWrexgwapHRfsybvUuJ2WlioqQWUE0IFGRaN
         4rBR8KBrZeNW/3jXVOAxYrbiBLpmuAD180mNTaD4cFkxMgRjvsRuc/3/XhV4z364mZ+D
         aGiGOWji/s+PTsq7YTgphaNt8nhik0om5nq6PACZ7pGkAJb0VNZh2I7Fk2iu56GoWI7o
         dIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696938848; x=1697543648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDIZK2JgNL/4fmh5x4TEGivcbBKztGUQajvuvg54oRA=;
        b=TxPQHqTUNW6qj4M5Y3r6zfhP+4b6LAJi9RET/DtMqb0eNvsEP6u6CQnI+nASInyjVO
         6VktNJPfqCixjX0htIzpvcVuM1zsC5GFLyG5Ampxg1/kdU//EatTyXaMttuGhIJi8P4d
         cVHnW3JpOddoUJrIHkqdRb0hDo4X3nP3G2CJvrF/sHnI1CZRUSgOUAZUJK+601ZqEJ5u
         wyQ31RuAnRrYOEXz3ZTkduTJ9RsMO75KBPFA9BN/iew7PbKCh+uXDLPfS1aAuQOdfT5A
         q5YNx2YH34cwsWYvFIR0FY90Z8v5heJAWOAo16WGio6e8MrW/CmqE9o3usvT63Abo1hy
         UwXA==
X-Gm-Message-State: AOJu0YzvjcGu2713te4AovtXgXqzykR6ekn+lTq7uqzWKwXXQ43+zDM7
        r88cZRxezLtGU8Q1mQ3W6SqZSbLwrK9iwZZBTdJxPQ==
X-Google-Smtp-Source: AGHT+IGJLeCEgyssCwkr1IRA6nE/61tJtIYUAQpXlv6Sm1fP8byIFDZgaogCvc1s1fl7Wj6hcZI7Vh16BAo3bPi/WUA=
X-Received: by 2002:a25:a344:0:b0:d78:f32:5849 with SMTP id
 d62-20020a25a344000000b00d780f325849mr15719479ybi.24.1696938848554; Tue, 10
 Oct 2023 04:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231005025843.508689-1-takahiro.akashi@linaro.org> <20231005025843.508689-2-takahiro.akashi@linaro.org>
In-Reply-To: <20231005025843.508689-2-takahiro.akashi@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Oct 2023 13:53:57 +0200
Message-ID: <CACRpkdYQefGqb3UUyoK6sf6FRUH0m_2xLDzUKO7rQ6dXyeGTww@mail.gmail.com>
Subject: Re: [RFC v2 1/5] pinctrl: define PIN_CONFIG_INPUT
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 4:59=E2=80=AFAM AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:

> This configuration is intended to be used to allow a pin controller based
> GPIO driver to obtain a value at a gpio input pin.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
