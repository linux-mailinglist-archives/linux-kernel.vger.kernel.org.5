Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D55A7754CA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 10:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjHIII2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 04:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjHIII0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 04:08:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1739F;
        Wed,  9 Aug 2023 01:08:26 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52348b53bd3so1949052a12.1;
        Wed, 09 Aug 2023 01:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1691568504; x=1692173304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SrSTqgsbLJSsIks9TgxyFdkng+ofXzd27szmGw2vUQ8=;
        b=nKr24M1ttD9NhoF7aA2AQzPlfF8F/K88VInXAggqbbVCKFMUUxKdBXY8CCxM6YIru3
         zXeRqWiAfLLZE0JrNIkQx+ERXeXX4I8NN1rs53plu/YPJc+qScAWrGk2Y1SPmsQCa4Ps
         n5rmjRjJq2VC5zs39xSwuz5f8lAN+OxP+3qpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691568504; x=1692173304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SrSTqgsbLJSsIks9TgxyFdkng+ofXzd27szmGw2vUQ8=;
        b=RMjoE1PEunnnRSBiUgRCeB03PSPXSfYbaLprLFlr4xz9Wd63g6dwhc4CDSlxIbRS2A
         cSQuVIzXBMWcMwmbutfT25mqIsgLmEPGEobDN4iXGfFGa/w4tt2flHFc3lZcFCIAPHXb
         6Fg5Sj1AMcTlX+KiMtBSiJxdJ5dW1pHV9lQAc00cB4xtfe5NJbkZnuP1yB/z4uY6NTxh
         uLItet3WMPHKGcmGWg2HfsaMo5FqLEj6GL0aWJTeyu3wq4pV9wPYTohHNw5jAf4hArYe
         sLx0PvsO2Bh40gHFV/Z9X1XwFV2kulStPHf1448qUdWKg/HNNEUL8xGrTkbDa81DAOgW
         GuGw==
X-Gm-Message-State: AOJu0YySMntjagw7J380Xv/JvouirWfa1gM0yCBycc2EhrfLfH0x8NrB
        alzR7aY4DcEzM/JvDIH90GFQUhwEp/6+CuuRIVA=
X-Google-Smtp-Source: AGHT+IHWLeW01BaNylBw+j4CoHMoP8qesgx2p10dtD7AQYa3aiYIzTPI/m7Xjh1jKl5QIUcxce01xjlniWpPyBahZl8=
X-Received: by 2002:a05:6402:184b:b0:523:4acb:7f41 with SMTP id
 v11-20020a056402184b00b005234acb7f41mr1726241edy.14.1691568504325; Wed, 09
 Aug 2023 01:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230803230324.731268-1-rentao.bupt@gmail.com>
In-Reply-To: <20230803230324.731268-1-rentao.bupt@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 9 Aug 2023 08:08:12 +0000
Message-ID: <CACPK8XcFL7kM1yaA0+ZRSt27a0yreO+AH5cXtSk1TyjqyjH1WA@mail.gmail.com>
Subject: Re: [PATCH 0/3] ARM: dts: aspeed: Fixup Wedge400 dts
To:     rentao.bupt@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        taoren@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED,URIBL_CSS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2023 at 23:03, <rentao.bupt@gmail.com> wrote:
>
> From: Tao Ren <rentao.bupt@gmail.com>
>
> The patch series fixes a few entries in wedge400 device tree.
>
> Patch #1 sets spi alias in ast2500-facebook-netbmc-common.dtsi (included
> by wedge400 dts) to make sure spi bus is consistent with flash labels in
> flash layout.
>
> Patch #2 enables more ADC channels in wedge400 dts.
>
> Patch #3 sets eMMC max frequency to 25MHz in wedge400 dts.
>
> Tao Ren (3):
>   ARM: dts: aspeed: Update spi alias in Facebook AST2500 Common dtsi

I wondered if we should do this in the aspeed-g5.dtsi.

>   ARM: dts: aspeed: wedge400: Enable more ADC channels
>   ARM: dts: aspeed: wedge400: Set eMMC max frequency

Reviewed-by: Joel Stanley <joel@jms.id.au>

>
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts    | 4 +++-
>  arch/arm/boot/dts/aspeed/ast2500-facebook-netbmc-common.dtsi | 4 ++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> --
> 2.40.1
>
