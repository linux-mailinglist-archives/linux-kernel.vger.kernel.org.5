Return-Path: <linux-kernel+bounces-104514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFB387CEF7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9375E1F22748
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BDA1B7F8;
	Fri, 15 Mar 2024 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="ejDDItDN";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="UClPvR0L"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DD626AE3;
	Fri, 15 Mar 2024 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513097; cv=pass; b=i8TPEwQV4GChKK4BNmrLr7ObgiuVV0sUNBQtJoJhIb+eBfBFuSUGFsKlET4pXVdEgXDO4jGJ2uq9T4Kzrp/awM5dR+DhsU41v2HVf0YzvftYRw/6ak0ewl//GJrk5P3dxwFytqbyNss9+3EzEXbQDwTw1IE/bl52Cc3GXAEuymY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513097; c=relaxed/simple;
	bh=ZvgNG/6Z+TZzmxQs+QM45IDmtBjoDzbTXRBfKInJ4Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMnZnUfJmgIKgA2n1uBgEH/onWHrKR6JRl/j0XfTESknGyLCIuQKt0WAhBSiUjW/KD3WN7XfwdhFD4OWR5190i3d3IFrmRr4SKtD+aNohVrlF2WHyqu7X1duvSrB0l4hsnmbw11XjNNXKgdNTDJMiDnrwu5WH4xfafxLpadI4Xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net; spf=none smtp.mailfrom=gerhold.net; dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=ejDDItDN; dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=UClPvR0L; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1710513069; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GDNuDhZuawtU6DtHyCWsknr3aY2cYOh8l1cU/RbdCh7yX8I/R8ddXBduUeBM53bjuh
    C6cW5TxCI7AOH7sIy11Tyift6liu+C60ckj6m0876g9NbTbnx7kXp/JtvyW8tmcq1ebt
    ok0E2CEVZverleiwaTl4/FOBws6kgtyJ4hnPkOeE6EFsZYepkd9VxfyMKF/UZ+nVQ0DV
    XlIQe9ptPrERewb3k0+ErVd6QKtYtkZHYr2HfdHsvRc2TMiIH8VlUHH+UPUe9rWPItmh
    idxDdfX4o0ff/nQkdf0LOd7tkbT74Ik9rCpBgNfXAwbWHgX3NeafORkbjrlPwV1HQ832
    0V2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1710513069;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3O4Z5Kgzu5Zkx8QMtOhc3RtLPiec48UGBDJQSIpu740=;
    b=GZPeogyc/mQL7b/BJO6X0ZdtE3xfnIE7qn5CyWkSrBEnQaUqvnyjCF/rSJLwOpPBur
    ZESZpyLkP9swnOu0GZ3dkeLjG6UclYy6kwHACJnS0EvxGW786okiR9v05ZXx/8m0UmRH
    iafPQnfY62GVBqPdrEuKglED+vD8UUqd3TIBADxgJ+mkj201kAIkGbJCu4DeYcCfWsXg
    Pvpo6xx10DUATQZJfHWiBrfTS4ZTMdVabRrTBkDOBJEwCQlAZfSfjm3sShWdZTAToaIT
    Z3Id1OfmBVukg/19KOM2mf63hldyzqOqAHXjchitCkp1k1NDGP3mdXH25zodLEatAmVD
    2aPA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1710513069;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3O4Z5Kgzu5Zkx8QMtOhc3RtLPiec48UGBDJQSIpu740=;
    b=ejDDItDNL2QLFybxujLzNs13W9O6lcYAkZOCq2TGPYf5UQOVRuSq6MBR35GHkuIhdL
    Z/7emwiFFomg06Ld6PsNnlP6gXKxO6mSXRJ1D79WwkbQFlW/ehgoJ2iWSwLtPJXzbOpw
    RslDNH1eOm+TqCjurEU8aiC285kNrO9vFotIFcSJ6S/f4IpDm96rzbA/VNEPgrrLG0Mn
    5Bd2cNy/FyvH8dUBmGuP8IUZgSC6OTC+eEV3TzVPP30xGBYLvADfVcqjQ//gabYhD6XT
    U14bWOsHlyPxO82sl2kLavpy2f+SQlfRhcoGUleNY80Wt3UPngPLhCq85ymBahq9hLxy
    65GQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1710513069;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3O4Z5Kgzu5Zkx8QMtOhc3RtLPiec48UGBDJQSIpu740=;
    b=UClPvR0LGGrvdCiO/gSVPvWLWKoJtPSTHZbzaA959ux8CUU46m/IAwLLeaGtjAH7wT
    TJGomYYbdVlXoGdtWdAw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA95vh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 50.2.2 SBL|AUTH)
    with ESMTPSA id Raa09e02FEV83CR
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 15 Mar 2024 15:31:08 +0100 (CET)
Date: Fri, 15 Mar 2024 15:31:03 +0100
From: Stephan Gerhold <stephan@gerhold.net>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	andersson@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	neil.armstrong@linaro.org, laetitia.mariottini@se.com,
	pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
	benjamin.missey@non.se.com, daniel.thompson@linaro.org,
	linux-kernel@vger.kernel.org,
	Jagdish Gediya <jagdish.gediya@linaro.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS
