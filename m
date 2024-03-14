Return-Path: <linux-kernel+bounces-103320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7BC87BE02
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875AA1F21D59
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32CE6EB74;
	Thu, 14 Mar 2024 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oJaWwPTg"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488AB5D8F8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710424220; cv=none; b=Rbo1pMcNZbjnmLcPWaED9TkJVQj9usPzySyfmkEGZCv8CoEYEHlbpmS3BzAEfC1pGeYLhsak0VSA5sLTKnUpT/PZg2SQItahHsBrAD7QWRSI3DVBTc5AM58Bh+5PKbGT/NY2EerDUUQzoozhN0nQwKSXWfEPhBad+FpCMTcy4tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710424220; c=relaxed/simple;
	bh=07AREVov5k9B5BhuEsQjAUzwZfLB1YvPRwfffwxJb+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SfbohOfdg9dH7BZ0OcQgjvPCF90AYqSz9CtqhacOeD7UoCMoVSqxz/SeOql+ub0bzRclIYf6FryhGn2ZTtySuFvhW1LElPLvD5L0QXDonGQaq/BAvzWhek6CSAHFknIqqgbgS/al6tyzHdBywZXyJxwkhMonfoGoasIH2UwDjJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oJaWwPTg; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7db797c5c93so442641241.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710424217; x=1711029017; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qDc/q77cxlaDVO4g1UV+WiSR8cl+9pdOHVzgL1OoM3o=;
        b=oJaWwPTglajyD3cm2oUPjVTWEnbairmxS/lDDoEAgDpe1fEIy0XVAaBxNwBxYFH9yP
         /U7sa33bHzR194/Og/moBIg1bLDmL/JBts+e5RHFllTlMcS2So2iDdDitEEHYF64fUDq
         H/C895GehVPQvimny6XmoAIAsoazF7ja007+uc8yInmv09c8N4rlXq17jS7q1Axhn9WC
         qyIE8jDeaZH1HfGt+wFcx9S2kTyblQGHRTdscG9kgZntgy02216SspWXYJ61uqLzMtVC
         5M5xYbLopyADBKQTw94Mz0ko9O39lC9xjhrT1uV8SJiikueb1BqnkUQIpTxzUgXMUEsQ
         eVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710424217; x=1711029017;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qDc/q77cxlaDVO4g1UV+WiSR8cl+9pdOHVzgL1OoM3o=;
        b=Z1nxZ3Qe05Gr1SIxBq+RJVj2Mbss4a8kWdFIjfYkIp3zGEnhQ6UT6ouzco1Txujx7s
         EBFxjetlkZe1owvGbfGdHrz5CPv/6bpYqhdlGpCuF4bzk8uKeIHf40BjRQgqsS8tQjAZ
         dipucG3fl3g4IAQA4wqKAtaDSE60qZcOhU9DvxJ2bVqufoBtA2hdNIlehrIPpMSLktvI
         S8wex+1wzEqux0ySCtN8yHR8YEo93K1CCMEF7C1kRsoMWPOVYuWUZMsUzbEsSRSym/Q5
         jXk7MkHM4itR6oVkwBii+r2lBF7vOUGgI/kXYJkM7VdyIvDtABIlMXg66PF6yTwUDZQC
         znug==
X-Forwarded-Encrypted: i=1; AJvYcCXQohMqJsJISq157zx/WH0Gu93yh6D6+7DmiNv0TRHG7Dh36XOXP8uU9Z/1lEztQNxmxahW/PcDU81JpXtnzE1NoW7zmdcKIpgiXVdq
X-Gm-Message-State: AOJu0YyXGwPvfGHXOjOFjBPdu9FKTkR91aQmoWmJuL90ax8QNYSGJZG4
	8IDeBxVNo5B+vppdwYlx2EPq1lljEEmTCaKNEp5pN0RMxohV14xTdq+gVxR9HMY9MbmQbAHYETR
	/jhpmnIwinYpxkErGJrO053eJnwiIyAE1E/8nDg==
