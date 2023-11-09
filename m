Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE097E749A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 23:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345358AbjKIW44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 17:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjKIW4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 17:56:54 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D014422D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 14:56:51 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c6b30acacdso17859491fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 14:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1699570610; x=1700175410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1QtA2/x0ZyZN5FnQ0Yz771YH8zXyNfVbXbyQs0J7Qcc=;
        b=u0yFevPjnb9B1oZvKEgt0ojfb988l4sjSb/1C+U6dTGr5MInh/Twzgt2MJIFvGZfNn
         X9/L50KTRV96g1YUwUsZKf6qLRhTDIEYrRFjQGdujF0ZeBoJa3Xk/eGdg0OI6NhEifJr
         SMuV0Gw/ISPFJHTCmctQBqHFmS1JgornSW2D3sdfWjnIZ/66rDhGXv2bVtiMpYHz/Rgk
         4k8Xw0S8IMqTAUI7+iu1DzaVT+PJwUaM+dduIfCrfuQXkrgLTZTLno0yNZ2EsA1I0q8j
         z9XzXPM4s92HtKFiJGGQIlyH1PEQQCn54NxrIsNE5igR73a2x3TDZGZYlk5mGIm71b5l
         zRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699570610; x=1700175410;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QtA2/x0ZyZN5FnQ0Yz771YH8zXyNfVbXbyQs0J7Qcc=;
        b=u1qNVoTuv5NA8FAvlgcggrFCdIdfbSUu/jZrq5hwJ6D9cHcwqs6NVqiGcScdSurLOD
         0xiPsIJYGSjJczzrKoSGDdwnhrJKepVZh0axkB+sFuuWjHpjv8hcteg/HZIXZO1cXSG4
         eoet2mzV037mA0gGgvbaVmquHJR4tb7pIPf7+8UIOKued+oL2J4zgoomJTEfHUpC31UC
         DZYn8J8olDLc/aA2qsPZdfXz/fxD+A4pNMyviNx96piRN63tbBEPHA2oFX5icZeJrglD
         ImFjWfqj597Tc+TfK7rIDZls50AhyEJFJiqKLZ0/B5HcYUCXrR+OaPe5H/SJgwRtU4Ih
         sj7Q==
X-Gm-Message-State: AOJu0YxPihK2gi2GTr0MOFxEKY0CXK1e6quOMg7eobCuWp7YOgsc+Hu8
        cfVHQJ1XxmsdcSyJQvVEGShGtQ==
X-Google-Smtp-Source: AGHT+IH8wamSL8MWF07seVKJLlmtRn705pu0xbWsjODjcj0QVNRgb8a+YFiv/EzLaDXHqlS63cHiAw==
X-Received: by 2002:a2e:a4d2:0:b0:2c6:ed74:4058 with SMTP id p18-20020a2ea4d2000000b002c6ed744058mr4667381ljm.42.1699570609595;
        Thu, 09 Nov 2023 14:56:49 -0800 (PST)
Received: from [192.168.0.28] ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c350700b004090ca6d785sm3432267wmq.2.2023.11.09.14.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 14:56:49 -0800 (PST)
Message-ID: <eb9cb563-d480-4000-8feb-b63b856235c3@smile.fr>
Date:   Thu, 9 Nov 2023 23:56:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] kconfig: avoid an infinite loop in
 oldconfig/syncconfig
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Brandon Maier <brandon.maier@collins.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
References: <20231104222715.3967791-1-yoann.congal@smile.fr>
 <CAK7LNAS6J5Nh8nOUHbaf123yd1Z-1q--FvB1ok8GQcoNorAROw@mail.gmail.com>
 <20231107210004.GA2065849@dev-arch.thelio-3990X>
 <CAK7LNARpJ9huseh-Ro9v8W_tabMof9cuUZO43gi-hfEnXG4FYA@mail.gmail.com>
Content-Language: en-US
From:   Yoann Congal <yoann.congal@smile.fr>
Organization: Smile ECS
In-Reply-To: <CAK7LNARpJ9huseh-Ro9v8W_tabMof9cuUZO43gi-hfEnXG4FYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 09/11/2023 à 05:26, Masahiro Yamada a écrit :
> On Tue, Nov 7, 2023 at 11:00 PM Nathan Chancellor <nathan@kernel.org> wrote:
>> For what it's worth, this change breaks our continuous integration [1>> because tuxmake explicitly uses /dev/null as stdin to make for
>> non-interactive commands (I think it does this as basically the
>> equivalent of "yes '' | make" in Python), so the error will always
>> occur.
>>
>> Before:
>>
>> [...]
>>
>> After:
>>
>> $ curl -LSso .config https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/raw/main/config

Calling 'make olddefconfig' at this point should avoid opening the prompt on /dev/null in the next make.

I got tuxmake to that with a hack:
$ .../tuxmake/run --kconfig /dev/null --kconfig-add https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/raw/main/config
# --kconfig /dev/null      => Start from a blank config
# --kconfig-add https//... => ... add to it a partial config
=> tuxmake will "merge" the empty config and the URL one and then run 'make olddefconfig' and finally 'make < /dev/null' which does run

>> $ python3 -c "import subprocess; subprocess.run(['make', '-j128'], stdin=subprocess.DEVNULL)"
>>   SYNC    include/config/auto.conf
>>   HOSTCC  scripts/basic/fixdep
>>   HOSTCC  scripts/kconfig/conf.o
>>   HOSTCC  scripts/kconfig/confdata.o
>>   HOSTCC  scripts/kconfig/expr.o
>>   LEX     scripts/kconfig/lexer.lex.c
>>   YACC    scripts/kconfig/parser.tab.[ch]
>>   HOSTCC  scripts/kconfig/menu.o
>>   HOSTCC  scripts/kconfig/preprocess.o
>>   HOSTCC  scripts/kconfig/symbol.o
>>   HOSTCC  scripts/kconfig/util.o
>>   HOSTCC  scripts/kconfig/lexer.lex.o
>>   HOSTCC  scripts/kconfig/parser.tab.o
>>   HOSTLD  scripts/kconfig/conf
>> *
>> * Restart config...
>> *
>> ...
>> Error in reading or end of file.
>> make[3]: *** [scripts/kconfig/Makefile:77: syncconfig] Error 1
>> ...
>>
>> We have been doing this for some time and never run across an infinite
>> loop in syncconfig. Can this be improved?
> 
> In Linux, most int/hex entries have a default,
> hence there is no practical issue.

I agree. I never met such case in Linux but only on downstream kbuild user (u-boot in this case).

> I will drop this for now.

Okay!

> I will send an alternative solution.

Please tell me how I can help!

For what it's worth the v2 of this patch[0] tried to exit *only* where the infinite loop would start.
I've just tested it, it allows tuxmake to run smoothly and avoids the infinite loop in case of a hex config without a valid default value.

[0]:https://lore.kernel.org/lkml/20230805095709.6717-1-yoann.congal@smile.fr/

Regards,
-- 
Yoann Congal
Smile ECS