Message-ID: <ZfRbp8o-4pFBAjc-@gerhold.net>
References: <CAFA6WYNMjCaa0FKjNv6a8VFkco3=GBfgWNDuckGZdiZ9dGmHgg@mail.gmail.com>
 <d82ab1f8-e677-485f-9a6b-4115acfd7239@linaro.org>
 <CAFA6WYNSumyScax=GkN42GJOG56T3odF5Ed9A2i1nk_exCyGtA@mail.gmail.com>
 <ZfLUu6_Vq7MvG2G3@gerhold.net>
 <CAFA6WYPN2Bt7zvDyd+02jrsZJz0sFhkD_o4W+PvU=-VC4W5k=A@mail.gmail.com>
 <ZfL6hi0kfp9MXQ0H@gerhold.net>
 <CAFA6WYMa_0OMkjUdvhYtWZ9SvQx5bB8+YrBZN08BaDXXOtPPNQ@mail.gmail.com>
 <fb20d921-dabd-41dc-9f91-bde90e3b87be@linaro.org>
 <9b614c61-276d-45bf-8320-44b7358a3e19@linaro.org>
 <CAFA6WYMHA2M1LLjaog17f83Cu_wH4MAvxhuwAQH0c7j4XTM3XA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYMHA2M1LLjaog17f83Cu_wH4MAvxhuwAQH0c7j4XTM3XA@mail.gmail.com>
Content-Transfer-Encoding: 7bit

