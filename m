Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD23577C636
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 05:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbjHODDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 23:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbjHODCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 23:02:45 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E900C1986;
        Mon, 14 Aug 2023 20:02:44 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-564b8e60ce9so2847473a12.2;
        Mon, 14 Aug 2023 20:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692068564; x=1692673364;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q9MMTmEvWS/Ce6VFrXHaEsM1pgSF/YPsnYYuXBrACr0=;
        b=X5Ic6vBDzAAF6Ep0MUw/84Q3nMysEY2zZMaSdDK42+wn0hdRQ/+y2XcgMHrLZg/zOS
         eMar0jZyljiUPCcl7NQFB5AocYNDAyJ0TGJPLbUGiexbwGyrHg/Zifs8yR8nzHXlM7WY
         nl3Odbl6CP13riajEITYwujjhnOR50AyL/PfxRJ5fRXy4uP24SagchZDCX/Zuu+gN33c
         MlFuiboIGSHoMHlLZC0jBtCVHnqipC9pVOS7goRYTdUkotL0DyJmgYh25yvr8HGmzB7t
         9NXX2K3tNGcuF6y4GM+LyGVb5SywLRKYMmCPMJU2BAAkvlkOT4PsFGUbh4nOXYybQguY
         BO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692068564; x=1692673364;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q9MMTmEvWS/Ce6VFrXHaEsM1pgSF/YPsnYYuXBrACr0=;
        b=KQaC//pwW5/ivzmhLDzIF81MCX4fplt5XoWXvj9l3zTng6v/LX5KkTDCOdsdWXHGuo
         m6fZCjSD4naibS9vuBzkiXfblhG0nxkOvFiUaCkwRgULo4sPb2LrjikJk2QweNp64ClN
         IcSP5CEYPsny8NXxnNUw+IqQ/y21dlOAjgzcQO2dBnKxid15RaO5TGIhUNHaSah+DYMx
         MEqNyy6gwXJpsV5F6JXfDsFYxXtC5u4ZR/F9ROcwdRexMVuuIbdBLz1zDRubqOEdwKUC
         rjx4ZTiZJpupyZDkx1uFnTDCAtIYedDE6CRVCz3gUhpu/9xQc7789cX/MwRDm0QvPOUH
         Fapw==
X-Gm-Message-State: AOJu0YwKbXLGMt9gEbdF2KMp2vIYJRDo2Cr2/U+NqZr+syW43DhT9Nat
        1E9Iis9U+47eI0PCcJ/BzXs8di4vkCWDNQ==
X-Google-Smtp-Source: AGHT+IEkJdNUDBYpx1+AoWlymwYzLLyqU9y56LHk33P2EkpWjWtFxo08KOEXY5Z/VKssMoN/KT2Akw==
X-Received: by 2002:a05:6a20:4428:b0:132:d029:e2d7 with SMTP id ce40-20020a056a20442800b00132d029e2d7mr15685050pzb.55.1692068564227;
        Mon, 14 Aug 2023 20:02:44 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id w20-20020a170902d71400b001b016313b1dsm6799423ply.86.2023.08.14.20.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 20:02:43 -0700 (PDT)
Message-ID: <b54c8861-e81e-5e1b-c777-b494a29b76d2@gmail.com>
Date:   Mon, 14 Aug 2023 20:02:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 5.4 00/39] 5.4.254-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230813211704.796906808@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230813211704.796906808@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/23 14:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.254 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.254-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

