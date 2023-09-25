Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C717AD261
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjIYHx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjIYHx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:53:27 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90AFE3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:53:19 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4047ef37f55so18012255e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695628398; x=1696233198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LA9aIdP6oUsEuxyES4cGO7GMfWmfd5vo+OxgnkgCK18=;
        b=RjbWsn/+LRW9QKhuLGvdSsYEwRcEg4Mucufz8mlQOZbZC6NHIsFrxAzSvkR0jlKRqG
         GjsiNoPfetz2xXO8VjI/Y6a8tcVtGazhdGZjrkalHs12bFQbtl3yWc5Fo8MKVpGVLhUP
         rUyn+bKQ6/JBDTeXPbAps6UzYWJlJpbYuIY5ka6deuDK4T0f4VQV4170Eml+96/HjVKx
         1kI0EZ2AhqdaxmL1onnUUjLEnSfn067yGCW+7UQIv9EpFm0PXV5n9JsgpiSa4m/SDcjS
         GRltvdEsgFUNJn7EkJ9bjx5/ofiSZ3FTkrVwdDUy6PjOE4wtNqlGLElTKvTB4tRC+4xh
         Ymlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695628398; x=1696233198;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LA9aIdP6oUsEuxyES4cGO7GMfWmfd5vo+OxgnkgCK18=;
        b=Eu71v0fYtcLvd4W5EywX/t+SoUNWkgfuIE+cddTCjv+jUwDVwQWam+J1dIldkLMeTk
         vWn2Omb//h6OUckLo3CiSr9fBvRCaUC5ZvnXLe6K01waidD/aOox3N75WL4QsOM6il19
         AQkKzAFTaD0MrZqMF9w1bFEX8ZxDeJqYgMng8n3xOW2kTXL6PI+gSsAnoFjzoZziyK/i
         Qa87+Owhxa7Ez4Ja0ENclcgOC5gvMbNmFZY+jJwR8xuuiNR7ZTg4kJyTPi03v+pscP59
         lIXW7BnNOGZghOBSBWA+b7HUNBj4WUl/wo8byds6ShMzoCfi9NsS9sk3BcZ/ORGaA/BG
         d0SA==
X-Gm-Message-State: AOJu0YzyiAI/X/F+uAfezwHRCQ8WIMAg2yAj/02mGeCpng7bDDjontEF
        yEL4WHxS6j8NVqUW6Tvp6cMx5+ros+wQNQH5DeYMVg==
X-Google-Smtp-Source: AGHT+IFc5ZRYT1o/k/93+PlPbcsvc2QnQHbxkFnt341ov/kqaDgO7oAIY5wDGBPc4UYnKk/U4t4g8Q==
X-Received: by 2002:a05:600c:1e18:b0:405:1ba2:4fcf with SMTP id ay24-20020a05600c1e1800b004051ba24fcfmr4899643wmb.4.1695628398043;
        Mon, 25 Sep 2023 00:53:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:3df1:f103:36a9:423d? ([2a01:e0a:999:a3a0:3df1:f103:36a9:423d])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c230e00b00402f7b50517sm11610774wmo.40.2023.09.25.00.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 00:53:17 -0700 (PDT)
Message-ID: <839c611d-6f13-403b-b37e-a69b589658cc@rivosinc.com>
Date:   Mon, 25 Sep 2023 09:53:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing/user_events: align uaddr on unsigned long
 alignment
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230914131102.179100-1-cleger@rivosinc.com>
 <20230914131700.0ba3ee80@gandalf.local.home>
 <20230914132956.569dad45@gandalf.local.home>
 <a736f219-9a38-4f95-a874-93e1561906d5@rivosinc.com>
 <20230922192231.GA1828-beaub@linux.microsoft.com>
