Return-Path: <linux-kernel+bounces-162487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071818B5BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF71C285CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9191180603;
	Mon, 29 Apr 2024 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="WEps1Ixz"
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038B535A2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402258; cv=none; b=V4UWLCmmn7kjzI7dlcalYFgjE4TcB5k7Q+I3K+NXdPXJrpDaA051jkEQasVLlGYOan49ptcYeK4HQk8Jk2rTkluUpizucrYeHQlIKHJdH/YcBsWX0g+BPeGjSWgFp6vkM9mCbYEtFxfvFwG64bbl+fydXHHsscNoqe8YlH2LP4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402258; c=relaxed/simple;
	bh=X7JtwVobbl1aaVdL5AfJMEGYBq1GtV+sXC/F23TkgsY=;
	h=Date:Message-Id:Subject:MIME-Version:Content-Type:From:To:Cc; b=nXHFdmCOr+E7w8ZAgxsXYOMttxJB/rHQ1nZ4N+3Or0arAAfz/9e7hV0uKahFgXK84z6tEyTRAbHsVgDbaJNpmsiB2bDqmyy9jjh4ZH2rBnRsFc/66XbWkyTKXOxmPFzg3+Nrymb+e5XI4Nh6g43EbUilcGow9yN6SP6/yDWlzaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=WEps1Ixz; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1714401927; bh=X7JtwVobbl1aaVdL5AfJMEGYBq1GtV+sXC/F23TkgsY=;
	h=Date:Subject:From:To:Cc:From;
	b=WEps1IxztuJBn90ya29W2ogR5A9xc3Em9Oi/CC4aFcnAOzb7KwoAwH7tyJY18/c3T
	 wgVvKS71iZ+tfOqvYso0G23yICN2+L0byZUn55hVSvEQdQGbdKqyr/IvhhpLEjIGUb
	 aX9Jmkl+Ser7rWIwBWf1dNrkDd/pxHAOScuensa7WtpDXtNP5ABkmqmr0FBmRCmubE
	 xZ13V3F0uhITItJgCiR/zCZD0kv2ihBiHcW77FhyE/gHd7OvVq2SM27lsW+fEOcQZz
	 xg+21gwGAVGUjg7I4v2icsDOyQF1wvqJz4LS9b7PcRIItslUluJVf7ZjUkJPnKX0ZN
	 7kV7GmE9ye9zQ==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4VSmMq2r3Gz8F;
	Mon, 29 Apr 2024 16:45:27 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.5 at mail
Date: Mon, 29 Apr 2024 16:45:27 +0200
Message-Id: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 00/12] regulator/core: Trivial cleanups and improvements
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
To:	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc:	linux-kernel@vger.kernel.org

This is a random set of cleanups, dead code removal and minor
optimizations.  This is a v2 of patchset sent long time ago, extended
with a couple more entries (one including a driver cleanup to enable
further changes). Tested on Tegra3 (ARM) and x86 devices.

v2:
 - added regulator_dev.reg_data cleanup patches
 - added a missing hunk in patch 6
 - removed an extra change from patch 5
 (Note: skipping changelogs in the patches, as the update has no relevant
  material changes there)

Michał Mirosław (12):
  regulator/core: _regulator_get: simplify error returns
  regulator/core: set_consumer_device_supply: remove `has_dev`
  regulator/core: of_get_child_regulator: remove goto
  regulator/core: regulator_bulk_get: remove redundant NULL stores
  regulator/core: regulator_ena_gpio_ctrl: pull in ena_gpio state
    handling
  regulator/core: remove regulator_init callback
  regulator/core: remove regulator_get_init_drvdata()
  regulator/core: set_consumer_device_supply: avoid copying const data
  regulator/tps68470: use rdev_get_drvdata()
  regulator/core: use dev_to_rdev() for device -> regulator_dev cast
  regulator/core: remove regulator_get/set_drvdata
  regulator/core: use rdev->dev.driver_data

 drivers/regulator/core.c               | 180 ++++++++-----------------
 drivers/regulator/tps68470-regulator.c |   4 +-
 include/linux/regulator/consumer.h     |  14 --
 include/linux/regulator/driver.h       |   9 +-
 include/linux/regulator/machine.h      |   7 +-
 5 files changed, 62 insertions(+), 152 deletions(-)

-- 
2.39.2


