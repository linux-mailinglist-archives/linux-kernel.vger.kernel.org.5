Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080457BEE74
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378928AbjJIWsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378927AbjJIWr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:47:59 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEA4AC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 15:47:57 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7a2874d2820so64231039f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 15:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696891677; x=1697496477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9dmV0s2gvhYKd9sKafgfFhwZfZh7sBcpDjTFnUkjgaA=;
        b=hbF1yqxPBlYbNekYZFnoG1PkY61oChmRAbe/8CpN72DoyiP++K6JTZeZFpT+gYcr60
         DdwdpqHwE7IOK0yWVlZ/ppmGBl6x+Yzds+AxTm7QVBU0yZGWZ6UpsMjN1nWLLG4FWzpt
         r5giEQ1DXu0U+sJGd345hHwZlSgweevb0FI4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696891677; x=1697496477;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9dmV0s2gvhYKd9sKafgfFhwZfZh7sBcpDjTFnUkjgaA=;
        b=Gc+ai5wxublrIUp5JVmgTzP4A/niVhEBYe6SiiEGzddRLS47eg5/gf5nMZARFzwY/V
         V9XR/mMT9aD3ZvZpImJhNTCscbpjMM+H3iwol5KqC0Xw8GGONkSuVoy/MTVYygcfxbRO
         pborXoGch9UWXL8ivGsMt1YtHqxwnG1tbbU0bL8FFF2+x2euZGoVBpVs09AN52bUFfA5
         qA83nrPo+ABMV5YUqBUgFeVA1yKXHEWcjJ5wAWZV9Yugz02eTV4Oh8uNlBSiFA12NdFm
         IQqvHs0WnzB/5KKg2Z5GSjmFwMIwGpgralV9xSm6DqCRAhtDYLLuC68ZU0vD5IwOkCh/
         A7+w==
X-Gm-Message-State: AOJu0YwxhYcna9ZdAeiYmolapJKMjQ0MTRinbd/BoTjGomZFrpJGtUvj
        jnfqLO2X67efsxSfT1nn7WTIan9enP/rFXCvwz0=
X-Google-Smtp-Source: AGHT+IGTiYBjiNf9gT4dg3w+9cYpLpg4VurB4YXRIhvnxRU5szianBv5FtByTdxps8PoBzoUju/Qvw==
X-Received: by 2002:a05:6602:3a11:b0:79f:922b:3809 with SMTP id by17-20020a0566023a1100b0079f922b3809mr17703193iob.1.1696891677005;
        Mon, 09 Oct 2023 15:47:57 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q6-20020a02a306000000b004290985a1efsm2344564jai.43.2023.10.09.15.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 15:47:56 -0700 (PDT)
Message-ID: <4275348c-13d8-47a5-b661-12cbeadc30d4@linuxfoundation.org>
Date:   Mon, 9 Oct 2023 16:47:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 000/163] 6.5.7-rc1 review
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
References: <20231009130124.021290599@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 06:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.7 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.7-rc1.gz
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
