Return-Path: <linux-kernel+bounces-29627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A658310F2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C60591F22298
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15679211C;
	Thu, 18 Jan 2024 01:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMPbQ4QB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570BB184C;
	Thu, 18 Jan 2024 01:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705541778; cv=none; b=Cmrxf6s44J+u9YiP4EgO1KSizZifrCZW7FKfbDqf1ete2hgE+czU67X0EdPIdn67OggIvytUXH3NjlrWaJl7bgRknlpvFRMirdt6WBSll+qH5fqwUddlocjufipyE93POlGByZ98dhAJU7R1gUkqZvGnAoamNEOjHtTb5mp/8Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705541778; c=relaxed/simple;
	bh=dqmuqll1E/XB+FTIA41WLVNPWxX4UcULZbNBRCEeHms=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=MamoQ3BB9HlcYs2+NCOTPLb9XjpMeTkelcjiFmoKUZExWVZYDwO50XD81dwlV91m7oOLfUAQnrGxm/xeFnZmnIl8laOuoStSsdl2Whb6KRZgIEaW4+8ZcuChV6RJ5ThEOIWbzHL2AX8FZhE07G8Wfnp5dKYJoQy8Cj8nX/WBTNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMPbQ4QB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5C5C433C7;
	Thu, 18 Jan 2024 01:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705541777;
	bh=dqmuqll1E/XB+FTIA41WLVNPWxX4UcULZbNBRCEeHms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JMPbQ4QBvedDBnOLYxCVQzJ1uTA8pqMKc1YYjsan+ZqHDrA6wqsOQRJERzOgwpxZK
	 HAqBa/ALWwsudxy1027KtBP9bRDl+jCqEyzQjkcpV6390+adnHyQFHoMPNW6IxXJtW
	 o2qwoVGMxYmeXkGqdFQVowhw9CHyLaA8FYy5Qeo5aJWBbEnfrS/YLqLIoOnkHal5sm
	 D90KmV+52N4L/3xrejKC2gDZR6WnZqixOdKQGZbdU5CO1QUIN7FNDXufpW6H/16LN2
	 cM9E/SdtYFnJBBx57Tedkx8boi1Dr6SX52WF7v56JhlXuYqAHb1IxmbEk+khyJzCP8
	 AT1zzzoTTR2dA==
Date: Thu, 18 Jan 2024 09:23:24 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Chao Wei <chao.wei@sophgo.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 0/2] riscv: sophgo: add pinctrl support for cv1800b
Message-ID: <Zah9jO4Y/+MnFr/c@xhacker>
References: <20231113005702.2467-1-jszhang@kernel.org>
 <MA0P287MB28221065B41ABE67768B98DEFE722@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MA0P287MB28221065B41ABE67768B98DEFE722@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>

On Wed, Jan 17, 2024 at 05:03:20PM +0800, Chen Wang wrote:
> 
> On 2023/11/13 8:57, Jisheng Zhang wrote:
> > This series adds pinctrl support for cv1800b reusing the
> > pinctrl-single driver.
> > 
> > Jisheng Zhang (2):
> >    riscv: dts: cv1800b: add pinctrl node for cv1800b
> >    riscv: dts: sophgo: set pinctrl for uart0
> > 
> >   arch/riscv/boot/dts/sophgo/cv-pinctrl.h       | 19 +++++++++++++++++++
> >   .../boot/dts/sophgo/cv1800b-milkv-duo.dts     | 11 +++++++++++
> >   arch/riscv/boot/dts/sophgo/cv1800b.dtsi       | 10 ++++++++++
> >   3 files changed, 40 insertions(+)
> >   create mode 100644 arch/riscv/boot/dts/sophgo/cv-pinctrl.h
> 
> One question, when we use "pinctrl-single" driver, should we enable
> CONFIG_PINCTRL_SINGLE? Or just leave it to package vendor to configure by

It's better to enable PINCTRL_SINGLE in defconfig. However, per recently
pin related xls from milkv github repo, pinctrl-single isn't suitable.

