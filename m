Return-Path: <linux-kernel+bounces-83600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041E7869C73
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A424B286B3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCCC149DE7;
	Tue, 27 Feb 2024 16:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FNRfL+9U"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18FB148300;
	Tue, 27 Feb 2024 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051298; cv=none; b=adqVTe2OF4WQP9WkAwQhKZ5KhW0zbm2U8230rXEdU/R/hB63JQj/TMCS/6CfxHPLt3gNmjwmw8EtyauA8fdUCSTpxa+/4jA8zBXgExVogbxzfA3mSp+ayfnqbY7uaubw0xkwbXr82C1y0BDcw5iMzBsNYw8zDpIw84oUT4lqsn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051298; c=relaxed/simple;
	bh=zBoRncRpaabg/PphISSG21C84uO5bjeWeT18G6pOYKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvCvLblF8Ni5w0hRxmXZaBWhRzaKLhbkbWREN+dFk2BfdEgzwCxPcKSwDkPUTbr63VHnkkelv6mWOFI2Hmgk2+RCUc8JiOYyQxLALnVCRog5zTmjJBF3WiXAKlUtj0LW+ahK/57+cxVikynlUOxm4Yz7Nx0CSf4nwsBwD/GVxdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FNRfL+9U; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ieaqldWYxlts8vxb1oirRiS9OuCsnlGmA+e1W7mof58=; b=FNRfL+9UCjzORcduefVPxbH4Zp
	mAgLGcE0Gz4hkr4nWBKxWYtIgwbszvE1/Q1mR+pSTZMTIdnI0077bhHaP/vWk5ojJ8W5VIxgxPxjq
	UDtOqr8DMn0PKTSxpryfZqw7IwmVuHF7TKC/NK+054c/s3EjmbNMp3Jaax5u3IG2EfBRwb4omu91c
	0BdLh6R+LtdhQOnuwwNK3I0i3nGWlJbTzdTLi9JiSRx6b/u0+NbJ7o/J40upfEXE0nxRCPLq2ruNV
	BcGapW0kpYiC0pZOcyIZdPDdOpqHiHTGnXOo3dIj5C/pMeBfem8dpixeQ3mHVKBYkrip+u3w9EHDO
	QVzgxMRQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50536)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rf0JN-0000eA-1d;
	Tue, 27 Feb 2024 16:28:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rf0JM-0007Wi-JB; Tue, 27 Feb 2024 16:28:08 +0000
Date: Tue, 27 Feb 2024 16:28:08 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Robert Marko <robimarko@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, andersson@kernel.org,
	konrad.dybcio@linaro.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	ansuelsmth@gmail.com
Subject: Re: [PATCH net-next 1/2] net: phy: qcom: qca808x: add helper for
 checking for 1G only model
Message-ID: <Zd4NmB/RLRXFDpjh@shell.armlinux.org.uk>
References: <20240227162030.2728618-1-robimarko@gmail.com>
 <20240227162030.2728618-2-robimarko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227162030.2728618-2-robimarko@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 27, 2024 at 05:19:28PM +0100, Robert Marko wrote:
> +	if (QCA808X_PHY_CHIP_TYPE_1G & ret)
> +		return true;
> +	else
> +		return false;

	return !!(QCA808X_PHY_CHIP_TYPE_1G & ret);

is a shorter way to write that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

