Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C6079306E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241937AbjIEUyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236667AbjIEUyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:54:45 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C059F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 13:54:42 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7950d0c85bbso22449439f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 13:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693947281; x=1694552081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UVR084rR5RH1R/uQ9mTd3tl74UrOU5b3+sORgEFRSn8=;
        b=ibzcaezzAezofsPJiw9iR3FFfPxMNpUJ68TGgwIuGEfhGoFBaYs9KbknbD7qAElc/u
         5h/k876Gr/F6SQe5TWi3zOtMxWOLx5ZkK8ZodpjmvxfzaR+7ESQAxZeR5wqTFaWnCrTy
         DvRVa6zGRNv4fOT84rytQGldPf+pfqkxsDJ7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693947281; x=1694552081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVR084rR5RH1R/uQ9mTd3tl74UrOU5b3+sORgEFRSn8=;
        b=Y7q6Rk5vMMPiZ15ZxortsV12QWDeVT6C2xhCr8PCwpn8RtsYxTN6irUste7vSiSdl1
         PH2PtcTqRQxp7BFqK5yn4y2U9vmhROY7U7cJ3cbiBOo6QKLfYJS8ObWUkQd+NC6X+LUO
         hQeSPnAr3fEUFFTw87Doz64ZtkTQPqv+XY29pXBDo3G7Fv2Bk7D1BIVBJkcZ4HDLLGrs
         LGQLaW9QO5fghlJwr2phDgqtT8niAVDgrgicjKx4FiMOw7Hth2IO/Ynv25gKoaAt1uqk
         a/Peyo6/vjJ7Y2/xhtAAn6LB2v3rvWd3svlLBNVdef9WVaM/LwOGjwbmkusw20KDRkjx
         +E1g==
X-Gm-Message-State: AOJu0YxQq9QPXQdS7zrYhbZObX/vtAvAQlxIza7fI4YmSUaVwjoPCBjP
        1tQR2r1w7agBQxjbZYVL/gpkkw==
X-Google-Smtp-Source: AGHT+IHIIrUy/PhIHwld2vNpd1q5Dv99pD5KOfcReJmDcupcmmT0Ucx+K1vnS/bAoXk+c9GG0Lx7Sw==
X-Received: by 2002:a05:6602:3e96:b0:792:7c78:55be with SMTP id el22-20020a0566023e9600b007927c7855bemr14393908iob.0.1693947281724;
        Tue, 05 Sep 2023 13:54:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x20-20020a056602211400b007836e9ff198sm4454637iox.55.2023.09.05.13.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 13:54:41 -0700 (PDT)
Message-ID: <a82772c6-eb0a-f103-936f-e0201aba1673@linuxfoundation.org>
Date:   Tue, 5 Sep 2023 14:54:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.4 00/32] 6.4.15-rc1 review
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
References: <20230904182947.899158313@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230904182947.899158313@linuxfoundation.org>
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
> This is the start of the stable review cycle for the 6.4.15 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.15-rc1.gz
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
