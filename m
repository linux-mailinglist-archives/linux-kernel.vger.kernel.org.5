Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C147D3F63
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjJWSie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjJWSic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:38:32 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A6E100;
        Mon, 23 Oct 2023 11:38:30 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-41cda69486eso22839831cf.3;
        Mon, 23 Oct 2023 11:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698086309; x=1698691109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wTZl9yJT84xQJpx2WB/28tP/KJ1wcwrESB4z0CgwnUM=;
        b=ZYZY4/yUbZCX8v087FrqFWrE9rcWWZPW18c61gmLtu7LFoyVpDPUpDE6z79tkzlWE+
         zihYbtFllTbbbkh5CnCi59KTOH/BKKwJ6yHyoec1naWyZFvBWmSSzbGnU0eeG7fNdfKl
         pdt3YLHZw4LV4ES/9/qW3iCWqwg02sBpx6U+s3HIHBK1+QwyO/pPi40iluwjDk+pXjxj
         HbDPULGdBIQozFYUIZ3HgB56IYzsje41M1znyb4iS4AR9oOd8TdixaNzftKn5yqjfKeM
         1HiZH8ASJmNt4Dkc+fVlVOx1rmeSmmTDLUjT5uECFXGrWwkzpj3UheIBWBrMf+wowWtc
         U9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698086309; x=1698691109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wTZl9yJT84xQJpx2WB/28tP/KJ1wcwrESB4z0CgwnUM=;
        b=TliYfTL3E0LDyyocm4pmk2icVoLKnR1+tD5VxJmrvR8aM/a/t1OG0FOZq+ybZagUFI
         d22ObT4nzz10gVMT+92qugftZBLn/f4HA5li6BSWiBY8ZbbyODuQHpX4bv0PGJXFh9aO
         ATH5Q2QUxt23LM9M5PA6B2SAVM6opoRNdUDr5a0v0cwS5fVKcbtXBddiXvTebz0B77+0
         A0RdPT2Uu19M1xNX/VkSl9Wime5CQseXiOprx30bwyxhKOZrP0YdUGsYCf5Wg7jbBoT2
         ZMQC6ffcJHuOLeHbz/joDA9lrLS58shMdKGeMLi7IFji6trLUaojZ4WZ06LXEgSTKGM+
         fhqw==
X-Gm-Message-State: AOJu0YxQcmsBsrq2S1UF+jjO6uf+77LpDaJUk++sondYCluOQvaME+nX
        wkAb0nI9OY+hZN/oDkPhlHY=
X-Google-Smtp-Source: AGHT+IHToWlKuJASqgn4O8LRF4ZwPN6hJc83KOFuYbmuwdpGW/SyFk+UKhYVZ/LqyYOZ+CfAbL3l5w==
X-Received: by 2002:a05:622a:189e:b0:41e:23e6:baaf with SMTP id v30-20020a05622a189e00b0041e23e6baafmr1897712qtc.68.1698086309375;
        Mon, 23 Oct 2023 11:38:29 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g22-20020ac84dd6000000b004166905aa2asm2889080qtw.28.2023.10.23.11.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 11:38:28 -0700 (PDT)
Message-ID: <d2cc0c5e-1f33-4c47-8822-a90b62d7a3be@gmail.com>
Date:   Mon, 23 Oct 2023 11:38:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/123] 5.4.259-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231023104817.691299567@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
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
> This is the start of the stable review cycle for the 5.4.259 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.259-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

