Return-Path: <linux-kernel+bounces-105986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2294787E722
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533881C21827
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AA438382;
	Mon, 18 Mar 2024 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rGBTSQQF"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35972376E7;
	Mon, 18 Mar 2024 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710757224; cv=none; b=tVXo+63Lu0jWZcAdm3E46DVsNPnWDNoYzCKP2PY179CjQj5ijEXU4w9FtdIjLHPtfod0QO4SspWL798OWUJXNRqVYFtIEBEHt85XfWaFQDqrMTYrbPjh0VDS8k+9pwDTwoj2hUh3nQunZxYDrEdGDORRXb1zCqULRob4hORepDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710757224; c=relaxed/simple;
	bh=uTZOtHBrwk1ZgvqEya2WCVuR3eGHVxsYo5270w6n4Ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S3uMxS4ZG5wjqk4IssUX2QCRWb2awIax3pLvzutsd7aO8gDMdyIeqCULayRLbJgJd2xHk6j4vWE8AnAaS+ZtXtmXv06rqNuZEH+M+Y6BXTSewbbiS8qF4q4DgK9fm0eXHCTmQ0yQcBv7Ey5OFAsml0aitU3vpCTNIDcf/xZHwmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rGBTSQQF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710757221;
	bh=uTZOtHBrwk1ZgvqEya2WCVuR3eGHVxsYo5270w6n4Ec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rGBTSQQF5SVvNdlqdbPW16zKYLKo+3gX5VqNkwX/zxCtwZNFJPAbHvrvFGndyScbP
	 5U5Y402CIoxHWmyMS7UToF1BlK8N/JMDLVFQVqVggrrSWK9hBiD/urCLjFoYQiqPF5
	 6J3d12I8ewa9x7KL73xpnG1kBXRORy6oCWE3gUzjOxzOR7XuyJqJZe3oJ/A4gCAdGG
	 toKNlK70ulX0YK1qKtPvKxXDh39tRNInMKNWSs10bw1hFZUkXCRCawTW9vUHgBslmR
	 DNG4nQDy44Nz7SQq7NGVFyR+LqLRbv0RXyJI1g0XvxOWZow3/VjUjBKr50LpL2aG1d
	 s9Rkir4a1Y9nw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E4E01378209C;
	Mon, 18 Mar 2024 10:20:20 +0000 (UTC)
Message-ID: <dd502eac-a97e-4f3d-9b48-538cc77d41d7@collabora.com>
Date: Mon, 18 Mar 2024 11:20:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] mips: dts: ralink: mt7621: reorder i2c node
 attributes
Content-Language: en-US
To: Justin Swartz <justin.swartz@risingedge.co.za>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
 <20240316045442.31469-7-justin.swartz@risingedge.co.za>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240316045442.31469-7-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/03/24 05:54, Justin Swartz ha scritto:
> Rearrange the order of the i2c node's attributes so that they
> are inline with the DTS style guide.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



