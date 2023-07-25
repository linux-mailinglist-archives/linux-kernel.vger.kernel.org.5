Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D71762331
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjGYUUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjGYUUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:20:10 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51931BE2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:20:08 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id e9e14a558f8ab-348dfefd2d6so1417715ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690316408; x=1690921208;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=40MUKgtjMMfWxSa/m74WsVfeVnmCY+9HBtHb/gRtD3k=;
        b=aPdJy/KYrpB1XhTlr6DMJqZCCkTnu8b3a/C9qI4YWs6X/whBQV1X+NT99p4A6I9IQQ
         5lbDQ8yCorF2rfB5z5MBvxKDh7JU8BlZhaRjH7E3Zh/vl+6DU6HkfXrmnOdMSKgun7Ki
         efNcYISrsnc7HHMPRFWKDm+9KU/wQtEqK5CJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690316408; x=1690921208;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=40MUKgtjMMfWxSa/m74WsVfeVnmCY+9HBtHb/gRtD3k=;
        b=PQwezOe/fBZKqRO+p429mh6T1SwoIKJUIVDV0hLEWYuma+Q7mY7kfjYXvPsyksLdaW
         i1UwfDXZhbI7xr0Tj+Kz/cgyh/efK912sA9V3qef+e1VSUpLfOZ8Usksz3xdjj8rwWt0
         7jsbFtebdmjo9scxZ3mM6bPYO/lYiYJOZcuxMHvVtejzofLZ0Py/2PO3rRfMGaCfMidJ
         0QMIX33WmFOl55/iUTBNw/Re9NiSEeWKqnK7rxlyOIUD3zmapnMtiyIq6YsECkOZ7E2q
         LTSzuGd5eCSndLJj3fs/lFvw3uQGexK2z7KIoGY+5gnagsAneL0ixT1VR1hnai8X67CF
         /1pw==
X-Gm-Message-State: ABy/qLa+J0TanTWWoyBw3pfobJfyz8/gRV4VQl0DWcbIbixsy+BCELpg
        QaJHM3G5TsDXTGW8EUOgzhPFiQ==
X-Google-Smtp-Source: APBJJlG9LQOgy8uDv7rRlMRdHE7p3FLYilMaLnvNpNxianS2g1xSQOyieZOcAxmswBTLqLKpFsDRyA==
X-Received: by 2002:a05:6602:8c9:b0:787:16ec:2699 with SMTP id h9-20020a05660208c900b0078716ec2699mr10077627ioz.2.1690316408223;
        Tue, 25 Jul 2023 13:20:08 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r5-20020a5d9b85000000b00784315b7f86sm4423441iom.24.2023.07.25.13.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 13:20:08 -0700 (PDT)
Message-ID: <fccc1892-36b3-fcf7-e82f-294cda335b04@linuxfoundation.org>
Date:   Tue, 25 Jul 2023 14:20:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.15 00/78] 5.15.123-rc1 review
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
References: <20230725104451.275227789@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230725104451.275227789@linuxfoundation.org>
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

On 7/25/23 04:45, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.123 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.123-rc1.gz
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

