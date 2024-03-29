Return-Path: <linux-kernel+bounces-125372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A14438924B5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19292B21EB5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E626C13AA48;
	Fri, 29 Mar 2024 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJBcHMrS"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCEB13A244;
	Fri, 29 Mar 2024 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711742278; cv=none; b=erMz4RdNoIa1CY2YVFwF+xLJbNySTBcRpgEAWArBz2lR6ID6IxtjzCzc8ayzm/se35yd5xRSOXjtnrQpacpqPabSxBgwGNJaYYN+bnb6RcNvw0W+1M/O+mYx5jRaTZ1snM73AabmrDW87E1r76TTVkQShInHsKs1fB2s9ctyoD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711742278; c=relaxed/simple;
	bh=ji2puHs2ApLpdIsQgEmTMvokE47R45ZXNgSSxONpTbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4k4jff6HK3UrEWOkTSySP0cX5pgDvLAv2gU8ApG/ytXDVCmCBxxL8M8MStvCxozbTqvXKM+edw6P4PgofHRQUyNRd1NSDVh93ivGvvECu4d7hTVcjfqk2BkU/tFq3Dgrv5gt/QpxuYIXObNvnKodOrl8iqWXD97HpZGzUYaGro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJBcHMrS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41495dcea8eso15610365e9.3;
        Fri, 29 Mar 2024 12:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711742275; x=1712347075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C23uZ0Jr08E06RbzAyD+Y4ogWC9iAo9dVeH4eyUiQkw=;
        b=ZJBcHMrSGb/A2eGzTqqlPiLxtOvSE9mKb1vZXt8yV9PygeLcpl4rKg+e6s416Ayg9o
         s5AjpmdnvTHvSLCwIlr6K1GewX4rZy0LzbEgGD3fzzPSjqpU8r75zRdOuiG0k68Ego7c
         8Kijko/Y+SEGYHxUtsDLw7KLU5Sa/X36EtpMpXL8MeqDnvuKRoBRdcUghI44ReukL5Cq
         k3mXpJ4/bxh7GzuCI/e42QAEvsa1W/S2IWj96PGHQ4JHvkNE9LPJ9PZ97vE5a1NGVA2s
         tF22msA/rwrjWbQY973qaTW+46MiQeuhKHoUtMW10dSARcjEjlJ/gk+eAFQHcl7EBGax
         iczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711742275; x=1712347075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C23uZ0Jr08E06RbzAyD+Y4ogWC9iAo9dVeH4eyUiQkw=;
        b=i4DHK6nQxkoakZapW3dCIBWDeTfkxjuD2Q4VcOxAcsl8tEbt7lQt4jI30AkqAaXjXC
         625E0wzBeoucGRSbkx/wE6jEQi/eaBnrqnrirYvsIL6hd8NDFPrvhxObKtXhQCHAWWM6
         pAIuKMIbbhZDZEruydmPqtOFITU2uHb8N8sZAxJUTscIF2ZLO29SnaJ1ULlkZsfEyi8x
         aXas915RXHLlpDH9Vi5lSBBpyG9y1f3fNE6DVzCRqIeTVsn8qCRIQHNxw37kdy/4H/62
         ulzi6S13/fWW1VOATJx8VOVp1sQCOzGLUqfNXv265o6BM3Z9vPuNK9pQpYaM2Wp8cPOR
         WDTg==
X-Forwarded-Encrypted: i=1; AJvYcCUFuTqkDhmfnNHtBMStowxTcYmjVLr86ePJjtF16ZGzQBp+vBnZxlJuCvUXeJwn0DTMx+h3sGJX8cBJrgpzIPWnBT9y6IjImXl4lm+Lfj/Y5czgBm7jjvb75kHXE223lp6/XZpGLR6frkWV4g==
X-Gm-Message-State: AOJu0YzcVokknpY1Bf+c2I55dYEX8khsrH1wH6lXXvfBKKEBW2qvMKV8
	z470t7D5HYMAONXEUZB4Ot3c+7qA76xOH1St5f0JE6ShzifhWDaN
