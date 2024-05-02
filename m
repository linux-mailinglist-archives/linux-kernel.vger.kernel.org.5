Return-Path: <linux-kernel+bounces-166932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8649C8BA237
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13CDA1F22B38
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173BC181BBE;
	Thu,  2 May 2024 21:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhqRAMZ7"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995821802AC;
	Thu,  2 May 2024 21:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685179; cv=none; b=F06EJokKvcF6zqUfVYLX5xeIWCAiIzOiSLendA5faiwhlAGd1EKSfhnFpDNxw3CXWhw0i7OD7z7INMa1Vw/yicEx1IAiUaWHj5rCkBLA+WBfP+Sx3U1uMhKcBA/iUFRHGXPvjkJ+Tc16QPtaTBOmQJ5zAZM6EPT5Unn7Kqnv1bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685179; c=relaxed/simple;
	bh=SyYOWZZG048c51JaV/kv91NhpeoEJdnZstAiYLX9hXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOpNICvo9U1z9KhgvmYSpiM2Sebm7+K66KqgpfFACuhLbVQXInzDJBtkJ9CUDTvYHS9nF2XrJALvZCCVqUV5tbHHUfYjXHRlXoS3HU8k0YAFGm57ERH9zwovrHW227vi2tYOX5H3nEetiTROtD8O6NaVxn+JaTgy4ME3QNalcgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhqRAMZ7; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51f60817e34so875666e87.2;
        Thu, 02 May 2024 14:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714685176; x=1715289976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C1gB8YjsPz4rQpEmCzwrb8+wB0LWmO1Pmfg0vfLQCl8=;
        b=QhqRAMZ7bqHiiOwjeGHbLE9lhi3mc41LcWVHn09zBDv/pNxCdbHVzncnhuVUqQIcD7
         l/iyDm5FVv59VQZNrjN2MIbpMfuuu8In9Ayt2X5X4G2cfsnhxszt1PsEdrZd9GfMaMN8
         uTzkn47dou5TMBGys0ovJQrFQX7t3MvGBwbpkpyPC0oy2kdRE1KC5XZI/HcSKUSta+En
         EPXePLpCojd5TvGIVVehbs+hBbtSEH9hxf96yKWatjavAB0veNI1advTbjdy/L6+bKRM
         G3pKkYibigUv/R5Ye3f4cKJtGKYxs6YGHK3snyp/22Y865Q4Lok8CAev72hjOjmMxEMs
         uwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685176; x=1715289976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1gB8YjsPz4rQpEmCzwrb8+wB0LWmO1Pmfg0vfLQCl8=;
        b=WDTiuAN+rmm5TyrsEJ2XQ4olgdIe7NeTZw0NJeQjX6bLK4caApeB4y9JWvi3dA6HpW
         8TQNdZISOcsHrXO0YkKcvUM8tE+L63Iv0LcxHsUPKXJ35FC2xKidNEx449IWU2f2JTvy
         Vp0fDs8eg/xHu++P+cpR/aviU4tCOCbmofVm4La+Qvj3KplhHyTkNcv23vlUeqvTSmoy
         susl3WKHARQgoxtBQx3fOIpT7iiuyS8TYjK/q6E+9rAZqdKhy3nUQyyBb2pKrg3oo+r8
         /AmT45V0BHJ9fyu5r9fPfJgQosjEXILl+mAYR+Rb0kpHZ+SxRFnVRozHq7TaGDJJcrWM
         67yw==
X-Forwarded-Encrypted: i=1; AJvYcCVkST4hEVo190JeUykDqZtX2gbLsI+qUusOkqvBY3sSCtDUk8f4MHDkkiAVb3WwA33jUOHiO/3N7KH8pnJGT0RsmbmYkOkj
X-Gm-Message-State: AOJu0YyytA63YRYtE1yA+PJzA3LhFu0NR1NMtHY4H3Gro37mOGGgOsFz
	5CkuwPKMLvs/oRAxldGpCloZcAVhnqyrMoo3GB3lT9/ke3nJLz0Y
X-Google-Smtp-Source: AGHT+IGAOdvGGIhOITqF96Naz8xBqcBwgssy/49bKxqTCGIDKIoeJMyFV6DuUxugWQXBUhdk06ALbg==
X-Received: by 2002:a19:5219:0:b0:51c:b8ec:c46f with SMTP id m25-20020a195219000000b0051cb8ecc46fmr584721lfb.22.1714685175418;
        Thu, 02 May 2024 14:26:15 -0700 (PDT)
Received: from mobilestation ([95.79.182.53])
        by smtp.gmail.com with ESMTPSA id p25-20020ac246d9000000b0051b41844048sm301735lfo.285.2024.05.02.14.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:26:14 -0700 (PDT)
Date: Fri, 3 May 2024 00:26:12 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Halaney <ahalaney@redhat.com>, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, hkallweit1@gmail.com
Subject: Re: racing ndo_open()/phylink*connect() with phy_probe()
Message-ID: <7723d4l2kqgrez3yfauvp2ueu6awbizkrq4otqpsqpytzp45q2@rju2nxmqu4ew>
References: <uz66kbjbxieof6vkliuwgpzhlrbcmeb2f5aeuourw2vqcoc4hv@2adpvba3zszx>
 <ZjFl4rql0UgsHp97@shell.armlinux.org.uk>
 <ykdqxnky7shebbhtucoiokbews2be5bml6raqafsfn4x6bp6h3@nqsn6akpajvp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ykdqxnky7shebbhtucoiokbews2be5bml6raqafsfn4x6bp6h3@nqsn6akpajvp>

Hi all

