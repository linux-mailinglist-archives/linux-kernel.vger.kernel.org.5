Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBEC7B8AF6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244378AbjJDSny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243679AbjJDSnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:43:53 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C313BAD;
        Wed,  4 Oct 2023 11:43:49 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6910ea9cca1so99685b3a.1;
        Wed, 04 Oct 2023 11:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696445029; x=1697049829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ooOYlMNzU/nXOVXoJ797h2bTTI8LLLqoLCs+5/x9Ip4=;
        b=RghYVaNNrpPi/xunouXUuHJB6SOPCkZbbdQDL7qZFfbqJkILN3UT00qnmlHQCO4isi
         PDkjfwLZIkLBUmFoQrfdsEx376dMP7/VGh7HnlnEdLC3/andxuDM18fS3OdY3zGgpyID
         u9ZLgxhVVlJTEmm+EOkKtIWOd6MDnzhLaRFIK4Iq3YdYP55x2vMtq+afL2ChbHPJs7n1
         yCLsunClgrhnWi5i1U7QcGs5dQDucNECQpSw/wI0lOPDLRbgjYg2ycfQr0++bFs0knJ1
         +eiM23s2CBNJj1Wradg65QIj3aVz6mQceSMcKrkOWmn0cwbO1Im27gtUqDp+KvBIN6Kv
         LEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696445029; x=1697049829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ooOYlMNzU/nXOVXoJ797h2bTTI8LLLqoLCs+5/x9Ip4=;
        b=aUMoM/Vovwx779qV79nD+PwrLphNQbDwP+xCoHXPrHegO/fdYqWINL2FS4q9OBjoyw
         64C/A2ZTYq+7YotgbsZJz69oY4Z2s2o8wsQ2laxN50Gfg4RnkpFWmhRqTKTJtEV6qNrm
         eoOuD98+xAI8COWK1vPmH1G9YDyDHC5fXwnkyTQzPAKpVyvg3aLqRH4N0yJwUPSTfJBm
         c/1ustY6XJ6G4wrIhMnZLFgjUP4sRJzg1Z3CS0h/cJuzDGuNNfPKnJZy9MfeuVnXIcCB
         UvzBIhibkSP0aRg0WsY26bDojY9oKQ8WkmcyCtFjzcE0q3zerHhda8WygAlT0VejNRo9
         yHwA==
X-Gm-Message-State: AOJu0YxOTJEWkkJPTIr9/R9LmvImp9sVhO6Ouk5vLNiK4inswTcikPsV
        A42QBwFMtnXDgfbx61PsE+Y=
X-Google-Smtp-Source: AGHT+IHiU5FJ7NyeBXXTb5/Pd5QfBu0+HGaAapZFd0bSBcl87BGZKPtg+wwrmtSgFOwUq9LSC+Xk2g==
X-Received: by 2002:a05:6a00:2482:b0:690:4362:7012 with SMTP id c2-20020a056a00248200b0069043627012mr3712536pfv.28.1696445029127;
        Wed, 04 Oct 2023 11:43:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id x7-20020aa79187000000b0064f76992905sm3536129pfa.202.2023.10.04.11.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 11:43:48 -0700 (PDT)
Message-ID: <ec06c2fb-6737-489f-8439-307e0d84687b@gmail.com>
Date:   Wed, 4 Oct 2023 11:43:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/183] 5.15.134-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231004175203.943277832@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/23 10:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.134 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.134-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build with:

   CC 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/metricgroup.o
util/metricgroup.c: In function 'metricgroup__parse_groups':
util/metricgroup.c:1261:7: error: 'table' undeclared (first use in this 
function)
   if (!table)
        ^~~~~
util/metricgroup.c:1261:7: note: each undeclared identifier is reported 
only once for each function it appears in
make[6]: *** 
[/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/build/Makefile.build:97: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/metricgroup.o] 
Error 1

caused by c1ef510a0f2a879bf29ddebae766ec9f0790eb8f ("perf metric: Return 
early if no CPU PMU table exists"). Dropping this commit allows the 
build to continue.

I had reported in the previous cycle that 00facc760903be66 ("perf 
jevents: Switch build to use jevents.py") was causing build failures:

https://lore.kernel.org/all/6a577578-8adb-aa70-1bf8-b1a4573152cf@gmail.com/

do we still want these commits to be included?
-- 
Florian

