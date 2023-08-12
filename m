Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776A4779EB9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 11:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbjHLJ4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 05:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHLJ4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 05:56:03 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F76D100;
        Sat, 12 Aug 2023 02:56:07 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-56c74961e0cso2243975eaf.3;
        Sat, 12 Aug 2023 02:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691834166; x=1692438966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U8wjaQXSLMzRwh0cRitdikC2z6aQUD+mqTclR1K6a5M=;
        b=flFkz6QkLIfqczqvD5zVuAarSOCtSsACYOuyvURalMYE11GpQE7pGasz9SsWJDUW/Y
         uqw6/EFyK58IHMbs6GV5pVtkdh7bWLig+dyV7dJ0EX/4/SgMc+lDRv/CVM/yLtv5435U
         RJLZTrbNgVzr/2YrcmNB98HzhFF+B5a5X39WQlaejo8KJNZHrzXqh/H28JC7PTl0se9N
         rKZdYvsnAAsFPr+pgXd9xVPRNopg7V9anRl3pobqDaDcJQiSOQu9T2AOkW8HDPaxR/wc
         GZndQ3NuNJzE2mS/KHFI3pml3ThWUFNXKMD3Eg/MxgeHRfIHS/nYX+R3nDNLmqfYY2it
         z5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691834166; x=1692438966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8wjaQXSLMzRwh0cRitdikC2z6aQUD+mqTclR1K6a5M=;
        b=G62zSSfi+Q2xJo0WjqCinwfVt50R7QR8peMduKiOYMjuJ6fBrHy4nnumz95x4KloZv
         Xtgz73TrpYwNMh2HPH5zFcoZlaDqquuEvxrc/+tIgk91z+j/2aSBWubs1XAg6fl8HuGj
         B0DsM1Q7FadLdi9XbutGzkrOiFQnwYYYmVKo6GlMLd6ffaiA0iygouKTNM2UmEPSjeyK
         KyYtoP0fLO9gHt6V/sssGQMW5LAFNgmCJV/iOK4zsQYYfrOYizV3qWeA5UMISfXzXsh4
         mLU5N6MupH4lBY8B+cWgBHtl+Y/1PkMU28EbxNF9NjuBycMqTuOFo+cNNkgW5gbPv92m
         iLnw==
X-Gm-Message-State: AOJu0YyXE6Zy4aoO6aktH4XIPDC46lwianLubv1k346nf9esL2IBX0Jt
        FZ6v/HpmjoftnUCfXJZuAlS+8+YLmAV9PSHW+pTbWrCW
X-Google-Smtp-Source: AGHT+IFPkv3F2BAgtU0mz7BhUPJx9bjS9SnrspuiRZr04lLjBdoBf66zikjRMd5dtb5tc9QAUZLGqq6jDryDMQlZiPw=
X-Received: by 2002:a05:6870:8301:b0:18b:1936:30ee with SMTP id
 p1-20020a056870830100b0018b193630eemr5165190oae.56.1691834166433; Sat, 12 Aug
 2023 02:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230811210142.403160-1-robimarko@gmail.com> <20230811210142.403160-2-robimarko@gmail.com>
 <4c96210b-4567-4cb5-80bb-7adca6c5f124@linaro.org> <CAOX2RU6X0Tww4UkTKVfc=PLY=RKVJdsm+gomytT0vOydTF+Hnw@mail.gmail.com>
 <7116b473-7f22-43df-af39-81e5f6db4507@linaro.org>
In-Reply-To: <7116b473-7f22-43df-af39-81e5f6db4507@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Sat, 12 Aug 2023 11:55:55 +0200
Message-ID: <CAOX2RU6nMvpTkGdwBoLJrES5v0qARnDDT6nCVd-DZid7p3pg6Q@mail.gmail.com>
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

On Sat, 12 Aug 2023 at 00:56, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 11.08.2023 23:35, Robert Marko wrote:
> > On Fri, 11 Aug 2023 at 23:28, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>
> >> On 11.08.2023 23:01, Robert Marko wrote:
> >>> Rename the SPI-NOR node to flash@0, remove #address-cells and #size-cells
> >>> as they should be under the partitions subnode and use the generic
> >>> jedec,spi-nor compatible.
> >>>
> >>> Signed-off-by: Robert Marko <robimarko@gmail.com>
> >>> ---
> >> You can also do "nandmanufacturer,mx25l25635e", "jedec,spi-nor"
> >
> > Hi,
> > I grepped the vendor U-Boot to make sure it's not being triggered off
> > the mx25l25635e
> > compatible but the only hit is the IC support itself.
> > MX25L25635 was just the original NOR IC Qualcomm used on the board so
> > to me it made
> > most sense to just use the JEDEC compatible as NOR itself is JEDEC NOR
> > compatible.
> OK if dynamic identification works fine

It should work fine, datasheet is clear that its JEDEC compatible.
That being said, I dont actually have the board, just figured it was
time for a cleanup as
OpenWrt has been patching DK01 and DK04 for ages.

Regards,
Robert
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>
> Konrad
