Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207137F5526
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 01:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjKWAH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 19:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWAH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 19:07:26 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9241C18E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 16:06:58 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5c1acc1fa98so1089795a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 16:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700698018; x=1701302818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HfvvVEoo2ZPc5Eo27do8s9IpqY2QyXGUUCVk7yAwMCQ=;
        b=FB/eQVfx4L2birSzTSyuoaAhbyXX2lHnKBeODR1ogS3Kj37iPbhwdmlJySLWAdihs0
         QbSzzqt3KhUI9/bTaK5mXqPC4y/fA5NzjM685n5nhClIHBqkxT6qrKKmNHZ1/h3JFnUt
         u50J8MwTR6GtniIIWX0zkFOCRQbAts54NXZ8NcXb2/61EbNjMw8AC4ztHoVK1ONVrbxe
         CWPW3ldXfEVOYeK/AFSoD/JOkWbNWzfW1eDMO9cv0nw6dPFRCseqIiAzuXp9pxzetCjL
         7BV2tniMZp1D6lkR2A57QiCyXEUn41Zsck8fq4y+L117NNLnTH67vwOxOMwA+f4xO/9E
         SrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700698018; x=1701302818;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfvvVEoo2ZPc5Eo27do8s9IpqY2QyXGUUCVk7yAwMCQ=;
        b=ofOhFHwzYP52s3/Jp08dNRMaI2PFRHU/LvH3J9sc5BwrxVRVOe8N2RaMtisgCCu2su
         MlONQP3rTVpJA/XF1Y4PMIo3GFFSqsYgjf2IO2cBUF4F6QuCzWjdaT9DOlKtGkL/7Oqd
         j5XNYvFcoAPdYQVsnvZinVf9QFrpGBY9SLf0uWSPt0z0pz1VerCmWFyrD1uZx6v/FWKk
         LdNffbD4VbJabjeJ+9SoE4f7IA84UO5107oT8x1ZdOVPuqu2Gf3gOIExIWaSrEhJElIj
         6qaBO4qP4IRN19ksf5Sjl5GiUktW0cCyFJecTidicoPvVXYhq9BVc6kRhx5r+EFUnQOr
         PNfQ==
X-Gm-Message-State: AOJu0YzpBQDnCoJq7VG346N1p/Yu2R1syIRJ3tq+kxO1U48En3Raz+ba
        1wzcAEetlZUrSJKieCAkPMfwLw==
X-Google-Smtp-Source: AGHT+IEwFMqGPwD33UW3ABxmr7nd/CddgFkLcJ+TM9pXbL7khyTzz/hWNuRt864Ilx/pO1gArN5JmQ==
X-Received: by 2002:a17:90b:1b03:b0:280:23e1:e4dd with SMTP id nu3-20020a17090b1b0300b0028023e1e4ddmr1418778pjb.17.1700698018004;
        Wed, 22 Nov 2023 16:06:58 -0800 (PST)
Received: from ?IPV6:2606:4700:110:82f3:5936:4753:3e8:2d8d? ([2a09:bac5:21b2:1246::1d2:2c])
        by smtp.gmail.com with ESMTPSA id z3-20020a170902ee0300b001cc2ebd2c2csm253083plb.256.2023.11.22.16.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 16:06:57 -0800 (PST)
Message-ID: <c81c83e7-881a-4fe8-9d1a-0321e10a8633@bytedance.com>
Date:   Thu, 23 Nov 2023 08:06:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] arch,locking/atomic: arc: arch_cmpxchg should
 check data size
To:     Andi Shyti <andi.shyti@linux.intel.com>
Cc:     ubizjak@gmail.com, mark.rutland@arm.com, vgupta@kernel.org,
        bcain@quicinc.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        chris@zankel.net, jcmvbkbc@gmail.com, geert@linux-m68k.org,
        mingo@kernel.org, palmer@rivosinc.com, andrzej.hajda@intel.com,
        arnd@arndb.de, peterz@infradead.org, mhiramat@kernel.org,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mattwu@163.com, linux@roeck-us.net
