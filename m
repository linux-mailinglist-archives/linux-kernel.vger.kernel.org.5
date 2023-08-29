Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F7A78C2EC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjH2LB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjH2LA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:00:58 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6101B7;
        Tue, 29 Aug 2023 04:00:49 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso64451351fa.3;
        Tue, 29 Aug 2023 04:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693306847; x=1693911647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fhXbORKrxhN4PvPUoLQtR9G41gWTxKeHkpCEPYc2HPc=;
        b=kO4Goe5r4EUEQIzTFH2R6snx0BfocRXemdQl152BVqkDcm8tU5ea1Uj9YfM8u8++Br
         2I715kZNftnwOFGghLR24doBebpaV2gmQMpq/2iIDUU7dpwiXnqDAQZ1IBgJj/2KtIhX
         bVTQDE2oZ95Pk9nJP5jZ3UjEeTFZun3cOa6UIsWsymNV267UJ0eR/p+jucq1LIIGNaY4
         H2IUXyXxi4MaZKNY/FuZD+RHwBnfNuloR0oH+/MV2Tj1uqRo/sM9zpHpesu5wnVpYD9h
         gNvgCkBl3KmPWyuRtIfmhxBTAuY3XLX3IcJbGKawvXI2gJx9kajAvaucCkPiyXOS5pwV
         Bg8w==
X-Gm-Message-State: AOJu0YxqmWgXjb46pFBodXI0E62FTQR9ybmyu7bugtq5EjI8DaMBonRF
        +1C2lI20EVT9bU16rp0tEyo=
X-Google-Smtp-Source: AGHT+IEGC3JDdsOQXcFEzYg7LIB2Ho4Uc2XTQWtco8s8gtwYQmMRopH84qYbhh66O8/fr47GwRu0Hg==
X-Received: by 2002:a05:651c:21b:b0:2b6:eefc:3e4f with SMTP id y27-20020a05651c021b00b002b6eefc3e4fmr22505250ljn.21.1693306847099;
        Tue, 29 Aug 2023 04:00:47 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id gl25-20020a170906e0d900b0099bd1ce18fesm5885829ejb.10.2023.08.29.04.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 04:00:45 -0700 (PDT)
Message-ID: <0d86668f-4f48-cd21-b891-443e99c5c86a@kernel.org>
Date:   Tue, 29 Aug 2023 13:00:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] kbuild: dummy-tools: support make MPROFILE_KERNEL checks
 work on BE
Content-Language: en-US
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Kubecek <mkubecek@suse.cz>
References: <20230829105106.1277-1-jirislaby@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230829105106.1277-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I deleted too few: the subject should read:
kbuild: dummy-tools: make MPROFILE_KERNEL checks work on BE

I will submit v2 if there are no other objections.

On 29. 08. 23, 12:51, Jiri Slaby (SUSE) wrote:
> From: Jiri Slaby <jslaby@suse.cz>
> 
> Commit 2eab791f940b ("kbuild: dummy-tools: support MPROFILE_KERNEL
> checks for ppc") added support for ppc64le's checks for
> -mprofile-kernel.
> 
> Now, commit aec0ba7472a7 ("powerpc/64: Use -mprofile-kernel for big
> endian ELFv2 kernels") added support for -mprofile-kernel even on
> big-endian ppc.
> 
> So lift the check in gcc-check-mprofile-kernel.sh to support big-endian too.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Michal Kubecek <mkubecek@suse.cz>
> ---
>   scripts/dummy-tools/gcc | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/scripts/dummy-tools/gcc b/scripts/dummy-tools/gcc
> index 1db1889f6d81..07f6dc4c5cf6 100755
> --- a/scripts/dummy-tools/gcc
> +++ b/scripts/dummy-tools/gcc
> @@ -85,8 +85,7 @@ if arg_contain -S "$@"; then
>   	fi
>   
>   	# For arch/powerpc/tools/gcc-check-mprofile-kernel.sh
> -	if arg_contain -m64 "$@" && arg_contain -mlittle-endian "$@" &&
> -		arg_contain -mprofile-kernel "$@"; then
> +	if arg_contain -m64 "$@" && arg_contain -mprofile-kernel "$@"; then
>   		if ! test -t 0 && ! grep -q notrace; then
>   			echo "_mcount"
>   		fi

-- 
js
suse labs

