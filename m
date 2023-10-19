Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0E97CFCCB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbjJSOdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235488AbjJSOdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:33:05 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB62010E2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:32:30 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1caa7597af9so14266165ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697725950; x=1698330750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XNrx3US1TBoOT89cC/5dM/an9l4kgmeujKRHDCLupM=;
        b=IFYDZo5lAbF2e10ozpQXYA9YrKwGIuwspFDgA+0fUygPYHP5/v2JqhCVXAPVIGWlQC
         qgWDZ+6PvRDa2X/1GBKbyhbQHpyalEKtHfm+EPtsuheiljoGk1cG4b9FbHFwTECAjT68
         lu9CYAoA5A9u21MeQztev2qtCYokCoYTLt4gvOetS+byi0lnkKVYNxW/aOWr53uKOjnU
         XSzLN3Nh1b+DNkpen+QYkC+qWIYYjJkCYH4wfewUnE8XOZLieNMwtwmAzdUcmjp2ByZr
         17FJ+Ksl31izGAhRcN1+0yLsbCvzq7eguMETPKWT3j5aq5iRkawbahM5R8TEA1AFj8TS
         6ArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697725950; x=1698330750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XNrx3US1TBoOT89cC/5dM/an9l4kgmeujKRHDCLupM=;
        b=M9vLqfa4JhYoIZT6UuzX0vhyL0jP/MmWaSgQJvqEJvQNM9YJ99pdftBG4qzbv4b6G3
         K5z2F2QR2wRATr1luDs7CuwmK5rp9l7UlPNEG0p5YXUxH4hWXi7rEwVYw4KpxkLgNcUo
         AmCpKlyBGgoMaDpHfbnO0cZyHV/nGlFpMu39DW5SVNCmWoLhtLf2BFqwTfI0mKWTlTGw
         McS9rFCcuSzBe2SVJukm1UDj920f+oCl+YtqYqCineoF17cGMny4QIKSiVuiDugHeUsX
         uUgGz4nn3HhbvurNTcOuJjtjLpVmvR5URoNv92YcvjRS3+dDcZ0EwKnD09EOJqRZAPkQ
         JnSg==
X-Gm-Message-State: AOJu0YyIxhdh1YxHadqLN5GFOf4NYtmIAgJc3LeHzrDM/kNrmemFz6yZ
        RVBWmHSx3UAwGUsmjD1nB5e4hBeA3p7CvhHSzNpzdw==
X-Google-Smtp-Source: AGHT+IF0maLNEBc0Dq3xbTv91IIXRq9WGF5Xiw5WZ5EZSw0JzAXHB7waQNn5r9NmgLXvWrREApajxxBXEDUsi9Q9LUc=
X-Received: by 2002:a17:903:238c:b0:1c9:d25c:17c6 with SMTP id
 v12-20020a170903238c00b001c9d25c17c6mr2158169plh.1.1697725950072; Thu, 19 Oct
 2023 07:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231019100639.4026283-1-andre.draszik@linaro.org> <20231019100639.4026283-2-andre.draszik@linaro.org>
In-Reply-To: <20231019100639.4026283-2-andre.draszik@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 19 Oct 2023 09:32:19 -0500
Message-ID: <CAPLW+4=DG2g1=fZB9do_xb+q2ZU+BcyTgH5i15rqWoi_WUcdVQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: serial: drop unsupported samsung bindings
To:     =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        alim.akhtar@samsung.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 5:06=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:
>
> Now that no implementation exists anymore for
> samsung,s3c24(1[02]|40)-uart, remove those bindings from here as well.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b=
/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> index 8bd88d5cbb11..d45079ef7bd9 100644
> --- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> @@ -24,9 +24,6 @@ properties:
>        - enum:
>            - apple,s5l-uart
>            - axis,artpec8-uart
> -          - samsung,s3c2410-uart
> -          - samsung,s3c2412-uart
> -          - samsung,s3c2440-uart
>            - samsung,s3c6400-uart
>            - samsung,s5pv210-uart
>            - samsung,exynos4210-uart
> @@ -96,7 +93,6 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - samsung,s3c2410-uart
>                - samsung,s5pv210-uart
>      then:
>        properties:
> --
> 2.40.1
>
>
