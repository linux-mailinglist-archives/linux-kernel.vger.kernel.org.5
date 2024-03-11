Return-Path: <linux-kernel+bounces-98714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D04877E57
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EB1FB2170A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905C938DC0;
	Mon, 11 Mar 2024 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MiwezWWn"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8BB2C861
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154041; cv=none; b=aL8UZI1Mf449WUZl5igXCGS3lLZcXVYKC6t8RUoSXjvYTEzqrydYTCpmcDDCNMtMrLTpySDl1zexP4h03GtfEjnPMziz4Te+AxGN/mj3s5+FIW+zXgvdp+izHgKLMgWKiCFvc2sQI5KkPIiE3jsHLH5YuLhWfPwIuc+nkC7zsyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154041; c=relaxed/simple;
	bh=FCFtKM5ZoK2XTLYGhcLAlAmDD4xwFFMWyjuRlDleGTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lF/Nhk2MPkv+GjUCuX41VbhXZtuxk5tjThXEGPA4CPX9RbaeP+ZAKEsRWCdZJYBhAAzxa5WuCgN/mSXTeOA0QmmzmZHNirsl5r0KPUJbtDpianFFuMmAlyYx11QXfuRnfiVHAMVnxIzBx8Mw3HPT6PgjowYKntet3Ig5xzNfkdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MiwezWWn; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6900f479e3cso45147416d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 03:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710154038; x=1710758838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cRIjS+xX+GPm53OcBVvySCiWaptis6C/taxIOwdOm1E=;
        b=MiwezWWnFKe8CFyXo7GC85OnrSCA/SH8NmsvfAL1uZq01ddhSiHJJLCsi+lVFqQKaC
         ckozFsZNvPwxFIPsYv5lCgwEmV+ujazm6dJgD7+fBJDC2Z1+SUJfy6cqWu0r3LHmn/Um
         GtHA/TInxGgHM4+8/gX4csPjGCcv+C5Gx0mgiB8bNl/XQUnUC5MqHeSNRVfzMlaie+1a
         4TX+DujKjdbLLkHpae2bg43w90OHHiuj1lFdyzPwl6R1oZRhiIeMJjXVi/W+Y89hXIfM
         wDFsLNeV1099OKwqm28uikkToGNWA55GUGR8/iuY4y4Z21USjcaMJY9Oo9wJtB5gYaz1
         hUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710154038; x=1710758838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRIjS+xX+GPm53OcBVvySCiWaptis6C/taxIOwdOm1E=;
        b=M8taTHHi+bjDUAOM0z6gQZuAgZ/dN7ZOClqJWyEYziGBAfGRqsGUoJ/bAfEnmxyezO
         sHNDIt3GFdYs0Co6g/0WFoxQ0+uxUfwxwemgzHa1LPNx1DymYLhFu0zlI7EbkkPft3qF
         KMOWFhAbEMqxdaGmhL7s+Pi+e3LZt4wFFuZ0VLH69EhTbfpQeVpODixChLNNRdlN86Jv
         GC9B+Kot+PlSvygBzzI37/O2wD1ICXQHPYPe3FfNihWaLS6islssoBDHtDZS463TBE0k
         Ci5V7TnzD+/I+0JpA1wYxXJZJNJY9f5IT8BQHBy5VhWQ8/cWBxc4/tilILUz7FjNlUqJ
         /1Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXhAeq1LKrzGtw0u4A+4rrpDLUY1jFAJYEoHxcrj+ufandNFqow8rzrqRZkLtwLF7vV61Q8zbLtaPkMoABk3+FtgtJdGv0PMtYO3k5F
X-Gm-Message-State: AOJu0YyHFZJqnkNCM8ted5q1FzFmwoLo5m3j6EpTmkH1/jru71LFg3/9
	eQAcYWp5J95ZAZP8wDesyxFucVkOwBSX9pMeCNrv4An/Gr4k93qpPG2QbfY+Z9fP4C5BQv6rmg2
	IeVjnWFsm44hqFInu7lzGscqTO5P0JMqbvecRJg==
