Return-Path: <linux-kernel+bounces-64956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA35854520
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0841C229CA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA5B12B7B;
	Wed, 14 Feb 2024 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1Dyi4h1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B9C168BC;
	Wed, 14 Feb 2024 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902731; cv=none; b=nALOStXMX5dEXdC1GF6v/QNqOJW29ebdso8VD+Em7GO5Xk0GoPBwMx5NHr1BNOx217SmjMaA77nn3yKgoFnzsfcLr1xd0LppINvqPk4K7q+PwD9dMqIWw3Fyz9dU8Z+sr87KlDNW51NK7jVhsTNYmVzuq3zIcHgVZ5cIY5/5qCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902731; c=relaxed/simple;
	bh=1Sxlw3DtRHuf/+Tg21dw2Havl+gSDlEajrxvtNXrd24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLpKDzdLGKVqJy+x/HS2EEtM8kh7smUq3C5h4q+lhXLAHNEbd+AovD3RhwbNLMdLfjL9we4L02aqeVeEgj7XnT87YjhVYwV3VvyT47W3q5sfXQK5a2FE3ObZGyZJZt928/19sA1boHCJN8+q0qCc3wfSENQV9/7FTV5QhHw+v4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1Dyi4h1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6782FC433F1;
	Wed, 14 Feb 2024 09:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707902731;
	bh=1Sxlw3DtRHuf/+Tg21dw2Havl+gSDlEajrxvtNXrd24=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f1Dyi4h1lddcPnpZvA7OTRd+buAWhbnKUUuqixk424akMnmEN4iZ74PNi4FuEn0rJ
	 23/2YheISdo2HTLE9XYZ8dncxaDDDD/O2euCTjPU3ZjR16ZaK/zqBkNC9/tCPrS97O
	 fLH6KR1Y0a8DjGJojnGklo56I1z4+cOmdwEXZn7JKNUmlmaeBeH1QxbHFvSJ9gTene
	 2BN30q5cPV9hG4U4InvnjJast3eA9+QSKgUNTKF4IiC2cfvDukmeSISKm5jNmrfN5g
	 UdOo04qH+ihhW0jnsBPFESEBfnOQCJYc8xXadBMvKP+D2vKeyX16oad/age2C10HGr
	 sGKnco2WhpVLg==
Message-ID: <8fc9bac2-d0ce-4c24-b88b-fab1f65dcf37@kernel.org>
Date: Wed, 14 Feb 2024 11:25:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am62-main: disable usb lpm
Content-Language: en-US
To: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240209130213.38908-1-andrejs.cainikovs@gmail.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240209130213.38908-1-andrejs.cainikovs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09/02/2024 15:02, Andrejs Cainikovs wrote:
> From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> 
> AM62 USB works with some devices, while failing to operate with others.
> 
> [  560.189822] xhci-hcd xhci-hcd.4.auto: xHCI Host Controller
> [  560.195631] xhci-hcd xhci-hcd.4.auto: new USB bus registered, assigned bus number 2
> [  574.388509] xhci-hcd xhci-hcd.4.auto: can't setup: -110
> [  574.393814] xhci-hcd xhci-hcd.4.auto: USB bus 2 deregistered
> [  574.399544] xhci-hcd: probe of xhci-hcd.4.auto failed with error -110
> 
> This seems to be related to LPM (Link Power Management), and disabling it
> turns USB into reliable working state.
> 
> As per AM62 reference manual:
> 
>> 4.8.2.1 USB2SS Unsupported Features
>>
>> The following features are not supported on this family of devices:
>> ...
>> - USB 2.0 ECN: Link Power Management (LPM)
>> ...
> 
> Fixes: 2240f96cf3cd ("arm64: dts: ti: k3-am62-main: Add support for USB")
> Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

