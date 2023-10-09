Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852437BEA58
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378218AbjJITJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346660AbjJITJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:09:12 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B259D;
        Mon,  9 Oct 2023 12:09:11 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-693375d2028so4345554b3a.2;
        Mon, 09 Oct 2023 12:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696878551; x=1697483351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2WB2O+ZBzB4ZMkeQ2reQ4/yBz+9uB3jIVkq0VzlaCUY=;
        b=MZSHmExeSeBfbLThBj5mbMPFrCmIjRfqA6onajkf6lWvKZjzR2WFdEQyqqio7tUiXU
         KJ62chzJ0T21JY1rSRLHMu9kJ5RLIiSnbBUsV6jhUhtOSNHEeVLiOcAer5i9QVsDaMdP
         MOq4czUvlUxj7Q+2WxABdHjlrX8+d7y+cbz3oaZxer1lAg3fXa0sPavsFIsYj1CTXx2r
         Zn26RAhn6yOWFS+sNaYuTU84xUKFXpxH4sc2Fguml6D7/mBVtkctCUjta2DYFE6u4PIB
         qNCHOgcwu9idqaYbGTrdu3DEOkd8EHA2Gr69eLefQuJV3YijleXfwQuKYhlPKLHJq32N
         Wj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696878551; x=1697483351;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WB2O+ZBzB4ZMkeQ2reQ4/yBz+9uB3jIVkq0VzlaCUY=;
        b=hxLcqF1UCB4UeP+2yylQCvb0fIYhzgyL01lc979F26JV8jJBL7uRarm41z+Aa7a4Sx
         w+pSmzDF9AJuYV1tTj2F+pMCa/kRJqVc8yTZhr0ohdaoQIRn70RUO/StQD7yrbBhukaJ
         dleJeJQ+mQd6sTKL98oxecqC4rYbb0vhBl8pM63yFejDf45j9H5jAJtWHdDWAzbCsBz7
         6QWkCBdoZRDuxqAkKuAAGeXmADfpsUqNzcG0f4RcqU1l+K1NIFMlSyJoX7FYuYTUK9yD
         EdEBRe6NrNRFM1OyhvHwHeAMIvV1x73niVhN565dGSTctRXPEJjSgcA61L+o7X6/f6RV
         OOwg==
X-Gm-Message-State: AOJu0Yz7HjAkiutXufN/yRTFIjxO568ecwP581trRhKkF2JuKkpjaosD
        B3I+xPQ+PdFsyOULpReLpA8=
X-Google-Smtp-Source: AGHT+IHqi/Arp5jO9UE8mGcTD2ZBtMrBThOiTbPkKB2cIKERsnzlL7P8eOjGCjenBXvVB4E+NMPaQQ==
X-Received: by 2002:a05:6a00:2394:b0:690:2ad9:1454 with SMTP id f20-20020a056a00239400b006902ad91454mr20897163pfc.33.1696878551009;
        Mon, 09 Oct 2023 12:09:11 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id gx9-20020a056a001e0900b00692b2a63cccsm6729012pfb.210.2023.10.09.12.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 12:09:10 -0700 (PDT)
Message-ID: <cb16ada8-4c7a-4134-aca9-41983521e388@gmail.com>
Date:   Mon, 9 Oct 2023 12:09:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/131] 5.4.258-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231009130116.329529591@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 06:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.258 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.258-rc1.gz
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

