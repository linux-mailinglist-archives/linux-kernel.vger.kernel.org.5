Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968B97AA5DF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 02:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjIVAC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 20:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjIVACZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 20:02:25 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1ECF9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 17:02:18 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690f9c787baso1356941b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 17:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695340938; x=1695945738; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIlWllockWVHn+USccr9bcIlaTuabHf1MxHz684jmAo=;
        b=hdvSg8hmq3Sesldu2kDZ0la0kgUjNWL1SZ1l3H0w1inJyDBp3oVpOXbv7NVLEBU1ZO
         7PZa3FKrP3mhzML5XtfIfOAjBpqyt5FGsSAzt0fD5f3PT6wiCypPO07MTXmlgAjgH30t
         2JrXC2GsDB6+qGemjtJHrQCoEHYZZ2NpS6hM/2USvlh3m0jeMhCcvj12k8aGXBqzhdQi
         RszxGxa0pto1iGp5SMaCm9qOKlKavHneOKJcMACICzJoSrfrW2m7BMzWKOT3RUM6mK3o
         ouejkNqrnRFjiGVfFaIFtkEfTyR0caEzTQlNKSE8Dkc943VeIHVq3H4ht1NK3grCL6/G
         1AZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695340938; x=1695945738;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lIlWllockWVHn+USccr9bcIlaTuabHf1MxHz684jmAo=;
        b=UdyxHmNEysuwTtVwo594R8MNInCRsdWn6xPw83wJ2lIq5rxsF68E5seMh/gEqoxdDT
         K/fSQWBQrJqke5mrBr0n4V46au2RLwUnAkmX2VKcLTF7Pud9DpnKF+qw8anJsBipJqWV
         0cvFAwSHFVe0/+dy7NB1JQr/M07PDd+BCnSzFpeyD9lxr1mthdPBsDnsiBoD9G91XYT9
         GpHfZXj0plVsnXOXvxO5u6+UepX1khMVCvnN1YYcdrswQ3EOBq+uZpt2FbMWlICbg1/k
         xjQRTK6GEbd8XkHC/uZFlGliqd+df0n3pbetThJhWVniG/+UxqoKRi8mb1q9RYEyACLr
         W38Q==
X-Gm-Message-State: AOJu0YwKatO2D+dpmYlcDwHBP5EbtuVnZMKyEmaZwvIq12xFa/w0yK/Y
        ui90fE834opZutOXS7XgdZM=
X-Google-Smtp-Source: AGHT+IFYHBSesDnJjmWGQ1ZQ0T9N+LxNIP5SZuAef88AoxvyO2avFf//tfqoENhODbAU8Q+z2mKUZQ==
X-Received: by 2002:a05:6a20:324c:b0:10c:7c72:bdf9 with SMTP id hm12-20020a056a20324c00b0010c7c72bdf9mr5869719pzc.29.1695340938184;
        Thu, 21 Sep 2023 17:02:18 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id z13-20020a170903018d00b001c0a414695dsm2136863plg.62.2023.09.21.17.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 17:02:17 -0700 (PDT)
Message-ID: <49a92f24-bd70-483c-aaaa-49d00c339b12@gmail.com>
Date:   Fri, 22 Sep 2023 07:02:09 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Greentime Hu <greentime.hu@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Vineet Gupta <vineetg@rivosinc.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Andy Chiu <andy.chiu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        matoro <matoro_bugzilla_kernel@matoro.tk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RISC-V <linux-riscv@lists.infradead.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: [bisected][regression] rustc userspace crashes on riscv in
 kernel 6.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:


> Since this commit:
> 
> commit 8ee0b41898fa26f66e32237f179b6989c65600d6
> Author: Greentime Hu <greentime.hu@sifive.com>
> Date:   Mon Jun 5 11:07:11 2023 +0000
> 
>     riscv: signal: Add sigcontext save/restore for vector
> 
> running rustc on riscv produces output like this:
> 
> $ rustc test.rs
> /usr/lib/rust/lib/librustc_driver-f0248bec779deb29.so(+0xe8ebdc)[0x3f8dc8ebdc]
> linux-vdso.so.1(__vdso_rt_sigreturn+0x0)[0x3f8fb91800]
> /lib64/libc.so.6(syscall+0x16)[0x3f8cbfacbe]
> /usr/lib/rust/lib/libstd-985e4b663b8154c3.so(_ZN3std3sys4unix5locks13futex_condvar7Condvar4wait17h4e3b669d2690824dE+0x64)[0x3f8cd45f68]
> /usr/lib/rust/lib/librustc_driver-f0248bec779deb29.so(+0x715ab6)[0x3f8d515ab6]
> /usr/lib/rust/lib/librustc_driver-f0248bec779deb29.so(+0x7159ce)[0x3f8d5159ce]
> /usr/lib/rust/lib/librustc_driver-f0248bec779deb29.so(+0x6b64f6)[0x3f8d4b64f6]
> /usr/lib/rust/lib/librustc_driver-f0248bec779deb29.so(+0x715534)[0x3f8d515534]
> /usr/lib/rust/lib/libstd-985e4b663b8154c3.so(rust_metadata_std_9e9c65f710e3ce43+0xaba32)[0x3f8cd44a32]
> /lib64/libc.so.6(+0x6a8e4)[0x3f8cbab8e4]
> /lib64/libc.so.6(+0xbb49c)[0x3f8cbfc49c]
> 
> even for a simple hello world program.  The output being present does not necessarily mean that the compilation failed, in fact often it will still return 0 and produce a working binary despite the output, but often it does not, frequently enough that it's impossible to build large rust packages.  See the attached log for an example of a real build which fails partway through (despite the fact that all compilation lines emit the traceback).

See Bugzilla for the full thread and attached rust build log.

The reporter (Cc'ed) confirms that this regression occurs on all rust toolchain
distributions (both from the distro and from rustup (maybe?)).

Anyway, I'm adding it to regzbot:

#regzbot introduced: 8ee0b41898fa26 https://bugzilla.kernel.org/show_bug.cgi?id=217923

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217923

-- 
An old man doll... just what I always wanted! - Clara