Content-Language: en-US
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20230922192231.GA1828-beaub@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/09/2023 21:22, Beau Belgrave wrote:
> On Tue, Sep 19, 2023 at 02:59:12PM +0200, Clément Léger wrote:
>>
>>
>> On 14/09/2023 19:29, Steven Rostedt wrote:
>>> On Thu, 14 Sep 2023 13:17:00 -0400
>>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>>
>>>> Now lets look at big endian layout:
>>>>
>>>>  uaddr = 0xbeef0004
>>>>  enabler = 1;
>>>>
>>>>  memory at 0xbeef0000:  00 00 00 00 00 00 00 02
>>>>                                     ^
>>>>                                     addr: 0xbeef0004
>>>>
>>>> 				(enabler is set )
>>>>
>>>> 	bitoffset = uaddr & (sizeof(unsigned long) - 1); bitoffset = 4
>>>> 	bit_offset *= 8;				 bitoffset = 32
>>>> 	uaddr &= ~(sizeof(unsigned long) - 1);		 uaddr = 0xbeef0000
>>>>
>>>> 	ptr = kaddr + (uaddr & ~PAGE_MASK);
>>>>
>>>> 	clear_bit(1 + 32, ptr);
>>>>
>>>>  memory at 0xbeef0000:  00 00 00 00 00 00 00 02
>>>>                                   ^
>>>> 				bit 33 of 0xbeef0000
>>>>
>>>> I don't think that's what you expected!
>>>
>>> I believe the above can be fixed with:
>>>
>>> 	bit_offset = uaddr & (sizeof(unsigned long) - 1);
>>> 	if (bit_offset) {
>>> #ifdef CONFIG_CPU_BIG_ENDIAN
>>> 		bit_offest = 0;
>>> #else
>>> 		bit_offset *= BITS_PER_BYTE;
>>> #endif
>>> 		uaddr &= ~(sizeof(unsigned long) - 1);
>>> 	}
>>>
>>> -- Steve
>>
>>
>> Actually, after looking more in depth at that, it seems like there are
>> actually 2 problems that can happen.
>>
>> First one is atomic access misalignment due to enable_size == 4 and
>> uaddr not being aligned on a (long) boundary on 64 bits architecture.
>> This can generate misaligned exceptions on various architectures. This
>> can be fixed in a more general way according to Masami snippet.
>>
>> Second one that I can see is on 64 bits, big endian architectures with
>> enable_size == 4. In that case, the bit provided by the userspace won't
>> be correctly set since this code kind of assume that the atomic are done
>> on 32bits value. Since the kernel assume long sized atomic operation, on
>> big endian 64 bits architecture, the updated bit will actually be in the
>> next 32 bits word.
>>
>> Can someone confirm my understanding ?
>>
> 
> I have a ppc 64bit BE VM I've been validating this on. If we do the
> shifting within user_events (vs a generic set_bit_aligned approach)
> 64bit BE does not need additional bit manipulation. However, if we were
> to blindly pass the address and bit as is to set_bit_aligned() it
> assumes the bit number is for a long, not a 32 bit word. So for that
> approach we would need to offset the bit in the unaligned case.
> 
> Here's a patch I have that I've validated on ppc64 BE, aarch64 LE, and
> x86_64 LE. I personally feel more comfortable with this approach than
> the generic set_bit_aligned() one.
> 
> Thanks,
> -Beau
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index e3f2b8d72e01..ae854374d0b7 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -162,6 +162,23 @@ struct user_event_validator {
>  	int			flags;
>  };
>  
> +static inline void align_addr_bit(unsigned long *addr, int *bit)
> +{
> +	if (IS_ALIGNED(*addr, sizeof(long)))
> +		return;
> +
> +	*addr = ALIGN_DOWN(*addr, sizeof(long));
> +
> +	/*
> +	 * We only support 32 and 64 bit values. The only time we need
> +	 * to align is a 32 bit value on a 64 bit kernel, which on LE
> +	 * is always 32 bits, and on BE requires no change.
> +	 */
> +#ifdef __LITTLE_ENDIAN
> +	*bit += 32;
> +#endif

Hi Beau, except the specific alignment that is basically what I ended up
with for the BE 64bit case (ie just bit += 32). Regarding the generic
alignment, depends on what the maintainers wishes (generic of user_event
specific). I also feel like this shoulmd be handle specifically for
user_events which uses set_bit in some non standard way. Any suggestion ?

Thanks,

Clément

> +}
> +
>  typedef void (*user_event_func_t) (struct user_event *user, struct iov_iter *i,
>  				   void *tpdata, bool *faulted);
>  
> @@ -481,6 +498,7 @@ static int user_event_enabler_write(struct user_event_mm *mm,
>  	unsigned long *ptr;
>  	struct page *page;
>  	void *kaddr;
> +	int bit = ENABLE_BIT(enabler);
>  	int ret;
>  
>  	lockdep_assert_held(&event_mutex);
> @@ -496,6 +514,8 @@ static int user_event_enabler_write(struct user_event_mm *mm,
>  		     test_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler))))
>  		return -EBUSY;
>  
> +	align_addr_bit(&uaddr, &bit);
> +
>  	ret = pin_user_pages_remote(mm->mm, uaddr, 1, FOLL_WRITE | FOLL_NOFAULT,
>  				    &page, NULL);
>  
> @@ -514,9 +534,9 @@ static int user_event_enabler_write(struct user_event_mm *mm,
>  
>  	/* Update bit atomically, user tracers must be atomic as well */
>  	if (enabler->event && enabler->event->status)
> -		set_bit(ENABLE_BIT(enabler), ptr);
> +		set_bit(bit, ptr);
>  	else
> -		clear_bit(ENABLE_BIT(enabler), ptr);
> +		clear_bit(bit, ptr);
>  
>  	kunmap_local(kaddr);
>  	unpin_user_pages_dirty_lock(&page, 1, true);
