Return-Path: <linux-kernel+bounces-71572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A4F85A735
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802431F223D1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC81383A3;
	Mon, 19 Feb 2024 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bd78iZSg"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E730B381CB
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355849; cv=none; b=C0gUu1pSRUNeNiinFSogYD0TgEMa9LNK38KE1n7RdFjCJKHujCvXZkJnXTKAEEE4TK+wVUFBue2B8FIL7YdbcqcpvWaJtJUcIBNp3lhRMU8SgBVJ+LbUT3uxDf81QGxECtQhsJBINh7/lMiQQyNKpFNzLUdOloPjaGa6fwguvdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355849; c=relaxed/simple;
	bh=4u+vZRbprsYYDxvXhklQgHuRRhedwLi1UJ+06rsx97s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KT/eRdN7j6qxg41SwRpwLWUou7vzM3fgb5NAlsltl3D6ERHwZnhgQszuqbuvU2kZBtnoSJbXKXj3FNUeIzSrp3ah0jyBJuduKn3iiltTQkh0DXWX00EJ7uBR77WReIt79zqWy1n42DLRxta6RHyIUY5tIPpHeMvd6Nm3lKTLuzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bd78iZSg; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512b29f82d1so1571386e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708355846; x=1708960646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ptSDR4svst+yQx5Wi88IEwZI/4pEHOjgszHrf2X/Qmc=;
        b=Bd78iZSgIjPnh2aZIYaG70BALxZA2XHTXSpnNet3ypId/2a/BYFsA367SNHNj6ghF4
         45aPD3ogSTp92nYBB/YwuO7YfUxZDQhdtZTiUaKgkjcc4EKZmMCRPsZbXZhtOFZRZgnf
         tPAX0Jdia+bXAIeZqMm3BAZOjnfHQxB/LrBrdKiil9HtvY19IJKxeL9bRQ4ljVFyuae2
         5ojSDzE2bRpY1i88Z3Jk5pxOmGmBQPr9UDS3p/SfNenFoqAjEx00Gagepf4jiF3C8gLu
         Md0alHRFXh5niEBPsK8l1/PfySwmNQTMOePGkgW2lz0Moq+1af1rEnnQrqrau59KFZKI
         CC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708355846; x=1708960646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ptSDR4svst+yQx5Wi88IEwZI/4pEHOjgszHrf2X/Qmc=;
        b=jKyoeq8RHVcWhan1kV2E4GCHx1R+W3yiZXDQWXWr+21AebWl3QhiKu9afbvtE/PX+Q
         gN7CKVDIYP10IbkrLGIzVG5jKtOyJpnyTxYhI9MMCmBqWRDEyF4n6sbTy8eChJ58mzbt
         iag/bkVmYLHC/1C6XiN/bOPhclsQEAF4D9N6oIY3C7HRqisf1B5rI9LNZMrTlYh6gyTQ
         DdP5WQI48gK7LY0FvnmiVBWQW0Xq0JZPP4COtjtU/9+xT3Mq27CSw2/8MfSm3GEnd6h0
         y7GHvBH/YMc9n3YovgvSZxvbHl4NoUMxAOH5Sv/d3bkhF4LdB/Al7qVlMjmmIno52Ocq
         MSeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+k7xBIMAZjpXP44tKWqf9zO6MLpywZlra6AkwOJgKYrp7njfMapoOyNFUeFtrZdXeJpdiphWRAu2WbnXanO59UpOB2aDfnzNNGR2
X-Gm-Message-State: AOJu0Yyr95h3bzrPVeo3aT5tX2cSIAK2ZyVWu+11JucctLb3Y7Zy6Kw1
	/GP+Iq2swRui20eLLNe9krbzJHLM9DH/jlTe7lTdKKGour+BVOJOhVws1FfX9cQ=
X-Google-Smtp-Source: AGHT+IHJCPUTOqOOK0BVrAjb14LJw9QQjjlTyZ/c04J29r9LsFgra2adD3mwG6mUtZOUOtrVyzD/yA==
X-Received: by 2002:a19:2d16:0:b0:511:aae2:e5e8 with SMTP id k22-20020a192d16000000b00511aae2e5e8mr7803033lfj.52.1708355846088;
        Mon, 19 Feb 2024 07:17:26 -0800 (PST)
Received: from [192.168.86.110] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id bm8-20020a170906c04800b00a3d9e6e9983sm3080286ejb.174.2024.02.19.07.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 07:17:25 -0800 (PST)
Message-ID: <98dea91a-5d2b-432e-8949-46179c824d1b@linaro.org>
Date: Mon, 19 Feb 2024 15:17:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/12] arm64: qcom: add and enable SHM Bridge support
To: Bjorn Andersson <andersson@kernel.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Gross <agross@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Elliot Berman <quic_eberman@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Guru Das Srinagesh <quic_gurus@quicinc.com>,
 Andrew Halaney <ahalaney@redhat.com>,
 Maximilian Luz <luzmaximilian@gmail.com>, Alex Elder <elder@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@quicinc.com, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240205182810.58382-1-brgl@bgdev.pl>
 <htsty5siakcu2nxxapiuq7pgs27tjwkb3yxgmfs3bonsl6kylw@joa2viypstoa>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <htsty5siakcu2nxxapiuq7pgs27tjwkb3yxgmfs3bonsl6kylw@joa2viypstoa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/02/2024 19:58, Bjorn Andersson wrote:
> On Mon, Feb 05, 2024 at 07:27:58PM +0100, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> We've established the need for using separate secured memory pools for
>> SCM and QSEECOM
> 
> Where has this need been established, what is the actual problem you're
> solving with this series?

