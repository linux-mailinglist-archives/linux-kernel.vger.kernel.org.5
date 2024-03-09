Return-Path: <linux-kernel+bounces-97754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BCF876EFC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 04:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED991C20C16
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 03:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E4B3308A;
	Sat,  9 Mar 2024 03:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqaANVVl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5854212E5B;
	Sat,  9 Mar 2024 03:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709955395; cv=none; b=PsEltIhGvvX4dBQy3bl60+wA3do3Nk6AminVMg1I2y1Fp/7EzLZgNU3tItizPiZDv6KV+icZtujYVLUsT/3o3qmgVOTUugWlfwXqUQiy+LrNZf1wxfiqUS7REZgsKnw699cEY5jO0a+1PWfhmTtK49OS3b/9HtxxUBaZ7317oig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709955395; c=relaxed/simple;
	bh=lLn6OOrz7gmP48Oh35CDpxbACMTCrCw+ctxvAb98+Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nf/ZuyNyGGRd5kexYbPQ53S89M2fIekW9LF+rx0D77BLZDGSCVMv+np5if198jSNTd81LeY2Wn+lCAWsTFDg1T8R7kqM+csxtTETNw1PON6QCCuMSHjCzzaiOdt3KFah4afJvRVAqenvcwkijdSAkjIcepN+Jiv+5tWJcvuP3yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqaANVVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EE0C433F1;
	Sat,  9 Mar 2024 03:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709955394;
	bh=lLn6OOrz7gmP48Oh35CDpxbACMTCrCw+ctxvAb98+Uk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mqaANVVlKWfUxM9PlxRgsdjRkOrg3Jkc7oPqzWTUbZvx04x/1cYRNF3P+VXIKijag
	 E4NUmiz3bBjfL9lAizdsXBZSmscGMeEp9h/p/sqyzDUFO9oMI9IlBsgjjTwW8cxUfW
	 Kw5IEh9OHXAG47izsjv00pXaK1HY6sgvmsqtujqG1soURdCHj/haDoOXMyCoLSl9Cw
	 VuhPjnL8tjLyINJekqUutnANno5gWdwbSlAnGm/bw5j9PFoctYsCh/24OOL6UTxDxQ
	 rK88cfYz00RLkCkrLWGLDzl8vk0yvOmSnasKC03uvIkTy7lt6avJ5J+mw00rjFtcAn
	 y+NveqC5bUT7g==
Date: Fri, 8 Mar 2024 19:36:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>, Bc-bocun Chen
 <bc-bocun.chen@mediatek.com>, Steven Liu <steven.liu@mediatek.com>, John
 Crispin <john@phrozen.org>, Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod
 Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Qingfang Deng
 <dqfext@gmail.com>, SkyLake Huang <SkyLake.Huang@mediatek.com>, Philipp
 Zabel <p.zabel@pengutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/2] phy: add driver for MediaTek XFI T-PHY
Message-ID: <20240308193632.158b3c42@kernel.org>
In-Reply-To: <ZevJwSq-A43vqO6k@makrotopia.org>
References: <745f8b46f676e94c1a396df8c46aefe0e8b4771c.1707530671.git.daniel@makrotopia.org>
	<3bb95f1d795eede63284dbcb224e06ea6886b421.1707530671.git.daniel@makrotopia.org>
	<ZevJwSq-A43vqO6k@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 Mar 2024 02:30:25 +0000 Daniel Golle wrote:
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>  
> 
> It's been a month since this patch was posted. Maybe it has somehow
> slipped under the table (or even under the carpet)?

Lots of people in To:, lets direct the question to Vinod? 
Most active generic PHY maintainer according to git, Vinod?

