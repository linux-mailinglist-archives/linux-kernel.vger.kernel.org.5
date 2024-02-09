Return-Path: <linux-kernel+bounces-59131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF97384F1B7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EEB91F22846
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88E2664B7;
	Fri,  9 Feb 2024 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KLC64FXN"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD397664A9;
	Fri,  9 Feb 2024 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468791; cv=none; b=vFsx6I5RMh251By77yzknCwt13EuMI87VFkJ7069j1vTkFl1q6j7pBMEuRoTn2U6IaDf5gH2uqzc8ShvZL2q2Ofi5jns82gwiRIbR5gQHhcSXXblYCEliKM7hH0AN/6mJrOBv/jSVqXWsG74nsG2lZtWQH9ahuGUlFN0gjorLbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468791; c=relaxed/simple;
	bh=SCFizRO1mkhWZ9UsKwKydQaTwmYcQyyC5mBYpD3gCl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ov0EM50PYGDtpdtwJ1P84KJ3ol632kONH+s3j2IIMDuMLPCjMD4oJTcOMtITOM9IhFNiB/otlKqv+ywhkiOVeLPGI5K5hwnYtN4LrVaPHn7MrV2YpOxUdGRAKL7QsJH0zuqopGRKT5kaVcDQL1FtQH16nsDwxh6ya8s9vJUwx4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KLC64FXN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707468787;
	bh=SCFizRO1mkhWZ9UsKwKydQaTwmYcQyyC5mBYpD3gCl8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KLC64FXNcnXhqbqrahhj6777lmtbhvlfuM4/EKSP6B82iRqUiIQUeiQPP+pPa8STa
	 GxqhhyMKeoxxPAc45FVZsRlqrT1Y7S+W/YsbxJf6GN7E+4c95jIog0Js8Ath1Lhsab
	 cDUMblADW+ABZgm9xawK8jEGaBVhRqZmk/Zm89bqB35oKMrqKE5TsYGjQ7A3QcHtQx
	 jJR2d8kp0gVslhKCnILaBUsz0D5TDCkyMveeerAURziLY/ietnD6NqB2clQX/QYEi1
	 h5tVm7IrsiYr+WG5A4ddgmnVO7u27Rix4vCfDQwRA74oSyXASYdotOT/mNvTX1PNpU
	 80hTWErraMQ3A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1628B37809D0;
	Fri,  9 Feb 2024 08:53:07 +0000 (UTC)
Message-ID: <258f93ce-c927-451f-b9f0-7170c140eccb@collabora.com>
Date: Fri, 9 Feb 2024 09:53:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] dt-bindings: arm: mediatek: convert SSUSBSYS to
 the json-schema clock
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240208215926.10085-1-zajec5@gmail.com>
 <20240208215926.10085-4-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240208215926.10085-4-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 08/02/24 22:59, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files. Introduced changes:
> 1. Documented "reg" property
> 2. Dropped "syscon" as it was incorrectly used
> 3. Adjusted nodename, "compatible" and "reg" in example
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



