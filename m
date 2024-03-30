Return-Path: <linux-kernel+bounces-125589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6B6892913
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 04:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F03DB22E60
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 03:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C6E7470;
	Sat, 30 Mar 2024 03:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPdy7BQj"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5841BB642;
	Sat, 30 Mar 2024 03:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711770249; cv=none; b=EM1xdZMwYu0HNKszHI+hqoalmf6vuFnjBEBS0z4FKI1M2TZ/etgyRzJ4quidmGvYj1FL1L58gCfCaT0Ifb8EjNl1h95ICpFjecnSuMEo87HZnHWWW2G0yU/3bn3MRowq4UGAbjMhMVomuUo+X2aMrwNbCAtqOlVnVmos7o5DueI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711770249; c=relaxed/simple;
	bh=QdFTG23hbXU6axx+snIQYEAfo0yAVMQ85LzrTKrvjTI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hHUZGKhcVhVMp6EvyeaYHudQTcWtMGp+X5ZG5/7rb8P059Av/Fi4h2UHaXYEyecWC1GAmR24D0o18EPTEoWdwd4Is1myspESeTjfhXuvjQmiRV0Lmnbp+KdERACEUYpkJVoYz2sl53c6Lfa0g7YMak8CSLL3BhMEyTtBC3kQ+Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPdy7BQj; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d8b519e438so1805645a12.1;
        Fri, 29 Mar 2024 20:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711770247; x=1712375047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mZVCYA6fIZw7UVkEo5rDiYQNpX8Kx+zZ6SIOO647FO0=;
        b=jPdy7BQjhHBEpRkgW0LOZESMJAErH7KB3U6+ZdZLUS6TWzfvgyLG+dp0xBgoBEHJV9
         +kqttJg/Lo4Af2PsLp9XAI75RDvTFT562uc+g+2EmT1mPp3p7F4B+W2x/e3BPuQdIYVn
         335jO7taqq32+SrGtPTiPpWXVnz0Y3IJdB5bSZHRFnkSdqXRMnV5iWM/5dkUx+phxIPQ
         ljuSvJObT23erV3iHfRW1UAokbk7eXfau1XN2Ar+zlk3BSudP49Z8mFmlbMobzLEXtQ0
         wTElQWFQcr5Ek10n5A9n9UHEz6BroD97vDMSAqwCeq1OfW3EFcD+dmGnXNRbqXrmE7BV
         qJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711770247; x=1712375047;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZVCYA6fIZw7UVkEo5rDiYQNpX8Kx+zZ6SIOO647FO0=;
        b=NLXRxamr+4WUtUio4gsQcnUojjszFExZVb0wT4v2aVODIZBZedgw2GVdAyCj9EdWO8
         LmXJOoG/x+P7sWHYNf1xFfmhQMiVeg+thAMCnalXMYl7xx38CGXww4fJlrXtB3H6y0sC
         r7AG72uwTViVjua0nBaEKG97jl85ZnfOFQgSk12Yu2N4uAOAS3CI6F7qJTTtjcQ6TB8+
         Z4XD6KEo6/k9zalYBYwnYRJ9+jit8j4xfXHrK/rhOiEtQMj0gbDJAzR/4AWFqmVIFsdy
         FeKSsi9Wkl9zRyRaJ0l3YViE1GRe4HjGIpw2ns95jPWdZPr4iGjWf5I1zC3ps09yZc0G
         Vplg==
X-Forwarded-Encrypted: i=1; AJvYcCVc+mx6C1oi5qavvwq/GoMH34GeJd5idzJfS8zXurlHJK8idpt+9i5HNWrOpCPY0P7Z43DyWt/CHNCyUqaPUQOx00VpjHfAZK4NrbzMz0WLXCyE2pjBYkCTsG4TpzYkXoCmgu/x83Nh
X-Gm-Message-State: AOJu0YyIa4VqlJtUscV1knCeGN7xtroQJSun+1dFWTV06IN55txsi53w
	F3BtKQgcQBZMR6kznYfI8PjQ9Nk/dXmm9MJhZdczuGLN2WjH1pbI
X-Google-Smtp-Source: AGHT+IEmoSr88aI1tp+TOCDmnOMuadV/HCPsleSFk0SPWG5ugOkpDNxfajnHjrmIfHw/RxPRVD3dKw==
X-Received: by 2002:a17:903:555:b0:1e2:577:f694 with SMTP id jo21-20020a170903055500b001e20577f694mr3836272plb.61.1711770247560;
        Fri, 29 Mar 2024 20:44:07 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:ba1:cc2b:c45f:1699:a1c3? ([2600:8802:b00:ba1:cc2b:c45f:1699:a1c3])
        by smtp.gmail.com with ESMTPSA id w20-20020a1709027b9400b001dca3a65200sm4228337pll.228.2024.03.29.20.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 20:44:06 -0700 (PDT)
Message-ID: <5e5c81af-a7c8-44b8-b5df-3153256fb928@gmail.com>
Date: Fri, 29 Mar 2024 20:44:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v2 5/5] clk: scmi: Add support for get/set duty_cycle
 operations
To: Cristian Marussi <cristian.marussi@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com,
 vincent.guittot@linaro.org, peng.fan@oss.nxp.com, michal.simek@amd.com,
 quic_sibis@quicinc.com, quic_nkela@quicinc.com, souvik.chakravarty@arm.com,
 mturquette@baylibre.com, sboyd@kernel.org
References: <20240325210025.1448717-1-cristian.marussi@arm.com>
 <20240325210025.1448717-6-cristian.marussi@arm.com>
Content-Language: en-US
In-Reply-To: <20240325210025.1448717-6-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/03/2024 14:00, Cristian Marussi wrote:
> Provide the CLK framework callbacks related to get/set clock duty cycle if
> the related SCMI clock supports OEM extended configurations.
> 
> CC: Michael Turquette <mturquette@baylibre.com>
> CC: Stephen Boyd <sboyd@kernel.org>
> CC: linux-clk@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

