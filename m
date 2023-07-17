Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F54756CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjGQTSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjGQTSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:18:10 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FA1ED;
        Mon, 17 Jul 2023 12:18:09 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b9d562f776so863701a34.2;
        Mon, 17 Jul 2023 12:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689621488; x=1692213488;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pD/oZCaJCOJRr2WuaMkYLcpCFfZmO7kAcw4QWPJFCs0=;
        b=NzeVcJLBnHLhBKfctguPt3mS8ngFJGqsjZWCfpuLI7fAgXT/QLVfgylUk86w5Qf3X5
         yP49vPtG1W6+tZqV4XUt/U5zVVI4+HQy+ZvKZx3UgL+PWQPvAd9bnkd8vrZlhsUsdVX/
         Y1lCkUFK/0n4WHFw6urPZkXbRFbl6xOJ/WMVGU2pu0vOUg/rTphyTiiVfIVLbynPtsH/
         Iuo3tgAzYEs0b3jg/thvAnfYbvB0rcKyLftRSR9lMogF85RRhNTU4Jne9Fe0Y1NNxG7N
         DzYsdcdBAP602sYgVIsmhPWV912b8ruFJcxMkSsdCYTtg9U6/9mnAPY78xnSvbXU+u5u
         1Oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689621488; x=1692213488;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pD/oZCaJCOJRr2WuaMkYLcpCFfZmO7kAcw4QWPJFCs0=;
        b=B3B3zTEqEWdradCSn0tk1c4aV9b9LL/EjU5M+c/grfY9k68ucz4Nd8VCCT/5ZTg4es
         eZWLlRCuoSBeMIPLSXNgUKp+QUp/cZwcwOeBmnXxP4k25ystPPWPkZFufXYbJO1x1nSI
         TZZf200MxFFlSZI5CdRXsv57gws2xHdhK0h+VTyljP2/tJrIKXbqCGlkiqtVssqcJeOB
         7IhIYjAc5kWnK+GdCvjeYP+hiAVr4KKqQgYRSab8hzCyi2wc+jyOx4q0xb/h/WN+FE8O
         IhmAAeX3xdkhizwPtASm9NlSdHfU1z7xBrgp3cP2gA+ChjuLNITHkwd7bErfJAJJBrpH
         t3bg==
X-Gm-Message-State: ABy/qLaUrCL5QnPE+IpI6yG31F0b1g7KAWikBEFd7tJy0SuW8Gz304C+
        /FPcnGcSygHQ6QFaraWyJE8=
X-Google-Smtp-Source: APBJJlGzBShM3WI3crHaFM1S6Hbpe/XCjVy49B1K121fBw7BDbSbSOkfDvrkh2vf+JNJJyYYYDZDmQ==
X-Received: by 2002:a05:6808:10d6:b0:3a3:9337:4099 with SMTP id s22-20020a05680810d600b003a393374099mr13876098ois.56.1689621488275;
        Mon, 17 Jul 2023 12:18:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i195-20020a636dcc000000b00514256c05c2sm171727pgc.7.2023.07.17.12.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 12:18:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5f514ecc-a0ae-ece1-a212-e392c128fb35@roeck-us.net>
Date:   Mon, 17 Jul 2023 12:18:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230717185609.886113843@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 6.1 000/585] 6.1.39-rc2 review
In-Reply-To: <20230717185609.886113843@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 11:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.39 release.
> There are 585 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Jul 2023 18:55:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.39-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
> Pseudo-Shortlog of commits:
> 
[ ... ]

> Sergey Shtylyov <s.shtylyov@omp.ru>
>      sh: Avoid using IRQ0 on SH3 and SH4
> 

This patch is applied without its fixes. That means almost all sh boards,
including the one testable with qemu, are broken. Fixes are (at least):

7c28a35e19fa sh: hd64461: Handle virq offset for offchip IRQ base and HD64461 IRQ
3d20f7a6eb76 sh: mach-dreamcast: Handle virq offset in cascaded IRQ demux
a2601b8d8f07 sh: mach-highlander: Handle virq offset in cascaded IRL demux
ab8aa4f0956d sh: mach-r2d: Handle virq offset in cascaded IRL demux

That list may be incomplete.

The same problem affects v6.4.y.

Guenter