X-Google-Smtp-Source: AGHT+IF/EBaSq+i5rvNdMkiWncVhrfbH1Nuz+qhq9iHxVG0tp8Naajdm6Q2sT4aVTODslHM28AnxYQ==
X-Received: by 2002:a05:600c:45c7:b0:414:86a6:f9ff with SMTP id s7-20020a05600c45c700b0041486a6f9ffmr2647559wmo.4.1711742274731;
        Fri, 29 Mar 2024 12:57:54 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id m34-20020a05600c3b2200b004148a65f12asm6415776wms.1.2024.03.29.12.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 12:57:54 -0700 (PDT)
Message-ID: <9db0fc7b-f24a-4d76-b8bd-ec577ecba0c6@gmail.com>
Date: Fri, 29 Mar 2024 20:57:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] firmware: qcom: qseecom: convert to using the TZ
 allocator
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Elliot Berman <quic_eberman@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Guru Das Srinagesh <quic_gurus@quicinc.com>,
 Andrew Halaney <ahalaney@redhat.com>, Alex Elder <elder@linaro.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@quicinc.com
References: <20240325100359.17001-1-brgl@bgdev.pl>
 <56e1c63a-4c09-4d92-9ef2-aad5390879cc@gmail.com>
 <CAMRc=Mf_pvrh2VMfTVE-ZTypyO010p=to-cd8Q745DzSDXLGFw@mail.gmail.com>
 <CAMRc=MfsVWcoMC-dB-fdxy332h-ucUPTfEUMAnCt5L-q3zJxWg@mail.gmail.com>
 <82f94b54-82d1-49b9-badf-63d948b347fc@gmail.com>
 <97e1f121-9e84-4e63-9c9c-57e2de0b29d7@gmail.com>
 <CAMRc=McLJFGcy-A6PZNmjgDXnvx8z0J4k-Dbak-txvWnycHG2A@mail.gmail.com>
 <2b1dc031-d645-494c-9103-a2bb422ea60b@gmail.com>
 <CAMRc=MdoSPuedbGhy4toDEkw0vSzESDz2bXGpyt_=R4hqXW+Uw@mail.gmail.com>
 <9b1e5ea0-bb32-4c42-b2e9-204bde31b905@gmail.com>
 <CACMJSesvM6_PhhR_2sP4JX6bR4ytVVg=MwWBEVrCHf5FNp2JXw@mail.gmail.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <CACMJSesvM6_PhhR_2sP4JX6bR4ytVVg=MwWBEVrCHf5FNp2JXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/29/24 8:46 PM, Bartosz Golaszewski wrote:
> On Fri, 29 Mar 2024 at 20:39, Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>
>> On 3/29/24 8:26 PM, Bartosz Golaszewski wrote:
>>> On Fri, 29 Mar 2024 at 20:22, Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>>>
>>>> On 3/29/24 8:07 PM, Bartosz Golaszewski wrote:
>>>>>
>>>>> Both with and without SHM bridge?
>>>>
>>>> With CONFIG_QCOM_TZMEM_MODE_GENERIC=y (and the upcoming fix) everything
>>>> works. With CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y things unfortunately
>>>> still get stuck at boot (regardless of the fix). I think that's
>>>> happening even before anything efivar related should come up.
>>>>
>>>
>>> This is on X13s? I will get one in 3 weeks. Can you get the bootlog
>>> somehow? Does the laptop have any serial console?
>>
>> Surface Pro X (sc8180x), but it should be similar enough to the X13s in
>> that regard. At least from what people with access to the X13s told me,
>> the qseecom stuff seems to behave the same.
>>
>> Unfortunately I don't have a direct serial console. Best I have is
>> USB-serial, but it's not even getting there. I'll have to try and see if
>> I can get some more info on the screen.
>>
> 
> I have access to a sc8180x-primus board, does it make sense to test
> with this one? If so, could you give me instructions on how to do it?

I guess it's worth a shot.

 From what I can tell, there shouldn't be any patches in my tree that
would conflict with it. So I guess it should just be building it with
CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y and booting.

I am currently testing it on top of a patched v6.8 tree though (but that
should just contain patches to get the Pro X running). You can find the
full tree at

     https://github.com/linux-surface/kernel/tree/spx/v6.8

The last commit is the fix I mentioned, so you might want to revert
that, since the shmem issue triggers regardless of that and it prevents
your series from applying cleanly.

Best regards,
Max


