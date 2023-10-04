Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94387B8D75
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjJDTdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbjJDTdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:33:15 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7015298;
        Wed,  4 Oct 2023 12:33:12 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3af604c3f8fso132868b6e.1;
        Wed, 04 Oct 2023 12:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696447992; x=1697052792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SemCWQzXcuF1OTgzS/LJmmq/aml5vJHjFSPL+GSAbeg=;
        b=F/ueSsai0d24N2kiynwMPMZFzL/y65rlG+f5XxVNcsjMhGje3Lq4JfRvEbbRymLgRo
         ozj4Db8aNq4H/vzT9yhLO5O8a6f5AyZQMxWY5ywCjvtOx2ww9NovcLDOclfcpugBahun
         18SeLygVLwldonfGtO6ow0nMWRvu8RasMgvHbXq+mL/Z4xTptNP74BnUusENtOi1B23R
         vt096shadLWB2I2LxeTfXdnS3863DoFpr0ef3V6eW3kAdG5MQtCm2jIs9bQk4YP0Uk9X
         VmisoU+AlY2HCHBS0+STjdne2u7KNm9CCyYCbVz5phtf/o/ofUBMoaJnDi7kbFN/RLJo
         yX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696447992; x=1697052792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SemCWQzXcuF1OTgzS/LJmmq/aml5vJHjFSPL+GSAbeg=;
        b=bn1jsFaYvtrYnHHfVfAwQ8wprv4vjyk44Ejg096QnaVOELV5gz8e7CqL+uMADaAcL5
         Fsg4reGacLIZO3/n42KMlF51Jtmnxe5fFEnVGpIu9r+lCMTr/FApEjVBerpQO6VjoR4k
         JiwsVCjDCD2AyC9C7uP5tdN49p730JAgPIJD98NnaWLjTo1yRk+ODmHpEVXW00T0FfGH
         lpeDzERbYtMXpm+CLu5cFn4ptASBFIapUz2n00VvcYRm5ZjQLfsfswLzLKJ0hwaEvWQ7
         bjeXaLCvgA2dt/QZWtZgy9U5suMlnnUMED5Hk63LDAhiRfNJuM8wpsGL7mXkzehgR3I2
         NENQ==
X-Gm-Message-State: AOJu0YwM/S7Gqobk2Ie2V+mioar5QWCbFgQjzbOSTRkl5v4EqlEljHVP
        27NKREpwdqZXt3K1bxzWjEc=
X-Google-Smtp-Source: AGHT+IEr82quBQXlc35fnQUjfi5Zei6SuX0j4dlPLgb+UF7tcqeF6Yik5FgXSIaDBuC6YBa8szmBKw==
X-Received: by 2002:a05:6808:1484:b0:3af:6c30:f206 with SMTP id e4-20020a056808148400b003af6c30f206mr4188489oiw.10.1696447991649;
        Wed, 04 Oct 2023 12:33:11 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b10-20020ac86bca000000b00417fa7d33dbsm1416420qtt.93.2023.10.04.12.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 12:33:11 -0700 (PDT)
Message-ID: <f0115175-975e-4fde-aa69-666568ce5c6a@gmail.com>
Date:   Wed, 4 Oct 2023 12:33:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/259] 6.1.56-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231004175217.404851126@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
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

+Namhyung, Ian,

On 10/4/23 10:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.56 release.
> There are 259 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.56-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build with:

fixdep: error opening depfile: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/pmu-events/.pmu-events.o.d: 
No such file or directory
make[5]: *** [pmu-events/Build:33: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/pmu-events/pmu-events.o] 
Error 2
make[4]: *** [Makefile.perf:672: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/pmu-events/pmu-events-in.o] 
Error 2
make[3]: *** [Makefile.perf:240: sub-make] Error 2
make[2]: *** [Makefile:70: all] Error 2
make[1]: *** [package/pkg-generic.mk:294: 
/local/users/fainelli/buildroot/output/arm/build/linux-tools/.stamp_built] 
Error 2
make: *** [Makefile:27: _all] Error 2

due a80fd00cb1a7793ead4d7c3fa7d3f1e898231c27 ("perf build: Update build 
rule for generated files"). Reverting that commit fixes the build for me 
and then all is good in terms of testing.
-- 
Florian

