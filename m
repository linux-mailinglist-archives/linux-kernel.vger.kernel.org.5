Return-Path: <linux-kernel+bounces-25612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0649F82D390
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 04:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 063E228156A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 03:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB02423A2;
	Mon, 15 Jan 2024 03:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IQQqkaVZ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8EC1FAA;
	Mon, 15 Jan 2024 03:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705291029;
	bh=gE9f3UIrT8NLh3MU9oG58RY7ipRU2KmEb7/90wbvBuM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IQQqkaVZ7ckQeiFkbhaMfASgeJu9n1eMACAVZLlzjlLu+I074ad0rVl022oIIWkWW
	 ks+B2pXyuEw833mkdN8LMhKatddZh+OZZ975lwtHYseUcqkR7/U6k8amMAbH6FKiWo
	 UJAWN/gEe/W4imsClXpjRqLFzFyIKZ/2VBLQos34W8nXkXPSnopP9gN/Seh5Rp/pxH
	 X+lC3Cyzr1sugmM/9SC8vV4CgIKmiX+n2hUDEQVQYSB431t1C4+MM+5fjKW+8HUjhT
	 KW0Q/u2PoYFLDRYl9gNf0mWtBJbSfLCRdm10MsUBsT8f2SebpDBxcnSdopCdi4OTZB
	 IVhhRGUSGHQmQ==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 77B0337811D0;
	Mon, 15 Jan 2024 03:57:07 +0000 (UTC)
Message-ID: <94beea2a-c4b9-4241-bbfe-8c57ca50fbf7@collabora.com>
Date: Mon, 15 Jan 2024 05:57:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: media: mediatek-jpeg-encoder: change max
 ioomus count
To: Rob Herring <robh@kernel.org>
Cc: bin.liu@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20231227130812.148914-1-eugen.hristev@collabora.com>
 <20240109032731.GA2578937-robh@kernel.org>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20240109032731.GA2578937-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/24 05:27, Rob Herring wrote:
> On Wed, Dec 27, 2023 at 03:08:11PM +0200, Eugen Hristev wrote:
>> MT8186 has 4 iommus in the list, to cope with this situation, adjust
>> the maxItems to 4 (instead of previous 2).
>> Add also minItems as 1 since iommus are mandatory, to avoid warning
>> on the example.
> 
> maxItems alone means minItems is the same size. If IOMMU is required, 
> then 'required' is where that is defined. Is there a case where 1 IOMMU 
> is valid? If so, what h/w has this case.
> 
> Rob
> 
> 

Hello Rob,

Without setting a minItems , the example in the binding fails, because it has just
2 items, while the maxItems is now 4.
I set minItems as 1 to avoid restricting any kind of hardware to have at least 2
items, but if you claim that previously, maxItems=minItems=2 , I will change this to 2.
Is that fine with you ?

Eugen

