Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CC37E2B0B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjKFRiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjKFRiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:38:02 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2338FB7;
        Mon,  6 Nov 2023 09:38:00 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2800f7c8125so4557738a91.1;
        Mon, 06 Nov 2023 09:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699292279; x=1699897079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JXl+Hk7DG0xQnZU4tGVI8tvUE8tmSEux9caPBMuGXfY=;
        b=AGIwb2XX6oF84pxTy7lZVJVM/Ea6h0y6ti6LCb8ktD1pNWKShjy5KCJRs9LyiBeGz/
         IvmJvV3PgmbW2s3oQuGneRDsj8lPVMALccaiCe8Jf+Dr8IOEyi+BmvQV531KkTodwaAt
         ImsTHNlsFjcBdgNlaon4n6Xjyd/x9MkvxD8P05ZflmLtXHcDaElmZyRYbo0G0yNwASQ7
         iP4dxcz4wHnhKnoUFToZSwfVGioQSFyg5B2djZbqo2PvSf3BfC/pztjuEAxAvL7gE0jw
         nd7rx2+hIzS1Hk8V16pfPCFrFoakCn+4ulejmzUZmLrspqMw8JTaf9hJuXDsYQ4fatxz
         PPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699292279; x=1699897079;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXl+Hk7DG0xQnZU4tGVI8tvUE8tmSEux9caPBMuGXfY=;
        b=SwDvbFVLUZ+Zzj7u1N2yk2pWRgS6F0LQQCgWs6K2Ov0cKxsetHErMnvj44wUuSB7w1
         DI4eRwMSa9u4YlOgNoYHXm3W9+W+E7UKpB3SlyOtZQLKm0DbhPMMeqCdYYCoNXBEGMP0
         3Oo55kRrN78C46KfsS99V8BdxogVvKbvsR19ddpFgXKLdTiV7uBVbBzXOQ9jRg+LM76P
         XtPlSAz77cxuvzFUpUFEUiZpKWrGV7l6mvnsveCM5Sw89M0Q+D6HN8iCfhbnBN5GglCf
         GXwdTGg28dGAw0tOnpddqQmF/pvrcARqJYBiFKspIWswTTZliohkQqnyebjI729rWjA+
         WtYA==
X-Gm-Message-State: AOJu0Ywv1kaulThvEX1ZVCCR8ZsXqckTci+SrI765ReAzgo+IG4B2jqZ
        MSMP5IwicTZbRMjZx4A9SNQ=
X-Google-Smtp-Source: AGHT+IENG/NaqDAdFCQ9VnTFpP4G2Tf2g017TUG53McEQO60wF6u3aF8m5z8YVdFn8j4VyH1bHKp4g==
X-Received: by 2002:a17:90b:4c92:b0:277:68c3:64b9 with SMTP id my18-20020a17090b4c9200b0027768c364b9mr267730pjb.5.1699292279446;
        Mon, 06 Nov 2023 09:37:59 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d11-20020a63fd0b000000b005b82611378bsm60018pgh.52.2023.11.06.09.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 09:37:58 -0800 (PST)
Message-ID: <f643650a-d520-4789-b67c-4f8da46fee73@gmail.com>
Date:   Mon, 6 Nov 2023 09:37:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 00/95] 5.10.200-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231106130304.678610325@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231106130304.678610325@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 05:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.200 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.200-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build with:

util/evlist.c: In function 'evlist__add_aux_dummy':
util/evlist.c:269:31: warning: implicit declaration of function 
'evlist__dummy_event'; did you mean 'evsel__is_dummy_event'? 
[-Wimplicit-function-declaration]
   269 |         struct evsel *evsel = evlist__dummy_event(evlist);
       |                               ^~~~~~~~~~~~~~~~~~~
       |                               evsel__is_dummy_event
util/evlist.c:269:31: warning: initialization of 'struct evsel *' from 
'int' makes pointer from integer without a cast [-Wint-conversion]

...

   LINK 
/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/perf
/local/stbopt_p/toolchains_303/stbgcc-12.3-0.2/bin/../lib/gcc/aarch64-unknown-linux-musl/12.3.0/../../../../aarch64-unknown-linux-musl/bin/ld: 
/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/perf-in.o: 
in function `evlist__add_aux_dummy':
/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/util/evlist.c:269: 
undefined reference to `evlist__dummy_event'
collect2: error: ld returned 1 exit status

-- 
Florian

