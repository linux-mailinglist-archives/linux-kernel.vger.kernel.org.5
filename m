Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EFF7AA20F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjIUVMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjIUVLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:11:03 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D00A3AC3;
        Thu, 21 Sep 2023 10:57:59 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-57b5ef5b947so354467eaf.0;
        Thu, 21 Sep 2023 10:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695319078; x=1695923878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MrqMyDfh/NoVjPJH/IspBXCIftHgNrpO3X4YYK4Vmmk=;
        b=YwS74lOa7mpRApzHNqib4jCJCGaJsaUtvwj5/8djA2pxOu2UyHyuwV48CrI2SbRvvW
         860CB2LaWumfv8lACeEluKrPzQsH2adTDGxlOfjwMlu10NjEACfCfgrqMB1W0HhCe7tj
         dExUqhmvNWT7zwWVzBJNQbBzuxHpHGqgCBJPn3HVFSScZ4a6ajO7WW3H+PpGUJ20zcxz
         JKIh8VOx4ENyQmB3zo9pY4ntGvNoJjJo09jA7VnaQcsHp0G1gHO3xj0kG6E1mStZV0Qx
         7J/l31Np+xg6mJf0M38fi5we5O/K5QZIHLsUjMX4wfd/bR6rJrqlR+KLqakZm7fkJa6r
         2Gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319078; x=1695923878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MrqMyDfh/NoVjPJH/IspBXCIftHgNrpO3X4YYK4Vmmk=;
        b=VNXPpe6xWBjwHrWeEjGKUZKuoYopzIA2/UMhqc0MvZVKOI3bKICUxDEN3Gr22VDJx0
         QEhAjVFYt/chQ2A0lN1Fs6Q6dbQHyYLAeE6XGw8sRTUSaJUAjZfn0He9JPgwL5rRaWgA
         6+SRCv3Pe6sChKskqkVc3QCwIgZBV5nyQG3Odcpsw3tFnbwQsR/GAlqD0EQvJTAQx8Bo
         +KQudkg+9lssNQEdXdjIqWHW+vv3kqYxFemtAS2U+Xw+aTZ8lwh5PWnuVDtuZV9CrXVx
         Ygiz9WZm8Agu/MVgZu435oqEThvU9hT083lsSmWz6QY9iWblQtmyUaw8rvcMhXOgvDqZ
         aJPA==
X-Gm-Message-State: AOJu0Yw/XQif/fq/7uGjSZ9eIvIVrlDWaKdm7A22RwGRf8a+rgw5Ycpb
        OCM7Qro2LRXMolqakFsbMQTtt6Adsnw=
X-Google-Smtp-Source: AGHT+IF7ZbUBjXhr1E3hDBZvekqd4EWOu7Rd4Hf7dK3IXPmdnMtSy8mWpGFOdQHr4eOR6s3YPupd8g==
X-Received: by 2002:a05:6808:df4:b0:3a8:4903:5688 with SMTP id g52-20020a0568080df400b003a849035688mr4759045oic.34.1695299104626;
        Thu, 21 Sep 2023 05:25:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i14-20020aa787ce000000b006870ed427b2sm1271538pfo.94.2023.09.21.05.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 05:25:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0309d2fe-a9c9-f963-b096-ba11fa74a081@roeck-us.net>
Date:   Thu, 21 Sep 2023 05:25:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5.15 000/110] 5.15.133-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230920112830.377666128@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230920112830.377666128@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 04:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.133 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 

Building powerpc:ppc32_allmodconfig ... failed
--------------
Error log:
drivers/usb/gadget/udc/fsl_qe_udc.c: In function 'ch9getstatus':
drivers/usb/gadget/udc/fsl_qe_udc.c:1961:17: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
  1961 |                 struct qe_ep *target_ep = &udc->eps[pipe];
       |                 ^~~~~~

This problem also affects v6.1.

Guenter

