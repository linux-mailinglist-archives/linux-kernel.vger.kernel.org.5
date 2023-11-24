Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAF07F7163
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbjKXK2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjKXK2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:28:06 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53693110
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:28:12 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50aae766214so501841e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700821690; x=1701426490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nbo0FUidKX+K23TC4mX9mkPOe1qgse1OtvaVCBp4abk=;
        b=bbFklktoX3PIbHn5sH/rkAjogtknbAF3+Q8wcYBQCQuziIdmLJXEfBUl0fIjASKWkA
         iSeL04sAymq/CKbNVx7G/FhdViH5gQP/JNUumAzofd8NpADMucD3B1JT4xz1M+EYX610
         TXDWyyt60i4NuNau9XHp/amXAN5dWDIqewHgHaUWdqPY9Qh5pPGK1PuTGJfDkniwztog
         Obu8vRxtUzXR0IDrqn6Eh3V3zjpdKSfjnI4I+re3dnWSHMhnF3Z7PdF8MAGh2ggKwqQ2
         vdrsnBogxip6NyDtv1YDiTGSO5u7r8PxJHz4XbqhYjf0B0lylOATRU2Gl8GIsOPzYFId
         6V8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700821690; x=1701426490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nbo0FUidKX+K23TC4mX9mkPOe1qgse1OtvaVCBp4abk=;
        b=Xl50tI8RX87/9vYIFgzjfuJ8SXXSF3zbupfZMFRkzIFIRDrYCjAxkyIny0EXcVzJFV
         6zqJ2tHaDHjd8fbDra59xCN7mO+j29bhW32tf2/bY15PL18s/G9sZykpQgZMVHO5xAZb
         fH0do/ETisRUesA1nn0K6NXEpXm9FJgBXtZ9d35DgT3wHdvQE0z76IfVrebzVDjsZOCU
         ceUWlHKCIF7yuFHEZEFDDHO3H9YGlEmeEPq+iMKgRIH2neIsa04A6H6OLJ0Huu18IkCD
         MtPogNmU8vsdhmCbls2YzVpBZLqL3CHdPg2wEPmNTtJliapCoS6VUnjiesJNYmMM6/VI
         qxjg==
X-Gm-Message-State: AOJu0YykJxYsIVkEcustN72RT4wX/XwxEEPtE9s+9v2C/fCP9WqQrCuU
        TeShR5MyMKT/cIaWiJ7aFxVtfg==
X-Google-Smtp-Source: AGHT+IE3d4+XZv6KBciYkFY6vMzT3RRiHUMV/wCvD7eh8ji9/04Z6RQNti57N2iLRAT5l+jpr23OEw==
X-Received: by 2002:a05:6512:3d25:b0:50a:bacb:5b74 with SMTP id d37-20020a0565123d2500b0050abacb5b74mr1743294lfv.4.1700821690465;
        Fri, 24 Nov 2023 02:28:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:999:a3a0:3471:930b:671b:cf77? ([2a01:e0a:999:a3a0:3471:930b:671b:cf77])
        by smtp.gmail.com with ESMTPSA id c11-20020a5d4f0b000000b00332e67d6564sm2758299wru.67.2023.11.24.02.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 02:28:09 -0800 (PST)
Message-ID: <7232f08e-dfe3-43d6-a4f7-abf8360bbfc1@rivosinc.com>
Date:   Fri, 24 Nov 2023 11:28:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: fix __user annotation in traps_misaligned.c
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
References: <20231123141617.259591-1-ben.dooks@codethink.co.uk>
 <ZWA9HwUNHDFIw0wP@infradead.org>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <ZWA9HwUNHDFIw0wP@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/11/2023 07:05, Christoph Hellwig wrote:
> On Thu, Nov 23, 2023 at 02:16:17PM +0000, Ben Dooks wrote:
>> @@ -319,7 +319,7 @@ static inline int get_insn(struct pt_regs *regs, ulong mepc, ulong *r_insn)
>>  static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
>>  {
>>  	if (user_mode(regs)) {
>> -		return __get_user(*r_val, addr);
>> +		return __get_user(*r_val, (u8 __user *)addr);
>>  	} else {
>>  		*r_val = *addr;
>>  		return 0;
> 
> This is the wrong way to approach it.  Pass the untype unsigned long
> from the caller instead and do a single round of casts from that
> depending on the address_space.

I sent a similar patch two days ago with the same modification. I'm not
sure to get it. Why is it better to pass the "unsigned long" type from
the caller ? I mean, the resulting code would look like this right ?

static inline int store_u8(struct pt_regs *regs, unsigned long addr, u8 val)
{
	if (user_mode(regs)) {
		return __put_user(val, (u8 __user *)addr);
	} else {
		*addr = (u8 *)val;
		return 0;
	}
}

Is this better from a "semantic" point of view and be sure the casts are
done in a single place ?

> 
> And please also remove this horrible else after return entipattern
> while you're at it.

Acked,

Thanks,

> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
