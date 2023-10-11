Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3EB7C4781
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 03:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344713AbjJKBwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 21:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344546AbjJKBwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 21:52:41 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B276D92;
        Tue, 10 Oct 2023 18:52:39 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b9ad5760b9so1061600466b.3;
        Tue, 10 Oct 2023 18:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1696989158; x=1697593958; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=luUw5tqGQ3BU2f4zRF8kts9D/h2ull0YaqRJxHMMH9o=;
        b=I7fCj2fwemYM2XWrisBgKLzDI7k8xjRZ+X+Nx7YHP7gQu4hhX8d14pnC5S15ZDa/pc
         luF4mPRqTxJkyrRgr3RkffZZv89mNcE1eqF9hHXJaDlch9thc87GwR2NeGwO4ZyynVXU
         P77SJ6omluq849DHtLxixZxpEmAk7qoLbefX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696989158; x=1697593958;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=luUw5tqGQ3BU2f4zRF8kts9D/h2ull0YaqRJxHMMH9o=;
        b=F55M3RXR/muTM74VbOuuX5ZLVW+O0RLR9Bopz2kHZHJS7PM4UOALJej50p2SVXfA1P
         m12IQNBrvP9Z1M19GSR1FsvwS8WV9t2tqKLOffj+AO0PcqiI/oNX3xKjOa0mavE9v4i+
         9RJV49HRXObCWQTolMubJY2xWdyY7YPq1wcsp5A40EkpQwNHPCtVy1J83wi2+fQGTEwv
         fgkzuV+04sUUOgzpVLy/8eFdWc+f64vu6FZEU0CnfmPC8qr/ABZW78C11fFdO1UpauYp
         nwbyx0nV1nODow6CS/lzv76NZiBzn+t1xqT8tFVmIYVZdu+GlO30lA7qPreHHNLJ+gNP
         Fr1Q==
X-Gm-Message-State: AOJu0YxGp6/8StJ0pv9ETQGiTIW+QAu2ywt5y6jBHlraVllsX2h/wvIh
        nyWnU9ajLs/q0HvfCBKuQRJUJ72aY9Wm7/H5dnw=
X-Google-Smtp-Source: AGHT+IF3xxxedApqqgkmd6UpoOa2FEJjAqgkiL1GacDU0VEwrkGybGeOFwHXsM6784ZOvbnnHBcngKb3QSFjnv4Wn8M=
X-Received: by 2002:a17:907:2723:b0:9a5:d657:47ee with SMTP id
 d3-20020a170907272300b009a5d65747eemr16776999ejl.58.1696989158194; Tue, 10
 Oct 2023 18:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231005035525.19036-1-chanh@os.amperecomputing.com> <20231005035525.19036-8-chanh@os.amperecomputing.com>
In-Reply-To: <20231005035525.19036-8-chanh@os.amperecomputing.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 11 Oct 2023 12:22:26 +1030
Message-ID: <CACPK8XehearTYQrmKTwwCB=Gvgur25Zr+UkgxzJW-7KKbJ9U7w@mail.gmail.com>
Subject: Re: [PATCH 7/7] ARM: dts: aspeed: mtmitchell: Add I2C NVMe alias port
To:     Chanh Nguyen <chanh@os.amperecomputing.com>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

