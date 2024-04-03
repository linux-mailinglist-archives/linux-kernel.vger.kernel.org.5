Return-Path: <linux-kernel+bounces-128895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E99F896193
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8211C2226D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DAED29B;
	Wed,  3 Apr 2024 00:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="EjzsYTj6"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADF417C8;
	Wed,  3 Apr 2024 00:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712105059; cv=none; b=UrfPLBvz/EwTvlZD043Z0A3hwLAvVKazP6+GKJdCtzKNzAI8WZAse35JtUCphagTvR4PRp8McI4oc1rZGA08pMd1TdwvB/UoE6O/5HtmWVIVQWAzNAUvTPdIxNDbISNvr3C9g4tQVMdNWD5cPVCX0kJN2JgSrwOgcBfWHvGUzMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712105059; c=relaxed/simple;
	bh=LR99gG5LNLc23ySSEXkTJVAntBAds+rXUifHCtQe2rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCbJ5NHzmkQuOOKvX2u2pdiBOKcUK9s36NCv1wPHLlsvU4GWHFL2bmMR+MnOjQkHUymQoDOMgHj/6FiITFI/5+mCK6sluDDTZlyJ87K+iM60SJDsGVQHoIVKlanN/xH+QY0nOM6RXawcIZ2fqG4grKe6l5KPGmOIevzsQZdQj/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=EjzsYTj6; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=V8Qan3vHh6zRqpFSLvYPjs8bOeaOc0YWEP6aFIgm3OI=;
	b=EjzsYTj6IL2j8EWBlji8fjHVghR5ngdCS0mbH9zznASj8rxb/LxJTV5uZt41DV
	bM76JwY9zp5fNlZ473qw19nTnDnLjawcMSaQShu8SquK3+XPSTN6enq11QkcxXJF
	rbbaU5t3VfUkEAbQpXFMCp5/hJ9eeP48fCmcdXbskDpok=
Received: from dragon (unknown [223.68.79.243])
	by smtp2 (Coremail) with SMTP id C1UQrAC3n2hHpgxmDFOyAg--.55910S3;
	Wed, 03 Apr 2024 08:43:52 +0800 (CST)
Date: Wed, 3 Apr 2024 08:43:47 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: carlos.song@nxp.com
Cc: shawnguo@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: lx2160a: add pinmux and i2c gpio to support
 bus recovery
Message-ID: <ZgymQ8D4JxviBJzP@dragon>
References: <20240328061419.1956329-1-carlos.song@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328061419.1956329-1-carlos.song@nxp.com>
X-CM-TRANSID:C1UQrAC3n2hHpgxmDFOyAg--.55910S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUs6pBUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFQq1ZV6NnBsUdgAAs5

On Thu, Mar 28, 2024 at 02:14:19PM +0800, carlos.song@nxp.com wrote:
> From: Carlos Song <carlos.song@nxp.com>
> 
> I2C bus recovery need a pinmux and gpio. So i2c driver can switch
> gpio mode to toggle scl to recovery bus.
> 
> Add pinctrl-single node to every i2c bus on fsl-ls2160 layerscape
> platform.
> 
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Reviewed-by: Frank Li <frank.li@nxp.com>

Applied, thanks!


