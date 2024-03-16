Return-Path: <linux-kernel+bounces-105244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BAB87DB04
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF31A1F21A51
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252381BF5C;
	Sat, 16 Mar 2024 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ebvg+W0U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638C61BC58;
	Sat, 16 Mar 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710609629; cv=none; b=gsc1c3uIuogZTpv/kU1kDgPtAqCSCkZo0HU+btNrL+PNAOaBZOrKwd25qyEsdosuVEi7BqRXoJOf8biAK7ZdiesSxmng+42+jdgVjpVpSeD8sUYcclXEhSqMC17SjJEfwlg75JnaxPyR5TiMRzihqG1UePTWWzt/Lh03D221BRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710609629; c=relaxed/simple;
	bh=14g6XW14/FQppYz6RFIEUed+PC+05r6isL19pE+03U0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=paeO0a3ymT74L0CmXzZEapKMI5q/XYwUtv4fA+ZyJtlaBAT+ToHiFwCj1mdBNU3rOtNkWUGXTQ1swWv5zSylXbk1hDTQ/gyczwO2IrEFfqVzMEAb09Z85ddlTWIpw9xRXMiiiXtLybpdxbOuP9gbNC0pOEAf7x7O7EdJ9IMZp1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ebvg+W0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32EA2C43394;
	Sat, 16 Mar 2024 17:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710609629;
	bh=14g6XW14/FQppYz6RFIEUed+PC+05r6isL19pE+03U0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ebvg+W0Uf+kFXwtsLiKtJIKz5ukMYB624TdlsHFJxa6xnIdgglXf+gjBIcxmoSJsy
	 ehqDnSUHfpNgm+V4N/xBiTv18WeEe0I3s6GnROT579BV0YfoudN+htgLpHshQxKxoO
	 tsK4Qw3UQP8FICXFctJWaxSHh60pTvyK//p0ZVDrBy/HnhIZb4TR3GfnnND/cgxAJQ
	 k7J3szXkq9oE+mMmufQKZuQefJeWkf5O+im7RjPdtOVTAvzTMZfFBMV742drydhncc
	 J3ZZKvXxI6YYVDB+w+Rf7yP6mo39eqLAYN15dK1xGu5XC2pzzOuisf/8mwxNyg4Xbg
	 EGZVmvOnb5w0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24A0CD84BAF;
	Sat, 16 Mar 2024 17:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2] Bluetooth: Add support for MediaTek MT7922 device
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171060962914.7860.3606951937987322680.git-patchwork-notify@kernel.org>
Date: Sat, 16 Mar 2024 17:20:29 +0000
References: <SYYP282MB119734BDF1275B7453AE84C7AB282@SYYP282MB1197.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <SYYP282MB119734BDF1275B7453AE84C7AB282@SYYP282MB1197.AUSP282.PROD.OUTLOOK.COM>
To: Ian W MORRISON <ianwmorrison@live.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 15 Mar 2024 18:48:08 +1100 you wrote:
> This patch adds support for the MediaTek MT7922 Bluetooth device.
> 
> The information in /sys/kernel/debug/usb/devices about the MT7922
> is as follows:
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3585 Rev= 1.00
> S:  Manufacturer=MediaTek Inc.
> S:  Product=Wireless_Device
> S:  SerialNumber=000000000
> C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
> A:  FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
> E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
> I:  If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
> E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us
> 
> [...]

Here is the summary with links:
  - [V2] Bluetooth: Add support for MediaTek MT7922 device
    https://git.kernel.org/bluetooth/bluetooth-next/c/f4a0fc6780c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



