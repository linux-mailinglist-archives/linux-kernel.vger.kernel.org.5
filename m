Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074057D2785
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 02:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjJWAeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 20:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJWAeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 20:34:08 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971AADC;
        Sun, 22 Oct 2023 17:34:06 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c434c33ec0so15272105ad.3;
        Sun, 22 Oct 2023 17:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698021246; x=1698626046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yo6K0bHj9eDw2uCekwr3qyBicYCjBn6A7SQ6ir3tv1I=;
        b=O1Whmw7m1zgny9j/yIbtZhgZVobvviwXEhNrDgFD2bzH/GvchcPBAR9ziFLUlwOQGe
         DQGGlZqgxJVzS1KnN4zZOiEuFNPmDt4PYw7E6TREi8p1WG5Rb7b2Z4+sR9WlRZcz3fZQ
         vSVsmABVpkz052hsjyB6e3A0lHwrowcHWw71u1/DwncJ6Rrhg+PpGJIJ2lSubXiVdCZZ
         crZerQvr8REz1sWKKqwnpUNLtYZp7WE9IfqjYNZ8mzznB6w+qMPB1tcZp9WfVrVYQ730
         xy/y2b7PcddXCM1MaB5SgX5EAO0qLJ51dvyK8Dafs2lIUX6uU1gph2xaLzOlYRyy3PYh
         ATcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698021246; x=1698626046;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yo6K0bHj9eDw2uCekwr3qyBicYCjBn6A7SQ6ir3tv1I=;
        b=vlJqrAsinaiLPVASX8jtiHNb+P8jEJhflBKf6jGkd5UniCRpyB0HjjVj473iM6Mg+f
         OC74y0kHBH5o+I9/SW2eEP1Mo3XBwTUZp8KkmhfGPdwEprG5+wt18PkMxMaUwIUECeWI
         EM0UYUM2d2vxBA5fnjPYTs0cA0OQy+teO1WCcGOBhjPRO/YByALPtyjdcgEF3juihntJ
         uKP7ekZeqSz4lLjEbY3CmX4wOc4PvxGEBvIyp+Qu8OAFSBe4UDyDLZcjJQ4ovVURYEI5
         4CBNvO7GR+I5rsSWmERWs7ePTJrtMx2VTr1PCrpHgs7SQ607v1iZ3EPYvaVkV8a/nUhn
         c2Kg==
X-Gm-Message-State: AOJu0Yz2VXqJiqpFE/ARzQOcG2apj46/mFZzCikWWCgLotOetb3pTXtz
        CxNMiwWZUKfC9bDpx2lO3pQ=
X-Google-Smtp-Source: AGHT+IEAAaFlEybSobEedAEEMCSAunEL1L1R+SiHOzUgbtvIQrRdrP7M8FCJ6EQ7WlvROxpGsvhygg==
X-Received: by 2002:a17:902:d48f:b0:1c9:dff6:58e8 with SMTP id c15-20020a170902d48f00b001c9dff658e8mr5395657plg.54.1698021245856;
        Sun, 22 Oct 2023 17:34:05 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902ee4200b001c73d829fb7sm4927232plo.15.2023.10.22.17.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 17:34:05 -0700 (PDT)
Message-ID: <4c926cff-a3f2-445e-9ca2-9effad423cb7@gmail.com>
Date:   Sun, 22 Oct 2023 21:33:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf-next PATCH v2 2/4] kbuild: avoid too many execution of
 scripts/pahole-flags.sh
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Nicolas Schier <n.schier@avm.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benno Lossin <benno.lossin@proton.me>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Gary Guo <gary@garyguo.net>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
        rust-for-linux@vger.kernel.org
References: <20231018151950.205265-1-masahiroy@kernel.org>
 <20231018151950.205265-2-masahiroy@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231018151950.205265-2-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/23 12:19, Masahiro Yamada wrote:
> scripts/pahole-flags.sh is executed so many times.
> 
> You can check how many times it is invoked during the build, as follows:
> 
>    $ cat <<EOF >> scripts/pahole-flags.sh
>    > echo "scripts/pahole-flags.sh was executed" >&2
>    > EOF
> 
>    $ make -s
>    scripts/pahole-flags.sh was executed
>    scripts/pahole-flags.sh was executed
>    scripts/pahole-flags.sh was executed
>    scripts/pahole-flags.sh was executed
>    scripts/pahole-flags.sh was executed
>      [ lots of repeated lines suppressed... ]
> 
> This scripts is executed more than 20 times during the kernel build
> because PAHOLE_FLAGS is a recursively expanded variable and exported
> to sub-processes.
> 
> With the GNU Make >= 4.4, it is executed more than 60 times because
> exported variables are also passed to other $(shell ) invocations.
> Without careful coding, it is known to cause an exponential fork
> explosion. [1]
> 
> The use of $(shell ) in an exported recursive variable is likely wrong
> because $(shell ) is always evaluated due to the 'export' keyword, and
> the evaluation can occur multiple times by the nature of recursive
> variables.
> 
> Convert the shell script to a Makefile, which is included only when
> CONFIG_DEBUG_INFO_BTF=y.
> 
> [1]: https://savannah.gnu.org/bugs/index.php?64746
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> Reviewed-by: Nicolas Schier <n.schier@avm.de>
> Tested-by: Miguel Ojeda <ojeda@kernel.org>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> [...]
> @@ -1002,6 +999,7 @@ KBUILD_CPPFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
>   # include additional Makefiles when needed
>   include-y			:= scripts/Makefile.extrawarn
>   include-$(CONFIG_DEBUG_INFO)	+= scripts/Makefile.debug
> +include-$(CONFIG_DEBUG_INFO_BTF)+= scripts/Makefile.btf

Would've used a tab, for legibility sake.

>   include-$(CONFIG_KASAN)		+= scripts/Makefile.kasan
>   include-$(CONFIG_KCSAN)		+= scripts/Makefile.kcsan
>   include-$(CONFIG_KMSAN)		+= scripts/Makefile.kmsan
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
