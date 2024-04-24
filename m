Return-Path: <linux-kernel+bounces-156660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 714AF8B066F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2BCE1C22AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7681591F2;
	Wed, 24 Apr 2024 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tM6/PJiM"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4002A158DC1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952257; cv=none; b=CHCdmPV7CrtIJiG4LejegQUGbQT1x+cq5U36mcNSAqC/DOpwmlp1PVqVnDtTvsyRbkDPs4qQSbJcvUP6A6FAqpFgdMjqOAdvrQ+KpiDiGldt/WJzrj3IC9F4ye6BcRW5uj+TuXn6t4+GbkoIYQnGmT6gZoCKDD1JD4ZeoZmqffo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952257; c=relaxed/simple;
	bh=nK7nS1UVq9zzGNXgNSJp+OxtsmQk9Oa3cfVYovruWM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GySm9+7U1KJcIxFB1JtDDCVS3F5kTn/rAGfnZ4D2aG1orXdRkTf+Fo21iSZzFzQGZSFu9owKzA5PRKt2WGzhbSjlQjHs1yCXbOAXNbn3icGjqHaPCcqxaZUv2RZnJfzkPLzCbNn9S/xqW58x3Jnm0LgDc6cG9O4oFn7Glngr2qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tM6/PJiM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41b09fb205dso2331465e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713952254; x=1714557054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b85HZpYiIiKl+GUwBq8FX1s6RozGan1UaidoFryFICM=;
        b=tM6/PJiMZs46EAiXb9fRocc+gjuNwY8wGWfd1kX8Oi9J9zTQna8LgKICNNYO8yvwae
         uqWscoZnGSw4JaKtTemJlr+OfeDqWgW0NSBKIKm/QGqllkE7Kon/1otGnOwAmgq8YwJZ
         nzjVP3DnK4/58oyuDTze7pDV3f91UEASdCunUzQI1VyztSRc2WuwYXWut4PZlB1OJttC
         hAOvmYRncz/3oLWxjgS0oEa70VXspMj/aGQKklPBVpCKwsqrZdeSdSiZD2CEXQnPsrwZ
         M46lSBnyh25k03wzQlDLd2oDMhzMplITcOgoGE+h2JpIXmoImxR13WuhwuqeXH5T6cu8
         hCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713952254; x=1714557054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b85HZpYiIiKl+GUwBq8FX1s6RozGan1UaidoFryFICM=;
        b=k7OZR0U4AmcOdHwxIkbSyDCJSj1sT4YkxpO+ys94MDB+Mf2F4gBchEuYkVd1rAtoSW
         aEg301Kt10fAM5xZsTD+FMAzlLNaKiuz5Vg5XhrM9neyA+5H8R6155DswbOFN0F2I5GJ
         62FdR2OlEeUBt7YZ2dpXPxTpPRqNEnov5qf69xM72cuhxx+ZehecCvyZcSL0NSKWi2KS
         YPD47B8FOcW9PdF28PNJqD3VK9gJh1mgrFFyEQ9yVyKYRF2wzJk+BQvsBF7h3bl0n/ii
         Dac/Uezf0jYlQhGyRBY2sTU46nqhI8haJyx6YjNoULLCvWhvlBTcxb8gTxxa09xl8pbP
         kiig==
X-Forwarded-Encrypted: i=1; AJvYcCV7xAKqCOfYWk6rT6QlxlOi6GQ/avMDUnbDNST9P3mDR8qYMgOjKh5tKEp1EOp/lO9mAFQBtsINtxy+1S6ZyxWaLjq02KjVWZa2JFbe
X-Gm-Message-State: AOJu0YznEizdw/cPgbmHyR92t2yCYwTaRrGVmDER4oNgqopPXVR4UGKu
	/6JIbpfwjWppxbggfvZdgb9vxJnWrjXbytYQEklWgr6Q1mdQdj4YJmzOkMmSvxU=
X-Google-Smtp-Source: AGHT+IFzD7doS/skuhId3F6zBpDePKoXPrR1SbrrEgdu87uiB3mysWvJZqj8vbifp9buIb5Ge1lsUg==
X-Received: by 2002:a05:600c:310e:b0:41a:9fc2:aab7 with SMTP id g14-20020a05600c310e00b0041a9fc2aab7mr1331576wmo.38.1713952254543;
        Wed, 24 Apr 2024 02:50:54 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c3b8500b0041a3b5ed993sm11453248wms.25.2024.04.24.02.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 02:50:54 -0700 (PDT)
Message-ID: <621dbaaa-6b86-45b5-988e-a6d9c39b13d7@linaro.org>
Date: Wed, 24 Apr 2024 10:50:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 RESEND 5/5] venus: pm_helpers: Use
 dev_pm_genpd_set_hwmode to switch GDSC mode on V6
To: Jagadeesh Kona <quic_jkona@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Kevin Hilman <khilman@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>,
 Ajit Pandey <quic_ajipan@quicinc.com>
References: <20240413152013.22307-1-quic_jkona@quicinc.com>
 <20240413152013.22307-6-quic_jkona@quicinc.com>
 <5c78ad52-524b-4ad7-b149-0e7252abc2ee@linaro.org>
 <b96ef82c-4033-43e0-9c1e-347ffb500751@quicinc.com>
 <a522f25f-bb38-4ae1-8f13-8e56934e5ef5@linaro.org>
 <dbd1b86c-7b5f-4b92-ab1f-fecfe1486cfc@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <dbd1b86c-7b5f-4b92-ab1f-fecfe1486cfc@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/04/2024 10:45, Jagadeesh Kona wrote:
> 
> Thanks Bryan for testing this series. Can you please confirm if this 
> issue is observed in every run or only seen during the first run? Also 
> please let me know on which platform this issue is observed?
> 
> Thanks,
> Jagadeesh

rb5/sm8250

My observation was on a previous _boot_ the stuttering was worse. There 
is in the video capture three times that I count where the video halts 
briefly, I guess we need to vote or set an OPP so the firmware knows not 
to power-collapse quite so aggressively.

---
bod

