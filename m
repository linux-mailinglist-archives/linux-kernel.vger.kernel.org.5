Return-Path: <linux-kernel+bounces-47654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D25078450C5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87C9A1F2A150
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36555F869;
	Thu,  1 Feb 2024 05:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="UEWFAFN6"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96625F851;
	Thu,  1 Feb 2024 05:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706765759; cv=none; b=OtEYMJxE5qyJcB03r/Y0FW7KEJKpSeBnixjPU+PqvsTcsAzBNwC9AV0zW4oC9Z6XXIeDko2eZ9WOzDslqylBf/sD8qUFnY73VXvLGJnsPX3oN4h9LBRncQ9VqW7kMveUQff/TkU/30HWJv5+7HihckiYGjFumxY041poQEGJOmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706765759; c=relaxed/simple;
	bh=QR/g7w43xokpD7sxT5tvmODoZQOnszcgBkOiURIoK+c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=un220+xaoMtHSz1n0V2eyDPnTQPyEE6RqOBiZEOzCKT7NcP0y/VBEu+bSmTfBzDHGYUC62jPMxJRZIRxUGcvROB0bYlOsfLNvJsCBwEquiFEuCpTYq5ik1GrkqUj/yFiK3gKOgLqR32Sv4l/RRVOCtRWB+8b21zl5Z7ooaW3vzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=UEWFAFN6; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-76-194.adl-apt-pir-bras31.tpg.internode.on.net [14.2.76.194])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 131A32017A;
	Thu,  1 Feb 2024 13:35:55 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1706765755;
	bh=QR/g7w43xokpD7sxT5tvmODoZQOnszcgBkOiURIoK+c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UEWFAFN67uOR5jxkJ5SAcxyDdfw6omUMDLuMJuNauiJ7h5WGiZ+9zKQjs4IIjEBEO
	 CalHkTZUz9biBn8xfTZ/6SS8QL0ra1JeZfWvYRymLh+pLZTYhYCNmIZuNjthZOKxGW
	 9UwQ2rlRZ4aVfqvmke7c+icsDLHEFE3Szf5/ByI/PiA0pLqLircoZ7o20bk7Stgr+H
	 4owLMcDlu7RDlxjzlw1y4uGs7QZwPenlN7IXTmfXVw2uTqGCTg+KRqfZI8HTPfNt9W
	 4s7qiaT35HDvKPjaM+2WDitJxqpOQs1aIsGmQB+8JOPP5q4qn2GaK5TzG2jlRXphvs
	 +YLW3iHEFWmkw==
Message-ID: <9c816665570c3834bfe0e6fa58f7bf2daf549fb0.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 07/21] ARM: dts: aspeed: yosemite4: Add gpio pca9506
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Feb 2024 16:05:54 +1030
In-Reply-To: <20240131084134.328307-8-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240131084134.328307-8-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-31 at 16:41 +0800, Delphine CC Chiu wrote:
> Add gpio pca9506 I/O expander for yv4 use

Use for what? It seems like there's a pattern to the additions, it
might be good to discuss that briefly?

Andrew


