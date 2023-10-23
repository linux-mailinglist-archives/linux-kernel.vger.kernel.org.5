Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5757D4047
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjJWT2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjJWT2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:28:01 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560B1B4;
        Mon, 23 Oct 2023 12:27:59 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4197fa36b6aso21282781cf.3;
        Mon, 23 Oct 2023 12:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698089278; x=1698694078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7uPS1FFufaRhK/k1kDczCmhK4LKtdz1IcFeYK/ffRJw=;
        b=eU+UWZGEliebkGuM6AEcGyVN9Hlek3FWKA26BYzScACdpwPiSvvilOhehE6mz5TvIN
         fP2X4LfE/KtAhWgdeWvshJZ/y+4UwF1+phsRMiQ/iC74iGht8GcGlJpx6/fBADC3cKwZ
         CJhAYjHBQ429qfwzZ7VoVVxfibAm1+GiIxcviLJjeNJu+Tx5raiQH7KCNc/YfU/F5kCG
         5ectFa6XPSUlVQ8+kDjlZgM+OIeXsLaQEGu5QPxMTp3Z6UfELqioTSXWfDEP8YEVB1Mh
         k0jPFy5MrB6F+U3Rp870TrdxCdZzEfSaULmcDFhlFce7psvgmbddpjTIPwxm7EK0v+eW
         ujYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698089278; x=1698694078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7uPS1FFufaRhK/k1kDczCmhK4LKtdz1IcFeYK/ffRJw=;
        b=uw0PX9/XHEjB26FLxCpRAJkMZSk5UACOow8xSlX67akI4JqhAZlU5Rhv2gzEHii3op
         stX0RNUe7EGp8DoXSWsrlT8w3VRcL6G3bkmf4LB8YxD0ZA0uLCTE/ttDR13ZZcEtm2o4
         4invUpewi5bUAbnmvby5Z1DnugycSONzc2cWXL92uA2JIp0GElcwOqqlSjukhCOhefSR
         uEfVtrO5PGHqWwVzioU6xjM7+dro0eirwv/47UQicC8+YHV4FWUg5ouqB0knbwkQyzeT
         Osz/ye5guHIOd+ccIK8ofkIbR/E6fFft+L2ybSd8oHyj1HGRcdB7TuEBOt1Aaq1P3VgJ
         VCTw==
X-Gm-Message-State: AOJu0Yxf/5VIawtEeB2pugUSlJutksKfOZ2xveCwNA0XPN8HUFTKLkSs
        /UMmycgAVstOZRhU66eFZxsJUQFrQrI=
X-Google-Smtp-Source: AGHT+IFYL1IyfQ3j3isIrCCK4NxOmZ7CB2WlQtdpk5hzEQZ184KwvTeBb43qjX5EG1f1sHTaDxDHTg==
X-Received: by 2002:ac8:5bd0:0:b0:40d:b839:b5ac with SMTP id b16-20020ac85bd0000000b0040db839b5acmr9103243qtb.15.1698089278247;
        Mon, 23 Oct 2023 12:27:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b23-20020ac86bd7000000b0041969bc2e4csm2953158qtt.32.2023.10.23.12.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 12:27:57 -0700 (PDT)
Message-ID: <43474e9f-ff6c-4a1e-9101-9bead276dda8@gmail.com>
Date:   Mon, 23 Oct 2023 12:27:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/196] 6.1.60-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231023104828.488041585@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
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

On 10/23/23 03:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.60 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.60-rc1.gz
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

