Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6E57BEF0C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 01:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379025AbjJIXYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 19:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379014AbjJIXYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 19:24:03 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508F79E;
        Mon,  9 Oct 2023 16:24:02 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d9a516b015cso294452276.2;
        Mon, 09 Oct 2023 16:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696893841; x=1697498641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ey8nM6Nn9aQGlr1wJTzUAbOZq2jE15XKD/B2tE+waEo=;
        b=ILSVMRlQM5zYWMtS7xMOEEbVIAaG0cpuE+WG2HjdxSbLvbNHtLqyaGQw1HU8R5k9yM
         4fBMjnZrEYzM/B9slEjGnSjmfHEkLFmjQSbgHnhypBQ01Kka9dDNAwyuHMsmtnu4o6lR
         3xQ6OZ7V5KU0SbDRqojctLgx9MnqvDkhNGv71gTpeuUVEnaf7NoCOmecSKAZV44t1+cy
         j6kfFbX2pSkYcTx7Wtu4qlniJpm7Gd/LsX63/TLZWO7xyvxe2SNOinNSJrPiKjUIrJMY
         cN8nWJo/T7Fq/CfeRs2Ar9OC1FJOX4dZ3DZ70MLF6vYb0RJHgMK3+APFllf1SnLubTaN
         pcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696893841; x=1697498641;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ey8nM6Nn9aQGlr1wJTzUAbOZq2jE15XKD/B2tE+waEo=;
        b=D3RNbtvjS421mCI5MSXsCMbRe9UARu+PB1CroUW6qfVki0TQGRDBmDhHH3SHFjtf3S
         UrmJUD3OjnY1CoRBbgLCHreAYdB04j3TwZ/nIFHjAMmU65Khbr3WoktphB9v5IFXecVz
         2xbRr/SRRu5enAZPBq02ml/Cr4QJic/WTZlfbXf/NTmgJ6LZeYOuOniAJU6r/NqO79g3
         u8FCkuZ+sjLmJzg5dOsZ2OzxtzmP+O0TYf7g9zgRqrer6QRHzWhzrmm3xtr+Kl6yCZMt
         WxnyqLz3xrGF/7ej9OPm4umg5NUYstqGAV6eka70k1Lz8x7wMGASNSyaxqcMOeWeyJo4
         scng==
X-Gm-Message-State: AOJu0YydFtgaqcamQUMVVvS2JRAzh4wJ81dyRl5DD22H9U4ACdTFnGs7
        IzP5ZlWYCIVgAsENBNBvBZQ=
X-Google-Smtp-Source: AGHT+IFZ6NjcILlhoL/fa4Ls67nKjcWAeUKBMb3C0lm+DoOQsAvLGSpfkgK+SC2Y326aFuGZOlpW8g==
X-Received: by 2002:a25:b17:0:b0:d9a:5021:4f34 with SMTP id 23-20020a250b17000000b00d9a50214f34mr723745ybl.15.1696893841394;
        Mon, 09 Oct 2023 16:24:01 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id e15-20020a0caa4f000000b0065afa589bbdsm4220141qvb.66.2023.10.09.16.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 16:24:00 -0700 (PDT)
Message-ID: <8ff4a55f-a4f2-48d6-af5c-3f39884a1730@gmail.com>
Date:   Mon, 9 Oct 2023 16:23:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 000/163] 6.5.7-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231009130124.021290599@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 05:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.7 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.7-rc1.gz
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

