Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB6E7F8CFC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 19:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjKYSHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 13:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjKYSHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 13:07:32 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ACD12B;
        Sat, 25 Nov 2023 10:07:37 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-41cba6e8e65so14945511cf.2;
        Sat, 25 Nov 2023 10:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700935657; x=1701540457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=upEcVraNSb7s/9xx6KGQEYjEvjDdPHa3kL3+IfGarY4=;
        b=kjXf1mCEK1dwuDtBhe0OlUJrcGlcOa0rx04oZtFnHefnt5UhZU+sVuMHnPvWnEsvTH
         VjuJqPYKaCOavht3zTr4I1CUIZ8FFlDmMSE/rpSMQx9MiDpGEGgN5wHtaKdcsT0wWqIZ
         EgowMt0DCzQ9VO96uikHQivwCB9Nz/YkobsLQYMZwxbRzOllSpaNBbzZ0HG6HB7jazve
         05ruasejo1buCQYd3+IVbzfVa6rZXljfLRXnwI9JMF2F6AGmUIXEm6YtlSFzEKRgwWYd
         L7khOK74s1RZlR/qneSuG0bnN4DXTovF+AxDe7orMMyy4x4NfqkNSB9oaMX9wgR+WYNM
         SW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700935657; x=1701540457;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=upEcVraNSb7s/9xx6KGQEYjEvjDdPHa3kL3+IfGarY4=;
        b=aEo6CKQs7AK47ZORr00Am9ssEIFmLbz4xsbV24EQEUDatgehKTX5015jIXWWKEKlRV
         9V7EnDPlh5npF9QWUzM84DL7S6JnrGk115Mbyv3W+zMSIKXdeI2u86nRFxMOsqwHzEja
         4mdlerBBHc9/uwN3NfIZrO1rBStt0ZvIeDJW6wi0CmXdqkolWLmCHrqqEA2RQQygcZrF
         75cZSjiXoD0xvNXGZVtKS4m5HmaK0ndiAZgojdkOcoU4R6V1SREbElgqp5sPhfhmUF+o
         QlYZzoxFAUrU9Ve9a4xm3KhNuc0aDzBA/VqHrtbL7hYIeExN4ZBZv1PCbyn4rYKFn8zg
         IzaQ==
X-Gm-Message-State: AOJu0YwU/4i4NjsVJp8V/kMdiRyXvQaylVnPGMfGtBiG+nxe2d+5Bamh
        RsoBb9idUwEGFCwEdPQs3CQ=
X-Google-Smtp-Source: AGHT+IGqGZqAANbcoTPQojvxE/r3u1wLfRA5xcge8wR1+dmbqyo9seuCllp65vjWuKE2EI2BWnt1mg==
X-Received: by 2002:ac8:5c04:0:b0:412:c2a:eaef with SMTP id i4-20020ac85c04000000b004120c2aeaefmr7647480qti.11.1700935656791;
        Sat, 25 Nov 2023 10:07:36 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id v12-20020a05622a014c00b004198d026be6sm1332091qtw.35.2023.11.25.10.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 10:07:36 -0800 (PST)
Message-ID: <261a0a3b-d1a4-4fe8-8fd7-42e9e2786348@gmail.com>
Date:   Sat, 25 Nov 2023 10:07:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/155] 5.4.262-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
References: <20231125163112.419066112@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20231125163112.419066112@linuxfoundation.org>
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



On 11/25/2023 8:32 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.262 release.
> There are 155 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 27 Nov 2023 16:30:48 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.262-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf does not build on ARM and ARM64 with:

util/evsel.h: In function 'perf_evsel__has_branch_hw_idx':
util/evsel.h:387:54: error: 'PERF_SAMPLE_BRANCH_HW_INDEX' undeclared 
(first use in this function); did you mean 'PERF_SAMPLE_BRANCH_IN_TX'?
   387 |         return evsel->core.attr.branch_sample_type & 
PERF_SAMPLE_BRANCH_HW_INDEX;
       | 
^~~~~~~~~~~~~~~~~~~~~~~~~~~
       | 
PERF_SAMPLE_BRANCH_IN_TX
util/evsel.h:387:54: note: each undeclared identifier is reported only 
once for each function it appears in

dropping 946b6643e67f552a9966a06ab5a9032120eeeea9 ("perf tools: Add 
hw_idx in struct branch_stack") allows me to build again for ARM and 
ARM64, howevef for MIPS we also have:

50a3ffda05679c55929bf2bdebc731dfafe3221b ("perf hist: Add missing puts 
to hist__account_cycles") failing to build with:

util/hist.c:2600:5: warning: nested extern declaration of 'maps__put' 
[-Wnested-externs]
util/hist.c:2600:23: error: 'struct addr_map_symbol' has no member named 
'ms'
      maps__put(bi[i].to.ms.maps);
                        ^
util/hist.c:2601:24: error: 'struct addr_map_symbol' has no member named 
'ms'
      map__put(bi[i].from.ms.map);
                         ^
util/hist.c:2602:25: error: 'struct addr_map_symbol' has no member named 
'ms'
      maps__put(bi[i].from.ms.maps);
                          ^

so I would suggest we just revert both commits. Once we do that, all is 
well for ARM, ARM64 and MIPS.
-- 
Florian
