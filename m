Return-Path: <linux-kernel+bounces-139159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4FF89FF41
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BBD1C23105
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4538817F376;
	Wed, 10 Apr 2024 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ts4QcG5E"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46D015B0E4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771852; cv=none; b=cb0vcHZIslowMKBA5cTpEbY7p/SE74QAUUSxi00jFPypy+Ah0U6HVmtog2NgxWXJHrL2XazpEa2cMic9PpisppkzFEg5qCXqzPTczWfierWH/loMauR6mYsxYjPznbY9oPMe44w1hnW3BtDuPlNaqYu9fvmJNwxd4s7jqANr8ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771852; c=relaxed/simple;
	bh=d4BtwqKAX8nsbOtJH/r0S6Y+oLvQxv6c8zbD+FFfF9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0UdXdK07iV65YBwoTL/zcCSDdU1XfNwz0ePTxRNsA8x3/BL270UUusNtTcjD52bZmv9HKfIp6UFSp2tcGfVOKYgvlFv78u7CxS3gkWJ0Jb9mXlNPBxN6MPQpTrbNTkNjJg2KVytLO0Q9re4eoNjGzTbvACw3X2YCyUyynOypHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ts4QcG5E; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d6c9678cbdso91008111fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712771849; x=1713376649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Keh+sIQeRPab3t60QMgWltAOm3qWZpzbMlaDmGjP9v4=;
        b=Ts4QcG5Ek3ER0MTyAo1wJy40MuGMsvGwuZq6WE3HN99XfVRX1GjSJtsY/TIGUCLwJz
         OYtMcLfOH+34rgcDeGYrwvjv12508+iiUDYp3Xg4lvhIJaMs5+a/czg3zUC1Ku9XKCHX
         zyds5LemfvDTgzdcFTv/9McXk2M8eFWi1Im5Np4SLqKwpBvcXXagQNPpKXs/WHB24iHQ
         ljK1GdzjhCJkFx2Gc+ghjbFJr09hQu7elVFztGrujOPzYTaGab8uGhTn/vGM0KmFgLR1
         jHQPTPTj5jG2UGRTT7oOPXiKpBI76uZHNIClBxXNYD3Xr/OOWNH2JbsONjEEE/yy7mtM
         UYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712771849; x=1713376649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Keh+sIQeRPab3t60QMgWltAOm3qWZpzbMlaDmGjP9v4=;
        b=l+RsHWAHdpne5fKyVQLkI9YiLkKcJmCj7Kql9RPk1ItcmUFL3/Jn/G/4ZKzsf+j8qD
         9RJnTvMlHsSIbMSpJAPm635y2URNoOJ1GB4fm4qe5fxl8a+lhK2q9pUEqiHrVNLTlFWM
         sld/6LIEuOtUwD41Zon21jNqtuoJ+JKLM384XvZB8KAJx1pf+tk+mnh0NOWEdvvq0n50
         qVON8rgFU8fjN6iNAy3T/P5oxlfjRc8baTJ2Pl+AZIw+HaWxgbJrRC0eCrArwppGZpeH
         Dfu0C6llfdbI+0EXuTd1kmHTh8skJlrbf4OOJdGMXwq9/C7ZYrxZNGN5PqzoFb2G64JG
         mW5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnWzMhScYb1PbJC8WM0NACLtTQow6f7gUysaO/K0qYJJK2N4b7xNfbXXwkhWy9wTA/gm0YQJN5XY3xb/mMUaEI4bLZf5NAYImVj1EV
X-Gm-Message-State: AOJu0Yx/fxvxG3Q2iNi0kEXaUuFvgwxN5nVCI2JJcwCTGo2HBeK6/+XV
	zbeqDbVP6/UCNmbMHiGNfBXngGu0sM1VDopJh69KwHr2I/eO8MB6r+UncVacGMw=
X-Google-Smtp-Source: AGHT+IE5JGH4lSYVlSEHhQH6EV1huMoARnine21xFIyBlZYyXopqr5UbT3v5//1+D8M8VOOpQl4S9Q==
X-Received: by 2002:ac2:48a2:0:b0:516:d250:86bd with SMTP id u2-20020ac248a2000000b00516d25086bdmr1962949lfg.44.1712771848929;
        Wed, 10 Apr 2024 10:57:28 -0700 (PDT)
Received: from [172.30.205.26] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id t20-20020a056512209400b00516be9fa424sm1883743lfr.254.2024.04.10.10.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 10:57:28 -0700 (PDT)
Message-ID: <fa826aed-579a-4432-a1eb-053a3b7f40c9@linaro.org>
Date: Wed, 10 Apr 2024 19:57:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: qcom: qmp-ufs: update SM8650 tables for Gear 4 & 5
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240410-topic-sm8650-upstream-ufs-g5-v1-1-5527c44b37e6@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240410-topic-sm8650-upstream-ufs-g5-v1-1-5527c44b37e6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 17:39, Neil Armstrong wrote:
> Update the SM8650 UFS PHY init tables to support Gear 4 and Gear 5
> using the overlays setup (only supported Gear 5 before), and sync
> back with the latest Qualcomm recommended values.
> 
> The new recommended values allow a solid 50% bump in sequential
> read/write benchmarks on the SM8650 QRD & HDK reference boards.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

I'm gonna trust you on copypasting these numbers properly as I
have no sources.. but that 50% speedup does look very nice!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

