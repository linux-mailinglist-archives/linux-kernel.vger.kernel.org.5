Return-Path: <linux-kernel+bounces-105509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC1F87DF82
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A03511C209FA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1351DDEC;
	Sun, 17 Mar 2024 19:08:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44EC1CD2A;
	Sun, 17 Mar 2024 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710702519; cv=none; b=W2MnReT3sw79LePb/uk7XNxZadpYet4pkEvSN6AAI4X54xdYlQAQyJNJLD1gwFJSfXvPNuL0RawxS8OJv+CfTNmWni5Yhu5TMwAbK9tSfYonjsKNLU27zfGSvz2OljkfMeircl3LyT05W3VcKEAqsnXvkeHt+PBbCV/LgfVnvA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710702519; c=relaxed/simple;
	bh=zaERisymV1niG4vxlRgldFGNfFyMp3ln6L34ffmt14Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3i6gUa4MH9maPXVZ79po04qI00S85xmzkwIWXPaK6t2krkbLUL34IRGDj4rMlhjEco/diiFZM2ohVWOjA3wZ9a8c3SDDYPk3VYhUhTZY2D6CqmagfpWAkitfgDJD3VwoIDpDCHS19Srxa9KUgJa3F3cJWZumDS/OLjyMT16p7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1758012FC;
	Sun, 17 Mar 2024 12:09:05 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC3013F23F;
	Sun, 17 Mar 2024 12:08:27 -0700 (PDT)
Date: Sun, 17 Mar 2024 19:08:25 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <Zfc_qW_soqofZVAG@pluto>
References: <20240314-pinctrl-scmi-v5-0-b19576e557f2@nxp.com>
 <ZfMqWP-t39SCvkA2@pluto>
 <DU0PR04MB9417056FD84405898F1B007B88282@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZfR89rdzRymY1Ovx@pluto>
 <e42e28ad-799d-4254-bf87-634bcd14c086@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e42e28ad-799d-4254-bf87-634bcd14c086@moroto.mountain>

On Fri, Mar 15, 2024 at 09:20:02PM +0300, Dan Carpenter wrote:
> On Fri, Mar 15, 2024 at 04:53:10PM +0000, Cristian Marussi wrote:
> > On Fri, Mar 15, 2024 at 12:31:51AM +0000, Peng Fan wrote:
> > (and whatever you use to test on the backend server too, if you want
> > to test this...)
> > 
> 
> What are people using to test this, btw?

Hi Dan,

I think NXP has their own SCMI server embedded in TF-A (Peng posted a
link at the public repo a while ago I think...) supporting Pinctrl;
additionally Oleksii/EPAM (the original author of this series) have their
own distinct proprietary SCMI server implementation with Pinctrl (not sure
where it run from in this case but it is a Xen based setup if I remember
right..).

Beside these, there are at least a couple more Vendor proprietary incarnations
of SCMI servers that I am aware of (that most probably did not support Pinctrl
anyway as of now...)

On top of this, on the other side there is, of course, the official SCP/SCMI
server reference implementation, that can live in a number of different places
thanks to the the virtualized environment built by Linaro, but this latter
SCP/SCMI server does not have any official Pinctrl support either as of now.

Thanks,
Cristian

