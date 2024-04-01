Return-Path: <linux-kernel+bounces-126751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570FF893C45
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120C6281D37
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614A943AC2;
	Mon,  1 Apr 2024 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="j4gz+d3F"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCBE383A9;
	Mon,  1 Apr 2024 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711982272; cv=none; b=hAcHoivY8lS2Fagb97NU5o8vPftDLp4Xot6q7oy1MqN7PIZ3BLVjJbEriQ9cSWcD2J7TKWn+ja9M1R3cyvT/qruscH+ApqPDcHyWTF1/Pax8Hby1wmYvsLHB21Z3igvpBia8BMG0Jb0fD8txKi4iiz9OppnqKgaWzqSo5kxfFkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711982272; c=relaxed/simple;
	bh=EDuwgJi1CNAu0XqxLHk/9kzn2VYjrr4A9J/CLlfn+MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AF7GxYyDoWyqzmKothWO+q5EWoVTGK6kIAvUuWcP4sd0mKplElHqtDb5akNTc21HBC3Ri2dtf4a39hCYBHxj8Z5JdMfAqbtrc3PZxD8vYjsPNlnXVB3KTYPgXIFtUr9IuKjqonCJdvobCRR7X5wb8/gX25XuCbGaWYWYGJ6pAT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=j4gz+d3F; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Q70vVkhHLdfFH+sr9h+PG76bJIzpJDz38Vtir45wbHQ=; b=j4gz+d3Fz7mUNFn3+/VvqqlCNd
	vLVwFWG9bjBeoEnyIPeG8fbVEOSp7XdWSS1h1YSFM1g/fofmlixWtUs7QvG5kCkcJWTPUYQUPbdTF
	eRYzbkMZNFG/26GJhqPZOl3hKcEQhR2zzzIWCiSZzJmKqSVHSsShmWFPeXuopuL3+1xc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rrInB-00BrXz-53; Mon, 01 Apr 2024 16:37:45 +0200
Date: Mon, 1 Apr 2024 16:37:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] arm64: dts: marvell: cn9130-db: drop unneeded flash
 address/size-cells
Message-ID: <7e406d36-eee5-487c-a6b6-09944607ac54@lunn.ch>
References: <20240401141051.98233-1-krzk@kernel.org>
 <20240401141051.98233-2-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401141051.98233-2-krzk@kernel.org>

On Mon, Apr 01, 2024 at 04:10:47PM +0200, Krzysztof Kozlowski wrote:
> Flash node uses single "partition" node to describe partitions, so
> remove deprecated address/size-cells properties to also fix dtc W=1
> warnings:
> 
>   cn9130-db.dtsi:313.10-336.4: Warning (avoid_unnecessary_addr_size): /cp0/config-space@f2000000/spi@700680/flash@0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

