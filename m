Return-Path: <linux-kernel+bounces-55303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F4584BAA3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56299282304
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FB4134CD3;
	Tue,  6 Feb 2024 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2Okhq0ik"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F32134733
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235864; cv=none; b=t/GjZn/c7MLwayPsjYebI7ic2TdYWQGdDwOnM+gFxiaAHQy3bq0Erb6BR+VmfA0wssupeu43NAb2xI3T6zVRLRsUdEfVvFjXrvgEkGgJSIho8njSQKZMDWxj0Acqw6ga8g9Zi05e7YMgNgY9YciqPJgwLXwdK6W6GmPrkTGknJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235864; c=relaxed/simple;
	bh=uy1Mkp3gzTrqH7Ahu2KKyj6Zh+0eGBQguM4Q0moS27k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rn11r5ehkOjgLDDeemgYWg7xlzVRPSEygzFFItjuPkq2fXGwXhXpnlrkuzHy9rRKy9PG06LVxivBpL/Ud1tCvjZbPKq5MnGJGn07nfo3UzSZUhFhRUlrTqXmhAkIoki0b/ga93L24+SVuvYibDRUc9n+QslNdNUeexvGcUI/HpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2Okhq0ik; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707235860;
	bh=uy1Mkp3gzTrqH7Ahu2KKyj6Zh+0eGBQguM4Q0moS27k=;
	h=Date:From:To:Cc:Subject:From;
	b=2Okhq0ikLzfDyXKIO/Qrp49byJli+hKfZDPNTLKPHs5eSfpIMrxq910C8dHJpY5kc
	 RMlcT4B30spOGUQfGOamfClz8ZirMiMRC9LzQgn22W/9XRrl2b6sIGP3qA2/eWmDot
	 BSR7SdGL6GrOkhetQy29eU8sdZM/7gvUO09msbVJ7Xq6sXT2Uto3ur6bXA4XZvUwaX
	 CK5shYmI/fx0Rqp2bYzeGibjHCAQ35aHTMhBLZ/yRPKppy13p6iVjSrInTxw1KRIJP
	 9XKe4ur2fgzTpvp2zrmbPcPED2qguKSgkUbkrOPdOhgbdJf+REkzHwQmok7D/BupM2
	 se9a9EVxfKxrA==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C82D837803EE;
	Tue,  6 Feb 2024 16:10:58 +0000 (UTC)
Date: Tue, 6 Feb 2024 11:10:56 -0500
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Chen-Yu Tsai <wenst@chromium.org>
Cc: regressions@lists.linux.dev, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Probe regression of efuse@11f10000 on
 mt8183-kukui-jacuzzi-juniper-sku16 running next-20240202
Message-ID: <47cdeac1-121d-4b1a-a3ac-e2affc7a2fc3@notapiano>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

KernelCI has identified a regression [1] on the
mt8183-kukui-jacuzzi-juniper-sku16 machine running on next-20240202 compared to
next-20240118:

<4>[    0.627077] sysfs: cannot create duplicate filename '/bus/nvmem/devices/mtk-efuse0'
<4>[    0.634945] CPU: 7 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc2-next-20240202 #1
<4>[    0.642542] Hardware name: Google juniper sku16 board (DT)
<4>[    0.648237] Call trace:
<4>[    0.650917]  dump_backtrace+0x94/0xec
<4>[    0.654815]  show_stack+0x18/0x24
<4>[    0.658359]  dump_stack_lvl+0x48/0x60
<4>[    0.662252]  dump_stack+0x18/0x24
<4>[    0.665796]  sysfs_warn_dup+0x64/0x80
<4>[    0.669688]  sysfs_do_create_link_sd+0xf0/0xf8
<4>[    0.674353]  sysfs_create_link+0x20/0x40
<4>[    0.678500]  bus_add_device+0x64/0x104
<4>[    0.682475]  device_add+0x33c/0x778
<4>[    0.686193]  nvmem_register+0x514/0x714
<4>[    0.690256]  devm_nvmem_register+0x1c/0x6c
<4>[    0.694577]  mtk_efuse_probe+0xe8/0x170
<4>[    0.698637]  platform_probe+0x68/0xd8
<4>[    0.702525]  really_probe+0x148/0x2b4
<4>[    0.706413]  __driver_probe_device+0x78/0x12c
<4>[    0.710990]  driver_probe_device+0xdc/0x160
<4>[    0.715394]  __driver_attach+0x94/0x19c
<4>[    0.719453]  bus_for_each_dev+0x74/0xd4
<4>[    0.723512]  driver_attach+0x24/0x30
<4>[    0.727312]  bus_add_driver+0xe4/0x1e8
<4>[    0.731284]  driver_register+0x60/0x128
<4>[    0.735343]  __platform_driver_register+0x28/0x34
<4>[    0.740265]  mtk_efuse_init+0x20/0x5c
<4>[    0.744155]  do_one_initcall+0x6c/0x1b0
<4>[    0.748214]  kernel_init_freeable+0x1c8/0x290
<4>[    0.752795]  kernel_init+0x20/0x1dc
<4>[    0.756512]  ret_from_fork+0x10/0x20
<4>[    0.760353] mediatek,efuse: probe of 11f10000.efuse failed with error -17

This efuse probe failure causes the probe failure of other components that
depend on it, including the display pipeline:

/soc/dsi-phy@11e50000
/soc/dsi@14014000
/soc/efuse@11f10000
/soc/i2c@11008000/anx7625@58
/soc/i2c@11008000/anx7625@58/aux-bus/panel
/soc/thermal@1100b000

There is a series already addressing the issue [2]. The first two patches have
been merged into the mediatek tree, but that tree isn't currently being
integrated into linux-next. Besides that, patch 3 hasn't been merged into the
nvmem tree yet, and it is required in order to solve the issue.

I'm sending this regression report so we can properly track the regression while
the fixes don't land on linux-next.

Thanks,
N�colas

[1] https://linux.kernelci.org/test/plan/id/65bd63c3f12d8a95e200a225/
[2] https://lore.kernel.org/linux-mediatek/20240130095656.3712469-1-wenst@chromium.org/

#regzbot introduced next-20240118..next-20240202

