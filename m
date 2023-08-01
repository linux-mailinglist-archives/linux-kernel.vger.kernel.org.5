Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4403B76B5B2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbjHANXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbjHANXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:23:42 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400F61985;
        Tue,  1 Aug 2023 06:23:41 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-686ba97e4feso5544500b3a.0;
        Tue, 01 Aug 2023 06:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690896221; x=1691501021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S8DGTH9o8XYfpqW6sUl5ShJmmE1aRyuvuNJxFdy1tXs=;
        b=gkvQPEMZQw1y2rMtAPv/AUcpIYlHuI+ICXX82Sg9BuW8GX15t7k7J7VK+0BSmiiCnK
         bTvyzywmngnqrEQOcyHDLRyK+WUZ+wHiHrQ+PrnJTPW77HC+ApM/+VuluvPR0DTtyRSy
         AWF/ElA0LsY+rK9S4OEA/JQTmfIGoafAnt+8BP10s0qZjOlZMPd6FHV7qQhtqcw9bKel
         zKzZKfo+QwVnj5alvGQcYBO51hlWMnK/eYxKiU2z/U81TLLxJlTBfUYoPVoQ1qe8mzXN
         A9RFXhb7JS6Nl5aQl9txsSKfDMolMj/UGgnIEt3dOjArDqGlJ8JiccLUxWxMFbgtPBnu
         oQqA==
X-Gm-Message-State: ABy/qLa5s5lTbJk47qJFpviFCzTKVTgcGQ6Z9BShe8WhlvVj2bPFlwhH
        tbwn1Rne71lfhfcW//vDToY=
X-Google-Smtp-Source: APBJJlGl6eg7z0GE6ZR9QqLPoLDV1SjAgmptJ7kEEEn1in7OIMQy1N+rIb5Um0iq0Vbh1jKdATtH3A==
X-Received: by 2002:a05:6a20:9194:b0:135:940:97e6 with SMTP id v20-20020a056a20919400b00135094097e6mr15062201pzd.8.1690896220368;
        Tue, 01 Aug 2023 06:23:40 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id t7-20020aa79387000000b00687087d3647sm8151133pfe.142.2023.08.01.06.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 06:23:39 -0700 (PDT)
Message-ID: <a660adba-b73b-1c02-f642-c287bb4c72fc@acm.org>
Date:   Tue, 1 Aug 2023 06:23:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: next: arm64: gcc-8-defconfig: ufshcd.c:10629:2:
 /builds/linux/include/linux/compiler_types.h:397:38: error: call to
 '__compiletime_assert_553' declared with attribute error: BUILD_BUG_ON
 failed:
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Avri Altman <avri.altman@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYur8UJoUyTLJFVEJPh-15TJ7kbdD2q8xVz8a3fLjkxxVw@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CA+G9fYur8UJoUyTLJFVEJPh-15TJ7kbdD2q8xVz8a3fLjkxxVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/23 05:16, Naresh Kamboju wrote:
> Following build error noticed while building Linux next-20230801 tag
> arm64 defconfig with gcc-8 toolchain.
> 
> Regressions found on arm64:
> 
>    - build/gcc-8-defconfig
>    - build/gcc-8-defconfig-40bc7ee5
> 
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> log:
> -----
> In function 'ufshcd_check_header_layout',
>      inlined from 'ufshcd_core_init' at
> /builds/linux/drivers/ufs/core/ufshcd.c:10629:2:
> /builds/linux/include/linux/compiler_types.h:397:38: error: call to
> '__compiletime_assert_553' declared with attribute error: BUILD_BUG_ON
> failed: ((u8 *)&(struct request_desc_header){ .enable_crypto = 1})[2]
> != 0x80
>    _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>                                        ^
> 
> 
> Links:
>   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230801/testrun/18754886/suite/build/test/gcc-8-defconfig/log
>   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230801/testrun/18754886/suite/build/test/gcc-8-defconfig/details/
>   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230801/testrun/18754886/suite/build/test/gcc-8-defconfig/history/

I can't reproduce this build error with a gcc-12 arm64 cross-compiler. How
important is gcc-8 for the ARM community?

Thanks,

Bart.

