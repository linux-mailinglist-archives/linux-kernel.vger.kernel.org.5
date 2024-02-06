Return-Path: <linux-kernel+bounces-55307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AD784BAB0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E101C23FEE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F650134CD3;
	Tue,  6 Feb 2024 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WToGyYlH"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C0512FF7C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707236048; cv=none; b=EgQuVsvTqB0bnkUZwJD93bDrQp/iHwFKQ2HJVq3UokzobPWZzxHOlv1NX8tes2c70KEthQMCCx0nEj66cJXYCj2a6zce9eJet1epweuBvv0GbUf21n36uV1Ozt7b59ejPT8OigJFK/fyv/zg67emdJNhOubo1FONyMIcUZPLwC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707236048; c=relaxed/simple;
	bh=tEkx7A+6AgwnGEsLHznPy0/5jiVXyn3+twjXfInoCys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ok1bSGLPzRKUnjgQOI32k8sz5mjMJKu8AAFRSZ6FcNG/ZJcxGSHXLwbsiblvZZ8qqAfT3jXxb+DZRChUGr6dC4nzVEZMdPNp4JU/Oi5cJrehDBaohahUkwgpl5rV1uHNZtFlLBI4+8D9daH+crlnrVxS9Q3oLCaJR/kkrRwxsGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WToGyYlH; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707236045;
	bh=tEkx7A+6AgwnGEsLHznPy0/5jiVXyn3+twjXfInoCys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WToGyYlHypkBbAwLW4E6hcECZpmOLTfS479VjD4Mlrn/B46Wz9TeUA7QgBp24QPOK
	 dc+XfhXoxoM71FTqCo1dqfGHSlUszPL3KuJ1HrrqmUWEzLTtzPoUan514gzI4UjISi
	 VMqGtu6hVyQFgWi6KY43HNH1/rvPW0kddbPAi7Up6/yued8KwmoDYoW3Sx4tCnyn4e
	 m9PZ6B94sCLnC2JFKPjgwagv5a/L9rtSn6Ei61vcGtkjB+k7iuZo6j4NjTHUglkpi0
	 95SCLW4c6IGpNpYCfyijYe+VrlSFAfF7s7akrx0gd6WDEKHQ3tfCVO6/pkcqzjtQMV
	 fj08YCB6d+pxQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E00F637803EE;
	Tue,  6 Feb 2024 16:14:03 +0000 (UTC)
Date: Tue, 6 Feb 2024 11:14:01 -0500
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	William-tw Lin <william-tw.lin@mediatek.com>
Subject: Re: [PATCH 3/3] nvmem: mtk-efuse: Drop NVMEM device name
Message-ID: <915f1ec3-a70a-4b56-9e93-5b597fc770cd@notapiano>
References: <20240130095656.3712469-1-wenst@chromium.org>
 <20240130095656.3712469-4-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130095656.3712469-4-wenst@chromium.org>

On Tue, Jan 30, 2024 at 05:56:53PM +0800, Chen-Yu Tsai wrote:
> The MT8183 has not one but two efuse devices. The static name and ID
> causes the second efuse device to fail to probe, due to duplicate sysfs
> entries.
> 
> With the rework of the mtk-socinfo driver, lookup by name is no longer
> necessary. The custom name can simply be dropped.
> 
> Fixes: 4e6102d60d88 ("nvmem: mtk-efuse: Register MediaTek socinfo driver from efuse")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

This does fix the efuse (and display) probe issue on MT8183. FYI I've sent a
regression report for it at
https://lore.kernel.org/all/47cdeac1-121d-4b1a-a3ac-e2affc7a2fc3@notapiano

Thanks,
Nícolas

