Return-Path: <linux-kernel+bounces-110813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 336E088643F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9861B22210
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E89A59;
	Fri, 22 Mar 2024 00:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aXkMMI0j"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35735382;
	Fri, 22 Mar 2024 00:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711066179; cv=none; b=sLddYT33m/bE7xt6l01tdQ6c902zlQXa9IKCDB+n7y/FrBmF/TwFG4ybRiQCFzZjzh9b9CGDxEcxUrZOkPx8SUSAFByGa+blUPVCnwhGc3ppdr615kIvWa2AYDc3StsbT8k3r6qT5x/8uE6PwCI74E5vT6oSU+RXdyyV54LfMrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711066179; c=relaxed/simple;
	bh=SgBVhDiLkqvj5heInVCpMQ/vA9DTmHwhTXsUN08CHaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXrMb0Mb2Wc1Q3FO6QO0Fz2jxfmOPYxnT5YSX/4hMmMHmSjN4GTnB834sPHr/TyT1yS82ehSnxF2jh4s1+YDG+Zf6I2o6Dtg7L/3nU3247kwg2WGePzC4NdvxVUogjrEgEmqPpkZsPk6esHdZFSY5PHUO7RkXMjxmA7+Lvoo8sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aXkMMI0j; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2moEpAismjcawN+PGW1bmLh6TrJn1P653kp5rgnCLkg=; b=aXkMMI0ja+5UEUhZLzxrAJrkpo
	OggZC2nCb+f2Fc6/hgyq/dQ94GWFA01LJDDP2/qY/PfR0cOEEIRO7rDEZOR4X/evTYWr484x/xhO3
	47CbPRUUvktN9l7IXCMsnWhcklfjWOYuw0E9d92IWt5TWXUCJkQDKh03JS9U77CcNYcMHVghXmFFu
	2t4mOBimVFjY+Dib9ePoRuVpnTqqQ61NKl5z1snJ7I9je9VFA/RF6dHv7EuRNfac5ZN52xWm/ySPu
	Nb6YpH4MMb2hjDYG5OrQtutMpquZ7gmQOTxdeOUBXqEoAoqtZcYcCC66Uvr72DpXZJUlgnF69G1wf
	Ybls5MUA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44658)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rnST0-0008AS-2e;
	Fri, 22 Mar 2024 00:09:02 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rnSSs-00049Z-Vr; Fri, 22 Mar 2024 00:08:55 +0000
Date: Fri, 22 Mar 2024 00:08:54 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: David Laight <David.Laight@aculab.com>,
	Jiangfeng Xiao <xiaojiangfeng@huawei.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"haibo.li@mediatek.com" <haibo.li@mediatek.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	"amergnat@baylibre.com" <amergnat@baylibre.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"douzhaolei@huawei.com" <douzhaolei@huawei.com>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"kepler.chenxin@huawei.com" <kepler.chenxin@huawei.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"nixiaoming@huawei.com" <nixiaoming@huawei.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"wangbing6@huawei.com" <wangbing6@huawei.com>,
	"wangfangpeng1@huawei.com" <wangfangpeng1@huawei.com>,
	"jannh@google.com" <jannh@google.com>,
	"willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH v2] ARM: unwind: improve unwinders for noreturn case
Message-ID: <ZfzMFv3zmYY36l9u@shell.armlinux.org.uk>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <1710906278-23851-1-git-send-email-xiaojiangfeng@huawei.com>
 <ZfqiD8Yw0oOVHW/p@shell.armlinux.org.uk>
 <84a57ca8-8963-ca24-8bd1-ddc5c33bf4da@huawei.com>
 <Zfs7sT6Pxy5yjnPC@shell.armlinux.org.uk>
 <bad25937-fc98-8e11-4279-ab6b3a727c1f@huawei.com>
 <bbcca1e205384cf0b42236e17f3969f7@AcuMS.aculab.com>
 <ZfwYx/8k8FVONg6+@shell.armlinux.org.uk>
 <CAMj1kXG2EGvgGuV-K7h5qDVJeLMd5hkq8GzigzCRzh9Z8cgyWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXG2EGvgGuV-K7h5qDVJeLMd5hkq8GzigzCRzh9Z8cgyWw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 21, 2024 at 11:43:41PM +0100, Ard Biesheuvel wrote:
> Given that this particular issue would just disappear if the compiler
> would just insert a BRK after the BL, I'd prefer to explore first
> whether we can get this fixed on the compiler side.

Arm32 doesn't have a BRK instruction. What would be appropriate after
the no-return BL would be OS specific.

Maybe a branch to "abort" would be a good idea though.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

