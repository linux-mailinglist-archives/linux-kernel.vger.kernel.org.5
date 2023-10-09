Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5127BEF0E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 01:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379065AbjJIXYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 19:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379014AbjJIXYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 19:24:05 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF6D9D;
        Mon,  9 Oct 2023 16:24:04 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-457584c824dso1120334137.0;
        Mon, 09 Oct 2023 16:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696893843; x=1697498643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cA2IGKu/7FNKv/PuZySh+4g16dqwPNHFTAWtDeYeE8g=;
        b=htAJwmosPQz52arIWO2NspiihQmXDFEcUtelh6t/7cFedIkrTrNTFt1gy+J88FgQ/g
         P3bVM7cA78oaqreJqQ6G75l8NgUcYWaBS3Jfym/FJzVVcMo2f9OiVPIztst2iFmmI6+Z
         eA4dyEjusexXrPg6ayJ52kv9xgMXqOk2v6VfTQv2bQPCD43tUxBkIwiL8/TMw/q4EAiY
         B5gywA5eAKw7/2gg04n2V6v+aO6X9+y6/PYnczjgEQdyvxunoh2/Ot1xIu/wpe6Xbk4F
         kknd+g449N1FwohNNP4n6nIaTQTSBGvHWJp0rj6Z28bS6FVnDre/ls6HReUENmRai2Vm
         4k1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696893843; x=1697498643;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cA2IGKu/7FNKv/PuZySh+4g16dqwPNHFTAWtDeYeE8g=;
        b=SzyZnw1HgvhlO40z2u12A+QaeNNq5VCu7NI2bOWEO6lXHxf8GGP6XHxv1SSRHAynZa
         cjD8MpQpbCrQZFdIGjL4+KIXUc9Q4wOjK0FVmhbCqCgaXc3LGnrqAG466LQindoK2wOg
         ecRQ8anKe0Fi4moTcnAER0l/oF3FNu/+phg75BTS0bvQ6DzO2W7w/OOciWjS05YmYry8
         F6uYKyxmYJKprvEk8YXEeM26UERFPfd0ysqy5Xke0K2fPVstQt0viQXHr84KSql2XisW
         VCTvtSq97kDgavM9c9Kcv3KwpEY2eCwiZDak42640noAaKL3/zYUCh+GwEdRLEBeuBJ4
         tDug==
X-Gm-Message-State: AOJu0YxzwevwYRwQXCoqq4XfM/qBxzFfJJ8HcpEcKoFqN0o9lzajX+vY
        jLbs5KMEh28XvPgFfkxoQF/x2pSsOBc=
X-Google-Smtp-Source: AGHT+IHP2HhxMOnlmXGK+txRl7Q9zJjy0sGy9q8G/opaA9agV7Dw8UPXhRzE49CDXfuCShdQ5cJ5CA==
X-Received: by 2002:a05:6102:441c:b0:457:7138:fa74 with SMTP id df28-20020a056102441c00b004577138fa74mr5156466vsb.35.1696893843473;
        Mon, 09 Oct 2023 16:24:03 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d9-20020a05620a166900b00773fe8971bbsm3887010qko.90.2023.10.09.16.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 16:24:02 -0700 (PDT)
Message-ID: <99e90f84-d95d-4438-8b4a-03c3956644ae@gmail.com>
Date:   Mon, 9 Oct 2023 16:23:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/162] 6.1.57-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231009130122.946357448@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
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

On 10/9/23 05:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.57 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.57-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

