Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F397F756E88
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjGQUrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjGQUq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:46:58 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BC710C4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:46:57 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id e9e14a558f8ab-346317895e7so2033535ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1689626817; x=1690231617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o5Y7u4wfa9oxMl286OAt5AFdptDBXZp+DAaKqKC9VPo=;
        b=h9HFz6+BsVaa7HnDrYPrytj3Cs0CLnvdrulRpVKx2ZbdhMu3iSKd7RWNYaCMrDG+ZF
         IHGegPK/6uPuaqemeaDcTFwprLL/SVlqP+b9J9SwTD7aBLgJo+MF86/ytNr1yJTBpqL3
         VZvf0bd7tAsVlfdeQdpeSn4xr7wmmPrls6hT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689626817; x=1690231617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5Y7u4wfa9oxMl286OAt5AFdptDBXZp+DAaKqKC9VPo=;
        b=BomAaA8U5XcPO5DFr+6hPmzYUXy4RpZFeD46g4se+gCu0YtQYu3Bsy8l7OISJF51Oa
         BZcHBLRgsk6Ha3zADl/IXvIlo+w6IXCMhEeopp0GXxQBvqWIx1MXWs+K1w5U+wUa6m5k
         i52LO+TGv5HbX8veBiCcMgNuRzUpu7w5XSjYYTtWLVjXUQF4UiTkr0gXEP96yZooURsW
         QfpicflNTXrLlwmnlrRTIdSATqDguoHGYWQ30kjQ6hD+tQAk3uM7wfuT/4yoKuszzdBA
         Ob9cFAN/FE+pGKTuVy0cgqfVRCYEeXAytyOGGECaBy6IdUbmuGYvMKZQrFw0+QqtonRa
         sjLg==
X-Gm-Message-State: ABy/qLY0vXqat1tDtu410deLJi+0/m480x/g0B21JkdLTbFk6AlhnBRr
        kwmpn0CupwS9rUYeIrPCRwpqUA==
X-Google-Smtp-Source: APBJJlF1StXb1kQ2bKseGNs05QRsBxvtV27vpfuo3v6EBu1Kp/dI/8vKYBw+tyVXSYfP9k4+zCFrPA==
X-Received: by 2002:a05:6e02:3486:b0:33b:d741:5888 with SMTP id bp6-20020a056e02348600b0033bd7415888mr786725ilb.0.1689626816791;
        Mon, 17 Jul 2023 13:46:56 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id v18-20020a92d252000000b00345e3a04f2dsm180502ilg.62.2023.07.17.13.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 13:46:56 -0700 (PDT)
Message-ID: <e143da96-6abf-0572-c112-46bb39e11bc1@linuxfoundation.org>
Date:   Mon, 17 Jul 2023 14:46:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.4 000/800] 6.4.4-rc1 review
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
References: <20230716194949.099592437@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/23 13:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.4 release.
> There are 800 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 18 Jul 2023 19:48:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
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
