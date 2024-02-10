Return-Path: <linux-kernel+bounces-60362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FEF8503F2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 11:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E662B21A53
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 10:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D3736B09;
	Sat, 10 Feb 2024 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="T/mPfRyu"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D64A364C7;
	Sat, 10 Feb 2024 10:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707561012; cv=none; b=Pb8Q2Am0ajIhxHtP2n1qR7edDka+jD0SvelBANk9GhRlvClzlIdx38G2wQAdQUJLlwYS+Z4rfTh6gsWfpeP5YY5lyMzC1nL61o3iZc0KXemV4q3noqpMs7V5gnf1npLBhOkx8EZ9AjvPltUGi86/Zr34URnS03ihGlrDcQc5y58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707561012; c=relaxed/simple;
	bh=A3ud78No7kD0Dn1wHTcneyRE+SVmCuqOLRHwIx5bJeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDryS4xgtan2kzS2fIDZCadmK9a1YmfXa9Aaxam26VNC6fVf1zo5TsUOpSurzr9Adv2YmXMWAxpxNfqZpPahxw+kLlJtwkVVg962D1bm61ITmnlISAEAGLss7MXc3ZDqJljn2Rci3AEPOUpMcwTgelv8BssCiSPIV8AgWwlBDjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=T/mPfRyu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ph4jzB86nHaGBdGyQlHwPpxZccThyM3+Io4W8gZIxGI=; b=T/mPfRyuRFUl8GCt02nw5hF8m8
	Awp1djpMFwBhecelf0XDJm5aDEs/HFqx7756B0bVepr/IJfGnj/mDwY2ntorwNMhuX7PNwkVwgiOs
	Vo0wg1FUKUe1QsAW95tmiDTM0/WP/VecHW4kPFzjiebWPfx/akDPQAN9lTy2Xp/2xXX+IbY8KnVwk
	MgbJRMZIRSjH+kI3aucCRbMHAnW4kOdZf765ego1yIRs35nz7bEpVbQLqzKKnVgwsNeRfkoMwTEpr
	nQVW3vHN/FJOwHxxSdheb5jdA9FltDBf0iVdtYybDa44bHMN/9CrHW6PvlCMexy63eQf+bCpkOJr8
	eiPfQRGA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38040)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rYkbe-0006qq-0m;
	Sat, 10 Feb 2024 10:29:10 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rYkbU-0007Ja-Ln; Sat, 10 Feb 2024 10:29:00 +0000
Date: Sat, 10 Feb 2024 10:29:00 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Zhang Bingwu <xtex@envs.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Zhang Bingwu <xtexchooser@duck.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: Re: [PATCH 1/2] kbuild: Abort make on install failures
Message-ID: <ZcdP7CC+OMbp5ZMi@shell.armlinux.org.uk>
References: <20240210074601.5363-1-xtex@envs.net>
 <20240210074601.5363-2-xtex@envs.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210074601.5363-2-xtex@envs.net>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Feb 10, 2024 at 03:46:00PM +0800, Zhang Bingwu wrote:
> From: Zhang Bingwu <xtexchooser@duck.com>
> 
> Setting '-e' flag tells shells to exit with error exit code immediately
> after any of commands fails, and causes make(1) to regard recipes as
> failed.
> 
> Before this, make will still continue to succeed even after the
> installation failed, for example, for insufficient permission or
> directory does not exist.
> 
> Signed-off-by: Zhang Bingwu <xtexchooser@duck.com>
> ---
>  arch/arm/boot/install.sh   | 2 ++
>  arch/arm64/boot/install.sh | 2 ++
>  arch/m68k/install.sh       | 2 ++
>  arch/nios2/boot/install.sh | 2 ++
>  arch/parisc/install.sh     | 2 ++
>  arch/riscv/boot/install.sh | 2 ++
>  arch/s390/boot/install.sh  | 2 ++
>  arch/sparc/boot/install.sh | 2 ++
>  arch/x86/boot/install.sh   | 2 ++
>  9 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/install.sh b/arch/arm/boot/install.sh
> index 9ec11fac7d8d..34e2c6e31fd1 100755
> --- a/arch/arm/boot/install.sh
> +++ b/arch/arm/boot/install.sh
> @@ -17,6 +17,8 @@
>  #   $3 - kernel map file
>  #   $4 - default install path (blank if root directory)
>  
> +set -e
> +

What about #!/bin/sh -e on the first line, which is the more normal way
to do this for an entire script?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

