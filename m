Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00EC7A8E87
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 23:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjITVfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 17:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjITVft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 17:35:49 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0EA9E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 14:35:43 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79293ebfaf2so2195439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 14:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695245743; x=1695850543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wnjLBTOoGB3BEH/QsYYxwDhaW5W429+ymNjcE88GaWc=;
        b=COPRiePDb8DjuRMkitqFGY6CwcmrrfJTjW0LuTBHTPfcuRFlMouA4th/bAmZQDFPgf
         WE6Bse0Ugl4C95/f1lcpraTCB/3c4peTcfSaoaaJr6qPoglWbB1vfPaWQzeGQJzZx1Cl
         zJajfM+LbSLDbxuMZ1EHqQPkhO/CQP58CQ8FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695245743; x=1695850543;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wnjLBTOoGB3BEH/QsYYxwDhaW5W429+ymNjcE88GaWc=;
        b=tRAq018H8ZgcQ8sTRr6Id7kDRaSpbiQtJUUVaRQShdwtv9HNKR8mnDqU4+AR0UweJt
         XuFgB2HMMfke/o6m58VXaeoesp/FAQklcfAoMxgWeLb2ctJHKVlLwCbAZOR7UoTVp6+G
         OzZT/aag05UcHL65qxPyAb/6x/FHaolJNE9HmwN38+YTy9RiFu9oo6gLmzeoj0bNzH79
         dL8annLtqQ+roJY6sQqG97nJxdgMkn2Dlql2LTos6BZo/aQpeUZiAewo9ruIAGX5moU9
         lAAaeXiPLvruZX8esuoBzDODGvz6igo5DPrgHHPucTvTVjDwJ2cGgyP80arXlse0bzlQ
         lrcg==
X-Gm-Message-State: AOJu0YynwfhjxVrRoH2bSMtXLLE5ap00Sir03SZmU5Ip5S599N1pwCJl
        /MTiW1I6UCUFULuSNO0C9Hcjlw==
X-Google-Smtp-Source: AGHT+IFJemHteVc1ljGTNwHf12PlSt6hsHhCIWqr117Co1UpKaEaeNRR+7WriBQWOyoXCTlNDe8TRw==
X-Received: by 2002:a05:6602:4996:b0:79a:c487:2711 with SMTP id eg22-20020a056602499600b0079ac4872711mr4715130iob.0.1695245743114;
        Wed, 20 Sep 2023 14:35:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x15-20020a056638010f00b0043194542229sm4126541jao.52.2023.09.20.14.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 14:35:42 -0700 (PDT)
Message-ID: <b581fd37-1e31-1d9d-b87e-23e916bc2116@linuxfoundation.org>
Date:   Wed, 20 Sep 2023 15:35:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5.10 00/83] 5.10.196-rc1 review
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
References: <20230920112826.634178162@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230920112826.634178162@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 05:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.196 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.196-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
