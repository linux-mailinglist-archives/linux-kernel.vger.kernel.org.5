Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B625179AF11
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350343AbjIKVhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244354AbjIKUJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:09:49 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C721A7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:09:45 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-34f5357cca7so4499885ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694462985; x=1695067785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n6Z8kcoZfdqrD4VAC+its9hMTOja8wL+SBN6X63Af10=;
        b=hJd0weg9G6YUTNwQAgWAnQuFFk7g3yfDoBhkK1bXaLU2DG6GuuJPLCDFLa1DDu2oDK
         bqwY4a0M+bULqHECRPvWdACVvAIsdvL/on+WQv8ynZzUx9/wieBUTMxqu2GZPe4BZRVN
         zJi5XxaEytgvT10zIPBNGnh8qzUyMGsqoln7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694462985; x=1695067785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6Z8kcoZfdqrD4VAC+its9hMTOja8wL+SBN6X63Af10=;
        b=moUrnjGkPO8RGRpTFSB23A9slfJY1K/bgtLxbS4GYKAEm6hd2KnbUnVbueM56P43cG
         9g2h4VZqed1+qaXAuIVvcy607rs+r4qg8MY5dqUexbwwe0edDGnbIWGHOtA68YB6sEXP
         aaPjnocXlOYs+LdNZ/Wdk8u6xB6TBaBTbf/ZdcL5FBNax4bQoVcVCesYa7SA1OuVmP9m
         lh7k3IgqJAKIsYT69EPAq3+kX9Tq7SXrV1emhVVTnZVP3TidU2Cm0a6yKpm3Kvhm9Vv4
         0qA6enZCulLlsSiK2bEFC5mW+ZTExfI6Sia4tCahscEeEAFUqOhoj8Pk/YSpfnrfmCxO
         LtNg==
X-Gm-Message-State: AOJu0YzfZChlrn4Usnysw3cFHn+sYUIR4x5KFjAM69DTcHt3VzK56Uwt
        yJTo+6ZdVrvAyRiaP6r/XOUa3w==
X-Google-Smtp-Source: AGHT+IHl7dEk3Usw2lbA4i6Du78JPOPDv+eJN2JrRzjfuzVVE4YHa04mCVuFcDZEenbGJoV25HF5dA==
X-Received: by 2002:a92:dc05:0:b0:349:983c:4940 with SMTP id t5-20020a92dc05000000b00349983c4940mr10587304iln.1.1694462984855;
        Mon, 11 Sep 2023 13:09:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q10-20020a056e02078a00b0034901a2f693sm2575834ils.27.2023.09.11.13.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 13:09:44 -0700 (PDT)
Message-ID: <a0dfa3d3-da47-56f2-b486-c9d607f9749e@linuxfoundation.org>
Date:   Mon, 11 Sep 2023 14:09:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 6.4 000/737] 6.4.16-rc1 review
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
References: <20230911134650.286315610@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
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

On 9/11/23 07:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.16 release.
> There are 737 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.16-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
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
