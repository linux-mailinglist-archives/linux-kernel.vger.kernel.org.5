Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9592276DB73
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 01:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbjHBXU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 19:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjHBXUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 19:20:50 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5184F139;
        Wed,  2 Aug 2023 16:20:49 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-63d10da0f26so2096156d6.3;
        Wed, 02 Aug 2023 16:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691018448; x=1691623248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W2vcx5gELJsgfbxT0pmjpLmAr1n1LycLpK/JQlvaDwo=;
        b=ReVvWhzUTjGE0LnMI1RoORPK1dKXSmPY9CTJqnjhthVVRQY9ZuN4wefnr6DHEqmTZJ
         CGMiSxDBYvCijQjuBgFreHwYQuaCJzKWNueh23VPb5jHwzWRv/cVRtxQtaqDofYtbFtj
         cEkfRzZAEhMO2Rvb4cveXeSxUnueTffbk+eXZqPPrivzNEzLNEYGdWIAnn2BWGR0fbDI
         zYfx1UJbx4uxZa4LUv6TcZ6W8RIhKc7dAhfj+m8w3iZVEabEXyNeOTqKWVLh0nh34Qd/
         F1pS/IMOdx98bJ9LjQ3V6OJOx4KB5cZMjSB+x01EfhvSox/Ta95jQm+NJ89EOxU8xMIW
         KUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691018448; x=1691623248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2vcx5gELJsgfbxT0pmjpLmAr1n1LycLpK/JQlvaDwo=;
        b=F9Ohw8S5ETWqR1CObQywGda4Jh6af/SOWcKn3xcdxU5nf6mWFNhCX8TJ4VBD8IxtBL
         ekd/80dug38mftRVYeTydMRv5ojonONIaIPUDpY/Iwcfwrhld46xE+S4DOtuS+NERUUS
         xcktitCWxrVnJQqYlmgyKVAX77ekRN/T5x5aBUQVJFq/WcwNWY9qHa2UqFu+FU1gx5rj
         SORSO1bJlltywDHGJD21cstb1TwU2YZ3Ce23VBJpOBVSXyS8SK4DemHbGwUE8z0UHLXR
         X6ciX6tVPYuca7DfvzyA6Z9HToq/dAum+iwYIWEn1PqO6ylRGZ0UvA/+AqeeyBh6kvI+
         pFmg==
X-Gm-Message-State: ABy/qLZ148sJgAVqtI7d5TFSQOBCdWUODNf/VCP5CqvSMcwJRhBTJ0Zt
        JnvNwQj7kRLamYeZ3pFKLmk=
X-Google-Smtp-Source: APBJJlG6tXUdAR4U5jf2BK3+UJZ8CVjryWPIZnH08iLpNkwDPXPHkd6Lx6MoZRMEXT6mp/C4o3N1uA==
X-Received: by 2002:a0c:e78b:0:b0:63c:fe76:c4ca with SMTP id x11-20020a0ce78b000000b0063cfe76c4camr18026614qvn.10.1691018448250;
        Wed, 02 Aug 2023 16:20:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c14-20020a0ca9ce000000b00632191a70aesm5898299qvb.88.2023.08.02.16.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 16:20:47 -0700 (PDT)
Message-ID: <8bef84f8-9971-95f1-c999-2695e3a742a1@gmail.com>
Date:   Wed, 2 Aug 2023 16:20:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.4 000/235] 6.4.8-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230802065501.780725463@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230802065501.780725463@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/23 00:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.8 release.
> There are 235 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 04 Aug 2023 06:54:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.8-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
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

