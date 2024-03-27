Return-Path: <linux-kernel+bounces-121293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E55A88E4BE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4EB1F2B183
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D25144D07;
	Wed, 27 Mar 2024 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LJVQ79+d"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BEA13280D;
	Wed, 27 Mar 2024 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543242; cv=none; b=LuB0lykPzK/F+LaNNX7+EWDvo6USPhMx48z4SqkOOYuYxwPCaQ8PhPMa6Prlt96rGBlWSOtOH4C5y6MhLtcqO9r8Hh5/cxeOUsuBNci/Nu8sNyf3P4eib1HX4ruUhlDNsIPEu+pu6fT5yTHVvngQu99OK/D1tYJ0fLmENNsDzX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543242; c=relaxed/simple;
	bh=Go2MGwGVcRF8lUeW+BNK0qGYRxUUf5O+KQEFEsGmpP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wh5GK27hjoC3F1bOys5/FHrq/borzbv8xELQOhd/AFU7n7Gl0ThDN9uxZcI5j+LuxSW5c5rmsx0+qXpBFrs9MiOhKhhAFrNxCQU7GNGEh60RvsFKCsI2WmmGKkcqSJbq0GpP0PRt/f/Er/4wCwj80Cj5pqQ7V31UPCW20tTF0og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LJVQ79+d; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711543238;
	bh=Go2MGwGVcRF8lUeW+BNK0qGYRxUUf5O+KQEFEsGmpP8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LJVQ79+dK0efazRAGk2tpWGFlKyfQydaCTZTnv5YHDxy/JngESoyC3DVlCkdpQXZD
	 JJLYhQdzZV6KPvtPwHrc1ZoPDTK0nNOzteGPCnQMybFmkwVtb8P0cN/OUDipeeuwQ4
	 R7cOJ6wXMfII1T6Ci0eG21Tmme4cCsKJYY+53Xo1r1vkP4ZQvJZiWFUGCKEJc/XZ2G
	 6jkY3c4/nWfVLE4B6SUp235J5vtW9K4fcNTtadp1auYewSVRKH/P772pqCh/OQwSz6
	 4efTPUgFFtgIBP66D8ISaA3BnVskFORrWjuV6miyW258hEtMgF4gJuiOB3cKQcAvXV
	 vkPHoYJbmNSPw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 389D137811CD;
	Wed, 27 Mar 2024 12:40:38 +0000 (UTC)
Message-ID: <6860673c-927e-446b-98f7-feb9dcae2eb3@collabora.com>
Date: Wed, 27 Mar 2024 13:40:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] remoteproc: mediatek: Make sure IPI buffer fits in
 L2TCM
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: andersson@kernel.org, matthias.bgg@gmail.com, tzungbi@kernel.org,
 tinghan.shen@mediatek.com, linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, wenst@chromium.org, kernel@collabora.com
References: <20240321084614.45253-1-angelogioacchino.delregno@collabora.com>
 <20240321084614.45253-2-angelogioacchino.delregno@collabora.com>
 <ZfxRY475SKaRYVTj@p14s>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <ZfxRY475SKaRYVTj@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/03/24 16:25, Mathieu Poirier ha scritto:
> Good day,
> 
> On Thu, Mar 21, 2024 at 09:46:13AM +0100, AngeloGioacchino Del Regno wrote:
>> The IPI buffer location is read from the firmware that we load to the
>> System Companion Processor, and it's not granted that both the SRAM
>> (L2TCM) size that is defined in the devicetree node is large enough
>> for that, and while this is especially true for multi-core SCP, it's
>> still useful to check on single-core variants as well.
>>
>> Failing to perform this check may make this driver perform R/W
>> oeprations out of the L2TCM boundary, resulting (at best) in a
> 
> s/oeprations/operations
> 
> I will fix that when I apply the patch.
> 

Thanks for that.

Cheers,
Angelo



