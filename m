Return-Path: <linux-kernel+bounces-29519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E67E830F8B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F5D28C3F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1EB1E88C;
	Wed, 17 Jan 2024 22:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2N70P7B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC64286B4;
	Wed, 17 Jan 2024 22:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531951; cv=none; b=FmEZ607rw+0+aUW+Siyz0FG9W26i8pM7I5rE+rY0QTLtwXcv6v8FDk/Nw2LjAxYKyae8hCBP+kgwDR5jzLE8lCkNwFVrxgAvLb/xBGHskDigJ08YDkHduHhQfje73CSYL88GGyaSJFM7OkVezVLo+MRaI8tZwNreePaY/KDlJEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531951; c=relaxed/simple;
	bh=doFhJfl05v+z3nBhsaH55fnA1hNGIVH9nafMEuRT5eo=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=oREhnQfFsxnu5qOJW2bP30jt6ho5RPPTwGqRtfVnXO1yN7y5GyWdCgyb/NEWiyc/j52R/7MTOSbWMKIdz2aiUrEXGlsCES/xSV9ZG3/WRi0Ehe+L8YIZVJqYc5zS7LPfCE7hqRaU4EcFqtoB/P4hEzY9DqdvmxkMBA5dLjnAEUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2N70P7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2685C433F1;
	Wed, 17 Jan 2024 22:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705531951;
	bh=doFhJfl05v+z3nBhsaH55fnA1hNGIVH9nafMEuRT5eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h2N70P7BMGUXLK6Qr3U4BMXvlsuJHU1R6xM5cjyddSnaOa2/2JVfJNQr+ZVe+OI1B
	 aZ6/hf2eVLwVTE39E8ZVH6I8bswK1oxMSM9p7xRV9py9Zi4M6vYvMcH5Q+gOZlDD3g
	 6ig8D406FeoTa7JMVtf0NSFyjahAN2a7sQ3UM+GPGcaqBa7E9wVHcFBQ91fgCuSYdn
	 CSCYXmrVdWkGTmSh72dcles0VKALlL7+pnupHJPvkjbtjOsXqX1w3q8cT9XqMXvnxs
	 3j6wNDyoPHJHZl1L1Z1pw5DGeJB9aNnA4NwaJ1Jzs9f3hFJeGDspzaUzsCXZE18JjW
	 p3D2BIp9kpxyg==
Date: Wed, 17 Jan 2024 23:52:25 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: ASMedia ASM1062 (AHCI) hang after "ahci 0000:28:00.0: Using
 64-bit DMA addresses"
Message-ID: <ZahaKaV1jlHQ0sUx@x1-carbon>
References: <ZaZ2PIpEId-rl6jv@wantstofly.org>
 <ZaaQpiW3OOZTSyXw@x1-carbon>
 <ZahDNr97MSPNSHW_@wantstofly.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZahDNr97MSPNSHW_@wantstofly.org>

Hello Lennert,

On Wed, Jan 17, 2024 at 11:14:30PM +0200, Lennert Buytenhek wrote:
> On Tue, Jan 16, 2024 at 03:20:23PM +0100, Niklas Cassel wrote:
> 
> > > On kernel 6.6.x, with an ASMedia ASM1062 (AHCI) controller, on an
> 
> Minor correction to this: lspci says that this is an ASM1062, but it's
> actually an ASM1061.  I think that the two parts share a PCI device ID,
> and I've submitted a PCI ID DB change here:
> 
> https://admin.pci-ids.ucw.cz/read/PC/1b21/0612

FWIW, the kernel states that 0x0612 is ASM1062, and 0x0611 is ASM1061:
https://github.com/torvalds/linux/blob/v6.7/drivers/ata/ahci.c#L603-L604

But that could of course be incorrect.


When you are dumping the LnkCap in the PCI ID DB change request,
are you dumping the LnkCap for the AHCI controller or the PCI bridge?