On Fri, Mar 15, 2024 at 03:01:27PM +0530, Sumit Garg wrote:
> On Thu, 14 Mar 2024 at 21:07, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> > On 14/03/2024 15:20, Konrad Dybcio wrote:
> > > On 3/14/24 14:50, Sumit Garg wrote:
> > >> On Thu, 14 Mar 2024 at 18:54, Stephan Gerhold <stephan@gerhold.net>
> > >> wrote:
> > >>>
> > >>> On Thu, Mar 14, 2024 at 05:26:27PM +0530, Sumit Garg wrote:
> > >>>> On Thu, 14 Mar 2024 at 16:13, Stephan Gerhold <stephan@gerhold.net>
> > >>>> wrote:
> > >>>>> On Thu, Mar 14, 2024 at 03:02:31PM +0530, Sumit Garg wrote:
> > >>>>>> On Thu, 14 Mar 2024 at 14:48, Konrad Dybcio
> > >>>>>> <konrad.dybcio@linaro.org> wrote:
> > >>>>>>> On 3/14/24 10:04, Sumit Garg wrote:
> > >>>>>>>> On Wed, 13 Mar 2024 at 18:34, Konrad Dybcio
> > >>>>>>>> <konrad.dybcio@linaro.org> wrote:
> > >>>>>>>>> On 3/13/24 13:30, Sumit Garg wrote:
> > >>>>>>>>>> Add Schneider Electric HMIBSC board DTS. The HMIBSC board is
> > >>>>>>>>>> an IIoT Edge
> > >>>>>>>>>> Box Core board based on the Qualcomm APQ8016E SoC.
> > >>>>>>>>>>
> > >>>>>>>>>> Support for Schneider Electric HMIBSC. Features:
> > >>>>>>>>>> - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno
> > >>>>>>>>>> 306)
> > >>>>>>>>>> - 1GiB RAM
> > >>>>>>>>>> - 8GiB eMMC, SD slot
> > >>>>>>>>>> - WiFi and Bluetooth
> > >>>>>>>>>> - 2x Host, 1x Device USB port
> > >>>>>>>>>> - HDMI
> > >>>>>>>>>> - Discrete TPM2 chip over SPI
> > >>>>>>>>>> - USB ethernet adaptors (soldered)
> > >>>>>>>>>>
> > >>>>>>>>>> Co-developed-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> > >>>>>>>>>> Signed-off-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> > >>>>>>>>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > >>>>>>>>>> ---
> > >>>>>>>>>
> > >>>>>>>>> [...]
> > >>>>>>>>>
> > >>>>>>>>>> +     memory@80000000 {
> > >>>>>>>>>> +             reg = <0 0x80000000 0 0x40000000>;
> > >>>>>>>>>> +     };
> > >>>>>>>>>
> > >>>>>>>>> I'm not sure the entirety of DRAM is accessible..
> > >>>>>>>>>
> > >>>>>>>>> This override should be unnecessary, as bootloaders generally
> > >>>>>>>>> update
> > >>>>>>>>> the size field anyway.
> > >>>>>>>>
> > >>>>>>>> On this board, U-Boot is used as the first stage bootloader
> > >>>>>>>> (replacing
> > >>>>>>>> Little Kernel (LK), thanks to Stephan's work). And U-Boot consumes
> > >>>>>>>> memory range from DT as Linux does but doesn't require any
> > >>>>>>>> memory to
> > >>>>>>>> be reserved for U-Boot itself. So apart from reserved memory nodes
> > >>>>>>>> explicitly described in DT all the other DRAM regions are
> > >>>>>>>> accessible.
> > >>>>>>>
> > >>>>>>> Still, u-boot has code to fetch the size dynamically, no?
> > >>>>>>>
> > >>>>>>
> > >>>>>> No U-Boot being the first stage bootloader fetches size from DT which
> > >>>>>> is bundled into U-Boot binary.
> > >>>>>>
> > >>>>>
> > >>>>> Back when I added support for using U-Boot as first stage
> > >>>>> bootloader on
> > >>>>> DB410c the way it worked is that U-Boot used a fixed amount of DRAM
> > >>>>> (originally 968 MiB, later 1 GiB since I fixed this in commit
> > >>>>> 1d667227ea51 ("board: dragonboard410c: Fix PHYS_SDRAM_1_SIZE") [1]).
> > >>>>> When booting Linux, the Linux DT was dynamically patched with the
> > >>>>> right
> > >>>>> amount of DRAM (obtained from SMEM). So if you had e.g. a Geniatech
> > >>>>> DB4
> > >>>>> board with 2 GiB DRAM, U-Boot was only using 1 GiB of DRAM, but Linux
> > >>>>> later got the full 2 GiB patched into its DTB.
> > >>>>>
> > >>>>> I didn't have much time for testing U-Boot myself lately but a quick
> > >>>>> look at the recent changes suggest that Caleb accidentally removed
> > >>>>> that
> > >>>>> functionality in the recent cleanup. Specifically, the SMEM-based DRAM
> > >>>>> size detection was removed in commit 14868845db54 ("board:
> > >>>>> dragonboard410c: import board code from mach-snapdragon" [2]), the
> > >>>>> msm_fixup_memory() function does not seem to exist anymore now. :')
> > >>>>
> > >>>> Ah now I see the reasoning for that particular piece of code. Is SMEM
> > >>>> based approach the standardized way used by early stage boot-loaders
> > >>>> on other Qcom SoCs too?
> > >>>>
> > >>>
> > >>> It is definitely used on all the SoCs that were deployed with LK. I am
> > >>> not entirely sure about the newer ABL/UEFI-based ones. A quick look at
> > >>> the ABL source code suggests it is abstracted through an EFI protocol
> > >>> there (so we cannot see where the information comes from with just the
> > >>> open-source code). However, in my experience SMEM data structures are
> > >>> usually kept quite stable (or properly versioned), so it is quite likely
> > >>> that we could use this approach for all Qualcomm SoCs.
> > >>>
> > >>
> > >> If the SoCs which support this standardized way to dynamic discover
> > >> DRAM size via SMEM then why do we need to rely on DT at all for those
> > >> SoCs? Can't U-Boot and Linux have the same driver to fetch DRAM size
> > >> via SMEM? I am not sure if it's an appropriate way for U-Boot to fixup
> > >> DT when that information can be discovered dynamically.
> >
> > [...]
> >
> > The reason I decided to hardcode this in DT for U-Boot is because SMEM
> > currently relies on the driver model and isn't available early enough.
> >
> > Also admittedly I just wasn't that familiar with the U-Boot codebase. I
> > just wanted to avoid hardcoding this in C code, and given that this was
> > already supported for the "chainloading from ABL" usecase, just
> > hardcoding the values was the obvious solution.
> >
> > I would definitely be open to revisiting this in U-Boot, having an SMEM
> > framework that we could use without the driver model which would just
> > take a base address and then let us interact with SMEM and populate the
> > dram bank data would be a good improvement, and would let us avoid
> > hardcoding the memory layout in DT. We'd just need to manually find the
> > SMEM base address in the FDT as part of "dram_init_banksize()" and
> > retrieve the data there.
> 
> These are the similar problems Linux has to deal with too but on Qcom
> platforms it is rather offloaded to bootloaders to rather implement
> this. It leads to custom DT modification or board code in U-Boot which
> is hard to maintain. If we want to implement it properly then
> corresponding bindings should be upstreamed too regarding how DRAM
> range is to be discovered via SMEM.
> 
> >
> > That all being said, I don't see any reason not to define the memory
> > layout in DT, it's a hardware feature, DT describes the hardware. The
> > whole "bootloader will fill this in" implies that the bootloader isn't
> > also using DT as the source of truth, but now with U-Boot it actually
> > is, so it's all the more important that DT be accurate ;P
> 
> I agree DT should be accurate and not a fan of DT fixups. However,
> when it comes to some hardware configuration being discoverable then
> IMHO DT isn't the appropriate place for that. For the time being I am
> fine with the DRAM range to be specified in DT.
> 
> > >
> > > You're mixing two things. Linux expects a devicetree where
> > > /memory/reg[size]
> > > is valid. Such driver should indeed be (re)implemented in u-boot to provide
> > > this information.
> 
> No, I don't think so. We should rather start thinking about the
> overall stack rather than just being Linux kernel centric. Do you have
> a generic solution for U-Boot regarding how this should be
> implemented?
> 

Detecting available memory via /memory in the DT or other firmware
services (such as UEFI GetMemoryMap()) is *the* generic solution used
everywhere, independent of the hardware (e.g. Qualcomm) and the
operating system (e.g. Linux or Xen).

It allows us to implement the board/Qualcomm-specific memory detection
in a single project, rather than having extra porting overhead for each
operating system for something as essential as available memory.

If we implement the SMEM-based memory detection in U-Boot (probably in
dram_init_banksize() as Caleb suggested) everything else will just work
without any Qualcomm-specific DT patching in U-Boot, and without any
special code in the operating system:

 - U-Boot automatically updates the /memory node in generic code (see
   fdt_fixup_memory_banks() call in arch/arm/lib/bootm-fdt.c). If you
   are using UEFI for booting, U-Boot will provide the same information
   via GetMemoryMap(). (The DT spec says /memory should be ignored on
   UEFI systems.)

 - Linux, Xen, and any other operating system can obtain the memory size
   via the standard method, and do not need any Qualcomm-specific at all
   (at least for memory detection).

I don't think there is anything Linux kernel centric for the memory
detection here. Quite the opposite really. :)

Thanks,
Stephan

