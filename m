Return-Path: <linux-kernel+bounces-163906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C1C8B7595
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF2A1F22A87
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5706B13D892;
	Tue, 30 Apr 2024 12:19:17 +0000 (UTC)
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB813D273
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479556; cv=none; b=TGH6iEyM8PWP9mRyLRpQQgx/HvZu/TFi9p50HgQ7yU7aEyclweMOzQCvzoY2wR+ZSNqc0XsFHQhbEcv5Hj2FlCq3KhHPOVHBMOmJwi0Cld3j8mfXr/EO63XATAPmSWMxu7nLO//aZ5I3wStYbvQZFQggeBSbbkP//HvXA2A2Y4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479556; c=relaxed/simple;
	bh=oY5e9LPYnv7RwUjCw/daYqSttXL09d2smgQUVcn3rek=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SOaz8lTXFcRxOIfdK4/XhR68On4Lju7VwDUh9+tf0c+hoyAjEfwkDSy4CELN7NvLpM+zZtvk+Ivujc0mbhoNedchyY0d0m0z6OqytG//WbBk3EXAJag2cUir9xk7Al9XdzGE4zKqDqs70Viyz9bLXYwK97pwwMoO6Y5A2fRrxyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from [192.168.114.15] (078088045141.garwolin.vectranet.pl [78.88.45.141])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id B540C1FD26;
	Tue, 30 Apr 2024 14:19:03 +0200 (CEST)
Message-ID: <19ccb549-5113-4a58-ac08-4e2e6fea3e20@somainline.org>
Date: Tue, 30 Apr 2024 14:19:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch/topology: Fix variable naming
To: Vincent Guittot <vincent.guittot@linaro.org>, lkp@intel.com,
 sudeep.holla@arm.com, rafael@kernel.org, mingo@redhat.com,
 peterz@infradead.org, lukasz.luba@arm.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, qyousef@layalina.io
References: <20240425073709.379016-1-vincent.guittot@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20240425073709.379016-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 25.04.2024 9:37 AM, Vincent Guittot wrote:
> Using hw_pressure for local variable is confusing in regard to the
> per_cpu hw_pressure variable. Rename it to avoid confusion.

To avoid confusing the compiler :P

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404250740.VhQQoD7N-lkp@intel.com/
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---

Fixes: d4dbc991714e ("sched/cpufreq: Rename arch_update_thermal_pressure() => arch_update_hw_pressure()")
Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # QC SM8550 QRD
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

