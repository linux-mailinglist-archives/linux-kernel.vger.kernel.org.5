Return-Path: <linux-kernel+bounces-62864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BF28526F9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98EC01C258BA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0019C17994;
	Tue, 13 Feb 2024 01:30:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8191714010;
	Tue, 13 Feb 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707787829; cv=none; b=e7Bi0P1VzUiFxDzsVRv/snh/FAL6brTjpnQ01T2Hg1sF8Tq9IyG6YdoKU5jBPguCk5sYJkeym+i515St7R2LOWMG+gyk8adiNZLfn7Wn19YZEP6Sbnb2HzVJfZfcJ9ehexb4MWm3W1iMonv6LbZaq01Tie8ImDmp8DDKhSH/ag4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707787829; c=relaxed/simple;
	bh=5YUUpkVeGZf2ULKeV0s8gYOnI9Ho0baFiYcgz1YGhG0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oCJt2fUNs23O/PW/fTbIh8khKEtnvSC4rqYqnr834+d5RCtTqAE3ujaA1nzi0QPc4QQAPkkD5p4s0Wjyc9vx4iDUEVlbqrS/xPYv0BFZmcp4bs5lhRtjiLpv5w6OnSfREZ+CUlHDCJv7hbr3KM/MIm1dxOfBl/Bf+aQOX8jZgPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4349C43390;
	Tue, 13 Feb 2024 01:30:28 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 9E53A106A041; Tue, 13 Feb 2024 02:30:25 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andrew Davis <afd@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-actions@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20240212162831.67838-1-afd@ti.com>
References: <20240212162831.67838-1-afd@ti.com>
Subject: Re: [PATCH v4 00/19] Remove pm_power_off use in
 drivers/power/reset
Message-Id: <170778782561.1080348.15486414819584613989.b4-ty@collabora.com>
Date: Tue, 13 Feb 2024 02:30:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Mon, 12 Feb 2024 10:28:12 -0600, Andrew Davis wrote:
> Use of pm_power_off is considered legacy and should be replaced with
> register_sys_off*(). Same for register_restart_handler(). Do this
> for the drivers/power/reset subsystem for all trivial cases.
> 
> Thanks,
> Andrew
> 
> [...]

Applied, thanks!

[01/19] power: reset: atc260x-poweroff: Use devm_register_sys_off_handler(RESTART)
        commit: f22e835028902b01915f584d2912cc25a397c84e
[02/19] power: reset: atc260x-poweroff: Use devm_register_sys_off_handler(POWER_OFF)
        commit: ab1439b05168dc73539e78d8b3100a0336a83bca
[03/19] power: reset: xgene-reboot: Use devm_platform_ioremap_resource() helper
        commit: 7ddfd33c6ee58ee915d09177a7dbac2c5be7b536
[04/19] power: reset: xgene-reboot: Use devm_register_sys_off_handler(RESTART)
        commit: 6af1ee028537be0a43ce939eb8f5321096208667
[05/19] power: reset: tps65086-restart: Use devm_register_sys_off_handler(RESTART)
        commit: e68b71812ebf385317c5bcf82674c109806be452
[06/19] power: reset: tps65086-restart: Remove unneeded device data struct
        commit: 11d2642e14ad022de13f261370ccddd33693c045
[07/19] power: reset: brcm-kona-reset: Use devm_register_sys_off_handler(RESTART)
        commit: 45079f206e635a08cba395a08dd3fd7629dbb24d
[08/19] power: reset: axxia-reset: Use devm_register_sys_off_handler(RESTART)
        commit: ad8d7b8002a1d3a673f2d6f110b378d137f61037
[09/19] power: reset: rmobile-reset: Use devm_platform_ioremap_resource() helper
        commit: 0867276eb12230a5e94ec2b28eba718e76b77eb1
[10/19] power: reset: rmobile-reset: Use devm_register_sys_off_handler(RESTART)
        commit: ba1188ea8be80a7bc091073792d404ab54b187b1
[11/19] power: reset: mt6323-poweroff: Use devm_register_sys_off_handler(POWER_OFF)
        commit: 6ab9137719a719f39e000aa62887ae25e1194815
[12/19] power: reset: msm-poweroff: Use devm_register_sys_off_handler(POWER_OFF)
        commit: b5711ff9171325261a7d6406b3c2b3c7752b6b8a
[13/19] power: reset: msm-poweroff: Use devm_register_sys_off_handler(RESTART)
        commit: 00ae86ebf893e0c89a7af6bfd270259e3ded93d1
[14/19] power: reset: regulator-poweroff: Use devm_register_sys_off_handler(POWER_OFF)
        commit: 77b61173c2d0ff42e5d609dc1fad137f1229f03b
[15/19] power: reset: as3722-poweroff: Use devm_register_sys_off_handler(POWER_OFF)
        commit: 348fde771ce7f5219a73750bd7a0d4c4497b1223
[16/19] power: reset: gemini-poweroff: Use devm_register_sys_off_handler(POWER_OFF)
        commit: b6475c3f81c13d6d69113f69a668c96af3a5af51
[17/19] power: reset: restart-poweroff: Use devm_register_sys_off_handler(POWER_OFF)
        commit: c3ede0b6f7dd345d8986cb69b861cadb9976782f
[18/19] power: reset: syscon-poweroff: Move device data into a struct
        commit: ffa212831289f15a92fe295a371157290619bb8f
[19/19] power: reset: syscon-poweroff: Use devm_register_sys_off_handler(POWER_OFF)
        commit: 14c5678720bdee7c5b582839a8dbcffd0c50de5c

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


