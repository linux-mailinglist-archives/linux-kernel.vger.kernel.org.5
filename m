Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D6A762333
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjGYUWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjGYUWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:22:34 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA941BC8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:22:33 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id ca18e2360f4ac-760dff4b701so72305739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690316553; x=1690921353;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bf2CNixqsX449C9tAWAb8hwMnIs0tbxQueKfU+PKFSM=;
        b=MaQDG0jspt5kde4hChmeMyA29ZTXrLY0a0EUCraJZk+l0I7NQXR2EmDNK2VgpK0hLK
         JU2ya1YxYgeWJBl86FlCkrs22JrXC0jVP3je5UaIWlPJZlG7RxOua3TeXbmnpjqx32a/
         HgNxEhfWOHc0jq0bn+cFh5qTxh+907/P8lnzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690316553; x=1690921353;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bf2CNixqsX449C9tAWAb8hwMnIs0tbxQueKfU+PKFSM=;
        b=DY2zo+U4iihc7aDJXNwRKTboI1Fml9hEBHQ9ysFYCYOhgGrJxm4aAtHb+GA68huV+a
         nZ4J6aOxOIWN61VJ5iMtouejcIVOcwYU0E1zjo1kXR79nvozvqiaSm5GC66JIxdr1rGB
         gkIQDy+NNf30ISDMHdiI9LukeVZyyv0uPZjPdxj03LEBanuXicRlb37eAxvVc18jLDWb
         a+sBqlHSu1vxhcEMe5sd2wU9Rm8u9bJHweE+koQKGg85v1uJJdgmL9qgLX8QnhwKDvqX
         tJVS1hfS9H47KE1fyFNsYrvLb+pcMdJO3BLLrffqhfmJAjZ+AS32slF4wL+yh8/fqiEN
         4Keg==
X-Gm-Message-State: ABy/qLY4BBRunLImxCpAzFWVkx9WlTrzpX7uMzXLt2ZQ0LP+v0iybVLi
        rGtKyJFky5p931esykxp9SJ10g==
X-Google-Smtp-Source: APBJJlGt4meFfqi4Y71Znubs6DO8N4/IGToe1sQM01yX2c3yoYaBm7GoGY8cRweCeMYwM2QD5T6WUQ==
X-Received: by 2002:a92:d08b:0:b0:348:d465:4a36 with SMTP id h11-20020a92d08b000000b00348d4654a36mr104889ilh.1.1690316552754;
        Tue, 25 Jul 2023 13:22:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id l15-20020a92d8cf000000b003420dad3121sm3900851ilo.75.2023.07.25.13.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 13:22:32 -0700 (PDT)
Message-ID: <8f30620b-5543-86b1-e7de-47b356c01dc5@linuxfoundation.org>
Date:   Tue, 25 Jul 2023 14:22:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.10 000/509] 5.10.188-rc1 review
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
References: <20230725104553.588743331@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 04:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.188 release.
> There are 509 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.188-rc1.gz
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
