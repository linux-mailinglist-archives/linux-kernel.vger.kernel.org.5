Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFF6776C20
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjHIWYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjHIWYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:24:38 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C43BB2;
        Wed,  9 Aug 2023 15:24:38 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686f25d045cso233079b3a.0;
        Wed, 09 Aug 2023 15:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691619877; x=1692224677;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BXEErU1EAFzIK7VWZ7YEZeKr+C1vSxWS6dUWwOP2Eyg=;
        b=aMTypv5TB2eU2ZhufmmWMC07SKzbrsSxeMJTTaSby3D0o57stJun/ajDamc5l0JRR4
         qwgx4UE+wT1o6LVWeT8Z9VH3AB/2sU12zc1XZ3y+jOqKAG87FGrSDccBjB0j5AGPgISx
         H8XQBhOsblvMqVlkwKxVRpt1BkzhWj4lrgjT6Z90nFH9YTINzsyVaYiWG6uz9e11bLoP
         RQsF5vta8BTz16NB4ugkumkYrEoi+dLuupGT1Bzk+WRg7nT8tsPcwgsqJPuMMGFQBLbC
         NYwJrei8MZJfP3QKXyx28nXzypM/UrHmjePub/Ly75BME3vTAtz5YWYMJ+OjTdLhcUuh
         n1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691619877; x=1692224677;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXEErU1EAFzIK7VWZ7YEZeKr+C1vSxWS6dUWwOP2Eyg=;
        b=joo3A0UlXwzDnNOPJRnpR8RhPlScfJcqUTxc+EQN284h7SJQ+extRg1s53zY3BGdCX
         Sou6QtWRAnm/fNM76sGEVsOGD6NpVfQyP8xPIjNfVtvyfYIAsHeFd7Jc1WAwjcwm6t3j
         w1rCVLfow9V7j2C2FTIOAp+F48pNwVLSyDY82fQqiPEOzFQp9g+/WUeMaUDAlMvqkSeM
         TuC41p8m+E/eWpFWltzmoN8E4SgqZNu6rxVcb58Aqwb9LJWyV1Blp2YWlzrIWFmIduXv
         u2BRKc3y5KkwXckf0iGoh/d8WKFVoVuOxVlOYd8p3ooSaU0++ghKBWoOidGsoI2/iRYv
         +TqQ==
X-Gm-Message-State: AOJu0YweX+vZAASdq6xOpau0Zzcz1P376qqMUnyUEF/OVkzUCvKoYEzE
        uznFAH6PdB6nzeKeV1pi4l4=
X-Google-Smtp-Source: AGHT+IF/wuiKaV+WFKzntO3257Xvbw12LzunbFl1tnNBcC2t20ekI66/aAdzcjvyQq4w6z4iMhim5w==
X-Received: by 2002:a05:6a21:4881:b0:140:48d4:8199 with SMTP id av1-20020a056a21488100b0014048d48199mr516661pzc.24.1691619877474;
        Wed, 09 Aug 2023 15:24:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id m3-20020a637103000000b0056456fff676sm99365pgc.66.2023.08.09.15.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 15:24:36 -0700 (PDT)
Message-ID: <9b640f96-deb7-c242-c924-8ce723ed9d2b@gmail.com>
Date:   Wed, 9 Aug 2023 15:23:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.4 000/165] 6.4.10-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230809103642.720851262@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 03:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.10 release.
> There are 165 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
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

