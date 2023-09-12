Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A123179D8E6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbjILSpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjILSpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:45:20 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA24410D3;
        Tue, 12 Sep 2023 11:45:16 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41215efeb1aso40648781cf.1;
        Tue, 12 Sep 2023 11:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694544316; x=1695149116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LwP0PjfGirkQcHRrwmcD1ZMMizzqSK+BkgtwVm0vXbw=;
        b=IO0mRC/SWTENaFPmBjDHL0kGxyPxoFMgtwJyCmSTjB5YRPpfJGJ5AhP4tlL2OQz8kg
         7bNJJ2+PjRnYeqkVygKEsOHT2PEokSRaY2rdb0Ex5A2Gttmg/6hw+UvWQRqGUHZqRPA4
         oVp///IGlniWzAML9DhIOs5et0fanTvYelB7m0wa/erhQ7BpsBXHQJnq/lqBDU2hGu3i
         CZiIOWUu+BVHI9c/JkvxaKPK62KKsBuM0NCVuunoeRHvOw9ePi65U9x5myOE/Nj0fElj
         x6nKH6HYKiCUtwE7BZp1KqWb8Rb4IsLWAr6Z6wNUubIkc4HmMbf1makMo4FQW+1uVZWw
         vtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694544316; x=1695149116;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LwP0PjfGirkQcHRrwmcD1ZMMizzqSK+BkgtwVm0vXbw=;
        b=w4cCYl2pwAwB7G6X+Ie0ZLuJaQjTYLsv9msJmaCjJOWmCMV6Vq9Vh9BNLG1nEhBapN
         b1qrIR8LBP4WpDYgpVZ5P5X7PpX9mHPQzFdKZ/b4IeffeJM6n/fHm1aO+ykUn3ogqRp9
         7DbDmo5+pRAuoc0JnqXDLHGUUTcP4QvI7bRDb7b01cO/2LAUXcQbCDJB2eJxzaemdU+v
         670BPjfsJWy2uKL9azwNs60P/e9ABJVOv+2Tfg+QtQMCI7HkZ0wPzWEmRCN2AIW3qrxp
         WSCOvOimbbFhdFNAm7gbdvh4GLigT0mynKIYPqE+Yr74AW5PDsvMrvIuKshOqufI/yr8
         kPIw==
X-Gm-Message-State: AOJu0Yx6nXocU8dICkELfD9MZBVG47+XDU2RoQ1ZAgDpxmdCvnT5uN01
        DdI/hN4tZbM/TXGlOzoxFYc=
X-Google-Smtp-Source: AGHT+IHV4enNEE0L5vfcO799Iy8mcrNrYIFLo33dD07G7QXXpUiQU6T/lmRjwGW82dSfL8bcsHpmzQ==
X-Received: by 2002:ac8:5986:0:b0:416:5f26:b8d6 with SMTP id e6-20020ac85986000000b004165f26b8d6mr148319qte.31.1694544315827;
        Tue, 12 Sep 2023 11:45:15 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id o15-20020ac8554f000000b004108ce94882sm3475189qtr.83.2023.09.12.11.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 11:45:14 -0700 (PDT)
Message-ID: <f28114e6-e3b6-1d3d-891f-a2a09e127f02@gmail.com>
Date:   Tue, 12 Sep 2023 11:45:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.5 000/739] 6.5.3-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230911134650.921299741@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/2023 6:36 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.3 release.
> There are 739 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.3-rc1.gz
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

