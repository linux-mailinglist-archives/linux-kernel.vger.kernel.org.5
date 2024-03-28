Return-Path: <linux-kernel+bounces-122207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C1D88F377
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0044F1F2B985
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436728BFC;
	Thu, 28 Mar 2024 00:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHjLPlD6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8713B849C;
	Thu, 28 Mar 2024 00:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711585057; cv=none; b=Bix7tpsyoZpuOCB4gGIv5uUp4xAEQOv2Tfb9NaCkSOmEnC1/9ebw0tZ6ZgD7o743j5QAfLBkksu9vmkm3/pV8UUUF9ratmElk5G+78zkTq26gYW6FYt+B5RhtPpbt4F2vHFC2DWhwZ4C4QR7kwJSf3UYOEPFmpDFyDcWXRneCn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711585057; c=relaxed/simple;
	bh=YcFPE3TRc86aEjPRPltUBbDnpItTNWpp3dcXY92em5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NWEycDDQZqxf1Fb9ykv5BwT4SK4YrGjZ6QT78S2MlWOHH5A2RdhpNQmwgu+bjGi7EAu2vbxxeakxh/podwmKX/kblE1QMpwZ//zepNVvuGdHo/hnoW1iq2KyYSyuc4ktoDDmfN7ESaLoP/Tg07+cyfrveOlclW3KkoBlSTBIYQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHjLPlD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D6CC433C7;
	Thu, 28 Mar 2024 00:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711585057;
	bh=YcFPE3TRc86aEjPRPltUBbDnpItTNWpp3dcXY92em5w=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=sHjLPlD6FkmXazbBDOtBwdmiX7Yi+NYMFarxyW5/3+JerVtPMYQaO9+n83Si2DQvq
	 RoGPOlx2m9mP0hgU0uiDiuicsZv9fdOTkrsSn5n/8AlP1pHqZgYK/FjlN823eLh7Gh
	 yLCpwqa8PuItKUCHgW4oVylVwAzTgbYl+fVhnQUvj8Hvjq4hb/vk3tGpRv1VZunJj1
	 +s4rfH2KhYIUisM9UlWKuqYPGRwABTVM3GuVJ/s3GnU4dq8Hg/jLvo4b6ylFEyW3Bw
	 gZP9bWZZ87alqgIi7Iy0OZ8m9GKwJqLoxmfAUxaAKT2jhvYI+Kg8Bc309Dl+mQql3U
	 aDNx9B5haAQEA==
Message-ID: <dbcc1b8f-342a-497a-9681-3bed4f61e7fa@kernel.org>
Date: Thu, 28 Mar 2024 09:17:35 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: pata_macio: drop driver owner assignment
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Sergey Shtylyov <s.shtylyov@omp.ru>, Niklas Cassel <cassel@kernel.org>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240327174936.519861-1-krzysztof.kozlowski@linaro.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240327174936.519861-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/28/24 02:49, Krzysztof Kozlowski wrote:
> PCI core in pci_register_driver() already sets the .owner, so driver
> does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied to for-6.9-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research


