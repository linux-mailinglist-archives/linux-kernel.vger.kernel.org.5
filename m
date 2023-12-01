Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F167FFFE7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377370AbjLAAIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377367AbjLAAIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:08:49 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B58197
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 16:08:55 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6d63e0412faso284888a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 16:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701389335; x=1701994135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zIpe6Pc8ZEweE2wHhNCMd1qwpO5w40pY6E+2NFsb9lM=;
        b=P9eMkDoYcRuWpW5lX2gDC3rXNb+6JHI9ZawoQPSB3RV/GDKEbBVz0DzM4u0zDp4mqJ
         KPInS8wQjHIU5W+zmCLfBHIyrfe6cLJ2r0HyRiUDDpux07u+Q/3/aYMJ9kh/JxV+1NS+
         UgHNdyl69ugHuAQcqXmZxSiKIxzAVftPRlr+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701389335; x=1701994135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zIpe6Pc8ZEweE2wHhNCMd1qwpO5w40pY6E+2NFsb9lM=;
        b=QRTFZpzCEGiAJMfAoST2aQTV+4MCvTTaGgiiuWdwllKy4ceR97X7nIjhpG8pGtcXlh
         /FflUDpMpsH2b0d4cD0JV8nF1m0rZDYT8Wq+3TZYXkVxlCZQBrEoS7jp+7Lff+Senpky
         SV7GjghoZptMfLnxWTheizxlzrswvD8r4DxtyoeWDxdQVBL/r4oBqhe3PTYU73w9n+t/
         JRQImfHqSjUiu2Mzcj/OduD8XGJMR4Dv3eBhndydhN0pveSCLY+eNNPJUjwcx3y6RdlD
         kU3uaTNHTuD5nRxcTNPYbyt4jwZ0vNbCtXbGAlYVGpcGmcOA4vJJQaFUjnGJWxWJmIBX
         pYCQ==
X-Gm-Message-State: AOJu0YzIlluVINcgmdkGAp2TPlihViVN3nSQQHWPc+DybA9aGlP13Dt2
        Z2Fb93Qolan7tgJlspNqc/P4wA==
X-Google-Smtp-Source: AGHT+IFiMvXhLclCKdsvPVqAtnER9bIGg1ntAGRXcro8SZwc8QNq2ehOJpy6gxKHfW0xxsLRvnKWsg==
X-Received: by 2002:a05:6830:4686:b0:6d8:53d9:8386 with SMTP id ay6-20020a056830468600b006d853d98386mr5896779otb.3.1701389334789;
        Thu, 30 Nov 2023 16:08:54 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e24-20020a0568301e5800b006cd09ba046fsm315807otj.61.2023.11.30.16.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 16:08:54 -0800 (PST)
Message-ID: <a78d25f6-4822-46da-a431-1c35cbca7b18@linuxfoundation.org>
Date:   Thu, 30 Nov 2023 17:08:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/69] 5.15.141-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20231130162133.035359406@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231130162133.035359406@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/23 09:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.141 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.141-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
