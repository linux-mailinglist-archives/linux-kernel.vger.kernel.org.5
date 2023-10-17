Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E367CCA59
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 20:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343819AbjJQSHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 14:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjJQSHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 14:07:38 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7A293
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 11:07:37 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507a3af69d8so1210685e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 11:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697566055; x=1698170855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A/3/619f+Q25m7gUwsaHUF/akHXjvSwe1+LWiXMJ0Gk=;
        b=SFi6NWF7i9saHf1pi/RYv1eHZWp3DWRcQMbR0IxaxXvbLXJzMjpP1UMtsihEpYRWlu
         m8V4fPjoe2isCp+JqARnQmIBK88Ij2uS1kdZN8gYiQFP/30t2IlfIOYBaBXWA2ru7fpE
         NanVByh8EO6nhGj9pxp3gOq0tXjUBW+DAa+vDcrbJ4+1hEA6zUZNx8k13WwGCvziW/2y
         70F82CuaY/oWPLlZ2amHCKf+FjeRJBmGFpjcikWUNiNxdWfz7M1FFzo59LYAwSFHGEoi
         3+j/nCiCIqRpEjh/6sQxdGC0TX/L0bBn1ksrO1MGSstktIC7BkVOCu4fuzpO98gZEEPS
         vFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697566055; x=1698170855;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/3/619f+Q25m7gUwsaHUF/akHXjvSwe1+LWiXMJ0Gk=;
        b=MnEjmIV6XedPoml5TgfyEy2xkK9l7+56tnyAi0wkvZNxCAmagj488YMEaxp7ymAlnF
         lyjWjpn68dSydgWFnLAORq5zuTFGXvcY2KxTp9/yEAoiuDq/4/+x4GlEd/N4JC/xZdvo
         xY935rY3cHNZ8O48hTfp9Gzx8ttHtrNnVYs3jyyHfmtEDF+lUuKYv4eTe3KOHMMuMPhy
         +h2YfjPQ0dfAngaTLi/yWC7Nn6D/oM3RXLmoVnpBEuTnmHyu1iWuDadY1B8741zGwe9z
         +GpKWXmRfMsqqIBZA86OIualboRSVIDbb1U09+olnv6AcAjqTp0SK2J+2INeBGxdUfI3
         ZVQA==
X-Gm-Message-State: AOJu0YzvP9NguVeCxYOR0f8rlTLMMH+HigfC4bBed09bOF3FUORSEU2P
        8KUulnR5oanFO0eIPbLLHkA=
X-Google-Smtp-Source: AGHT+IGbPFD0bcE5wCs1htp9GU5eeHdcWq1LsHPM6G0yMoj/MHBbqHcqGORyISlDm6kxnblk/eo4YQ==
X-Received: by 2002:a05:6512:3d25:b0:505:6edc:b548 with SMTP id d37-20020a0565123d2500b005056edcb548mr2522823lfv.2.1697566055251;
        Tue, 17 Oct 2023 11:07:35 -0700 (PDT)
Received: from [192.168.0.104] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id c12-20020a17090603cc00b009adce1c97ccsm210358eja.53.2023.10.17.11.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 11:07:34 -0700 (PDT)
Message-ID: <337b7086-98fd-469d-a9ce-36b2d8a20559@gmail.com>
Date:   Tue, 17 Oct 2023 20:07:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8192u: remove entry from Makefile
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thorsten Leemhuis <linux@leemhuis.info>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
References: <2023101709-amuck-upward-46f1@gregkh>
 <51fcd05c-cb8e-420f-be62-0c9ade82fbfb@leemhuis.info>
 <2023101757-defy-spiny-4faa@gregkh>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <2023101757-defy-spiny-4faa@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/23 15:35, Greg Kroah-Hartman wrote:
> On Tue, Oct 17, 2023 at 12:35:57PM +0200, Thorsten Leemhuis wrote:
>> On 17.10.23 10:13, Greg Kroah-Hartman wrote:
>>> In commit 697455ce4110 ("staging: rtl8192u: Remove broken driver"), the
>>> driver was removed, along with the Kconfig entry, but the Makefile line
>>> in drivers/staging/Makefile was not updated, so things like 'make clean'
>>> fail to work properly as they will decend into all subdirectories to try
>>> to clean things up.
>>>
>>> Resolve this by removing the entry in the main staging Makefile.
>>>
>>> Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
>>> Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Fixes: 697455ce4110 ("staging: rtl8192u: Remove broken driver")
>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> Thx Greg, that fixed things for my case. In case anyone cares:
> 
> I care, thanks!


Sorry for messing up. I did a compile test of the entire kernel but I 
was not aware that I also need to test 'make clean'

Bye Philipp
