Return-Path: <linux-kernel+bounces-103021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3B687BA02
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED3E1C21FD0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48016BFA8;
	Thu, 14 Mar 2024 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UHmQqejv"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378376BFA3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710407107; cv=none; b=Go3N3k9jUbjxNn8KVnUYmJ8kabeXWbjFyrsHQluugvkp5uxm4RpNnISqJm0nWRe5VV/SS7uRHKndJf3hVSZU9cLPbJKJo/2bGlIKJ2N07t8cGnqsGnyHCpysD22raIbk/pVfvs8dw2sOIPn26JV8+N2v/Ftdr1jLsxFgXEis8Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710407107; c=relaxed/simple;
	bh=yrn71eIjOmgBSyIqCd4lKsazo4Wdi2E8bP1fOz/khS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FvJPECBn6WWjVRGlMadY16W3jizI0Yjnmcvz2GlshmveHCu0+8su7ohlb4Xxs5X2danWshLI3O8SMLij3vYFn8x1BSHEu99rojA+h6zobJzafO4G89jdWe88H5JL4PcHRIFrN7MCTzwaSb1uGg0QWAYoQQrT6FWtOV+94tKow0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UHmQqejv; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4d371351b62so217886e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 02:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710407105; x=1711011905; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pluLdqg2nkucRAZjVzjgsrwf+1H2Zzn4zs52dfBa6jY=;
        b=UHmQqejv0ywXStRFoeZk/5Mf5im0AyG71dpNulPVKXumBVca8zx0xUwSTHNxWaQteZ
         CJfbKrldd1nsCNmHfkeygAhdF+6wd+WT9orjon+VKm2dl260fxHLmBLkgDtNpYFkelm6
         kTJ+lQppsILf18rcIQrQA9GZJ5h/Hr+nPD9iAD9s5wVUzk5AfA61fE8Sr+dnfXQEcQUt
         NY4XBqz7BE3fQHAw/CwVbFx9KWU0eZP6CD3RNQSi6RjVxzQcHjtSx6ic6uGRpHo6yrpk
         z4/KE6OsmRXWUYqEDfB1HEyBd4Z2JUZpp8m+ReP6zNQHOMBgX2w5a/3ZEJfv0JJTBiYo
         JhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710407105; x=1711011905;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pluLdqg2nkucRAZjVzjgsrwf+1H2Zzn4zs52dfBa6jY=;
        b=A4Yr7Zpiq76A6jB3HHMSSYQdUH6Jj6MmywDG/zcr/JaNM2s8jFWkb4xB6czz4Thfq5
         4T2BUhPb1vwOl6PDCzVkExBjnGTTFavpS8d2etIj87ICnFGIvtIoLQqLT64LajcA4OIB
         MJVtfNFa6KWTbah9FTjnLKjLvGSGru22hfQdbj0KlLph0CiiDdpwcnM3R+k6gVGt9Nzd
         pz0X40ZouEENItWYg8Ug9KtrzLXggvbTsgo1s8c2UYMGXOPB+36oFnDXGdQuSV0cFpa2
         PU4qPg4Lv5Ool7fFVZAp+wMGjAxe7BSzQd2cdqt3RGG4KrBcUgwuM3eMAgB3UrBkV9LT
         TqUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVApEutTEs1bG4xG6KUwi7xnqrv4A2ezyDCCo2GlU2bF39Z0qHZhlfWGsJLO4Hu69eKOJYRyOZUXOiX9PcnnI49hfHv9eD8iFBrvARa
X-Gm-Message-State: AOJu0YxZFNZi1bO1deYUAtXat2oIPI6AGkOjYEIj1rCtZKlafydEZLe9
	THQOYEqBdUI0pWo5CByIuLCmyxbduYWE1ctkRT0y38MkbQArqOWAITNfFBZ9zO1UdiZf+V1Ex3O
	svxYshApL/ehvXdEBxooCvmhaaU9kX7lV30IN4A==
X-Google-Smtp-Source: AGHT+IFf63LIfFoXzeMmE019hGsU2o70hLnxbZpGgVf8VdO2xiC1dsEM4H6OfRCTb6FY/3CrHAvcTT+chq2P6gFWn1U=
X-Received: by 2002:a05:6102:2434:b0:473:2305:7f53 with SMTP id
 l20-20020a056102243400b0047323057f53mr1176915vsi.2.1710407105142; Thu, 14 Mar
 2024 02:05:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313123017.362570-1-sumit.garg@linaro.org>
 <20240313123017.362570-4-sumit.garg@linaro.org> <c0e10cbf-c6f3-4b0c-8616-983da2a40236@linaro.org>
