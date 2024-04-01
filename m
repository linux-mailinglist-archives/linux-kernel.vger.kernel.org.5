Return-Path: <linux-kernel+bounces-126752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD193893C47
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9CE1F21689
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D934943AC7;
	Mon,  1 Apr 2024 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LLy200uP"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A00446AE;
	Mon,  1 Apr 2024 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711982287; cv=none; b=TTduvSVu1tFcHwOlxRcf0FprIF2wSURYeaH+Ijq6VVSQL5wB1gd3OLtbydt2qZ0W2KcUKeoq71oVyJY6XLilZNAH3QsNQX9YgiMU9NwUlBHW/5BB1ig856IfmWJR5v/fsrkWVozg4fYhgqWfYSy8uftXguahxAl2TqgwWQJ9Jqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711982287; c=relaxed/simple;
	bh=SXQTByqzEXaR5S5kYOJIcR3xTtLqqL1R5gVesyFHYt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMZguU8TGf9gCB98rmhL5vkEZ9qqd0py6Do4yGmBctKKQWrhni4v6f4Cnlv6oITuyz0sKBb+9RHCzToZKfg4QKzhP7wUNW2gLm8+E/mPdEUFQMaXHDRh0S0fdtKSq872RkkOTGUhVpfd2hQjBxZLchqH84avswZPvZGGuBNceFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LLy200uP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cn2TJY+2syK9goNy3YY9LDdi5CIMAb/s12/BcD97vIc=; b=LLy200uP+fvz1noGkAG5tSMANV
	WZoBwfVSvRpFHNE9irmVt8kddSMaczAfWyvFbGwTqSrQDT2tiKIOD/4MHnxjd01nZh8QMCPDW1gTK
	zB26iU01UIblgVw41nuw4meXJEVrJ/nKQnfDy3cKrZkBMfgtdJrWRS6R6IwIfxtiPlKM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rrInP-00BrYV-1r; Mon, 01 Apr 2024 16:37:59 +0200
Date: Mon, 1 Apr 2024 16:37:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] arm64: dts: marvell: cn9131-db: drop unneeded flash
 address/size-cells
Message-ID: <cf1f8efa-b559-464d-9e96-8ddf200fcd4e@lunn.ch>
References: <20240401141051.98233-1-krzk@kernel.org>
 <20240401141051.98233-3-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401141051.98233-3-krzk@kernel.org>

On Mon, Apr 01, 2024 at 04:10:48PM +0200, Krzysztof Kozlowski wrote:
> Flash node uses single "partition" node to describe partitions, so
> remove deprecated address/size-cells properties to also fix dtc W=1
> warnings:
> 
>   cn9131-db.dtsi:140.10-163.4: Warning (avoid_unnecessary_addr_size): /cp1/config-space@f4000000/spi@700680/flash@0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

