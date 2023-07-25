Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E1476244B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 23:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjGYVYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 17:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjGYVYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 17:24:45 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4989F1FD2;
        Tue, 25 Jul 2023 14:24:44 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-268030e1be7so1511063a91.3;
        Tue, 25 Jul 2023 14:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690320284; x=1690925084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DdGMZ3nhAKvZh4BY9rcT4I0j/MWs6ecPuO0p3nOu5rE=;
        b=bXxSJZvblOKlLAgXGnD6CioO9LiWP5Dn1MW2LVqZutjTfDHbabWhItozvlSWlDsFa+
         C4rtv9M0CQEn2oWgGowUbGgpOJyBp0OauQe0NxzdOtOf2oiyg2PJm6e9sbu/CKdjpuMQ
         XAku9m0JPM0Obr9kR9ugRj3GNmZoQC6X1emWuO0+fSDiphVDxFNKP+Cv5QZ049yf5M1h
         O1CnBI1lGrf16f1uS7zMN4iOXfjKZ2I66B9jLnWd8w8cTq77JOwY/v37XmOuSfNco7/d
         xd3/ax/K2fu6MVCy6CTOYYjK/weD8JegDnuLK2Sxa/Gl9u+Ldg3hbteUowQWSJUuJpm5
         LzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690320284; x=1690925084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DdGMZ3nhAKvZh4BY9rcT4I0j/MWs6ecPuO0p3nOu5rE=;
        b=DQVFCvFuwidQaIjsPiRoNuyFBMlAgVK6QvRfx3YXCxiu9bqq4E9FVa3OE1rsqpIRZk
         wuAyZKS0u7P6BFZgAM9xY1nYx/YnEWI+P3icXWhNPuUSAfCpxXqTM4POEQP7Ar8lbAKJ
         +FmmdpyPVHoQYtr/FNt1wXWrFwdDufOZBIuh5pDO5X69/Vl+Gdwiietd7mngSc1+S2qa
         u1ZnAsUkSjq3X0pkCWR+lD/llm0XXXBdvnARmxYhXuAYvtc13EZptTD/heJltfaodbXc
         5OvbC0RAzV/lzRJ9+KOjL4044dOrH7Fz/8N+AoyJj9VsdHhvH12D3jnlrt9GIF1ndMNS
         Rmeg==
X-Gm-Message-State: ABy/qLYDB/WjWCe+6oUM8k6woWvK4Ah6ch/h/ZdWmlRmUOdm+zYBafOD
        x61Yw81tkea9V0fAzpfCF4w=
X-Google-Smtp-Source: APBJJlGfxPTf6vGPHwdCOZ2d046ZKGCGPMNe9DfRIkw+7ghicaW796dobYiDSByaxl43MNNWDEUopg==
X-Received: by 2002:a17:90a:a607:b0:267:faba:705 with SMTP id c7-20020a17090aa60700b00267faba0705mr303108pjq.10.1690320283675;
        Tue, 25 Jul 2023 14:24:43 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 14-20020a17090a19ce00b0026851759e9csm30706pjj.29.2023.07.25.14.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 14:24:43 -0700 (PDT)
Message-ID: <64eca0da-dfe1-fb61-27d8-1e873bfb6a66@gmail.com>
Date:   Tue, 25 Jul 2023 14:24:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.10 000/509] 5.10.188-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230725104553.588743331@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 03:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.188 release.
> There are 509 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.188-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

