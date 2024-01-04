Return-Path: <linux-kernel+bounces-16877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2B582454E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40DEF2843F7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A359249ED;
	Thu,  4 Jan 2024 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IveUNarC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E91224D5;
	Thu,  4 Jan 2024 15:46:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F095C433C9;
	Thu,  4 Jan 2024 15:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704383177;
	bh=SfZbR38GEcgJBvCINBMSek/E8wPgRnRG8ktuyVrX3zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IveUNarCqW/WK/8Gk5NEKAQVJAt7LI3pmLVBOPmtCgUAUkU72rXXr29d8Yqn28wQ1
	 vA16eeqmAhjiBrrO4iFDP0X/daoMm8Qttz4qBoqex04PAfTjpwLL0Aq/gPcV9LNetX
	 IIDC7o4DtIGWqenWBYGChQgZSp+95PDVJQKSK00k=
Date: Thu, 4 Jan 2024 16:46:14 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <michael@walle.cc>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	u-boot@lists.denx.de,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V3 6/6] nvmem: layouts: add U-Boot env layout
Message-ID: <2024010446-willfully-swoop-8510@gregkh>
References: <20231221173421.13737-1-zajec5@gmail.com>
 <20231221173421.13737-6-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231221173421.13737-6-zajec5@gmail.com>

On Thu, Dec 21, 2023 at 06:34:21PM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Move all generic (NVMEM devices independent) code from NVMEM device
> driver to NVMEM layout driver. Then add a simple NVMEM layout code on
> top of it.
> 
> Thanks to proper layout it's possible to support U-Boot env data stored
> on any kind of NVMEM device.
> 
> For backward compatibility with old DT bindings we need to keep old
> NVMEM device driver functional. To avoid code duplication export and
> reuse a parsing function.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> V2: Support new compatibles & use device_get_match_data() helper
> V3: Use imperative in commit body
> 
> IMPORTANT:
> This is based on top of the:
> [PATCH v6.8 1/2] nvmem: layouts: refactor .add_cells() callback arguments

I applied patches 2-5 in this series, I'll let you rebase the remaining
two after addressing the issues discussed in patch 1.

thanks,

gre gk-h

