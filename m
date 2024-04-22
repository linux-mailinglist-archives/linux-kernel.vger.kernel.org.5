Return-Path: <linux-kernel+bounces-153174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A74438ACA95
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2FA1F21802
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9637213E8BC;
	Mon, 22 Apr 2024 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aXHYYZ4n"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8429F4CDF9;
	Mon, 22 Apr 2024 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781741; cv=none; b=Px233E0w2vy3JY7s/tsjqkb7sMxfu0xC+DInhI58Vs/5OSYTkBk4x3DR7uUJutw9jPOO7nDeOX4XqDApx/eXhLpFK44TMsVcsrJtofB6gFymrHEuf7WF9y2IKexohY9Qq/EpfoyzY16K7tI0EpqhuPZ7c02qZF2+5fQmfGR+ppM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781741; c=relaxed/simple;
	bh=DHt+L1NZgy2bz/kCHKVwRnwZpxMBqGkS0kyobZTAHeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J+lR6JnFxT1bIriHYmWs9xvs4N4odGetkvtj7wRnA2Eng01nOF4g8L6mdHAoUH0We+MvmxrWArxLGpJYONzQcKtuVXgfnYkk5xcDXMAXrucwYTMt9ilvDQJ8X1b2FNQS08CxvlPYLi8b27KU0PD/Dcc2EOL6WSd9PyZcX7UALA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aXHYYZ4n; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713781738;
	bh=DHt+L1NZgy2bz/kCHKVwRnwZpxMBqGkS0kyobZTAHeA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=aXHYYZ4n2PiIuiChBeoJeEfCMfT/QNK987vorDIA78bQqXUhIyTLyZyDlZPzvqE04
	 8MR3QgZQu6+dUJ/j4jNL1oHHTrsXuk2GA9+47GN/r3vli/dxS1f8CWfuO9Vf1FCe0s
	 UfG7Vo8SycXv3+ezVU6wAryDzwHjYbGjS3g4Z7QLGdLYVU2cuWeFRkTbqKKpya0K2W
	 m686bRCG0E/zvhT5x0ltlqjrH2WaFgp2VxurJoFRHA1Vxv5v9pCUb5+MS8yF+ENPdb
	 vePgyVWRfcmTC0SYJpX3mI5r/v9UeniWwyLadVY7MGAaHlsedM9F8MfCBP3IexO1pE
	 Ycb1sDFYsxt3A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4F7313780C22;
	Mon, 22 Apr 2024 10:28:58 +0000 (UTC)
Message-ID: <03e285d1-f718-453f-b5c7-57cc3fd01afc@collabora.com>
Date: Mon, 22 Apr 2024 12:28:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: mediatek: Add support for MT7988A
To: Daniel Golle <daniel@makrotopia.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <acf4fb446aacfbf6ce7b6e94bf3aad303e0ad4d1.1713545923.git.daniel@makrotopia.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <acf4fb446aacfbf6ce7b6e94bf3aad303e0ad4d1.1713545923.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/04/24 18:59, Daniel Golle ha scritto:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> This add cpufreq support for mediatek MT7988A SoC.
> 
> The platform data of MT7988A is different from previous MediaTek SoCs,
> so we add a new compatible and platform data for it.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



