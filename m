Return-Path: <linux-kernel+bounces-104402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287B487CD57
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8900EB226AC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2AA286A6;
	Fri, 15 Mar 2024 12:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aPai7EW8"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377EA1B7FF;
	Fri, 15 Mar 2024 12:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710506174; cv=none; b=UGhEDS1lyVHZkQU9gBkIa4pWHp054+Ai9y5TQtsEhk+ZQ85kmvfY36RvzyvXhTlEXSFyB8WmpVz7+ytjPOpiT14hkLon54oTgMYNiWonvAJ68XrOvwpdbpZwrCc4yzwDXw2QJd/ksQbOWoBkA2sTUlV51Ugul8tNrMcb+Hrig/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710506174; c=relaxed/simple;
	bh=qVRS4AlDH1tcDYo6iWSXKnhmVMUJuEjn+DOA54u7xMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9ukBymVJM4ACVOcYc9IK3Z6dd8rdYpCRYxqxFXtpxDAHNH5N44tv8QeJN+2qxvhseDpqKxtJw4wiEsp3p6bvnj+//D4A+DIqK8IO9w2cqoo06umigxrIWGPeikLz4IWTEqcbBcCWYW9S3RVZm4++EJlv2PC3hEHDn4wCxdb9fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aPai7EW8; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710506171;
	bh=qVRS4AlDH1tcDYo6iWSXKnhmVMUJuEjn+DOA54u7xMM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aPai7EW8s1C94a3NwOZ9T8QgoTHIn62FC0363nl0OCDEY3e+QbFWgq0jQCpNMJmBN
	 VlZXL/D+1xLhQg4jMaxATJnWs6+5Rhy8wahe7iD1m+5woJvrx0IWdcDb9XkemoGsMN
	 1KnpgoShiGson45u9i2LqDcO4vBuPvDQlHJK+uu97Hg1rxiqRLQLELTQtr0oZ5eU/0
	 chTeMThixOtFDCxjkixTAlNiD2eMgDPfOuwjzYnLFn/8rulTgIC3u9UhP0nK9BoYCB
	 Hzqe4D4or2IZf0dCpe38Ok0Z5VqWaidD46HqE2j63Q7aiGSfREC/vSLT6ZOcAbr6F1
	 CC2d+42RDUmJQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CA09E378210F;
	Fri, 15 Mar 2024 12:36:10 +0000 (UTC)
Message-ID: <3a3caf05-64af-4354-aa11-0880b66e91e2@collabora.com>
Date: Fri, 15 Mar 2024 13:36:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: dts: mediatek: mt8183-kukui: Use default
 min voltage for MT6358
Content-Language: en-US
To: Pin-yen Lin <treapking@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 linux-mediatek@lists.infradead.org
References: <20240315111621.2263159-1-treapking@chromium.org>
 <20240315111621.2263159-4-treapking@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240315111621.2263159-4-treapking@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/03/24 12:16, Pin-yen Lin ha scritto:
> The requested voltage could be lower than the minimum voltage on the
> GPU OPP table when the MTK Smart Voltage Scaling (SVS) driver is
> enabled, so removing the definition in mt8183-kukui to use the default
> minimum voltage (500000 uV) defined in mt6358.dtsi.
> 
> Fixes: 31c6732da9d5 ("arm64: dts: mediatek: mt8183-kukui: Override vgpu/vsram_gpu constraints")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



