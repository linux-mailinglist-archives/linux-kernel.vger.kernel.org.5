Return-Path: <linux-kernel+bounces-126762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1543893C62
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2A32827E9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B830144C89;
	Mon,  1 Apr 2024 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CSMXS/oX"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81306446B4;
	Mon,  1 Apr 2024 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711983202; cv=none; b=FuG+LAKnqxwiDmHyTc9S4r6wCPmU6AfIlpsTT+5iq41JkWFXtmbg+n1c4o5Zvb/iQLUpRZSTU3NnWp8ZMVk2DSmlX/lSFLSlv3Ane4mjcfuB4+2I82o628Zc0KHC/CYv2+gL4lj/Zcv573eVY9BE/WN+z2sCQiOZF/IGJTLk9/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711983202; c=relaxed/simple;
	bh=yloUbEiMF310IOcwHWkZeGYQdWnRad/t8yaPC4hBQco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHC4bbqAMX7nbAkhEzhCNhQktLK6ACCwIDMX7LY7D5F1G5GdljaYhQvzkbT00IVu70+XwMuZwHZDdUtz9ANfsk9vcJ0mEk4cccDtKxE9irkW+EVmSyfgVFcerRYkPPRPdyU62fqwunBA33IYICpZffDpnMbpk6ZXDLwtOE1k88Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CSMXS/oX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SUYqqJRgXGf9mQerq1K5Az97AxxYJNUyDS5cN1Mc7Vs=; b=CSMXS/oXFaI/OUAWuuyMHfmdXM
	dCJDxRC72tUGrABO58Edyb72+pXPCvWeyAqRLnH2ePn9mGerVyyxWG9dlvtd8vLxkpFqu3WTfWGht
	rC0vBwnxtzJjSXDCLxRPyORwlsAndOkb2WMYsPfib+hfrwBLTPngWq+xY3FVTFU4hfPQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rrJ2A-00BrcD-H9; Mon, 01 Apr 2024 16:53:14 +0200
Date: Mon, 1 Apr 2024 16:53:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] arm64: dts: marvell: cn9130-crb: drop unneeded
 "status"
Message-ID: <a74a10bc-19f3-489a-962d-dcf483c53bd2@lunn.ch>
References: <20240401141051.98233-1-krzk@kernel.org>
 <20240401141051.98233-6-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401141051.98233-6-krzk@kernel.org>

On Mon, Apr 01, 2024 at 04:10:51PM +0200, Krzysztof Kozlowski wrote:
> Devices are enabled by default.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

