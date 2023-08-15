Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2878E77C4A3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjHOAs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbjHOAsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:48:04 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B281710
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:48:03 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-760dff4b701so51546639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692060482; x=1692665282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ukogAUa4ocH8ByC+yfaWUlJyirwsSGA/r/2pc70jO2g=;
        b=HB4+b+sHrTF6qOQjgz0IL9t5QHSzfIk4wpavGIC8e/vJ9aAwxBosFQxh8cDyO8yl9c
         fCgfE4NCWOMAA5I4KUaEMsap6XfUswIyZV+urtLoiq30nYKlmvM9plHLTRnfMBWBdvk0
         jkmqZ4ixVPzn1Xm+kylG9lxk4Mr55F4dwZY/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692060482; x=1692665282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukogAUa4ocH8ByC+yfaWUlJyirwsSGA/r/2pc70jO2g=;
        b=QDxB6Dz3eyjxzdFvuKsnhZCzpoxW+EPokJW+1R3kfsJIomODTqu9rYkpXXEIapb0x1
         3JaHaFW+m1MhajgQJQQt5YFUNM20BoCnGRr51MGbHzA4aDFCMSYkfxvWctz11EjbtjLL
         jwvcPqCQpSR4oyVq1bJkGiLYRkoxddDGlrhmDz2IjCBAkf2p371zk2qFJB2BTwXGdFCA
         MGY/enMAzt7jeM3nY4aHh/Hh72NqTNTCbXBcZ2hbvgrkJYUbuZiLSyPt2mOCYXCFUBCf
         MZn1BbMLy1C1YOiHSdO1T5j/m51w5xvRsdNkn2NHT8cWxvRM+iTw5erZyFLyhTycTJXx
         9rMw==
X-Gm-Message-State: AOJu0Yx0t8r6oibXLvCusJTDCBAPOLdhT3B/Tl9e8s+qqVXAelE9wEGO
        6RSSY37JHqkgKQudm3yJ85l0BLkV1glWPDe3+tk=
X-Google-Smtp-Source: AGHT+IElHmrz0ZozMelXl4KgM3inJg7xAE16vvhdPbsnqAtkfank5asX6xxKIeVMbsEyihL/tfpujg==
X-Received: by 2002:a05:6602:3a13:b0:783:63e8:3bfc with SMTP id by19-20020a0566023a1300b0078363e83bfcmr14241537iob.0.1692060482678;
        Mon, 14 Aug 2023 17:48:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id em6-20020a0566384da600b0042b0a6d899fsm3363834jab.60.2023.08.14.17.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 17:48:02 -0700 (PDT)
Message-ID: <a2b84aa7-dc02-dd98-9a27-e9969c8f1824@linuxfoundation.org>
Date:   Mon, 14 Aug 2023 18:48:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.1 000/149] 6.1.46-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/23 15:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.46 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.46-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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
