Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207567BEEAB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 01:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378947AbjJIXDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 19:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378152AbjJIXDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 19:03:41 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F242AA6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 16:03:38 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7748ca56133so46444439f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 16:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696892618; x=1697497418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=isNibIDfjCBz+AxQha4Vz6XAmq4W2W0frOEb93LFaIw=;
        b=cRi4SLRTfIaHKGebtDHxeVhrkDaNmTO2X+km9MIRI2HYPR21jhg/hIgyVEXTx+707S
         RJpr0l3A59dqpSZcLHFk6ysiDA8a+iMo862CTLeqEW7QZLiCW7fPB0AxOcmd54fXlKEi
         j4nctci4/zt7smJ2dctZDvoANZTSji5o1FYGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696892618; x=1697497418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=isNibIDfjCBz+AxQha4Vz6XAmq4W2W0frOEb93LFaIw=;
        b=rJOI6tgn6bzMr/eZHWNMSW4XnwVOYWVU1t6EB5uwLYidPIaA1vGTm9oZmztjxCFjQv
         3RjQ+bOWCO3Vp0wcUvt/uirRMOEpHF6Mz88cWZGt3PAAyZOHCCSDQzgN6zyrmh8jUxwQ
         XFZZhqlYw3LX2Csrqlo2TSgsbS+6xBImk42KPeOTeIF2JzIp17TByHT+OIAyhFDlYmGl
         ocW3O9rlvVFXfBtMxT0w77REWRU0um7faUE8/YmPHBuJIJimrrzJTE2H5gmj+URRHAfC
         pYNVlR6fObhfizSd4D8+X0pw93k+zJ+gHE8Ip6Y0vm8+xDA/OkSE1tc3KK//BanZOXXI
         IKCA==
X-Gm-Message-State: AOJu0Yw7WA/NQAvIdPpJ4GZDNNycmSM3PUEwj7cJ4Pf/8ZXFfgjJblZ0
        Cl7UxrCDVP3KbrZaqa+5WJ51Sg==
X-Google-Smtp-Source: AGHT+IFC7dB+rmhJK94YvLDte9VrWpF4MStdv3nT+6mBzwWpLQzXID6OdAsgCEfdl8dnfczLe/bLCQ==
X-Received: by 2002:a92:dacc:0:b0:34f:b824:5844 with SMTP id o12-20020a92dacc000000b0034fb8245844mr16033525ilq.3.1696892618299;
        Mon, 09 Oct 2023 16:03:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c4-20020a92c8c4000000b0035134215863sm3150909ilq.55.2023.10.09.16.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 16:03:38 -0700 (PDT)
Message-ID: <e60e435c-892a-4d9a-ac46-feb7b49b7f18@linuxfoundation.org>
Date:   Mon, 9 Oct 2023 17:03:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/91] 4.19.296-rc1 review
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
References: <20231009130111.518916887@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231009130111.518916887@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 07:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.296 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.296-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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
