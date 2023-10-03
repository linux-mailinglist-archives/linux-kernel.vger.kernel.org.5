Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751A97B655D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbjJCJWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239583AbjJCJWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:22:54 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BFCA9;
        Tue,  3 Oct 2023 02:22:50 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5033918c09eso781688e87.2;
        Tue, 03 Oct 2023 02:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696324968; x=1696929768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AI28QGsrmaOeIfp5/dnkKIs2m3ja8fuDploYXCzyMN8=;
        b=iVj5Yc6OnzcOemy4Jf4cEMY1B7VVzvT+oyWyrgBYY3MmfBo/H0gDmFS+ckLatD8kVu
         ssBaW5V63Gey0Q0RCKbFWnMQdzMfVIzGZJPDGjnDA6JL69BAMymnmFJAIYKgBhnyqFiK
         XEXl2qZXQ9qlcYiw8zVesoM85bbC9DnClglHTeVfvoYF+YsUG2WejYrlMjWoGjWl7/Q2
         MMQhD4HO6biRQOIId1O0lTFoLaooc3WjhRxLAPkwLbh9UYm2WPPpwxNno39zY5wO4ylA
         tt7YZWxo20ilsDHD41RaNjls4YezuiHMAgE958DLhrHzu5fhMDbyA3s+Xn+VEc8nMWfE
         RE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696324968; x=1696929768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AI28QGsrmaOeIfp5/dnkKIs2m3ja8fuDploYXCzyMN8=;
        b=cSJEKviZ02T/vVHH/O834cegZOT70/l4uAw29Gl/IrvQlkwD/t9pfeaaObwKg/82Nd
         6cRPTiSvbwJyMSM+++tLJ6ISD+f7lixEHB2PoSxYrUTkGAXbCFnhK9MIHdGuQb4tAyja
         8Pe240GbrogMhgBBh3nKyDiE05mPsWnm6hW/toGzfqycQB2sd3360urYSaRRSm9iXw+G
         yrHtODWHRyNnhOXkdaZFZ/m5j3u8HhMliuhLO3byinaV/QNrIEDfTHOt2nkpiMafEOqo
         SqfOEluhm5DF46T62YNeVU24SUL5NGQuxRX/3b1qiDRiDJm9294KZSQLTh05xlnIbLj/
         JPNQ==
X-Gm-Message-State: AOJu0Yxh4sUPmwgNSgpRXOtYwDHca1aWVNacQNhcK6RJsCYsuQJj/iXa
        2V/gr6X11xKpFYNQfrdAVh8Z20KWXbCwq0ilLDI=
X-Google-Smtp-Source: AGHT+IEiM4K2h16qnD5cluahgHpj68PkC/JY1V9W6Ee3KLmHPuO3ZMsCY7A+TWPBXNM/4tDuWAbqLfJHbH0T+suu36I=
X-Received: by 2002:ac2:5453:0:b0:4fe:8c4:44fb with SMTP id
 d19-20020ac25453000000b004fe08c444fbmr11849690lfn.38.1696324968125; Tue, 03
 Oct 2023 02:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAEPPPKu=yxS6SgdLZiuhbF2DRURKVUBNgNbUQ96LxHHbtsJ6Sg@mail.gmail.com>
 <c6a974ce-511c-47f8-b6cb-baeec5283af9@linaro.org>
In-Reply-To: <c6a974ce-511c-47f8-b6cb-baeec5283af9@linaro.org>
From:   Sophon Wu <wuxilin123@gmail.com>
Date:   Tue, 3 Oct 2023 17:22:36 +0800
Message-ID: <CAEPPPKtf6mo7YrUYdT57TiTjWO=NJ61aMDR0W-D2z95EJxQppQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] clk: qcom: add SM8550 DISPCC driver
To:     neil.armstrong@linaro.org
Cc:     Andy Gross <agross@kernel.org>, andersson@kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        Rob Herring <robh+dt@kernel.org>, sboyd@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<neil.armstrong@linaro.org> =E4=BA=8E2023=E5=B9=B410=E6=9C=883=E6=97=A5=E5=
=91=A8=E4=BA=8C 15:16=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On 03/10/2023 04:17, Sophon Wu wrote:
> > On 09/01/2023 16:47, Neil Armstrong wrote:
> >
> >> Add support for the display clock controller found in SM8550
> >> based devices.
> >
> >> This clock controller feeds the Multimedia Display SubSystem (MDSS).
> >> This driver is based on the SM8450 support.
> >
> >> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> >> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> >
> > Hi Neil,
> >
> > I'm trying to enable display on SM8550 but having trouble with clocks. =
Do you
> > have any idea on this maybe? Full dmesg here: https://bpa.st/7E6Q
>
> You may need to remove the cont-splash memory zone and the simple-framebu=
ffer,
> if you leave the cont-splash the bootloader will leave the MDSS on and Li=
nux
> will fail to take over and initialize the clocks.
>
> This is known issue, and for now we re-initialize everything from Linux a=
fter
> ABL disables the display subsystem entirely.
>
> Neil

It works! Thanks a lot for the tip.

Regards,
Xilin
