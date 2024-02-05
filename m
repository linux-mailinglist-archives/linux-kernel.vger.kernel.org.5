Return-Path: <linux-kernel+bounces-52911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 034C0849E2E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F4D1C218F5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED432D610;
	Mon,  5 Feb 2024 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MLa/SRbB"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C572D05A;
	Mon,  5 Feb 2024 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147116; cv=none; b=dIsIqc9AWeCXDFjCXz2lxhcDDsWK5B6eAqX6fxb4pkDBg50qIgaEOuWzy/pSzqc1xo79L/jlo5I/UUhUrfwJxYDgtVAruZLehJzD//XwxZ1DHoYRn7rCAwHjbr4LZZAuRZWF2yKk4dh7DmlWYmg+ltlAMZnTeRERrhFJbTwaIyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147116; c=relaxed/simple;
	bh=8snPz5SG3U7m1WhMLbVGZPjJdXl3YDQbMd0wdwiDQUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PfhFskdR1oKAno/NzW8TW0MPCJHvoIVKON/Oa2K8jsexnNqJhjzeNyuuHXMkS/KLYdhL/AsTIMRoNvNVe1L7sGkZS5+kRR24fNvRHlD7HOQNuUX3MeFJRHi4ZLDzz0hdCbaYU6R1kFQtCFXpLjStcS3HmlIFhOrVE7kOTGQUPNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MLa/SRbB; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707147113;
	bh=8snPz5SG3U7m1WhMLbVGZPjJdXl3YDQbMd0wdwiDQUI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MLa/SRbB6D+KCjcUqvcFgqX3P6BgkTBZbWRnH0sYReMq04vsIR7XrADyPkdgWN1BV
	 fVxwZ7qnvAZcsnJntJhIB4Eut7W4zWVh8C6kXd50V1yYaj55xqIDInFJ1BuLfWmfDJ
	 6pxeHDxi2HxBhY+eHjxp1EpT1UpOjL9XSl7/YY1llLl5EqEpK1aSQd3gTo1nu+hFX6
	 TmYdHMJpTFlYj7wflYj/WieA9HoHRQYuMgkjDGOChW7wduNE3ZpEGjSq027pvkAmNr
	 FgBTFIxgFG6/IbWXGYZ11UvX90dFGmIGUvTMEgFbHdFjHOt3Z7kemIt6atJqRiS1dH
	 LTqV00pOy2ptA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 35B2B37813E4;
	Mon,  5 Feb 2024 15:31:52 +0000 (UTC)
Message-ID: <1b2538a1-d85d-4a62-8c9a-24ce93613080@collabora.com>
Date: Mon, 5 Feb 2024 16:31:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: Introduce the MT8395 Radxa
 NIO 12L board
Content-Language: en-US
To: kernel test robot <lkp@intel.com>, linux-mediatek@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, wenst@chromium.org, hsinyi@chromium.org,
 nfraprado@collabora.com, macpaul.lin@mediatek.com, sean.wang@mediatek.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 stephen@radxa.com, tom@radxa.com
References: <20240202114821.79227-3-angelogioacchino.delregno@collabora.com>
 <202402041754.SHJCpnEP-lkp@intel.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <202402041754.SHJCpnEP-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/02/24 10:31, kernel test robot ha scritto:
> Hi AngeloGioacchino,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on linus/master v6.8-rc2 next-20240202]

Whoever is reading this... yes that's all expected; this series depends on a commit
that was already picked in the mediatek trees.

https://git.kernel.org/pub/scm/linux/kernel/git/mediatek/linux.git/commit/?h=v6.8-next/dts64&id=d464e09e60f024aea0de7adb680a8e8582ab8df8

Regards,
Angelo

> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/dt-bindings-arm64-mediatek-Add-MT8395-Radxa-NIO-12L-board-compatible/20240202-195207
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> patch link:    https://lore.kernel.org/r/20240202114821.79227-3-angelogioacchino.delregno%40collabora.com
> patch subject: [PATCH v2 2/2] arm64: dts: mediatek: Introduce the MT8395 Radxa NIO 12L board
> config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240204/202402041754.SHJCpnEP-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240204/202402041754.SHJCpnEP-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402041754.SHJCpnEP-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> Error: arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts:791.1-8 Label or path ssusb0 not found
>>> Error: arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts:804.1-8 Label or path ssusb2 not found
>     FATAL ERROR: Syntax error parsing input tree
> 



