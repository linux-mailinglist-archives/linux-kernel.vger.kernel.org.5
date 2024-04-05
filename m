Return-Path: <linux-kernel+bounces-133277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B2989A19A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 558C1B2700F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9463916FF2D;
	Fri,  5 Apr 2024 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAMfk9XH"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D1716EC0B;
	Fri,  5 Apr 2024 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331809; cv=none; b=CxBbzG/mdbsr3OjtttC3Hw9wiyOPppikHsb8T3gmfRRJslLvbXBuUhzoHQk42ZQ0por6i5Pjv+Pn+j04G5bdJn5dOr9KpGWw7J+kcOu3iB9q9QnBmcyl+ybRKWOpW1nGdycGghi+cXmdIzztQ5PcLWqKxwrfPiDVYCVOEWBxqK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331809; c=relaxed/simple;
	bh=3tjUb3aIhcJ6VyI06t2jNh/PHQu+242vcNQbZWuXUe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6eS0fX8xXCVCJ5FXZ0hw/vbeCCRChWna9YiL9I7g1a4gnCMH3Wif5kZXkFjOiErAnkdcx/c0SbCpyoB4Bf7Xb6L/gzarujGnWSIeqqkwVLmzsKUU9rWzn4PoX0koiJAjeI/jzI0fpzV3GkcSHbs6Zc5zCusp/VQ570CjRU30+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAMfk9XH; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36a06a409caso7062995ab.3;
        Fri, 05 Apr 2024 08:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712331807; x=1712936607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o5G4YX3A6SwCOkm+ekTzFYShVJvSdNT/a9NFK7+1Luc=;
        b=KAMfk9XHKpOFEe5fiYRM38ZZFjCYFEnlI9zL30x6Kks1THopggeyTiFDHR8K8uc7Wt
         D6SQQPKDF4a9++rqjLxxCbR7moQvoxlQDCM9wfrcajWp/D/owbELEQgwyY+7HccDuf3f
         TrXLqfMG+poXhg21l+qE9YDHCAV+3U9Ouo9tSK+rt78zYz6axPRtf1yFkLsrkHUOKfYV
         j00Rw1zekYsOgyb1PYqiHetHc71NMEZFYahzbqS/IEaiANIVFFWhogVqu7WTWjTdHkUi
         w0rBxfl+pg+V2b1ur3bi7QA5vDLX8cMAUvgHieCA5tmmbUKc8UcOs0CdFTZE0xQFrJmu
         2jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712331807; x=1712936607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5G4YX3A6SwCOkm+ekTzFYShVJvSdNT/a9NFK7+1Luc=;
        b=Jdk4csJ0fAZxPOzfBsNPGnHmz38tyVRao4apSP1q8kQvAYqF1L+AZRyNBSAcjjMReu
         W5H3kn7oJbPmNuNNrmNt+KmSv4mLgMHWAvs0NmSBjVfrr9jn2Fr/Swz04XCiERXbsEc5
         Uicpt7GxysGCbBjCvUsClCdlc6O2shkNAbDCHtQIo6JRiZCWYlmmkVVBOBs55/m/vuma
         mMqflszSnhU69FjOEM4twEoIcLQi6/0cQebKfWKwO+8kfoijknxUOuYUcWGdWo6LpkGb
         YV7hT32aNcF7dXNuT6HMuqHruunVnmSxmWQtQhmfZ0lXHmBuBgmnyqrSQmW17ni9Xxyq
         nDaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPL0bZGyXH5EB7ERJVqcJIbOyePZiuinlVCMGjNHuwEZGvR1Fl03xmFxESDb/NNuHUbN8TB98jNYl/OoLR9uoM1st5Ia5LagU1qWVS
X-Gm-Message-State: AOJu0YwOD6C6Jc7rGM8w4U4uZPyVdr2WaR3gmLmBEUD2PxPNajSX6vsA
	qT9feqHITADDnNZjOWqmAI+JtDYIhyFgD2x8Juq7Ta1TKTE7agT5fHkoR11f
X-Google-Smtp-Source: AGHT+IHnDWUKPgOIjBHX4/x1yAWbk+lxozZtWN8xafzN7p6tvmMwF2w0T76sJXYXwebbp63cnKNJ7w==
X-Received: by 2002:a05:6e02:1fe5:b0:36a:bba:8d95 with SMTP id dt5-20020a056e021fe500b0036a0bba8d95mr1758790ilb.31.1712331807486;
        Fri, 05 Apr 2024 08:43:27 -0700 (PDT)
Received: from [192.168.0.171] ([223.166.28.146])
        by smtp.gmail.com with ESMTPSA id j19-20020a63fc13000000b005e49bf50ff9sm1615582pgi.0.2024.04.05.08.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 08:43:27 -0700 (PDT)
Message-ID: <4ac84262-d5b2-4f63-8d0a-23bb45f4ed2d@gmail.com>
Date: Fri, 5 Apr 2024 23:43:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] soc: qcom: pmic_glink: fix client handling
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Halaney <ahalaney@redhat.com>
References: <20240403-pmic-glink-fix-clients-v2-0-aed4e02baacc@linaro.org>
Content-Language: en-US
From: Xilin Wu <wuxilin123@gmail.com>
In-Reply-To: <20240403-pmic-glink-fix-clients-v2-0-aed4e02baacc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024/4/3 11:10, Dmitry Baryshkov wrote:
> Fix two issues with the way the pmic_glink driver handles its clients.
> First issue is mostly theoretical, while the second issue can easily be
> reproduced if the drivers are built as modules.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Changes in v2:
> - Also take a lock at pmic_glink_rpmsg_callback() (Andrew Halaney)
> - Link to v1: https://lore.kernel.org/r/20240402-pmic-glink-fix-clients-v1-0-885440b81c65@linaro.org
>
> ---
> Dmitry Baryshkov (2):
>        soc: qcom: pmic_glink: don't traverse clients list without a lock
>        soc: qcom: pmic_glink: notify clients about the current state
>
>   drivers/soc/qcom/pmic_glink.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> ---
> base-commit: a6bd6c9333397f5a0e2667d4d82fef8c970108f2
> change-id: 20240402-pmic-glink-fix-clients-5df0bab3e871
>
> Best regards,

Tested-by: Xilin Wu <wuxilin123@gmail.com> # on QCS8550 AYN Odin 2
Fixes: 
https://lore.kernel.org/all/20240311-qcom-pd-mapper-v4-0-24679cca5c24@linaro.org/


Thanks,
Xilin

