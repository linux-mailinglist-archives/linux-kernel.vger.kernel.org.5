Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317C477B723
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbjHNKzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbjHNKzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:55:05 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F4518F;
        Mon, 14 Aug 2023 03:55:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2681223aaacso2748597a91.0;
        Mon, 14 Aug 2023 03:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692010503; x=1692615303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hhmwSyjtQSxE/dkQdva/YxGtcysRwvIZ3JCpWE/74fU=;
        b=kK+0yX5JEMbSzoqNOg9GH6WpHRbXUru+rWhxp1w12IjYg5tK+rOiM6CLsFMdbJqf/M
         xO5z0zHZ/rpIUWs3GH/CNTbVAeUArH9pJueNnPTqgC1IQ37hAz2BEdLMQ9tZ98t/xkl1
         tiYHtL7nMkfsG+UJRPgnHIdRSzzxrn+ZpwdffTf6K0FXjBUuGyWNcFyMOIBNUD9jaIBS
         BMYofih2X5u9Ixb3gWNNWNubsl61NAqBEa2J7AQh5b2aWZKNKM1O68cC3ihTS3tyzIkM
         nF8iwojrtuDXhhrmEw5MEmfgKkqaOlzYVSoBr/N+lf38hjPqwwv+o9J+hFLx3dMvkYwT
         UCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692010503; x=1692615303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hhmwSyjtQSxE/dkQdva/YxGtcysRwvIZ3JCpWE/74fU=;
        b=hgZ3OSU4AX5r55iZDe1HMnCoC+h85lQI0jJb9FoXpg3i5zAhE75ocxqdnIoUKWoNZO
         bKQygEhVknkEt75By2inzeORCfRsnTtMfAYI4dryZv/RyqCp3CLdFAOjXLji98J/G4Lx
         IhlxFoIQHzhozbMNuI2QAt7z0a1zCQ1HzLncqOh90UmNWMDnRMdf5OTaYHdYxHYirvmg
         CkgouGTE0kPSgwlh5uQWk9fI953e+yna62cu7Yc13bbRCIvNqbbzm1zwT2GfKn+lSixs
         uRW4QuvfVyljjjGFcUk1lPNIrQFA0sfBwMC3LRgFFCrCpuvcO/ih2TgfxnWPNNPNiFKQ
         6npg==
X-Gm-Message-State: AOJu0Yw6zqLzyU5SBB8992KLL0okfzBXohJiUeNCDL5ZuoBEYuKIB/E7
        s6EeWq3qm+MWbpQitEjEbl1d4adYw2dHomE0gtc=
X-Google-Smtp-Source: AGHT+IF7oSDdFynB6xKqblmAfUlYq6Y1BpV3hF5BMWuVAgi4SwVHzBomhRKtBwEF8OQ7fCq+UgOSA0Yz1sA76q/ihO4=
X-Received: by 2002:a17:90b:78d:b0:268:5e70:507c with SMTP id
 l13-20020a17090b078d00b002685e70507cmr16221272pjz.4.1692010503156; Mon, 14
 Aug 2023 03:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230811210142.403160-1-robimarko@gmail.com> <20230811210142.403160-2-robimarko@gmail.com>
 <4c96210b-4567-4cb5-80bb-7adca6c5f124@linaro.org> <CAOX2RU6X0Tww4UkTKVfc=PLY=RKVJdsm+gomytT0vOydTF+Hnw@mail.gmail.com>
 <7116b473-7f22-43df-af39-81e5f6db4507@linaro.org> <CAOX2RU6nMvpTkGdwBoLJrES5v0qARnDDT6nCVd-DZid7p3pg6Q@mail.gmail.com>
 <e784f70f-3232-42e6-bf4c-67075abd210a@linaro.org> <CAOX2RU7cLoK206hLkfDr+Ry8QgS5F48EEiSbJ+gbGK_xkXBDpA@mail.gmail.com>
 <389904f7-86fa-48be-ba30-aa8cfeb44353@linaro.org> <CAOX2RU5OeGdhk2DoG-noE2RHDmQ-6TnFxVRwHCnmWXWRZE6-5g@mail.gmail.com>
 <7fdee4c2-4c14-4a7f-b161-52ccd2458d3f@linaro.org>
In-Reply-To: <7fdee4c2-4c14-4a7f-b161-52ccd2458d3f@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 14 Aug 2023 12:54:52 +0200
Message-ID: <CAOX2RU6vG=cwW=A3zzMc0WT02a57LEpdZhHP_Bks5P_y486Fbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: qcom: ipq4019-ap.dk01.1: align flash node
 with bindings
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Aug 2023 at 16:15, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 12.08.2023 16:12, Robert Marko wrote:
> > On Sat, 12 Aug 2023 at 16:08, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>
> >> On 12.08.2023 16:07, Robert Marko wrote:
> >>> On Sat, 12 Aug 2023 at 12:47, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>>>
> >>>> On 12.08.2023 11:55, Robert Marko wrote:
> >>>>> On Sat, 12 Aug 2023 at 00:56, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>>>>>
> >>>>>> On 11.08.2023 23:35, Robert Marko wrote:
> >>>>>>> On Fri, 11 Aug 2023 at 23:28, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>>>>>>>
> >>>>>>>> On 11.08.2023 23:01, Robert Marko wrote:
> >>>>>>>>> Rename the SPI-NOR node to flash@0, remove #address-cells and #size-cells
> >>>>>>>>> as they should be under the partitions subnode and use the generic
> >>>>>>>>> jedec,spi-nor compatible.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
> >>>>>>>>> ---
> >>>>>>>> You can also do "nandmanufacturer,mx25l25635e", "jedec,spi-nor"
> >>>>>>>
> >>>>>>> Hi,
> >>>>>>> I grepped the vendor U-Boot to make sure it's not being triggered off
> >>>>>>> the mx25l25635e
> >>>>>>> compatible but the only hit is the IC support itself.
> >>>>>>> MX25L25635 was just the original NOR IC Qualcomm used on the board so
> >>>>>>> to me it made
> >>>>>>> most sense to just use the JEDEC compatible as NOR itself is JEDEC NOR
> >>>>>>> compatible.
> >>>>>> OK if dynamic identification works fine
> >>>>>
> >>>>> It should work fine, datasheet is clear that its JEDEC compatible.
> >>>>> That being said, I dont actually have the board, just figured it was
> >>>>> time for a cleanup as
> >>>>> OpenWrt has been patching DK01 and DK04 for ages.
> >>>> Hm. Do we know whether there are still users of this boards?
> >>>
> >>> I honestly doubt it as they have been broken in OpenWrt for years and
> >>> nobody complained.
> >>> So we are currently removing support for them, but I still wanted to
> >>> at least fixup the DTS state
> >>> upstream.
> >>> These boards are not obtainable anymore.
> >> I also noticed they were detached from the other snapdragons in u-boot
> >> for no good reason (at first glance anyway).
> >
> > If you are talking about the mainline U-Boot then yeah, my basic port was done
> > years ago and I knew way less about the SoC then now.
> > Currently its on my TODO to merge them with Snapdragon and add some proper
> > GPIO and pinctrl drivers as well as using the Linux DTS.
> Take a look at this branch of mine [1], I already did some of that.
>
> If you wish to upstream that, please coordinate with Caleb (+CC) who
> may be interested in the same in parallel.
>
> [1] https://github.com/konradybcio/u-boot/commits/konrad/rb1_forcepushing

That is great, though this is very low hanging fruit for me, I have
plenty more of IPQ807x
stuff that needs to make its way upstream.

Regards,
Robert
>
> Konrad
