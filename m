Return-Path: <linux-kernel+bounces-48893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820E48462E3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B8228A602
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C872B3F8D4;
	Thu,  1 Feb 2024 21:51:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603F11E4AA;
	Thu,  1 Feb 2024 21:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824310; cv=none; b=uvhk7qHhBrjMfTepLbQ5J26hgJqkU4CD5oawK8EfqxKh0yuvPZ/WBiwzy4u2KSb0cPRSETNQj93LlhrXkgeYm47dmaSu2LTIOhS2As1cclkIxLK/uxB2weT0Q7wVvI8MU6S9ZG9Rh+pU+CS9VZYY3Ut5dHLLdBwrqLlTCa5GxwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824310; c=relaxed/simple;
	bh=nYOKeNNCygrvnM3yUPYmsdj07SBNCiT7gBLj9/exBHM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SVe/x7oyiPc6uwdg147SY7JUABPJJ95cYfRInVc5zsq3AseodlP9q2NP/yEnLrjJ7c2UMCJLluNcchWstizJomE6I5xiHfVIRUHqOpQiOG/+lQgzVY5yTlBenLqGw69JBiAnI5fCUWx0AKqnLdtJLyUKWknsbM7GcoARENKReCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4100C433F1;
	Thu,  1 Feb 2024 21:51:49 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 8D0BB1062449; Thu,  1 Feb 2024 22:51:45 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Support Opensource <support.opensource@diasemi.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Andrew Davis <afd@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240129190246.73067-1-afd@ti.com>
References: <20240129190246.73067-1-afd@ti.com>
Subject: Re: [PATCH v2 0/4] Power supply register with devm
Message-Id: <170682430554.1254657.9141440535307121291.b4-ty@collabora.com>
Date: Thu, 01 Feb 2024 22:51:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Mon, 29 Jan 2024 13:02:42 -0600, Andrew Davis wrote:
> These are the 4 patches that had "unused variable" warnings (thanks kernel
> test robot). Fixed the warnings and rebased on -next so all taken patches
> from v1 are dropped.
> 
> Thanks,
> Andrew
> 
> [...]

Applied, thanks!

[1/4] power: supply: max14577: Use devm_power_supply_register() helper
      commit: 99ae075684be3a84a9c20d9541259221d2c01fc8
[2/4] power: supply: max77693: Use devm_power_supply_register() helper
      commit: aed93a83a01211270feed78aa5dd5f2d2c76ff82
[3/4] power: supply: max8925: Use devm_power_supply_register() helper
      commit: 478a253e466570c4f02cbd7c9386f29dffe4375d
[4/4] power: supply: wm8350: Use devm_power_supply_register() helper
      commit: cad1e6df54ca6231a3d1217bc4231d1a7eadbc0c

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


