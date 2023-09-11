Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7CF79C09A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359023AbjIKWOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbjIKIxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:53:30 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08671A5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:53:25 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d7830c5b20aso5775284276.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694422405; x=1695027205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uSuFkePcllXheKKrDKtEzRTd0oahV94Bg0tqz8sFvE=;
        b=EbMFixh28wQ4GZwVv4qxTXqipReLUX44kj/GBs9Y3Kx1i/SQvQn3OJj1Zl59gX52Lx
         Hjy/2uuPdX/VAXD3fIhJRcwEvlOHQdP1CI2fPCqKa/jFAHbA9a3a57XrYNjB1+6osOzX
         Z0J3wHkunK4a6WvJJg6v5L9H332DAyi5Djbxk4VBKdyJyFgLgrJV9KQP9TCAhTh+Hx2V
         jdP+hFcA5/M1YZ4oFC4llgfNgMx0XWWw8rLOWg6VVlas28Km3XQFsu9Fip8MU0xfMheH
         hUossyIQORJQLlN6Oq5b/+8YZWwonak9Jc6fBJvN8lP13RX/GxYts/iDUpr2eaDKWvZu
         BeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694422405; x=1695027205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uSuFkePcllXheKKrDKtEzRTd0oahV94Bg0tqz8sFvE=;
        b=J2QIXG0G7DD9kMhsepkh23CXTfv9SJudYsdKCvJFFqWJzvY+zCzCZAAooBE0Q6A9BQ
         qS9cE8mD9fwORwBsjokMJgrRLy/NZY7pQ4NPjZaO92OEaytm1osZUp2SlRbSOjl7kti5
         HClfPr/BO6Q9EQxMRIsum8hxB+QK6XyXLqvmk//lNUDTXRIylXAOOeGyL9IDgKuPfGmc
         YzaEyxX3bZmmUbHYM8IDDj/0lpSSP180R0zBATVEaL3ZNHammfrVk02BMNu6Uy441Wmr
         f7uSu1kKb0JKDYsdJa9lCmj6pUeggklzSGDlP+pzVbIjHOUKof/+ts1bYyUn5Vq+lseO
         h9mg==
X-Gm-Message-State: AOJu0YzzaiDBoLs0eFG9nY9IlHukEeu7HLSN50vOJKvgwgZ9q3dPwsPQ
        l7/HS/eGAV7wYtsyNq/bHIICtwxbRMq79fk5v4c/Dg==
X-Google-Smtp-Source: AGHT+IEpUVQ6pAi/5PvV7lvoYO9nqoagoZuqIl8EkSZivs/K/vJ4a0Wlk0i5y7BwzCtKeUmkF3ktqnt3UTq/4vNP5sA=
X-Received: by 2002:a25:db0f:0:b0:d71:c79c:86c1 with SMTP id
 g15-20020a25db0f000000b00d71c79c86c1mr12790563ybf.32.1694422404707; Mon, 11
 Sep 2023 01:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230824105703.19612-1-tychang@realtek.com> <20230824105703.19612-8-tychang@realtek.com>
In-Reply-To: <20230824105703.19612-8-tychang@realtek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Sep 2023 10:53:13 +0200
Message-ID: <CACRpkdbSwF-9kuz4dLbRZiAFUB9qXvxAUXyin2BxLtq=hrzwSw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] dt-bindings: pinctrl: realtek: add RTD1619B
 pinctrl binding
To:     Tzuyi Chang <tychang@realtek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Aug 24, 2023 at 12:57=E2=80=AFPM Tzuyi Chang <tychang@realtek.com> =
wrote:

> Add device tree bindings for RTD1619B.
>
> Signed-off-by: Tzuyi Chang <tychang@realtek.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
