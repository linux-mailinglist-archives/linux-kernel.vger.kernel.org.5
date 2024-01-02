Return-Path: <linux-kernel+bounces-14321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA033821B51
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6120E2826E8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69024EED0;
	Tue,  2 Jan 2024 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KAUdcJ8O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA505EADD;
	Tue,  2 Jan 2024 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TrldZaqicdY+eHDcrmmjpA/9Owv7+FTLRDqnX9I0EAI=; b=KAUdcJ8OGnhDITYlgY3qOzn2tv
	d8wrtp2vVCjvKwTTjSSMZrdyfhQUc0my67GlgtSMpe0VBeJmXUGyOxeOvKXP5qjbq+g+x2P50rlQT
	3hAl6vW6imBt7w71wntPvKCCTIwDsRcVjh2ZttFQH2rvzUg+6aN+DyeTt/vaGetwUN+3s4Kszfl4m
	1NtEz8TVzFbgXEx1ES1SJ1zwhFHGmkKEKHxl4UfQktwPkkNjcAydU4IdkfyTN+ovO6jZqMbb0SD1E
	9O7YdMtBQ09L+La9cI+iC/RpRzcqt4qCVgqBWsXsjlnDBH2sxUUbXKkJT2mSoo1lBKBarUA80Y7T5
	VWTOFnfw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42138)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKdU4-0006W6-0J;
	Tue, 02 Jan 2024 12:03:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKdU6-0005Gj-BO; Tue, 02 Jan 2024 12:03:02 +0000
Date: Tue, 2 Jan 2024 12:03:02 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andriy.shevchenko@linux.intel.com, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Subject: Re: [net-next: PATCH] net: mvpp2: initialize port fwnode pointer
Message-ID: <ZZP7djOPhOf0+TaV@shell.armlinux.org.uk>
References: <20231231122019.123344-1-marcin.s.wojtas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231231122019.123344-1-marcin.s.wojtas@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Dec 31, 2023 at 12:20:19PM +0000, Marcin Wojtas wrote:
> Update the port's device structure also with its fwnode pointer
> with a recommended device_set_node() helper routine.
> 
> Signed-off-by: Marcin Wojtas <marcin.s.wojtas@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

