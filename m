Return-Path: <linux-kernel+bounces-55263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B028F84B9E7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5C81C218A1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D487D134727;
	Tue,  6 Feb 2024 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5PEXFWi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133DC12FF7C;
	Tue,  6 Feb 2024 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234114; cv=none; b=IqYJtgGGt5EIpNz5MhoAUnBBDtEJTsHKYpkBBMqaxz09siwWevR/R084mGctf1aMGl2QLPqDSLt2k8aosug297bxtsCVCogiP8DX6L7pWpGzbdvx+F+2Wgu1hWb9Je6P3dfkLLWMRJ+QqGT92LiSV0GcXSak0BWGp1/Vo1Xt630=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234114; c=relaxed/simple;
	bh=oScgEk/aYGptFrrB5MOL3mgXZxvV99oi26hFKVq4TEI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3Qr34s7BL9dcLc8ad/PSr1et4E+RRdA68M3JWUlYliuw218yxX9P9pzZpakEsY5eI3WYrNlyiWDWko7TB+hTd0pJf939zssX0/yqGJ/XzvYQWDYQNCQhkWNBMpCQPEVON7CylGem2oekQfdHoQQ+WSMwsycF5Iu+SoOCk4Gko4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5PEXFWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB900C433C7;
	Tue,  6 Feb 2024 15:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707234113;
	bh=oScgEk/aYGptFrrB5MOL3mgXZxvV99oi26hFKVq4TEI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V5PEXFWi9i5rYkXQ5IgEyli/kRnLL882F4isFuO3YOhdDC0bySwvHTQMrp9lO2zJd
	 Q/r3/n/3VArTkyqxcmyjLDGa/ejbzXHaaySay2O6gpAk7YJorMIL/PezDxeWFCmbxR
	 PN7xN31c/tXSKPkD+rkMg8Bw6dG8I6XTi7vSqzbxD7c4L4o8kRBU/N9dkoMD1MLXOY
	 4Es1+g9vfVkuSiXd/bWyXaSMqjgDmP4IrIlpM338vspj3GVxIp3OhoPI8w5YTb9h23
	 nJdWByHzRBN3/JQpEItntVE9sDkf1DLQ6U2i8/qRdHK9T3A1iISOP6dtxAdPc3dmPS
	 4EfEfHuBYE+Ag==
Date: Tue, 6 Feb 2024 07:41:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Frank Li <Frank.Li@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Wei Fang
 <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
 <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 0/4] Add 8qm SMMU information
Message-ID: <20240206074151.577d33f1@kernel.org>
In-Reply-To: <ZcIPCxgO3Gxc/aXh@dragon>
References: <20240201-8qm_smmu-v2-0-3d12a80201a3@nxp.com>
	<20240202110511.135d26b7@kernel.org>
	<ZcIPCxgO3Gxc/aXh@dragon>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Feb 2024 18:50:51 +0800 Shawn Guo wrote:
> > Any preference on whether all these go via a platform tree,
> > or should we pick up the net patch to netdev? I guess taking
> > the DTB via netdev would be the usual way to handle this?  
> 
> No, it's not.  Taking DTS changes through arch/platform tree is the
> usual way.

I said DTB.

