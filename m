Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9130F81346A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjLNPPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbjLNPOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:14:53 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3611732
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:14:37 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2888c80994bso4807088a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702566876; x=1703171676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWqMHpUSkAPDn3wm2z4jDOhMdXvzCuosczZCAgcr4kM=;
        b=ltvDi11omEnn5qaqbSVvMf92ELR8bE6qNn/++dxsVNOur3z8xo7SAIKQJ/fL+IrpqW
         +X7iCi5e3BoyXyokbX4BkYjJz8zPO3FPtbEyQGgS/DGcCbUw7bW4e1w4kdwTQutKWiCC
         dmHh/sfjBe52v+3QEvGNV7jqM0OBjYaskaThRqMLsArR3TW5DDjHXazJfYkvhli7OgPk
         3b+dcl/04RMP670Ur/uBVW5FlQXFwO5pzfIPifD8iLQMGBe03KWGhTDYrzzy3ATvOJje
         IuixlPuB8/xBPIVcvKuMpLKxwruxCmshCgKVOt3Zl2r9ZcuGIkp+xPgYiD0BXUTF7k4h
         lQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702566876; x=1703171676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWqMHpUSkAPDn3wm2z4jDOhMdXvzCuosczZCAgcr4kM=;
        b=BxoJvjEBsfy6iirKj3nkORdTBJuQAgu7BYL7l2X+dmiOjpf0Iw1eb+ylwXRSii7zCl
         R+I9TMSEJ2vXsK4tWO/rUfzPJwFuV3oKI3Nok9oBzrAlxTwYRzTg2ojW303UibfB2BuR
         dfyT6YzwtwvafnDbCmC1Z8RcuJ5tCCH5mmeP3YNaiTUvgbltxNh4E4EidHvrlA8xU1tY
         gg4wKOapBi6XtfsFBi3VQDTi7m2t5XcSpFNyEJvxzgJ83EBsJbTaGlEtyo0TNOMyjAZn
         pjr+hWNYCRjxal3sucAZnam6mJPoJnOyChuhlyJpPMn8/J/x99Egm/sTwcEzQ+z2Nymg
         raVA==
X-Gm-Message-State: AOJu0YzPRe1utwfqywH6blLQafx3+hf/2GFxt+Ih1bTxC9o40GYZ6VyK
        SDZ8FrRq6TSQUNPkpF5XZgjCyR/J+Tjw9W2W31aHvA==
X-Google-Smtp-Source: AGHT+IEM9NOntXhLmCrjcoIuQ47Pfui0YztUJd6OSshayTkyxMrEa+wi5LDmzXV8P+FrMsH0LnE9quA35R9O9TaR7Z4=
X-Received: by 2002:a17:90b:3697:b0:28b:d51:e7fe with SMTP id
 mj23-20020a17090b369700b0028b0d51e7femr354699pjb.64.1702566876603; Thu, 14
 Dec 2023 07:14:36 -0800 (PST)
MIME-Version: 1.0
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org> <20231214105243.3707730-5-tudor.ambarus@linaro.org>
In-Reply-To: <20231214105243.3707730-5-tudor.ambarus@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 14 Dec 2023 09:14:25 -0600
Message-ID: <CAPLW+4kBPj+f+aedr3yq_KTg7V7NFjK3RzFMypeYdQ-eos-NAA@mail.gmail.com>
Subject: Re: [PATCH 04/13] dt-bindings: serial: samsung: gs101: make
 reg-io-width required property
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     peter.griffin@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
        alim.akhtar@samsung.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        s.nawrocki@samsung.com, tomasz.figa@gmail.com,
        cw00.choi@samsung.com, arnd@arndb.de, andre.draszik@linaro.org,
        saravanak@google.com, willmcvicker@google.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 4:52=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> GS101 only allows 32-bit register accesses. When using 8-bit reg
> accesses on gs101, a SError Interrupt is raised causing the system
> unusable.
>
> Make reg-io-width a required property and expect for it a value of 4.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b=
/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> index 133259ed3a34..cc896d7e2a3d 100644
> --- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> @@ -143,6 +143,10 @@ allOf:
>      then:
>        required:
>          - samsung,uart-fifosize
> +        - reg-io-width
> +      properties:
> +        reg-io-width:
> +          const: 4
>
>  unevaluatedProperties: false
>
> --
> 2.43.0.472.g3155946c3a-goog
>
