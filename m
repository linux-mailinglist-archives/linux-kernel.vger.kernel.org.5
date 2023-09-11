Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FE479BD1D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347670AbjIKVZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244323AbjIKUGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:06:50 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308A31A7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:06:46 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-760dff4b701so57164039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694462805; x=1695067605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5vdcOYkDo7YYgDn3y9MlkiRl34kpqBQNFGUopW9ZjvE=;
        b=G2fPLsnBlhTtYX3kk4HX3HjyObbQIcuQZ7MTQvg7dbffL/hTJ3EyHjV9pcVvdIGyZG
         j55266iH3UqW9bn/ZWruKm4PpEtA4oSvH0tO9gAaA0+OcKNUNqhR5aztcNkvkrTuJYwv
         QMeQXMzFcAbpQqTFaYELVNQ8GnvTeRIzwaP9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694462805; x=1695067605;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5vdcOYkDo7YYgDn3y9MlkiRl34kpqBQNFGUopW9ZjvE=;
        b=JAwdAuHeCfDlshaXYDv0hlxhoIvIG7bKF456Kz4fxeTqcldh4b2DorCERBG6ZbC5AT
         q+GIoVYi0oqsTno7P4fKGzSQoFpbKDO1jAr+rU/ihvpb9F3IR8r3x+GkH/I3MHZkEWTD
         sqxXY6S/TeT1PL0qsOrHX6Ks3aY6se26j1XbgHnyGYo9qNn44Rsf+XL+6tX2+YysSkp0
         IMIcip2GT2FSJGJ/3RsuvgjTUGKZ8/CSRplPR5UIzZ9KLK0TL4LIqy4+OwXfBsh2dsMy
         Yd7fBgfUGd/Mi/5Rwq/Y7GtrmuumLJ7Ya7MlsbWW15dPH5Ehdps3iZ9cvfEcC/TGLIwP
         9i4A==
X-Gm-Message-State: AOJu0YyIxZJNE+dEMmCcKBhvq01CdYrhbGSaSPPCHaCDNAgOTkklNEGT
        QpKyMDzjXEKcsKCFaVbR4zuzSg==
X-Google-Smtp-Source: AGHT+IFWyI74g4J7b5VMjPOyOMsyz+RufAkrXy81JLdc8QUB4IHlAQwhWICvcnTmDPRDlM0vPfHyVg==
X-Received: by 2002:a6b:c810:0:b0:794:da1e:b249 with SMTP id y16-20020a6bc810000000b00794da1eb249mr13694459iof.1.1694462805495;
        Mon, 11 Sep 2023 13:06:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i3-20020a02c603000000b004302760aa6bsm2333572jan.4.2023.09.11.13.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 13:06:44 -0700 (PDT)
Message-ID: <a775025c-4e66-f414-5475-76698e30accf@linuxfoundation.org>
Date:   Mon, 11 Sep 2023 14:06:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 6.5 000/739] 6.5.3-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 07:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.3 release.
> There are 739 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
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


