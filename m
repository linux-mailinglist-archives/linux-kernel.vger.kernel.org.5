Return-Path: <linux-kernel+bounces-138882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F29A789FB9A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ECE01C22A29
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E787716EBED;
	Wed, 10 Apr 2024 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AXHMNKKJ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42841591E1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763105; cv=none; b=gmyDRYWxdGLQox3yrBLs3RSTCXLjzKhP7Fq3goSxQJGHQ9k+rqj+GGt7U4hkPqmTp9/LRrLCNrea4mateT5V3slo3prU6JoXl0Twi/xWxZ1Dy5EBFkVgVoAdJm7XUmkyzHi26ECR0GVDOMYvJ75uZ02oZKseFSsKcGZvhnGE8BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763105; c=relaxed/simple;
	bh=lIsydFjFH4O9qDXir41/xW9OeB9uWOqhgAX0I0+gXwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eUZyWPGjtztC3xtvMAWeZHa2Sj+LPm8S6XV0gwGMeI3CX0gNVI54a/mEjodFIQArpbR1nytW6UlL1XoVHmCgGfuP9eJwY/dp9ZnRtd/oDBVlb8IB7tNy2ZP8Eg2cahsFX/BGnK7vWgrZwb6bZ37oLxbPOg+HnXU8u3C2ENXq394=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AXHMNKKJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712763101;
	bh=lIsydFjFH4O9qDXir41/xW9OeB9uWOqhgAX0I0+gXwA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=AXHMNKKJiOSU/tdBw4/2X1abTJziNFfLrJ0WPsFVhWhFpzvVvgTtGpWQRiPDjWhU4
	 SD5xSVCTP9nIiCiHuQGg8Ybzl8RZrX1JJQj1q1Qkjrke70A2O0bHw+M0Jbo4SUTJh4
	 U70rJcFPOwnq6sDB7a8rhnFpZiBwbRKCUfOKvDBBiGf17BGWQJyFxNH6OwZlU3a4CC
	 if2yRkZejcTVwaq7knns5AxucP3j6XEnrIGLW+AqXD5C/DZ+99ANbtCFVF9S4MCFfN
	 vUMlS7Aq7ZhQvjijK6QZmnH/DY3EvRzUOt+CF8dcfIIqKgQSm+cvBxCrrj9CQtAUpc
	 5GpZdkTzX7ZsA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6871B3780C13;
	Wed, 10 Apr 2024 15:31:41 +0000 (UTC)
Message-ID: <40feb89d-732c-4bc9-bab3-939896f13248@collabora.com>
Date: Wed, 10 Apr 2024 17:31:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: mtk-cmdq-mailbox: fix module autoloading
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240410152534.190326-1-krzk@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240410152534.190326-1-krzk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 10/04/24 17:25, Krzysztof Kozlowski ha scritto:
> Add MODULE_DEVICE_TABLE(), so this module could be properly autoloaded
> based on the alias from of_device_id table.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