X-Google-Smtp-Source: AGHT+IGyrPx1d8EcSWfPY0WZ1CYoYrM93ITiWLlRr/ltcc0nW0tGxeB9PQdlmfL0rMLOYoJeiLKm/R9q7ev0Ge3Vbpc=
X-Received: by 2002:ad4:58c5:0:b0:690:46a8:93f with SMTP id
 dh5-20020ad458c5000000b0069046a8093fmr5235070qvb.44.1710154038009; Mon, 11
 Mar 2024 03:47:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307135912.163996-1-tudor.ambarus@linaro.org> <073e5ef5-2a2e-4300-93d6-e25552276e13@linaro.org>
In-Reply-To: <073e5ef5-2a2e-4300-93d6-e25552276e13@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 11 Mar 2024 10:47:06 +0000
Message-ID: <CADrjBPojf92=Vvq9rVt9frC-61BQbKeX+5fRa-q8fqr9iGMryA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: exynos: gs101: define all PERIC USI nodes
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
	willmcvicker@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof & Tudor,

On Fri, 8 Mar 2024 at 16:45, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 07/03/2024 14:59, Tudor Ambarus wrote:
> > Universal Serial Interface (USI) supports three types of serial
> > interface such as UART, SPI and I2C. Each protocol works independently.
> > USI can be configured to work as one of these protocols. Define all the
> > USI nodes from the PERIC blocks (USI0-14), in all their possible
> > configurations. These blocks have the TX/RX FIFO depth of 64 bytes.
> >
> > Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

With Krzystof's comments addressed:

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

> > ---
> > Please note that:
> > - google,gs101-spi compatible was queued through the SPI tree:
> >   https://lore.kernel.org/linux-arm-kernel/170742731537.2266792.3851016361229293846.b4-ty@kernel.org/
> > - SPI dma properties were marked as not requiered. Queued through the
> >   SPI tree:
> >   https://lore.kernel.org/linux-spi/170967132774.228925.1759895846287455970.b4-ty@kernel.org/
> >
> >  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 782 +++++++++++++++++++
> >  1 file changed, 782 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> > index ee65ed9d2cfc..d7ecfbc7e440 100644
> > --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> > +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> > @@ -373,6 +373,398 @@ pinctrl_peric0: pinctrl@10840000 {
> >                       interrupts = <GIC_SPI 625 IRQ_TYPE_LEVEL_HIGH 0>;
> >               };
> >
> > +             usi1: usi@109000c0 {
> > +                     compatible = "google,gs101-usi",
> > +                                  "samsung,exynos850-usi";
>
> This should fit within 81 characters, which is pretty close to 80, so if
> there is going to be any resend/new version, please join the lines.
>
> > +                     reg = <0x109000c0 0x20>;
> > +                     ranges;
> > +                     #address-cells = <1>;
> > +                     #size-cells = <1>;
> > +                     clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_0>,
> > +                              <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_0>;
> > +                     clock-names = "pclk", "ipclk";
> > +                     samsung,sysreg = <&sysreg_peric0 0x1000>;
> > +                     status = "disabled";
> > +
> > +                     hsi2c_1: i2c@10900000 {
> > +                             compatible = "google,gs101-hsi2c",
> > +                                          "samsung,exynosautov9-hsi2c";
> > +                             reg = <0x10900000 0xc0>;
> > +                             interrupts = <GIC_SPI 635 IRQ_TYPE_LEVEL_HIGH 0>;
>
> I wonder why we use four cells in GIC...

Due to the ppi-partitions defined in the gic for the pmu-(0-2) devices.

regards,

Peter.



>
> > +                             #address-cells = <1>;
> > +                             #size-cells = <0>;
> > +                             pinctrl-names = "default";
> > +                             pinctrl-0 = <&hsi2c1_bus>;
>
> Please reverse two lines, first pinctrl-0 then pinctrl-names. I know we
> did not follow this convention till now, but at least new code can be
> correct. Also clocks should be before pinctrl, so we keep some sort of
> alphabetical order.
>
> It is anyway too late in the cycle for me to pick it up, so no need to
> hurry with resend.
>
> Best regards,
> Krzysztof
>

