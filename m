Return-Path: <linux-kernel+bounces-31980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCFD8354C1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 07:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3806F1F23289
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 06:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E214B364A6;
	Sun, 21 Jan 2024 06:56:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D2F36126
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 06:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705820192; cv=none; b=PwLbBOxZYpGiQZRBhlKeKRm8Wg4AQbZa9xZZwPpf3vosA6CFpk12HPxIDWXOY6SXwozsN/NYQIo5FYw9A00DduHWqG+rxCkD0UViszm+R6sAgmb73N2gNSlt4Ce35Leh7kQa6Yc1gCCYX1T/Exh8lxFGJr/3nNbFMr0L1D2lW7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705820192; c=relaxed/simple;
	bh=H4D65o2qgKezV17qXXj1tv+dOT754Db1R0b4ZWq3T0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sy6cGSs3RHvcArokimSTfhUEnadfUXmBHc+A8Hn5nqLRO82xaOAjq+wsC1CM/fVwLeyHGQzVcHiu/JW5aFXA+xDkuZ3yB5md8hSKn6Y9xntWf1eTpPeCkmTBQkhh7EBaY0TE4wgUiq6jUJ3Lgz3mPgOos4UprVxpA9gFBMWeCfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rRRka-0006vJ-6d; Sun, 21 Jan 2024 07:56:12 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rRRkY-001JDN-4I; Sun, 21 Jan 2024 07:56:10 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rRRkY-000zga-1K; Sun, 21 Jan 2024 07:56:10 +0100
Date: Sun, 21 Jan 2024 07:56:10 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [RFC PATCH v1 0/7] Introduction of PSCR Framework and Related
 Components
Message-ID: <20240121065610.GC163482@pengutronix.de>
References: <20240119132521.3609945-1-o.rempel@pengutronix.de>
 <7gadkjffeljjwb2cgcmg6ixco3xtg4t4hrxtetfnjyzuxvfsjt@ze7u4glqnerb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7gadkjffeljjwb2cgcmg6ixco3xtg4t4hrxtetfnjyzuxvfsjt@ze7u4glqnerb>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

On Sat, Jan 20, 2024 at 12:19:09AM +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Jan 19, 2024 at 02:25:14PM +0100, Oleksij Rempel wrote:
> > This patch series introduces the Power State Change Reasons (PSCR)
> > tracking framework and its related components into the kernel. The PSCR
> > framework is designed for systems where traditional methods of storing
> > power state change reasons, like PMICs or watchdogs, are inadequate. It
> > provides a structured way to store reasons for system shutdowns and
> > reboots, such as under-voltage or software-triggered events, in
> > non-volatile hardware storage.
> > 
> > These changes are critical for systems requiring detailed postmortem
> > analysis and where immediate power-down scenarios limit traditional
> > storage options. The framework also assists bootloaders and early-stage
> > system components in making informed recovery decisions.
> 
> A couple of things come to my mind:
> 
> 1. Do we need the DT based reason-string-to-integer mapping? Can we
>    just use a fixed mapping instead? It simplifies the binding a
>    lot. With that the generic part could be dropped completely.

The project I'm working is using RTC for storage. The RTC device in
question provides 8 bits, 3 bits are assigned for PSCR.
Currently all reasons provided in this patch set would fit int to 3 bits,
but soon or later it may expand.

> 2. I would expect the infrastructure to read and clear the reason
>    during boot. If e.g. a watchdog triggers a reset you will otherwise
>    get an incorrect value.

Hm.. good point. I'll set a value on the boot that there is currently no
attempt to shutdown at all. PSCR works only for software assisted
shutdown/reboot. It should extend, not replace PMIC or watchdog detected
reasons.

> 3. The reason is only stored, but not used? We have a sysfs ABI to
>    expose the reboot reason to userspace since half a year ago, see
>    d40befed9a58 (power: reset: at91-reset: add sysfs interface to
>    the power on reason).

ACK. I'll add sysfs support.
For my use case, the user is the bootloader. The is one of reasons why
DT is used for mappings, this is the stable ABI between this systems.

> 4. Available options should be synced with the list in
>    include/linux/power/power_on_reason.h

ACK

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

