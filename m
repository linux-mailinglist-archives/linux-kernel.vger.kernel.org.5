Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF297775B4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbjHJKYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjHJKYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:24:34 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131C783;
        Thu, 10 Aug 2023 03:24:34 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6bb07d274feso716440a34.0;
        Thu, 10 Aug 2023 03:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691663073; x=1692267873;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E9ofX90Q1n1BdjDgkIEbfd5XRT/6fEliAupf+NmfUrU=;
        b=NsJRwoRFKn2CWETK8zbmU7shAPvceSYQpR4aBB7F9mxlzuigwB+HTEX3cAf5EW/hau
         iIsrjMZMPjjWMlpjozv8kf1B7pYmcJ43yJVmdSiMlS3zT99ja38DiSVqSBy5v11mfzLw
         EfhzJ5KUCLmnPKaM8KPAnElvnlWXA8kqY2kC8JnuhKgZ5cwxQYCIKnbh5dREPF4YYz0Z
         GzFOFRiFC8cgzpiltUI2qLnLJ+y1Y5Q5l+jOSdwyurzaiuUbTah/O9U0Ow+Vp1M0YPAH
         gBOrZDHWLV4BPPGcrt0alyN7QC8wir5t2LLPLiIblpuLWcokkqWuRSo7+ZMPHRAhHzxn
         9qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691663073; x=1692267873;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9ofX90Q1n1BdjDgkIEbfd5XRT/6fEliAupf+NmfUrU=;
        b=Z/9z7ke3hTnzReRpV3+49/2wC8dvU9Vf46ifs+uXGlm0htMry5owNpI/txhWro/9Lp
         wHbxurGct1hDQ5v82VWGpGhYMbU/xzJK1UhQT3icfEUoqfHso5XKktD5AmqUnMNJjnF2
         C8hnWpGxvjjZhjawfqtiUpDbPx4UYpjAZzXfrrppBy1YmS7sPkapO57yw6mFvzusJn7L
         /XmN2hvrAjqFkLwac6Fj7kkx9joji6wVq8AltmEq2iqlMJhIz9UDJ35CnDEkoM5D1lJ/
         kMJdX4v8en1/CCVDb5u1qHxEfopWeGe1FIhflp5HXLtCZwRpMzPbI10FH60WRKq1wGTh
         CNgA==
X-Gm-Message-State: AOJu0YybDjGU/FdxTmwSnY37bqCPGxuU9n0wB5a5MggOb9w1k86O2cGS
        hwmWo+crGldnPSC409hPW24=
X-Google-Smtp-Source: AGHT+IGeuDmUOWzkPXK/ivn3OD5O5OWCuw5vmYPqUnP/KNzDU108GJbkWAqD0HSvjdu7njR6jlIuuA==
X-Received: by 2002:a9d:7dda:0:b0:6b9:cba6:b246 with SMTP id k26-20020a9d7dda000000b006b9cba6b246mr2012773otn.9.1691663073311;
        Thu, 10 Aug 2023 03:24:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c4-20020a63ea04000000b0055c178a8df1sm1171021pgi.94.2023.08.10.03.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 03:24:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9a3b1ff6-d702-6b67-9d9b-5eb1f90b4e50@roeck-us.net>
Date:   Thu, 10 Aug 2023 03:24:31 -0700
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
References: <20230809103633.485906560@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 5.15 00/92] 5.15.126-rc1 review
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 03:40, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.126 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
> 
Building arm:allmodconfig ... failed
--------------
Error log:
drivers/firmware/arm_scmi/smc.c:39:13: error: duplicate member 'irq'

drivers/firmware/arm_scmi/smc.c: In function 'smc_chan_setup':
drivers/firmware/arm_scmi/smc.c:118:34: error: 'irq' undeclared

Building arm64:defconfig ... failed
--------------
Error log:

drivers/firmware/arm_scmi/smc.c:39:13: error: duplicate member 'irq'

drivers/firmware/arm_scmi/smc.c: In function 'smc_chan_setup':
drivers/firmware/arm_scmi/smc.c:118:34: error: 'irq' undeclared

That is because commit d80e159dbdbb ("firmware: arm_scmi: Fix chan
free cleanup on SMC") is applied without its dependent commit(s).

Guenter

