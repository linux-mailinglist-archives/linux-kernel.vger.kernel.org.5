Return-Path: <linux-kernel+bounces-12625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7765A81F7ED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7522870F2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F026FDE;
	Thu, 28 Dec 2023 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ONCzrVn6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A8E6FCC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-67f9f24e7b1so40680896d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 03:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703764075; x=1704368875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BsK7xZISxiuXDg9wPVaPYTu1lvOYZ2U6PfsoOzeLC88=;
        b=ONCzrVn6HZzTcSrTrpSpgjs+iF9dU75ksRX42JKE19fKg9CE2u4ZqjPhulOI/SN7x4
         QgE+DpOC1FwXkuVKN7jfIi4iVE47/ffyThlqR2vVRkbgvRn453oUjghRRunV/PMlhadd
         19MQV9qLyWpfUnEo1i4mLqqXltsSUlxsD4h0yXfW6xXrhHo0Plm7wMz1revnNuFYBaNf
         GqTIBa6BUBbGMSCvlNfgpBZ3/Axg0F8KeFmKhenawP9EFPjnW88M7gB47U91swU1vJ2E
         0yISDT1qkC76W3TQXNJldJoFQzCeITcEvxftHkomdeIug4875JQbcVLZtKY2fPyAj+f7
         A77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703764075; x=1704368875;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BsK7xZISxiuXDg9wPVaPYTu1lvOYZ2U6PfsoOzeLC88=;
        b=nWt71Px9/Jwt2XzlgqZIIC+Ap4+ydyYsLgUbIBhlKMDDiJmR58bbnxkTOXrQJV85ZM
         P8fUp9GwTLwYdrQb3h76oyEl3oM9xLL7JkuKu0jYU2fzANIYp1q+ur7oFeYbHlvBefy/
         zcXJ5BTMf6M2DspdYHjlL9V/zMrsnDhRNR07OTcZMpjx3c9aDoKAvKoFdXi3ptWPpzX1
         kGiFeylZTT3deWKKvlUPeCMATn6jucdGYCu3cArPXH3pKASiSphyk7bDo6psvjWkFRHy
         Ro9F/fyjz6E3KpVdlkIp5zjAMdWVrawdyNrJlEnTNY2RFdNFj1FkeoP9oBl1YJprLhHx
         d+8A==
X-Gm-Message-State: AOJu0YwEA3xxapfIHE8g4iCqYFJY2XT6qDzLu40k5Wq2RemYTQqTLBfs
	rVWRvC7U2AOMDOh4eXDtHg+w7bdQA2dPWg==
X-Google-Smtp-Source: AGHT+IEQu2QL3XzljmcS3eSkHoxzhGZ/p1UjT35OZSocsoO2YywMlyaULvMpJFbCdEk7/LtZYBGT4A==
X-Received: by 2002:ad4:4d0f:0:b0:67f:aed5:1195 with SMTP id l15-20020ad44d0f000000b0067faed51195mr10331244qvl.106.1703764075167;
        Thu, 28 Dec 2023 03:47:55 -0800 (PST)
Received: from [192.168.199.125] (178235179028.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.28])
        by smtp.gmail.com with ESMTPSA id d5-20020a056214184500b0067f9ab3564asm5150841qvy.68.2023.12.28.03.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Dec 2023 03:47:54 -0800 (PST)
Message-ID: <f34dd5de-9e56-4c58-b9bf-2356b41d17b1@linaro.org>
Date: Thu, 28 Dec 2023 12:47:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] firmware/psci: Set
 pm_set_resume/suspend_via_firmware() on qcom
Content-Language: en-US
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>
References: <20231227-topic-psci_fw_sus-v1-0-6910add70bf3@linaro.org>
 <20231227-topic-psci_fw_sus-v1-2-6910add70bf3@linaro.org>
 <20231228102801.fzaubcjq5thfwgxg@bogus>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231228102801.fzaubcjq5thfwgxg@bogus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28.12.2023 11:28, Sudeep Holla wrote:
> On Wed, Dec 27, 2023 at 11:15:31PM +0100, Konrad Dybcio wrote:
>> Most Qualcomm platforms implementing PSCI (ab)use CPU_SUSPEND for
>> entering various stages of suspend, across the SoC. These range from a
>> simple WFI to a full-fledged power collapse of the entire chip
>> (mostly, anyway).
>>
>> Some device drivers are curious to know whether "the firmware" (which is
>> often assumed to be ACPI) takes care of suspending or resuming the
>> platform. Set the flag that reports this behavior on the aforementioned
>> chips.
>>
>> Some newer Qualcomm chips ship with firmware that actually advertises
>> PSCI SYSTEM_SUSPEND, so the compatible list should only grow slightly.
>>
> 
> NACK, just use suspend-to-idle if SYSTEM_SUSPEND is not advertised. It is
> designed for such platforms especially on x86/ACPI which don't advertise
> Sx states. I see no reason why that doesn't work on ARM platforms as well.
Not sure if I got the message through well, but the bottom line is, on
Qualcomm platforms the "idle" states aren't actually just "idle" (read:
they're not like S0ix). All but the most shallow ones shut down quite a
chunk of the entire SoC, with the lowest ones being essentially S3 with
power being cut off from the entire chip, except for the memory rail.

Konrad

