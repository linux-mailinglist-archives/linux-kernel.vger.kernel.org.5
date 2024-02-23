Return-Path: <linux-kernel+bounces-77937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5C3860CF5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02381C227F5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D3A383B2;
	Fri, 23 Feb 2024 08:34:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554E919474;
	Fri, 23 Feb 2024 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708677252; cv=none; b=YVT9CR/pCie/fpC8mIYgieQGm/AnyMtae4I4iyuKVAmJnTenBTdFCNaQhdgcMvGzt8WBmsIXvzSpJ5GbP53BaMUeK1cT7CFA2PaxElijocHiM26+RNQc/H5mSv9X/Fjcm8j/zPYa+WPZ7jyDXC+M2P5cS9OQduGbnGQsEKGor5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708677252; c=relaxed/simple;
	bh=/lW7ZmoooOy9fLc7q9dtxDneE+FqEHXGAYdnAzZbiw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2ae4CLH3edxoYwsWd+AW0s3Ufz/8mpZSaz8hARVI32AA/Vgdo7R5yViGoZWOjmcEE3yx10+08HpN81zFccwSn+vad7whF1xCc/Lhxk7T/GT5TQ3V9DC7J9lZS14Iy+Zfs8FJTyZ9u+lJ8zjSX3hGSn60xI1Sv99NxdN8AwD86I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E439C15DB;
	Fri, 23 Feb 2024 00:34:46 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 050E83F73F;
	Fri, 23 Feb 2024 00:34:05 -0800 (PST)
Date: Fri, 23 Feb 2024 08:33:55 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v4 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <ZdhYc90uy7yuYrx2@pluto>
References: <20240223-pinctrl-scmi-v4-0-10eb5a379274@nxp.com>
 <20240223-pinctrl-scmi-v4-3-10eb5a379274@nxp.com>
 <CACRpkdZLuWwecacBAimT=Vj67dGabzBH-7aaqzoyj1B1sY6o_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZLuWwecacBAimT=Vj67dGabzBH-7aaqzoyj1B1sY6o_A@mail.gmail.com>

On Fri, Feb 23, 2024 at 09:28:12AM +0100, Linus Walleij wrote:
> On Fri, Feb 23, 2024 at 2:08 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> 
> > From: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> >
> > Add basic implementation of the SCMI v3.2 pincontrol protocol.
> >
> > Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
> > Tested-by: Cristian Marussi <cristian.marussi@arm.com>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> > Co-developed-by: Peng Fan <peng.fan@nxp.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> 
> This looks ripe for merging for me, there are clearly dependencies in the SCMI
> firmware tree so I can't apply this to the pin control tree, but if
> someone creates
> an immutable branch from the SCMI firmware repo (based off v6.8-rc1 or so)
> I'm happy to also pull the branch into pin control.
> 

Well, AFAIK there is another upcoming change in the v3.2 SCMI spec and
I am not sure if this series accounts for it...indeed the v3.2 -bet4 was
still pending fr feedback AFAIK (and I doubt latest changes are in since
they have been discussed like yesterday...)....but I maybe wrong, I will
chase for the final spec and look into this to verify if it is
compliant...

Anyway, given the particularly long history of changes in PINCTRL v3.2
SCMI I would wait to have the final spec officially frozen at this
point before merging....

Thanks,
Cristian


