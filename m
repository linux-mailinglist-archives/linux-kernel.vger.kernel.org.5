Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EE5790475
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 02:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348555AbjIBAVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 20:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjIBAVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 20:21:08 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC866E5C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 17:21:04 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1c50438636fso1633072fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 17:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693614064; x=1694218864; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Psrz6OLugnAHI8N/ongnXW3Llo2Oy5igQZp0EV1W0To=;
        b=KLSc690u+mpg7zidF8e9x2xuJBuNe6gDejZIAydc4N1nOKvezSXBfwPJTPsJpijzRl
         8406u3QR9Fue+9GdX+l30LXG2RQPw33QiAO37FQB9c1Iv5ydKz9V0JV6EXkTHwWz0szZ
         SeH2aYIF+sXZshe+K/vMYm8qqUz2yOYbYtAD9XKlCP+V8FbxqNc6lBkGTYuQt/sTQjp8
         F38XstaB/yThQaMvkPJa6DQd2tknPrwWjGbfzrGC9xXDCpctkmoTytECfxczdA5LNXfa
         Nu394pp9b0Oxx+ZNzMP0ZyNrjGkOnghlqAgs7XpJhDfOWdx4Snf7LuU96Ifkh3atLwgl
         r0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693614064; x=1694218864;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Psrz6OLugnAHI8N/ongnXW3Llo2Oy5igQZp0EV1W0To=;
        b=ZUrsZKobuLZ+NI5Xu0MVlwmYUaaePrTmlVX2qoUdwOF9Z6EyCyd5ZNTACM1nsTNVd8
         x/tYMU3QlPuj03z3ljUAadj3dUsY0h5cIgiAhw3wii3X6SLgt3o/5vPBqTmRyGczaVr/
         X/WmWPxKjbnS5xpMz6zGLmFywnDALHKuBxFHm7/RG8TxlBNqQMlGk0XLhfz0Ak6237gZ
         UlQO5wa5R6VO/dwrO1DoF0DdtGXSv/1YinOVZJNDOkvmSKhG7hLPMtXCC8a4YLDPnI9N
         pTn4PhcwP0ptZTHWK7+P4FiOAEsmQTFuJa9jxO1Z2K+mbVdRgzvbrcS1FoDSe0kUaFqG
         rnbg==
X-Gm-Message-State: AOJu0Yy0RzNDcnVJiWv7d/1tUuhgtr/loVu9fvxoacHk6asae44Ydiki
        ryfeEIAGcgKrYCm3D8gwnuA=
X-Google-Smtp-Source: AGHT+IFW9L2FLM8HcMkKhApzzFEzKsT9XZi/6S0+2uIs6H5Z0No5EZjuDhBc7GDMPQLEFnuqZxe4CA==
X-Received: by 2002:a05:6870:561f:b0:1bf:2ad9:8dae with SMTP id m31-20020a056870561f00b001bf2ad98daemr4717892oao.45.1693614063761;
        Fri, 01 Sep 2023 17:21:03 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id s7-20020a17090a5d0700b0026b12768e46sm3488542pji.42.2023.09.01.17.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 17:21:03 -0700 (PDT)
