Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E287B9959
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 02:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240950AbjJEAzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 20:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjJEAzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 20:55:00 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ACBC1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 17:54:56 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7a24c86aae3so7656139f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 17:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696467295; x=1697072095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a08xY7SZXFKc+c3Xwi7VT9tqVA8hFrAkL1vfo3KcpXw=;
        b=dbP6fCmjE4uDc6fKR2KCdV1S5mps3wZvEm0Y/pYALDmjq4vH+QotfHTCCDIbWeS4ym
         A5maGxh8WfP+1rKosIb/9EI6ExfnndY72UgZXWiTx/IqWGty92Y52PTex3JGozl2eDQw
         eed0jIuW6kSZB3rPdds1h6Q/g0mVXuzHMqkBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696467295; x=1697072095;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a08xY7SZXFKc+c3Xwi7VT9tqVA8hFrAkL1vfo3KcpXw=;
        b=nhSbrVlqvD3u3Rtn1mjKstUyV9VfcytHiJGNNjoPJL45oGo91laQk1q79bG6M1GX4+
         Tzq48h4CvIy4of1x2Ohu32xQm+vmP1plAp909CDkHbNvVx8y65meEFz97cGzwk98tT60
         LdceI+6fE3Z4c7zpjTDNFl9pa7VbYt8G6MEoJStDuEZoQyeP+MzBtl0vp3ba3yQlyT8W
         vU/UR94+5p/9EWtYh34M99nvd2ZQZQ9MAZE2wzVtT54bIZwmmYlNEXPeAASXL8b59/Zi
         Uo2dvt+McuhYuopOGQ0kHwphxU99YDoBpsoiRlOC7QBVVuUmuVGavFzVIGKzbQGCNVMs
         yPSA==
X-Gm-Message-State: AOJu0YxFc5GeHlpMNyf7uKoWPphaA8ZgLbuo1Hb6BVJ7cMWcMPPVe0h+
        QQNYFpMyBquVtlgbwbKyogHQZw==
X-Google-Smtp-Source: AGHT+IE58O11Qqrb8YDePCZPuDtEnm8Rhg6ypj6OjcqiXoAICbc8fmxx8LLaZD4gkl57C3EZW73VwA==
X-Received: by 2002:a92:d1d0:0:b0:351:54db:c1bc with SMTP id u16-20020a92d1d0000000b0035154dbc1bcmr3786198ilg.0.1696467295606;
        Wed, 04 Oct 2023 17:54:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id n4-20020a92dd04000000b0035150cf93basm100992ilm.16.2023.10.04.17.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 17:54:54 -0700 (PDT)
Message-ID: <8ba0360d-81b4-4555-aa47-540fc4e5acf0@linuxfoundation.org>
Date:   Wed, 4 Oct 2023 18:54:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 000/321] 6.5.6-rc1 review
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
References: <20231004175229.211487444@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/23 11:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.6 release.
> There are 321 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.6-rc1.gz
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