X-Google-Smtp-Source: AGHT+IG4auUNtTS4kpwHbhlfVMUzXdoEI+o1aNTqaGOFOx94ao8Owny9p2K6h1BoaOYCTyogrpxQUOw+WWFX2KZ32Is=
X-Received: by 2002:a67:fc1a:0:b0:471:e46a:2a9f with SMTP id
 o26-20020a67fc1a000000b00471e46a2a9fmr201523vsq.33.1710424217119; Thu, 14 Mar
 2024 06:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313123017.362570-1-sumit.garg@linaro.org>
 <20240313123017.362570-4-sumit.garg@linaro.org> <c0e10cbf-c6f3-4b0c-8616-983da2a40236@linaro.org>
 <CAFA6WYNMjCaa0FKjNv6a8VFkco3=GBfgWNDuckGZdiZ9dGmHgg@mail.gmail.com>
 <d82ab1f8-e677-485f-9a6b-4115acfd7239@linaro.org> <CAFA6WYNSumyScax=GkN42GJOG56T3odF5Ed9A2i1nk_exCyGtA@mail.gmail.com>
 <ZfLUu6_Vq7MvG2G3@gerhold.net> <CAFA6WYPN2Bt7zvDyd+02jrsZJz0sFhkD_o4W+PvU=-VC4W5k=A@mail.gmail.com>
 <ZfL6hi0kfp9MXQ0H@gerhold.net>
In-Reply-To: <ZfL6hi0kfp9MXQ0H@gerhold.net>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 14 Mar 2024 19:20:05 +0530
Message-ID: <CAFA6WYMa_0OMkjUdvhYtWZ9SvQx5bB8+YrBZN08BaDXXOtPPNQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, andersson@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	caleb.connolly@linaro.org, neil.armstrong@linaro.org, 
	laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com, 
	jimmy.lalande@se.com, benjamin.missey@non.se.com, daniel.thompson@linaro.org, 
	linux-kernel@vger.kernel.org, Jagdish Gediya <jagdish.gediya@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 18:54, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Thu, Mar 14, 2024 at 05:26:27PM +0530, Sumit Garg wrote:
