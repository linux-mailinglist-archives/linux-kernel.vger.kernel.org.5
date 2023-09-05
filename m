Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7BC793067
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241536AbjIEUxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236667AbjIEUxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:53:16 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ED3113
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 13:53:02 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7950d0c85bbso22430739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 13:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693947181; x=1694551981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6lzSXNiIgkt0RVCFcTX8x1K9L6RQ1Rs9EBt4A42ozfk=;
        b=fI4y605uPFnT3zDtr1J54xh5bOPtS4Zw62EAhW2kf9KGCcWOq9bZbdy7qqzBfbg3Pj
         LWPT1d+waDy8D7tqORXYG0b154oDJgkebVB0Thg1VJ09j9L5S/0nRdkT3ZY8mBXVhm4J
         JFHoPxpfCfTZCffFqxBk8apHdZCDmELEbDsIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693947181; x=1694551981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lzSXNiIgkt0RVCFcTX8x1K9L6RQ1Rs9EBt4A42ozfk=;
        b=NLbl2PEq6yxdXgYCaqmiydVCipk3dqAcigzpXr7lC/35H+JCLFtORNrPN6kZV1sNHw
         iOge/TrgbH6l2+rNlFPFb6PsV7SCw4I/8XizfqnZPeu0is0oG7ABDGFh5Lw/lT7i6qZp
         mRK2bhknIocba0oqpqXZSk/RSdT1YxO3NUpeIWFTZgfpc9lQIAu6u447TDbXDRWoIRCb
         UEbCxhvAMQXX6ec3QvZgK83DCa9c0e0qjvS2t92+6zTRlWIO0IQboOLNTzjEdamY5Gyg
         w3OpfOlzmZsHHyFxryrvOG7pgDvN6GfmfWUxJGs8oXU+ZR2mFTUj4bxjJWeBQARRbMGX
         SQCg==
X-Gm-Message-State: AOJu0YxpEC7FXikCUTDw9ppUvedyt/dY2v11FLwTem6mUxmemXjf9dOP
        zxsh4H6Nui9qUFBFQit5UXiCaw==
X-Google-Smtp-Source: AGHT+IETIvXknVtoBD5RJ1GF5BtEo4yZSv4IRdlZbL0D/WHeAnx8eXCUPaupMBCrwoCjkVAoQ4TZdQ==
X-Received: by 2002:a92:d952:0:b0:346:1919:7cb1 with SMTP id l18-20020a92d952000000b0034619197cb1mr13220494ilq.2.1693947181552;
        Tue, 05 Sep 2023 13:53:01 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r6-20020a92c506000000b00348d652a6b4sm4342171ilg.48.2023.09.05.13.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 13:53:00 -0700 (PDT)
Message-ID: <f2a12e3f-9c82-90c4-829d-5b814cf6d449@linuxfoundation.org>
Date:   Tue, 5 Sep 2023 14:52:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.5 00/34] 6.5.2-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230904182948.594404081@linuxfoundation.org>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230904182948.594404081@linuxfoundation.org>
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

On 9/4/23 12:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.2 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.2-rc1.gz
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
