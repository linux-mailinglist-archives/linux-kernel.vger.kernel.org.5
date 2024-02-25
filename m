Return-Path: <linux-kernel+bounces-80284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7446E862CE5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 800C8B20A56
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 20:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFB21B81B;
	Sun, 25 Feb 2024 20:41:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637B7111A5;
	Sun, 25 Feb 2024 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708893660; cv=none; b=YAi1ShU921+fSwyvp7dzKTdm0da1r0/wXz51VjmPsT/thbLFztWCM2xbfPiUZMd50zqxinO6GE0jBF1R0UTwqNWYrvR09TAWyM5/Yrn26eUKVpMHxEY9IglRH7BqOtBQmb+TMSrt7KNIRBrngM3cz+ktjwSR+20ld2CeC6Y6E0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708893660; c=relaxed/simple;
	bh=XumoTfKfv/ZGFc5svkWZgCNU7144b6sk/mox3FGWCLM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RhqwRouy9KQam4FA5xXsjrs8wXjAp4bVFvBkZYA3EkrMwKdHt+aOA1eTN+2piPcHUn/miWdnlVSoM5+mM4Flq3jVIuJQixqN6vPSrl9b66I9/Mx+tv4aEFgR0wQpn5atVDn437Q/HOZnLQFyAjrFNrBB3IWdcGc5Aw4nrxJkXcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8402EC433C7;
	Sun, 25 Feb 2024 20:40:59 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 088151060D21; Sun, 25 Feb 2024 21:40:57 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20240224-device_cleanup-power-v2-1-465ff94b896c@marliere.net>
References: <20240224-device_cleanup-power-v2-1-465ff94b896c@marliere.net>
Subject: Re: [PATCH v2] power: supply: core: constify the struct
 device_type usage
Message-Id: <170889365697.1930401.10570101771941744000.b4-ty@collabora.com>
Date: Sun, 25 Feb 2024 21:40:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Sat, 24 Feb 2024 17:15:41 -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the
> power_supply_dev_type variable to be a constant structure as well, placing
> it into read-only memory which can not be modified at runtime.
> 
> In order to accomplish that, export power_supply_attr_group in
> power_supply.h and use it with the macro __ATTRIBUTE_GROUPS when defining
> power_supply_dev_type in power_supply_core.c. Therefore the attribute group
> is no longer static. Lastly, because power_supply_attr_groups is no longer
> dynamically associated to power_supply_dev_type in
> power_supply_init_attrs(), make the function receive zero arguments.
> 
> [...]

Applied, thanks!

[1/1] power: supply: core: constify the struct device_type usage
      commit: 7b46b60944d77e361a727cd8ce46aec31c146e26

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


