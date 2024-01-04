Return-Path: <linux-kernel+bounces-16133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B7F823975
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80CA1F25A7D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126A07E6;
	Thu,  4 Jan 2024 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDFo2wP2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E02367;
	Thu,  4 Jan 2024 00:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF11C433C7;
	Thu,  4 Jan 2024 00:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704327091;
	bh=FVnLkp+lC5YchY+7IQkFupGJ+/28QBnreRLrXMvUCGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aDFo2wP2hEspYa03CA3X/8uOdaAOdrf3YXkarUJI5EkAbli/jbYewN9g7mYV5HmmH
	 agPuqbvxyGaRACwz3PAJyb8HhPJPWithaBwOkXWBRG/AJjRemEpOILM4g1Agcl+HKm
	 j9EpEndi8OQdzYBCvN1ABsPjPCv7NQpn6mG3FFrSChRWeIZD4YXyhWl7ilgzHBcn2g
	 qxq2t6g8DzWr4Jri4i2MitG5Tt0UTasXzBxJJNmSC4G5Ei1a+iy/dxy4LP0JpULg3B
	 UVooQDIAs0fo5ME9VELYQhXZXeaNF0MtvXU4ZC1Xi9pcRIIJKgUlKvois9PN/sTsjN
	 LO391lTDWryYw==
Received: (nullmailer pid 2095445 invoked by uid 1000);
	Thu, 04 Jan 2024 00:11:29 -0000
Date: Wed, 3 Jan 2024 17:11:29 -0700
From: Rob Herring <robh@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Walle <michael@walle.cc>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, u-boot@lists.denx.de, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V3 1/6] dt-bindings: nvmem: layouts: add U-Boot
 environment variables layout
Message-ID: <20240104001129.GA2045237-robh@kernel.org>
References: <20231221173421.13737-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231221173421.13737-1-zajec5@gmail.com>

On Thu, Dec 21, 2023 at 06:34:16PM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> U-Boot env data is a way of storing firmware variables. It's a format
> that can be used of top of various storage devices. Its binding should
> be an NVMEM layout instead of a standalone device.
> 
> This patch adds layout binding which allows using it on top of MTD NVMEM
> device as well as any other. At the same time it deprecates the old
> combined binding.

I don't understand the issue. From a DT perspective, there isn't. A 
partition is not a device, but is describing the layout of storage 
already.

Rob

