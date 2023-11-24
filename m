Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AD57F714E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345567AbjKXKVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345427AbjKXKVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:21:16 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74459A2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:21:22 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b2a85c99bso1316185e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700821281; x=1701426081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vk+K03FMpa5I++N+IPb24j4gsziH07t0yvKcvp4gCiw=;
        b=aHzbpTLOfD6d3KOPshpE6hLklIeXuCTdTTThqPZKUKDyGYy0bI5g5RwIj0bwA15tep
         w4hpnST0y0Kexim5YeycDpOhbLg8HeZtr129/SHQmKqUI7TBtuePKO7qCso7GFmUzKlp
         p5HUJOlWT03LocPfgN/nCTu81Qg3ItkzX1lfY4MgnIwUTTnoTrYOUYT6GxddZYRyPM26
         19MIN18J23XiQZNSy5DOp1fJ3xLKrH/dSLolw+/tHwQJhIPFBDdhGUpp9P+wjhBof/a3
         bFFc4M313aUzj8qANKWlJIi4eZ0mCAP0cO9k3C/eO+lqu7YcRxuW4OkmmYQR/NTI4W0y
         8O9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700821281; x=1701426081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vk+K03FMpa5I++N+IPb24j4gsziH07t0yvKcvp4gCiw=;
        b=cM27zWSXm/i0BuqIRTkfv1JglvHF2N0FAqZHjabsldbSkR8JGPnUzCUvbTHn6DhspK
         w5hEgQmoTQURl4RGWXfUHU2P83D/DlxLHh9pekiAJvZ3PCD0u3cfR8+6Ha/0vBv6VaH1
         K/b22MSrI3JXLJkZJ8gwZXFQgGgOQvdDGNi14VUxBb0+F9x6vqHaRzJc2WrCtGa6psi5
         4Eo7NxvNXfVTiRTX2DOj5gky8mzXtV6lZJCOHctk7QmXPKBuER1Hb/myU4QgBUHuPuv5
         nk9SwlTs1zV8NrfP0LdBwL9DTUjjgOUeASm+hcYTIYONcZEBYVhbf1SxQIPzcG1VPpjO
         ZgBQ==
X-Gm-Message-State: AOJu0Ywwz/E0jSPzIe3p1wQXCn2Aqmq2eIam9IsILk7fnQSq3zhd31Fn
        fCOjoL89N5N+cQLBACCfkQ25jA==
X-Google-Smtp-Source: AGHT+IHfAetx+moACOMxx0ZqVDGW0f2zx0GRuaQijEBgGWyP33sq9c4jdtFCKMaWouOHYVP0LZ7Pnw==
X-Received: by 2002:adf:d1ee:0:b0:32f:9b7c:fe73 with SMTP id g14-20020adfd1ee000000b0032f9b7cfe73mr1629025wrd.5.1700821280779;
        Fri, 24 Nov 2023 02:21:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:999:a3a0:3471:930b:671b:cf77? ([2a01:e0a:999:a3a0:3471:930b:671b:cf77])
        by smtp.gmail.com with ESMTPSA id c9-20020adfef49000000b0032fb7b4f191sm3952549wrp.91.2023.11.24.02.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 02:21:20 -0800 (PST)
Message-ID: <5a4971eb-853a-493c-8c02-0c7bd14b88d6@rivosinc.com>
Date:   Fri, 24 Nov 2023 11:21:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: fix __user annotation in traps_misaligned.c
To:     Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu
References: <20231123141617.259591-1-ben.dooks@codethink.co.uk>
Content-Language: en-US
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20231123141617.259591-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

I sent a similar patch two days ago
(https://lore.kernel.org/linux-riscv/20231122135141.2936663-1-cleger@rivosinc.com/).

On 23/11/2023 15:16, Ben Dooks wrote:
> The instruction reading code can read from either user or kernel addresses
> and thus the use of __user on pointers to instructions depends on which
> context. Fix a few sparse warnings by using __user for user-accesses and
> remove it when not.
> 
> Fixes:
> 
> arch/riscv/kernel/traps_misaligned.c:361:21: warning: dereference of noderef expression
> arch/riscv/kernel/traps_misaligned.c:373:21: warning: dereference of noderef expression
> arch/riscv/kernel/traps_misaligned.c:381:21: warning: dereference of noderef expression
> arch/riscv/kernel/traps_misaligned.c:322:24: warning: incorrect type in initializer (different address spaces)
> arch/riscv/kernel/traps_misaligned.c:322:24:    expected unsigned char const [noderef] __user *__gu_ptr
> arch/riscv/kernel/traps_misaligned.c:322:24:    got unsigned char const [usertype] *addr
> arch/riscv/kernel/traps_misaligned.c:361:21: warning: dereference of noderef expression
> arch/riscv/kernel/traps_misaligned.c:373:21: warning: dereference of noderef expression
> arch/riscv/kernel/traps_misaligned.c:381:21: warning: dereference of noderef expression
> arch/riscv/kernel/traps_misaligned.c:332:24: warning: incorrect type in initializer (different address spaces)
> arch/riscv/kernel/traps_misaligned.c:332:24:    expected unsigned char [noderef] __user *__gu_ptr
> arch/riscv/kernel/traps_misaligned.c:332:24:    got unsigned char [usertype] *addr
> 
> Fixes: 7c83232161f60 ("riscv: add support for misaligned trap handling in S-mode")
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/riscv/kernel/traps_misaligned.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index 5eba37147caa..446e3d4eeea9 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -319,7 +319,7 @@ static inline int get_insn(struct pt_regs *regs, ulong mepc, ulong *r_insn)
>  static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
>  {
>  	if (user_mode(regs)) {
> -		return __get_user(*r_val, addr);
> +		return __get_user(*r_val, (u8 __user *)addr);
>  	} else {
>  		*r_val = *addr;
>  		return 0;
> @@ -329,7 +329,7 @@ static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
>  static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
>  {
>  	if (user_mode(regs)) {
> -		return __put_user(val, addr);
> +		return __put_user(val, (u8 __user *)addr);
>  	} else {
>  		*addr = val;
>  		return 0;
> @@ -343,7 +343,7 @@ static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
>  	if (user_mode(regs)) {				\
>  		__ret = __get_user(insn, insn_addr);	\
>  	} else {					\
> -		insn = *insn_addr;			\
> +		insn = *(__force u16 *)insn_addr;	\

__read_insn() is called with either a u32 or a u16 pointer which is why
this macros did not used a specific type. Doing so would result in
loading half of what is needed. My patch addresses that.

Thanks

>  		__ret = 0;				\
>  	}						\
>  							\
