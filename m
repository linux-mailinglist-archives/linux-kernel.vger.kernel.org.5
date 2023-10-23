Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAC87D2789
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 02:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjJWApv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 20:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJWAps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 20:45:48 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73131E7;
        Sun, 22 Oct 2023 17:45:46 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b44befac59so2749685b3a.0;
        Sun, 22 Oct 2023 17:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698021946; x=1698626746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GNPV+1khYPNoiNENeKlZWWTYFEnA3SXV9H6z2dWOrpM=;
        b=kGwKMs3O/rMJtlcK+naL3fv7yiDiU5S4VOVzL6WHdcNNw3eUhSAHpKiPATv7ZlSfFA
         q1Xs7CFFDcXXIEuu8afPF+Z+Rzr8XdxSIqJHFDJ+7pFd7rjSSIGGVrJ6JWodaAxrJr+U
         64w+VQRqDvV9IGYE3iJWX/bfQxGcrduvdsStv5ifECe9O0U+oua+5LT087kjtaU+n3Vf
         qGN6ExizYQFdswyg/BTwSa2sxbo88njsKQiTXCXuERk/AJPOwwvrCfNxKEyTwBY2z04Z
         Uur4Tg1PbsD3Go1L7cPVIx77LaK+lDXgYYkln3r2eJweZ9pw1WPf49eCad8ija+BjIC5
         l97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698021946; x=1698626746;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GNPV+1khYPNoiNENeKlZWWTYFEnA3SXV9H6z2dWOrpM=;
        b=Ee19VpBVaS0VXYB7Jq6YtMKwpDabwQG5FV/FkAWYVWFqd4+160iEHsySXdw3H2VfTZ
         RFtYiPIeDKDXitQ76+vtD/nfYy1QfN8+0h8BagtzNRC5TluMGdtNu8rf60E3r8LjQK27
         10t7RwJ1Dci0h8Ux5avvqkjyFeAORmNBF2/4oQxwlcAoHJZzGaAtWZ+CNjpfGTAXTm1w
         VnJIgrDwI26CozvUltmLeCemUk0X6by1iJO6QXGlCTmxldeffu5R/tJUTSBBmeyJi7ZQ
         /XvOwDjfPcxah2ghKDIW9dIGYkvtNYJeDNnF+2RVVbUSCZAOtrYmRD49VpZSCFp5nYDe
         JqOw==
X-Gm-Message-State: AOJu0YyzAw42nkOUibFbNWgTL3lpil/Cz/pskWQ8WVsVMFFcs0N+A6t5
        lOp+s6ouZySk//38JIT7Wdk=
X-Google-Smtp-Source: AGHT+IG8y0/YzjOTgyS/PVsCvncSF0Ip6rs/IDzBlHqt63zc+/GbcNXSo38GekWUOS0KxlNw5D0ShA==
X-Received: by 2002:a05:6a20:1592:b0:17a:e2b9:77e0 with SMTP id h18-20020a056a20159200b0017ae2b977e0mr9905847pzj.7.1698021945796;
        Sun, 22 Oct 2023 17:45:45 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id k11-20020a056a00134b00b00692b2a63cccsm4963258pfu.210.2023.10.22.17.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 17:45:45 -0700 (PDT)
Message-ID: <6c7a92d1-fe8e-4d05-854d-127b54907a46@gmail.com>
Date:   Sun, 22 Oct 2023 21:45:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] scripts: Build per module Rust crates
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
References: <20231006155739.246381-1-yakoyoku@gmail.com>
 <20231006155739.246381-2-yakoyoku@gmail.com>
 <CAK7LNAQhPRkSpBQcn44dPMmnBVR=aTxMpG3vS4-=FkgQ5T2PVQ@mail.gmail.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <CAK7LNAQhPRkSpBQcn44dPMmnBVR=aTxMpG3vS4-=FkgQ5T2PVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/23 13:21, Masahiro Yamada wrote:
> On Sat, Oct 7, 2023 at 12:57 AM Martin Rodriguez Reboredo
> <yakoyoku@gmail.com> wrote:
>>
>> Enables compiling Rust crates as dependencies of kernel modules.
>>
>> When a composite object depends on an `.rlib` file, which by the way is
>> a current ar archive, Kbuild will compile it from its base Rust source
>> and link it.
>>
>> This makes possible to have Rust bindings for a subsystem that is
>> compiled as a module.
>>
>> Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> 
> 
> I could not understand how this will work because
> there is no explanation how to use *.rlib in the later
> build steps.
> 
> If I understand correctly, does this intend to link *.rlib
> as a part of modules?

Yes, the purpose of this RFC is to link the *.rlib, its members
specifically, as part of modules to avoid the scenario of having
Rust bindings linked statically and their C counterparts dynamically.

I'll write a v2 that'll clarify its usage. I've made more progress
locally and had run tests with success.
