Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBEC7B78C4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241533AbjJDHdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjJDHdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:33:02 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF76098;
        Wed,  4 Oct 2023 00:32:58 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9ad8bf9bfabso333071666b.3;
        Wed, 04 Oct 2023 00:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696404777; x=1697009577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x5Uy06MF6r5s4tofVRVpqtiiuIjO2bB4ESmT7SAj9MY=;
        b=Ggp7U9n+Sq25U6emSuwLzB+DawQe3A2NU0GSU1JvmYCzBY4XNYoECSsqVtdc3RFelO
         22trYSK1+gD1IoxA5fXBmcKD/sK3C1HYv1sGROqjrY2ZtFMCRA03+CSC7Kx5i9EhCpHz
         fbQUcqZfSfgxTGkRpiAM6eomOb9Bg/inuHGZ40wm4h3bVdrGYqc0poQqKRL5j2zbuKsV
         aR99Xqw/Waj6aPmsO6Huc2yBUVGVmWSzdWGaiTefz6JiTRd57yTpEVLIGDmXgnGIzJIa
         ctm5RCvFm22Bp5uu+fiSchv94Bz/qRgGVrH4I0s2ySRd3lV2SgFU4SoBz9iMpV1/CKDO
         8dZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696404777; x=1697009577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5Uy06MF6r5s4tofVRVpqtiiuIjO2bB4ESmT7SAj9MY=;
        b=RGifU07qW5eKnZU3L3gGWM0PZ65JfRAxu5Q8oDUsTKFZZdbALfyHjdu8lzA+AVNYlP
         Dr+Ikbv+y7e50ulUl/b/jOP2ASjnaVSvDkccBvHdi01xurZM+zFv15cu5T7hlovyNPUd
         JJmYoZ8pXLthX5NhO1pMKf6CWLpwzvlxpEWRMilqbybwXir2HiUCTCV+ulBxLjH9W207
         s+6tn9VAR5wpSzn8s3jRyUgtuMpEw4ASm26Td/zR+pcn3j1dBp5dVboNNspHiRsaO3QS
         CRE/aBt6sJUqSofDJhFIMzSVZI/iZdft9RN3237CEvtqMw1td473Fi0IKinQId57W78r
         0iRg==
X-Gm-Message-State: AOJu0YyZ5FSmF9wGFZ6/uD2l3MY54NqJGD4xpJGhy1Y1DtojCPdQa9KK
        XxEvUrBy0XPNqOPoxfdCGJA=
X-Google-Smtp-Source: AGHT+IHDvySrbKlvjT+ET5wXwV0u/nDtUew8J8/RSIpQZZJW2H6Z7InqAcK5PGnRmJ+FVbD8k7Bq4w==
X-Received: by 2002:a17:906:20ce:b0:9ae:3210:22fd with SMTP id c14-20020a17090620ce00b009ae321022fdmr1338641ejc.48.1696404776875;
        Wed, 04 Oct 2023 00:32:56 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id la12-20020a170906ad8c00b009a1dbf55665sm2282805ejb.161.2023.10.04.00.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 00:32:56 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 4 Oct 2023 09:32:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] x86/tdx: replace deprecated strncpy with strtomem_pad
Message-ID: <ZR0VJsgA6g0Wk4dq@gmail.com>
References: <20231003-strncpy-arch-x86-coco-tdx-tdx-c-v2-1-0bd21174a217@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003-strncpy-arch-x86-coco-tdx-tdx-c-v2-1-0bd21174a217@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Justin Stitt <justinstitt@google.com> wrote:

> strncpy works perfectly here in all cases, however, it is deprecated and
> as such we should prefer more robust and less ambiguous string apis.
> 
> Let's use `strtomem_pad` as this matches the functionality of `strncpy`
> and is _not_ deprecated.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v2:
> - update subject (thanks Kees)
> - update commit message (thanks Dave)
> - rebase onto mainline cbf3a2cb156a2c91
> - Link to v1: https://lore.kernel.org/r/20230911-strncpy-arch-x86-coco-tdx-tdx-c-v1-1-4b38155727f3@google.com
> ---
> Note: build-tested
> 
> Note: Ingo Molnar has some concerns about the comment being out of sync
> [1] but I believe the comment still has a place as we can still
> theoretically copy 64 bytes into our destination buffer without a
> NUL-byte. The extra information about the 65th byte being NUL may serve
> helpful to future travelers of this code. What do we think? I can drop
> the comment in a v3 if needed.

>  	/* VMM assumes '\0' in byte 65, if the message took all 64 bytes */
> -	strncpy(message.str, msg, 64);
> +	strtomem_pad(message.str, msg, '\0');

My concern was that with the old code it was obvious that the size
of message.str was 64 bytes - but I judged this based on the
patch context alone, which seemingly lost context due to the change.

In reality it's easy to see it when reading the code, because the
length definition is right before the code:

        union {
                /* Define register order according to the GHCI */
                struct { u64 r14, r15, rbx, rdi, rsi, r8, r9, rdx; };

                char str[64];
                ^^^^^^^^^^^^^
        } message;

        /* VMM assumes '\0' in byte 65, if the message took all 64 bytes */
        strtomem_pad(message.str, msg, '\0');


:-)

So no worries - I've applied your patch to tip:x86/mm as-is.

Thanks,

	Ingo
