Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891177A52C8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjIRTOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjIRTOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:14:03 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E454B10D;
        Mon, 18 Sep 2023 12:13:57 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68fb79ef55eso4452130b3a.0;
        Mon, 18 Sep 2023 12:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695064437; x=1695669237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dBgll0vV+9Vhff8vKZmdxvYEuk870/D/EdkI0S+iCj4=;
        b=F2fsigFUj5Svrxbg5msXILOystSHnAv7eHqXkE6U6zz5eFxvqTi5Eqw96abtd2nEt6
         zx+L6BOaqXu05UibJguLUHRl57B70Wrisf1RKIx7JDhIbWyCLm2ZA47osPpcev2VPfem
         KLOJbYZLkiuizTbTMQB6VVcvbNVMtYx9J8PuC5fhLV4YpmgUQB/E5UM/D7nbyHlKdXve
         r/pgH9pJkaobSDUAo+EqIz+/IYyEkrdL2dDb10I5d2kn8ANJPTKHFu4kgTOw+v5AQdHg
         c8JtJou7Gb17kDgC/1oJXflVhqeROhrlBFF0Yjk3TryIU3wmRFHtxN3EnKlq22e+ycU5
         /HOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695064437; x=1695669237;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBgll0vV+9Vhff8vKZmdxvYEuk870/D/EdkI0S+iCj4=;
        b=CSb+Ln5OguYZfVnB23xwakDTBxO1DWPAxGTbfrZWf9SsnE5B8WJSHGakguSypzKild
         61zIEBEZZYPUUbq0i8qW03ZRCZoMhI8Yiaf5vu9JBZaThjOeFrImTyWj/cJR1K3vM0mO
         pLJIAqLZzRcHiuwRnTI7KAid2++uz7R/OdjTi41smHgZ7/wFOHG9Y60dsVwxF+3OsBie
         6wEoKYPgpkhsmveLSHuoiWsn5pvw4osEelKR8Tye4Owd8zBnEWUu/PNIOSVa+lh8ws+t
         nFzSgzNZE8Aacrjh7b/QtV+PUKGb1P02ayhA7A/0c/WDDBIIJBuekue8jUi6Mv1UutDb
         bSgQ==
X-Gm-Message-State: AOJu0YyX/8dlvq5dJNfDdsPIYzrUuQGmLr7m6FNU4DigrvXFn4/rWlZh
        C8wydtWo/qdJsdh8HgxLW0I=
X-Google-Smtp-Source: AGHT+IEtPQ2gcwZwvuxi1RJu0eheIDLvUbluLfxgaER7RLlWeuh5FuziT2DXJl1qR/5NlGU6wAT+sA==
X-Received: by 2002:a05:6a00:18a5:b0:68e:2d9d:b0cc with SMTP id x37-20020a056a0018a500b0068e2d9db0ccmr13002251pfh.6.1695064437259;
        Mon, 18 Sep 2023 12:13:57 -0700 (PDT)
Received: from [10.67.49.139] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id de11-20020a056a00468b00b00686236718d8sm334088pfb.41.2023.09.18.12.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 12:13:56 -0700 (PDT)
Message-ID: <ce0230eb-8bd4-a587-c034-f390337d8b3c@gmail.com>
Date:   Mon, 18 Sep 2023 12:13:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.5 000/285] 6.5.4-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230917191051.639202302@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/17/2023 12:10 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.4 release.
> There are 285 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
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

