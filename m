Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2827A5132
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjIRRqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjIRRqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:46:19 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC82114;
        Mon, 18 Sep 2023 10:46:14 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c43b4b02c1so20320065ad.3;
        Mon, 18 Sep 2023 10:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695059173; x=1695663973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2CcOTnEgUoTNMyg7Li7SLw44CUpQbtm5k7rtpHppxpI=;
        b=Da/W84KPFrcTpvPeEdCwB3kOSxk4TL8s+HWH8GVtwmZannqSTkNM4KtDdALjhBajUO
         z9SQYe2tlaal7cwe2ePLd94GslejYy9BkPRomi+BRVKUk4v5wKSdyhHZY478fCf9nA7C
         NM7UJr1LfM+d7wdfAiNsUzWJrhr1n3if3BdoKfj7y0Ba9c3nQf9HMdl6vAkQ90o/M+Cj
         Gntq7KTlCpGobcnEavZ8Le7n1PGpN2EYeaHtp+atj6dX0Xf7PLI+JddEoqfR+TUAZAPm
         FsjaIxlbfMJ5NJG+wCRABHiSATQknKjN3L8l8tFwg/eM80Euz4ZJcATBXfRsb7I3icQc
         +c8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695059173; x=1695663973;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2CcOTnEgUoTNMyg7Li7SLw44CUpQbtm5k7rtpHppxpI=;
        b=X9htd8r8pgbnjp9BM8BqHQjqL/QwGoXnpv0rOOr6lWzrMHLGdIqbm/gdaryYinj9iY
         1K4IyRoANeeAOzJiHOcStPMHqC8AKJ1lciBKaQ1D5JYdMXgPQpKkVEoEajjnJ0LmkxbL
         Zh2y7hS0ZObm4FlBfUDapb5c/3SKX6y9KSWWAWGSIrJfEZbKmwW9seqJuJm3fXxcOTWW
         rsq3htGCprzG2Ij4PVPwIYwjpjrOpfkaOSgpozQeQAXMDs9/eJvSBQMx9PIPeNv5qXJy
         8vbNM86BgiVklsh6Mi29jw3YJzCgnPHZ+Cw54dOSms+XUhl3dmjcdfARxFRmlw92/GH3
         S39w==
X-Gm-Message-State: AOJu0YzgDeEfpnGVsCwmhFBT12LP5nf4LossezOzFbPUkHrB37fuitno
        ECvwpKzuUc0VvW0Azjdm8Aw=
X-Google-Smtp-Source: AGHT+IGk3ewbfzHW2WRQS+m1g6CW4GIWtkM0uJSbYwzCwwNQpt4lq4j12/S2RFTJCVhrljnuLpVDZA==
X-Received: by 2002:a17:903:1107:b0:1c4:3294:74ca with SMTP id n7-20020a170903110700b001c4329474camr8553475plh.17.1695059173413;
        Mon, 18 Sep 2023 10:46:13 -0700 (PDT)
Received: from [10.67.49.139] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b15-20020a170902d50f00b001bf846dd2d0sm8598504plg.13.2023.09.18.10.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 10:46:11 -0700 (PDT)
Message-ID: <8a57183d-49c0-066b-fcc0-d378aa80cbe1@gmail.com>
Date:   Mon, 18 Sep 2023 10:46:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 5.10 000/406] 5.10.195-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230917191101.035638219@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
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



On 9/17/2023 12:07 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.195 release.
> There are 406 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.195-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

