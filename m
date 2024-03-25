Return-Path: <linux-kernel+bounces-117399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D38388AADF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E17344226
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419A456452;
	Mon, 25 Mar 2024 15:42:00 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B3140BE7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381319; cv=none; b=hkr79BB7uY8amuCrkXRt0KCOovOm/Ltzl/6XVfLDFK0X3JijiJILZfmBX1P/XFFXdqiC1e+zjoKGXNlapFdIhiPP1xZ5/1aYN/ZKKTEy9TqiGnqqyHnH4jXvgkK2jgFLsb+eOmWl8WE+GpMhqyFDmO8MpCHWo79bE1Yt63/Pg+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381319; c=relaxed/simple;
	bh=bicn3bt3Rvxfh/ao16vucJTlRZS/v7dDzolUZTqTn28=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ha1s1yS7FrbIHNBfFE9QVfakUpBo2F7R2/D8ApEX/tuAbPtigb8qdXqX9Tlw53RCpZ+CMIYXYUhp07TTYqNmHq8dqrUXELh3AXVmMxlIEZp2Yk+nb/NTjw2KEzlrA/8kTdUs6y/uKLKMzxJ/9mXehuogWUuo02vvEG3gmj6GtaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V3H9z469xz6K9T0;
	Mon, 25 Mar 2024 23:37:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 01EF9140B39;
	Mon, 25 Mar 2024 23:41:52 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 25 Mar
 2024 15:41:51 +0000
Date: Mon, 25 Mar 2024 15:41:50 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shimrra Shai <shimmyshai00@gmail.com>
CC: <heiko@sntech.de>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
	<max.schwarz@online.de>, <niyas.sait@huawei.com>
Subject: Re: [PATCH 0/0] (proposed?) Add ACPI binding to Rockchip RK3xxx I2C
 bus
Message-ID: <20240325154150.00003bde@Huawei.com>
In-Reply-To: <20240322155146.22755-1-shimmyshai00@gmail.com>
References: <20240322103521.00001a12@Huawei.com>
	<20240322155146.22755-1-shimmyshai00@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 22 Mar 2024 10:51:46 -0500
Shimrra Shai <shimmyshai00@gmail.com> wrote:

> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> For
> 
> > It would be good to highlight in this description what is missing for
> > doing a standard ACPI binding and not using any specific hacks in the
> > driver (get clocks as normal etc).
> > 
> > There are ACPI clock bindings, but Linux doesn't support the yet (I think?)
> > See ACPICA commit
> > https://github.com/acpica/acpica/commit/661feab5ee01a34af95a389a18c82e79f1aba05a
> > 
> > I've seen prototype code but was a while back.  I'd like to see that
> > work compled rather than having every driver need to paper over the hole.
> > 
> > The alias is a different question that needs to be addressed.
> > If this is a common pattern, push it up in to the i2c core, not
> > a specific driver.  I see there is already code related to that
> > in i2c_add_adapter - that just wants an ACPI option.
> > 
> > Jonathan  
> 
> and
> 
> > That implies that the kernel can cope with the device tree wrapped up in
> > ACPI path.  If that's the case, why do you need RKCP3001 as you can
> > match on the compatible?  
> 
> This was all based on how the people working on the firmware project wrote
> the ACPI binding. That said, since I've got a foot in it too I can 
> definitely submit them an updated binding. The binding for the I2C in the
> project looks like this:
> 
>   Device (I2C1) {
>     Name (_HID, "RKCP3001")
>     Name (_CID, "PRP0001")
>     Name (_UID, 1)
>     Name (_CCA, 0)
> 
>     Method (_CRS, 0x0, Serialized) {
>       Name (RBUF, ResourceTemplate() {
>         Memory32Fixed (ReadWrite, 0xfea90000, 0x1000)
>         Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { 350 }
>       })
>       Return (RBUF)
>     }
>     Name (_DSD, Package () {
>       ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>       Package () {
>         Package (2) { "i2c,clk-rate", 198000000 },
>         Package (2) { "rockchip,bclk", 198000000 },
>         Package (2) { "#address-cells", 1 },
>         Package (2) { "#size-cells", 0 },
>       }
>     })
>   }
>   
> (there are others, e.g. I2C2, I2C3, etc. one for each I2C bus, with
> correspondingly different _UID and some different numbers for interrupts
> etc.)
> 
> From what I'm gathering from reading the documentation at
> https://uefi.org/specs/ACPI/6.5/19_ASL_Reference.html
> which is admittedly quite terse and doesn't provide nearly enough examples
> for my liking, and given I have not been able to find a "in the wild" ACPI
> using ClockInput, I presume a better binding would be like this, correct?:

Niyas is in the CC but is OoO for next few days I think.
He wrote the ACPICA patches for this and can provide better answers than me.

> 
>   Device (I2C1) {
>     Name (_HID, "RKCP3001")
>     /* _CID is gone now because we are no longer assuming mirror of DT */
>     Name (_UID, 1)
>     Name (_CCA, 0)
> 
>     Method (_CRS, 0x0, Serialized) {
>       Name (RBUF, ResourceTemplate() {
>         Memory32Fixed (ReadWrite, 0xfea90000, 0x1000)
>         Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { 350 }
>         ClockInput (198000000, 1, Hz, Fixed, "PCLK", 0)
>         ClockInput (198000000, 1, Hz, Fixed, "BCLK", 0)
>       })
>       Return (RBUF)
>     }
>     Name (_DSD, Package () {
>       ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>       Package () {
>         Package (2) { "#address-cells", 1 },
>         Package (2) { "#size-cells", 0 },
>       }
>     })
> 
>     Device (PCLK) {
>       Name (_ADR, 0x0)
>     }
> 
>     Device (BCLK) {
>       Name (_ADR, 0x1)
>     }
>   }
> 
> Note now I added two device nodes for the clocks and use ClockInput to
> describe the frequencies. I'm unsure though about the device node part,
> however; I know that the .DTB has a central node for the CRU (the actual
> clock generator on the RK3588), so should we instead have a top-level
> Device node "CRU_" and reference the ClockInputs to that, e.g. something
> like
> 
>         ClockInput (198000000, 1, Hz, Fixed, "CRU_", I2C1_PCLK)
>         ClockInput (198000000, 1, Hz, Fixed, "CRU_", I2C1_BCLK)
> 
> ? (Note the obvious analogy to rk3588s.dtsi for the labels, which would be
> #defined constants.) Though in this case I'd ask if someone here would be
> kind enough to supply the structure for the top-level CRU binding so that I
> don't have to guess the "best" form for the kernel like the makers of the
> firmware were doing which is what led to this disagreement in the first
> place.
> 
> FWIW, I'd also be willing to help lend a hand to finish out the support for
> the ClockInput binding in the ACPI reader subsystem. There already seems to
> be some support, e.g. in drivers/acpi/acpica/rsinfo.c and a few other
> places, but I'm not sure what else is needed to get it going and would need
> to study that subsystem in much more depth.

That would be great. It's been on my backlog to take a better look at this, but
it won't happen any time soon.

Niyas, could you forward what you had to Shimrra? (I can find
it if you don't have it any more).

Thanks,

Jonathan

> 
> - Shimmy
> 


