Return-Path: <linux-kernel+bounces-103058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3E587BA7E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2904C1C21660
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809866DCE3;
	Thu, 14 Mar 2024 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JXcVdz7r"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68B76CDBD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710408766; cv=none; b=SjgGYcEKbinxsENfFOjCG7lHqz1jCTTEShmmlXsxmiRBy8wbn2G0TOXgVYVPRpUXYP1p/gsKoyhi2wsc0JZZCfxYpm3BVRwZXyRYPrmw4qHMptM0hgVkkxtCPQ4ELaXwIdobziSvaWxbcKD5qurKBHoWru6zJBsjIq4JXn+Gm+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710408766; c=relaxed/simple;
	bh=BOQwADhp6hNBBGWp57cYwSctxcMOUUM6fgHRtwk1t5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hk8Z5gHgEWYzeFsyOGhkZx2Pg6/gzSdZlsHWT89BQUW2LjIjbfBODHnIXuY4jVxT/ninMmSZnf7KhbjrvbtMR4lpnv7kJmf5xlBWTYl042DDO+1lwIkBLyWekbZekIAXotaFHxtUZuFCU9ER0DS/PyIQC8/gZ4KoEyvza8Y6eCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JXcVdz7r; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-475767a2a42so792342137.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 02:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710408762; x=1711013562; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5JooR2GP0yo+BFgcavLa552X/AqpFEXdVuiGm3v30sY=;
        b=JXcVdz7rpBGnIdW4ixwYHnoVddO3sJ7o5Xp5UJ3LnIx8tvCnyzHQmoL5W9ptuAvx52
         up5QxdgfqfGeSnFK1aHuJ41KnedZuyQ1lssL3QJ5rZZIz8o1Tf04xZ1ajMDNdi7PMG1r
         sp+pLeU+XMdpleTG/w6aEYblUzqWo+l4UQtF+wcFa1GG6aPbOKbonwLlbckiJcUkoTGr
         P6JuTWUvIMwvtAbQPrcWQ+cVIer0oJI7D5/mt8oQZQx06ITsAa29eUEYNI2MyWoQ9jV7
         iN9oitoB1+042Wq154B3+zcntJAMmL3Kr/I/JA/86H7YrGrhtaxgnvya5Dlj7iWkHQUT
         T/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710408762; x=1711013562;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JooR2GP0yo+BFgcavLa552X/AqpFEXdVuiGm3v30sY=;
        b=XISn+O74y2l23muE9DahIXNv05AANzAceHpcvUkT+uxa2kdtgf/8WEoov8jvvHftTl
         b/iePN48tWY+XQjGTlsulXhztOlcbmzq2hAUIJVV8C0x38mp8oAmPnMNE4pQE3Dhme1H
         YiR0voGt2b1BD5igaoG+GpsXiLI2ZQKh9xwKSJWMI6zjWWmRJxqJb8p1wuNxMQoFHJei
         RvXhSH1vWTVKb1kWzvlhLnf5+DPmbMk15Q4qASf1v7xxykFT2plpu2kL7IIgIn5i8LjS
         49tdsHMMlfROfTABVhD6wCE2VNjBrQo1/xjtA2knDUAghaeaKRR3h4pmabiD0c3YsMI8
         307w==
X-Forwarded-Encrypted: i=1; AJvYcCUPbuyqUJXQIrKZ2xK2pyfBMKbqj6ZS/hBBxsqbAr6YVxIUo3fPkNXgU+7sDefyXYdoQxYHlDlCCLFpeBjaMa7/PcwQA9O/yun6OM/8
X-Gm-Message-State: AOJu0YzscgYaCsh68LCP3IImIv8JUgYBtwLY+QCxkJ5fbONH/s6PLVpz
	r1MPI03HkmUlVVM5xmu+PPlbY7dq5bB/tDzenySm7VKHovZanbKnjR+4Cts0OpInFOdIp9c05XC
	Okxm1S92sQnWPmdz44ANEcbbWf8uqgHUf7IU3ow==
X-Google-Smtp-Source: AGHT+IEw/ehjPfDXNATTHtGrSHHP4C9JwV6Kj6BatJG08Bp402mPy1LMb6cyyRyUbYRiGWhqcYgS8xdIUCRwabBR1Bc=
X-Received: by 2002:a67:f247:0:b0:473:48b6:48b5 with SMTP id
 y7-20020a67f247000000b0047348b648b5mr1285848vsm.2.1710408762595; Thu, 14 Mar
 2024 02:32:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313123017.362570-1-sumit.garg@linaro.org>
 <20240313123017.362570-4-sumit.garg@linaro.org> <c0e10cbf-c6f3-4b0c-8616-983da2a40236@linaro.org>
 <CAFA6WYNMjCaa0FKjNv6a8VFkco3=GBfgWNDuckGZdiZ9dGmHgg@mail.gmail.com> <d82ab1f8-e677-485f-9a6b-4115acfd7239@linaro.org>
In-Reply-To: <d82ab1f8-e677-485f-9a6b-4115acfd7239@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 14 Mar 2024 15:02:31 +0530
Message-ID: <CAFA6WYNSumyScax=GkN42GJOG56T3odF5Ed9A2i1nk_exCyGtA@mail.gmail.com>
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

On Thu, 14 Mar 2024 at 14:48, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 3/14/24 10:04, Sumit Garg wrote:
> > Hi Konrad,
> >
> > On Wed, 13 Mar 2024 at 18:34, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>
> >>
> >>
> >> On 3/13/24 13:30, Sumit Garg wrote:
> >>> Add Schneider Electric HMIBSC board DTS. The HMIBSC board is an IIoT Edge
> >>> Box Core board based on the Qualcomm APQ8016E SoC.
> >>>
> >>> Support for Schneider Electric HMIBSC. Features:
> >>> - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> >>> - 1GiB RAM
> >>> - 8GiB eMMC, SD slot
> >>> - WiFi and Bluetooth
> >>> - 2x Host, 1x Device USB port
> >>> - HDMI
> >>> - Discrete TPM2 chip over SPI
> >>> - USB ethernet adaptors (soldered)
> >>>
> >>> Co-developed-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> >>> Signed-off-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> >>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >>> ---
> >>
> >> [...]
> >>
> >>> +     memory@80000000 {
> >>> +             reg = <0 0x80000000 0 0x40000000>;
> >>> +     };
> >>
> >> I'm not sure the entirety of DRAM is accessible..
> >>
> >> This override should be unnecessary, as bootloaders generally update
> >> the size field anyway.
> >
> > On this board, U-Boot is used as the first stage bootloader (replacing
> > Little Kernel (LK), thanks to Stephan's work). And U-Boot consumes
> > memory range from DT as Linux does but doesn't require any memory to
> > be reserved for U-Boot itself. So apart from reserved memory nodes
> > explicitly described in DT all the other DRAM regions are accessible.
>
> Still, u-boot has code to fetch the size dynamically, no?
>

No U-Boot being the first stage bootloader fetches size from DT which
is bundled into U-Boot binary.

> [...]
>
> >>
> >>> +
> >>> +             compatible = "adi,adv7533";
> >>> +             reg = <0x39>;
> >>> +
> >>> +             interrupt-parent = <&tlmm>;
> >>> +             interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
> >>
> >> interrupts-extended
> >>
> >
> > Please see Documentation/devicetree/bindings/display/bridge/adi,adv7533.yaml.
>
> Okay, and what am I supposed to see there?

I meant you to refer to an example there but looks like
interrupts-extended is a valid replacement too. I will use that
instead.

-Sumit

>
> Konrad

