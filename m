Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2784D78F43C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 22:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347441AbjHaUna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 16:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238671AbjHaUn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:43:29 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201C11B0;
        Thu, 31 Aug 2023 13:43:27 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-76f08e302a1so80071285a.1;
        Thu, 31 Aug 2023 13:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693514606; x=1694119406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ZEkpgI+1xGvtb5oOFsSrJIyIMnI7mF5GQF81tetMAw=;
        b=Ytl67oD2/ZL7Uy7qwq9htEvDIi8SRgWFjvfldChBUF7TES50M/0956dTwgp0nnBSJd
         T5AHik5dpG8fj9FhXkgQ+XVVwvx0B+seVoMj+4GR4tOfu/hz8NH6kloufEwhbzhp6T/R
         fs9UQdRUBmu6vcHFV1oe87OACWytmP43qnN6fuUYyadxRWraQwthibGsO+EWe/9Wx7CQ
         /KexcCen+WedBhYD/4+KfLOMpu5N98of8u9oFxjOgxBHJbE0LuDRLqPc2X+yPqXHjyCz
         uUN8uR0o9w9sNQNYWFuUCo5ewp/AI1hbrtbV1ogGI7p4GijJJW3ViHSgWVg8R+d6F7SX
         b9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693514606; x=1694119406;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZEkpgI+1xGvtb5oOFsSrJIyIMnI7mF5GQF81tetMAw=;
        b=alyNMCdEFaSHS+I4AP/BxQ9K+DN0MNdD88RZeq79aQ8dzwqC69nDXpKuRHmAQW0Qop
         WXu7oHVGJAqwVrkZHghLEMsNOxZofmvPkndnd/+WDTr7gM8ciuxkEWlkwnmlAA35O+vs
         9gX9MZe/8yyBwt7+uX5SDZACFNZu95tIZt5+YxCUva0bO/Vaclm6gtMDAH16LMoWPuRO
         iMsGNVvFKTzXytqB8mY2ZcOwk3dSEZob8nAXduz5M29sfQbHYtS7nT3cuwtBoSYPy6ll
         Z6dCIe+jEN7En/+92CTIJiJSGqCvnhLZUL6V9kFgAxA9uZJSquKPwB/novek6cpami7F
         eA2A==
X-Gm-Message-State: AOJu0Yyj+WkLyT0tp9ZO94kfAaCe1arJzaI+y/m//hmTqVocCAgpUY99
        ttSYHt6eQG5Ys1ErtN2svoPLExGd+Bc=
X-Google-Smtp-Source: AGHT+IEp+IPzo0Pw0JG0bt36rjaOYI2aqAxXTUBCCt/Bq5AbEV5G3X1iHPGrpD6JDmVg+1XHODRsew==
X-Received: by 2002:a05:620a:17a4:b0:76f:27af:2796 with SMTP id ay36-20020a05620a17a400b0076f27af2796mr627289qkb.60.1693514606114;
        Thu, 31 Aug 2023 13:43:26 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id p19-20020a05620a113300b0076ef40734c8sm877942qkk.79.2023.08.31.13.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 13:43:25 -0700 (PDT)
Message-ID: <890f7c2a-f87f-308f-fc77-cfa9cfef53f0@gmail.com>
Date:   Thu, 31 Aug 2023 13:43:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.15 0/9] 5.15.130-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230831110830.039135096@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230831110830.039135096@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/23 04:10, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.130 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.130-rc1.gz
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

