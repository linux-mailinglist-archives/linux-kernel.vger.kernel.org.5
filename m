Return-Path: <linux-kernel+bounces-145475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238748A56A5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4861F22506
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3947A702;
	Mon, 15 Apr 2024 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JZlTZZdt"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC3976046
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713195644; cv=none; b=tUWYzh8Oo4bqtFzsAiib6dT7Zy0ytQta7ONnYxAe+ecrzxcOXHXOLxEwGY5cet3NAQ2+yfviH6wr71n5r/DtFTOF4wgog6Imfjtd4vj/LxDfYiXX/uZ/leHXFc9qgpGqkTbULD/XG7gxoT036tBTt3+VnfSsmoH2gu1DChK+AH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713195644; c=relaxed/simple;
	bh=lfZ6ImByiKwmzsWO7quCdEHzgX/s71Ok2fPLvtsr8uU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JiyJNnig8IhlDWHYWQTth9fIpNU9wDTJoiQLWKnxjg9VNg1+DpCfWSQBLd4jC/8zwc2Tn6kAj1XSRVLkWSoldMbX71MYCR3tvfxC75v7xC3iTOx9sozLM028psRSPmJ3e7CuUQGuPLiZSHx1qFFXnKHx7jRLy45JgHHj1llPox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JZlTZZdt; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <98230531-5b9b-4181-b862-21be6eb0ffbe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713195640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lfZ6ImByiKwmzsWO7quCdEHzgX/s71Ok2fPLvtsr8uU=;
	b=JZlTZZdtbDMTFmEYwvXjI5Tey5bLpYunVqy8R3i2XOlfiyJbY9xl9Epta2ayfmYcjTs7zy
	ZDLkHG/JGvif463nv+dulrifPEleJmklInsYlM3RNFNJV7mdO8DSRDAqGUjXa81AGLCMwA
	5Z7VafK5fniuiSrBEemfuLXzlCSMUt8=
Date: Mon, 15 Apr 2024 08:40:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf/tests: Fix typos in comments
Content-Language: en-GB
To: cp0613@linux.alibaba.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240415081928.17440-1-cp0613@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240415081928.17440-1-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/15/24 1:19 AM, cp0613@linux.alibaba.com wrote:
> From: Chen Pei <cp0613@linux.alibaba.com>
>
> Currently, there are two comments with same name
> "64-bit ATOMIC magnitudes", the second one should
> be "32-bit ATOMIC magnitudes" based on the context.
>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


