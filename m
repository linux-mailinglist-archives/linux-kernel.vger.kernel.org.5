Return-Path: <linux-kernel+bounces-105796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC1587E49E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C2F282346
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CEF2421D;
	Mon, 18 Mar 2024 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rIp2Zj/c"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E3A24205
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710748940; cv=none; b=syPUtxNUbthMr1P9F+QtdengVzoZEymmIZ3chq1napgoWPmmqWbhMwSXG202QaDU3iB3dhkkjyvNApoG3TjEdQ5kJgStoUeI7sxUrEPu054xwpl2Byy5zkbK3hAP2u8+OjXcAwdf1a0VF1n1zZuBpf/lhKPEPfdyKMV0EoE5698=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710748940; c=relaxed/simple;
	bh=y/vyQhNzMuAdGVX1iCrP4UVgZ81kdl+o6hBaLjBNBQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAKxlD529Ke3g1PeAyIznt4Sxo3NTjtLEkEqbqMR2z60fc80NfO2sz3Nf2sUK0Qdv9WBFJQ9lASW36XO2TVZFUTdYMXjHlka0dKbbptG/Y5J0pNy9F4RJS4oRCeGPHrViQyKuSlL0e1MBKqh3dR/Erf5duL0mw3R8aUGY4kYqBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rIp2Zj/c; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-47695273c19so20575137.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 01:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710748937; x=1711353737; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UL5ks0Y+z1y/j7c53NIu7JJr/PCUnbpkYzwsdj3yW5s=;
        b=rIp2Zj/c9Z5Kok9685UL/+uH1IuVx3K2RTukOkZ3z2Q4WkmUTtuUm5Rwwyp5kLgpcE
         28bn721VfwT56XHxkWC0BQcvTWEpblET1rpT52txyxPWrK0ulZa48R2sfCZON6dCj7iv
         EOCFC2ed5VPVMijOzqa6ue0ZCeWZFM2MJacqm/YXK9f9RDfJrwpp5BobwiIFktmkNHQs
         weg/BY8cGnyppVAkI9aWzvRCvFLaj7iCAUrSaU6jWX00SCUrX1Y1Z2rX8fSQ0lbolQ6m
         GJR2SXCxQB6BkV+J6EUko0q0kb+G+kPitbF9wvxHG/R7r2tpZSRHZcRUS3sPkgr8gxgh
         ABAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710748937; x=1711353737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UL5ks0Y+z1y/j7c53NIu7JJr/PCUnbpkYzwsdj3yW5s=;
        b=WThRcA0ciF5o+TPZdvCOSBPHoXXFGf/bHjIsNBOwN4G5D18ZNT/DCNBz9CgjTxOlKQ
         7j+JrE6muYEtcniH2ffBE6VGbL4+0OaQFAKZ9o9gP8LBUpOxNRMyuLtNjHZHLFqLvv2z
         Znj4tyl23KwFSNGZNDjzjmSR1WLv4S5PWsl3n4tEbfw8jNXHhr2FeiDaXfmg4d0QH5IH
         qobvFf+7Vf4GSN4RrJSqFHkqbZB6XHmXoEPmlC0rPI0BgGYmaYKBzAF57IKR0+FrYqq4
         PrCHRY85lbOqCQBXGv0UH7dcjaWapl3jxOagKH8XiAvPMN6rwg8o/WQIinhxlDzkwYiI
         DnOg==
X-Forwarded-Encrypted: i=1; AJvYcCW1euWJZpx+tim0PySFDsCdQob/p4bRHHriTGQUczon/RVRrBkln14IoL3jn9G9vHQ5NEhhp8y0wZ4XG976p1HtJC+Cqiqk+7foU7kg
X-Gm-Message-State: AOJu0YyJ07jOxth5pioHI1SsxGLjvRrQv+HZzhgdy5GcMmBbxDwTKc1U
	OlygMSvAoJ9u0z+aeKMoSrfmZPOkSPOHShXkLcasVmedJ6QYR3uSSu/qo2GcT0/V4TWEx7nfkBp
	1iGXcwpwdQFFKv/MTi0bs8+vinUYaS6rzlQEqEw==
