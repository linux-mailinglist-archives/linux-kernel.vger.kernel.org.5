Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F3B79BD38
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbjIKUyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244373AbjIKUNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:13:32 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519EF1A7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:13:27 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-760dff4b701so57238239f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694463206; x=1695068006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oHAg2VsYE9Wj9A+w2eQqzWwdmNR2LINhzqAcs3jRGCQ=;
        b=OTIqUpBmEH8khAWpb9mVqBbuRwV4BOekqYPWJNL+/m0ewUwFk0ctBJm161pDB6V2CR
         4YRGPZumiNCF8D9yi2w9nM0zu5O68wXPiTjDNIxSRJKB7gUSEaVAIXLh7xm4tp4LH0lz
         nGIRNo8x+1ZB0NbbaMIuzKvcXa/t8qTWcJ8iY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694463206; x=1695068006;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHAg2VsYE9Wj9A+w2eQqzWwdmNR2LINhzqAcs3jRGCQ=;
        b=S6AVOt7dAPh29H9PO0Qa0xCfY6mX8MHzUm1FlS7RmwX20TtGYVZJvHsfyg+g5BXHxv
         puUXe+QoWjwPoiNuzWasMwFT09lW21SVw7o7iiv4lFNVYTsWcv/nCSMEWCRngdQhFSpy
         f9naE2s0N6635Ph4urnrNN59QvP8ESE8OgL0STf4SBPEYGzntzERGtvggUTytUGq6/fM
         OuUUsYaWuo7m3nTWOomzD5d2Xs82juvhTOYaSEVs3wXh0z+T0MaiUJa6zS61llpw8nGg
         GIH9q44VUL8MY0a2pY2IflfDpqHMAo8NzBJvxB728B2tLi0cLnc+CpTk3SWiZsXAgEId
         zAUw==
X-Gm-Message-State: AOJu0YwFj1S3XpFLttiBuLfnkAOpGqsTm1c9yN+bC4skaucLDNO6I37m
        q7l/TQee8ZV7XfNMPKgOlIwFVBfuHRcO1gqxMbc=
X-Google-Smtp-Source: AGHT+IHju+pZJElzjkRQNbwS7wWV4kEKFa3k5wqg8347rfU+vNEOKlF8pgbnZJFdZXH90URKq3MS4w==
X-Received: by 2002:a92:b74b:0:b0:34f:6e08:d6a3 with SMTP id c11-20020a92b74b000000b0034f6e08d6a3mr5779868ilm.0.1694463206639;
        Mon, 11 Sep 2023 13:13:26 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id p14-20020a056e02104e00b0034f6f2eca21sm1298149ilj.69.2023.09.11.13.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 13:13:26 -0700 (PDT)
Message-ID: <20762b62-c15d-467d-2125-f8ac20d20d95@linuxfoundation.org>
Date:   Mon, 11 Sep 2023 14:13:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 6.1 000/600] 6.1.53-rc1 review
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
References: <20230911134633.619970489@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 07:40, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.53 release.
> There are 600 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.53-rc1.gz
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
