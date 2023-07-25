Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5F97623C2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjGYUm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjGYUmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:42:14 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA830E47;
        Tue, 25 Jul 2023 13:42:13 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68336d06620so5568998b3a.1;
        Tue, 25 Jul 2023 13:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690317733; x=1690922533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MQmJ/m2T/ydxcjfile7If/e4KOGCFPlQ1iZlkwg8KdI=;
        b=ZTx1BqZcaa8x9126EESFJ9eCw2x2YHm5MpXp7fNkpRvehfLHMQiyKDZp6K5seJ02q0
         D1Sk+7R37/Qvm5jz+CQJPMRWOVXL0w2xSavdoktlx9i6HhDFX7/8NE0M/FdSmemLdCKz
         Y9YYIUaXJox8uMbkyTWfeD917IqIh/tgAHxSJLNbRSczQpQ1Ere/p2KPgowDU0U2t1hn
         QEvIB0J4kQQm73XqTx/DqCD3/tNRQ89KBMk5etIBTVyuvUa6+gkoTReAFMTcte3Bp0+0
         o8Jblij4548dpo2/F8OuNwoRRQfYtlTly6E25PII9lgIRff+zew1hSWVLe0UhjMaLofj
         XvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690317733; x=1690922533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MQmJ/m2T/ydxcjfile7If/e4KOGCFPlQ1iZlkwg8KdI=;
        b=kMWwaPJNMXoXlk8DI44HX4Hlpn4DG+gaDwCA0EHZFJ2i8ZBD8rPQ4RVUu1XpX7kxqP
         RdYtA0SUjfH694UcpGDmySTDE0X1fU3IVfF+Eb5B22JH3IutBujcvm7qxyo67jh0dz/8
         CXOVBOv6YpnbzLvVOQTDGEEGOlKMVIZJ/pkR5fWObXDO5aqK0c76keHJVSxKiG7tYypt
         R4Jos+/z6orkDv+cF8DQvvRQckCtSqScGNn3HohFmEHcQufFDB5vXoAbr3iqmZpT5aRU
         UMsFq0Wbxh9+9Mr7x5FKOdaA/XoUqojx/b68PFEcXBPZ14e1NMmSF+zgmUOXkQmlLtYW
         Ghcw==
X-Gm-Message-State: ABy/qLbrdgq3T14ywocDnt05OzoC8lH6DlDSCT8+B4tloBnN4fpRttNo
        LG7NRhcVHJKMrxtsT/Wn0hs=
X-Google-Smtp-Source: APBJJlGCgl8X3aUEZlPeeAoAG21g/VkFzj3agq1zYPsrFu6uYCaZjbOHh41AK/Zr67xCbEHs7RNM9A==
X-Received: by 2002:a05:6a20:8408:b0:133:96c9:fb3b with SMTP id c8-20020a056a20840800b0013396c9fb3bmr189930pzd.45.1690317733116;
        Tue, 25 Jul 2023 13:42:13 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id z24-20020a63ac58000000b005533b6cb3a6sm10962157pgn.16.2023.07.25.13.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 13:42:12 -0700 (PDT)
Message-ID: <f96821af-113c-0f56-8576-b84616db4233@gmail.com>
Date:   Tue, 25 Jul 2023 13:42:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.4 000/313] 5.4.251-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230725104521.167250627@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
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

On 7/25/23 03:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.251 release.
> There are 313 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.251-rc1.gz
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

