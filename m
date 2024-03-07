Return-Path: <linux-kernel+bounces-95337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC749874C6F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C821C22C38
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEDE12838A;
	Thu,  7 Mar 2024 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="euxAtePE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9E285641
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709807593; cv=none; b=WWVrKMLrHOq5Pc2v7swCwJPs27iU+OwJfJ2/pt8rfpsN8Ch4ijtA0KO5bhDVmx6sV7IR/H3KVtFqjzSRqtCfD5GiOfJPDfYgcz1rKsJGT91wdjr2NMOwr9W7lhuEPi24SKKY2dJSujGH1QvK/oBegGabuWpfIPd/0i0DFIc/dzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709807593; c=relaxed/simple;
	bh=bBunPHKSmHGf8l/+2/CVYxGsnfGs5hi7pWNxqAObtxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgOHXMfub6rF5bOpajrerQOpdytC8vR+M+nx+APWkt6lQKTXZjfceku1pi6CzeShLsFOKrB9gDPhxPmi93ixn1QOcsRE3Q2o2VdAUCbAh2AJ7BCpab0ZZSyqdDNu1P6Qrg46IfQXn2NK2zAqQj4vTgTGsZDi6SLO6Yv7iybyLwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=euxAtePE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709807589;
	bh=bBunPHKSmHGf8l/+2/CVYxGsnfGs5hi7pWNxqAObtxU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=euxAtePErViPvAXDPjS/CT8y1c0eP4O2jbOK+Ntj2k+uP3KihT8Y9T8Ph9mWIEzVS
	 k1DL5I2VnPAlIguTwBTqNeVSAaASO2ecbbmmwUiFH6QMD02RIjuiZFqLRE52byf4LQ
	 nBymRvsQ+WNlKibzp3IyPP5xFoTPjWkbQUBKTNtW4llrB2yBx/1z0RjHBthDPNn/Cr
	 dJHTZfHLKVeB+KbbQQnAw387zZ6XhYn17J0jWWnLLUt9XnxrM2Vl6xnhwsyX7XAvE+
	 F3RY0KKrlArY0Au6jemtGEigfU3xXQ+WpO46TJXaUNCvY5mNCDSp3auKSaLPa/mKBD
	 5pHk4+yPOx1gQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D98C837820EA;
	Thu,  7 Mar 2024 10:33:08 +0000 (UTC)
Message-ID: <a0d01d84-60de-4728-9b36-c66fb2561ba9@collabora.com>
Date: Thu, 7 Mar 2024 11:33:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] soc: mediatek: mtk-cmdq: Add cmdq_pkt_mem_move()
 function
Content-Language: en-US
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Jason-ch Chen <jason-ch.chen@mediatek.com>,
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 Shawn Sung <shawn.sung@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20240307013458.23550-1-jason-jh.lin@mediatek.com>
 <20240307013458.23550-3-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240307013458.23550-3-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/03/24 02:34, Jason-JH.Lin ha scritto:
> Add cmdq_pkt_mem_move() function to support CMDQ user making
> an instruction for moving a value from a source address to a
> destination address.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



