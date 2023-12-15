Return-Path: <linux-kernel+bounces-761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E63378145A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F231F21272
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCE520305;
	Fri, 15 Dec 2023 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cafjFKyD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414AE1C6A0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PdzJ9VKXcEMcAxxr2ZmlKGIqR30GIGVAEeo6WczzwHE=; b=cafjFKyD65fpUljF50IbMlPPBD
	zYHTsB18uaByJSgGN36pcrh0TQJW4bZUdDnVLBLONVhOOY5G7U/31yIWP3G6Sfn5LkoXP/i5qXdgt
	2ZbkW08qzDY9mir4UUsWAeemuy4NmVXnc6CAQMvNh1pPNb0+AO2Cd/0pm6ArvKkpLq6rxgr6Bfggc
	QUa1aDxu52kxRSYiiCC15T0l92SGTa+DeHpc3TB6tXlMpc8BFmI3OdyMNmR7W4ezaFp0ubTP2mOwt
	wyoosP+P71ZHL8qTh7OY26hgA2giapeAFcitbOt5qCAPWH7zv/iSl5WonKgq7Z3f5F3OnNXSwwcwB
	a80k7kSg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60024)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rE5UP-0002Vh-0X;
	Fri, 15 Dec 2023 10:32:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rE5UQ-0003WR-OS; Fri, 15 Dec 2023 10:32:18 +0000
Date: Fri, 15 Dec 2023 10:32:18 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Wang Jinchao <wangjinchao@xfusion.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stone.xulei@xfusion.com
Subject: Re: [PATCH] arm: remove duplicated include
Message-ID: <ZXwrMtFllyGLFl0Y@shell.armlinux.org.uk>
References: <202312151426+0800-wangjinchao@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312151426+0800-wangjinchao@xfusion.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Dec 15, 2023 at 02:27:23PM +0800, Wang Jinchao wrote:
> remove duplicated include
> 
> Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
> ---

These have been ignored in the past because although they seem correct,
they haven't ended up in my patch system. I guess I'm going to get asked
what that is, despite the link to it being in the footer of every email
I send... (please look at the footer of this email and follow the link!)

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