SHMbridge will restrict the amount of memory that TZ can see, making 
system more secure.

Need for having different pools makes this more scalable overall, so 
that different usecases can run seamlessly. ex: loading a TA and SCM calls.

> 
> Does SCM and QSEECOM, as it's implemented in the kernel today, not work
> satisfactory?
> 
>> as well as the upcoming scminvoke driver.
>>
> 
> Is smcinvoke driver upstreaming blocked by not transitioning the scm
> driver to a "secure memory pool"?
> 
> Is this happening now, or do we need to merge this series when that day
> comes?

SMCInvoke development is happening now, I see no reason for this 
patchset to wait for it.

This series can go as it is for two reasons.
1> improves system security in general
2> Hardware Wrapped key support patches also use this which are also in 
good shape and tested, ready to be merged.

> 
>> It's also become clear that in order to be future-proof, the new
>> allocator must be an abstraction layer of a higher level as the SHM
>> Bridge will not be the only memory protection mechanism that we'll see
>> upstream. Hence the rename to TrustZone Memory rather than SCM Memory
>> allocator.
>>
>> Also to that end: the new allocator is its own module now and provides a
>> Kconfig choice menu for selecting the mode of operation (currently
>> default and SHM Bridge).
>>
>> Tested on sm8550 and sa8775p with the Inline Crypto Engine and
>> remoteproc.
>>
> 
> It's reasonable to assume from mentioning of this (and Andrew's t-b),
> that the patchset has only been tested on recent platforms that indeed
> does implement shmbridge. Can you please share the list of other
> platforms that you've tested this on, and can you please get someone
> from IPQ to also give their r-b or t-b?

We will try to reachout to someone who has access to these.

thanks,
Srini

> 
> Regards,
> Bjorn
> 
>> v6 -> v7:
>> - fix a Kconfig issue: TZMEM must select GENERIC_ALLOCATOR
>>
>> v5 -> v6:
>> Fixed two issues reported by autobuilders:
>> - add a fix for memory leaks in the qseecom driver as the first patch for
>>    easier backporting to the v6.6.y branch
>> - explicitly cast the bus address stored in a variable of type dma_addr_t
>>    to phys_addr_t expected by the genpool API
>>
>> v4 -> v5:
>> - fix the return value from qcom_tzmem_init() if SHM Bridge is not supported
>> - remove a comment that's no longer useful
>> - collect tags
>>
>> v3 -> v4:
>> - include linux/sizes.h for SZ_X macros
>> - use dedicated RCU APIs to dereference radix tree slots
>> - fix kerneldocs
>> - fix the comment in patch 14/15: it's the hypervisor, not the TrustZone
>>    that creates the SHM bridge
>>
>> v2 -> v3:
>> - restore pool management and use separate pools for different users
>> - don't use the new allocator in qcom_scm_pas_init_image() as the
>>    TrustZone will create an SHM bridge for us here
>> - rewrite the entire series again for most part
>>
>> v1 -> v2:
>> - too many changes to list, it's a complete rewrite as explained above
>>
>> Bartosz Golaszewski (12):
>>    firmware: qcom: add a dedicated TrustZone buffer allocator
>>    firmware: qcom: scm: enable the TZ mem allocator
>>    firmware: qcom: scm: smc: switch to using the SCM allocator
>>    firmware: qcom: scm: make qcom_scm_assign_mem() use the TZ allocator
>>    firmware: qcom: scm: make qcom_scm_ice_set_key() use the TZ allocator
>>    firmware: qcom: scm: make qcom_scm_lmh_dcvsh() use the TZ allocator
>>    firmware: qcom: scm: make qcom_scm_qseecom_app_get_id() use the TZ
>>      allocator
>>    firmware: qcom: qseecom: convert to using the TZ allocator
>>    firmware: qcom: scm: add support for SHM bridge operations
>>    firmware: qcom: tzmem: enable SHM Bridge support
>>    firmware: qcom: scm: clarify the comment in qcom_scm_pas_init_image()
>>    arm64: defconfig: enable SHM Bridge support for the TZ memory
>>      allocator
>>
>>   MAINTAINERS                                   |   8 +
>>   arch/arm64/configs/defconfig                  |   1 +
>>   drivers/firmware/qcom/Kconfig                 |  31 ++
>>   drivers/firmware/qcom/Makefile                |   1 +
>>   .../firmware/qcom/qcom_qseecom_uefisecapp.c   | 281 +++++---------
>>   drivers/firmware/qcom/qcom_scm-smc.c          |  30 +-
>>   drivers/firmware/qcom/qcom_scm.c              | 179 +++++----
>>   drivers/firmware/qcom/qcom_scm.h              |   6 +
>>   drivers/firmware/qcom/qcom_tzmem.c            | 365 ++++++++++++++++++
>>   drivers/firmware/qcom/qcom_tzmem.h            |  13 +
>>   include/linux/firmware/qcom/qcom_qseecom.h    |   4 +-
>>   include/linux/firmware/qcom/qcom_scm.h        |   6 +
>>   include/linux/firmware/qcom/qcom_tzmem.h      |  28 ++
>>   13 files changed, 685 insertions(+), 268 deletions(-)
>>   create mode 100644 drivers/firmware/qcom/qcom_tzmem.c
>>   create mode 100644 drivers/firmware/qcom/qcom_tzmem.h
>>   create mode 100644 include/linux/firmware/qcom/qcom_tzmem.h
>>
>> -- 
>> 2.40.1
>>

