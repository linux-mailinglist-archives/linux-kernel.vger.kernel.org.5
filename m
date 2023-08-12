Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9531F77A05B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 16:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjHLOMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 10:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjHLOMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 10:12:15 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759C110E4;
        Sat, 12 Aug 2023 07:12:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2680f27b52dso1617402a91.0;
        Sat, 12 Aug 2023 07:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691849538; x=1692454338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OgIvR3F49ZqtH1pqZfkJuT0RLpkkRf+F1xFVL6y3jsE=;
        b=Ds2QVQnChpN0qaiYERYGsTT836Vpc2OFM7MS7OKrYXdDzQbK3XbwiqKfO4q9SSvjH5
         lMimjl7edzRWnhPJhT8zOqZ79j6a4FWDOzY2pezq+/5Fy2ZXIJ4kE7bAHDCfn7oY0cQb
         hI4EPjMtjTBdMSr3ipwzYYCUxXs/9w/VpXfc/4BmSWMqhbW2s0l5tl4OjQx7jtDjAAM1
         Hea4PmuRqVokTcO0+JQGzAifLEDbK2bxvpK2UHgmANZ90A/BVuWuNiYweqyp6joUOGzV
         s9Hb8rSoRbfw6HApbi4MKK0XOOFDSBab6P+aHCMfaHi44CZw+OJ7/SHLk7BsjJKJABkR
         zVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691849538; x=1692454338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OgIvR3F49ZqtH1pqZfkJuT0RLpkkRf+F1xFVL6y3jsE=;
        b=bUkcJDT2tQtU+d8sk1S62WbSdTM6UIypw/Fa2GaoU6FZxTOQccdJdAdC9eiQZAsBma
         C0xCtjnXiItQb1wQJDGDSoJ0VUChJDmFbATEPm8lC0cc5DrR9k1AxnIFuRQG8CrzL6ja
         +Vc3rQbmgbha78dFPJEz57Lv3iExNYmpxdSc4/R9yfYr6QThiERtEFjQobdsbbAJF+Db
         9n8UpXqOx7Lj8/hZ0ReQAPgxCVoMmSOYtFZG6Mkym92box4PvkLqjDK8jgJwESQY7PSV
         WBMUyuyyDDcJlGw6jbrPu0h+VEc2wjgZxuiYdX+1jyS3d/iNABhavhndf6eKtKNUrWSQ
         EoAg==
X-Gm-Message-State: AOJu0YzrIdUtMaL+PXc8AKFBoJP8zg+gIdl3KIxwotC8uQbOYL7dd1io
        ccKirUdsTsvqtj0m3aW2cPbHPyP9+vjHN3gc4ngd3QLo
X-Google-Smtp-Source: AGHT+IEwNxVb6JlNjLh/KBdKIT1+eaC6vZ3hIKXFXnHCDqg+8wdROJK9/L8s0I+nOXi1GrU8njq5hPqFs6DnjGbpaD4=
X-Received: by 2002:a17:90b:1e4d:b0:268:7ce2:ad20 with SMTP id
 pi13-20020a17090b1e4d00b002687ce2ad20mr2907730pjb.21.1691849537811; Sat, 12
 Aug 2023 07:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230811210142.403160-1-robimarko@gmail.com> <20230811210142.403160-2-robimarko@gmail.com>
 <4c96210b-4567-4cb5-80bb-7adca6c5f124@linaro.org> <CAOX2RU6X0Tww4UkTKVfc=PLY=RKVJdsm+gomytT0vOydTF+Hnw@mail.gmail.com>
 <7116b473-7f22-43df-af39-81e5f6db4507@linaro.org> <CAOX2RU6nMvpTkGdwBoLJrES5v0qARnDDT6nCVd-DZid7p3pg6Q@mail.gmail.com>
 <e784f70f-3232-42e6-bf4c-67075abd210a@linaro.org> <CAOX2RU7cLoK206hLkfDr+Ry8QgS5F48EEiSbJ+gbGK_xkXBDpA@mail.gmail.com>
 <389904f7-86fa-48be-ba30-aa8cfeb44353@linaro.org>
In-Reply-To: <389904f7-86fa-48be-ba30-aa8cfeb44353@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Sat, 12 Aug 2023 16:12:06 +0200
Message-ID: <CAOX2RU5OeGdhk2DoG-noE2RHDmQ-6TnFxVRwHCnmWXWRZE6-5g@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: qcom: ipq4019-ap.dk01.1: align flash node
 with bindings
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sat, 12 Aug 2023 at 16:08, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 12.08.2023 16:07, Robert Marko wrote:
> > On Sat, 12 Aug 2023 at 12:47, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>
> >> On 12.08.2023 11:55, Robert Marko wrote:
> >>> On Sat, 12 Aug 2023 at 00:56, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>>>
> >>>> On 11.08.2023 23:35, Robert Marko wrote:
> >>>>> On Fri, 11 Aug 2023 at 23:28, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>>>>>
> >>>>>> On 11.08.2023 23:01, Robert Marko wrote:
> >>>>>>> Rename the SPI-NOR node to flash@0, remove #address-cells and #size-cells
> >>>>>>> as they should be under the partitions subnode and use the generic
> >>>>>>> jedec,spi-nor compatible.
> >>>>>>>
> >>>>>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
> >>>>>>> ---
> >>>>>> You can also do "nandmanufacturer,mx25l25635e", "jedec,spi-nor"
> >>>>>
> >>>>> Hi,
> >>>>> I grepped the vendor U-Boot to make sure it's not being triggered off
> >>>>> the mx25l25635e
> >>>>> compatible but the only hit is the IC support itself.
> >>>>> MX25L25635 was just the original NOR IC Qualcomm used on the board so
> >>>>> to me it made
> >>>>> most sense to just use the JEDEC compatible as NOR itself is JEDEC NOR
> >>>>> compatible.
> >>>> OK if dynamic identification works fine
> >>>
> >>> It should work fine, datasheet is clear that its JEDEC compatible.
> >>> That being said, I dont actually have the board, just figured it was
> >>> time for a cleanup as
> >>> OpenWrt has been patching DK01 and DK04 for ages.
> >> Hm. Do we know whether there are still users of this boards?
> >
> > I honestly doubt it as they have been broken in OpenWrt for years and
> > nobody complained.
> > So we are currently removing support for them, but I still wanted to
> > at least fixup the DTS state
> > upstream.
> > These boards are not obtainable anymore.
> I also noticed they were detached from the other snapdragons in u-boot
> for no good reason (at first glance anyway).

If you are talking about the mainline U-Boot then yeah, my basic port was done
years ago and I knew way less about the SoC then now.
Currently its on my TODO to merge them with Snapdragon and add some proper
GPIO and pinctrl drivers as well as using the Linux DTS.

>
> If we don't get any hands up from users, I think deprecation is in order.
>
> Konrad
