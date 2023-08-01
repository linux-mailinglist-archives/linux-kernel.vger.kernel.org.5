Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A98676BE46
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjHAUIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjHAUIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:08:16 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB922683
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 13:08:15 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id ca18e2360f4ac-760dff4b701so73447439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 13:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690920495; x=1691525295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qGwXx3KOfKZdlW9q4qIboZeupOtTw2c7/yPWU17zfUY=;
        b=cTmSS8ZCb3+sHnVnW+0ROnlOAFrjtMNiSg4vWSXaQ7eEiABh/knJcF6+qc41JWMoEb
         Ge5drTPwhRhrEjQO/+4tixsrBxjz3t73WLoU6lsD5JknlzjX1oxhkiuszFdOX1cAjUIx
         MDAOlmEP15Mx5lb3xrh1HTpLiMWDiU7H/Ncq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690920495; x=1691525295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGwXx3KOfKZdlW9q4qIboZeupOtTw2c7/yPWU17zfUY=;
        b=lrecIKBzKVguA1UV0Jwz+cVgvEjcPl59KbRtNxrzcV/iTuGRPuwYoj2hPnBsBNYuS5
         9TFisSOc0Q5hnmpUSqwHVWeco0luM6i71XZGkC0blKjMhpbshUmwoHVopBkQSeHQb0Wh
         /fs3qU6uoIs/Cd2+Hm0dJq1mmvACuQr6miBtvPvLIkzCceqEaRaukaJaRuReL5oTXXz0
         dEJON1NdslWxbQW7kD3I/sxBk+otQPu7A1Ea1M+tDiZX79MM+PFiZlhRRjdjegQjHYFt
         Qs333fafA8zjNWcneEldg2ZLJ0z8VUVqcdpnt1OTYrt5xZSwF/TB7JwpuTXFSDYCi9LK
         sMVw==
X-Gm-Message-State: ABy/qLbZWxPZkkd3dWL4ysODLnW1S7B8QDP5bLA49hIR/Mym/fcATKWa
        g1v3KIhMORZ6SPdf1RHGabM8dg==
X-Google-Smtp-Source: APBJJlEfXOObYKBwXKqr86KaNuXOU6D7KQEKoOJ2zSv9v6mNaZX5XkMSztmkOL3XIqru6Hmri1r7LA==
X-Received: by 2002:a6b:c3c2:0:b0:790:958e:a667 with SMTP id t185-20020a6bc3c2000000b00790958ea667mr8992208iof.2.1690920494927;
        Tue, 01 Aug 2023 13:08:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s4-20020a6bd304000000b0076ffebfc9fasm4161813iob.47.2023.08.01.13.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 13:08:14 -0700 (PDT)
Message-ID: <87daf7ca-7ae6-1a21-90e3-5b109c4f3d12@linuxfoundation.org>
Date:   Tue, 1 Aug 2023 14:08:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.4 000/239] 6.4.8-rc1 review
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
References: <20230801091925.659598007@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
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

On 8/1/23 03:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.8 release.
> There are 239 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 03 Aug 2023 09:18:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.8-rc1.gz
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
