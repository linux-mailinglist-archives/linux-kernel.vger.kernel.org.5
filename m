Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EE97DD940
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 00:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347406AbjJaXZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 19:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbjJaXZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 19:25:00 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A50DE4;
        Tue, 31 Oct 2023 16:24:58 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-66d264e67d8so39867796d6.1;
        Tue, 31 Oct 2023 16:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698794697; x=1699399497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SDESU+0pFHKDRbJM8m3kaLz68UPQM8PiOfH4nRsFFEo=;
        b=MQS+KxPU7lb83ewQPo2vOGCf0Xyd/3CASg2rluGLPzDxBcsR3tgFwfdl/XjwYJZbdx
         x/z/PF8i4LvJQVdx/06oDa0yhdjWq2kNM/MlXUDV8yRwesu9umiOxvDhb6MKBgqq78ax
         z5OpSO2CTygqCM6cC6jlJ0ZQ56pfX8v1uov/HXgrRYiNHZ/KqQgqTUMcYdGsXGD+VixR
         ud9J8geY+EHKnDLs8MiMI2Yw3+gtcd6r3hcKnq3/Abjoy2XNY932m/jCs2mOZg4TaYPk
         BWtfCF/BwCF8tcEDA86/oIAiUxeLPK8qHffIpFRELydemrVrG1BdQOA/QBNqgFVHiGrA
         nrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698794697; x=1699399497;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDESU+0pFHKDRbJM8m3kaLz68UPQM8PiOfH4nRsFFEo=;
        b=jXE7A6z0d1+tLhFGpaJioRyf+kmhtL33UZWWhxPPB7ayNOtf1Jkwwbx9G6dH3QcY2T
         dLj6tcHVMuMTkMqWCd4FLuX1YxTBqe1hC+11ogKDbdmMgeheB0D3qMs7PS8R6QaFajN5
         8ovlAkU4nSWO/WDB+8W8socpe1JvDydvsiYsJwkgaeg9mpMGfrjE8uCtPltYVZbBulDz
         REg54PZk2GPpuaJ2B+lETH81uY8KF371kgWQ/qkHoLUONI+MqMFrxJrA1FBswAiq/JMa
         gojFKzqoJvs45OrO828EZ6/YDDC8Zy8y2XFmLIZPUT3yYOhSrSguBLSSMUhlF9aa6JWE
         jL0Q==
X-Gm-Message-State: AOJu0YwLMfO3p7JURMAQBXtM2VU7XabACABLSLSXkcnI9jNkoeKHCreX
        86Uc0V89Ax8SFMHO2KXzi98=
X-Google-Smtp-Source: AGHT+IFHo/AJFjlo72eI+SRjYj16ZaiSwrTUmzEVxbrNGknpE4MeJNX7h1SIVL6IWnpdDNp1NM5HFw==
X-Received: by 2002:a05:6214:4103:b0:66d:1624:2200 with SMTP id kc3-20020a056214410300b0066d16242200mr19108430qvb.13.1698794697271;
        Tue, 31 Oct 2023 16:24:57 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id dw13-20020a0562140a0d00b0065b13180892sm947489qvb.16.2023.10.31.16.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 16:24:56 -0700 (PDT)
Message-ID: <9834c735-297e-4b70-9440-ab47a9118698@gmail.com>
Date:   Tue, 31 Oct 2023 16:24:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 000/112] 6.5.10-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231031165901.318222981@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 10:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.10 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Nov 2023 16:58:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
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

