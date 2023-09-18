Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488B67A5219
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjIRSe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjIRSeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:34:25 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A3D10D;
        Mon, 18 Sep 2023 11:34:20 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690b85eb2dcso487355b3a.0;
        Mon, 18 Sep 2023 11:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695062060; x=1695666860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FklHMNqNjRSEiP2yIY2hQ7L26kuoNsBASX7uOWLkP/A=;
        b=nUEH49ltPPhjlMSu0pXp3Pztz4c0XsZnyrdHPHm5d/cz80hwMKRZ0KSGaGEB5/xPVo
         VPH840f8iUbWG6rMNIBjv2TQKxOTQCWw5Zzz2oPeMQA1Fh5/m29yG/HZuDabj7krVIPy
         jkaGRRi2YNufCMztQGM9Pr7k0urlOWZHnTrcHc5qi6kGDyT2alHBixn1FFbj747C+FQh
         oth/izvZTtiBD7vD6JTiRuLVScmlb+Ll/YorsO15zs+7ku7z9YdYdRMi476X2e+j4+a+
         9ovWQLWIaEmLFVh38Y0Da7b2cyNm+6UvCUZF7zsTgUz5lbS7sjc5VFz2U/KjSsj0Quf9
         vwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695062060; x=1695666860;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FklHMNqNjRSEiP2yIY2hQ7L26kuoNsBASX7uOWLkP/A=;
        b=UDDQTRVHq/8WFhbI7dLiuHtSK2RG5Hy1OgEfWt5NRKCe+Sqn9uaQYFNXKWmv3BhR0A
         EE6eUZoq2TIkjJVHTKTvOY5ifpTj06azRfU8WMgTY9Xnygeo0HutcWRZNlyga6wuNI+0
         faoeqw/JWrntxxT3BCLI/zu7e8/zJYa5YVYzetqIUir8oFCdqOqdI3PE3ah1+LtPhAdi
         KyVerZPcsAybBSIouI7+L6mbPeSl2pZD2EHvXZaY7P32vKwAws05wP/fyZgRRRiL9NS1
         Y51IYxedaLb0aN4en+JR3HDJGRYXEexquBhePvAmSa/RoqMNJBe9HXS54d69pQZ6m71g
         lNWA==
X-Gm-Message-State: AOJu0YxF76Fk62zUk6p3nLF9PsqbbgXaUV81xARopmFvj3r8ZJOTv4Zq
        OV6JpJrdBS+I1rtFBGRURKo=
X-Google-Smtp-Source: AGHT+IFwXJYVQv7z5guUlBHJTzNuMu1g2FRKkARGo7K/d5Yx3WlGOhxJ8DgFkGmY2CmJxSK9DFz1DQ==
X-Received: by 2002:a05:6a00:21d5:b0:690:2ecd:a597 with SMTP id t21-20020a056a0021d500b006902ecda597mr12245813pfj.21.1695062060007;
        Mon, 18 Sep 2023 11:34:20 -0700 (PDT)
Received: from [10.67.49.139] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id r11-20020a62e40b000000b006879493aca0sm7395460pfh.26.2023.09.18.11.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 11:34:19 -0700 (PDT)
Message-ID: <51d7f8b8-13c8-7350-53eb-1f1e09f1b683@gmail.com>
Date:   Mon, 18 Sep 2023 11:34:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.1 000/219] 6.1.54-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230917191040.964416434@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/17/2023 12:12 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.54 release.
> There are 219 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.54-rc1.gz
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

