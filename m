Return-Path: <linux-kernel+bounces-163032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 595858B63F1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8E421F2234B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66A5178CCF;
	Mon, 29 Apr 2024 20:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="byQXqCty"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1BB1779AB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714424395; cv=none; b=RVgeDac8ag2xPn1l47wuwpxDx7VUHR+LyumRqpyukDE1zIUJE0HOvxHTpB6fgesHH1h6Mnd0zLaAOUcLouDREQqVcSU9w/M1NdLbq6pqml3w8P6l3MKxPhf40Q11XSGRFRRg7Fm4GI7NmZnRDWNK3CoQwvGBSxjwvmDAiLgtWFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714424395; c=relaxed/simple;
	bh=GOfEDRU6P0ovWrWCU9wtFsIhy74/04c7AX+niJ+qtt4=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=JujRs3fnuXLejxTDXVu5x5lOPm9EY064UW7qPtfuu6IXnjWyYh1cDIVkiG0dPmMalhuxVAQEZ7ZocSHDh42xxXF9beeFt+PD5EYHz20My8XXdxWKTiobqTDL6bFADBqN4Yz9CeQ98PVF7BrJ94hf7X5cvl0Hwhk+1X9HihVNRo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=byQXqCty; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f0aeee172dso3460771b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1714424392; x=1715029192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPb10z2R6QzqCU/Ny7A6YIEMfMl5Kr9JPZ53mPCpdgY=;
        b=byQXqCtyLlixH+TXDbYgk3c2ARFOcDGc5SKTn0XZF4kSctEh36fupBI10jqdXCotgV
         0zoW7wfC7UUNzR5I+2XWH7YFML08H+sakz+d5TZiDyy+q7OIz9VrhMWm3jICw1lP7vWV
         0rjKICLa9uT36BZyvKrxbcfxdi6tczk2/eHaocPUJOSsWB9tnUAV6QpwkHx6xucmb95y
         kaVd37J+dT2ajGbX5sGy1fcKxhtJ4CW8JbnldmBtLo1FF6MmnHX41vh6c2pOTJAjg7jv
         77qCbBfXEoqbGW7KOFIsyZKfQke69NBhOna/YVU9fElTd+TgHpTq0gVp/iSB0/maKc7o
         Frxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714424392; x=1715029192;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPb10z2R6QzqCU/Ny7A6YIEMfMl5Kr9JPZ53mPCpdgY=;
        b=WqBj7+vkLwEPfNox7QJ6hWJAg0UL3bDIo/+27MCqJMoIOh0ZNrTYJW9gfiqXRKTf/E
         ZqwelI+ACjeFR+5otualtObQ4CEkCyAA0SYomdOKHRi8EwUsErd6Q+6IfUUEQY9mbbCi
         DPVvv8LEBYTSTRt1WMTr53yEDNuCiJIN0vwQk7F6XYGJxL7rqY6o7bEtIyPWSPrF2CSr
         LlFzFKnGXV3SGiACiD7t0sn47YbJ2N2RbIckDljli65HTfQj68dccaaSqp3zk+CRetrg
         /27eeLP5jDL1xtK8/H8gsTbPtqXVgZJdzNTphnQ1LKgNXb3WSHbkx4OfGUa+a9UIra7j
         9xpA==
X-Forwarded-Encrypted: i=1; AJvYcCW3TtClG9i6UjUepuiP90aR8AaawVADQ/GazOIhbijwvM5A9e7rS4P88EA1k/uGS/C4tvY65verhKAuetMWGLeic3efLYaimAcYBJK6
X-Gm-Message-State: AOJu0YyqtqNsb4REdq6KM3pW4YuGjiPgVPAiwCRq8EdTvYZLlhkB4xGz
	l+bWBXF9CBEr94cMoKhZ/Nntt30ib9gFhMIGmcTz7tvRi8lZirpWPdKZN6B1i/g=
X-Google-Smtp-Source: AGHT+IHIKkaYV9ZXxRvvVi+o+bLxYVmWl7xyTt+htZ7i1zC3bt5vINHy15SJmXRoDfBppCvN4VrC3Q==
X-Received: by 2002:a05:6a00:2e91:b0:6ec:ebe0:e4ba with SMTP id fd17-20020a056a002e9100b006ecebe0e4bamr1023158pfb.9.1714424391806;
        Mon, 29 Apr 2024 13:59:51 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id fj40-20020a056a003a2800b006f3021367desm13045927pfb.197.2024.04.29.13.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:59:51 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:59:51 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Apr 2024 13:59:47 PDT (-0700)
Subject:     Re: [PATCH] cpuidle: riscv-sbi: Add cluster_pm_enter()/exit()
In-Reply-To: <CAPDyKFph3WsZMmALnzBQKE4S_80Ji5h386Wi0vHda37QUsjMtg@mail.gmail.com>
CC: nick.hu@sifive.com, anup@brainfault.org, rafael@kernel.org,
  daniel.lezcano@linaro.org, Paul Walmsley <paul.walmsley@sifive.com>, linux-pm@vger.kernel.org,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, zong.li@sifive.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: ulf.hansson@linaro.org
Message-ID: <mhng-eea6b80c-4359-46d0-85d9-358bc89e9169@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 29 Apr 2024 07:32:12 PDT (-0700), ulf.hansson@linaro.org wrote:
> On Mon, 26 Feb 2024 at 07:51, Nick Hu <nick.hu@sifive.com> wrote:
>>
>> When the cpus in the same cluster are all in the idle state, the kernel
>> might put the cluster into a deeper low power state. Call the
>> cluster_pm_enter() before entering the low power state and call the
>> cluster_pm_exit() after the cluster woken up.
>>
>> Signed-off-by: Nick Hu <nick.hu@sifive.com>
>
> I was not cced this patch, but noticed that this patch got queued up
> recently. Sorry for not noticing earlier.
>
> If not too late, can you please drop/revert it? We should really move
> away from the CPU cluster notifiers. See more information below.

Sorry about that, I'll toss it.  I'm testing some other stuff right now 
so it might miss today's linux-next.

>> ---
>>  drivers/cpuidle/cpuidle-riscv-sbi.c | 24 ++++++++++++++++++++++--
>>  1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
>> index e8094fc92491..298dc76a00cf 100644
>> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
>> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
>> @@ -394,6 +394,7 @@ static int sbi_cpuidle_pd_power_off(struct generic_pm_domain *pd)
>>  {
>>         struct genpd_power_state *state = &pd->states[pd->state_idx];
>>         u32 *pd_state;
>> +       int ret;
>>
>>         if (!state->data)
>>                 return 0;
>> @@ -401,6 +402,10 @@ static int sbi_cpuidle_pd_power_off(struct generic_pm_domain *pd)
>>         if (!sbi_cpuidle_pd_allow_domain_state)
>>                 return -EBUSY;
>>
>> +       ret = cpu_cluster_pm_enter();
>> +       if (ret)
>> +               return ret;
>
> Rather than using the CPU cluster notifiers, consumers of the genpd
> can register themselves to receive genpd on/off notifiers.
>
> In other words, none of this should be needed, right?
>
> [...]
>
> Kind regards
> Uffe

