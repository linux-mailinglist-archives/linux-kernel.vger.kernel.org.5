Return-Path: <linux-kernel+bounces-77847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF4D860AF8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E9B283829
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910CE12E43;
	Fri, 23 Feb 2024 06:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="ewCes4RB"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7A3191;
	Fri, 23 Feb 2024 06:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708671105; cv=none; b=RvgJq4HVoVfSdwKmNum363Y1zbRrNEhCuX7WyG+E7ydLFuWirYLQ8CtqFEN1d76DAPRMLVCow1/P+o3K5a3aWPjMcFGTfyS7scZGiyiHdawC91N3kKStnb3cCX3E0dmX8c41D4QoL3mKbkz2K1mRLt4QFmyGaGw+CLC1u0c09Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708671105; c=relaxed/simple;
	bh=vT9G9b43AMGM5pLTKA+EprBnUWtHeH0b5MybGw/4Lus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6Pyn5oXvmrPVLpWaJYbLD04wT2pts5oB9eavRQQctVnkTwyfx3DfHtBeRikU3TpN8N2bOhIg+OXHw60Dy7ZdY5X7lK/SZh8apHjk8s189en0RAPleI6rqJooc03j1Nct63eW1Quv1gQ32sydGbsj5zNKzuKshMuygLW0sCw2fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=ewCes4RB; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=VKc5odsoWzSfFg9pZXMb4XA+y+Mb9lK0SWDgdu2fK3Y=;
	b=ewCes4RBDuIVtSowGiiPfjBtU8mnGhuataNePolVwqCIY2I8NVnHlk/NdFb0JF
	2JO7uP/jrV4JIOPSdP7p0lmDsqAR6k4XePjSZWHEbtWdBx/4HIE/QOE1N7i1vbw4
	sbtoxKq4XIqGrKcuW0+FKjb5N1lX+BGwbz/MIpkCGR/1U=
Received: from dragon (unknown [183.213.196.200])
	by smtp1 (Coremail) with SMTP id ClUQrADnpBkyQNhlOqIwBA--.5122S3;
	Fri, 23 Feb 2024 14:50:28 +0800 (CST)
Date: Fri, 23 Feb 2024 14:50:26 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] arm64: dts: ls1088a: Add the PME interrupt for PCIe
 EP node
Message-ID: <ZdhAMmOILyw3pUz3@dragon>
References: <20240206230525.3578868-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206230525.3578868-1-Frank.Li@nxp.com>
X-CM-TRANSID:ClUQrADnpBkyQNhlOqIwBA--.5122S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIco7DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFRSNZV6Nm6C1PwAAsL

On Tue, Feb 06, 2024 at 06:05:25PM -0500, Frank Li wrote:
> From: Xiaowei Bao <xiaowei.bao@nxp.com>
> 
> Add the PME interrupt porperty in PCIe EP node.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


