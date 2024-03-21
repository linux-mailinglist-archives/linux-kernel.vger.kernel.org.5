Return-Path: <linux-kernel+bounces-110071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6392A8859A5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05E9282152
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B2284039;
	Thu, 21 Mar 2024 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bq3le8SH"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096EA83CC9;
	Thu, 21 Mar 2024 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026525; cv=none; b=faiHmwNhIwGJOZ1WfvwMPuSrXITQBSzA2QOpjzVsb0innOmi4BdS3htvZjjaFH4Gszw5otoSC5Ym7hhnCeuFlI3TvrgUCLkbRT9V0nwFaAZCeD55w4lBW0mQ8c3HSJE/u8/GJrSutpobPRBBpUmTwwqcYhb1c8BZTsCREXm98IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026525; c=relaxed/simple;
	bh=cG0asu/1nO7Dp23vefPYOO9+RR4qemdnjGRrIiAl7y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiI5W9VHWIiLew2ddf3Rf5lG58pTzCyiUFf8JVBbWV0BX9+GeIEURJT6axuH4xdompipR2QIQZgspaVc8ia9QYnITia7nxg0riF1gj1+L1kA/zkWS2P+yqD3WXs1gnQIx1fSJikT7Q5diOruY9h2TCKLL+XpzZowRE2lVrpcHMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bq3le8SH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PeWMjzv2TCP5O1EIfymN2AlFHQvzJcY+97La6mMNs54=; b=bq3le8SHCA9RGKtRjoQT80Yt+r
	GAIPSfvVky9RjIb3Jj6jCkxsr54sQBXpDnitSmwOcVhkDXEcZK7iXBPmTzELNxCtRU3Vna8xkgRzH
	VzC9PZx2c0580S3Ilj4czYH2iklxaE1QrI3ge/k08tld8peE+ZQy1PAa5ggPZ7Rv1NEnUXK9bNxX/
	ZpkNxepK5BDc6i0hD5OnbzzCwQn3UMPFIYJR2uNhCtYtNOhPACtZPiKqzywCz5Fp75hED7U6OkODN
	v3+FJbVe6G2ys8Z01T/dpSdLUaBrzBeQhu33cane2Z8qXzEP/ak8sBIFxtiPwDsTdilrD6PVtwRC9
	C1LYOZhg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42380)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rnI9R-0007a9-10;
	Thu, 21 Mar 2024 13:08:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rnI9K-0003fA-VJ; Thu, 21 Mar 2024 13:08:03 +0000
Date: Thu, 21 Mar 2024 13:08:02 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: David Laight <David.Laight@aculab.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	'Jiangfeng Xiao' <xiaojiangfeng@huawei.com>,
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
Message-ID: <ZfwxMuPflqlVyCDd@shell.armlinux.org.uk>
References: <1710906278-23851-1-git-send-email-xiaojiangfeng@huawei.com>
 <ZfqiD8Yw0oOVHW/p@shell.armlinux.org.uk>
 <84a57ca8-8963-ca24-8bd1-ddc5c33bf4da@huawei.com>
 <Zfs7sT6Pxy5yjnPC@shell.armlinux.org.uk>
 <bad25937-fc98-8e11-4279-ab6b3a727c1f@huawei.com>
 <bbcca1e205384cf0b42236e17f3969f7@AcuMS.aculab.com>
 <ZfwYx/8k8FVONg6+@shell.armlinux.org.uk>
 <db930076c837456f999daee5cb76735f@AcuMS.aculab.com>
 <ZfwmomjUwQdCefzh@shell.armlinux.org.uk>
 <0fd55e156195440bb1d815dd8300894b@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fd55e156195440bb1d815dd8300894b@AcuMS.aculab.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 21, 2024 at 12:57:07PM +0000, David Laight wrote:
> From: Russell King
> > Sent: 21 March 2024 12:23
> ...
> > > That might mean you can get the BL in the middle of a function
> > > but where the following instruction is for the 'no stack frame'
> > > side of the branch.
> > > That is very likely to break any stack offset calculations.
> > 
> > No it can't. At any one point in the function, the stack has to be in
> > a well defined state, so that access to local variables can work, and
> > also the stack can be correctly unwound. If there exists a point in
> > the function body which can be reached where the stack could be in two
> > different states, then the stack can't be restored to the parent
> > context.
> 
> Actually you can get there with a function that has a lot of args.
> So you can have:
> 	if (...) {
> 		push x
> 		bl func
> 		add %sp, #8
> 	}
> 	code;
> which is fine.

No you can't.... and that isn't even Arm code. Arm doesn't use %sp.
Moreover, that "bl" will stomp over the link register, meaning this
function can not return.

> But if 'func' is 'noreturn' then the 'add %sp, #8' can be discarded
> and then the saved LR is that of 'code' - but the stack offset is wrong.

If func is noreturn, then the remainder of that path isn't expected
to be executed, so anything that happens after the "bl" is irrelevant.

> A PC from LR will always be the next instruction.
> It is only the PC from a fault frame that is the current one.

That sentence makes no sense to me, as I don't think it's even proper
English, so I can't parse it.

> The unwinder probably need to be told which one it has.
> (Or add 4 the fault frame PC so that the unwinder can subtract
> 4 from it.)

That's basically what I said.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

