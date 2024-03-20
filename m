Return-Path: <linux-kernel+bounces-109363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88213881812
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290DD1F23118
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3669E85922;
	Wed, 20 Mar 2024 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zwIOU/N2"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF5953E2C;
	Wed, 20 Mar 2024 19:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963784; cv=none; b=GxmdADSO5fs00iitlY17FCkd2Q0a5edXMzc8KIpnn4CcNEJDdP6koJQdm+X0LuwyFjfqC3+J8Itd8blQg+eN1AN1dv1OTYMlyUPlOZZOFXy44jGY+TC2hTqQrancoJJM2qD8Ei3GqhuAafMY0rVYDVROCdDebIFGn/CAEJdI9Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963784; c=relaxed/simple;
	bh=MDKqTwIIurD45hwLmu/lsiu5Ez8SLeE3iiSVsv+IrC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLajqpSN8IJa4a74OixMr/LBTPjPBm176y9EuLGSsQYIpDSSFXKTpGWEpQi0tQh5AYTVoJp7q6fcYB1HbDXEyVCHhe0XfVbx/BXvPv/pxWFAxLweXrDXfT3SL5uXNVpHfKmsEEEWx8o8c5FO0l4KH60etIjppOupD1hmUDaZwlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zwIOU/N2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JpvMIN5sLRmpewvvELoDaUedbJXpt4XMYlW/TmEfGUQ=; b=zwIOU/N2ME1TIeKU9BmL5bQgzW
	pnW2dx0WfF9yZeI84CfZ/Qdfz/bLGlrK+DxOUcGoWkfbrkHOKnJt9X46vVCPhpu+LnwG7/K01nBrb
	0kEQGUrq9MZgohrf9pmDfLcAslQCwZMR9ehetlAJIrIpvb+wIfYlL743kA4vzPASsblIlF57F64XL
	rUCvoxS0GJbvSTW6ED3BpDsKIwaSGSJv57XNtTlB0Yce6SMKN58fZVlwnTafh3I0I/s1INk74AV1k
	mwbNIyd6OB7oKHs2jQtl3mkbbuDytE+O5gowXIRpgk1YdwEGdUzq1/dP9jnUD6RMYPH6e/MabCDB5
	sWd9CfJA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35138)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rn1pm-0006qG-0E;
	Wed, 20 Mar 2024 19:42:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rn1pk-0002w4-Le; Wed, 20 Mar 2024 19:42:44 +0000
Date: Wed, 20 Mar 2024 19:42:44 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Cc: linus.walleij@linaro.org, arnd@arndb.de, keescook@chromium.org,
	haibo.li@mediatek.com, angelogioacchino.delregno@collabora.com,
	amergnat@baylibre.com, akpm@linux-foundation.org,
	dave.hansen@linux.intel.com, douzhaolei@huawei.com,
	gustavoars@kernel.org, jpoimboe@kernel.org,
	kepler.chenxin@huawei.com, kirill.shutemov@linux.intel.com,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	nixiaoming@huawei.com, peterz@infradead.org, wangbing6@huawei.com,
	wangfangpeng1@huawei.com, jannh@google.com, willy@infradead.org,
	David.Laight@aculab.com
Subject: Re: [PATCH v3] ARM: unwind: improve unwinders for noreturn case
Message-ID: <Zfs8NNlAwF3+LYZ/@shell.armlinux.org.uk>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <1710949294-29287-1-git-send-email-xiaojiangfeng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1710949294-29287-1-git-send-email-xiaojiangfeng@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 20, 2024 at 11:41:34PM +0800, Jiangfeng Xiao wrote:
> This is an off-by-one bug which is common in unwinders,
> due to the fact that the address on the stack points
> to the return address rather than the call address.
> 
> So, for example, when the last instruction of a function
> is a function call (e.g., to a noreturn function), it can
> cause the unwinder to incorrectly try to unwind from
> the function after the callee.
> 
> foo:
> ...
>     bl      bar
> ... end of function and thus next function ...
> 
> which results in LR pointing into the next function.
> 
> Fixed this by subtracting 1 from frmae->pc in the call frame
> like ORC on x86 does.
> 
> Refer to the unwind_next_frame function in the unwind_orc.c

This came in while I was still replying to your previous reply, so
I'm going to ignore this. Please allow at least 24 hours between
postings, and please allow discussion to finish before posting a
new version - give your reviewers adequate time to compose a reply
bearing in mind that timezones might get in the way, but also making
supper (as is the case in this instance) may cause several hour delay
in reply.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

