Return-Path: <linux-kernel+bounces-90402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB9686FEB3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB5A2813B2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A093613A;
	Mon,  4 Mar 2024 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SjAKL/+a"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AF1225D2;
	Mon,  4 Mar 2024 10:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547182; cv=none; b=XD45cEykY7NOmmK+6dydzA1y1F1mNk+VD2LtJTymG5f00SQhxDXRQwicUyVyPDWFXYjw7zuUvwJNL3BaTEnslHR8gRraRrLRBxNs0DdCw4tTYKF56q9Dx0M6Bvfsh677RdAWKhbNcLdbILFRGbCA9sFPVyt8Lk5O8QPVqi1J/UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547182; c=relaxed/simple;
	bh=CdD0gojEKaMK1V0uxqyzqCJ3ztwMhtLhWT3fngZDSXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQ5xs4h2l+PuQxI8AT/TNmUZhp2oB4MotdKCL7eqxVeWkegJdIoZhYnIRxmPrzJpSGo6Zq/sNw8cRM9tmSYRPymkMp/g9b7DcfCRpDzzsARjB6ab6FzqcRdMgtQRdK/GtO2uZHSkrmOkn0iKxyms7cfDc45xgYfF3QOf1en3wu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SjAKL/+a; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709547179;
	bh=CdD0gojEKaMK1V0uxqyzqCJ3ztwMhtLhWT3fngZDSXE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SjAKL/+aWvvIHZ/44a+k7hKEZxUbz7zE5swg3ByjmWr85EF+7rgqb2dZAwh2Mwjrl
	 W6l0kELSAMjmzaDOpGpap5OY/zDE8RWYtsXLpiOh09dzZDugxPYEw6W51GnbHHI1oJ
	 pOXIc+gTJ0D8O3TnApToaFDoplipVKNdqQ5gCaO2qiN+hebRZABz+ZF/lVSis3OhhD
	 ++qjJnX6r9DL9Jhf1PzwpCAjwzK02UQBI+YkOtKDM7QiI92HcdN9q0/rZn2ml8R4eC
	 /nXnivJX0tDueCALX3ZggXKTN31L2MTd+nDfd7Du0tae2417zOhgPgM1g5hvNlHzau
	 nyHxrNpncYozw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2FFEF3782091;
	Mon,  4 Mar 2024 10:12:59 +0000 (UTC)
Message-ID: <fcba424c-eb0b-4a43-b657-eeef811809c4@collabora.com>
Date: Mon, 4 Mar 2024 11:12:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: mediatek: mt7622: fix ethernet controller
 "compatible"
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240301113506.22944-1-zajec5@gmail.com>
 <20240301113506.22944-4-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240301113506.22944-4-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 01/03/24 12:35, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Fix following validation error:
> arch/arm64/boot/dts/mediatek/mt7622-rfb1.dtb: ethernet@1b100000: compatible: ['mediatek,mt7622-eth', 'mediatek,mt2701-eth', 'syscon'] is too long
>          from schema $id: http://devicetree.org/schemas/net/mediatek,net.yaml#
> (and other complains about wrong clocks).
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Fixes tag?

Thanks,
Angelo


