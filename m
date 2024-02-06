Return-Path: <linux-kernel+bounces-55550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 774A084BE05
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7A01C22686
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2487168BA;
	Tue,  6 Feb 2024 19:20:10 +0000 (UTC)
Received: from mail.someserver.de (mail.someserver.de [116.202.193.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB591754B;
	Tue,  6 Feb 2024 19:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.193.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707247210; cv=none; b=PXg+HdfPaad9kth18B1gLhHwv1nTg8vpro0sEew25i6w9D3khj9D785LmqWtzRqJpwhogkfi36SN70FqdpTXNiFXew4uymOa7Zl4+nWZIjhDqe3qP1+UW8W8RkojVl1D10/gD0ewOJuFRFVhlOluzYIPvaGr50HLH+B38U514q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707247210; c=relaxed/simple;
	bh=3iSqkYE7BU24TdTslIeyhkwASqnpAZB9syTd+oJD1KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQa7NanO4z/5F+1j6f/StSvJa4eroVgBGigU7L3ObdWpRahUIjTZVbEA3xMnznKZJofga+ehJLoa9BtKEHe36n0g3vePMjcUoJuI5PSRuv1Ain5I4AeYorbfA8BQVoGdMZlevaouZCxfqlvgNhdQOwCDsq33et55A9aQFQ+SXio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=christina-quast.de; spf=pass smtp.mailfrom=christina-quast.de; arc=none smtp.client-ip=116.202.193.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=christina-quast.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=christina-quast.de
Received: from [192.168.244.146] (tmo-103-215.customers.d1-online.com [80.187.103.215])
	by mail.someserver.de (Postfix) with ESMTPSA id 7BB29A21C5;
	Tue,  6 Feb 2024 20:19:53 +0100 (CET)
Message-ID: <eb229460-0efc-448a-863f-ac0634a72f2c@christina-quast.de>
Date: Tue, 6 Feb 2024 20:19:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] net: phy: add Rust Rockchip PHY driver
Content-Language: en-US
To: Trevor Gross <tmgross@umich.edu>,
 Christina Quast <contact@christina-quast.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Heiko Stuebner <heiko@sntech.de>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20240201-rockchip-rust-phy_depend-v2-0-c5fa4faab924@christina-quast.de>
 <20240201-rockchip-rust-phy_depend-v2-3-c5fa4faab924@christina-quast.de>
 <CALNs47tnwCgyvM2jBo=bTt1=2AJFt3b6W+JsTHM3Np2tbNJYCA@mail.gmail.com>
From: Christina Quast <chrysh@christina-quast.de>
In-Reply-To: <CALNs47tnwCgyvM2jBo=bTt1=2AJFt3b6W+JsTHM3Np2tbNJYCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Trevor!

Thanks a lot for your review, I learned a lot! I felt, from the feedback 
in the Zulip forum that rewriting more phy drivers might be interesting, 
but I think I misunderstood something.

There is no specific goal behind the rewrite, I just thought it would be 
useful to bring more Rust into the Kernel.

Cheers,

Christina

On 2/1/24 22:06, Trevor Gross wrote:
> On Thu, Feb 1, 2024 at 12:07 PM Christina Quast
> <contact@christina-quast.de> wrote:
>> +++ b/drivers/net/phy/rockchip_rust.rs
>> @@ -0,0 +1,131 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (C) 2024 Christina Quast <contact@christina-quast.de>
>> +
>> +//! Rust Rockchip PHY driver
>> +//!
>> +//! C version of this driver: [`drivers/net/phy/rockchip.c`](./rockchip.c)
>> +use kernel::{
>> +    c_str,
>> +    net::phy::{self, DeviceId, Driver},
>> +    prelude::*,
>> +    uapi,
>> +};
>> +
>> +kernel::module_phy_driver! {
>> +    drivers: [PhyRockchip],
>> +    device_table: [
>> +        DeviceId::new_with_driver::<PhyRockchip>(),
>> +    ],
>> +    name: "rust_asix_phy",
>> +    author: "FUJITA Tomonori <fujita.tomonori@gmail.com>",
> Tomo wrote this? :)
>
>> +    description: "Rust Asix PHYs driver",
>> +    license: "GPL",
>> +}
>> +
>> +
>> +const MII_INTERNAL_CTRL_STATUS: u16 = 17;
>> +const SMI_ADDR_TSTCNTL: u16 = 20;
>> +const SMI_ADDR_TSTWRITE: u16 = 23;
>> +
>> +const MII_AUTO_MDIX_EN: u16 = bit(7);
>> +const MII_MDIX_EN: u16 = bit(6);
>> +
>> +const TSTCNTL_WR: u16 = bit(14) | bit(10);
>> +
>> +const TSTMODE_ENABLE: u16 = 0x400;
>> +const TSTMODE_DISABLE: u16 = 0x0;
>> +
>> +const WR_ADDR_A7CFG: u16 = 0x18;
> Most of these are clear enough, but could you add comments about what
> the more ambiguous constants are for? (e.g. A7CFG).
>
>> +struct PhyRockchip;
>> +
>> +impl PhyRockchip {
> Remove the `helper_` prefix for these functions, and change the docs.
> Their use as helpers is obvious enough based on where they are called,
> better to say what they actually accomplish.
>
> Since they don't take `self`, these could also just be standalone
> functions rather than in an `impl PhyRockchip` block. This makes
> calling them a bit cleaner since you don't need the `PhyRockchip::`
> prefix.
>
>> +   /// Helper function for helper_integrated_phy_analog_init
>> +    fn helper_init_tstmode(dev: &mut phy::Device) -> Result {
>> +        // Enable access to Analog and DSP register banks
>> +        dev.write(SMI_ADDR_TSTCNTL, TSTMODE_ENABLE)?;
>> +        dev.write(SMI_ADDR_TSTCNTL, TSTMODE_DISABLE)?;
>> +        dev.write(SMI_ADDR_TSTCNTL, TSTMODE_ENABLE)
>> +    }
> For consistency, just make the last write also end with `?;` and add a
> `Ok(())` line.
>
>> +
>> +    /// Helper function for helper_integrated_phy_analog_init
>> +    fn helper_close_tstmode(dev: &mut phy::Device) -> Result {
>> +        dev.write(SMI_ADDR_TSTCNTL, TSTMODE_DISABLE)
>> +    }
>> +
>> +    /// Helper function for rockchip_config_init
>> +    fn helper_integrated_phy_analog_init(dev: &mut phy::Device) -> Result {
>> +        Self::helper_init_tstmode(dev)?;
>> +        dev.write(SMI_ADDR_TSTWRITE, 0xB)?;
>> +        dev.write(SMI_ADDR_TSTCNTL, TSTCNTL_WR | WR_ADDR_A7CFG)?;
>> +        Self::helper_close_tstmode(dev)
>> +    }
>> +
>> +    /// Helper function for config_init
>> +    fn helper_config_init(dev: &mut phy::Device) -> Result {
>> +        let val = !MII_AUTO_MDIX_EN & dev.read(MII_INTERNAL_CTRL_STATUS)?;
>> +        dev.write(MII_INTERNAL_CTRL_STATUS, val)?;
>> +        Self::helper_integrated_phy_analog_init(dev)
>> +    }
>> +
>> +    fn helper_set_polarity(dev: &mut phy::Device, polarity: u8) -> Result {
>> +        let reg = !MII_AUTO_MDIX_EN & dev.read(MII_INTERNAL_CTRL_STATUS)?;
>> +        let val = match polarity as u32 {
>> +            // status: MDI; control: force MDI
>> +            uapi::ETH_TP_MDI => Some(reg & !MII_MDIX_EN),
>> +            // status: MDI-X; control: force MDI-X
>> +            uapi::ETH_TP_MDI_X => Some(reg | MII_MDIX_EN),
>> +            // uapi::ETH_TP_MDI_AUTO => control: auto-select
>> +            // uapi::ETH_TP_MDI_INVALID => status: unknown; control: unsupported
>> +            _ => None,
> Is receiving an invalid value not an error? I.e.
>
>      uapi::ETH_TP_MDI_AUTO | uapi::ETH_TP_MDI_INVALID => None,
>      _ => return Err(...)
>
> I know the current implementation came from the C version, just
> wondering about correctness here.
>
>> +        };
>> +        if let Some(v) = val {
>> +            if v != reg {
>> +                return dev.write(MII_INTERNAL_CTRL_STATUS, v);
>> +            }
>> +        }
> In the match statement above - I think you can replace `=> None` with
> `=> return Ok(())` and drop the `Some(...)` wrappers. Then you don't
> need to destructure val here.
>
>> +        Ok(())
>> +
>> +    }
>> +}
>> +
>> +#[vtable]
>> +impl Driver for PhyRockchip {
>> +    const FLAGS: u32 = 0;
>> +    const NAME: &'static CStr = c_str!("Rockchip integrated EPHY");
>> +    const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_custom_mask(0x1234d400, 0xfffffff0);
>> +
>> +    fn link_change_notify(dev: &mut phy::Device) {
>> +    // If mode switch happens from 10BT to 100BT, all DSP/AFE
>> +    // registers are set to default values. So any AFE/DSP
>> +    // registers have to be re-initialized in this case.
> Comment indent
>
>> +        if dev.state() == phy::DeviceState::Running && dev.speed() == uapi::SPEED_100 {
>> +            if let Err(e) = Self::helper_integrated_phy_analog_init(dev) {
>> +                pr_err!("rockchip: integrated_phy_analog_init err: {:?}", e);
>> +            }
>> +        }
>> +    }
>> +
>> +    fn soft_reset(dev: &mut phy::Device) -> Result {
>> +        dev.genphy_soft_reset()
>> +    }
>> +
>> +    fn config_init(dev: &mut phy::Device) -> Result {
>> +        PhyRockchip::helper_config_init(dev)
>> +    }
>> +
>> +    fn config_aneg(dev: &mut phy::Device) -> Result {
>> +        PhyRockchip::helper_set_polarity(dev, dev.mdix())?;
>> +        dev.genphy_config_aneg()
>> +    }
>> +
>> +    fn suspend(dev: &mut phy::Device) -> Result {
>> +        dev.genphy_suspend()
>> +    }
>> +
>> +    fn resume(dev: &mut phy::Device) -> Result {
>> +        let _ = dev.genphy_resume();
> Why not `?` the possible error?
>
>> +
>> +        PhyRockchip::helper_config_init(dev)
>> +    }
>> +}
>>
>> --
>> 2.43.0
>>
> As Greg and Dragan mentioned, duplicate drivers are generally not
> accepted in-tree to avoid double maintenance and confusing config. Is
> there a specific goal?
>
> It is quite alright to request feedback on Rust drivers (and I have
> provided some) or even ask if anyone is willing to help test it out,
> but please use RFC PATCH and make it clear that this is for
> experimentation rather than upstreaming.
>
> Netdev has seemed relatively open to adding Rust drivers for new phys
> that don't have a C implementation, but these phys are of course
> tougher to find.
>
> Also for future reference, changes intended for the net tree should be
> labeled [PATCH v? net-next].
>
> Best regards,
> Trevor

