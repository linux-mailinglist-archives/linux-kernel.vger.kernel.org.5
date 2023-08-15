Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0695A77C4C9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjHOAxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjHOAxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:53:16 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F020A198E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:52:56 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-34aa1a145f1so1517095ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692060641; x=1692665441;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K0tOP/Sk6SaxW5EklQ0Kq5WadLaqCBXr2GTwbhwi+As=;
        b=UD0u6HFzR0/85L8kNBZPJG+bo+aLP7rhkYoiBLwnXuMA/IWoPtBlxPMW7W8pZ8m+rp
         o4v/O62XRljwATLcarVFjk4n8AqMzI7vy+kAbZaEJBEz/+y/WP3oyxedFclYp8KZTskx
         3ODKq+yW85LqrYC4LhHkiBfoP6YazlaH/b3EE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692060641; x=1692665441;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0tOP/Sk6SaxW5EklQ0Kq5WadLaqCBXr2GTwbhwi+As=;
        b=lWVTi/avUv0kSpJX4tBlHwOV5qOys+HVmJjw0itOkn9D2MgUYjNGod+AF6VaQkIsNi
         mv/Vp4bEqjPOt8B+L8bZs6OQMjtNaJRWgYdDQmv4bMnr8z+fmc+mtdRvzQLP5jzcewmz
         N3EZoni4rMifdZjj32IvNsR7vzNqVMuTCVCH3eq4AAe5pKY0UKMDEeb2c5wV/Hdb/o2w
         aYBvyaNkcSrtIRi2aQSHd7XqceARKu6KKwnZ9baVY2V2mONC4FaXfNmQfaP7HDKw0tJO
         Z/EQHjxnqgzgjPHKU4OGwuP8Ts8s0O/dFEpPenijs91ktbGkZxoM+/V1XlehEQr7g28s
         Vb4Q==
X-Gm-Message-State: AOJu0YxhajFf2yd2585XUP5Cz+OiyjD+/2/s4dxeQUTTS8RViX4NN9rS
        fVCENmiC9XF/gR7YN9PhhzjZww==
X-Google-Smtp-Source: AGHT+IHlrrS+jS+og76YUa8EoyLSWx0CRIu3vN6zTO5d+dOrQZpvb4VyJhrYCvo/YV3WEBBhqEmHtw==
X-Received: by 2002:a6b:cdc8:0:b0:790:c991:8467 with SMTP id d191-20020a6bcdc8000000b00790c9918467mr13076492iog.0.1692060640948;
        Mon, 14 Aug 2023 17:50:40 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id eh28-20020a056638299c00b00430245071ddsm3309996jab.176.2023.08.14.17.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 17:50:40 -0700 (PDT)
Message-ID: <b47405d0-1bf7-be07-3059-41c66cdea77b@linuxfoundation.org>
Date:   Mon, 14 Aug 2023 18:50:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.15 00/89] 5.15.127-rc1 review
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
References: <20230813211710.787645394@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/23 15:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.127 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.127-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

