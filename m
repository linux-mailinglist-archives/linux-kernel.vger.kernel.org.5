Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177F780DAB9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344664AbjLKTRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344349AbjLKTRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:17:19 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C92BD;
        Mon, 11 Dec 2023 11:17:26 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-58d06bfadf8so3024304eaf.1;
        Mon, 11 Dec 2023 11:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702322245; x=1702927045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ZEOt5yTQPrFy3hfdqmgP7F6Z7u2ECJR4HRXNBsOBgo=;
        b=PHVfjKW7l6I9r0WsQoDS8vLcYXqLY0GuRt8pi+J6bPucFR2jP7Ep5CKoLiiGUylgp1
         L3eedKsDK2RC8J+XWPdjwGJC4fGJtKqbE5Ar0uKfyX47bEU6hCSUjqqj/akeH8y4OFwX
         GoRlyHL0IXma+YCMNmZMOz/qgPy4wUkHu3aBGw/Ew2fxEte4rcx6qO2b/OFLPahL/MRa
         eesVPg97Vuqr151f/ahFDuojjM0sKp6ASMpiKd1fKjDNrVzYs9T4sZtVtQtwfabtd5yc
         FS9MuuYzAJdDJh+Yq+Ugl+DrRt8vtu1qpi2AzY/ltpGnShoQ1M2iYmuMx2HEZteE8CjG
         UwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702322245; x=1702927045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZEOt5yTQPrFy3hfdqmgP7F6Z7u2ECJR4HRXNBsOBgo=;
        b=JWHfa2w52IVPUFGOZUlgJ+ejmQzKK+Box7N6bNSsG0aCYME5xpvRm7fHnuaEkXqfxt
         BUYtXRUgESujcKMhReDW3Y10x9cYlWNad1pG3i1zbiLSP/7Wav/L4VEfk8QRm0b8IQ5l
         mRv7Aq499azOVxMgAEbAGaVRsiJAHiaXZS0OBKgA1lU1+6BNsrCU7jFYSd4sqJxkoQGf
         BZ4vIHRrv0fo5xBWZju9SCcYhZudxxxXvnZqbC/qfzC9FWsUz07LvWA/sxtxpWOhkY/g
         YpKZGj6gs9FEMWoWYx1PIKUHrgzXdrPllhT5gvg/FvOs7PO2xExJsE70Pmz6ev00yfmk
         AUew==
X-Gm-Message-State: AOJu0YyfC+T+Ju/1FgJLl3IJobT8lmLWUieMZAyQ0qcV3VzIt0M21N3K
        kDuQBU3+Hpe3MA7wU0XRBV0=
X-Google-Smtp-Source: AGHT+IGMffK+4fGed3ByrNcSTaR9TiAU6EQW9eZYutuCQshnUEbfwUwoDjlvUoERbVwB2u3pQ0vzNA==
X-Received: by 2002:a05:6359:5e95:b0:170:17eb:9c53 with SMTP id px21-20020a0563595e9500b0017017eb9c53mr3911948rwb.52.1702322245416;
        Mon, 11 Dec 2023 11:17:25 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id o63-20020a634142000000b005898df17ea4sm6712171pga.27.2023.12.11.11.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 11:17:24 -0800 (PST)
Message-ID: <ef53615b-cd47-4635-b348-eede25802527@gmail.com>
Date:   Mon, 11 Dec 2023 11:17:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 00/97] 5.10.204-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
References: <20231211182019.802717483@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231211182019.802717483@linuxfoundation.org>
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

On 12/11/23 10:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.204 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.204-rc1.gz
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

