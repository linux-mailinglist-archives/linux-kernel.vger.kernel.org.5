Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790707FABC0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbjK0Uky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjK0Uku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:40:50 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F8B191;
        Mon, 27 Nov 2023 12:40:56 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5cc642e4c69so47012867b3.0;
        Mon, 27 Nov 2023 12:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701117655; x=1701722455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRs6V1G4bJ91r4gRjp2FMkL9JXcsUtL6rgbmHrGxlFU=;
        b=ZnNwijAvXgqkjbm+6xZlridLPH6rx4BWsN2uWpG2rhlxnYqcl/qN8XrVZG0wC8g+jP
         a1AaDmfQJq/crz4CBZhDH47xYucViAlyDd8pIGwyv1fRSlfP5tZbgx6W5c9PxAm+IwZK
         PcaPfahDjdaP/cojAQDuRE1RhVl0Fa8kveDYb5D5H1SWGQHdkr53zS14vgXTKni0lDNW
         YmxxOxPBP7Hj31QJruA9XIWOCLPMKZZPgWBgqRrLQLDeY5FXO+Gs59oSgKgr3HFecQ1X
         F53W0V8UsAyfniixL9gPaVr2w9TfAzM39zzWH0q/VbUavmU5+IQ/Dgv9y/acSRJg4aNp
         ktVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701117655; x=1701722455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRs6V1G4bJ91r4gRjp2FMkL9JXcsUtL6rgbmHrGxlFU=;
        b=M5i5SYdidvOCQrK55QuEbY1xviP9NTXq4Z02BGfkXPklCX6zEUkXiW+Ch6TxrJ8KSi
         wDhlTR+4MKq+Am5gLbYmHQvs5lhZn99hsQ+fyb+hJkHZdz0vRjzwzuIyWt+m0TTdkKv9
         k8NFYvbzqGicK2fW8+iBFECwNDxkgYRDq+ug8J8s7UkrxRNwxF+NFWsFEDkRxEj2SnsG
         bMI3lF3ElwuAroiGG0a+a+lfCX4AzrnW0kA+S2eTPPSUPabhu2q30E6o3gFB+QP0/r1b
         dNEp3fRSGJJTi62De8087qO4vymA1hrMo+8ifosAi+S98ugA6GdURd2XifpaArHq5YEP
         03uw==
X-Gm-Message-State: AOJu0YwN+FzCF4b6Z5ooNcX85RrxaugpYCJ7Q41XBkwfhZoBFRPrnSv8
        5dovNY26ubENsdvAkYRZQ7VruPg863phQoBK4ww=
X-Google-Smtp-Source: AGHT+IGLjeq9rPxpKGNviEOOhVzIBQ0feYNgTbl0lSFiOgTO1kLXII5c0Mlnva6g6WSroWuY2ZejdJzlWtDHa0ooWmc=
X-Received: by 2002:a25:a41:0:b0:da0:ce05:ca2c with SMTP id
 62-20020a250a41000000b00da0ce05ca2cmr10919080ybk.7.1701117655444; Mon, 27 Nov
 2023 12:40:55 -0800 (PST)
MIME-Version: 1.0
References: <20231127200430.143231-1-andreas@kemnade.info>
In-Reply-To: <20231127200430.143231-1-andreas@kemnade.info>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 27 Nov 2023 14:40:43 -0600
Message-ID: <CAHCN7xLpERbs1MPMXTAPCqoPgAN5ts+Ubr=MiO6urW-wuuxp=w@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: omap: logicpd-torpedo: do not disguise GNSS device
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 2:04=E2=80=AFPM Andreas Kemnade <andreas@kemnade.in=
fo> wrote:
>
> https://support.logicpd.com/DesktopModules/Bring2mind/DMX/Download.aspx?p=
ortalid=3D0&EntryId=3D649
> clearly specifies the availability of GPS, so let's not disguise it
> and name the node accordingly.

Thanks for doing this.
>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Acked-by: Adam Ford <aford173@gmail.com>

adam
> ---
>  arch/arm/boot/dts/ti/omap/logicpd-torpedo-37xx-devkit.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/ti/omap/logicpd-torpedo-37xx-devkit.dts b/=
arch/arm/boot/dts/ti/omap/logicpd-torpedo-37xx-devkit.dts
> index 533ce7ce387a5..fbff15a0a0fe9 100644
> --- a/arch/arm/boot/dts/ti/omap/logicpd-torpedo-37xx-devkit.dts
> +++ b/arch/arm/boot/dts/ti/omap/logicpd-torpedo-37xx-devkit.dts
> @@ -52,7 +52,7 @@ wlcore: wlcore@2 {
>
>  &uart2 {
>         /delete-property/dma-names;
> -       bluetooth {
> +       bluetooth-gnss {
>                 compatible =3D "ti,wl1283-st";
>                 enable-gpios =3D <&gpio6 2 GPIO_ACTIVE_HIGH>; /* gpio 162=
 */
>                 max-speed =3D <3000000>;
> --
> 2.39.2
>
>
