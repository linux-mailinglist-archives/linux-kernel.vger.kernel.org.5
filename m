Return-Path: <linux-kernel+bounces-9584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B1B81C7E9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481DB1C25100
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55BC14F94;
	Fri, 22 Dec 2023 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9RzoUvV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5BC11189;
	Fri, 22 Dec 2023 10:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB61C433C8;
	Fri, 22 Dec 2023 10:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703239900;
	bh=DJZ4k1+5+NhXW5nZgyHjVM9hVDuYw0xK75a9tiO1atE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n9RzoUvVcZrjnxzjCQSal+Zs9I4wNPrs+z4VIADy7FtrYOggK9pgfqq9ndUrcD2wA
	 mKfWWbgm6ZAL4Ock8aTbBS8MYnQpf6bNhVKZIgiDtIlcw1cbxRiW9ef7soSYIIjDIX
	 QXwq8NsPJPRH+KRRS4NNLDClEtB36lxZBiYmLTSiVG622rSksk7brBFW/Hu3E1LRD8
	 5Fk29k8lKM9FgNh3zdqw6WUEabQx3OvRMFCNuRZEbeW8Hiz3hevNhheDlQzWhO4ZzC
	 WgQAMezwFCbett1dOT0iCOYIpFdxRRpuiwBQwrXSKWfghrKg67J6caJXdkJLarEkY5
	 R15Z6VPxBxL5g==
Message-ID: <9d8abd54-b497-467e-b473-13df39c13a76@kernel.org>
Date: Fri, 22 Dec 2023 12:11:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] phy: cadence-torrent: Add USXGMII(156.25MHz) +
 SGMII/QSGMII(100MHz) multilink config for TI J7200
Content-Language: en-US
To: Swapnil Jakhade <sjakhade@cadence.com>, vkoul@kernel.org,
 kishon@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: mparab@cadence.com, s-vadapalli@ti.com
References: <20231221162051.2131202-1-sjakhade@cadence.com>
 <20231221162051.2131202-6-sjakhade@cadence.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231221162051.2131202-6-sjakhade@cadence.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/12/2023 18:20, Swapnil Jakhade wrote:
> Add a separate compatible and registers map table for TI J7200.
> TI J7200 uses Torrent SD0805 version which is a special version
> derived from Torrent SD0801 with some differences in register
> configurations.
> 
> Add register sequences for USXGMII(156.25MHz) + SGMII/QSGMII(100MHz)
> multilink config for TI J7200. USXGMII uses PLL0 and SGMII/QSGMII
> uses PLL1.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

-- 
cheers,
-roger

