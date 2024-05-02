Return-Path: <linux-kernel+bounces-165984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BC08B943B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7302C2832B9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8592032B;
	Thu,  2 May 2024 05:30:52 +0000 (UTC)
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E8D1F95A
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 05:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.23.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714627852; cv=none; b=dmMDjKnswfUohi/HfOqaAI6fKfDvsBhbOf04TPIpO4PW9nQzsRT91QK4UMsGYrn0IiO+1SmF0ErTbmD3WngipoSZgMDZlK4mmIYCtn7UL54s5xeT6kMopMLvfA5N5TDzvr6bXlCuY6ZacN5ntDpqDNQVsyjZOEoyUgCFVpo6158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714627852; c=relaxed/simple;
	bh=LI0KyEmBHwNHgJxUJ1W0VYNHp5VBTABTODCgOQ9VHow=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=F84wdDdcx9sFkk8/aFH+14mcfnMTQq07qtNuq2OPFsBvA027Gp1m1dbpnXWMlmceUGauVgCc67tCBDChBhyL1saktNtSzP1xA0ubrNy5SwjQsvyDUO4uJT3h4GSnWweF2YrzAxE/X42F2tlvKNMXE3334Wvl6dV0mLs1IeY3Ts0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.23.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
	by 156.147.23.51 with ESMTP; 2 May 2024 14:00:48 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO ?10.178.36.63?) (10.178.36.63)
	by 156.147.1.126 with ESMTP; 2 May 2024 14:00:48 +0900
X-Original-SENDERIP: 10.178.36.63
X-Original-MAILFROM: chanho.min@lge.com
Subject: Re: [PATCH] arm64: dts: Add/fix /memory node unit-addresses
To: "Rob Herring (Arm)" <robh@kernel.org>, soc@kernel.org,
 =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Khuong Dinh <khuong@os.amperecomputing.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Robert Richter <rric@kernel.org>,
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>,
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>,
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20240430191856.874600-2-robh@kernel.org>
From: Chanho Min <chanho.min@lge.com>
Message-ID: <a5a4063c-9ae9-9d3d-de28-51e4220ef139@lge.com>
Date: Thu, 2 May 2024 14:00:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240430191856.874600-2-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 5/1/24 4:18, Rob Herring (Arm) wrote:
> '/memory' nodes always have a 'reg' property, and therefore should have
> a unit-address with just plain hex (i.e. no commas). Fix all the arm64
> '/memory' nodes.
> 
> It's possible that some bootloader depends on /memory (arm32 ATAG to DT
> code does for example). If so, the memory node should be commented with
> that requirement.

>   arch/arm64/boot/dts/lg/lg1312-ref.dts                  | 2 +-
>   arch/arm64/boot/dts/lg/lg1313-ref.dts                  | 2 +-

Reviewed-by: Chanho Min <chanho.min@lge.com>


