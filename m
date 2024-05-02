Return-Path: <linux-kernel+bounces-166071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12698B958B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08E3CB21E57
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424BF3EA76;
	Thu,  2 May 2024 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dYnqEXt1"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47112225AE;
	Thu,  2 May 2024 07:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636067; cv=none; b=fLgo8aNdKYISMXbRT+TrrSLojKIjh//w4rg87PPJr4U7ekfDgJ2MfKBtqKbWby/TVYnIZpw9NhwKIGtY+pFwm5muB8J0dsnDLoW3Th7xq5+Ror53ZeeYVK6nuq7lkxZeVWMWvHGYd78WJWRarjyVK5US80o2j3ndBLIFj0JpeZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636067; c=relaxed/simple;
	bh=tAkFuTt9zkG5ZBtL1Yv3248sv5gx/vvbNt8665mwxgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5H1FsYrZ7eYW2tXMmbySZ3KYydHDcWHC5GtBtgpLm42qOJfRkGoZOY/u+1fDkGeigJrkrNtfCIHcwsYRx9HBHpRPfjHSZs7yNqvzycbr9rZyIIX8c+jVe1HlU2c2lY13Gy689B6Fp5FnP66uYjufwjmGh+dDpTnbvvU7tGOXjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dYnqEXt1; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A4183FF80E;
	Thu,  2 May 2024 07:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714636063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vhXtmRv3kbKgnYd6PjMU3UqcLb0WMxLPFCLc04cLDYY=;
	b=dYnqEXt1YNKWgJZAg//9nAueSIXvkhnkrzXNziy64VRfhQRLC4LLmXKNJ4iTNKZgj+i1Ah
	GxjzyWJOQgMIy+NoiuBXRUz/FinD3VEmbMP5Z/Q/M5uGVP3mca94UcphgiPCz3T0yjdL1a
	/W78laTzvdpKnxmPkJwowz2Q70RJ/C8FsTQEXQz/9LDl7OdKXK2K2FSgs9caAGMDdWvhPE
	b6fy+SDXjwjtje5h+OOURmG8bnRzGBXBawFIGd4Vn+/tSVbRaO10S+L5rKiaC6VGEi7RkQ
	WRWQJnXnWYuMjK0NXPYUxzpaeGZVefX4Xfy2HRoKUEZ1NcqidPJ9TgxYgIaYnw==
Message-ID: <1444dac5-c725-4bf7-8843-469a62c3abf1@bootlin.com>
Date: Thu, 2 May 2024 09:47:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 4/4] riscv: dts: thead: Add clock to TH1520 mmc
 controllers
To: Drew Fustini <dfustini@tenstorrent.com>,
 Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>, Yangtao Li <frank.li@vivo.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240426-th1520-clk-v2-v2-0-96b829e6fcee@tenstorrent.com>
 <20240426-th1520-clk-v2-v2-4-96b829e6fcee@tenstorrent.com>
Content-Language: en-US
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
In-Reply-To: <20240426-th1520-clk-v2-v2-4-96b829e6fcee@tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.bonnefille@bootlin.com



On 4/27/24 2:10 AM, Drew Fustini wrote:
> Change the clock property in the T-Head TH1520 mmc controller nodes to a
> real clock provided by the AP_SUBSYS clock driver.
> 
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>

I experienced that, when the I2C clocks were correctly configured, the 
UART stopped working, likely due to their dependence on FOUTPOSTDIV.
Setting up the UART correctly, for instance:

                 uartx: serial@xxxxxxxxxx {
			...
                         clocks = <&clk CLK_UART_SCLK>, <&clk 
CLK_UARTX_PCLK>;
                         clock-names = "baudclk", "apb_pclk";
                         ...
			status = "disabled";
                 };
resolved the issue.
As this would be mandatory in the future, I suggest that you configure 
all the nodes currently set to a fixed clock, not just the MMC controller.

Thomas

