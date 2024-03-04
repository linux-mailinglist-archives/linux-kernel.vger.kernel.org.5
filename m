Return-Path: <linux-kernel+bounces-90400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBA586FEAA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F671F22E0B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2776E3D565;
	Mon,  4 Mar 2024 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dvtyVHrd"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A25224DE;
	Mon,  4 Mar 2024 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547162; cv=none; b=gfFYpyky1LMU+R4slOb6PhyXKv7YiVt5WSrwXRWl+fWNglkA6e/QvV+mGe6SmVkCtf4THgMjDcelxUf7zCsqAgYeTaMjue7G1uBom0ziu2T3UT8FAwAcyZF3yWYg86eqdpI0saKV3womTSGFXg1cX/cg2AS0DKWkNB7XteCAda4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547162; c=relaxed/simple;
	bh=oUx/isVKxmvWHtpgYFPP9fHHnhsGSqVOuWq5EctlFbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RdpbbAXlrNpj7yRn8T5fw/OhHSmoB8TG4q5YY21KN9GYIUvVliH5XeOgvTGf7ObC4ZLQ+vkFD/wlF0cDlEh22Rs7oiah5qwxm4Azlhmh0fhaQQNuWh2KhCnzFf4NDFL1/yR6x2rTs7+T7Qx3EdZEpXFk69jf8JaHz3Kna5FOuyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dvtyVHrd; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709547159;
	bh=oUx/isVKxmvWHtpgYFPP9fHHnhsGSqVOuWq5EctlFbk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dvtyVHrdbSR2yZlTTVq8+xCCccXVclO7B7yvvxRIs2hmYXPl5HYzjpNIiZEp8TwM8
	 JIS39Ys04fbbwrFcKYdMTbgRiZWD+DWvprL3x/nOQWun5EKoFQEIPEDVVqG2Y+Qd8J
	 sFU7JhGdbT7+adZHxe2jRwdCu/h63YOH9ngQjkKoz9+TP0kK01UfLhE+VK2Q3bDgp4
	 iMtrpEzWn8AFjHi6ujD05EGXYvsqBXoeh33oWTU14ep2wOuHlBcpSF6/3pBEME02w8
	 pzfpXu1Mw1YEcZRxKaWclQiHiVs38wJPCud+cupEiDaJXhBcy2pLK1rCnNfaYywxsJ
	 ZupwCvz0xK7nA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7825A37803EE;
	Mon,  4 Mar 2024 10:12:38 +0000 (UTC)
Message-ID: <3de64dd8-8d1e-423f-a139-ffee6f120b6b@collabora.com>
Date: Mon, 4 Mar 2024 11:12:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: mediatek: mt7622: fix clock controllers
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240301113506.22944-1-zajec5@gmail.com>
 <20240301113506.22944-2-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240301113506.22944-2-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 01/03/24 12:35, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> 1. Drop unneeded "syscon"s (bindings were updated recently)
> 2. Use "clock-controller" in nodenames
> 3. Add missing "#clock-cells"
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Please add the appropriate Fixes tag and resend.

Thanks,
Angelo