In-Reply-To: <c0e10cbf-c6f3-4b0c-8616-983da2a40236@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 14 Mar 2024 14:34:53 +0530
Message-ID: <CAFA6WYNMjCaa0FKjNv6a8VFkco3=GBfgWNDuckGZdiZ9dGmHgg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	andersson@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, stephan@gerhold.net, caleb.connolly@linaro.org, 
	neil.armstrong@linaro.org, laetitia.mariottini@se.com, pascal.eberhard@se.com, 
	abdou.saker@se.com, jimmy.lalande@se.com, benjamin.missey@non.se.com, 
	daniel.thompson@linaro.org, linux-kernel@vger.kernel.org, 
	Jagdish Gediya <jagdish.gediya@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Konrad,

On Wed, 13 Mar 2024 at 18:34, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 3/13/24 13:30, Sumit Garg wrote:
> > Add Schneider Electric HMIBSC board DTS. The HMIBSC board is an IIoT Edge
> > Box Core board based on the Qualcomm APQ8016E SoC.
> >
> > Support for Schneider Electric HMIBSC. Features:
> > - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> > - 1GiB RAM
> > - 8GiB eMMC, SD slot
> > - WiFi and Bluetooth
> > - 2x Host, 1x Device USB port
> > - HDMI
> > - Discrete TPM2 chip over SPI
> > - USB ethernet adaptors (soldered)
> >
> > Co-developed-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> > Signed-off-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
>
> [...]
>
> > +     memory@80000000 {
> > +             reg = <0 0x80000000 0 0x40000000>;
> > +     };
>
> I'm not sure the entirety of DRAM is accessible..
>
> This override should be unnecessary, as bootloaders generally update
> the size field anyway.

On this board, U-Boot is used as the first stage bootloader (replacing
Little Kernel (LK), thanks to Stephan's work). And U-Boot consumes
memory range from DT as Linux does but doesn't require any memory to
be reserved for U-Boot itself. So apart from reserved memory nodes
explicitly described in DT all the other DRAM regions are accessible.

>
> > +
> > +     reserved-memory {
> > +             ramoops@bff00000 {
> > +                     compatible = "ramoops";
> > +                     reg = <0x0 0xbff00000 0x0 0x100000>;
> > +
> > +                     record-size = <0x20000>;
> > +                     console-size = <0x20000>;
> > +                     ftrace-size = <0x20000>;
>
> No ecc?

Okay I can add that.

>
> > +             };
> > +     };
> > +
> > +     usb2513 {
>
> Please use a generic node name, like usb-hub

Ack.

> and keep the nodes
> sorted.

See other email thread...

>
> > +             compatible = "smsc,usb3503";
> > +             reset-gpios = <&pm8916_gpios 1 GPIO_ACTIVE_LOW>;
> > +             initial-mode = <1>;
> > +     };
> > +
> > +     usb_id: usb-id {
> > +             compatible = "linux,extcon-usb-gpio";
> > +             id-gpios = <&tlmm 110 GPIO_ACTIVE_HIGH>;
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&usb_id_default>;
>
> property-n
> property-names

Ack.

>
> [...]
>
> > +             led@5 {
> > +                     reg = <5>;
> > +                     label = "apq8016-hmibsc:green:wlan";
>
> These names look overly complicated.. s/apq8016-hmibsc://g?
>

I will drop them as suggested by Krzysztof.

>
> > +
> > +&blsp_i2c3 {
> > +     status = "okay";
> > +
> > +     eeprom@50 {
> > +             compatible = "atmel,24c32";
> > +             reg = <0x50>;
> > +     };
> > +};
> > +
> > +&blsp_i2c4 {
> > +     status = "okay";
> > +
> > +     adv_bridge: bridge@39 {
> > +             status = "okay";
>
> ???

Will drop it.

>
> > +
> > +             compatible = "adi,adv7533";
> > +             reg = <0x39>;
> > +
> > +             interrupt-parent = <&tlmm>;
> > +             interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
>
> interrupts-extended
>

Please see Documentation/devicetree/bindings/display/bridge/adi,adv7533.yaml.

-Sumit

> Konrad

