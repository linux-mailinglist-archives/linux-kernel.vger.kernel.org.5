Return-Path: <linux-kernel+bounces-116379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DACC88899A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961B02A1750
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951F212F5A6;
	Mon, 25 Mar 2024 05:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rL3+HMty"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8BB14A606;
	Mon, 25 Mar 2024 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711331663; cv=none; b=R2TkN1px4vuLS+vcLlOmYx8at8lOBxHIM+zVtL56H0LKjF3LknOurJFOnSZJHPJRPnMB+LsLruuk+XnMcz6befx0qOosgNgA75GP9OmZQeno+bwtlIWf+MAX//Uc3AtzuGeg4icAAfN5QbbHGxGI3HDGDgl/QJMSZLM2khN+KUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711331663; c=relaxed/simple;
	bh=ojOvuJS5jAKIVgnuu4Wz3oDaixRKiajNf9MRBrzuQ5Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mmlI5TcJvhdX7WLSgRFeDRQSuCVghi6OqZP3d+wKgTzR5Y3hRnHJn83OCzxqUjRFLjPjLsrVsMUj3tYZy3Ce2nLK8ff8JpLU75xkhi99LL56HB15A/XrsE6NhHz8EiGUGKMry5Te7IcVIGsjI6C65Mc20lCyY5j2LcQMdf732so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rL3+HMty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 854ADC433B2;
	Mon, 25 Mar 2024 01:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711331662;
	bh=ojOvuJS5jAKIVgnuu4Wz3oDaixRKiajNf9MRBrzuQ5Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rL3+HMtypHYBa4J7uPg7by0dwLSvnBXl3ADMS5FAGRkhMQuz1yb7QxSprvv8h5w+O
	 VR0SOphVx5QiK4LWWWG7g4lPmjsmWKPfbrttgecDxFjAuf4RKjN9+6L0cehPrFAVdL
	 hgcrODZvBAkGd5q0pgFstXbhIDGDmk97mtQEmSndRxo+xBSljiPrLgdtyR7qRnXksL
	 W5tkbEOnOhE7GiKau/9sUZ4xiMB6SonhQyE85kx9yaaow9Qet8YSMOBuZcgSlttPi6
	 +S6iFSfIp8Y61YVa00fCb3OlaEL/5m43MOcCZbus46mVj9tarGw5AYGmr5OKaZctt0
	 JSEYFP48at7AA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B479D2D0E5;
	Mon, 25 Mar 2024 01:54:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/4] Allow coreboot modules to autoload and enable cbmem
 in the arm64 defconfig
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171133166243.9916.3802194200601946624.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 01:54:22 +0000
References: <20240212-coreboot-mod-defconfig-v4-0-d14172676f6d@collabora.com>
In-Reply-To: <20240212-coreboot-mod-defconfig-v4-0-d14172676f6d@collabora.com>
To: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado_=3Cnfraprado=40collabora=2Ecom?=@codeaurora.org,
	=?utf-8?q?=3E?=@codeaurora.org
Cc: tzungbi@kernel.org, arnd@arndb.de, briannorris@chromium.org,
 jwerner@chromium.org, masahiroy@kernel.org, nathan@kernel.org,
 nicolas@fjasle.eu, catalin.marinas@arm.com, will@kernel.org,
 angelogioacchino.delregno@collabora.com, andriy.shevchenko@linux.intel.com,
 gregkh@linuxfoundation.org, kernel@collabora.com,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Mon, 12 Feb 2024 09:50:04 -0500 you wrote:
> This series adds the missing pieces to the coreboot bus and the module
> alias generation to allow coreboot modules to be automatically loaded
> when matching devices are detected.
> 
> The configs for cbmem coreboot entries are then enabled in the arm64
> defconfig, as modules, to allow reading logs from coreboot on arm64
> Chromebooks, which is useful for debugging the boot process.
> 
> [...]

Here is the summary with links:
  - [v4,1/4] firmware: coreboot: Generate modalias uevent for devices
    https://git.kernel.org/chrome-platform/c/c2b28f6806d2
  - [v4,2/4] firmware: coreboot: Generate aliases for coreboot modules
    https://git.kernel.org/chrome-platform/c/f1cebae1dbf8
  - [v4,3/4] firmware: coreboot: Replace tag with id table in driver struct
    https://git.kernel.org/chrome-platform/c/8a0a62941a04
  - [v4,4/4] arm64: defconfig: Enable support for cbmem entries in the coreboot table
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



