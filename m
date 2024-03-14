Return-Path: <linux-kernel+bounces-103297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD9487BDAD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02A91C2140C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F0570CB1;
	Thu, 14 Mar 2024 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="i7ilBbfc";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="b5Myrf7Y"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE326EB79;
	Thu, 14 Mar 2024 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710422859; cv=pass; b=XzWRnPn6/4EIXFl/9IADXLYMql2pneZWSZFpYUtXFoeLQhLWEWUfe9AeXVta0fULa7VyVJEvHjzM1fSSrNhNJJRfGgUpmTqEr89XVFxNcPalE4Yroq4X2Q038kRrkTpKvSJYke+GqshqMqANkbwRCBf8eXrwtPnpB9rvhGP9M1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710422859; c=relaxed/simple;
	bh=wlAjoEmmqbb90V29uMN7qmilpO/NLQlvdBoOehj02Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPEliPdah4treA65Jdmx2uwHhsVt6brgzQnbUqtjc6cesVa/bXfKajAj6xmoP1cJ+hCus9GeNUkkQF/IjnQC057aoXrVRGqGLhfiZvY73Zn6AePruDGPPP1S7VZt1DFUYWkvvFVFqBcOTr48TmBEBdO1Nr5uaEdXDlQGG4ICdC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net; spf=none smtp.mailfrom=gerhold.net; dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=i7ilBbfc; dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=b5Myrf7Y; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1710422668; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=E4Iwe4V+vwQhOykblpEseoJt9+tD1NcewVXb5PUBEFs3NwEncKa/dFjrBpz2W8iu2t
    jTq8ij2mINARzlEJ75LQP/QDTHU6P8Gv/IAM1vwIpgyhootIUD8ayYopdr9hWPGhfdUe
    7+3AzB+mbRlUA1olLyFtSNfLPuUDAw6rMrPBMYW8PCPZeodkVnUwmTBjA4PlvpKsQT6h
    Qh5UZFMh7kZ50xTrR2iT0M1fNEx4UKrFMVxY8w7HTrZgvGNFdOn5dI6YXZKghZCPmYio
    nSBUB12CRMNH8ehESREWdjZh3qAugqO3bVKbkpxEDwQnMXYWb2+YXerA1oUpIomh1Aa3
    Fklw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1710422668;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ct/z5cPRWSv8Gwipo9RaoUxHvAdzX90f5gn0Pkz4RcQ=;
    b=XAhN0uUZLumYEZzgPjCuemsq3EkE1sgc3RnSQD/ZrmDV4RkBvGg6g4GGtBUdSEIqiT
    rNXn3pSsZzVtAVyv0yVUgvPETvc8gFWULr1kRDQbtPkX/sRqhWo3ZL9lQeouP3PCFeAO
    HP2kN/QqnlqgYM/N3p3TFQDclhXSLXi+hhxBDtwNi/NGS6K2BlLi0YmOUVKVHH0uC4u/
    4nCbbTFsn7ym3aYMuEyw8V38FX9l/ClYVu1TyJfsA/PHq5GbbpSH5FwrDjCFGb4HR9vo
    mfBUN3e/kJTeFO2PY6gYZa10W94S5a7r/sgJ4rK/hccGQwEK1dks1XBNA/9JX6TUN3dl
    T6Bw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1710422668;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ct/z5cPRWSv8Gwipo9RaoUxHvAdzX90f5gn0Pkz4RcQ=;
    b=i7ilBbfc/am6jj92M1VwAgpCdIEs5Lpm0KjHOSn8UbRylUWrTsmX214qeSagBzjmAc
    M3EDqGFCbHUfe2bp2yLJ+P6QZ5lLUkSxv93gr1K/QBrJShttXo0jCSl5Qsbi+Cn2yZZU
    afruzI2SkW/GjIgdGRzGYqzxVuTAkEUy7O4kFZY2u6RO5tp8u+OYR+sypIG/oGtX9f7q
    R+vKfe+2KwzX0yXvKn8VOKlbZO9vH+niAv8D2iy9JZp4EM+sSorAkibBHosKcsx5ojda
    WtTiq3wp3724Rv9ryXM8+HxaFp03z0ax5wC6PUtPXm8xSuE5BTg5LMaQ30wmeCirOnQM
    loPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1710422668;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ct/z5cPRWSv8Gwipo9RaoUxHvAdzX90f5gn0Pkz4RcQ=;
    b=b5Myrf7YLUgs4KeyXKT9xaAoUbucA0dV1hZ+QwqFpPNWT35Ua1bEfekssBS4osqBBq
    YA80jidbAtTkW7XNERDA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8p+L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 50.2.2 DYNA|AUTH)
    with ESMTPSA id Rf2ecd02EDOR4Jd
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 14 Mar 2024 14:24:27 +0100 (CET)
Date: Thu, 14 Mar 2024 14:24:22 +0100
From: Stephan Gerhold <stephan@gerhold.net>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, andersson@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, caleb.connolly@linaro.org,
	neil.armstrong@linaro.org, laetitia.mariottini@se.com,
	pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
	benjamin.missey@non.se.com, daniel.thompson@linaro.org,
	linux-kernel@vger.kernel.org,
	Jagdish Gediya <jagdish.gediya@linaro.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS
Message-ID: <ZfL6hi0kfp9MXQ0H@gerhold.net>
References: <20240313123017.362570-1-sumit.garg@linaro.org>
 <20240313123017.362570-4-sumit.garg@linaro.org>
 <c0e10cbf-c6f3-4b0c-8616-983da2a40236@linaro.org>
 <CAFA6WYNMjCaa0FKjNv6a8VFkco3=GBfgWNDuckGZdiZ9dGmHgg@mail.gmail.com>
 <d82ab1f8-e677-485f-9a6b-4115acfd7239@linaro.org>
 <CAFA6WYNSumyScax=GkN42GJOG56T3odF5Ed9A2i1nk_exCyGtA@mail.gmail.com>
 <ZfLUu6_Vq7MvG2G3@gerhold.net>
 <CAFA6WYPN2Bt7zvDyd+02jrsZJz0sFhkD_o4W+PvU=-VC4W5k=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPN2Bt7zvDyd+02jrsZJz0sFhkD_o4W+PvU=-VC4W5k=A@mail.gmail.com>
Content-Transfer-Encoding: 7bit

On Thu, Mar 14, 2024 at 05:26:27PM +0530, Sumit Garg wrote:
> On Thu, 14 Mar 2024 at 16:13, Stephan Gerhold <stephan@gerhold.net> wrote:
> > On Thu, Mar 14, 2024 at 03:02:31PM +0530, Sumit Garg wrote:
> > > On Thu, 14 Mar 2024 at 14:48, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> > > > On 3/14/24 10:04, Sumit Garg wrote:
> > > > > On Wed, 13 Mar 2024 at 18:34, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> > > > >> On 3/13/24 13:30, Sumit Garg wrote:
> > > > >>> Add Schneider Electric HMIBSC board DTS. The HMIBSC board is an IIoT Edge
> > > > >>> Box Core board based on the Qualcomm APQ8016E SoC.
> > > > >>>
> > > > >>> Support for Schneider Electric HMIBSC. Features:
> > > > >>> - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> > > > >>> - 1GiB RAM
> > > > >>> - 8GiB eMMC, SD slot
> > > > >>> - WiFi and Bluetooth
> > > > >>> - 2x Host, 1x Device USB port
> > > > >>> - HDMI
> > > > >>> - Discrete TPM2 chip over SPI
> > > > >>> - USB ethernet adaptors (soldered)
> > > > >>>
> > > > >>> Co-developed-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> > > > >>> Signed-off-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> > > > >>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > >>> ---
> > > > >>
> > > > >> [...]
> > > > >>
> > > > >>> +     memory@80000000 {
> > > > >>> +             reg = <0 0x80000000 0 0x40000000>;
> > > > >>> +     };
> > > > >>
> > > > >> I'm not sure the entirety of DRAM is accessible..
> > > > >>
> > > > >> This override should be unnecessary, as bootloaders generally update
> > > > >> the size field anyway.
> > > > >
> > > > > On this board, U-Boot is used as the first stage bootloader (replacing
> > > > > Little Kernel (LK), thanks to Stephan's work). And U-Boot consumes
> > > > > memory range from DT as Linux does but doesn't require any memory to
> > > > > be reserved for U-Boot itself. So apart from reserved memory nodes
> > > > > explicitly described in DT all the other DRAM regions are accessible.
> > > >
> > > > Still, u-boot has code to fetch the size dynamically, no?
> > > >
> > >
> > > No U-Boot being the first stage bootloader fetches size from DT which
> > > is bundled into U-Boot binary.
> > >
> >
> > Back when I added support for using U-Boot as first stage bootloader on
> > DB410c the way it worked is that U-Boot used a fixed amount of DRAM
> > (originally 968 MiB, later 1 GiB since I fixed this in commit
> > 1d667227ea51 ("board: dragonboard410c: Fix PHYS_SDRAM_1_SIZE") [1]).
> > When booting Linux, the Linux DT was dynamically patched with the right
> > amount of DRAM (obtained from SMEM). So if you had e.g. a Geniatech DB4
> > board with 2 GiB DRAM, U-Boot was only using 1 GiB of DRAM, but Linux
> > later got the full 2 GiB patched into its DTB.
> >
> > I didn't have much time for testing U-Boot myself lately but a quick
> > look at the recent changes suggest that Caleb accidentally removed that
> > functionality in the recent cleanup. Specifically, the SMEM-based DRAM
> > size detection was removed in commit 14868845db54 ("board:
> > dragonboard410c: import board code from mach-snapdragon" [2]), the
> > msm_fixup_memory() function does not seem to exist anymore now. :')
> 
> Ah now I see the reasoning for that particular piece of code. Is SMEM
> based approach the standardized way used by early stage boot-loaders
> on other Qcom SoCs too?
> 

It is definitely used on all the SoCs that were deployed with LK. I am
not entirely sure about the newer ABL/UEFI-based ones. A quick look at
the ABL source code suggests it is abstracted through an EFI protocol
there (so we cannot see where the information comes from with just the
open-source code). However, in my experience SMEM data structures are
usually kept quite stable (or properly versioned), so it is quite likely
that we could use this approach for all Qualcomm SoCs.

> >
> > Also, the DRAM size is now always taken from the DT (which is probably
> > better than the previous hardcoded size in the U-Boot board code).
> >
> > I think we should bring the dynamic DRAM size detection back, because
> > there are quite some boards available with varying DRAM size. Restoring
> > msm_fixup_memory() would likely be easiest, I guess the ideal solution
> > would be to parse SMEM in U-Boot's dram_init() function so even U-Boot
> > has the correct amount of DRAM to work with.
> 
> In the context of the HMIBSC board, it has 1 GB RAM LPDDR3 internal
> not expandable. IMO, having it in DT as default should be fine.
> 

Right. I was more talking in terms of DB410c here, where the lack of
this feature is kind of a regression.

Personally, I'm fine if you put the memory node here like this. If there
are concerns from others you could also move it to the -u-boot.dtsi and
omit it for Linux.

Thanks,
Stephan

