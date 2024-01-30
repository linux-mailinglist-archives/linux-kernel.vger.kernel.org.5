Return-Path: <linux-kernel+bounces-43694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6B28417D5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB0851F2525F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D722CCD5;
	Tue, 30 Jan 2024 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Qc984naj"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862221E486;
	Tue, 30 Jan 2024 00:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706575817; cv=none; b=mDnu31J5IdIu92PI+LFNYgG8+tbAj13mMjrj+1iQ7DQQIIkYpqyL6+RlEh3lTBdETk5sAoEakQ/UulyFfTZaPfXDTJDnmWp422inzEICfpVarRkcgHOkOBLidzCwVGQO2izZsMK/Zt+rPiy6XCOV9zkAYiLsjVrN6jziY7HaDCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706575817; c=relaxed/simple;
	bh=ThPkbKmqHHdUcXpBDNoCdKALP+40lPN8itv/9IFf1WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEGYtTguOsQTgfEwzFU6a8XKMYML3tyHnuZ0CiZkCXqJCIjUtTJ527ZzVQp961lUyYt5AaI0AaQq8XJV0shTS4VoeoeE5PJuZqjqdfWc//zyd+WEPB6yPTyNeWY36NdkG851j+wf3EHNhU+t/Ig6pNwi16z0gVFdhZ53Sw0xrKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Qc984naj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UNuOAh732Iz0sCuy9DmPJv186mEKEDafoVURB8T3cQc=; b=Qc984najjcqfo0JWw68P1PLvrp
	wJ0HiNGM4vaqULIRinZmMfyw3CrZ+1VU4/YqOx4khgKlNePFsLve4IWxr/X6zZWgHtRutlDcZtmpW
	eGq4IjaHfX5DB21/zERw6d5GF8ZhKXpB/QFBTprZOm+MCRnYYbrfpaTLWE+LSrMPIFjs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rUcK2-006Qn7-78; Tue, 30 Jan 2024 01:49:54 +0100
Date: Tue, 30 Jan 2024 01:49:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jie Luo <quic_luoj@quicinc.com>
Subject: Re: [net-next PATCH v2 1/3] dt-bindings: net: ipq4019-mdio: document
 now supported clock-frequency
Message-ID: <200e67aa-85e4-4d9d-85c7-725d3c2d8157@lunn.ch>
References: <20240130003546.1546-1-ansuelsmth@gmail.com>
 <20240130003546.1546-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130003546.1546-2-ansuelsmth@gmail.com>

On Tue, Jan 30, 2024 at 01:35:20AM +0100, Christian Marangi wrote:
> Document support for clock-frequency and add details on why this
> property is needed and what values are supported.
> 
> >From internal documentation, while other values are supported, the
> correct function of the MDIO bus is not assured hence add only the
> suggested supported values to the property enum.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

