Return-Path: <linux-kernel+bounces-95068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CE58748E2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FAC328205E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC1663117;
	Thu,  7 Mar 2024 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1TZAGW/"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7404A629EE;
	Thu,  7 Mar 2024 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709797125; cv=none; b=AtnNFzBUXfx/PuV8PCQv2c7nkAVmr35HivtXhFktlqCvpNTO/RWbgAyrCTBwF0YKywXE5JvbYkV2DAH18YX85rVeQUkCERF2riMoPTgQhwHPpqxwCJbqdmgqOUhjRCmw0e5IYQFYUDhMNWsWXlrg/FWVzlqgGHsm9eBak/3ymxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709797125; c=relaxed/simple;
	bh=QZDtxWtiWsaXzVEJuIGs8nppd+BP0qnH+cZoDsvDnkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXISXR9zk8p/qxZjc1lQgTZxHuHviPjgpOtOTjljghOUPWwsbbdprvQXIhXqk3yxwSIX3ECnGOY2gD+uWhrOl+sqk8+cz4/JaBFdIn+T1k/47+VCB6zfUO8Bgo9un3f0Sud+lKwukLJX1gbU3/yCcfm4QK7su9+PXooausE/yHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1TZAGW/; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso360513a12.3;
        Wed, 06 Mar 2024 23:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709797124; x=1710401924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fo4W1rjQGY32ECPDHzMWRRX2lcPya1jBNNol53n/HhM=;
        b=h1TZAGW/cXTzolnzbmjNDFAiZ+wgA6YD6P5XhEeu9CZ0ViXGzVNxxLNs+eafBepX8W
         WoYtjjo+yHH8wrEBrxXkcTUF141W7MiCbBCRfFSTEraKqvVqqrOzbAr2ODWjV+Yx13hY
         qlgwH0auPG4huYPSWr/K0PzsPcNgQfvCLN8QfqZ7RLXDo1UdHCdZMpXVw9S888GZbi2B
         knH3DWGQVCnoihgw8RVc8ktF3/4HW0BGY7vISfaOwliaIT19kZ/0Dzpr4DJdw8Woyp/M
         ZDpGRccnGy1dPTiuGe3cvsFl4cHU8m+MvEX4GmolXWuK3a1c+vL1NaI1h81zyMPgaqWN
         45VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709797124; x=1710401924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fo4W1rjQGY32ECPDHzMWRRX2lcPya1jBNNol53n/HhM=;
        b=nq8W0Ydx2ob9YRP/INA5nvawlRS9ovHgZbmD1X5IniWKAb4jafi6ZywfLTx298XCX5
         iflNkdlQVYJhGHs+6MqiW+vgwzUf8jG5zVFZeV74ppjfOtJoyQk/dxW0cdI/pyeasz9i
         Z5GvhhUTm1hNH+rvXw2Zs8Yo6xTxRDYub88hEJTB2l6nj146ZrjgTWkE4xrQPOADwQ2k
         Xqfm8Wr0WiFpMWnloo4LbalcaMeGs/lnqSqWVYYMNZtAklKp/Z0QigkFz1sn6AZpiKn1
         qR5Xt3MaaMdYDcX9KU8/yU9TBLt+fdsaga8fWjK+QdDdqmRfZswwPbryZaWMBO55WXNw
         VS1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9F+yxrSFkJAKx1iKM+y2giE0fwSsVNwEtwVLJsMwTZwjn5Uj2Avlq1votCiC6FtstxY1iDepffqHApVBB/AS+CbXK3ZAeYk5gnnukDkSU5pngf6tnisXyMYdr9gbmNeIH6kef8butLoZYcDC7aqlrqWumgjsm7v+12jWZTm/bSdMjkIuvCWM=
X-Gm-Message-State: AOJu0YwI5ShLfrBf4Bb6zS4d6nMSplOsGZbJq1FZY9FA1Vqp4r0XVl4c
	80ZiUI9Zeg1SzvsXVwIVbp4XXK9VP2nk8Zx4Y8Zj/LVhkdGnKXIt+Zk+PJTMQS8Ye6qHpeEISwb
	pHbV1YWn4X1PPkbrIBulxLoQHFGW6fVVv
