Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3BE805DE4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjLESpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLESpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:45:13 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07199BA;
        Tue,  5 Dec 2023 10:45:19 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d06d42a58aso33951435ad.0;
        Tue, 05 Dec 2023 10:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701801918; x=1702406718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=flKgYIE4IwSJ2fUJsrVvCXDFvYHVpDfSU5/bd5JZy5g=;
        b=bRmwVJ6HvtiRNsnKuwrWcfLoxFlrASijxvdgKe7VQTx8oIjz5YWB7XxEiEclt/ymEw
         Nax+l9gSaumSiBxUfvrtZwtJBj+kU8/D7fPtam8BQXS9Hdn8emUDexJRgIYRTbSU9QTm
         3eLaWbcl160HGUv8QNAmJC4rszthy5NBOGccMw2O7FyE/XvxmsRywshnVBv08IOC0U7z
         8zBCHpSrDVuBvkLCT+0ciZIku6TlimSc/UzRJX9bdTNy2ZrpVa8B/EZrOJKuJFVaudhn
         zu4otT3T77ncRXNFo0rcH1KesheMmhUj8v8sX18nEpFcXRGJmUHbWL86ALr3KarYjWRq
         pBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701801918; x=1702406718;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=flKgYIE4IwSJ2fUJsrVvCXDFvYHVpDfSU5/bd5JZy5g=;
        b=VrYnFW6Te4cM5cnCVVfoAC8kFn779Y120i+hhdeKmF9ZzKSYHCAMiSb+LMKWUQIP+F
         VaDI1CBkTxJ/xEex8MDNtsct2X3vMZZpD816fDG0GAEE1R+Sht1XU1FhLIjkSoyBWhLP
         GpPnnZq45b8A5WF0X2uVx4IoVyqQ0idH+eGghCs3DLEvY9Ix9wVQijEZhuS3CipSKPXW
         QUPgxp+yiKbHnCO7RQEU2XtSrY0WCBLB3eXLVXXbxAa1z0vjJ1YTvgRZxbMEmqFdKrRA
         6nV4+QM37YLXx11UOa5ptsWIs4bL4sbtcoAZ2AsYSaGPuLIVtXfB1eD/kL9NhBRs8yTq
         pw0Q==
X-Gm-Message-State: AOJu0Yw5J9MpByUSPXvuYtJfp9MGikBymUZF72/c/u6zZbLRxJ6uSndU
        38z8fGlQFBq62ZZXVGKKNaQ=
X-Google-Smtp-Source: AGHT+IGczgLSfDMb+5nx+kA8WVFhT7MdlDViILaqT6EbIEY451+EMdH3QvSTDARDC1u1ZoLDPmLNkw==
X-Received: by 2002:a17:902:bd01:b0:1d0:d312:bbfe with SMTP id p1-20020a170902bd0100b001d0d312bbfemr290385pls.15.1701801918190;
        Tue, 05 Dec 2023 10:45:18 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id z20-20020a637e14000000b005c68da96d7dsm2520922pgc.38.2023.12.05.10.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 10:45:17 -0800 (PST)
Message-ID: <d2194d36-aca2-46c4-be3b-cfe3c3f33edf@gmail.com>
Date:   Tue, 5 Dec 2023 10:45:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/93] 5.4.263-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
References: <20231205043618.860613563@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231205043618.860613563@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/23 20:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.263 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 04:35:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.263-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Same perf build issue as reported by Harshit, will be waiting for -rc3 
to confirm the build issues are resolved, thanks!
-- 
Florian