> > On Thu, 14 Mar 2024 at 16:13, Stephan Gerhold <stephan@gerhold.net> wrote:
> > > On Thu, Mar 14, 2024 at 03:02:31PM +0530, Sumit Garg wrote:
> > > > On Thu, 14 Mar 2024 at 14:48, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> > > > > On 3/14/24 10:04, Sumit Garg wrote:
> > > > > > On Wed, 13 Mar 2024 at 18:34, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> > > > > >> On 3/13/24 13:30, Sumit Garg wrote:
> > > > > >>> Add Schneider Electric HMIBSC board DTS. The HMIBSC board is an IIoT Edge
> > > > > >>> Box Core board based on the Qualcomm APQ8016E SoC.
> > > > > >>>
> > > > > >>> Support for Schneider Electric HMIBSC. Features:
> > > > > >>> - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> > > > > >>> - 1GiB RAM
> > > > > >>> - 8GiB eMMC, SD slot
> > > > > >>> - WiFi and Bluetooth
> > > > > >>> - 2x Host, 1x Device USB port
> > > > > >>> - HDMI
> > > > > >>> - Discrete TPM2 chip over SPI
> > > > > >>> - USB ethernet adaptors (soldered)
> > > > > >>>
> > > > > >>> Co-developed-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> > > > > >>> Signed-off-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> > > > > >>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > >>> ---
> > > > > >>
> > > > > >> [...]
> > > > > >>
> > > > > >>> +     memory@80000000 {
> > > > > >>> +             reg = <0 0x80000000 0 0x40000000>;
> > > > > >>> +     };
> > > > > >>
> > > > > >> I'm not sure the entirety of DRAM is accessible..
> > > > > >>
> > > > > >> This override should be unnecessary, as bootloaders generally update
> > > > > >> the size field anyway.
> > > > > >
> > > > > > On this board, U-Boot is used as the first stage bootloader (replacing
> > > > > > Little Kernel (LK), thanks to Stephan's work). And U-Boot consumes
> > > > > > memory range from DT as Linux does but doesn't require any memory to
> > > > > > be reserved for U-Boot itself. So apart from reserved memory nodes
> > > > > > explicitly described in DT all the other DRAM regions are accessible.
> > > > >
> > > > > Still, u-boot has code to fetch the size dynamically, no?
> > > > >
> > > >
> > > > No U-Boot being the first stage bootloader fetches size from DT which
> > > > is bundled into U-Boot binary.
> > > >
> > >
> > > Back when I added support for using U-Boot as first stage bootloader on
> > > DB410c the way it worked is that U-Boot used a fixed amount of DRAM
> > > (originally 968 MiB, later 1 GiB since I fixed this in commit
> > > 1d667227ea51 ("board: dragonboard410c: Fix PHYS_SDRAM_1_SIZE") [1]).
> > > When booting Linux, the Linux DT was dynamically patched with the right
> > > amount of DRAM (obtained from SMEM). So if you had e.g. a Geniatech DB4
> > > board with 2 GiB DRAM, U-Boot was only using 1 GiB of DRAM, but Linux
> > > later got the full 2 GiB patched into its DTB.
> > >
> > > I didn't have much time for testing U-Boot myself lately but a quick
> > > look at the recent changes suggest that Caleb accidentally removed that
> > > functionality in the recent cleanup. Specifically, the SMEM-based DRAM
> > > size detection was removed in commit 14868845db54 ("board:
> > > dragonboard410c: import board code from mach-snapdragon" [2]), the
> > > msm_fixup_memory() function does not seem to exist anymore now. :')
> >
> > Ah now I see the reasoning for that particular piece of code. Is SMEM
> > based approach the standardized way used by early stage boot-loaders
> > on other Qcom SoCs too?
> >
>
> It is definitely used on all the SoCs that were deployed with LK. I am
> not entirely sure about the newer ABL/UEFI-based ones. A quick look at
> the ABL source code suggests it is abstracted through an EFI protocol
> there (so we cannot see where the information comes from with just the
> open-source code). However, in my experience SMEM data structures are
> usually kept quite stable (or properly versioned), so it is quite likely
> that we could use this approach for all Qualcomm SoCs.
>

If the SoCs which support this standardized way to dynamic discover
DRAM size via SMEM then why do we need to rely on DT at all for those
SoCs? Can't U-Boot and Linux have the same driver to fetch DRAM size
via SMEM? I am not sure if it's an appropriate way for U-Boot to fixup
DT when that information can be discovered dynamically.

> > >
> > > Also, the DRAM size is now always taken from the DT (which is probably
> > > better than the previous hardcoded size in the U-Boot board code).
> > >
> > > I think we should bring the dynamic DRAM size detection back, because
> > > there are quite some boards available with varying DRAM size. Restoring
> > > msm_fixup_memory() would likely be easiest, I guess the ideal solution
> > > would be to parse SMEM in U-Boot's dram_init() function so even U-Boot
> > > has the correct amount of DRAM to work with.
> >
> > In the context of the HMIBSC board, it has 1 GB RAM LPDDR3 internal
> > not expandable. IMO, having it in DT as default should be fine.
> >
>
> Right. I was more talking in terms of DB410c here, where the lack of
> this feature is kind of a regression.
>
> Personally, I'm fine if you put the memory node here like this. If there
> are concerns from others you could also move it to the -u-boot.dtsi and
> omit it for Linux.

In U-Boot we encourage people to drop -u-boot.dtsi entirely rather
than the opposite such that we have a canonical devicetree usage
especially with OF_UPSTREAM enabled.

-Sumit

>
> Thanks,
> Stephan