On Thu, May 02, 2024 at 12:43:27PM -0500, Andrew Halaney wrote:
> On Tue, Apr 30, 2024 at 10:42:58PM +0100, Russell King (Oracle) wrote:
> > On Tue, Apr 30, 2024 at 04:02:19PM -0500, Andrew Halaney wrote:
> > > Basically, NetworkManager is setting both interfaces to up, and end1's
> > > phy doesn't seem to be ready when ndo_open() runs, returning
> > > -ENODEV in phylink_fwnode_phy_connect() and bubbling that back up. This doesn't
> > 
> > Let's get something clear - you're attributing phylink to this, but this
> > is not the case. phylink doesn't deal directly with PHYs, it makes use
> > of phylib for that, and merely passes back to its caller whatever status
> > it gets from phylib. It's also not fair to attribute this to phylib as
> > we will see later...
> 
> Sorry for the delay, I wanted to try and test with some extra logs in
> the legit setup (not my "simulate via EPROBE_DEFER delays" approach)
> which is tedious with the initramfs (plus I wasted time failing to
> ftrace some stuff :P) to reconvince me of old notes. Thanks for the
> explanation above on the nuances between phylink and phylib, I really
> appreciate it.
> 
> > 
> > There are a few reasons for phylink_fwnode_phy_connect() would return
> > -ENODEV:
> > 
> > 1) fwnode_get_phy_node() (a phylib function) returning an error,
> > basically meaning the phy node isn't found. This would be a persistent
> > error, so unlikely to be your issue.
> > 
> > 2) fwnode_phy_find_device() (another phylib function) not finding the
> > PHY device corresponding to the fwnode returned by the above on the
> > MDIO bus. This is possible if the PHY has not been detected on the
> > MDIO bus, but I suspect this is not the cause of your issue.
> 
> So I think we're in this case. I added some extra logs to see which
> of the cases we were hitting, as well as some extra logs in phy creation
> code etc to come to that conclusion:
> 
>     # end1 probe start (and finish)
>     [    1.424099] qcom-ethqos 23000000.ethernet: Adding to iommu group 2
>     ...
>     [    1.431267] qcom-ethqos 23000000.ethernet: Using 40/40 bits DMA host/device width
> 
>     # end0 probe start
>     [    1.440517] qcom-ethqos 23040000.ethernet: Adding to iommu group 3
>     ...
>     [    1.443502] qcom-ethqos 23040000.ethernet: Using 40/40 bits DMA host/device width
> 
>     # end0 starts making the mdio bus, and phy devices
>     [    1.443537] qcom-ethqos 23040000.ethernet: Before of_mdiobus_reg
> 
>     # create phy at addr 0x8, end0's phy
>     [    1.450118] Starting phy_create_device for addr: 8
> 
>     # NetworkManager up'ed end1! and again. But the device we're needing
>     # (0xa) isn't created yet
>     [    1.459743] qcom-ethqos 23000000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-0
>     ...
>     [    1.465168] Failed at fwnode_phy_find_device
>     [    1.465174] qcom-ethqos 23000000.ethernet end1: __stmmac_open: Cannot attach to PHY (error: -19)
>     [    1.473687] qcom-ethqos 23000000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-0
>     ...
>     [    1.477637] Failed at fwnode_phy_find_device
>     [    1.477643] qcom-ethqos 23000000.ethernet end1: __stmmac_open: Cannot attach to PHY (error: -19)
> 
>     # device created for 0x8, probe it
>     [    1.531617] Ending phy_create_device for addr: 8
>     [    1.627462] Marvell 88E1510 stmmac-0:08: Starting probe
>     [    1.627644] hwmon hwmon0: temp1_input not attached to any thermal zone
>     [    1.627650] Marvell 88E1510 stmmac-0:08: Ending probe
> 
>     # device created for 0xa, probe it
>     [    1.628992] Starting phy_create_device for addr: a
>     [    1.632615] Ending phy_create_device for addr: a
>     [    1.731552] Marvell 88E1510 stmmac-0:0a: Starting probe
>     [    1.731732] hwmon hwmon1: temp1_input not attached to any thermal zone
>     [    1.731738] Marvell 88E1510 stmmac-0:0a: Ending probe
> 
>     # end0 is done probing now
>     [    1.732804] qcom-ethqos 23040000.ethernet: After of_mdiobus_reg
>     [    1.820725] qcom-ethqos 23040000.ethernet end0: renamed from eth0
> 
>     # NetworkManager up's end0
>     [    1.851805] qcom-ethqos 23040000.ethernet end0: Register MEM_TYPE_PAGE_POOL RxQ-0
>     ...
>     [    1.914980] qcom-ethqos 23040000.ethernet end0: PHY [stmmac-0:08] driver [Marvell 88E1510] (irq=233)
>     ...
>     [    1.939432] qcom-ethqos 23040000.ethernet end0: configuring for phy/sgmii link mode
>     ...
>     [    4.451765] qcom-ethqos 23040000.ethernet end0: Link is Up - 1Gbps/Full - flow control rx/tx
> 
> So end1 is up'ed before end0 can finish making its mdio bus / phy
> devices, and therefore we fail to find it. I can easily simulate this
> situation as well by -EPROBE_DEFER'ing end0 for say 10 seconds.

AFAICS the problem is in the race between the end0 and end1 device
probes. Right?
If so then can't the order be fixed by adding the links between the
OF-devices?  As it's already done for various phandle-based references
like "clocks", "gpios", "phys", etc?

* Before this topic was raised I had thought it was working for any
phandle-based dependencies, but apparently it wasn't and the
supplier/consumer linkage was supposed to be implemented for each
particular case. The "phy-handle" property lacks that feature support
(see drivers/of/property.c:of_supplier_bindings and
of_fwnode_add_links() for details).

-Serge(y)

> [...]

