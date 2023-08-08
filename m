Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3E37742FB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbjHHRyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjHHRxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:53:51 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220022A8DF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:24:02 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76ad842d12fso450818485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691511835; x=1692116635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YwNCnLA4BDgyiFzQID8GItNEy8vbOZgDk2M81TSduC8=;
        b=OUQYfKb2mSTAxKJv2UXLoBW8SJaDxksWYZqxLk9l7X3g8TEUV1tP/6a4eHLk4FFa4M
         9zXGKcJEkswytRe7gikgctHO9AF5NtmL6P6KM04x4vv1sUobNo5Q7Ep7MmmzdipphDKd
         rqknnmZoZ/XzsagAixddTlK4loOHAgc9G7Mv12ZaLV7p3wUPKGHjaRENbEe3B79kc3Cb
         es/OFJY5xrJErqcllDAIROy93iSybo06G5AzOAN3P8Cw6DoowX2wlI5DZkSSdtTSdlUm
         FkI2jPC34f/OdmVb/EO8m23WidZQwfjS/QPYKvuFcD98m7WBPdEHmCJFDlTCfC6I5ezi
         UonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511835; x=1692116635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YwNCnLA4BDgyiFzQID8GItNEy8vbOZgDk2M81TSduC8=;
        b=SJiTwyA9dtCBz6sTwLEMvx56HWN5nRMcWWuOpRG9lfvIONqGIcI2BfTBQE5WzB67W/
         IqN7JR8niDUEPHWHANWO8bITH6zc+HTpo0ikJjowRANNHanywkCJlQNyj6+HAnfh+tKV
         cHW2T1FQFFcOxYbvXFO0tBMJxYVsWMpwzlpQ9iG+kzvQpd6dtrj3OaCn07ZjxfjzQ62A
         ErJ4jqLd+lAtQ1ENpb8XqTJtZCgHVB8alfkLELxlXQGWEYxQfckSjm4ZzOUE9FapNVuY
         WMZtFNfYSEE104pO1TlVWiQ/ju13n4XYAaHv4oUWmKTvxBmJWQMit6BOuoTz+47U94FS
         lswg==
X-Gm-Message-State: AOJu0YwG8MSn6FbzDFPj86vG40SNcDgpfA1ccFvJ5XOn8Yn8HGp/PI5w
        H3rgVfQalKQk8CpyB3lsfwt2AQh/ANiHxkZB5emBO3u/0FzpodLt
X-Google-Smtp-Source: AGHT+IG9EEqlXpXWekaLAYR4RRWGuO58HRpkGWaCiIehSEMsiNiSZuyy3X4+ishH9SYGOyW6zxa/y5LIsjM1cUS7rOQ=
X-Received: by 2002:a25:24b:0:b0:d4d:b6de:69bd with SMTP id
 72-20020a25024b000000b00d4db6de69bdmr7351002ybc.23.1691484651033; Tue, 08 Aug
 2023 01:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230728102616.266235-1-varshini.rajendran@microchip.com>
In-Reply-To: <20230728102616.266235-1-varshini.rajendran@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 10:50:14 +0200
Message-ID: <CAPDyKFoeLar9SRiq_dusmo0ZQGoeqKygi0Y3HOPQ8FO+BaaCTw@mail.gmail.com>
Subject: Re: [PATCH v3 19/50] dt-bindings: sdhci-of-at91: add microchip,sam9x7-sdhci
To:     Varshini Rajendran <varshini.rajendran@microchip.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 at 12:26, Varshini Rajendran
<varshini.rajendran@microchip.com> wrote:
>
> Add microchip,sam9x7-sdhci to DT bindings documentation.
>
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

Applied for next, thanks!

Next time, please convert to yaml before changing the bindings.

Kind regards
Ulf Hansson

> ---
>  Documentation/devicetree/bindings/mmc/sdhci-atmel.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> index 69edfd4d3922..a9fb0a91245f 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> @@ -5,11 +5,13 @@ Documentation/devicetree/bindings/mmc/mmc.txt and the properties used by the
>  sdhci-of-at91 driver.
>
>  Required properties:
> -- compatible:          Must be "atmel,sama5d2-sdhci" or "microchip,sam9x60-sdhci".
> +- compatible:          Must be "atmel,sama5d2-sdhci" or "microchip,sam9x60-sdhci"
> +                       or "microchip,sam9x7-sdhci", "microchip,sam9x60-sdhci".
>  - clocks:              Phandlers to the clocks.
>  - clock-names:         Must be "hclock", "multclk", "baseclk" for
>                         "atmel,sama5d2-sdhci".
>                         Must be "hclock", "multclk" for "microchip,sam9x60-sdhci".
> +                       Must be "hclock", "multclk" for "microchip,sam9x7-sdhci".
>
>  Optional properties:
>  - assigned-clocks:     The same with "multclk".
> --
> 2.25.1
>