On Thu, 5 Oct 2023 at 14:26, Chanh Nguyen <chanh@os.amperecomputing.com> wrote:
>
> Adds the I2C alias ports to each NVMe drive via the
> backplane card.
>
> Besides that, it also adds the eeprom and temperature sensor
> on the backplane card.
>
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  .../aspeed/aspeed-bmc-ampere-mtmitchell.dts   | 267 ++++++++++++++++++
>  1 file changed, 267 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> index eb8d5e367276..1f70e3e4e83b 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> @@ -14,6 +14,42 @@
>         aliases {
>                 serial7 = &uart8;
>                 serial8 = &uart9;
> +
> +               /*
> +                *  I2C NVMe alias port
> +                */
> +               i2c100 = &backplane_0;
> +               i2c48 = &nvmeslot_0;
> +               i2c49 = &nvmeslot_1;
> +               i2c50 = &nvmeslot_2;
> +               i2c51 = &nvmeslot_3;
> +               i2c52 = &nvmeslot_4;
> +               i2c53 = &nvmeslot_5;
> +               i2c54 = &nvmeslot_6;
> +               i2c55 = &nvmeslot_7;
> +
> +               i2c101 = &backplane_1;
> +               i2c56 = &nvmeslot_8;
> +               i2c57 = &nvmeslot_9;
> +               i2c58 = &nvmeslot_10;
> +               i2c59 = &nvmeslot_11;
> +               i2c60 = &nvmeslot_12;
> +               i2c61 = &nvmeslot_13;
> +               i2c62 = &nvmeslot_14;
> +               i2c63 = &nvmeslot_15;
> +
> +               i2c102 = &backplane_2;
> +               i2c64 = &nvmeslot_16;
> +               i2c65 = &nvmeslot_17;
> +               i2c66 = &nvmeslot_18;
> +               i2c67 = &nvmeslot_19;
> +               i2c68 = &nvmeslot_20;
> +               i2c69 = &nvmeslot_21;
> +               i2c70 = &nvmeslot_22;
> +               i2c71 = &nvmeslot_23;
> +
> +               i2c80 = &nvme_m2_0;
> +               i2c81 = &nvme_m2_1;
>         };
>
>         chosen {
> @@ -534,6 +570,237 @@
>
>  &i2c9 {
>         status = "okay";
> +       i2c-mux@70 {
> +               compatible = "nxp,pca9548";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x70>;
> +               i2c-mux-idle-disconnect;
> +
> +               backplane_1: i2c@0 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0>;
> +
> +                       eeprom@50 {
> +                               compatible = "atmel,24c64";
> +                               reg = <0x50>;
> +                               pagesize = <32>;
> +                       };
> +
> +                       i2c-mux@71 {
> +                               compatible = "nxp,pca9548";
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               reg = <0x71>;
> +                               i2c-mux-idle-disconnect;
> +
> +                               nvmeslot_8: i2c@0 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x0>;
> +                               };
> +                               nvmeslot_9: i2c@1 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x1>;
> +                               };
> +                               nvmeslot_10: i2c@2 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x2>;
> +                               };
> +                               nvmeslot_11: i2c@3 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x3>;
> +                               };
> +                               nvmeslot_12: i2c@4 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x4>;
> +                               };
> +                               nvmeslot_13: i2c@5 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x5>;
> +                               };
> +                               nvmeslot_14: i2c@6 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x6>;
> +                               };
> +                               nvmeslot_15: i2c@7 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x7>;
> +                               };
> +                       };
> +
> +                       tmp432@4c {
> +                               compatible = "ti,tmp75";
> +                               reg = <0x4c>;
> +                       };
> +               };
> +
> +               backplane_2: i2c@2 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x2>;
> +
> +                       eeprom@50 {
> +                               compatible = "atmel,24c64";
> +                               reg = <0x50>;
> +                               pagesize = <32>;
> +                       };
> +
> +                       i2c-mux@71 {
> +                               compatible = "nxp,pca9548";
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               reg = <0x71>;
> +                               i2c-mux-idle-disconnect;
> +
> +                               nvmeslot_16: i2c@0 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x0>;
> +                               };
> +                               nvmeslot_17: i2c@1 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x1>;
> +                               };
> +                               nvmeslot_18: i2c@2 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x2>;
> +                               };
> +                               nvmeslot_19: i2c@3 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x3>;
> +                               };
> +                               nvmeslot_20: i2c@4 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x4>;
> +                               };
> +                               nvmeslot_21: i2c@5 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x5>;
> +                               };
> +                               nvmeslot_22: i2c@6 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x6>;
> +                               };
> +                               nvmeslot_23: i2c@7 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x7>;
> +                               };
> +                       };
> +
> +                       tmp432@4c {
> +                               compatible = "ti,tmp75";
> +                               reg = <0x4c>;
> +                       };
> +               };
> +
> +               backplane_0: i2c@4 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x4>;
> +
> +                       eeprom@50 {
> +                               compatible = "atmel,24c64";
> +                               reg = <0x50>;
> +                               pagesize = <32>;
> +                       };
> +
> +                       i2c-mux@71 {
> +                               compatible = "nxp,pca9548";
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               reg = <0x71>;
> +                               i2c-mux-idle-disconnect;
> +
> +                               nvmeslot_0: i2c@0 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x0>;
> +                               };
> +                               nvmeslot_1: i2c@1 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x1>;
> +                               };
> +                               nvmeslot_2: i2c@2 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x2>;
> +                               };
> +                               nvmeslot_3: i2c@3 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x3>;
> +                               };
> +                               nvmeslot_4: i2c@4 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x4>;
> +                               };
> +                               nvmeslot_5: i2c@5 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x5>;
> +                               };
> +                               nvmeslot_6: i2c@6 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x6>;
> +                               };
> +                               nvmeslot_7: i2c@7 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x7>;
> +                               };
> +                       };
> +
> +                       tmp432@4c {
> +                               compatible = "ti,tmp75";
> +                               reg = <0x4c>;
> +                       };
> +               };
> +
> +               i2c@7 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x7>;
> +
> +                       i2c-mux@71 {
> +                               compatible = "nxp,pca9546";
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               reg = <0x71>;
> +                               i2c-mux-idle-disconnect;
> +
> +                               nvme_m2_0: i2c@0 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x0>;
> +                               };
> +
> +                               nvme_m2_1: i2c@1 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x1>;
> +                               };
> +                       };
> +               };
> +       };
>  };
>
>  &i2c11 {
> --
> 2.17.1
>
