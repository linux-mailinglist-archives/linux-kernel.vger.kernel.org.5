Return-Path: <linux-kernel+bounces-78088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 122BC860EBD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFA4285FCB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B7B5C916;
	Fri, 23 Feb 2024 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="WJia82bJ"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1998618E14;
	Fri, 23 Feb 2024 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708682110; cv=none; b=R6jsOgUSJvWK66ixFRUTHddA4EOzNwgnRbWbOFqhSgpf5hOwuio/EXVo9ifud6ZlilIaCNcJtrvkMGJxLgzHgFAGk0sWRbIPEblbmv9GIVzmhVYvI9Xs405coiZUftGv/s40smigiCPmFe5Ncs9ooFkiv6k07Qqeojcpqk4u8Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708682110; c=relaxed/simple;
	bh=0E2n95rnjTTZ2Ws2bGPAeBdPeTsco6peetfmdUDP3VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+JzjYboCZVdU7lsKt7UNRJMDeaoF0a5K0RbWj6757KYKbRJg3S+bjSSGb2cedp+fLKXAOp/wmu/TfBYRuBdKKwm6Dj04qDGYAvGCms2Wk+v64rZCGMakJ+3RJw60LrhYXaK/QMIKjBw8YI7B/E+rUJYsrYila7344SRUZqcsRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=WJia82bJ; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id A7D49865F5;
	Fri, 23 Feb 2024 10:54:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708682100;
	bh=3qKTfJi8o8tNWbQi3rhDcA+/uzL369N4mvuptnnr0JQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WJia82bJfCE0ylDKeHSD7jDKnVcQ2DxS4MT1uqx5w58SzDDQhzRdQECLoR3orlV3G
	 xO4N9g0wLkU0vTTaWvzloMVD/bcEuBrOQsRqYHXph8K4insNtBcl88rjk+Vclk+/ik
	 6RPbu1HLnyInwiFRuDV5kwqxifALYwSdzsc1vPE3yjvo59GhyZ8amzqL0mcKWpSmns
	 TGJ4i95KYXkNwR6tJgyGNKDZWJjhxjCp6b/TMMbe2rGd4rkVhOlf9t6AS9qD5/Db9S
	 EH9IdUy96oYN1JjiO1DT7tKxC2v3wb7cQbVRp8y9JjVWjFHeouTFndqbdDn0zg8qqs
	 TxDL0Lyk0sRmg==
Message-ID: <906acc9a-0dc2-4b39-a2f1-297690a7db63@denx.de>
Date: Fri, 23 Feb 2024 10:54:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx8mp: Fix LDB clocks property
Content-Language: en-US
To: Liu Ying <victor.liu@nxp.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, linux-imx@nxp.com, l.stach@pengutronix.de,
 alexander.stein@ew.tq-group.com
References: <20240223091522.2880155-1-victor.liu@nxp.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240223091522.2880155-1-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2/23/24 10:15, Liu Ying wrote:
> The "media_ldb_root_clk" is the gate clock to enable or disable the clock
> provided by CCM(Clock Control Module) to LDB instead of the "media_ldb"
> clock which is the parent of the "media_ldb_root_clk" clock as a composite
> clock.  Fix LDB clocks property by referencing the "media_ldb_root_clk"
> clock instead of the "media_ldb" clock.
> 
> Fixes: e7567840ecd3 ("arm64: dts: imx8mp: Reorder clock and reg properties")
> Fixes: 94e6197dadc9 ("arm64: dts: imx8mp: Add LCDIF2 & LDB nodes")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Reviewed-by: Marek Vasut <marex@denx.de>

