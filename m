Return-Path: <linux-kernel+bounces-128546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479D1895C40
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1B61F22398
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D957915B962;
	Tue,  2 Apr 2024 19:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GNWThCLN"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C2715B57B;
	Tue,  2 Apr 2024 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085048; cv=none; b=s2l1f/qbDokydF5hDJA97u70Wlru8a+QGLojsDe/e4u75lVgXWnyaz/otptsmuybHeXfQf67gqJhXeSSNvvDWDIxq/NMFf4058ATUCYVAbj67eyFWcQAvKrgtUZSRQZX3ArTY8fo0mACpgT9gnezzOB8Oae1pviKPHqrsil/icM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085048; c=relaxed/simple;
	bh=cCElBJeqSwLnyLN+YE76xaiX5fQwvcoJQPd2SFshbRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Td5BeM7ueC8WDod4x2s0p+FEs6c/Bgm8jnRxGLpCEZrWx5jg1aor40glIgXuvm4S7IsR1UQ1iOVcBj4RVSZbWM6W+/fdT3DXd+hPGMIbU/5gWIRtXspMi9kx7pKKP49X+6Z/Yd251pShxLJ7OMBNaqfLMF1CdvpJXNtKKMCwwLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GNWThCLN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nwskUurYHjbroGvSSFUYy7E4e5HI5hGu+OLsewG/HTk=; b=GNWThCLNlxusKCBP8uefm7OnET
	EuNaj+OQoWTZqVaS0VsGPnqaHc5lsZRxavEEH1VjbGLVWsiJi0GMvS2PB8EfSH9I7KfsCoH4i1gN9
	qwcv6k6vcU4ooqnQMHpWzwxamyZduXsSNKgVpvcpkW4YdH+liNspojhgt+0yz2WuL9b4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rrjWp-00Byfi-LP; Tue, 02 Apr 2024 21:10:39 +0200
Date: Tue, 2 Apr 2024 21:10:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Robert Marko <robert.marko@sartura.hr>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: marvell: turris-mox: drop unneeded flash
 address/size-cells
Message-ID: <44c3d582-ddef-4db2-8f2b-06030dbb7b92@lunn.ch>
References: <20240402183240.49193-1-krzk@kernel.org>
 <20240402183240.49193-2-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402183240.49193-2-krzk@kernel.org>

On Tue, Apr 02, 2024 at 08:32:39PM +0200, Krzysztof Kozlowski wrote:
> Flash node uses single "partition" node to describe partitions, so
> remove deprecated address/size-cells properties to also fix dtc W=1
> warnings:
> 
>   armada-3720-turris-mox.dts:218.10-255.4: Warning (avoid_unnecessary_addr_size): /soc/internal-regs@d0000000/spi@10600/flash@0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