X-Google-Smtp-Source: AGHT+IFDk73HzChnZbOIf0ZI9lAlhlJRKYSCYs4E4haQhP1SZe+fHGrKp2PhUmF507ktjbmxZd5XkNfKFQXUj3HTedM=
X-Received: by 2002:a67:e20c:0:b0:474:c5cb:e4c9 with SMTP id
 g12-20020a67e20c000000b00474c5cbe4c9mr6894200vsa.30.1710748937355; Mon, 18
 Mar 2024 01:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFA6WYNMjCaa0FKjNv6a8VFkco3=GBfgWNDuckGZdiZ9dGmHgg@mail.gmail.com>
 <d82ab1f8-e677-485f-9a6b-4115acfd7239@linaro.org> <CAFA6WYNSumyScax=GkN42GJOG56T3odF5Ed9A2i1nk_exCyGtA@mail.gmail.com>
 <ZfLUu6_Vq7MvG2G3@gerhold.net> <CAFA6WYPN2Bt7zvDyd+02jrsZJz0sFhkD_o4W+PvU=-VC4W5k=A@mail.gmail.com>
 <ZfL6hi0kfp9MXQ0H@gerhold.net> <CAFA6WYMa_0OMkjUdvhYtWZ9SvQx5bB8+YrBZN08BaDXXOtPPNQ@mail.gmail.com>
 <fb20d921-dabd-41dc-9f91-bde90e3b87be@linaro.org> <9b614c61-276d-45bf-8320-44b7358a3e19@linaro.org>
 <CAFA6WYMHA2M1LLjaog17f83Cu_wH4MAvxhuwAQH0c7j4XTM3XA@mail.gmail.com> <ZfRbp8o-4pFBAjc-@gerhold.net>
In-Reply-To: <ZfRbp8o-4pFBAjc-@gerhold.net>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 18 Mar 2024 13:32:06 +0530
Message-ID: <CAFA6WYMOwTXRhq1+fmifmV1M17HX9CzndUGEG=MoA5heVauqxg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	andersson@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, neil.armstrong@linaro.org, laetitia.mariottini@se.com, 
	pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com, 
	benjamin.missey@non.se.com, daniel.thompson@linaro.org, 
	linux-kernel@vger.kernel.org, Jagdish Gediya <jagdish.gediya@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Mar 2024 at 20:01, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Fri, Mar 15, 2024 at 03:01:27PM +0530, Sumit Garg wrote:
