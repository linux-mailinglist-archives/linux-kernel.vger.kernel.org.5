Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9909876423E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 00:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjGZWnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 18:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjGZWnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 18:43:20 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28084270F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 15:43:19 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bbd2761f1bso2468965ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 15:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690411398; x=1691016198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MaG/2UBeePq8inaENT+NwKjpjU5MiahEk7iN9th9S0Y=;
        b=ko8WGR+/taNUp8J6OqypMcS4PobhQCefoY9ZnAMyqN+swRHLtYzA3J3I6EFZHH5JLf
         2ScAKum79L0DXHoNKzy90xTh8rpFYEVm3NZAzExvQsBq6s4uVgOCVHJVgTmMPpxSLI4p
         6/R7YD7r11qvwTQRy55tAwQB/oLhjaO8JkmQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690411398; x=1691016198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MaG/2UBeePq8inaENT+NwKjpjU5MiahEk7iN9th9S0Y=;
        b=mIfB9KnDc9vJQ6q+UcUfmkEe5YwsGHpqScGsfFm7Pm4NU8BN1SM6wBmp2AUI5hF7xN
         /u/KZHg+aicYFGuZpHIqcHT/rj0VdqS0BSinTeFqmU3/02TEaJ8v1Zr3y/R/nUtlvhHx
         WG0/d332Jrel/EkDTGN/P8+JnrqALEjUFRUCpvjbWsM2TPYRAWDrJJ4f1PLt2Z0160Dw
         Iycorq1MhO3ArTZbgOyYrC5r0Fv8I8FqFJ5988Bpp+xzUzvTHFv3K0HbNTvPFKQgHsuM
         vU93JQTcoTz8wA00eXB2sN9ewcj0TM1zzmmvTeDktFMuJjSgCSVCA/0wKrVn/YHuxhzF
         sbNA==
X-Gm-Message-State: ABy/qLbwwRy8kFnCz9I1cRHmsmaKtaz/e2jIxNpsSIfFqOTq8lqgaFVl
        Li+1qUztVFzveBLycAJJBuiR1Q==
X-Google-Smtp-Source: APBJJlGmY/8Zc8HCO/n+aNXSXQHmPYUwpxTdy/8NUuT8Ni2Oa94ClFZfeWl7lqC5TYAI00z5wRGgcQ==
X-Received: by 2002:a17:903:442:b0:1bb:98de:251e with SMTP id iw2-20020a170903044200b001bb98de251emr3120883plb.56.1690411398639;
        Wed, 26 Jul 2023 15:43:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902d2cf00b001b54a88e6adsm39153plc.309.2023.07.26.15.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 15:43:18 -0700 (PDT)
Date:   Wed, 26 Jul 2023 15:43:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Petr Mladek <pmladek@suse.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH] [v3] kallsyms: rework symbol lookup return codes
Message-ID: <202307261536.797610DC@keescook>
References: <20230726141333.3992790-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726141333.3992790-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 04:12:23PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Building with W=1 in some configurations produces a false positive
> warning for kallsyms:
> 
> kernel/kallsyms.c: In function '__sprint_symbol.isra':
> kernel/kallsyms.c:503:17: error: 'strcpy' source argument is the same as destination [-Werror=restrict]
>   503 |                 strcpy(buffer, name);
>       |                 ^~~~~~~~~~~~~~~~~~~~
> 
> This originally showed up while building with -O3, but later started
> happening in other configurations as well, depending on inlining
> decisions. The underlying issue is that the local 'name' variable is
> always initialized to the be the same as 'buffer' in the called functions
> that fill the buffer, which gcc notices while inlining, though it could
> see that the address check always skips the copy.
> 
> The calling conventions here are rather unusual, as all of the internal
> lookup functions (bpf_address_lookup, ftrace_mod_address_lookup,
> ftrace_func_address_lookup, module_address_lookup and
> kallsyms_lookup_buildid) already use the provided buffer and either return
> the address of that buffer to indicate success, or NULL for failure,
> but the callers are written to also expect an arbitrary other buffer
> to be returned.
> 
> Rework the calling conventions to return the length of the filled buffer
> instead of its address, which is simpler and easier to follow as well
> as avoiding the warning. Leave only the kallsyms_lookup() calling conventions
> unchanged, since that is called from 16 different functions and
> adapting this would be a much bigger change.
> 
> Link: https://lore.kernel.org/all/20200107214042.855757-1-arnd@arndb.de/
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v3: use strscpy() instead of strlcpy()

Thank you! :) (Though see my notes below...)

> [...]
> @@ -344,13 +345,12 @@ const char *module_address_lookup(unsigned long addr,
>  #endif
>  		}
>  
> -		ret = find_kallsyms_symbol(mod, addr, size, offset);
> -	}
> -	/* Make a copy in here where it's safe */
> -	if (ret) {
> -		strncpy(namebuf, ret, KSYM_NAME_LEN - 1);

This -1 was to keep the buffer NUL-terminated.

> -		ret = namebuf;
> +		sym = find_kallsyms_symbol(mod, addr, size, offset);
> +
> +		if (sym)
> +			ret = strscpy(namebuf, sym, KSYM_NAME_LEN - 1);

This strscpy should use KSYM_NAME_LEN without the "- 1".

>  	}
> +
>  	preempt_enable();
>  

-Kees

-- 
Kees Cook
