Return-Path: <linux-kernel+bounces-36997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBE183A9FA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F396CB21E88
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1451077655;
	Wed, 24 Jan 2024 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="llq9UrGc"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B3A7764F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099904; cv=none; b=oiscPggCImh5BGPgCTVyTWhQKWRrxjmO6cH6TNp9cbpeKwyxIr4azincY8k0j6RjciFAQxYKdhPN/MkX5mwXhVESjlKAEFc/8TaZVff5EXkxAv1vcnEGomK3yDOnczAq41jaKnsma4uyo8PjpJAmkhNlAq0pGrQW8x1L7vbFaPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099904; c=relaxed/simple;
	bh=G4Eo78yHotMmyyqcl5vUTI1sj/UNZU3YgL4Fb4G5AFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZMyzjA5B1bOFIfWBWgwjTr8GPXatOmtTY/n3/quE6m0wyXsZl0YF78o0RJi+jH34tHMgEJ/Zte2aQtgwwdyOgOpMkMbaMLFOqLirm5mZY5kz9ll3sJ/caZq8Mq+ngyN15T1GYgcBFfY9aHMwCOaVvNxPCdue2gfkIwPo5SzXyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=llq9UrGc; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cf296932d8so4241261fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 04:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706099901; x=1706704701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eErz+34XA2SH+q6nUCH407rk9Jd9s2beoCta3Tc+wxg=;
        b=llq9UrGcIqOZj338ukHKn+LLHoy40gTsL0x7EFOtPYfgolITqA6aKETatoSj2jYoHj
         S2w8Ul6GV7D4QGqm4O1IfYv6h2QQoq0uBlMKM0seB7qcDPBGxDTiNr51lN/0Wjl/xpf1
         6NbD9KWYwKi/5iw4fW4/pRJIYHtdRJ3gaOcw7jTpzCUm50tvcgWA2pY5hG2ttBoak8UR
         riNrIVh6QOPnzFfKUvWOmi2Idqk9trpZqqP2dkrm20wD1NgbfqQVHKTv0BrY1LRdRSAi
         UtNlWrL1msZAtzn7mMyEnDXv1xNlwvmFsYkWz1V/upkt+7Il6pGhApokHf2lXXl56y8d
         17Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706099901; x=1706704701;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eErz+34XA2SH+q6nUCH407rk9Jd9s2beoCta3Tc+wxg=;
        b=I2/Z22uX/LLJsrjwYTdYXiKaqTEME7F0Y3muqAkf3tdcpBjbBsbTfG55qWG9tYhiB5
         wOTt+6zwWW8g6T5WHgcIMZ6JYsuGqRr2bmWozxejzLmSjdZNC9Y4YmUmIZhPR0C1iYmP
         bfGblPtPddvk5sQtSeP19nUr09Qzy0C384910M97/fwcS1De3dp9rIq0uAimWUyrlADA
         uEuBrZTUD31TZAlbY2wM6ad/iisd1Ock4SjiH4wmQNdYnx/zKaUdlWRxPosId1gjg+uI
         GTc1bpzp7dSViNltPmCN+r+7b+5Imc0G7WFQQ5q5eucZNrnTOE/t6H0G35w+iXwPHUm+
         NZfA==
X-Gm-Message-State: AOJu0YzcouTE2/IXuWMR4wSgNzFyhxCS5NCQ0IPgFiWvcPom2Gnf+n8/
	aNz8w3q4jJyQ+C311RLBo6kXStB+u8rzWH2NWdDXY6pkEy0CXoHY2HzpzUpoR+Y=
X-Google-Smtp-Source: AGHT+IEcmvjt2FacYK+z8AFeFgN6XsDd8oOiQ+Msgo9dlrmxCTyx4Rasaluw0LWJgsEpNEAXokSJYQ==
X-Received: by 2002:a05:6512:3cc:b0:50e:b65b:4944 with SMTP id w12-20020a05651203cc00b0050eb65b4944mr3052789lfp.21.1706099900779;
        Wed, 24 Jan 2024 04:38:20 -0800 (PST)
Received: from [172.30.205.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id o1-20020ac24c41000000b0050ea7b615c3sm2556075lfk.230.2024.01.24.04.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 04:38:20 -0800 (PST)
Message-ID: <0679f568-60e7-47d8-b86e-052a9eb4c103@linaro.org>
Date: Wed, 24 Jan 2024 13:38:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: qualcomm: Remove QDF24xx support
Content-Language: en-US
To: patchwork-bot+netdevbpf@kernel.org
Cc: timur@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, marijn.suijten@somainline.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20240122-topic-qdf_cleanup_net-v1-1-caf0d9c4408a@linaro.org>
 <170605983124.14933.9916722082205803213.git-patchwork-notify@kernel.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <170605983124.14933.9916722082205803213.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/24/24 02:30, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Mon, 22 Jan 2024 13:02:22 +0100 you wrote:
>> This SoC family was destined for server use, featuring Qualcomm's very
>> interesting Kryo cores (before "Kryo" became a marketing term for Arm
>> cores with small modifications). It did however not leave the labs of
>> Qualcomm and presumably some partners, nor was it ever productized.
>>
>> Remove the related drivers, as they seem to be long obsolete.
>>
>> [...]
> 
> Here is the summary with links:
>    - net: ethernet: qualcomm: Remove QDF24xx support
>      https://git.kernel.org/netdev/net-next/c/a2a7f98aeeec

Jakub, can we please drop this (or should I send a revert)?

It turned out that Qualcomm is actually still using this internally,
for "reasons".. [1]

Konrad

[1] https://lore.kernel.org/lkml/4c37d84f-ee46-4557-b25d-01ad9af4e950@linaro.org/

