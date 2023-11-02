Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67917DF8AA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjKBRZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjKBRZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:25:36 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6578A123;
        Thu,  2 Nov 2023 10:25:33 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-509109104e2so1389505e87.3;
        Thu, 02 Nov 2023 10:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698945931; x=1699550731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uNZVlyzQ1sL4l4gGZgfOvYzM1lLpkdtOhbOEpCB9H7k=;
        b=bTbBN7VxXSA2ECARdfbNcJGc3fXTbPWb71voIgvQyjQPCAmvW7J4m6tKeIGlOoipaA
         VfrhJB2MwKTXSWclqkyI5ROLmqC7256U35ilFNoIOdwIh3ezDgwd4tAKEJT3rM6gF94s
         eb1cJxL0y3lg3J99st2QoVEZS/9EWvaGQjH0tbzFutwo0SJTn5w1pEadvxXcH34eJh9q
         bTSk8rV+8uqnCPq0+wF1e47C5xQpmxU0xZNKKljru3rR0R4hWRWOj5w63PtPfl8Rr8Bc
         frxcZ/y9OcZUDH4enw+Grao80FSjPbX8zT/LLDv2DvbYV1gYS+Qg6wv8G85kbOGB4LD3
         li1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698945931; x=1699550731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNZVlyzQ1sL4l4gGZgfOvYzM1lLpkdtOhbOEpCB9H7k=;
        b=QVecksxuChQJ0pHBa7roqipVw277vCM54JzxZlVUMWvn5U+QKAEJ94GyCRKOzka2UU
         BTa5hUehBy11gD+52dYwufX8awwYDu+DPj8Cl0tnHIG2aDlS0aHO/6L/BMewt0TZVe10
         FMh1/9B0vSbOqE+i2gSOzj3tcSMJiB6pLjdxQbYPfjbvkZyYXB/oRLF7gbne4uE1QPjQ
         egaiGS+qHvamz6P9kqYTYsFUL2Xbnlzk8DbIsTKnUkECftVV/cjWpFBpU6IE2HaU5f8R
         KcX7sbhzuw3ZhT3vv0XgBsmCLq6TURgKh+1mxG/vSo+nM4vx+rbWNctc6Ja5QpTrqvM/
         xXwg==
X-Gm-Message-State: AOJu0YwlygBQDjv6hG2s7BNa+ibZwOcrRqxviISTFd3x/y7q5h/Jc1nQ
        APnLwRCq04Qmg3dWvEqdBdBcGUvLcaw=
X-Google-Smtp-Source: AGHT+IGNcflDK5tx9dXHxqAkZ0BhsAWy/q3GpGaWNvhx3Ti1pY8diRK8GPvFwdgYGKxvkIcqpyKRIA==
X-Received: by 2002:a19:644d:0:b0:509:44b6:e3ac with SMTP id b13-20020a19644d000000b0050944b6e3acmr2964636lfj.61.1698945931285;
        Thu, 02 Nov 2023 10:25:31 -0700 (PDT)
Received: from [192.168.0.101] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id v6-20020a5d5906000000b0032f7cfac0fesm856147wrd.51.2023.11.02.10.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 10:25:30 -0700 (PDT)
Message-ID: <b8183f5e-7c4f-48c1-8130-54b77e55349d@gmail.com>
Date:   Thu, 2 Nov 2023 17:25:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/lib: Fix overflow of variable m when val >=
 1410065408
To:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231101153237.2214698-1-colin.i.king@gmail.com>
 <203cf76c-3855-408c-9a7c-8ff3f74a88bd@intel.com>
Content-Language: en-US
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <203cf76c-3855-408c-9a7c-8ff3f74a88bd@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2023 16:38, Dave Hansen wrote:
> On 11/1/23 08:32, Colin Ian King wrote:
> ...
>>   int num_digits(int val)
>>   {
>> -	int m = 10;
>> +	long m = 10;
>>   	int d = 1;
>>   
>>   	if (val < 0) {
> 
> Isn't this still broken on 32-bit where sizeof(long) == sizeof(int)?
> Seems like we need 'm' to be able to hold values that are ~10x larger
> than 'val' if we need this to work for the entire int range.

Good point, long long is required for 32 bit,

sizes:
arch     int   long   long long
i386     4     4      8
x86_64   4     8      8

I'll send a V2.


> 
> Also, performance doesn't matter here at *all* with the current use in
> a couple of printk()'s.  Just making 'm' 'long long' or u64 probably be
> just fine.

