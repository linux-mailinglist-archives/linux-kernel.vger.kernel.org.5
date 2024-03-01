Return-Path: <linux-kernel+bounces-89202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A5486EBEA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7B1283523
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BE95E3AF;
	Fri,  1 Mar 2024 22:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="21WBm76q"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4345915D;
	Fri,  1 Mar 2024 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709332598; cv=none; b=chTpoixD9OQ3RtfPX3KNVgiowsmtodqcSBOTNbo9itQnpImLFod5gVxKRm5mg65Al+hNNQGBpVOPCyFJzCnMyP+WFOKpCRqKDJfkeDK+9GVQ8JP1OnOmCJoAdyvHV0l1XY9N2XkB9PjcVPSBF7RT7rk0acrkS7eggtd+php+2lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709332598; c=relaxed/simple;
	bh=YVqKyfzAKGmkSmL4KKBl0+G1eWM96JH+Sd4gxQKLKeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kz368tu8o28XWqOaPKQXyThcDVfejAyWUou8LhNI/4KbxBpYvBy/4v/jcbF9S5FDRwh2O19jMV+ouZ+kXvKdFa1jJ3FgV8XuGtYKuuOrCSn6Fy/8kKzbnjhAgtqMFxmNlT5H1Jb69STmILoXpU6dyUHHzOiPqmAstp2neXb60r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=21WBm76q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PG+oytNfd+recud757xU3maYgbs21CX5ihLnnh8yEe4=; b=21WBm76qNLnnqHkiK9DvL5yQQP
	j2XVibxgLKK7bA7jYmasBOqXHLyhy48eOeqq3bxYRJQtQjtBfyCyvk0rhL10gVC59K2aAZQP0kRL6
	vQyU0rxXYYBnDLOjmNoYJBftYXJ+tNsO6AvLkQVDq3VYtHJEpC4skyOd/GsCtGrx+v2g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rgBUf-009B2N-CJ; Fri, 01 Mar 2024 23:36:41 +0100
Date: Fri, 1 Mar 2024 23:36:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
Cc: joel@jms.id.au, andrew@aj.id.au, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
	robh+dt@kernel.org
Subject: Re: [PATCH v2 1/1] ARM:dts:aspeed: Initial device tree for AMD Onyx
 Platform
Message-ID: <c8686f40-e6e9-4652-b450-217de604b216@lunn.ch>
References: <20240301222257.3309541-1-supreeth.venkatesh@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301222257.3309541-1-supreeth.venkatesh@amd.com>

> +&mdio0 {
> +	status = "okay";
> +	ethphy0: ethernet-phy@0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0>;
> +	};
> +};
> +
> +&mac3 {
> +	status = "okay";
> +	phy-mode = "rgmii";
> +	phy-handle = <&ethphy0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii4_default>;
> +};

That looks odd. Where are the RGMII delays coming from? Normally its
"rgmii-id", which asks the PHY to insert the delays.

	Andrew

