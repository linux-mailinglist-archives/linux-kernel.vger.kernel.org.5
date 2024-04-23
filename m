Return-Path: <linux-kernel+bounces-155240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FABB8AE741
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7F91C23223
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601F112BF36;
	Tue, 23 Apr 2024 13:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="BAIGnqw9"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3C1126F3F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877276; cv=none; b=jquZxQwxbt8rEqx0oNvtyTeuc3awOekAaaS56Ry8sVGbBJLnpfTgiloWLA15uj651ibAYBYKvJosC9JEOVR7j3kKy2Zw5EKkc6LU5UbhAetumrLSVsRmyP3g/h4UAxX4rD5hoI2Srim1pspEvvXPQhf9/UMi4ILw0l4U3tOHeVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877276; c=relaxed/simple;
	bh=jYxcIHesv2ljqogqgbueoJU2yrwkh8HM8rNpxR5845g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vuwtub5wrC8gRlaF2kVgLjDjmeQd6HwtKOaPXrdv9KOwHL20MOppY9AOknMePCG/noBze0OgOYyaqxuaBXuoxWDEkSeeH/NGP9uh9BTzoYfMGvrE7Plil0BRPbn6EC1xH6VaiUJmvsY1VWvkZYFyPj+kM4pw38Wbghzj4MUdSpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=BAIGnqw9; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1713876346; x=1716468346;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jYxcIHesv2ljqogqgbueoJU2yrwkh8HM8rNpxR5845g=;
	b=BAIGnqw9O3boWcPyVc2sOH/TzsgXWEBf3hixk19wN5obXCLGTiQiKmpJzhrBv+xg
	Q6C/rfkL2m28cuXg2ueNd68XMYqkH8aKCPQ1UzXUB1TDCRJduGK7j4hbl3kvJjMO
	+Gh0xD6UeKTUqUQ9MxrumsKSjQBfJyO7ZcMdIefsKgs=;
X-AuditID: ac14000a-fadff7000000290d-96-6627ad7a000b
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 9D.34.10509.A7DA7266; Tue, 23 Apr 2024 14:45:46 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 23 Apr
 2024 14:45:45 +0200
Message-ID: <654d0b27-1b50-499d-8986-90f12655b4bb@phytec.de>
Date: Tue, 23 Apr 2024 14:45:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: Enable overlays for the
 am625-phyboard-lyra
To: Nathan Morrisson <nmorrisson@phytec.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
References: <20240419193552.3090343-1-nmorrisson@phytec.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240419193552.3090343-1-nmorrisson@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWyRpKBR7dqrXqawZ/NihZr9p5jsph/5Byr
	xfLPs9ktXs66x2ax6fE1VovLu+awWbz5cZbJ4kPjZjaL/3t2sFt0v1O3+H/2A7sDt8emVZ1s
	HpuX1Hv0d7ewevy5+I7V4/iN7UwenzfJBbBFcdmkpOZklqUW6dslcGW8b2xmL9jHXnHr8Xy2
	BsbFbF2MnBwSAiYSz1qbWbsYuTiEBJYwSUx4vJENwrnLKDH9+jwmkCpeARuJG682gtksAqoS
	+/7MhIoLSpyc+YQFxBYVkJe4f2sGO4gtLBAkcX7nUxaQQSICSxklHq/awQTiMAu0MUo8eXiA
	GaRKCGjq6WfdrCA2s4C4xK0n88GmsgmoS9zZ8A0szilgK/FzyS6oGguJxW8OskPY8hLb386B
	miMv8eLSchaIf+Qlpp17zQxhh0ps/bKdaQKj8Cwkx85Csm4WkrGzkIxdwMiyilEoNzM5O7Uo
	M1uvIKOyJDVZLyV1EyMo5kQYuHYw9s3xOMTIxMF4iFGCg1lJhPfXH5U0Id6UxMqq1KL8+KLS
	nNTiQ4zSHCxK4ryrO4JThQTSE0tSs1NTC1KLYLJMHJxSDYyOSodMb726c2pfxaG+d90m3d3T
	Iq7W+l3VDEtJcWPeb3ysJ+vMRyHPjvWzHt4NqWhp3H953eeNwlXhi5ce9Pxm5Ds15/uU1+ou
	L2VOON/yk94pZtmqlflJPkZ58rJNQa4sbAulN/OmWM71CF3YsiyqtWWP/sRXXzSi/19PqHp5
	r+TmhrtOXi+UWIozEg21mIuKEwGjwJ5/pwIAAA==



Am 19.04.24 um 21:35 schrieb Nathan Morrisson:
> Add symbols when building the am625-phyboard-lyra-rdk DTB so
> overlays can be applied.
> 
> Fixes: d8280f30a9cd ("arm64: dts: ti: am62-phyboard-lyra: Add overlay to enable a GPIO fan")
> Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>   arch/arm64/boot/dts/ti/Makefile | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 9a722c2473fb..3fa1257efcd3 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -169,6 +169,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
>   
>   # Enable support for device-tree overlays
>   DTC_FLAGS_k3-am625-beagleplay += -@
> +DTC_FLAGS_k3-am625-phyboard-lyra-rdk += -@
>   DTC_FLAGS_k3-am625-sk += -@
>   DTC_FLAGS_k3-am62-lp-sk += -@
>   DTC_FLAGS_k3-am62a7-sk += -@

