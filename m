Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBAB80F216
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbjLLQNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjLLQNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:13:34 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5324F2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:13:39 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7b70c2422a8so38749339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702397619; x=1703002419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i7alySON03WYfD6qf3ZfyB9eSAEEy5WG2do07xkvBxk=;
        b=K1SzLdpb7gA9oMzk+aaiKNmDLcH3nC3En/NUOjSZZ4NFL2/ak1vY7mv+lPppZHzal8
         7tZMfcqKHipYYsTEK2ecuhOP1/ctT94SkR4yht1bRiCiiOWgPRdPuQO2grUWai3lv7B9
         JgWDZW8/LiWww+wmiVNr2tTw7qxDFpc9qa/tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397619; x=1703002419;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7alySON03WYfD6qf3ZfyB9eSAEEy5WG2do07xkvBxk=;
        b=SHW6HAd+VBZtw8+yHb7r8yHtzjyv862rDSaYl11+Dq6iU4ycMaoRu0cIHB7ikin0H+
         gZUj0RslQYJcoMm8U8bijuJ8/cithCkxPsyZN8jrm1aBARerf2fYPp/OM2eXtqa7+moQ
         AgmMeg8IeBd4OD3crpVqNf+BdtrUv2cWkyeN74nsNQxAs5oIpK4PDDnM7y/X9pA7WzfQ
         iVyhAoxy/fskfpmqhn7LMhDETDY1x0U6uwMeR61luAtiyP5JDtM1snhM1Iuoo2ZXDNKM
         QgUCpzKx6jGYVxKC9qhyqSUVRcR5PUQVzp3hG+puN8JEBPv/m4bx7PpE2Wuc9HWWrLj9
         dMZA==
X-Gm-Message-State: AOJu0YySr8Y6pOPGPOL1Fi1zCg1ICUg5j9GfJiWncODAUK1pEMiVzs5o
        4mnWlUxHDKLjvCRQ120PXB83zA==
X-Google-Smtp-Source: AGHT+IG3GZGYn4y4YYm2tHG2D87ap6X+kqIa27ZDbVHHkcGLK1mHElj7VKWjYheX7bdAtLLEJpdQnw==
X-Received: by 2002:a6b:e70c:0:b0:7b7:fe4:3dfa with SMTP id b12-20020a6be70c000000b007b70fe43dfamr10643360ioh.2.1702397618980;
        Tue, 12 Dec 2023 08:13:38 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id t1-20020a6b5f01000000b007a6816de789sm3012606iob.48.2023.12.12.08.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 08:13:38 -0800 (PST)
Message-ID: <195fd72d-2170-4224-9e8a-3b4b27fbe3df@linuxfoundation.org>
Date:   Tue, 12 Dec 2023 09:13:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/67] 5.4.264-rc1 review
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
References: <20231211182015.049134368@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231211182015.049134368@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 11:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.264 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.264-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

