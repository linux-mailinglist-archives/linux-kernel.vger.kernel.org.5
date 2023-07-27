Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9673765B61
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjG0SbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjG0SbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:31:10 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB433A80
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:30:45 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-48651709fa5so445613e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690482644; x=1691087444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voiXLpkjPfzBEig254frn/V48hVLiCZ+gaG536em0hA=;
        b=Qiq8lUwYXYNyVnvwMa8aWnxcFGZ05ItPYrcq4TUFUiE1cCXakvWeNjsruAYgCRHqGQ
         8rexWOTNJPL/JuJS8YGH713DEm1X98VcrYeZj+5HFGJHdqbzjeTwd33rnG2vS2DddinO
         dREWCzP1ARYy8PHMyV7oBGQ4MHZ1wT9s3ddmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690482644; x=1691087444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voiXLpkjPfzBEig254frn/V48hVLiCZ+gaG536em0hA=;
        b=lO5CDTOpwOhbCb0B5SYdq3ypeCNHmiJ3Z0kJmY8fA1I34HFpCkR4pGDoexqLl7A6j9
         S1NYK/UxKHKsoyqKW59tLraDeDdRYWit9Qz+fyw0fdTZttaPwJHTiDekums1dozOEqzB
         gN8nUG/qrmmnfMySca32997nfSNVAMgfkWmfVJfbTj1Gc6L5H618tCPOmof7BX5d0XAH
         le3fg+kxP187NYs18WWz9w5WsrDcySe8C1IU+YZh0jRdRDHQg46eh0dD6ep3a2ocUFRr
         DZIiQs7x0kW8wGutfypVl6e3nLo2w7Ov1MZXAkzp3La4EVyulw/myvPy+P7XuDoBS2go
         wUnw==
X-Gm-Message-State: ABy/qLbtYKEY4V5LfPBYGhWIsjC7/ZWM6iCyNlkWzQxdajhCevAusf7V
        EVkw2KB31u8+TKZVJ1vnXqgCL7/rYJeFPrwG3bU=
X-Google-Smtp-Source: APBJJlFhyO6UWAHd6gT5u9Wzu6ROaOBuffy0bVkGvecxIMRT5s8fWQb5k66mvHGeZgi7vhJCUJ5LZQ==
X-Received: by 2002:a1f:5fcb:0:b0:486:242e:5b5e with SMTP id t194-20020a1f5fcb000000b00486242e5b5emr333436vkb.13.1690482644629;
        Thu, 27 Jul 2023 11:30:44 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id bq3-20020a056122230300b00484148e37e8sm290896vkb.8.2023.07.27.11.30.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 11:30:42 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4864928ce7fso438566e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:30:42 -0700 (PDT)
X-Received: by 2002:a1f:bf0c:0:b0:47e:30a:c7bc with SMTP id
 p12-20020a1fbf0c000000b0047e030ac7bcmr319345vkf.12.1690482641747; Thu, 27 Jul
 2023 11:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <ZLm3G5G6/gmLZwkn@tora>
In-Reply-To: <ZLm3G5G6/gmLZwkn@tora>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Thu, 27 Jul 2023 12:30:30 -0600
X-Gmail-Original-Message-ID: <CAHQZ30Dn8pT4X_=XZCFGEy2ijXTfJskSLUoQV6o_QC5v446Z4Q@mail.gmail.com>
Message-ID: <CAHQZ30Dn8pT4X_=XZCFGEy2ijXTfJskSLUoQV6o_QC5v446Z4Q@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Add DMI definition for
 post-Skylake machines running custom Coreboot builds
To:     Alicja Michalska <ahplka19@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robbarnes@google.com,
        lalithkraj@google.com, bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, Mrchromebox@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 4:37=E2=80=AFPM Alicja Michalska <ahplka19@gmail.co=
m> wrote:
>
> ChromeOS EC LPC lacks DMI match for newer machines, which
> use "Google" DMI_SYS_VENDOR as opposed to "GOOGLE" in older models.
> This patch adds DMI definition for MrChomebox's custom Coreboots builds,
> which we (Chrultrabook Project) are using.
>
> Signed-off-by: Alicja Michalska <ahplka19@gmail.com>
> ---
>  drivers/platform/chrome/cros_ec_lpc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chr=
ome/cros_ec_lpc.c
> index 500a61b093e4..6ac993be4eb1 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -533,6 +533,14 @@ static const struct dmi_system_id cros_ec_lpc_dmi_ta=
ble[] __initconst =3D {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "Glimmer"),
>                 },
>         },
> +       /* DMI doesn't match modern machines running custom firmware */
> +       {
> +               /* MrChromebox's firmware */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> +                       DMI_MATCH(DMI_BIOS_VERSION, "MrChromebox-"),
> +               },
> +       },
>         /* A small number of non-Chromebook/box machines also use the Chr=
omeOS EC */
>         {
>                 /* the Framework Laptop */
> --
> 2.41.0

+ Mrchromebox

Hrmm, it looks like this table is only used if the GOOG0004 ACPI
device wasn't found. Is the MrChromebox fw missing this ACPI device?
