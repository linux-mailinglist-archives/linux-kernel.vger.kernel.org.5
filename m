Return-Path: <linux-kernel+bounces-106271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F355387EBB1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87BA62815F2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F49F4F20C;
	Mon, 18 Mar 2024 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ri1M17Kr"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35224EB54
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710774543; cv=none; b=tOrHYPJTKNGpZsm+LDqLzAnjmbpUeyglQ6MsgKJvFfCOQDeHXaR8GuFnNFbRZWKf2fSySqNzfnqUKWEPw8hKr29kbYm/gkg5L9fDtJ6lCYvWZT2UVXolei2WoUGsv1thnlosFkT3oPrFtroa+YkanY1uwmOZ+SKpmAfZ0dq3p/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710774543; c=relaxed/simple;
	bh=jdUSjQfELoCxrmMar6U8OQhaRPvf8KwScinRJQd8ysE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzl/4oW/G3sRz4whuOoSPTxPycQvmzFyDeLbZg8JgR0qcmPvw3RehNyhVIOpO3w52dREjhIxZcwwFj9odtv5kR5aZfoUxQ8f/6xwbTGBOM8L8UbddsEC4sCCqZGvWSIxWd2Qqbiq0zVVne10b+kueUbaE2IjsGalXN8/KuP0LyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ri1M17Kr; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7e04a248-cf29-4f0e-b6c5-6dce0fd78613@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710774540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdUSjQfELoCxrmMar6U8OQhaRPvf8KwScinRJQd8ysE=;
	b=ri1M17KrHBQVuuHS6Pt0zlxhvdeECi6rIYC/QjRPDyMakidFBANeT9usyBd1f8yzhL6ssJ
	DiDCzFkSWXI8Vup9oo0wTgft/WWwI05jJ4fgudAflQjECt6fST+ztm6k9LUFQN2CSpdAQ+
	N3c5iD68lcWN7S9PMnLUq/KQNpntEaw=
Date: Mon, 18 Mar 2024 11:08:58 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] nvmem: Remove qoriq-efuse in favor of layerscape-sfp
Content-Language: en-US
To: richard@bit42.se
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Michael Walle <michael@walle.cc>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240316002026.1808336-1-sean.anderson@linux.dev>
 <20240316002026.1808336-2-sean.anderson@linux.dev>
 <6f5636e65df5616395cc8e24f63b09ef@bit42.se>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <6f5636e65df5616395cc8e24f63b09ef@bit42.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/18/24 04:32, richard@bit42.se wrote:
> On 2024-03-16 01:20, Sean Anderson wrote:
>> The qoriq-efuse driver is a duplicate of layerscape-sfp.c. The T-series
>> uses TA 2.0, while Layerscape uses TA 2.1 or 3.0 (depending on the
>> chip). Add appropriate compatibles to the layerscape-sfp driver and
>> remove the qoriq-efuse driver. I did not add support for P-series SoCs,
>> since they use TA 1.0 which doesn't share a major version with either of
>> the existing implementations.
>>
>> The qoriq-efuse driver does not properly abstract the location/offset of
>> the fuses properly, instead exposing the device's whole address range to
>> userspace. This is not appropriate, as the fuses only occupy a small
>> portion of this range. The layerscape-sfp module correctly constrains
>> the nvmem size to the fuses size. This represents a (necessary)
>> compatibility break. The qoriq-efuse driver has been in-tree for around
>> six months. Hopefully this will limit the fallout.
>>
>> I would appreciate if someone with access to trust architecture 2.0 user
>> guide could confirm the number of fuses.
>>
>> Fixes: 0861110bb421 ("nvmem: add new NXP QorIQ eFuse driver")
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> I don't think Fixes is appropriate here. Apart from that:

As mentioned in the second paragraph, the original driver exposes the whole
register space in the nvmem. I consider this a bug.

--Sean

> Acked-by: Richard Alpe <richard@bit42.se>


