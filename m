Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958497BF7F6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjJJJzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjJJJzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:55:22 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4742A93;
        Tue, 10 Oct 2023 02:55:21 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-57be3d8e738so2956410eaf.1;
        Tue, 10 Oct 2023 02:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696931720; x=1697536520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fRr0GLki14imU2pQsyavD3bnxa727VzXZ1CS3z19LiA=;
        b=kRAzTH2u0dwSv3MzKe6lonHnKRFHNmGEkhjz8gw74t5wEFxhe2Sl4EZ/IY0y1c4Oq0
         OTZPTI1TLrwBK3AIx+Cy3Y+m5VWkBxBB/idQ4OB3ohGNX5KebxtTxN2IPYgrCeJaxod4
         mbj63zubD3EROosBH+34eaTNZwkWFUcNjKY0JaIFTnQ3QgwBRm2jDk/M87zYMJy76MCf
         MG1UXGXPE/T7vKuPklrVXj3YbUHkSHDVTbmmtZzMLcfsdUp7azNy2TGviv6uTmp76qUB
         VcD0zAbamu2myo+nisa//HVmKVRykqHRpGK0jsf7zl6f1+p7fMFlMg9AGgsdqqH4JqNj
         2wgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696931720; x=1697536520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fRr0GLki14imU2pQsyavD3bnxa727VzXZ1CS3z19LiA=;
        b=W8dwdivZwMCW+FhOHW2lB1eT9KG9hIa6vgqaDBwZE+r2Ic+ACm/ZEFV530kpkoeu8h
         ICxG7w31qdCnfNdouQ2dQR1UtEanMksh5pJZ/wODdZSm/25MELWSmQ+UVmP9wlev2dOX
         RvyKm+Lba5tgoD21SOqOz6pERTKb6sSTxAtd6mP8nO8TXHmS8J0sEpm7j8lFN6fl76Em
         L9pBRaJdKSNzzsK2rFPxp99oIa4PHQa0j2Nu65HENcNLZGxw9n6/BHHlQCh87prFS7rh
         LZ7bSNXfd4xgrvAUIIJKclnD06p04uC80iKqmNeaoen0lLGAJqcxhe54VLiu3vggT9M0
         ZSvg==
X-Gm-Message-State: AOJu0Yy5+z8iDeWAZRn6V//3ZUDsHIkTnhHdVtdf54awJ4RjPhAcCBmn
        6jRA7w2Hij2HVL+2B+4LUpJSNnH8zoEiu0XWBdpfa654Gl/veQ==
X-Google-Smtp-Source: AGHT+IHgEuySn4JrjKTV0h4pLKEwHPrdQJVtRc1PhXmTOwWq2g2k6eFHdk8ESnnLQW6ySJSfF9cdAUj1M3VbQ+5p4Yg=
X-Received: by 2002:a4a:91d2:0:b0:57b:e100:60ae with SMTP id
 e18-20020a4a91d2000000b0057be10060aemr16550947ooh.7.1696931720475; Tue, 10
 Oct 2023 02:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231010032446.3194-1-linux.amoon@gmail.com> <9fe7d0d2-3582-4b62-be9b-aa9134c18023@linaro.org>
In-Reply-To: <9fe7d0d2-3582-4b62-be9b-aa9134c18023@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Tue, 10 Oct 2023 15:25:02 +0530
Message-ID: <CANAwSgRv5d5o2cDzbGYAj0srhUO7T5LAMuzMBqP7p+uHJN0xVQ@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: amlogic: Used onboard usb hub reset on
 odroid n2
To:     neil.armstrong@linaro.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, 10 Oct 2023 at 13:40, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Hi,
>
> On 10/10/2023 05:24, Anand Moon wrote:
> > On Odroid n2/n2+ previously use gpio-hog to reset the usb hub,
> > switch to used on-board usb hub reset to enable the usb hub
> > and enable power to hub.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >   .../dts/amlogic/meson-g12b-odroid-n2.dtsi     | 36 ++++++++++++-------
> >   1 file changed, 24 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> > index 91c9769fda20..9e671444eca6 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> > +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> > @@ -31,6 +31,30 @@ hub_5v: regulator-hub_5v {
> >               enable-active-high;
> >       };
> >
> > +     /* USB hub supports both USB 2.0 and USB 3.0 root hub */
> > +     usb-hub {
> > +             dr_mode = "host";
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +
> > +             /* 2.0 hub on port 1 */
> > +             hub_2_0: hub@1 {
> > +                     compatible = "usb5e3,610";
> > +                     reg = <1>;
> > +                     peer-hub = <&hub_3_0>;
>
> It seems peer-hub is missing from Documentation/devicetree/bindings/usb/genesys,gl850g.yaml, could you add it ?
>
Yes, will add an example in genesys,gl850g.yaml file.

> Thanks,
> Neil

Thanks
-Anand
