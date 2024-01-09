Return-Path: <linux-kernel+bounces-21099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7DE8289D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C84F28624F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522DE3A27B;
	Tue,  9 Jan 2024 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fec97Xkm"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E3B3A264
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3367a304091so2960995f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 08:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704817003; x=1705421803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uM4bx9JfogXOCEh/2zqOEU5Nxv4Lz17EfumQJ6uXjyk=;
        b=fec97Xkmo3qH7pvVWZB9j/tGZR9x8/uv7nWoHaf37DB4CwIzljbVnC1nGMzpjrLJgN
         QQLtYtmD6OEjh79idU0hpKOwX4KYX7drZ+iSl8xmzshvQlHaG4Ezgl1bokRkpzVekc61
         sVdvUaKdvRM8EGPNHgbK39dXQzrpr8haFfJuLtutxxVgFBOJPfakTx4817NT9ltVM76E
         Avr4j5RPslT96RPPoKjntghmTihhwUSDcMprEs8W/5gUnQHQPx3ifEyzkKcpX5JPiVu8
         FNKEaVqD+TGzl4we9Qt0VgnWwPWLVo+IZhQR6BbIksQPd005iK3xN0AHTAG/yooDXHnf
         qDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704817003; x=1705421803;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uM4bx9JfogXOCEh/2zqOEU5Nxv4Lz17EfumQJ6uXjyk=;
        b=cUZwDdcDMbD+cZpRogtJp/9GXpdyjL4QzTQX1bOJSNpktDqL9wERC5n14BewEz+jRR
         zeshTajfeLSxEjM+NFQNAhtBR/+iNu8PNRxtt4c1RQ3aFt903HjGM7v9lBIvU5pbwZva
         4bbwKmT43YWkvuBtX8JXgWUPbq5VTCYO8y7MrSwGz9wBp33w0QQ/lpUi5kyI0G5v17F7
         7WpKCrklNNc2W9GYu1HU1WoDmFLMhF6cqNXROdb3ZRSYlB44vRCCZcdHXrEENlMKxGl6
         u7KJOE0J/smxjAOYDWpn8oTtkMJUWPbF4QxslhAa34cudayyxF/U6jOfhwMSUYRmlraa
         faXQ==
X-Gm-Message-State: AOJu0YyAM+g2oHtGWyNp5sA5LXkpSGSu2pKhJht74vvl7gkvT+39XS0R
	Thh53ZAOHBIE8lr7mkScnSpVfMiG7n+CoQ==
X-Google-Smtp-Source: AGHT+IGfcNr8gQ8XeZWGAKIbA/pKPo4p3CzphQ1F3insA3jF4nV4kM9Ll4oWdaxMT0F+3y0NrXx44Q==
X-Received: by 2002:a5d:6308:0:b0:336:c963:25e8 with SMTP id i8-20020a5d6308000000b00336c96325e8mr457336wru.109.1704817003273;
        Tue, 09 Jan 2024 08:16:43 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id p11-20020a5d59ab000000b00336ebf93416sm2817775wrr.17.2024.01.09.08.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 08:16:42 -0800 (PST)
Message-ID: <65b4168f-f9cd-45dc-a712-d5daabc9dbda@linaro.org>
Date: Tue, 9 Jan 2024 16:16:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: irq: include <linux/cpumask.h>
Content-Language: en-US
To: Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, sumit.garg@linaro.org,
 dianders@chromium.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel-team@android.com,
 andre.draszik@linaro.org, willmcvicker@google.com, peter.griffin@linaro.org
References: <20240109140437.3703330-1-tudor.ambarus@linaro.org>
 <ZZ1cRnjNlryrqAL0@FVFF77S0Q05N.cambridge.arm.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <ZZ1cRnjNlryrqAL0@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/9/24 14:46, Mark Rutland wrote:
> On Tue, Jan 09, 2024 at 02:04:37PM +0000, Tudor Ambarus wrote:
>> Sorting include files in alphabetic order in
>> drivers/tty/serial/samsung.c revealed the following error:
>>
>> In file included from drivers/tty/serial/samsung_tty.c:24:
>> ./arch/arm64/include/asm/irq.h:9:43: error: unknown type name 'cpumask_t'
>>     9 | void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu);
>>       |                                           ^~~~~~~~~
>>
>> Include cpumask.h to avod unknown type errors for parents of irq.h that
>> don't include cpumask.h.
> 
> s/avod/avoid/

ah, will fix, thanks.

> 
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>  arch/arm64/include/asm/irq.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
>> index 50ce8b697ff3..d5612bc770da 100644
>> --- a/arch/arm64/include/asm/irq.h
>> +++ b/arch/arm64/include/asm/irq.h
>> @@ -5,6 +5,7 @@
>>  #ifndef __ASSEMBLER__
>>  
>>  #include <asm-generic/irq.h>
>> +#include <linux/cpumask.h>
> 
> Minor nit: we usually have the <linux/*.h> headers first, then a line space,
> then the <asm/*.h> headers, e.g.

I wasn't aware of this habit. Will update accordingly in v2.

Thanks!
ta

