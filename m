Return-Path: <linux-kernel+bounces-90637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DCB870292
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0EACB257ED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7284A3D972;
	Mon,  4 Mar 2024 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EszN5Bhl"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA1C3D55E;
	Mon,  4 Mar 2024 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558626; cv=none; b=fI+JV2IkAjvuackurYXP0LT+fTYc+SvrzyZK9XSX3sYbXd0J1gmp9mJLV2xpBhqtfiEyNCebbK+N21l6n+6fmT4o2aTQhZXbKRmIMU0GsHvccWEiMjBlJVjYXBleAaL4Nfi6Z+nYe/gRMyUk08Wn49uJed+KhczE/DIgyOvlcF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558626; c=relaxed/simple;
	bh=YsyDulOzSzx19ZpeWD5p9gxvh32LjG6ZWdvbYa2ooAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSDOjiKADQdgEW8Vog4LTe3gvMZaG+dksk/o2DHHBE+2YCjq02htpO6qIsJeMqSPy2OXpMYn1L7TkjpZA7Y/Pu/vzUMuLT36vPX7OirIPgcLniQpAMWk6GzK0qtXEPU3O0CbSrNxO2JdTwSpnqH0sGZKGuZa62EwHX2F0+n4vnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EszN5Bhl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1CZLYbfZD2uFt0DlBr8muQhEVQXSLcxTpka04YzR95c=; b=EszN5BhlkHgHWqGTCQdqNI4TxO
	Uv67t+hBg3BhPkaFjwRro/2sCKqvWKosw+B9bI8cjiUYhPaN/h+isbKXkjYBqnDXfROyrE8QCnXS4
	nASPiAGYIYG2C7gtyFsxMNwHVvu03d4ruR77xFf7H0ZYXNBMaCKL37k/KKVYA95AxLX8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rh8IT-009KDq-Qh; Mon, 04 Mar 2024 14:24:01 +0100
Date: Mon, 4 Mar 2024 14:24:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	wojciech.drewek@intel.com, arun.ramadoss@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v3 1/2] net: phy: micrel: lan8814 led errata
Message-ID: <bc298c9b-95f2-4d54-bf0c-d1e257c9d172@lunn.ch>
References: <20240304091548.1386022-1-horatiu.vultur@microchip.com>
 <20240304091548.1386022-2-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304091548.1386022-2-horatiu.vultur@microchip.com>

On Mon, Mar 04, 2024 at 10:15:47AM +0100, Horatiu Vultur wrote:
> Lan8814 phy led behavior is not correct. It was noticed that the led
> still remains ON when the cable is unplugged while there was traffic
> passing at that time.
> 
> The fix consists in clearing bit 10 of register 0x38, in this way the
> led behaviour is correct and gets OFF when there is no link.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

