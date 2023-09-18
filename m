Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F577A55AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 00:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjIRWUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 18:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIRWUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 18:20:02 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AD391
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 15:19:56 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-34e1757fe8fso3812935ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 15:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695075595; x=1695680395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iQtkVy0bBjiY++L4VDVGjsqSDZ1al4llsn1ovHo8nPo=;
        b=BuUubTp39ukGBpuXqzCOT3i4UxXAXbAsKCXxE7ttMoekWRp1cOvunpSvfqmAqkurGH
         oNcYb18lR2BUqeyEhc6WC3mnc37+SMv1qnE2pJaUnJ6niEiRGfTqlujWa5gV1V7/9etP
         kXN6cJ9I4bjVFuBv51+PdL1niVBKkWk6pW4nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695075595; x=1695680395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iQtkVy0bBjiY++L4VDVGjsqSDZ1al4llsn1ovHo8nPo=;
        b=q02xSJT/3p11EW9NjXrUQjgIqtiaAFZiUVT6IxULpoPgfQZO/s0MDwJSVXDBNs9l5W
         GxwsYl1KhlOGp2n0ve3XABF7famoFsIQNUynaDtIISUCS5AHNVDef72rleUYDDhDUn9f
         oFSC+9YPgjybrfPYgLiMPnxBfpQGg8BH83R9LQxgKnQpaVvsS37TDGys/GqpTsVavPd3
         nmRPn60jLvVUkZCcb9241nY8SdfsFFqqFdFlvLqYNFWDZ11mMkdLMEBJG1bGt7YLlfgp
         cwj8NcsCucBP68K7Ygh5Ca2pEd2Udl+34qOEf+xuo2fDcWoZvr2GrCympY9KeIFe/kzM
         75dA==
X-Gm-Message-State: AOJu0YzQEM+BD5PEp0iwyyUDum42QbM0Nx+D9j/5LupiuVzrCPV88QO0
        k/HUlT9WrPsE1/OZUGzdueFT9g==
X-Google-Smtp-Source: AGHT+IGhHG2GWoVd+m67RgtbSpgQz/v41HIUXEkQ9EnlB6GmJaiYZUTQduVR2tkiUNR1L5MrITSeCA==
X-Received: by 2002:a6b:5f1d:0:b0:792:9b50:3c3d with SMTP id t29-20020a6b5f1d000000b007929b503c3dmr11061093iob.1.1695075595589;
        Mon, 18 Sep 2023 15:19:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id dk19-20020a0566384bd300b004165ac64e0asm3250361jab.40.2023.09.18.15.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 15:19:54 -0700 (PDT)
Message-ID: <f5262d8f-82af-1f1d-b21f-fc95604e4b99@linuxfoundation.org>
Date:   Mon, 18 Sep 2023 16:19:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6.5 000/285] 6.5.4-rc1 review
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
References: <20230917191051.639202302@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
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

On 9/17/23 13:10, Greg Kroah-Hartman wrote:
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
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

