Return-Path: <linux-kernel+bounces-131165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF918983F1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E45C1C2263B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E71745CB;
	Thu,  4 Apr 2024 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vv736jNp"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994087442A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712222796; cv=none; b=q8b+4NS82fXAj8+V5nnv13PV6BeycUzv0FwLe6Yh46tjjL6jYehV/jWJS8rmb/d3etSzNTF+YunWEdK1dmKSIBf/OmqG3/mfjg8GMHitq5nBUOb1MyDjjTFOF4qLoxpBGrzrmM6ERHXsWHM48m+uROv2orZWAZJE5Xw10UeJAW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712222796; c=relaxed/simple;
	bh=XAc3BIhJUg3umIIjqLa8/qsx1yVlz8S4sxmtR7CkB14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F2daPvUo0xBwvWgNBOGWvWJ16qBr5rtueuzf3pKJdemxPmJqTt9mOWo4wX7mKtFlgQe1pw7IlNjwFUYNZzdtEtpji0uQNFIpBHfangKS9iD4sSmOV3ZB1y0Tlq9Ahbwgb/E2HhinZvlFwRmyPH3MJaHUfX655NdK6TVq9+r6Pt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vv736jNp; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712222792;
	bh=XAc3BIhJUg3umIIjqLa8/qsx1yVlz8S4sxmtR7CkB14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vv736jNpmicCIQP5dOfis7w7uG6VPaYsYmPMO5hX/jw3+pqZAd3SM5guyyeE1DsM4
	 WVbgaRBAS5eGqZlbD4Raqgds6QwW9bG7SOqDrU769EEyZTrsGuI9GwLQOTfrcS4bAw
	 5NcR6MgYFXogzK2Eiy9wL48rCZ3nZhnax+EhnHaNz+RrGfGE1kfD1mms1zhDSB6Ahm
	 SNxvdd6Y7ndLA39+T/DknUeLRLmaXVyOThMvLaNsypHD/8UjnRUDsBHT/HEjStKJv3
	 1qAsRatLsj9Bq4act0U0JmX8MGts5JXR335bY4T++FtR77Xdon9eHwtCydfR/+eZan
	 P8j1qtVcwERkQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6A0483782117;
	Thu,  4 Apr 2024 09:26:32 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: regressions@leemhuis.info
Cc: kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	tglx@linutronix.de,
	x86@kernel.org
Subject: Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge Chromebooks
Date: Thu,  4 Apr 2024 11:26:59 +0200
Message-Id: <20240404092659.176813-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <09d67d1d-2c65-4872-b38e-665eda154339@leemhuis.info>
References: <09d67d1d-2c65-4872-b38e-665eda154339@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Thorsten,

On 4/4/24 10:24, Linux regression tracking (Thorsten Leemhuis) wrote:
> [/me added x86 team]
> 
> On 28.03.24 12:50, Laura Nao wrote:
>>>
>>> I ran a manual bisection to track down the root cause for this
>>> regression and landed on the c749ce
>>> commit from this series:
>>> https://lore.kernel.org/all/20240212153625.145745053@linutronix.de/
> 
> FWIW, that commit is c749ce393b8fe9 ("x86/cpu: Use common topology code
> for AMD") from tglx that was part of the "x86/cpu: Rework topology
> evaluation" series.
> 
>>> Do you have any insight on this issue or any suggestion on how to
>>> effectively debug this?
>>>
>>> Thank you!
> 
> Hmmm, it looks like this did not make any progress. Thomas, did this
> fall through the cracks due to Easter, or is this this on your todo list?
> 
> Or was there some progress and I just missed it?
> 
> Laura Nao, I assume the problem is still happening?

Yes, I confirm the issue is still happening.

See e.g. KernelCI report for next-20240403:

https://linux.kernelci.org/test/plan/id/660dbeed148e1a8a284c4372/

> 
> FWIW, this was the initial problem description:
> 
>>>> KernelCI has identified a mainline boot regression [1] on the following
>>>> AMD Stoney Ridge Chromebooks (grunt family), between v6.8 (e8f897) and
>>>> v6.8-1185-g855684c7d938 (855684):
>>>> - Acer Chromebook Spin 311 R721T (codename kasumi360)
>>>> - HP Chromebook 14 (codename careena)
>>>> - HP Chromebook 11A G6 EE (codename barla)
>>>>
>>>> The kernel doesn't boot at all and nothing is reported on the serial
>>>> console after "Starting kernel ...". The issue is still present on the
>>>> latest mainline revision.
>>>> The defconfig used by KernelCI for the boot tests can be found in [2].
>>>>
>>>> Sending this report in order to track the regression while a fix is
>>>> identified.
>>>>
>>>> Thanks,
>>>>
>>>> Laura
>>>>
>>>> [1] https://linux.kernelci.org/test/case/id/65fca98e3883a392524c4380/
>>>> [2]
>>>> https://storage.kernelci.org/mainline/master/v6.8-11837-g2ac2b1665d3fb/x86_64/x86_64_defconfig%2Bx86-board/gcc-10/config/kernel.config
> 
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> #regzbot poke


