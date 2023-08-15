Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93A677C4D3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjHOA7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbjHOA6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:58:53 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A91A6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:58:52 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-790af3bfa5cso58197039f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692061132; x=1692665932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JdivT+33ubXZzmbj3HnlgDDmTGKoaEP2PiuRQnajAEI=;
        b=cGvE9GsutE2vGYYLpoxtruRo2qx9ju2hC/VOKsBKx+hjTZ0gFAM7YkJa3PRC4/r7KV
         vvYYtxrkOXxnJVkL3mynprvFKoB8yaQbn6vU3TTZPN+tWtr0sGGbuBKOssHECfc5aw/3
         APoe0ydN+Ak1EuMJXeKCBUk5EvHv51FyxryUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692061132; x=1692665932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JdivT+33ubXZzmbj3HnlgDDmTGKoaEP2PiuRQnajAEI=;
        b=KV4c3oJAouSZSH6SHtwMQU+ZzLFbSf3rhZecGv6hfznZjun9d6+mi3s1zMQuVuE7Y6
         QPIaTeBsFRdJQft6V03Qz50Vwv020LNcAuGotoyuorBKqW4MMsdclZVpRKM1WXFfhBDq
         W5myXN0Wgfilnx3S09CE2+1zurch7prZnmzeUr4p25spW33ajYxhXoPuZbLUvfjdL6Ho
         9FUoIWsj3AXflbUFP+IvdX3EEpZLYRqnR5i3kwSems3PJjz9Pt39mDguHey2RYZcfyFP
         uCuh44gGgXhOIn3AktMdxtrbpjhKpK9oq8cB6gOdDchB0kFT7gfm6MHnug94TVdxPa02
         ypVQ==
X-Gm-Message-State: AOJu0YxPjcFFQbn44RAYwz3v1cYUEb49P2ZiqVMF4474ZR5XIOyhHG+0
        w12NkF8KafIKiL8zp5JK1aNMog==
X-Google-Smtp-Source: AGHT+IHt36N2MvBksFyBSjcoO4rMuJi6SleshEqYhq1CbDLN0rp02f75O2SYsrbxea9QmpkqI10Pyg==
X-Received: by 2002:a92:c74f:0:b0:349:582c:a68d with SMTP id y15-20020a92c74f000000b00349582ca68dmr11073016ilp.3.1692061132197;
        Mon, 14 Aug 2023 17:58:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b21-20020a029a15000000b0042b0de0b976sm3228805jal.154.2023.08.14.17.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 17:58:51 -0700 (PDT)
Message-ID: <0ada8b3a-0e77-41dc-a7a9-f12c112c0790@linuxfoundation.org>
Date:   Mon, 14 Aug 2023 18:58:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.4 00/39] 5.4.254-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230813211704.796906808@linuxfoundation.org>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230813211704.796906808@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/23 15:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.254 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.254-rc1.gz
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