X-Google-Smtp-Source: AGHT+IEvUKFBal6PUczVHRGMvlQIQ73Nr8uvACXWiA6RWIcpIsYoKHXkxXIevneLi2tpY6K5uVUQ9HexoaPjAILo7yU=
X-Received: by 2002:a05:6a20:c222:b0:1a1:42fb:af59 with SMTP id
 bt34-20020a056a20c22200b001a142fbaf59mr6256789pzb.37.1709797123726; Wed, 06
 Mar 2024 23:38:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306123006.724934-1-amadeus@jmu.edu.cn> <20240306123006.724934-2-amadeus@jmu.edu.cn>
 <CAA8EJpqYjutM1Kh6QxysB6XNAmXywtOtRJ7KP0LbY5E36kCPvA@mail.gmail.com>
 <78b1a1a2-a9fa-4b28-9d96-d65bb5517199@gmail.com> <CAA8EJppJBOQh19r4A-igsh5znDE_R6mDNy+ao5ximx7vtsZZvA@mail.gmail.com>
In-Reply-To: <CAA8EJppJBOQh19r4A-igsh5znDE_R6mDNy+ao5ximx7vtsZZvA@mail.gmail.com>
From: Robert Marko <robimarko@gmail.com>
Date: Thu, 7 Mar 2024 08:38:32 +0100
Message-ID: <CAOX2RU4W-zV3A8eW0A+1V838Fm=tUkXY=Bs3j4VJ8Jo9mxrOAw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] arm64: dts: qcom: ipq6018: add sdhci node
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 08:28, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, 6 Mar 2024 at 22:35, Robert Marko <robimarko@gmail.com> wrote:
> >
> >
> > On 06. 03. 2024. 20:43, Dmitry Baryshkov wrote:
> > > On Wed, 6 Mar 2024 at 14:31, Chukun Pan <amadeus@jmu.edu.cn> wrote:
> > >> Add node to support mmc controller inside of IPQ6018.
> > >> This controller supports both eMMC and SD cards.
> > >>
> > >> Tested with:
> > >>    eMMC (HS200)
> > >>    SD Card (SDR50/SDR104)
> > >>
> > >> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> > >> ---
> > >>   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 19 +++++++++++++++++++
> > >>   1 file changed, 19 insertions(+)
> > >>
> > >> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> > >> index 322eced0b876..420c192bccd9 100644
> > >> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> > >> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> > >> @@ -441,6 +441,25 @@ dwc_1: usb@7000000 {
> > >>                          };
> > >>                  };
> > >>
> > >> +               sdhc: mmc@7804000 {
> > >> +                       compatible = "qcom,ipq6018-sdhci", "qcom,sdhci-msm-v5";
> > >> +                       reg = <0x0 0x07804000 0x0 0x1000>,
> > >> +                             <0x0 0x07805000 0x0 0x1000>;
> > >> +                       reg-names = "hc", "cqhci";
> > >> +
> > >> +                       interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> > >> +                                    <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> > >> +                       interrupt-names = "hc_irq", "pwr_irq";
> > >> +
> > >> +                       clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> > >> +                                <&gcc GCC_SDCC1_APPS_CLK>,
> > >> +                                <&xo>;
> > >> +                       clock-names = "iface", "core", "xo";
> > >> +                       resets = <&gcc GCC_SDCC1_BCR>;
> > >> +                       max-frequency = <192000000>;
> > > If I understand correctly, GCC_SDCC1_APPS_CLK support frequencies up
> > > to 384 MHz, but here you are limiting it to 192 MHz. Why is it so?
> > >
> > > I am not sure that 384MHz is actually supported as IPQ6018 datasheet
> > > clearly indicates that HS400 mode is not supported.
>
> I didn't check the datasheet, I opened the gcc-ipq6018.c

I understand that, I just pointed it out, it wouldn't surprise me if
the frequency table
was just copy/pasted from IPQ8074.

Regards,
Robert
>
> > >
> > > Regards,
> > > Robert
> > >
> > >> +                       status = "disabled";
> > >> +               };
> > >> +
> > >>                  blsp_dma: dma-controller@7884000 {
> > >>                          compatible = "qcom,bam-v1.7.0";
> > >>                          reg = <0x0 0x07884000 0x0 0x2b000>;
> > >> --
> > >> 2.25.1
> > >>
> > >>
> > >
>
>
>
> --
> With best wishes
> Dmitry

