Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B142E77C4C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjHOAxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjHOAxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:53:14 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A71619B4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:52:53 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-790af3bfa5cso58116039f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692060765; x=1692665565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OMHEMD2drjafQVG8JrAKuYd3GCDFQ+GbZ9AG30u1YxA=;
        b=K9rfLJ74XS/LBFVT1DDIbRdoZS7Kv/Wk+KEDkz5OCPixVJiE5O2gl0toQPWJgAjjTd
         y5alRq2zbFRc01I0wqqRpSKsxYxi5i6py1LNw5DpwgcdH8b43waAYvyE+HEE+frLL+PX
         Lz6r+cnqducOdHZb+G1qfqayXNTBs9fVPc4wE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692060765; x=1692665565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMHEMD2drjafQVG8JrAKuYd3GCDFQ+GbZ9AG30u1YxA=;
        b=EhsnNo+KR7dHxsFUdoTMQ+KCcenptgZMJKLEIbB/xgboVQczFU6cNuyP933+tkhWhl
         HjFCtDnEy7yx1KN2FOgB3OCDaexn7oxh4Ql+Ir/bUQKKZRkAC0zqtjAuulXHt96slMxc
         9lUsmIWTLbYWcvQ31HaZQCKUP5gAy9h2FvQrCpals5ft1uRXE16GuMpfZfzz2TGPjbsv
         73qUJxObNWyYHURag1LyW0n9TCYx2b6/KNSS0HLTLmZ3pKp6lLEvEKoN8t0+p0y/zRrL
         MKfGQ9hZ92gCP2foPtc+fvVHAlvWUvQ5atMt9vj4DF2oDfGDBAN3JHPDPfr0HclXriCg
         B8sg==
X-Gm-Message-State: AOJu0YwseRsueF+IOhnKfnP0FWG3CmxOElOEI2pd4D25uAJ2kSpY7eDj
        8I4tnJvHfym6yXsKQ/QivUUC7g==
X-Google-Smtp-Source: AGHT+IFX3GXgUzsbUvGnkssxTlN3jq4QhVZLC6xKs6FZ8jJPIhSjSDQU0V9CeIVBhXLzm+zO+14Fzg==
X-Received: by 2002:a92:c6ce:0:b0:349:7518:4877 with SMTP id v14-20020a92c6ce000000b0034975184877mr11968941ilm.0.1692060765684;
        Mon, 14 Aug 2023 17:52:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id t15-20020a92c0cf000000b00348ac48e127sm3577087ilf.33.2023.08.14.17.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 17:52:45 -0700 (PDT)
Message-ID: <b44a3dea-ad20-c046-2027-95fa855ddec8@linuxfoundation.org>
Date:   Mon, 14 Aug 2023 18:52:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.10 00/68] 5.10.191-rc1 review
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
References: <20230813211708.149630011@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230813211708.149630011@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/23 15:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.191 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.191-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

