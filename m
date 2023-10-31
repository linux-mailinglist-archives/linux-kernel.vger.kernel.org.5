Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9CB7DD92F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 00:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376877AbjJaXQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 19:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbjJaXQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 19:16:14 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15510113;
        Tue, 31 Oct 2023 16:16:12 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77063481352so27122085a.1;
        Tue, 31 Oct 2023 16:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698794171; x=1699398971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=atmiYi00WMCyp7aFMPt4w9sGV6FatXJOBSSrDMaqG7s=;
        b=Hq/JiYbwXFukMP1+7zUH1DcR4YOqqpgdK+FRlnf1xU42Q8tcGkwWxvi4fU9ytU1+3d
         PgZGg2QMO6vyLAm7WtEGQqnEZW1sj1r5wUaIioq43K70KAqXIHsvyCXoYxGvyo23hhXy
         KlRzks3YbOpOSS5muFQ+FP0hclCIj2fIO9BX0ruiasHENAmKikiV+jm2BUQCRtCygoSD
         GJlVGEF6EUHnmHZilvBsQqHluBfhf648ovVxb/1PazO6oEnvVRNU87pwbzy0+GDnI2VE
         i8ONSVcPO6FJSXSfwtN+xSRLbX1secNbUuM6KDkzKWbsiyVdbH1okIaU6OHcteR8S2xa
         FY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698794171; x=1699398971;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=atmiYi00WMCyp7aFMPt4w9sGV6FatXJOBSSrDMaqG7s=;
        b=Vd75MJSwU7RD8QR3RMh+asoHfJdSWPW7K2Ny8fKaZOVbKHOkjM+hWfbaSHEVgd66UT
         c44ygHore55mXKTsrhUx8lxHqeFEa3Af53jPGyX4HdWB/hnX8CiIHMSsg3tPZNHYuuOq
         94HI+aZL88BiI+B2qZVXSD1ItiqyjmR1H3nahQimmjcnTUa5KOSHK11c8+kpzHJEJtY4
         Yb0rX0+j7x6EGO6w6GUAIdpw1yTt0D67MThkRuqTQOyiT1WZYUtovbXNscrk+1rXBEUJ
         xeK9tp8d9Xknb36wmHNFLRKD/hBvwXXuUoA7BWTiSstUjOeBaSrFvAvZ32F/W4jGjYFH
         BQ0w==
X-Gm-Message-State: AOJu0Yyofu2WSlx8EDemF+r6gGuM5N3D6KqcRHjeT1R/zadFNXrn5Jkf
        6W70uUCKqtbJfkXv3jLtFrg=
X-Google-Smtp-Source: AGHT+IHzClK0Yy/DDg5jbTwk9MzhOqMDsSgvTkzwRWZOi4OOOoM6R+CxLmO15DBkYC+qiQUZ27zW4w==
X-Received: by 2002:a05:6214:321:b0:671:560f:3306 with SMTP id j1-20020a056214032100b00671560f3306mr5041211qvu.4.1698794171063;
        Tue, 31 Oct 2023 16:16:11 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id dc6-20020a05620a520600b00767b0c35c15sm912709qkb.91.2023.10.31.16.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 16:16:10 -0700 (PDT)
Message-ID: <2cc5b202-f024-4fa1-a2d1-577fe463d633@gmail.com>
Date:   Tue, 31 Oct 2023 16:16:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/86] 6.1.61-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231031165918.608547597@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
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
> This is the start of the stable review cycle for the 6.1.61 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Nov 2023 16:59:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.61-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