> > On Thu, 14 Mar 2024 at 21:07, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> > > On 14/03/2024 15:20, Konrad Dybcio wrote:
> > > > On 3/14/24 14:50, Sumit Garg wrote:
> > > >> On Thu, 14 Mar 2024 at 18:54, Stephan Gerhold <stephan@gerhold.net>
> > > >> wrote:
> > > >>>
> > > >>> On Thu, Mar 14, 2024 at 05:26:27PM +0530, Sumit Garg wrote:
> > > >>>> On Thu, 14 Mar 2024 at 16:13, Stephan Gerhold <stephan@gerhold.net>
> > > >>>> wrote:
> > > >>>>> On Thu, Mar 14, 2024 at 03:02:31PM +0530, Sumit Garg wrote:
> > > >>>>>> On Thu, 14 Mar 2024 at 14:48, Konrad Dybcio
> > > >>>>>> <konrad.dybcio@linaro.org> wrote:
> > > >>>>>>> On 3/14/24 10:04, Sumit Garg wrote:
> > > >>>>>>>> On Wed, 13 Mar 2024 at 18:34, Konrad Dybcio
> > > >>>>>>>> <konrad.dybcio@linaro.org> wrote:
> > > >>>>>>>>> On 3/13/24 13:30, Sumit Garg wrote:
> > > >>>>>>>>>> Add Schneider Electric HMIBSC board DTS. The HMIBSC board is
> > > >>>>>>>>>> an IIoT Edge
> > > >>>>>>>>>> Box Core board based on the Qualcomm APQ8016E SoC.
> > > >>>>>>>>>>
> > > >>>>>>>>>> Support for Schneider Electric HMIBSC. Features:
> > > >>>>>>>>>> - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno
> > > >>>>>>>>>> 306)
> > > >>>>>>>>>> - 1GiB RAM
> > > >>>>>>>>>> - 8GiB eMMC, SD slot
> > > >>>>>>>>>> - WiFi and Bluetooth
> > > >>>>>>>>>> - 2x Host, 1x Device USB port
> > > >>>>>>>>>> - HDMI
> > > >>>>>>>>>> - Discrete TPM2 chip over SPI
> > > >>>>>>>>>> - USB ethernet adaptors (soldered)
> > > >>>>>>>>>>
> > > >>>>>>>>>> Co-developed-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> > > >>>>>>>>>> Signed-off-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> > > >>>>>>>>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > >>>>>>>>>> ---
> > > >>>>>>>>>
> > > >>>>>>>>> [...]
> > > >>>>>>>>>
> > > >>>>>>>>>> +     memory@80000000 {
> > > >>>>>>>>>> +             reg = <0 0x80000000 0 0x40000000>;
> > > >>>>>>>>>> +     };
> > > >>>>>>>>>
> > > >>>>>>>>> I'm not sure the entirety of DRAM is accessible..
> > > >>>>>>>>>
> > > >>>>>>>>> This override should be unnecessary, as bootloaders generally
> > > >>>>>>>>> update
> > > >>>>>>>>> the size field anyway.
> > > >>>>>>>>
> > > >>>>>>>> On this board, U-Boot is used as the first stage bootloader
> > > >>>>>>>> (replacing
> > > >>>>>>>> Little Kernel (LK), thanks to Stephan's work). And U-Boot consumes
> > > >>>>>>>> memory range from DT as Linux does but doesn't require any
> > > >>>>>>>> memory to
> > > >>>>>>>> be reserved for U-Boot itself. So apart from reserved memory nodes
> > > >>>>>>>> explicitly described in DT all the other DRAM regions are
> > > >>>>>>>> accessible.
> > > >>>>>>>
> > > >>>>>>> Still, u-boot has code to fetch the size dynamically, no?
> > > >>>>>>>
> > > >>>>>>
> > > >>>>>> No U-Boot being the first stage bootloader fetches size from DT which
> > > >>>>>> is bundled into U-Boot binary.
> > > >>>>>>
> > > >>>>>
> > > >>>>> Back when I added support for using U-Boot as first stage
> > > >>>>> bootloader on
> > > >>>>> DB410c the way it worked is that U-Boot used a fixed amount of DRAM
> > > >>>>> (originally 968 MiB, later 1 GiB since I fixed this in commit
> > > >>>>> 1d667227ea51 ("board: dragonboard410c: Fix PHYS_SDRAM_1_SIZE") [1]).
> > > >>>>> When booting Linux, the Linux DT was dynamically patched with the
> > > >>>>> right
> > > >>>>> amount of DRAM (obtained from SMEM). So if you had e.g. a Geniatech
> > > >>>>> DB4
> > > >>>>> board with 2 GiB DRAM, U-Boot was only using 1 GiB of DRAM, but Linux
> > > >>>>> later got the full 2 GiB patched into its DTB.
> > > >>>>>
> > > >>>>> I didn't have much time for testing U-Boot myself lately but a quick
> > > >>>>> look at the recent changes suggest that Caleb accidentally removed
> > > >>>>> that
> > > >>>>> functionality in the recent cleanup. Specifically, the SMEM-based DRAM
> > > >>>>> size detection was removed in commit 14868845db54 ("board:
> > > >>>>> dragonboard410c: import board code from mach-snapdragon" [2]), the
> > > >>>>> msm_fixup_memory() function does not seem to exist anymore now. :')
> > > >>>>
> > > >>>> Ah now I see the reasoning for that particular piece of code. Is SMEM
> > > >>>> based approach the standardized way used by early stage boot-loaders
> > > >>>> on other Qcom SoCs too?
> > > >>>>
> > > >>>
> > > >>> It is definitely used on all the SoCs that were deployed with LK. I am
> > > >>> not entirely sure about the newer ABL/UEFI-based ones. A quick look at
> > > >>> the ABL source code suggests it is abstracted through an EFI protocol
> > > >>> there (so we cannot see where the information comes from with just the
> > > >>> open-source code). However, in my experience SMEM data structures are
> > > >>> usually kept quite stable (or properly versioned), so it is quite likely
> > > >>> that we could use this approach for all Qualcomm SoCs.
> > > >>>
> > > >>
> > > >> If the SoCs which support this standardized way to dynamic discover
> > > >> DRAM size via SMEM then why do we need to rely on DT at all for those
> > > >> SoCs? Can't U-Boot and Linux have the same driver to fetch DRAM size
> > > >> via SMEM? I am not sure if it's an appropriate way for U-Boot to fixup
> > > >> DT when that information can be discovered dynamically.
> > >
> > > [...]
> > >
> > > The reason I decided to hardcode this in DT for U-Boot is because SMEM
> > > currently relies on the driver model and isn't available early enough.
> > >
> > > Also admittedly I just wasn't that familiar with the U-Boot codebase. I
> > > just wanted to avoid hardcoding this in C code, and given that this was
> > > already supported for the "chainloading from ABL" usecase, just
> > > hardcoding the values was the obvious solution.
> > >
> > > I would definitely be open to revisiting this in U-Boot, having an SMEM
> > > framework that we could use without the driver model which would just
> > > take a base address and then let us interact with SMEM and populate the
> > > dram bank data would be a good improvement, and would let us avoid
> > > hardcoding the memory layout in DT. We'd just need to manually find the
> > > SMEM base address in the FDT as part of "dram_init_banksize()" and
> > > retrieve the data there.
> >
> > These are the similar problems Linux has to deal with too but on Qcom
> > platforms it is rather offloaded to bootloaders to rather implement
> > this. It leads to custom DT modification or board code in U-Boot which
> > is hard to maintain. If we want to implement it properly then
> > corresponding bindings should be upstreamed too regarding how DRAM
> > range is to be discovered via SMEM.
> >
> > >
> > > That all being said, I don't see any reason not to define the memory
> > > layout in DT, it's a hardware feature, DT describes the hardware. The
> > > whole "bootloader will fill this in" implies that the bootloader isn't
> > > also using DT as the source of truth, but now with U-Boot it actually
> > > is, so it's all the more important that DT be accurate ;P
> >
> > I agree DT should be accurate and not a fan of DT fixups. However,
> > when it comes to some hardware configuration being discoverable then
> > IMHO DT isn't the appropriate place for that. For the time being I am
> > fine with the DRAM range to be specified in DT.
> >
> > > >
> > > > You're mixing two things. Linux expects a devicetree where
> > > > /memory/reg[size]
> > > > is valid. Such driver should indeed be (re)implemented in u-boot to provide
> > > > this information.
> >
> > No, I don't think so. We should rather start thinking about the
> > overall stack rather than just being Linux kernel centric. Do you have
> > a generic solution for U-Boot regarding how this should be
> > implemented?
> >
>
> Detecting available memory via /memory in the DT

I would rather call that as "Hardcoding available memory via ...". The
basic DT description [1] says:

"A DTSpec-compliant devicetree describes device information in a
system that cannot necessarily be dynamically detected by a client
program."

[1] https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#overview

> or other firmware
> services (such as UEFI GetMemoryMap()) is *the* generic solution used
> everywhere, independent of the hardware (e.g. Qualcomm) and the
> operating system (e.g. Linux or Xen).

That's an appropriate alternate example of how available memory
information can be passed to the operating system. But on non-UEFI
systems, bootloaders are just stuck with DT fixups as the operating
system doesn't support an alternate method to retrieve memory
information.

IMHO, whether it's a UEFI system or a non-UEFI system the DT should be
identical without the need for fixups.

>
> It allows us to implement the board/Qualcomm-specific memory detection
> in a single project,

I suppose in your view U-Boot is the only bootloader project out there
but you should at least check out [2].

[2] https://en.wikipedia.org/wiki/Bootloader

> rather than having extra porting overhead for each
> operating system for something as essential as available memory.
>
> If we implement the SMEM-based memory detection in U-Boot (probably in
> dram_init_banksize() as Caleb suggested) everything else will just work
> without any Qualcomm-specific DT patching in U-Boot, and without any
> special code in the operating system:
>
>  - U-Boot automatically updates the /memory node in generic code (see
>    fdt_fixup_memory_banks() call in arch/arm/lib/bootm-fdt.c). If you
>    are using UEFI for booting, U-Boot will provide the same information
>    via GetMemoryMap(). (The DT spec says /memory should be ignored on
>    UEFI systems.)
>
>  - Linux, Xen, and any other operating system can obtain the memory size
>    via the standard method, and do not need any Qualcomm-specific at all
>    (at least for memory detection).
>
> I don't think there is anything Linux kernel centric for the memory
> detection here. Quite the opposite really. :)

The question here is really about the thinking that people still
consider DT as a way to describe information which should rather be
detected dynamically. The DT fixups seems to be an outcome of this
thinking.

On a non-UEFI system, if people are instead looking for a generic way
to pass information then we should be able to consider firmware
handoff data structures [3] too. However, if we can just have a
reference in DT /memory node to a particular data structure then we
should just be fine with the corresponding driver extracting the
memory information.

[3] https://github.com/FirmwareHandoff/firmware_handoff

-Sumit

>
> Thanks,
> Stephan

