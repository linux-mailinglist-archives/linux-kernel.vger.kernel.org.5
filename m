Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639E87A64EF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjISNcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjISNcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:32:15 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70CBF1;
        Tue, 19 Sep 2023 06:32:09 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bfea381255so53166721fa.3;
        Tue, 19 Sep 2023 06:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695130328; x=1695735128; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WwVxMLRoTi4jmpcZHwksJ5/u+vVpQogOzA/iWOhcTMI=;
        b=i9BAQ1DZX0UwPvG1Ehm33GL9JoC/+lwxfzLJcZx7K92wigATq3oTuxutJExc4z81/2
         1KDbsKLOO6X2bRH7HFbuDTCU22CVPtFLrakSmjXfc98q7KcaX/7d/5PexmX1MUedvWaX
         61LmVNSVo/gHF1wtxGb91tfqfq7EPoysb30vjPcSPknwNWQQySTkSMd0Ez45RgNikZLV
         10CV0VBcwm21r7DEMPVkHuBfgbcNPyDSPmuziEmif+7O1OVZeZ5YW/D6hDQTJmJCLXD0
         zqNxKErDELIYf1TCLXg10Wl99gB9KYG36i9MW1jiYxZwMQIopY4ztBROy5s6IG+9E+kl
         /Jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695130328; x=1695735128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwVxMLRoTi4jmpcZHwksJ5/u+vVpQogOzA/iWOhcTMI=;
        b=IJ9aNX7Eot3pogeJZPxbuJk87OQmtPfuaT0ZCmbSK4KwNc46mrv1ItViqDkrEB32CU
         ftI0vOiHHZFWCblVr4d5KglRSEUPlscFpD0bSLOil1gJwQykgvPQFud8gkQscmtE07OW
         L7/OMf5qT21Yu7M/vJpd/KHtmbAK4Hf+GqpZc+Xb8A9emxPnnBxmhCK8Hc9BgBqSR3OE
         Nv42kqBs1akXSPQlKLhmCNa9ln/0Njvqjmn77oBSeYh8+dl22fOkD9MUd3J7k+ktclxy
         WraCRNl2l89DXaQWQYDskvOkKwjM4h7Q3H62WjiDs9pQVI84JTJrhK1Uz3N7b/vPnMXf
         gPZA==
X-Gm-Message-State: AOJu0YzFGClp07KiZXpxDWrD2umnjVoq6e00mKWEvA2wPLkNLELIIxWh
        msoZ9at91OvsaglLllDCjEmpo3LHh0nH2niuWB+O9ym6
X-Google-Smtp-Source: AGHT+IFsPbd3Z94I5V4mZLsZ0dcHcT44w/wtHVfCTyguyHRWhbnJq6iM8o/Htimw94qJ7HPxPLBgx9cHBwiGaoMkjBc=
X-Received: by 2002:a05:651c:1a1f:b0:2c0:2a6e:7869 with SMTP id
 by31-20020a05651c1a1f00b002c02a6e7869mr1667667ljb.44.1695130327566; Tue, 19
 Sep 2023 06:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230918165958.2659-1-tmaimon77@gmail.com> <20230918165958.2659-2-tmaimon77@gmail.com>
 <b7a337f2-a810-d14c-e7cd-15e33a9ecb5d@linaro.org> <CAP6Zq1gSJYsNUuD-bexFW_1VpAUuF_WZkicNzZms6hVdo9LnMQ@mail.gmail.com>
 <e0d42d13-b307-9915-97c8-948261b39ce1@linaro.org>
In-Reply-To: <e0d42d13-b307-9915-97c8-948261b39ce1@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 19 Sep 2023 16:31:56 +0300
Message-ID: <CAP6Zq1g0=-h0PFg2a8bqao+XjdNHoxGMdYSRRPAnfY_6WdemAw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-binding: usb: ci-hdrc-usb2: document Nuvoton
 NPCM supprt
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     peter.chen@kernel.org, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        xu.yang_2@nxp.com, peng.fan@nxp.com, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, j.neuschaefer@gmx.net,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sept 2023 at 15:39, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 19/09/2023 07:14, Tomer Maimon wrote:
> >>>            - nvidia,tegra20-ehci
> >>>            - nvidia,tegra20-udc
> >>>            - nvidia,tegra30-ehci
> >>> @@ -325,6 +326,20 @@ properties:
> >>>      type: boolean
> >>>      deprecated: true
> >>>
> >>> +  nuvoton,sysgcr:
> >>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> >>> +    items:
> >>> +      - items:
> >>> +          - description: phandle to syscon that configures usb phy mux.
> >>> +          - description: offset of usb phy mux selection.
> >>> +          - description: mask usb phy mux selection.
> >>> +          - description: value usb phy mux selection.
> >>> +    description:
> >>> +      A phandle to syscon with three arguments that configure usb phy mux.
> >>> +      The argument one is the offset of usb phy mux selection, the argument two
> >>> +      is the mask usb phy mux selection, the argument three is the mask usb phy
> >>> +      mux selection.
> >>
> >> Sorry, you miss phy driver. Don't use syscon instead of proper hardware
> >> devices.
> > Sorry the role of nuvoton,sysgcr property is to handle a mux between
> > the different devices and not the handle the phy itself, handle the
> > mux done in the GCR.
> > Should we move the nuvoton,sysgcr description to another place in the
> > ci-hdrc-usb2.yaml
> > or
> > Should we use a different driver to handle the mux and call it from
> > the ci-hdrc-npcm driver, If yes which driver should we use?
>
> What is an "usb phy mux"?
We have USB phy that could be connected to USB host (different driver)
or it can be connected to the UDC driver(ChipIdea)
> Best regards,
> Krzysztof
>

Best regards,

Tomer
