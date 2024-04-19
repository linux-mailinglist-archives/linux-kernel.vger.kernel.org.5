Return-Path: <linux-kernel+bounces-151469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C0E8AAF4A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8109F1C22335
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212D112837C;
	Fri, 19 Apr 2024 13:26:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84428121F;
	Fri, 19 Apr 2024 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713533176; cv=none; b=MrE+A8fc3lAvF+QWtfHy3SZ0zlq1viNGGtGiThkjSi6uGgctSBbBkyi7TwEFTX1Azzb2s948T6amjXgPuEC/k+BoSpicBPQX+KUqZy4yAF8Gvv2upB0mYL7ABZSeEyNQ2zweCLNOcZDdkMjLWLBiUWnXaog6Px0xcD+whmOyNAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713533176; c=relaxed/simple;
	bh=6j8LAuPX+5y1QeKSrSDHV4idU5BIz6e5AHZh1OPYS4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ugz/p0IFR5FzYXZwBtJmE5Di+CRC7XO3gDT2tUZXJfLDNL7vEQssN2+57E22jFcO2nSPCuvM9aQkOyV86LoQqg9bIvIVnw8wzpIASZuet8SVj8My4pbiRqOJECgmTelkONT79w3/N81+0sXXR+lT9kv8HNm5IZ4elI5IbqE1gH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E72B2F;
	Fri, 19 Apr 2024 06:26:42 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7813D3F64C;
	Fri, 19 Apr 2024 06:26:11 -0700 (PDT)
Date: Fri, 19 Apr 2024 14:26:08 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Dhruva Gole <d-gole@ti.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v11 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <20240419132608.3hlubncopeakdwo5@bogus>
References: <20240418-pinctrl-scmi-v11-0-499dca9864a7@nxp.com>
 <CACRpkdbswetf2Tr6H216nxb8XKX8evyiWiVcsK5E=inqBUUVng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbswetf2Tr6H216nxb8XKX8evyiWiVcsK5E=inqBUUVng@mail.gmail.com>

On Fri, Apr 19, 2024 at 03:20:08PM +0200, Linus Walleij wrote:
> On Thu, Apr 18, 2024 at 3:24 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> 
> > Per Sudeep's reply in v10,
> > "This series looks good overall. Since it has pinctrl driver, I need Linus
> > to ack/agree to pick the whole series up or I can ack them so that Linus
> > can take the whole series. Either way it is fine for me."
> >
> > v11 is just minor update per Andy to patch 4 and Andy's R-b applied.
> >
> > Hope v11 is good for you to pick up.
> >
> > Linus, would you ack or this patchset go through your tree?
> 
> Since most of it is in firmware rather than pinctrl I suppose
> the best is to merge it in the firmware or SoC tree, so:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 

Thanks, I will merge this soon for v6.10

-- 
Regards,
Sudeep

