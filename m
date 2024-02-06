Return-Path: <linux-kernel+bounces-54657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B54C84B21C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E27A1C234CB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76F112EBDF;
	Tue,  6 Feb 2024 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cCe7Wzn8"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5568912EBEA;
	Tue,  6 Feb 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214232; cv=none; b=EE8v0FbkemTKIWz+m5wqSTGItUPmuzh7WD6OEKEs/vX3sfbJBqMSFlmg2N3va1eduWFBphHnvR8/aCZALhSTGj/6LTRSP0lU/KERDs7bl+UaFX/1EhJF9FNtTkd1eZ0PuccfTGsp17J5il2gC1hrUrmkHzC/Lu1TnVE/OoPgsW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214232; c=relaxed/simple;
	bh=c0L7QZYigfyLPmzRjA6nS5GyM2Z1QUEWyvUjNZ0gam8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nz2/3t5fF1FlbvH8WdID/vypbDVXkwJB4E11XIb/nsbWPeCQYYHAq2ykXcEwtv40/QKPG/f5nXJBlA4IhohqIxpwsy5tE6Kwy6mcutNMFh756/roCqSYA3xyEBJigCC+NDcEmJWLsXAs93w9HJNmlLaPxhOeMQv8LZ8iqhAU2ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cCe7Wzn8; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707214228;
	bh=c0L7QZYigfyLPmzRjA6nS5GyM2Z1QUEWyvUjNZ0gam8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cCe7Wzn8mB/Qc2IlweE/YDlAx4XfeacuEPNZi8O5b3+sWsF5QBYAPAlU8rHBGvUJ5
	 cdYZNevT/tmv/Z9t+j6a2Jg/g1075A9U8lgYjj5/WGb9cJUz5RLTmRDexmtlovQuH3
	 h9JcY1hYhAIp2LNyNV1I9F0ENfUFbbHx5uTFbw0zBVJQHyAnKQQVmwcVHuosS2xfEY
	 aJUB2kf/OqPh4vwKTtBi37VW8i1XMzYjoFndzVRFeDlwFffATcEznXu3JiNaCNloPV
	 ojLHP6VhrNJvj0jaFYF4XH3rZZPEVIJOMraFGnSkKBIONqH28EdUrgwwP+ysHQZeOG
	 cV5jZtl/Nr+Ew==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A72AA378206B;
	Tue,  6 Feb 2024 10:10:27 +0000 (UTC)
Message-ID: <d5998dd4-d582-488e-b3ef-98ea9737dcfb@collabora.com>
Date: Tue, 6 Feb 2024 11:10:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pmdomain: mediatek: Use
 devm_platform_ioremap_resource() in init_scp()
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <da6af483-5ee9-45cd-922e-d9d5364674dc@web.de>
 <CAMuHMdUxn4Ne7kmEfONz8Uk3Why3m9r83GdM5RzTxm_4Gj_a6g@mail.gmail.com>
 <6e397bf2-1d45-434f-8619-58a737a138e3@web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <6e397bf2-1d45-434f-8619-58a737a138e3@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/02/24 10:21, Markus Elfring ha scritto:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 6 Feb 2024 10:05:34 +0100
> Subject: [PATCH v2] pmdomain: mediatek: Use devm_platform_ioremap_resource() in init_scp()
> 
> A wrapper function is available since the commit 7945f929f1a77a1c8887a97ca07f87626858ff42
> ("drivers: provide devm_platform_ioremap_resource()").
> 
> * Thus reuse existing functionality instead of keeping duplicate source code.
> 
> * Delete a local variable which became unnecessary with this refactoring.
> 
> 
> This issue was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



