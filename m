Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD641756E84
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjGQUqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjGQUqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:46:18 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC0F10CC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:46:16 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id ca18e2360f4ac-785ccd731a7so51666739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1689626776; x=1690231576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sxgp2mwlv26YsfH69lRjIjxF5UskIkFR70oX6AS3GJs=;
        b=Y61QceVKdQIJKsar7XFQV/CaFS90R4bca2nGRuvsmf1lRexRt9E9pWQ68rXcbKHE0Z
         y274BCu/HTQganiSFr9veh79rMHykmo7ZYKGZSttNRxjGHYsiW8dCce1pihg2kbN4R7I
         czKxf4r87JW3TUYg9u0vKJ/YCLP6fl2qwO7J8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689626776; x=1690231576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sxgp2mwlv26YsfH69lRjIjxF5UskIkFR70oX6AS3GJs=;
        b=C+7fwWt2hbHifGCu5mzdQ9f2OuWa08HSF+rJC+3NBqj+lbKfnuERYnZKWKFl2HAoEb
         jEpRt79OYsB4xu7yJcNbMmrRSDsNl4hMf+s55J5mAI6fg39A7OkA3HpagZqOJGW1nxht
         VIfSmjS3fvNlg0bdp3CR9F43Ska/8CUVGaOW7pJzLlEMxw3gp2+a6LlLbIi/+lJ/g0JA
         YYuMHItdzw8rjQ3mZOh1EVgZ1rJ+B+ILzXgUoQAQ3fJaN1LxRxnfKoL+1vCaFK5B2RSX
         Kr1z/usBCp2DQVzh362Hlpx0zPgHQW5+nO2HFlVF58+tw6eEubKtJZ0WA/AzUoD1CcPf
         YPhg==
X-Gm-Message-State: ABy/qLZ0lg6conk144jCjnh/T+K32eVbc6nr5IxN9AW+M01UxWMwlT3Z
        wQ5LQShlOnjeiI/ErS7HTovbsg==
X-Google-Smtp-Source: APBJJlG6MFdMmtlsKtO6W9vfx8X+L1SO5x7xZilm+7U95hMbQfsDp+fQmSAqCf0o9C5oDSYSdCjL7A==
X-Received: by 2002:a92:2609:0:b0:346:10c5:2949 with SMTP id n9-20020a922609000000b0034610c52949mr647458ile.1.1689626776218;
        Mon, 17 Jul 2023 13:46:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id m7-20020a924b07000000b00345d2845c42sm181319ilg.57.2023.07.17.13.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 13:46:15 -0700 (PDT)
Message-ID: <519168de-b559-186b-41d4-3659e0551c10@linuxfoundation.org>
Date:   Mon, 17 Jul 2023 14:46:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.1 000/591] 6.1.39-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/23 13:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.39 release.
> There are 591 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 18 Jul 2023 19:48:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.39-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