Message-ID: <0e6de51b-da1d-43f0-ffae-fb521febbe07@gmail.com>
Date:   Sat, 2 Sep 2023 07:20:55 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Janpieter Sollie <janpieter.sollie@edpnet.be>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Uhhuh. NMI received for unknown reason 3d/2d/ on CPU xx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> seems to be a regression since 6.5 release:
> the infamous error message from the kernel on this 32c/64t threadripper:
>> [ 2046.269103] perf: interrupt took too long (3141 > 3138), lowering
>> kernel.perf_event_max_sample_rate to 63600
>> [ 2405.049567] Uhhuh. NMI received for unknown reason 2d on CPU 48.
>> [ 2405.049571] Dazed and confused, but trying to continue
>> [ 2406.902609] Uhhuh. NMI received for unknown reason 2d on CPU 33.
>> [ 2406.902612] Dazed and confused, but trying to continue
>> [ 2423.978918] Uhhuh. NMI received for unknown reason 2d on CPU 33.
>> [ 2423.978921] Dazed and confused, but trying to continue
>> [ 2429.995160] Uhhuh. NMI received for unknown reason 3d on CPU 48.
>> [ 2429.995163] Dazed and confused, but trying to continue
>> [ 2431.233575] Uhhuh. NMI received for unknown reason 3d on CPU 36.
>> [ 2431.233578] Dazed and confused, but trying to continue
>> [ 2442.382252] Uhhuh. NMI received for unknown reason 3d on CPU 48.
>> [ 2442.382255] Dazed and confused, but trying to continue
>> [ 2442.725076] Uhhuh. NMI received for unknown reason 2d on CPU 49.
>> [ 2442.725078] Dazed and confused, but trying to continue
>> [ 2442.732025] Uhhuh. NMI received for unknown reason 2d on CPU 48.
>> [ 2442.732027] Dazed and confused, but trying to continue
>> [ 2443.666671] Uhhuh. NMI received for unknown reason 2d on CPU 48.
>> [ 2443.666673] Dazed and confused, but trying to continue
>> [ 2443.756776] Uhhuh. NMI received for unknown reason 3d on CPU 39.
>> [ 2443.756779] Dazed and confused, but trying to continue
>> [ 2443.907309] Uhhuh. NMI received for unknown reason 3d on CPU 48.
>> [ 2443.907311] Dazed and confused, but trying to continue
>> [ 2444.004281] Uhhuh. NMI received for unknown reason 3d on CPU 49.
>> [ 2444.004283] Dazed and confused, but trying to continue
>> [ 2444.207944] Uhhuh. NMI received for unknown reason 2d on CPU 49.
>> [ 2444.207945] Dazed and confused, but trying to continue
>> [ 2444.517408] Uhhuh. NMI received for unknown reason 3d on CPU 49.
>> [ 2444.517410] Dazed and confused, but trying to continue
>> [ 2444.946941] Uhhuh. NMI received for unknown reason 2d on CPU 49.
>> [ 2444.946943] Dazed and confused, but trying to continue
>> [ 2445.573807] Uhhuh. NMI received for unknown reason 2d on CPU 49.
>> [ 2445.573809] Dazed and confused, but trying to continue
>> [ 2445.776108] Uhhuh. NMI received for unknown reason 2d on CPU 49.
>> [ 2445.776110] Dazed and confused, but trying to continue
>> [ 2445.969029] Uhhuh. NMI received for unknown reason 2d on CPU 49.
>> [ 2445.969031] Dazed and confused, but trying to continue
>> [ 2446.977458] Uhhuh. NMI received for unknown reason 3d on CPU 49.
>> [ 2446.977460] Dazed and confused, but trying to continue
>> [ 2447.044329] Uhhuh. NMI received for unknown reason 2d on CPU 46.
>> [ 2447.044331] Dazed and confused, but trying to continue
>> [ 2447.469269] Uhhuh. NMI received for unknown reason 2d on CPU 49.
>> [ 2447.469271] Dazed and confused, but trying to continue
>> [ 2447.866530] Uhhuh. NMI received for unknown reason 3d on CPU 48.
>> [ 2447.866531] Dazed and confused, but trying to continue
>> [ 2448.456615] Uhhuh. NMI received for unknown reason 3d on CPU 48.
>> [ 2448.456617] Dazed and confused, but trying to continue
>> [ 2448.509614] Uhhuh. NMI received for unknown reason 2d on CPU 49.
>> [ 2448.509616] Dazed and confused, but trying to continue
>> [ 2448.758005] Uhhuh. NMI received for unknown reason 3d on CPU 49.
>> [ 2448.758007] Dazed and confused, but trying to continue
>> [ 2449.093565] Uhhuh. NMI received for unknown reason 3d on CPU 48.
>> [ 2449.093567] Dazed and confused, but trying to continue
>> [ 2449.227344] Uhhuh. NMI received for unknown reason 3d on CPU 48.
>> [ 2449.227346] Dazed and confused, but trying to continue
>> [ 2449.770534] Uhhuh. NMI received for unknown reason 2d on CPU 49.
>> [ 2449.770535] Dazed and confused, but trying to continue
>> [ 2449.955594] Uhhuh. NMI received for unknown reason 3d on CPU 48.
>> [ 2449.955596] Dazed and confused, but trying to continue
>> [ 2450.077872] Uhhuh. NMI received for unknown reason 2d on CPU 48.
>> [ 2450.077874] Dazed and confused, but trying to continue
>> [ 2450.190844] Uhhuh. NMI received for unknown reason 3d on CPU 49.
>> [ 2450.190846] Dazed and confused, but trying to continue
>> [ 2450.561450] Uhhuh. NMI received for unknown reason 2d on CPU 49.
>> [ 2450.561452] Dazed and confused, but trying to continue
>> [ 2450.604498] Uhhuh. NMI received for unknown reason 3d on CPU 48.
>> [ 2450.604500] Dazed and confused, but trying to continue
>> [ 2450.814451] Uhhuh. NMI received for unknown reason 3d on CPU 48.
>> [ 2450.814453] Dazed and confused, but trying to continue
>> [ 2450.923171] Uhhuh. NMI received for unknown reason 2d on CPU 49.
>> [ 2450.923173] Dazed and confused, but trying to continue
>> [ 2451.084612] Uhhuh. NMI received for unknown reason 3d on CPU 49.
>> [ 2451.084614] Dazed and confused, but trying to continue
>> [ 2451.793342] Uhhuh. NMI received for unknown reason 3d on CPU 49.
>> [ 2451.793343] Dazed and confused, but trying to continue
>> [ 2451.793662] Uhhuh. NMI received for unknown reason 2d on CPU 48.
>> [ 2451.793664] Dazed and confused, but trying to continue
>> [ 2451.926819] Uhhuh. NMI received for unknown reason 3d on CPU 48.
>> [ 2451.926821] Dazed and confused, but trying to continue
>> [ 2452.502583] Uhhuh. NMI received for unknown reason 3d on CPU 49.
>> [ 2452.502585] Dazed and confused, but trying to continue
>> [ 2452.675633] Uhhuh. NMI received for unknown reason 2d on CPU 61.
>> [ 2452.675636] Dazed and confused, but trying to continue
>> [ 2452.974655] Uhhuh. NMI received for unknown reason 2d on CPU 48.
>> [ 2452.974657] Dazed and confused, but trying to continue
>> [ 7065.904855] elogind-daemon[2461]: New session c2 of user janpieter.
> 
> according to dmesg, this happens without any special reason (I didn't even notice)
> some googling points at a ACPI C state problem on AMD CPUs a few years ago
> in 5.14 kernels, I didn't see it.

See Bugzilla for the full thread.

Anyway, I'm adding this regression to be tracked by regzbot:

#regzbot introduced: v6.4..v6.5 https://bugzilla.kernel.org/show_bug.cgi?id=217857

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217857

-- 
An old man doll... just what I always wanted! - Clara
