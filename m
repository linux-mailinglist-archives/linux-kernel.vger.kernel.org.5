Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A217AC2A1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 16:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjIWOXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 10:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjIWOXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:23:34 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374EB19A;
        Sat, 23 Sep 2023 07:23:28 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-570a432468bso3804279a12.0;
        Sat, 23 Sep 2023 07:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695479007; x=1696083807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gb8IgGF6U/jzWDiENgaHWyfhk6nOAXP9WOymk/x8GAI=;
        b=LemcwzO/s3ZF/DT1p6RlfWzE1+Z9twyOPxqhRIfwqp42PLz+83iDmk4VUoqwN48dpu
         Z4FvEeyZC+bxwVBFLEwyO3FFr78lEQqCZohAfBPB8ea+Ih12hD//uhUPZS/GjEEGt1Lq
         7eFXqQ63RuMgsdbxBFFdy1fnr8E0g3/AkAHiUiCK8lzIpFDeCPQYLcIZxgNm01x4vsHP
         a7HR9HZeaHX+MQq+lqTX9koI/oulrniDBUatt7YW8QbW/c5jQOR+6O8yIgkorVjN8ZMz
         zypLVJXYK/h+vcvQzzA4o3bXjyiYmeC1Uie0el9s0W+dk8Q0+hyWt186QRO8CiP4X/Kr
         5ZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695479007; x=1696083807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gb8IgGF6U/jzWDiENgaHWyfhk6nOAXP9WOymk/x8GAI=;
        b=J53BI4PzajH5v1I/10SZLASmZTWVTAaEkOI9znntjGrK2aJv8BPaUdZpypKjkCSdZt
         D1SAyQS6C0O+4h85F+bsjXaZHcwb/2uJvoFSX4nKPcVN51uLqqRuJNQAVe9oFvrg14xT
         P/+PBIr/XdNVnHxTUsQu6I4BZrXVCdiB5OIQ6qsbeVJddHrK0Ev4UgWX794EZ6EmAh3S
         IFguZUAzpv8oqh2rPnchrHrtshEbwJfH1ZZ703NEKuNjlfu33DuvKx2Q2yF80IxCjXYU
         djpL4pNz+7oWk0DKKia7NeYeG6dfVg4+2SUPseTKKGK8pJcdRM+P80whx8yZw+KviD5/
         sVlg==
X-Gm-Message-State: AOJu0YyiUPaOmPJ2Oaua/gZn9p7/PaKjhPOFfGcyWlMLa1iJcuYTpfmM
        P+2ZTrf6DJM+ctChAvi7j0x0C2OBuBn/q0wnXWg=
X-Google-Smtp-Source: AGHT+IEVArCvJvYrsDQwQRUae2muvu2UgxzqTCgU5RWPgHKWGrLb0pQVJye14YoqIXEGr29NfkgHRU4LxkcdeirefJU=
X-Received: by 2002:a17:90a:72c6:b0:273:dfb1:2439 with SMTP id
 l6-20020a17090a72c600b00273dfb12439mr7971263pjk.21.1695479007640; Sat, 23 Sep
 2023 07:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230830092314.624212-1-mathieu.moneyron@gmail.com>
 <096e9122-23b8-5a36-7779-28994187c620@intel.com> <9a311ce3-0d29-af39-5533-c1cad6de1300@microchip.com>
In-Reply-To: <9a311ce3-0d29-af39-5533-c1cad6de1300@microchip.com>
From:   Mathieu Moneyron <mathieu.moneyron@gmail.com>
Date:   Sat, 23 Sep 2023 16:23:16 +0200
Message-ID: <CAKmtTBYquiYQ-=MVWCqH8=iiFONvt6B_==EZhWsQkSA8WNuYUQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: Fix force card detect in sdhci
To:     Aubin Constans <aubin.constans@microchip.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aubin,

Thanks for your feedback.
I'll try my best to give clear explanations.

On Sat, Sep 23, 2023 at 2:44=E2=80=AFPM Aubin Constans
<aubin.constans@microchip.com> wrote:
>
> On 04/09/2023 09:38, Adrian Hunter wrote:
> > + Eugen Hristev  > > On 30/08/23 12:23, mathieu wrote: >> On the ATMEL =
at91 when using
> the non-removable flag in device tree >> and not using the card-detect
> pin inside the device-tree pinctrl, >> the card detect pin is physically
> still used which can cause >> unknown behaviour when this pin is used
> for other purposes.
> Hi Mathieu,
>
> On which SoC(s) exactly, has this behaviour been observed?

This has been observed on SAMA5D27.
>
>
> Also, has this issue been discussed in any separate support request, in s=
uch
> case we could retrieve some background from it?
>
> By "unknown behaviour", do you mean "the card insertion status would
> follow whatever electrical level is seen on the card-detect pin"?

For instance our board design has the PA13 (card detect) pin wired to drive=
 a
3v3 power supply.
The fixed regulator driver configure this pin as output (described in the d=
evice
tree).
But what I observed is that the sdmmc driver still want to use PA13 as the =
card
detect signal which is then configured as an input. This cause the 3v3 powe=
r to
drop.

By "unknown behavior" I mean the configuration of this pin as card detect s=
ets
unwanted electrical levels to what's connected to this pin.
>
>
> >>  >> From my interpretation this seems to be caused by a hardware desig=
n
>  >> flaw and the real hardware is not working as intended by the >>
> documentation. >>
> >>
> >> Signed-off-by: Mathieu Moneyron <mathieu.moneyron@gmail.com>
> >>
> >> ---
> >>  drivers/mmc/host/sdhci-of-at91.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-of-at91.c
> >> b/drivers/mmc/host/sdhci-of-at91.c
> >> index 69fef88e7..4fd6bfbf6 100644
> >> --- a/drivers/mmc/host/sdhci-of-at91.c
> >> +++ b/drivers/mmc/host/sdhci-of-at91.c
> >> @@ -51,10 +51,15 @@ struct sdhci_at91_priv {
> >>  static void sdhci_at91_set_force_card_detect(struct sdhci_host *host)
> >>  {
> >>      u8 mc1r;
> >> +    u8 ctrl;
> >>
> >>      mc1r =3D readb(host->ioaddr + SDMMC_MC1R);
> >>      mc1r |=3D SDMMC_MC1R_FCD;
> >>      writeb(mc1r, host->ioaddr + SDMMC_MC1R);
> >> +
> >> +    ctrl =3D readb(host->ioaddr + SDHCI_HOST_CONTROL);
> >> +    ctrl |=3D SDHCI_CTRL_CDTEST_INS | SDHCI_CTRL_CDTEST_EN;
> >> +    writeb(ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
> >>  }
> >>
> >>  static void sdhci_at91_set_clock(struct sdhci_host *host, unsigned
> >> int clock)
>
> Kind regards,
> Aubin
>
Kind regards,
Mathieu
