Return-Path: <linux-kernel+bounces-16896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D327824595
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188031F244A4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7144124A1A;
	Thu,  4 Jan 2024 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kVe+qjl3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ECF24B25
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7bb982d0f12so44429639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 07:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704383909; x=1704988709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+LkB4Vo+u25oWI7sGQO48sDZuLcvpPhc24u586CsWs=;
        b=kVe+qjl3xbGw5qWbwaGJLueBZsSZWNrS0gHCt9jy8llqd3VWqnWAd+42K9WMM/OzWh
         +1klNDLjVzjSTkBswvg4xiifHF87PO+zJuXQYNcHtOk9tRifUfwVsn9l7z73c6RTvx5x
         UPpOrtgu9fIdtgbyTLoD+jD+rmGUbXZgbOv3XMvZQBsQ9DtCUIqo7lQ8nFwQvibehvau
         pRPzt3rdOpEVxiunjYorYIcjCwa1uir6yYE/7YLBJ/qUvq7aTpPs664DwZZP3+o8ouDa
         qzJ0csyUrQplH3sW8jqENa/cPR498SUj9G++VupUpQ3DpIMgg58+wRnU0QtnXWTGdikA
         yuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704383909; x=1704988709;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+LkB4Vo+u25oWI7sGQO48sDZuLcvpPhc24u586CsWs=;
        b=i3NXj41c+eIyAOE5nPLUJE58v6bzu+w42L3bGHWne/jEMapWjKjU3ZFEsOpt0kaibr
         qFXw4AcHTBOVIu6nDiErzGSozlfTWV60fLgNVJAPk5NYoQXV/je0FmSsh7R0Lu7pVjK/
         ACivlnOlttmIcWQoWqZJcJo5yyMrllEKhToNmRNFHuJ2ByIHwUTIGxHvIDX7dS7YBzXJ
         fe01u6f0cyvXHqoZLMmfUhcE3RIEzj5G5Y2GzEBWv+e3W2iES4qzztjAis/Jp0m+5Znt
         JnGyPa114HYGOtRpwZYzq21ZFXV08Hi3s/hO1BLpq/JoLEkJWl8uim+OOzlOe7sMOh7p
         PseA==
X-Gm-Message-State: AOJu0Yz3BmtEKVcq1h5MdVwMTcjUdF7Wyb3RARdSI03ktoiDEUNuz99C
	dXSaRdkI4Sro62sj1VXfe3F1XYNG21JqPA==
X-Google-Smtp-Source: AGHT+IH0j3oQCRY8sxvQe5xsZpHeGls13odOGuU65eTJqn0FYIyylaRiHWDyo9dxY5HyEPL4psyAAg==
X-Received: by 2002:a05:6e02:b48:b0:35f:f023:f8e2 with SMTP id f8-20020a056e020b4800b0035ff023f8e2mr508987ilu.17.1704383909345;
        Thu, 04 Jan 2024 07:58:29 -0800 (PST)
Received: from ?IPV6:2605:a601:adae:4500:b86c:e734:b34:45c6? ([2605:a601:adae:4500:b86c:e734:b34:45c6])
        by smtp.gmail.com with ESMTPSA id v16-20020a92d250000000b0035d6559c5b9sm9232707ilg.64.2024.01.04.07.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 07:58:29 -0800 (PST)
Message-ID: <84389bc3-f2e7-49c5-a820-de60ee00f8a7@sifive.com>
Date: Thu, 4 Jan 2024 09:58:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] LoongArch: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Content-Language: en-US
To: Huacai Chen <chenhuacai@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-arch@vger.kernel.org, WANG Xuerui <git@xen0n.name>
References: <20231228014220.3562640-1-samuel.holland@sifive.com>
 <20231228014220.3562640-8-samuel.holland@sifive.com>
 <CAAhV-H5TJPqRcgS6jywWDSNsCvd-PsVacgxgoiF-fJ00ZnS4uA@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <CAAhV-H5TJPqRcgS6jywWDSNsCvd-PsVacgxgoiF-fJ00ZnS4uA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Huacai,

On 2024-01-04 3:55 AM, Huacai Chen wrote:
> Hi, Samuel,
> 
> On Thu, Dec 28, 2023 at 9:42 AM Samuel Holland
> <samuel.holland@sifive.com> wrote:
>>
>> LoongArch already provides kernel_fpu_begin() and kernel_fpu_end() in
>> asm/fpu.h, so it only needs to add kernel_fpu_available() and export
>> the CFLAGS adjustments.
>>
>> Acked-by: WANG Xuerui <git@xen0n.name>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>> (no changes since v1)
>>
>>  arch/loongarch/Kconfig           | 1 +
>>  arch/loongarch/Makefile          | 5 ++++-
>>  arch/loongarch/include/asm/fpu.h | 1 +
>>  3 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index ee123820a476..65d4475565b8 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -15,6 +15,7 @@ config LOONGARCH
>>         select ARCH_HAS_CPU_FINALIZE_INIT
>>         select ARCH_HAS_FORTIFY_SOURCE
>>         select ARCH_HAS_KCOV
>> +       select ARCH_HAS_KERNEL_FPU_SUPPORT if CPU_HAS_FPU
>>         select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
>>         select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>>         select ARCH_HAS_PTE_SPECIAL
>> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
>> index 4ba8d67ddb09..1afe28feaba5 100644
>> --- a/arch/loongarch/Makefile
>> +++ b/arch/loongarch/Makefile
>> @@ -25,6 +25,9 @@ endif
>>  32bit-emul             = elf32loongarch
>>  64bit-emul             = elf64loongarch
>>
>> +CC_FLAGS_FPU           := -mfpu=64
>> +CC_FLAGS_NO_FPU                := -msoft-float
> We will add LoongArch32 support later, maybe it should be -mfpu=32 in
> that case, and do other archs have the case that only support FP32?

Do you mean that LoongArch32 does not support double-precision FP in hardware?
At least both of the consumers in this series use double-precision, so my first
thought is that LoongArch32 could not select ARCH_HAS_KERNEL_FPU_SUPPORT.

Regards,
Samuel


