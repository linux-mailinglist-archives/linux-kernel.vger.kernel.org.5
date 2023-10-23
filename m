Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937FD7D40DC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 22:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjJWU0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 16:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjJWU0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 16:26:38 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDEDB3;
        Mon, 23 Oct 2023 13:26:36 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-778a92c06d6so229779885a.2;
        Mon, 23 Oct 2023 13:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698092795; x=1698697595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0oKSEdBXUqRCSV7Bxm6sRKTF2Sn9JAV4Bp7UbQh4XsQ=;
        b=QV9Aa4qZS0vi06JsREnAe5M562mcQNjoXeNjCN7HWPBAXa+ze4UJP4LdZZVdesq3og
         JAORG6AYjRTJTfCX6l0DcV2qoGoNTTXRC5z2NkJhXD4bndx6QsHQKIoJ3nBV8h8hEkKk
         imZ88Ztr/CYqjX3aEB3c3xnQSvoCL+2+Gl9W3Ml3QIkJPEFQoPlhg4qGkKc12wvah97d
         qKlJnjKHogP9e8la6gxl62HzEUkpdQAGYZcP7UlaiFjlmDuJ2TApP+hOfCqvQ74r4oXt
         c4a2Dyg2XtNd/BPDHlw1mrH8VryzNSMZo98iySxlbBT1tBQaGh9CdX+Ka+7nNHihkg4n
         iWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698092795; x=1698697595;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0oKSEdBXUqRCSV7Bxm6sRKTF2Sn9JAV4Bp7UbQh4XsQ=;
        b=QamjX2Qa3AZ8QMRz5SzRUdc+HOz1Lz/pBODgBKXIF1M0jtuGVhSuNrGr7dbYd+SDEp
         mPgtUmvgsSREJeb8g9uByxTBC8L3x1HwOIxqXwkdx5aldK9fW0z+WZ80FdRRpW8K9frB
         uK7YdimL3qHdNhgjfF+4mcsaakGKsRWp2iyYuNw9R+YSlY9be629LYAcUFtUSX77VBTA
         YTmjTMFZsNO86uA1bay/Ovqx+v34u15FW7oys6/QnwpnoYjWuqyID/H6CfmPMhRjVmok
         09oRac3cNTb/8EdHwKP1Tt5uHwPxbUynzFhzLkI6HBrkHQW0CPE3CtYu0T614Lmnn5Mw
         mgWw==
X-Gm-Message-State: AOJu0YzKhcbGqOOqwJ8PJjOw3tWixG2tuYXR2g/Ds4/jamcN8JYrBg1Z
        a+qtXvPAEfLtMdfs2bpGgD0=
X-Google-Smtp-Source: AGHT+IEsjf5/mz0myw7K9E10LXvqraHROlIr2wrSuiRDCCP+eXRLueK1ieTQ76Bhs+alj45uShMm/Q==
X-Received: by 2002:a05:620a:1009:b0:778:9836:3ddb with SMTP id z9-20020a05620a100900b0077898363ddbmr10144992qkj.34.1698092795350;
        Mon, 23 Oct 2023 13:26:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i7-20020a05620a0a0700b00767d572d651sm2963285qka.87.2023.10.23.13.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 13:26:34 -0700 (PDT)
Message-ID: <83337b9c-35c1-4a90-a822-3b320ae8afa6@gmail.com>
Date:   Mon, 23 Oct 2023 13:26:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/137] 5.15.137-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231023104820.849461819@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/23 03:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.137 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.137-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