References: <20231121142347.241356-1-wuqiang.matt@bytedance.com>
 <20231121142347.241356-2-wuqiang.matt@bytedance.com>
 <ZV594z0bNQR-vo2b@ashyti-mobl2.lan>
Content-Language: en-US
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
Autocrypt: addr=wuqiang.matt@bytedance.com; keydata=
 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
 4mCJUdEkdwCS
In-Reply-To: <ZV594z0bNQR-vo2b@ashyti-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andi,

On 2023/11/23 06:17, Andi Shyti wrote:
> Hi Wuqiang,
> 
> On Tue, Nov 21, 2023 at 10:23:43PM +0800, wuqiang.matt wrote:
>> arch_cmpxchg() should check data size rather than pointer size in case
>> CONFIG_ARC_HAS_LLSC is defined. So rename __cmpxchg to __cmpxchg_32 to
>> emphasize it's explicit support of 32bit data size with BUILD_BUG_ON()
>> added to avoid any possible misuses with unsupported data types.
>>
>> In case CONFIG_ARC_HAS_LLSC is undefined, arch_cmpxchg() uses spinlock
>> to accomplish SMP-safety, so the BUILD_BUG_ON checking is uncecessary.
>>
>> v2 -> v3:
>>    - Patches regrouped and has the improvement for xtensa included
>>    - Comments refined to address why these changes are needed
>>
>> v1 -> v2:
>>    - Try using native cmpxchg variants if avaialble, as Arnd advised

BTW, the changelog should be in the cover letter. I'll correct it in next
version, so don't bother resending to make more noises.

>> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
>> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>> ---
>>   arch/arc/include/asm/cmpxchg.h | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
>> index e138fde067de..bf46514f6f12 100644
>> --- a/arch/arc/include/asm/cmpxchg.h
>> +++ b/arch/arc/include/asm/cmpxchg.h
>> @@ -18,14 +18,16 @@
>>    * if (*ptr == @old)
>>    *      *ptr = @new
>>    */
>> -#define __cmpxchg(ptr, old, new)					\
>> +#define __cmpxchg_32(ptr, old, new)					\
>>   ({									\
>>   	__typeof__(*(ptr)) _prev;					\
>>   									\
>> +	BUILD_BUG_ON(sizeof(*(ptr)) != 4);				\
>> +									\
>>   	__asm__ __volatile__(						\
>> -	"1:	llock  %0, [%1]	\n"					\
>> +	"1:	llock  %0, [%1]		\n"				\
>>   	"	brne   %0, %2, 2f	\n"				\
>> -	"	scond  %3, [%1]	\n"					\
>> +	"	scond  %3, [%1]		\n"				\
>>   	"	bnz     1b		\n"				\
>>   	"2:				\n"				\
>>   	: "=&r"(_prev)	/* Early clobber prevent reg reuse */		\
>> @@ -47,7 +49,7 @@
>>   									\
>>   	switch(sizeof((_p_))) {						\
>>   	case 4:								\
>> -		_prev_ = __cmpxchg(_p_, _o_, _n_);			\
>> +		_prev_ = __cmpxchg_32(_p_, _o_, _n_);			\
>>   		break;							\
>>   	default:							\
>>   		BUILD_BUG();						\
>> @@ -65,8 +67,6 @@
>>   	__typeof__(*(ptr)) _prev_;					\
>>   	unsigned long __flags;						\
>>   									\
>> -	BUILD_BUG_ON(sizeof(_p_) != 4);					\
>> -									\
> 
> I think I made some comments here that have not been addressed or
> replied.

Sorry that I haven't seen your message. Could you resend ? I rechecked
my mailbox and the mailing lists, but no luck.


> Thanks,
> Andi

Regards,
Wuqiang

> 
>>   	/*								\
>>   	 * spin lock/unlock provide the needed smp_mb() before/after	\
>>   	 */								\
>> -- 
>> 2.40.1

