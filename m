Return-Path: <linux-kernel+bounces-59132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C131584F1BA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3AC28891B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E576664C9;
	Fri,  9 Feb 2024 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="xzOQ1z0t"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F39664CF;
	Fri,  9 Feb 2024 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468795; cv=none; b=FHApSO+I5v8v7NJhaBPGAbFvTmpHaX9ZU70y/wur1qGTY5IiWfZXYbPm+4oNmBQFkwhdvIicE5qtRzoCVYZfMziXNVSPoUy9ixmTj4Uqf84SSRKbeKAX8NI2nYa8bQgEj+J1RaqjYZgC1DAVw6f62GrO6O5b+5Yyj1Ud931U88U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468795; c=relaxed/simple;
	bh=SCFizRO1mkhWZ9UsKwKydQaTwmYcQyyC5mBYpD3gCl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+/Djj96Auv0JOmRBdkhMEyYdG8qc+J1RQqgBMTxEACsmrVf1UOxXg1aOEvO6a3L6tiogSVmTpvQX5wFvyZLLrQBLahrAqrZh5iT6uNYei0olqy3DcR2fZSul227Zn5uotP9SQqW0FjvumSCK+eVKDg24OJBI1gRRoKBL26CXkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=xzOQ1z0t; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707468792;
	bh=SCFizRO1mkhWZ9UsKwKydQaTwmYcQyyC5mBYpD3gCl8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xzOQ1z0tw2tQcrlxq7shEkIqqOvvTDRmchYbfQO4bMS2m4ExGez6jjPPijlYIgamm
	 b5ZUmS1QpXQHzC0lwSspeY1XvrfxCPMkhm9Hpc1UkjKLvwuTclZ2Fa6Fky8No7SRdq
	 uAfUHcHLCSeoKJ16H9ADwguzsViPCuqLeKu7pS+ZI7cderQ8OIMxMb1PxLw6b/GiO1
	 vkTJWV3Fi2ZWzbHB4yqQOwyh1b4Fi2itADigVdOjZqT3xs6UzSrjzAM8saAmINWr+g
	 RFwmTX+H9eCaQgVLE0rFtM2lEorNgc+RQMJKfMm7s12pckYLPMJN7NOck3VCBBvaPi
	 yIjKSHkvKh7IQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3342637813FD;
	Fri,  9 Feb 2024 08:53:11 +0000 (UTC)
Message-ID: <c4bcd969-cd6f-4961-aac7-cd169da4bfeb@collabora.com>
Date: Fri, 9 Feb 2024 09:53:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/3] dt-bindings: arm: mediatek: convert PCIESYS to the
 json-schema clock
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
 <20240208215926.10085-3-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240208215926.10085-3-zajec5@gmail.com>
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


