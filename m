Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE717D2BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjJWHvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjJWHvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:51:15 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F41DD65
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:51:12 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9c2420e417so2838276276.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698047472; x=1698652272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwpfXuSMxW2SQUceKEQObxa1Va7HSYmmlN8vyK0Wa9g=;
        b=x0SPzP8TWH+DPfQr77Ql2yskLtJZKTK8bIJotYstSKFjPUB1x17bq6XAliStZmCSg2
         T0nHM6LbOFkUkwMc1cMQqgc8JOVQ1Nihi0Sia48WHr6x0uC/zA5uuA9hYCcpdEToOMk+
         wKYjwFA6orwPnjeNhaNA80itrbQcBmUPyWusyHH8PL1XOmHk6Pob6k9U7NvwHvAFfgTA
         vh83w/x7MCu8lJ/BW/6bo7yv76YG8xh7L0i+wUGG10XhbXcrEgnKsQJvEPSAtDOKtqt9
         wsoJp3OFO9suLPOvSywFp24515u6f/aMX1GBe9bS9L4CqCHpSyUcZPc6YBOlM2sFqgbK
         R/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698047472; x=1698652272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwpfXuSMxW2SQUceKEQObxa1Va7HSYmmlN8vyK0Wa9g=;
        b=JW/ufRbrlPl7jTY9NyrJ3x0rS0XjyVuoeziXDb/JA1wqGKCApiUCGXPdSl0aXsNYqp
         79ZXra5FRlsoIsSX6O2EFvNetlXBg/Eh7G6vLFOtp2CcDD83lzsEjF/MIK8qDf3uJ4vT
         V0y2nK2I1bqsx2mSIqZktelWI975DiK78MvkwUadcvI57ofra4XiHJKjX4K5ZauWNyAE
         w0jtuEE8HA+fxw6lrc6XYI0WJlN3HpmIcBdW66MQ7L/TZJtMxoAU2y9buW4cra3AB/XQ
         RDdP8fUrCv2IYbQxXvkA9kpi+IQ4YNflvvj+iGcSjCH+ox1GfuzIdKdqE7uFQEpcHNM9
         68EA==
X-Gm-Message-State: AOJu0Ywo7tLo15BMYcaMP0QApqp5RnL85v50urRe07jLVzwZtFFBi4ZI
        x7m/TrX9Bou2BR/bVHTiCnoYIIMh4MhTsLFQZSd6PQ==
X-Google-Smtp-Source: AGHT+IHjwVacJ7rVA2lCtIQF3l4kMyb0ZMctra14lquxIIj/j34f3PN6Hrfc6Nsb/yiuys+Hr1x5NE7foptIZcLlM+c=
X-Received: by 2002:a25:d8ca:0:b0:d81:6151:2031 with SMTP id
 p193-20020a25d8ca000000b00d8161512031mr9021111ybg.61.1698047471820; Mon, 23
 Oct 2023 00:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231023-marvell-88e6152-wan-led-v5-0-0e82952015a7@linaro.org> <20231023-marvell-88e6152-wan-led-v5-1-0e82952015a7@linaro.org>
In-Reply-To: <20231023-marvell-88e6152-wan-led-v5-1-0e82952015a7@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 23 Oct 2023 09:51:00 +0200
Message-ID: <CACRpkdZ_o0pMXZEVWfGiu2tPjv=dLMagT6KF-d=kaZ6fJZqr0A@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/7] dt-bindings: net: dsa: Require ports or ethernet-ports
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Rob Herring <robh@kernel.org>
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

On Mon, Oct 23, 2023 at 9:19=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:

> Bindings using dsa.yaml#/$defs/ethernet-ports specify that
> a DSA switch node need to have a ports or ethernet-ports
> subnode, and that is actually required, so add requirements
> using oneOf.
>
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
(...)
> +  oneOf:
> +    - required:
> +      - ports
> +    - required:
> +      - ethernet-ports

Ooops I meant to drop the patch altogether because I just
couldn't figure out how to test this.

Ignore bot complaints on this one then.

Yours,
Linus Walleij
