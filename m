Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED927CA11D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjJPIAT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Oct 2023 04:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPIAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:00:16 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0D0A1;
        Mon, 16 Oct 2023 01:00:14 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59e88a28b98so35301167b3.1;
        Mon, 16 Oct 2023 01:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697443214; x=1698048014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btMRsKTHsZdLmcavs42DtOcp7fEFbpSLSg3f+uNZoIE=;
        b=RCd3kHlgl9Xa7yngThkrI2YHKWGUrRD6X/Y08fnCb49bqDoNigngLO1wlL7Y1OI9Px
         MdLI41aYSOGPKNbYl7G73mJmPEgvVoJd6ygpSy/HuVRnt4FqVMQuvpZExXY6BfEnE4fi
         B7jxTKcIMhKKM8CXuKBdDLiixbZKifgrUAfgR1PA3zvQA1U+BnSY8Qc6LFmI6azctqd6
         c5WT1IcC3XL5Al0R+SW21CLWpArKE3lCX8y+c3ehpVTM4OM1Zg6hRNMDKhJDNo6h/w50
         evrQJKASFF1lJu5Xg9k4oSrluL6baPkw8yaHeRrKpwRuskvJ6HlmRrBnp7esyAzYRF+w
         fMrQ==
X-Gm-Message-State: AOJu0Yy0aNV0DnxgDCjU2ipCmNZsqWQXsrJffJTPCrwM45nDP8vEEnSc
        eDdhQDQXeNAucBsqsp9qqfPk9dPELUKhxA==
X-Google-Smtp-Source: AGHT+IGOmGWdItEcsIGoknY6yH3hoT6EX0h75yIHP6ToRIdeeRnRucIb+qzcCXu/ckiPdFd9NymnwA==
X-Received: by 2002:a0d:df43:0:b0:5a7:fb66:61ff with SMTP id i64-20020a0ddf43000000b005a7fb6661ffmr3571836ywe.21.1697443213827;
        Mon, 16 Oct 2023 01:00:13 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id n7-20020a0dfd07000000b005a7c829dda2sm2006671ywf.84.2023.10.16.01.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 01:00:13 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-59e88a28b98so35301107b3.1;
        Mon, 16 Oct 2023 01:00:13 -0700 (PDT)
X-Received: by 2002:a0d:df43:0:b0:5a7:fb66:61ff with SMTP id
 i64-20020a0ddf43000000b005a7fb6661ffmr3571828ywe.21.1697443213449; Mon, 16
 Oct 2023 01:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231016061654.22267-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231016061654.22267-1-krzysztof.kozlowski@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 Oct 2023 10:00:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVTFpqbXc0L--Kz3URrfpSm9NX8th9zAp+th1Tv1+027g@mail.gmail.com>
Message-ID: <CAMuHMdVTFpqbXc0L--Kz3URrfpSm9NX8th9zAp+th1Tv1+027g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: re-order entries to match coding convention
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 8:17 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> The DT schema coding convetion express in

convention expressed

> Documentation/devicetree/bindings/example-schema.yaml expects entries in
> following order:
>  - properties, patternProperties
>  - required
>  - if blocks, allOf with if-blocks
>  - additionalProperties/unevaluatedProperties
>
> Re-order few schemas to match the convention to avoid repeating reviews

review comments

> for new patches using existing code as template.  No functional changes.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
