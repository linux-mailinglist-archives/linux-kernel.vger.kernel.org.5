Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B79D7C6746
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377922AbjJLH46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347191AbjJLH45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:56:57 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421F5CC;
        Thu, 12 Oct 2023 00:56:55 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-692a885f129so565352b3a.0;
        Thu, 12 Oct 2023 00:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697097415; x=1697702215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KY0ypPMouC/gc/fShPGord6YxNIg4wjSjV68xFY4qM8=;
        b=DchKo9A3e7kaAvWnf8UWc6HXv9rcocQkpjMcXeeg/5iBgfNpTERfE+F+IaOuFO47Y/
         o6CTV41QrzFLteD5XGelFcAIN+OpsTuBZkRNkoqumkazkgnvGhzaO2zSwEeIpVcX9n3Y
         RYsewEBt1o27W1PQjeByj58kKmgwvyCWNPFoA5KG8M2/V9N3bxXeUA1J6ViXN375aROS
         m6sWOTeddSXmzIAY8u+SnuOYQShIaCCYWwjoJzb0UIXPrEt9qnRxM3GTv8+sK4gbtTXi
         /JWPMIrFgFooVS8OXukpeex8AfoQfhbBSH64sSkICcxSjLt2bJW6MKvS4RbNwrozDPyy
         Ug+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697097415; x=1697702215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KY0ypPMouC/gc/fShPGord6YxNIg4wjSjV68xFY4qM8=;
        b=UU6A4VQRHP4hd+doXqy6SrsPiFZJodNf2R+0IsE3tePe76vQ/rluPkhKPsa3NXsSQN
         DOZhZ6Lu/8tR6NKVszO5XE5C4OoXRZAQuy5xXg3MWptrS0YMCDikJXUODxrKGRgtszTT
         LdqjsE1KNUl4lyf+17jBmx1n4CYefQ1rzjvb8tT1Dea6YM6705GPov6+BxIxh6IC3b3w
         HLJTQ96EcJDlW0t/CGXi4+jOB+8EL6adZatkkr5ZjHDovqR+Fs+qJJMv+6b8phl5qR5S
         NiR0BaM+ltchKRagXJyq+JmQGm+9qkt8kHXg/D/dFqfvQYCkQil+9dABEheJ5zYnb3qf
         pqgg==
X-Gm-Message-State: AOJu0Yw9jxUVnYxBMyWP6VWeiqmUWvXjAwQp+PdRXamfXILaaUAIh33R
        SJ0PlTMRj5y9WcGjg27WD/k=
X-Google-Smtp-Source: AGHT+IHV4CR21UOUBHuemm1nSHilgQwolLdmRc5oq1FyDnKdlzYKHLfW/oMQSSCqwFIFMiLNpBzntg==
X-Received: by 2002:a05:6a21:3289:b0:174:d189:2f93 with SMTP id yt9-20020a056a21328900b00174d1892f93mr1538024pzb.59.1697097414647;
        Thu, 12 Oct 2023 00:56:54 -0700 (PDT)
Received: from [172.22.12.30] (118-163-147-182.hinet-ip.hinet.net. [118.163.147.182])
        by smtp.gmail.com with ESMTPSA id p10-20020a17090a930a00b0026d4100e0e8sm1188408pjo.10.2023.10.12.00.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 00:56:54 -0700 (PDT)
Message-ID: <6348ae7e-21f3-51ef-e60a-b3ceccc38be4@gmail.com>
Date:   Thu, 12 Oct 2023 15:56:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/5] watchdog: eiois200_wdt: Add EIO-IS200 Watchdog Driver
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     wenkai.chung@advantech.com.tw, Susi.Driver@advantech.com,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <cover.1696495372.git.advantech.susiteam@gmail.com>
 <d7df3c7b-730a-4d09-8f15-3cc8591c8092@roeck-us.net>
 <b08d6cf6-cd48-86d7-a959-290fc4de092c@gmail.com>
 <ce810ce8-f93c-4a9c-9d14-1e8f8f8c3e2b@roeck-us.net>
 <88ffe7b3-fa62-e879-b9d6-6e229cfdab7d@gmail.com>
 <655945a4-fc45-4d01-954b-88aa6fb7231f@roeck-us.net>
Content-Language: en-US
From:   Wenkai <advantech.susiteam@gmail.com>
In-Reply-To: <655945a4-fc45-4d01-954b-88aa6fb7231f@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck 於 10/11/2023 11:05 PM 寫道:
> On Wed, Oct 11, 2023 at 12:08:57PM +0800, Wenkai wrote:
>> I understand that the patches don't meet the expected quality standards.
>> The compile issue is due to my MFD core driver, which is currently under
>> review and has not been merged yet.
>>
>> I would also like to seek your advice on how to best proceed with the
>> sub-drivers like the watchdog driver. Should I wait for my core MFD
>> driver to be successfully merged before submitting the sub-drivers, or
>> let Jones Lee review my core MFD driver and all its sub-drivers, or is
>> there another approach that you recommend?
> If the sub-drivers depend on the mfd driver, at least provide a reference
> to the patch or patch series introducing that driver. Either case, a direct
> include from "../mfd" is simply unacceptable. include/linux/mfd/ does exist
> for a reason, after all.

The LKML link is https://lkml.org/lkml/2023/9/6/1245. Is this link to 
the patch
sufficient?

And, I'll move the "eiois200.h" to "include/linux/mfd/".

> I don't know the best solution for reviewing all the drivers. I didn't
> (and do not plan to) look into the driver-driver API. If the interface
> is regmap, reviewing sub-drivers on their own should be straightforward.
> If the API is with function calls, things get more complicated because
> the API needs the sub-drivers to be tested and everything needs to be
> reviewed together.
>
> Guenter

Unfortunately, all sub-drivers mostly communicate with the EC firmware
through the MFD core driver's driver-driver API, only a few uses regmap.
So should the MFD core driver and its sub-drivers be reviewed by the same
maintainers?

Best regards,
Wenkai


