Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5AE80F1FC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346627AbjLLQLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjLLQLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:11:23 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93220112
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:11:28 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7b05e65e784so47428739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702397488; x=1703002288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9A8ywdoqkvbMjsf35PJP+6DC/rgWj8HumDYD5a8MF5c=;
        b=cWHyCx02lIdcjl73AD8GM/HwQkyyJHO0sBfrhaQE4GUYV1t3XmYRUTC4al+/xiQrSM
         JVpieQRwKZr/5YYj5QiIdFFDeHPRzaLy4POA7CsexyMi57TZ8koHiF9dwAiiAdpJ0DPi
         mTcPeOSLjpJnrk87x53WZb38kUoGyqY5Rl3FM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397488; x=1703002288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9A8ywdoqkvbMjsf35PJP+6DC/rgWj8HumDYD5a8MF5c=;
        b=ql6bm74hB58LG8cooQoYQPLg1vMxr4zBRvcYnUTSryJMkBQV8LRec4q9Lo1/Gukr+A
         kP9oF96aMCgDJeeh5uQ67pphDiJeVUeirYrMiJeO+Y6tJst3IYxwk8OOjPdgw3Q6A3P2
         Z33EmdM2/GTCcK6mSp+Fo27Hv3tC2YnFmd/ycYJhW48CEy0fosUndrnp/w9/8cHoRvLi
         ECMSafVQO/x7+ImDvlka0zm8mXsrzzaiHILpETtViOo8FhtP1CJpnggqYir7mCs7cr9+
         7eZmF6s+jncxmfXudZpcggIP5isPyEFbPeKTu8JhT83scvRimTx+tQg8eYyBMRdIBX8M
         gDhQ==
X-Gm-Message-State: AOJu0YxOs7mDGz0l14pDQlj4/AgK3sGvpYrVDvzhRZtZ43qX7ND5H8S3
        vjuLZg1diK5TKC1ePXtQh4xHYQ==
X-Google-Smtp-Source: AGHT+IGIAN8f7DjQU3m3l7oGBzuemvs/+v1uNJrzjbiEiUXi2FlQ3CVHAZy8Zv3mOToQOcsKkLLw3g==
X-Received: by 2002:a05:6602:254e:b0:7b7:3ba4:8949 with SMTP id cg14-20020a056602254e00b007b73ba48949mr7112425iob.2.1702397487767;
        Tue, 12 Dec 2023 08:11:27 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id t1-20020a6b5f01000000b007a6816de789sm3012606iob.48.2023.12.12.08.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 08:11:27 -0800 (PST)
Message-ID: <86fb793f-f319-48c3-889b-ee9251371e23@linuxfoundation.org>
Date:   Tue, 12 Dec 2023 09:11:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/244] 6.6.7-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20231211182045.784881756@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 11:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.7 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
