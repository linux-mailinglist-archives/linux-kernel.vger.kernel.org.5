Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D226778479
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 02:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjHKAOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 20:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjHKAOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 20:14:16 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F862D48;
        Thu, 10 Aug 2023 17:14:14 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99cdb0fd093so207932066b.1;
        Thu, 10 Aug 2023 17:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1691712852; x=1692317652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XlFDrgd4Kjgs88FYYyhC1up8TqnDvp4WBELyUE1OyrA=;
        b=I7YRRJs8HkI8fcSoO3+uj1zSU6OiINQeNAr6ehSd1x7yUHjTJQ7awZP96zwUzgi8B8
         O96FCkcDHhVenS5Cs9Li/Ps8brLRKAEzz4QcnjpDgdDdHymlGd13AhYVN57sHeMNMEVp
         BLLQDnjf6DI/jxCDEFMfYKOnkAx3gkAlV+40g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691712852; x=1692317652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XlFDrgd4Kjgs88FYYyhC1up8TqnDvp4WBELyUE1OyrA=;
        b=dMrBWkKxqCB6bzxCHhK4O/cH/kSx88iR9CM5SgAiNEz2+0YJR+duQCWKf/i7iIUKm3
         SaQMB2tE88St+gL1d94q2oPtBbgX1krD5d5Ai/zRn+o92LmhaY/nWtotmxHcA+QAJly0
         1IA4PML7EpvAQeLOLx0MzlaAVAOhjkgM34FA1lmALl10dkSnvQ8WVfkZr0FxkuhbPH4L
         bTLW1xv9eudA2wvlv07RLtpNwp1AtFF20B6pVb16Gau0PvY7pD1SHc+oKlciCEMzEiz7
         SPl1lcZdFP7YTNhgcx+rKWGAD66EIn/FP4N4vWQj75hdemcGyWrJtuummvwAe579BetJ
         LTNg==
X-Gm-Message-State: AOJu0YzRaYJLx5LFdckLIVmQcqZypTcZR/mmHSajvdSOMtZWpq+9pA/f
        VNJUQHLqyfEBlAA0hTQuicHTFYjiagSI2lg52t4=
X-Google-Smtp-Source: AGHT+IGn9S/blGrvEnNPG7qZMlGuQ9p5jKZ+zLGBRss3rKyDzeHjb4zDHGyCXJezpLMHz3B3HavVDYhG2jahJHGLr54=
X-Received: by 2002:a17:906:3087:b0:99b:e6ec:752c with SMTP id
 7-20020a170906308700b0099be6ec752cmr312934ejv.70.1691712852333; Thu, 10 Aug
 2023 17:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230809134413.3614535-1-dylan_hung@aspeedtech.com>
In-Reply-To: <20230809134413.3614535-1-dylan_hung@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 11 Aug 2023 00:14:00 +0000
Message-ID: <CACPK8XcwcufQRYj+QX9KLyGDEXMFQeK816iDknZnT58sTDk+Mw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: pinctrl-aspeed-g6: Add I3C1 and I3C2 control pins
To:     Dylan Hung <dylan_hung@aspeedtech.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, andrew@aj.id.au, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kobedylan@gmail.com, BMC-SW@aspeedtech.com,
        Jeremy Kerr <jk@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 at 13:44, Dylan Hung <dylan_hung@aspeedtech.com> wrote:
>
> Add pinctrl support for the I3C1 and I3C2 pins.
>
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> Reviewed-by: Jeremy Kerr <jk@codeconstruct.com.au>
> ---
> changes in v2:
> There are no code or message changes in v2. This commit is being made as
> a standalone patch separate from the original patch series, as the other
> patches from the original series are no longer necessary.

Thanks, I've applied this.

>
>  arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi
> index 7cd4f075e325..289668f051eb 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi
> @@ -297,6 +297,16 @@ pinctrl_i2c9_default: i2c9_default {
>                 groups = "I2C9";
>         };
>
> +       pinctrl_i3c1_default: i3c1_default {
> +               function = "I3C1";
> +               groups = "I3C1";
> +       };
> +
> +       pinctrl_i3c2_default: i3c2_default {
> +               function = "I3C2";
> +               groups = "I3C2";
> +       };
> +
>         pinctrl_i3c3_default: i3c3_default {
>                 function = "I3C3";
>                 groups = "I3C3";
> --
> 2.25.1
>
