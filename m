Return-Path: <linux-kernel+bounces-165256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBB58B8A21
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A3128429C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DB92D05D;
	Wed,  1 May 2024 12:37:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BE433DD;
	Wed,  1 May 2024 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567025; cv=none; b=K+tGC+jWOvKI80N0pJfpbeqlz7bTVUXtKBf57edRQzpDDB/hOPqaFnrRifRXfnpXHsm8/nQIr1mQtfoMwc9UTfc8/e8fAEg7x84ggxWpTG3skN1waWQbxm3ArfVOWrO/540TlJRAkSQdzf02hXz+fmy2jXdAyDQ9HKqCRkuGzDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567025; c=relaxed/simple;
	bh=jiPJIKOPACJlRigbwCAhBeP3mvgotgIB4cHD8g8MBkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPtNdoLylM0jRQ802HKbOKMA/oQLWiwAmaLwI/vfRpHn+5eN6/wKaZnnRhlgM0VxJ8kufvfa9M2FyuV7xZacrm/hcCMqpF8JgsrucA8enANVcBmL9gr8bQN4zHn0EaOf2fqnTtsOxb0c+rzqwMmWrUSsIhwlCg8KHz9O/OVevvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2693B2F4;
	Wed,  1 May 2024 05:37:28 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98C753F73F;
	Wed,  1 May 2024 05:36:59 -0700 (PDT)
Date: Wed, 1 May 2024 13:36:57 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dong Aisheng <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-gpio@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3 4/6] pinctrl: scmi: export pinctrl_scmi_get_pins
Message-ID: <ZjI3abJUIgo4xgRu@pluto>
References: <20240428-pinctrl-scmi-oem-v3-v3-0-eda341eb47ed@nxp.com>
 <20240428-pinctrl-scmi-oem-v3-v3-4-eda341eb47ed@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428-pinctrl-scmi-oem-v3-v3-4-eda341eb47ed@nxp.com>

On Sun, Apr 28, 2024 at 01:07:50PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add pinctrl-scmi.h to include the function prototype and 'struct
> scmi_pinctrl' to export pinctrl_scmi_get_pins, so other drivers
> could use it.
> 

Hi Peng,

so you wrote a new alternative SCMI driver using Pinctrl protocol@0x19
so that you can just parse you custom DT bindings and then use the SCMI
pinctrl_ops to set the OEM extensions to configure your platform...
..since your firmware cannot cope with the all SCMI stack footprint....

.. you seemed to have solved the issue of having 2 Pinctrl drivers
coexisting under the Linux Pinctrl subsystem while attached to the same
protocol@19 node with patch 5/6 blocklist (if I get that right..)

I think this approach of a standalone SCMI alternative Pinctrl driver
that handles distinctly NXP OEM extensions and DT-parsing is certainly
more preferable than the original series you posted months ago where
custom NXP stuff were simply stuck on top of the Generic SCMI Pinctrl driver...

..what I still dont understand is why you exported data and structure
from pincttl-scmi.c to use it here; when NXP pinctrl is active the
standard Linux generic Pinctrl driver wont be alive, so not probed, so
no data can be shared, the only thing I can imagine is that you are
just trying to avoid duplicating a dozen lines from the logic of
scmi_pinctrl_get_pins() into your new NXP driver.

In this way, though, you are creating a dependency between 2 drivers,
that are not even allowed to cohexist at runtime really (due to the
blocklist trick).

Am I missing something ?

If not, I think it will be much better to just rewrite that few lines of
scmi_pincrtrl_pins_get trivial logic into your NXP driver and keep the 2
drivers fully distinct at all times.

Thanks,
Cristian


