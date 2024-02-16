Return-Path: <linux-kernel+bounces-68437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BC7857A30
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82FE21F2476A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C953249ED;
	Fri, 16 Feb 2024 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="AX393ypt"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E8C1F5F0;
	Fri, 16 Feb 2024 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078847; cv=none; b=Hrd/C11iHvHpd8tg4iz2NttkOAByrr0P4uHSUskR8nvfTtvVtjeFeMAW7uvOejs8s9zirsZiPbTbUND0nDLcwVWw2FvI890z7W9QBHwMFQOI2h/zDIfSz0sVfN+htr9aCHep7TaUD7fUDrGlxTx/IddF9JXacGIMf83A73SRgjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078847; c=relaxed/simple;
	bh=BPY8Q0Fuy+ZVui7wIHHsxpFY4u2pgVOODurhQIxaRYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QS8igAjZQyYN0TEmo8WQ7ZKSQ2oSwatgLyElVxmaq8VBkHKNZQ6Y4XDeHi3EGrVVNCYKsB8Hoc4LlOYmI1Y7Dyb509mpddzJgyg5IT+2KIXNVFl5X3Ls1ExF10PzZGSjg+q84xbODUHg8s/Ef3UWov1GFqrRsNxdrXmRzYAHpVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=AX393ypt; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:712b:6300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 6F548E24;
	Fri, 16 Feb 2024 02:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1708078838;
	bh=0elf/8DBFF9nD7HnEVv8mQ6pIMWx7HsQOmIWp2FVY/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AX393yptT4D1gnQTL0SLZpDFwTppZK18wmPWMfWUEguKzpArW7XJbW9RmHc7uDS3v
	 lSn7hSHxdHJVDHwQ2GW752BbF48UPsRnW215LappvaIN+6EqLREBTK2sY8cpdpfGk8
	 NTZIiTekG3ROb8sdELVBPNOYpons8lbxnHLAKzm8=
Date: Fri, 16 Feb 2024 02:20:37 -0800
From: Zev Weiss <zev@bewilderbeest.net>
To: Manojkiran Eda <manojkiran.eda@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, jk@codeconstruct.com.au,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
	Ryan Chen <ryan_chen@aspeedtech.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	openbmc@lists.ozlabs.org
Subject: Re: [PATCH] Add eSPI device driver (flash channel)
Message-ID: <f63c3077-f8cc-4f05-92ef-9b2303b181f4@hatter.bewilderbeest.net>
References: <20240213-espi_driver-v1-1-92741c812843@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240213-espi_driver-v1-1-92741c812843@gmail.com>

On Tue, Feb 13, 2024 at 06:36:08AM PST, Manojkiran Eda wrote:
>This patch adds the driver support for the eSPI controller of
>Aspeed 5/6th generation SoCs. This controller is a slave device
>communicating with a master over Enhanced Serial Peripheral
>Interface (eSPI).
>
>eSPI supports 4 channels, namely peripheral, virtual wire,
>out-of-band, and flash, and operates at max frequency of 66MHz.
>
>But at the moment, this patch set only supports the flash channel.
>
>Signed-off-by: Manojkiran Eda <manojkiran.eda@gmail.com>

Hi Manojkiran,

Glad to see this progressing again!  It sounds like there may still be 
some open questions regarding the approach, and as others have noted 
there are things included here that should be split out into separate 
patches.

I did try it out in its current form though, and encountered a few 
problems...

Firstly, the calls to dev_notice() all appear to be missing the struct 
device * as their first argument and hence don't compile (I hacked 
around this to get it to build).

Second, the device-tree updates only include aspeed-g6.dtsi, so I 
manually imported the corresponding aspeed-g5.dtsi change from the last 
version Chia-Wei posted [1] and used that for the AST2500 system I need 
eSPI support on.

[1] https://lore.kernel.org/linux-arm-kernel/20220516005412.4844-1-chiawei_wang@aspeedtech.com/

And finally, after making the above changes and running it I got the 
following during boot:

[    0.288079] aspeed-espi-ctrl 1e6ee000.espi-ctrl: something went wrong
[    0.288120] aspeed-espi-ctrl 1e6ee000.espi-ctrl: failed to allocate flash channel

I'm not sure if there's some change in this new version such that the 
dtsi patch I imported from the old one no longer works, but if nothing 
else it might at least suggest that the error messages could be made a 
bit more informative.


Thanks,
Zev


