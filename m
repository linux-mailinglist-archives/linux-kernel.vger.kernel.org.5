Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA5A80EC8D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376325AbjLLMwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376275AbjLLMwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:52:05 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B42AC;
        Tue, 12 Dec 2023 04:52:11 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6d9dbe224bbso4144293a34.2;
        Tue, 12 Dec 2023 04:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702385531; x=1702990331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OiQLT1KyS2c/6FByDfn019uWStgZcMlHLm0iys4Bj8I=;
        b=SiYFIbidN6gWbF2HZKrl3Z836W08qISpmsT4CNrXhzdBwT0S8ZhWcEqXucDGjDDPPN
         F9mDfV/XdvHwIcaoJAl0HatcgzHVAR1P+qoTa1HZlx0EvdOo7YWvN3VIggS9BUGLIj75
         VvwTKFDh5UJAWrx16A3W3ldyhtyImhOQ5bCuFf42kl2wFMyyWVrIXayc5n4kt5EXWV9Y
         AeDbvlQtk5SrOQgFGeXZrG7h7zTqGsHO23vjGAFaCVH6Iva8+2RRavKfh+t6JxoryIzo
         GfCVw6HdT7qw5vD22MaNXahdiG915RSR0J+JUusoHCa+aLiEqZ3FTeKwPaARs0CrnH80
         p+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702385531; x=1702990331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OiQLT1KyS2c/6FByDfn019uWStgZcMlHLm0iys4Bj8I=;
        b=LfR9ThmVN6S76nQTC67UDTg1lPLeUodstXwqESEih5GTyWuxPIAnpwQz2yAc3LZvla
         urU5boa4v++VOj2A50peGEwe4iYHxLdkvBemfx/CAqE2suhQZL/sgBfukuNPoFzyANwH
         C6Vy8XXw1lFJTT1+OY7ubKZd7/WYzUlG9XSo7nk0pvA/B3kasIOfzcYyDaxYE5849KFZ
         MYna2Rxwd0wGTTwzE+D90nMJg/UnGDEMFvitr3gYPE5qQW0QgbbY2jufzDei3nRfd78W
         6aEoUGjh36crXDZFTJ2AxCIb22L4RSC8huy73Z3wzfjZv3rJq182Kg1I4FHzEOc/HVyJ
         IPkQ==
X-Gm-Message-State: AOJu0YxnZGbuKrLLT0urZDSRiDMDcTtA03uz73i5iY3FX41c/n45XsLX
        d+Q/uuINwcq3WuU1V9v7nW6lVthdzQt/L5S8t0c=
X-Google-Smtp-Source: AGHT+IHKWrsXy01ldugdSTL8sfEzcukqIIBEOBmZkVoJSFLBDXhY2XL4cl7TiAlUdAuH1cYperFkv+OqfPifykaYFLM=
X-Received: by 2002:a05:6871:d102:b0:1fb:75a:de63 with SMTP id
 pi2-20020a056871d10200b001fb075ade63mr6447333oac.81.1702385531019; Tue, 12
 Dec 2023 04:52:11 -0800 (PST)
MIME-Version: 1.0
References: <20231204144429.45197-1-linux.amoon@gmail.com> <20231204144429.45197-2-linux.amoon@gmail.com>
 <20231206135311.GA2043711-robh@kernel.org> <CANAwSgTS0ZSFPv4x803pCLEpjH5imh8vEoWpbiJRH14Sy3GZww@mail.gmail.com>
 <21673bfd-bb87-4c7d-a53f-337c263f3a00@linaro.org> <CANAwSgSo37B0zg-xjrmqndSZ5SbyB3m27_wRsqqN9WTONooeiw@mail.gmail.com>
 <604e653d-c1e2-45c7-b121-8a6b4be5c6bb@linaro.org> <CANAwSgRB=XWo2-40rDru=Zy277-kgGNjozJ8Lxnxgv_4ABB-kg@mail.gmail.com>
 <1a78d453-62a2-410a-a40f-1ff0c2b62e86@linaro.org> <CANAwSgTy4N7Q8e0OQLsFRkRDWksTSbkOetKQGygaqsQ8++U1_g@mail.gmail.com>
 <2e688f4e-11d7-4f8e-b8ec-58f4a97304a8@linaro.org> <CANAwSgQstkS-SDaV2hj0fimt7vgfEgOT_x4efshZ6sZQ0gWSEA@mail.gmail.com>
 <8f28ea77-b3d0-445e-8d8e-80f980775f89@linaro.org> <CANAwSgRLORHb6qiHWRBR0tMbYB=O=gwatuGhk72SwZyhYMopCw@mail.gmail.com>
 <d2962ffb-badd-44a6-bdcc-53e15d4a4379@linaro.org>
In-Reply-To: <d2962ffb-badd-44a6-bdcc-53e15d4a4379@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Tue, 12 Dec 2023 18:21:55 +0530
Message-ID: <CANAwSgSpuh-+HFYg2UTgX27SHFyCBddV46MgKakiSCOtFX4+aw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: usb: Add the binding example for the
 Genesys Logic GL3523 hub
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-amlogic@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, 12 Dec 2023 at 17:22, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 12/12/2023 12:37, Anand Moon wrote:
> >
> > Here is the list of warnings I observed with this patch
> >
> >   DTC_CHK Documentation/devicetree/bindings/usb/nvidia,tegra186-xusb.example.dtb
> > /home/amoon/mainline/linux-amlogic-6.y-devel/Documentation/devicetree/bindings/usb/usb-device.example.dtb:
> > hub@1: 'vdd-supply' is a required property
>
> You always require the property, but it is not valid for some devices.
> Just require it only where it is applicable (in if:then: clause).
>
I had already done this check many times before.
my v6 original patch was doing the same and it passed all the tests
but since I updated the required field it not parsing correctly.

required:
  - compatible
  - reg
  - vdd-supply
  - reset-gpios
  - peer-hub

>
> >         from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
> > /home/amoon/mainline/linux-amlogic-6.y-devel/Documentation/devicetree/bindings/usb/usb-device.example.dtb:
> > hub@1: 'reset-gpios' is a required property
> >         from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
> > /home/amoon/mainline/linux-amlogic-6.y-devel/Documentation/devicetree/bindings/usb/usb-device.example.dtb:
> > hub@1: 'peer-hub' is a required property
>
> ...
>
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            enum:
> >>> +              - usb5e3,610
> >>> +              - usb5e3,620
> >>> +    then:
> >>> +      properties:
> >>> +        peer-hub: true
> >>> +        vdd-supply: true
> >>
> >> Drop this if:, redundant.
> >>
> > No, this does not resolve the above issue.
>
> It shouldn't resolve it, not related.
>
ok
>
> Best regards,
> Krzysztof

Thanks
-Anand
