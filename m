Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC2076D972
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjHBV0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHBV03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:26:29 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB2AE6F;
        Wed,  2 Aug 2023 14:26:28 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b8b2886364so2651755ad.0;
        Wed, 02 Aug 2023 14:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691011588; x=1691616388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vpxv8V9L5JZbPZfIFzQxedIS3P5Jxl68SXEqUp5VX1Y=;
        b=X6WSbmzaTIAv/HyInxOx9KeKlbuu9qh8gZsOBYMIUykFA/ug53wGtt9o0XTD2lkmTc
         ljR5lXKVVZeAIvylCU4LYiWAIxc55b9bE9LMZpb4oQ8fudh5x2w1WSGbz1JLCRpJ19/q
         moU7gWPvm+vYtyiG2IRP05ydm65gmrGOx0yirkOhnirpqfYnMJRsbiLIcwUzpkEB9Y3d
         EqX97wClSGNXXrRqulK/HrlUNk2vx30wbiz0q11Alfd0tYh1cnszWdN9wMMOwOLvrBT1
         J/PazZwAi+wvfehWkHrfIEMzDVSh5wwUb8KXSP2U1Z59R5ywT3FSJY0lFY2esxpdxB3R
         RizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691011588; x=1691616388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vpxv8V9L5JZbPZfIFzQxedIS3P5Jxl68SXEqUp5VX1Y=;
        b=FXjm67PEH2lHlVZInJBzlLjrrvMy1NpGiEQs/wl2ZV6s5n6F7SGt2Ucgwo9cCzGS//
         l+hcDyhAU/afOjKHUWGVwAa9+hIZ3vFxlUt3vwNfXXqQD+VBr+2g8qKK2NBYjIeQ7l+t
         igQLsqblESgrGsMiQVL2RZecV6R7HgQg5A31BKoGtVopr4qlErLJhOLmPXt+AYfNQeF+
         I9shoPRYs/MuEkdJnRt1N7PTT56udRke8GosBzsYMCRwSNhhCDnNCFG7IfZZroahSE2P
         AJIdt4HxCSg+AaF6ZU2UhPU6HOqB1tKbhJy344PdXbY7WP1lyxkXmI38WEx37HywGCAt
         +0Ng==
X-Gm-Message-State: ABy/qLa8dGZnFmChI2RQntizoTHcfN/gUeRgzbBPr2AIIDpZSJ9myps+
        zyO4xx3j55cAANQ6+aXH5gY=
X-Google-Smtp-Source: APBJJlEgKciE33/chNIcAQ96G1OCtS5OCHSVQg/14SDAGAXKpbOq7gbtv6F6jd3XUXC5lStKovfWeQ==
X-Received: by 2002:a17:903:2351:b0:1bb:d280:5e0b with SMTP id c17-20020a170903235100b001bbd2805e0bmr17334723plh.18.1691011587738;
        Wed, 02 Aug 2023 14:26:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id jj6-20020a170903048600b001bba7aab826sm12880629plb.163.2023.08.02.14.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 14:26:26 -0700 (PDT)
Message-ID: <64b9cfad-94db-9f18-72e7-f88da212b56c@gmail.com>
Date:   Wed, 2 Aug 2023 14:26:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.15 000/153] 5.15.124-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230802065452.161574662@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230802065452.161574662@linuxfoundation.org>
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

On 8/2/23 00:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.124 release.
> There are 153 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 04 Aug 2023 06:54:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.124-rc2.gz
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

