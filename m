Return-Path: <linux-kernel+bounces-37471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE6283B086
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07671F24CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDB012A16C;
	Wed, 24 Jan 2024 17:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sj1xzL0G"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE8F129A97
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118754; cv=none; b=EBQzboWHh/mhFyKflX8dXMwT6lvneGIuK83dM/ZIEI4mTEJtGT/Vmzmu6w6g7Q09+9mW8FOr7u9AQN54xvNZM9KJ4lv/i1M2kqo/AGujRZNzxpIu048p4emSws/hux+Yl60Q6A7W0Vn5DTv6XqbxSH5IkGGoSXDdy14hps0lNds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118754; c=relaxed/simple;
	bh=2nzwYy5eLPzezXEa8LQ+/BiHlD0Mt33Sf5tv11jdlcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubJbpVwpqPY9c3gaab5eFwxWdHftTLpiKjItwX/oa/zODTUejTsA0U3G3nA5Nl4aZLPgp6ZdrrXzmrooLeqDtAwVR+Dtf5CGcDaldrBDnQSPafcQWPDOUVEbsePgunMiASY5XKg5mxPo61h7AglLFMdkdmijQtjZrFCVCd4x/jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sj1xzL0G; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5100c4aa08cso2070216e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706118751; x=1706723551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vTlQZ1fr4MYjqJNvKsZeP6R4Md0Qcnn9S554f0tlhZM=;
        b=Sj1xzL0G+MwmNSKuOkkY7myMdHQ1x3Kxu3y7yCD0qhrsFazeFB2DmzpwEAuuqxiTaF
         JC6Kn14LUf0kaW1TSSC/sxmsjzbxKdyCAnV1QwJ2eQ1aTzhGquHuOwdk8AxCffrTLypC
         iQhVPcoZb9W5foxRMSC8oUbPK2gfejJnGatH57z+M/kGPkYDmNS5fwnKQWG0R5mt9LD4
         6aclUOHYbSnnSD15L/FDpTS813RVfySH4ZUbOJVZHEmcR5JG7+CHPmFaEhKfyUoX5V7C
         Q1+wwd9NERY5kgVaB98++XAO75doawh59Xttk/wBqI6s2IUPnBs3jNQrcolnMOrRYHVG
         KoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706118751; x=1706723551;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vTlQZ1fr4MYjqJNvKsZeP6R4Md0Qcnn9S554f0tlhZM=;
        b=e5HJf5K61IqAdCPkujZzJFZUYJWyCB2cyTMqrBUwS9ze2nvMA14l3B+JHVlg3sPPst
         t3IEXlhkllF+lNM7F0CCAF8NM9Nsg5rOazwH83BzutYXcfjYqp1SKlG9ZkO0WYDr/8cX
         0GhPo6xkkwXIlqrL69LC0Ej4OGLwaCyX7CvDYBsy1MhIUvTUhnmx+Uwb8bylxZsgEdKr
         vzly+NQrOnrbaGLhXiZ7otxZxpIb2xA59xh365tIElYQ5CzjG9bfLwJoLgVbeadDacNA
         ZfFcT4EK25sdM+mPI9oT1GmpafeDZYkZrsDdzYXiKrgnRLHwFAyD3nR8TttlAC6kbNls
         0TDw==
X-Gm-Message-State: AOJu0YwNnMjumh0HidV/i+CrnrkL8A04yvGVUSwAQVB6MK6/wwVOkRsb
	qdWb0airjrL72xg04y7HJIwSZ20GVswvz8Mm3Kg+jnlh7CQGQaTqLKrKGOAz4B0=
X-Google-Smtp-Source: AGHT+IFVZa2kg7IyRx7QJp069qZ9912rNwBb+h/X1nfVuEMEY0k4ho5ymWS2GZhOS354vQXe07M81g==
X-Received: by 2002:a05:6512:3b98:b0:510:19dd:6c56 with SMTP id g24-20020a0565123b9800b0051019dd6c56mr18096lfv.125.1706118750800;
        Wed, 24 Jan 2024 09:52:30 -0800 (PST)
Received: from [172.30.204.154] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u1-20020a056512128100b0050eb25590ffsm2621579lfs.207.2024.01.24.09.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 09:52:30 -0800 (PST)
Message-ID: <7c74ef2b-0031-4861-9d97-2c242db14d5e@linaro.org>
Date: Wed, 24 Jan 2024 18:52:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: qualcomm: Remove QDF24xx support
To: Jakub Kicinski <kuba@kernel.org>
Cc: patchwork-bot+netdevbpf@kernel.org, timur@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 marijn.suijten@somainline.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240122-topic-qdf_cleanup_net-v1-1-caf0d9c4408a@linaro.org>
 <170605983124.14933.9916722082205803213.git-patchwork-notify@kernel.org>
 <0679f568-60e7-47d8-b86e-052a9eb4c103@linaro.org>
 <20240124073558.41c1b99d@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240124073558.41c1b99d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/24/24 16:35, Jakub Kicinski wrote:
> On Wed, 24 Jan 2024 13:38:19 +0100 Konrad Dybcio wrote:
>> Jakub, can we please drop this (or should I send a revert)?
>>
>> It turned out that Qualcomm is actually still using this internally,
>> for "reasons".. [1]
> 
> Oh, I thought you only meant they are using the UART driver (somehow).
> I'll revert, sorry.

Thanks for taking care of this!

Konrad