(Because you use # lspci -s 27:00.0 in the PCI ID DB change request,
but # lspci -s 28:00.0 further down in this email.)

(Perhaps the PCI bride only has one PCI lane, but the AHCI controller has two?)


> > The DMA mask is set here:
> > https://github.com/torvalds/linux/blob/v6.7/drivers/ata/ahci.c#L967
> > 
> > And should be called using:
> > hpriv->cap & HOST_CAP_64
> > https://github.com/torvalds/linux/blob/v6.7/drivers/ata/ahci.c#L1929
> > 
> > Where hpriv->cap is capabilities reported by the AHCI controller itself.
> > So it definitely seems like your controller supports 64-bit addressing.
> 
> Perhaps, or maybe it's misreporting its capabilities, as it is an old
> part (from 2011 or before), and given that it doesn't seem to support
> 64-bit MSI addressing, either, which for a part with a 64-bit DMA engine
> would be an odd restriction:
> 
> # lspci -s 28:00.0 -vv | grep -A1 MSI:
>         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
>                 Address: fee00000  Data: 0000
> #

That just claims that MSIs have to use a 32-bit PCI address.

See e.g.:
00:02.0 VGA compatible controller: Intel Corporation Haswell-ULT Integrated Graphics Controller (rev 0b) (prog-if 00 [VGA controller])
  Subsystem: Lenovo Device 3978
  Flags: bus master, fast devsel, latency 0, IRQ 58
  Memory at b0000000 (64-bit, non-prefetchable) [size=4M]
  Memory at a0000000 (64-bit, prefetchable) [size=256M]
  I/O ports at 4000 [size=64]
  Expansion ROM at <unassigned> [disabled]
  Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
  Capabilities: [d0] Power Management version 2
  Capabilities: [a4] PCI Advanced Features
  Kernel driver in use: i915

It has 64-bit BARs, but does not support 64-bit MSIs.


> 
> (I checked the available datasheets, but there is no mention of whether
> or not the part supports 64-bit DMA.)

If you are curious, hpriv->cap is the HBA capabilities reported by the
device, see:
https://www.intel.com/content/dam/www/public/us/en/documents/technical-specifications/serial-ata-ahci-spec-rev1-3-1.pdf

3.1.1 Offset 00h: CAP – HBA Capabilities

Bit 31 - Supports 64-bit Addressing (S64A).

It seems a bit silly that the AHCI controller vendor accidentally set this
bit to 1.


> Per:
> 
> 	https://www.asus.com/motherboards-components/motherboards/workstation/pro-ws-wrx80e-sage-se-wifi/helpdesk_bios?model2Name=Pro-WS-WRX80E-SAGE-SE-WIFI
> 
> However, some Googling suggests that the ASM106x loads its own firmware
> from a directly attached SPI flash chip, and there are several versions
> of this firmware available in the wild, with different versions of the
> firmware apparently available for legacy IDE mode and for AHCI mode.  If
> (some of) the AHCI logic is indeed contained inside the firmware, I
> could see a firmware bug leading to the controller incorrectly presenting
> itself as being 64-bit DMA capable.
> 
> Some poking around in the BIOS image suggests that there is no copy of
> the ASM106x firmware inside the BIOS image.  In other words, it could be
> that, even though the machine is running the latest available BIOS, the
> ASM1061 might be running an older firmware version.
> 
> The ASM1061 firmware does not seem to be readable from software via a
> ROM BAR, and it doesn't seem to readable from software in general (the
> vendor-supplied DOS .exe updater tool only allows you to erase or
> update the SPI flash), so I can't check which firmware version it is
> currently using.
> 
> 
> > If that does not work, perhaps you could try this (completely untested) patch:
> > (You might need to modify the strings to match the exact strings reported by
> > your BIOS.)
> 
> Thanks for the patch!

Assuming that you just have ASM106x controllers in your system,
you could also replace it with a simple:

@@ -1799,6 +1823,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
        if (ahci_broken_devslp(pdev))
                hpriv->flags |= AHCI_HFLAG_NO_DEVSLP;
 
+       /* must set flag prior to save config in order to take effect */
+       hpriv->flags |= AHCI_HFLAG_32BIT_ONLY;
+
 #ifdef CONFIG_ARM64
        if (pdev->vendor == PCI_VENDOR_ID_HUAWEI &&
            pdev->device == 0xa235 &&


Just for testing.


> 
> I will do some tests with PCI passthrough to a VM, to see whether, and if
> it does, exactly how the controller mangles DMA addresses.

Were you running in a VM when testing this?
(Usually you need to pass through all PCI devices in the same iommu group.)

The errors from your previous email:
[IO_PAGE_FAULT domain=0x0035 address=0x7fffff00000 flags=0x0000]
[Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged

could also suggest an iommu issue. Have you tried booting with iommu=off
and/or amd_iommu=off on the kernel command line?
(Or temporarily disable the iommu in BIOS.)


> 
> I've also ordered a discrete PCIe card with an ASM1061 chip on it, and I
> will perform similar tests with that card, to see exactly where the issue
> is, i.e. whether it is specific to this mainboard or not.
> 
> I will follow up once I will have more information.

Looking forward to hear your findings :)


Kind regards,
Niklas

