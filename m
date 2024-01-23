Return-Path: <linux-kernel+bounces-35831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8433C83971A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71971C23C63
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BFF8120A;
	Tue, 23 Jan 2024 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lQ1r0Lua"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F3C8005D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032775; cv=none; b=mYOykqzNubbYXU/Sa6HMYZO7qwTL5wWAMHcTA3PSYBGRSJkIz6WyHOpJi6dfKfWJCguGx+UXZzuaRIeWUNh/Qx7xLeGNE0fORTUFA31OTZeg309hC5RJ9dBPCaVlRqRGkQd00uoGy14zY+dJv1wadMYrLvqXigE8lNz2xHIXdOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032775; c=relaxed/simple;
	bh=zy+VtAthqnrtNOUurs3SoKsfCadphFbukqOkKL+5+c0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKxKDsuPbRsBrU+I3KFbU7FxQ2k0O9Y3OWgqPXocnaAIBg68Ia3MY6JO0D7YOzSotLjV3DVnqs0jKLxTgH71RWCABV29LNSLvXuxnJM7vORHnXezOkNjZ/F13f4DC7pVj5g/mjx2cUWfaPn946QUd+YCOQO22U/9qOe5a8WmJ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lQ1r0Lua; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cd33336b32so61249111fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706032771; x=1706637571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MevgjBoC1naTbBSpDdFhU7jz6wq+Ub0rYmPiyyfGzGg=;
        b=lQ1r0LuaqIBsLzUw9F3CllEmNPwkUTvNHClVpuRm3iq3/0BM5kK8lH8HPiHSBKA4nR
         IkNVD6C7HeeFp6YIAW2HKv2oqGiY41U7cHFHSeE/CPQOIG7oCQekk26IUqmmz/XXCPjH
         wgwQCY9gEvgW8b6arKwH2Durs/sHl/3VMCdPU/x9ZbFqO4jlUvh2zF6txvdDhJO1bAtp
         dTFAdG/idcVGtFpG5tnaSTaM8VxmwfnZIBOIWuCixylG7rAl2lsS74LW/7WidwJo5ZAe
         ggiBUpkvs76V3dxEk9e1+DOftSzbo1QDRm0vXeC5lKUtNeKD82RiefH4vNB1U0bIAx0g
         s+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706032771; x=1706637571;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MevgjBoC1naTbBSpDdFhU7jz6wq+Ub0rYmPiyyfGzGg=;
        b=fM4sTQHnAOdDEEbRQitE4K0dyjyg+5tXkxb/r5o/CzgIVZX31NFnyz6rX5R+rPtSSM
         8jZxcqT4ByJTHBS/PS9zM5i/nQONpSp2rjWWbU+k42iwtNxRjN/NE4QwN+TgevNdv1KQ
         gpkIi38MCYLt8g+oJzLlUttwc2998mlP44K0X8rX8hnKWlSZDdzxyDlosrjboLOT0PvI
         z0QYKum5ej+OONo2IujNxZQEsujIqq+PkAhtS+G9iaipas8c44teU9Qz1iUjLFEVxy25
         w0sc/JPYlMJmfpwbMUXfB7BzK3CHq8Puya4SvOJyOR7i8SE6sIOOqvItMVyGzGUykzyu
         2LPw==
X-Gm-Message-State: AOJu0YyPXQc76U9ZrIjDG5jREp5W9wTcEFyHoI5RGYwQG68IlYQELFum
	zEadysnaY90qOew8Zg3QbAg7izuAoscN5UFyH98DsaGxt2fIOL4Cocmc2ajwIB0=
X-Google-Smtp-Source: AGHT+IFsQdXZATi7GwTB0ulTN78M/aUoE2hnQJP5hgZwsQ02mD2/+t03X9iw/GN1e8SEqoW0WSkhyw==
X-Received: by 2002:a05:651c:2208:b0:2cc:609d:eeaf with SMTP id y8-20020a05651c220800b002cc609deeafmr102633ljq.36.1706032771190;
        Tue, 23 Jan 2024 09:59:31 -0800 (PST)
Received: from [172.30.205.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id f17-20020a05651c03d100b002cdfc29b46dsm1514699ljp.88.2024.01.23.09.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 09:59:30 -0800 (PST)
Message-ID: <4c37d84f-ee46-4557-b25d-01ad9af4e950@linaro.org>
Date: Tue, 23 Jan 2024 18:59:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: qualcomm: Remove QDF24xx support
Content-Language: en-US
To: Timur Tabi <timur@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20240122-topic-qdf_cleanup_net-v1-1-caf0d9c4408a@linaro.org>
 <CAOZdJXXCmZi8Qx-y2D_NhJiafnGhvma2OY6F+KauqYcNAAQNCQ@mail.gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAOZdJXXCmZi8Qx-y2D_NhJiafnGhvma2OY6F+KauqYcNAAQNCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/22/24 21:34, Timur Tabi wrote:
> On Mon, Jan 22, 2024 at 6:02 AM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> This SoC family was destined for server use, featuring Qualcomm's very
>> interesting Kryo cores (before "Kryo" became a marketing term for Arm
>> cores with small modifications). It did however not leave the labs of
>> Qualcomm and presumably some partners, nor was it ever productized.
>>
>> Remove the related drivers, as they seem to be long obsolete.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Sad day indeed, but understandable.
> 
> Acked-by: Timur Tabi <timur@kernel.org>
> 
> If you're looking for other QDF stuff to remove, the QDF2400 hacks in
> the SBSA UART driver really should go.

I have a branch completely axing it, but it looks like Qualcomm
apparently still uses some internally [1].. I'm not super happy,
but let's wait on this one.

Konrad

[1] https://lore.kernel.org/linux-arm-msm/52479377-ff61-7537-e4aa-064ab4a77c03@quicinc.com/

