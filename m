Return-Path: <linux-kernel+bounces-167370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA848BA888
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D86F0B2286F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6E9148FE5;
	Fri,  3 May 2024 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Bv4NvW4y"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51132147C93;
	Fri,  3 May 2024 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714724289; cv=none; b=oFYSzIEWyi7VvACZuZ7Fl3CEQHawng7rq2EhbC6ViUcgQAB8QO6ja+BwZUsgxmtqL0r+3g11QixZGPkPpvHsvMdKaCXIIxNXOW1oDJmd4luDmS2gRBOLV8MnnvvnC/DEkKsZ1iJ84O0N086W+r+oYBn+9ueXEmF4WIyqB5hCBLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714724289; c=relaxed/simple;
	bh=9uV/YQYaIYkhtsqFzmacJ36qAQoDsqbw98wU0Hnm7Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ui/luqi3aihvnxVFYdsTARAa1165Q3pQmn3pMmHGacoH56MDKORqvaD9JN3tCUqtzvcM2xlNFAe8LqTiUKO+Tfpaa/OrDJrvtWhJeeHxkeNvtPU0LHrVI9mVBWhquQy1UswraG34e/HMfeNA1jYA0n3hfdyQObmVeRy460Dec9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Bv4NvW4y; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W3iNDIgZeC0CT9YGfChbAP1InEwQCyyLp0Q/9ORxGog=; b=Bv4NvW4yJxnojpffZMD7Y93hqq
	c+KY0MLlFgJLr5xBnZ20PwzpDoSnu1sw4W+TyQfBbyDQD/p2M33marUvfSHzCTChn7cv/Om22+PgH
	3LHfhMWpQAxwKAfza47b9Ae0xI0VhsgVubefySSzIJcmxcwJ7m+wldSPFbkkHLn1ZD+njQqLv0Sw7
	XIRCrJEsL+kEBSf6deBRuiwyPPnshgn+0abgYY65/Ir0XNCZKA+dzWqJ28bDZk5amCGUqkRJhVmc/
	7A86D+JbMeMI23CN9RqFPewb+T3pwQmI09RcOCQV+WPGOMeocHpZO7CkzHoj6ZxGiUOVBJPbb9N+I
	ljUEV2sw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33424)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s2o7E-00086P-1B;
	Fri, 03 May 2024 09:18:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s2o7E-0004Rk-Uz; Fri, 03 May 2024 09:18:00 +0100
Date: Fri, 3 May 2024 09:18:00 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the arm tree
Message-ID: <ZjSduO+MI7EA3O9A@shell.armlinux.org.uk>
References: <20240503101516.09f01e44@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503101516.09f01e44@canb.auug.org.au>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, May 03, 2024 at 10:15:16AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the arm tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> drivers/clk/clkdev.c: In function 'vclkdev_alloc':
> drivers/clk/clkdev.c:195:16: error: assignment to '__va_list_tag (*)[1]' from incompatible pointer type '__va_list_tag **' [-Werror=incompatible-pointer-types]
>   195 |         fmt.va = &ap;
>       |                ^
> cc1: all warnings being treated as errors

This builds perfectly fine for me - this is on debian stable with
arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 20210110:

  CC      drivers/clk/clkdev.o
  AR      drivers/clk/built-in.a
  AR      drivers/built-in.a
  AR      built-in.a
  AR      vmlinux.a
  LD      vmlinux.o
  OBJCOPY modules.builtin.modinfo
  GEN     modules.builtin
  MODPOST Module.symvers
  UPD     include/generated/utsversion.h
  CC      init/version-timestamp.o
  LD      .tmp_vmlinux.kallsyms1
  NM      .tmp_vmlinux.kallsyms1.syms
  KSYMS   .tmp_vmlinux.kallsyms1.S
  AS      .tmp_vmlinux.kallsyms1.S
  LD      .tmp_vmlinux.kallsyms2
  NM      .tmp_vmlinux.kallsyms2.syms
  KSYMS   .tmp_vmlinux.kallsyms2.S
  AS      .tmp_vmlinux.kallsyms2.S
  LD      vmlinux
  NM      System.map

No warnings, no errors.

va_format is defined as:

struct va_format {
        const char *fmt;
        va_list *va;
};

and what we have here is a "va_list ap".

Therefore, the assignment:

        fmt.va = &ap;

is correct.

What certainly won't work is:

	fmt.va = ap;

and there aren't any other reasonable alternatives.

My conclusion: your compiler is being stupid.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

