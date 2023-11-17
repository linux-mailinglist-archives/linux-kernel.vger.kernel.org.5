Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A350B7EEBCB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 05:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjKQEyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 23:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjKQEyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 23:54:17 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9CD1A1;
        Thu, 16 Nov 2023 20:54:14 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso1215846b3a.1;
        Thu, 16 Nov 2023 20:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700196854; x=1700801654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/lmKwmdeL65ZlMvWyE8ViyW/IEvLXZ106QkyWY1HoSE=;
        b=Vnge7/5biuqSbk0RzDLJ+6eoIX/gdp1M90IHNnXc34hA24LYKK36nbuFSp5Itej4jD
         B7aUS1/O5ekEtWFsxhwzDCteEoteXGg+0PpdcVuzlbPB3SMhn3/IMynZlaBQmAalNb0n
         rmL7M9mlC5YKukCNQE8qp/juNsUaixBVg2pwv1wvVAiJF2tAquCsAtkjpJi4SXoXIdv7
         F4+S1pfyR0aiFTVQZMFif1Y4jOvN42qvMAEJrtcvxoW7nFiZdSvC4G6VUQBIUim+UxZJ
         6eJdVcvZ7XJvprVAFKEHV4qCqZaNVAYfB3UUU04o3CUu3DNMYi7bhSwIascyyfeVJbp3
         fZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700196854; x=1700801654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/lmKwmdeL65ZlMvWyE8ViyW/IEvLXZ106QkyWY1HoSE=;
        b=UJqOY8TQ6WhS2IMtyRY63v2rYoTvKF2mAhqOxXJdyPWCNF5xp4MvKKRc1SXtDA3YlX
         0K4fdcYADmlxOafEwRVn84P/nMOJqa9wlwU6p/hqr3T7dv0dC2H2a75UOYTPpT+Zxrm7
         4h4zlAfM65b7i+bKh62T8/eqKmCB59DQjs8HPWCQkPK10nwTao9dqczjjg1BcUfsDCTq
         4nedr3zr47lxJL4IU/C+HnqNHu3HFfBQyGKUBQpX1beOBEnlHI8QzQ9P1v+lXJ1tsQpy
         A2wTPmotMBzpa/lD4h31+yLw63g1BqIgP/k7edDnNkkvxVJJodYBUjwmpPcD9VXzmAzd
         CJuA==
X-Gm-Message-State: AOJu0Yz/fNLC7RtBiEz9vU1lG33qcqnhSuk7f4z7WD3stw9GWOU7hnVR
        Rvt4s3+nVbN9YVf8Q/RXTYBTWR6S4tU=
X-Google-Smtp-Source: AGHT+IGEWBjc364kyBtrL2ltQbOgcPCiHETUvmBsIqW35a7IsgEIWjdVMMe5fccFaEPw0ylxLY/kTA==
X-Received: by 2002:a05:6a00:310f:b0:6c4:d6fa:ee9d with SMTP id bi15-20020a056a00310f00b006c4d6faee9dmr5104694pfb.1.1700196853698;
        Thu, 16 Nov 2023 20:54:13 -0800 (PST)
Received: from [10.10.14.80] (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id v1-20020aa78081000000b0065a1b05193asm568042pff.185.2023.11.16.20.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 20:54:13 -0800 (PST)
Message-ID: <7080c9f3-2a57-4855-be1b-9a206f6ef8e1@gmail.com>
Date:   Fri, 17 Nov 2023 12:52:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: Add mps mp5990 driver bindings
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joel Stanley <joel@jms.id.au>,
        Chanh Nguyen <chanh@os.amperecomputing.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
References: <20231113155008.2147090-1-peteryin.openbmc@gmail.com>
 <20231113155008.2147090-2-peteryin.openbmc@gmail.com>
 <a3445201-58f2-42c6-bef7-ca6968fd80d6@roeck-us.net>
 <69657f96-4849-4134-911d-4785d5d6b8d8@gmail.com>
 <140086a7-c89d-48b7-9574-7db28dcc056e@roeck-us.net>
From:   PeterYin <peteryin.openbmc@gmail.com>
In-Reply-To: <140086a7-c89d-48b7-9574-7db28dcc056e@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Guenter Roeck 於 11/17/23 12:16 寫道:
> On Fri, Nov 17, 2023 at 11:18:47AM +0800, PeterYin wrote:
>>
>>
>> Guenter Roeck 於 11/16/23 06:27 寫道:
>>> On Mon, Nov 13, 2023 at 11:50:07PM +0800, Peter Yin wrote:
>>>> Add a device tree bindings for mp5990 device.
>>>>
>>>> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
>>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>>
>>> What branch is this patch based on ? git fails to apply it.
>>>
>>> Guenter
>> I think I don't pull the last version. I can rebase it and push the new
>> version. Thanks for your feedback.
> 
> Question is: Last version of what ? Best would be if it was based
> on mainline.
> 
> Thanks,
> Guenter

It is base on Linux 6.5.4, OpenBMC Kernel tree
https://github.com/openbmc/linux/commit/2ba0babe7865cd5f4fac3d76ad15d9b6131bd283

I can regenerate it on mainline.

Thanks,
Peter.
