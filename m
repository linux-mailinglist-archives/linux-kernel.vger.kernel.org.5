Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08DA7A95D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 18:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjIUQ42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 12:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjIUQ4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 12:56:25 -0400
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA522F1;
        Thu, 21 Sep 2023 09:56:11 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7ab30cee473so414543241.2;
        Thu, 21 Sep 2023 09:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695315306; x=1695920106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bRKrkoX546m0rrXqj9LX34in6kCX9Nm6R0nAMVnYoZ8=;
        b=jEjyNGD0pNZoMvuQ9M8xPhUSeOzMM5K7RuKha+V0T//QfbIMW3/9ekI2zMcDnarUSZ
         SfxBbz5QBjUAfw3G72qYilck0zgAouokR3Sx3UmeHoZmJi3apyAUVXOpFjzjjRyeEWF3
         YSI/CmWb6aFXgHfS+b+OUYTK1lkaX2kGbTdOppE3HbV/c5U26WmKwfyb5LNoJdv462zQ
         RydEXf22/dDj6iwF3Mg1j3FobTs0MbBeQtywCsv0epjGYnuRjIJ5f4pYQgFvu2nzNhJD
         QEDRMu8y7HWt3RJal7Obhow5nf5MbVmHNyxcAUfNRyQzfpZptop5gaDAfCSk3F9En/tj
         pZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315306; x=1695920106;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRKrkoX546m0rrXqj9LX34in6kCX9Nm6R0nAMVnYoZ8=;
        b=HP76TAEPpkG9XyUgMQJK2VCO11QsPLgDarlfstTu1frnugAdWeNvmAfFJA3gx/Az8S
         bQnJfNkg6keP7HTbly/7W5wUXC9eP5JvoV1mggW1vZBNfR8xtLrjULNJizCgM1XHxiyS
         tfzGE9mXjSz+Z5PJnEGkUBrIqkf4Zih40RFbuNdw+o+YnNR1CJlpkqqQc5jWwio1NpRV
         Bl+Ww+qdbhuK4m42zVbT1t84xftHVtN4cHFxefbKPwuazYramMDXLOXrtv5Y8aII2EcW
         /QxXr43lp2qpjGwRCg3WvnXSkF5g2Nxz6Bt5Hkt9km6a+u8ABB4b8e4xOAAu35rRnjo8
         GNgg==
X-Gm-Message-State: AOJu0YzFUzSRU2CoUW3X8TjfL06cTrPywLhaFfJmeTlwsp7Gzy6RIlov
        tjZ2oQ1MYvqxiilYwwPSayR9TDqQO2Y=
X-Google-Smtp-Source: AGHT+IFXkcZZ+FrJWIgtoDVWXF5W0k54s49OSuzsR2iFUk3hqay0ZRvvpO/yos/ac4Y/QrCf4RUZng==
X-Received: by 2002:a05:6a00:3697:b0:691:2d4:23b5 with SMTP id dw23-20020a056a00369700b0069102d423b5mr1600110pfb.31.1695298820050;
        Thu, 21 Sep 2023 05:20:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v3-20020a655c43000000b005782ad723casm1067235pgr.27.2023.09.21.05.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 05:20:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1885150a-6caa-8d92-f893-02bdb5ee508d@roeck-us.net>
Date:   Thu, 21 Sep 2023 05:20:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5.4 000/367] 5.4.257-rc1 review
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230920112858.471730572@linuxfoundation.org>
 <166b5b43-adab-7d00-e3f6-c9a1dfd29f52@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <166b5b43-adab-7d00-e3f6-c9a1dfd29f52@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 10:21, Florian Fainelli wrote:
> On 9/20/23 04:26, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 5.4.257 release.
>> There are 367 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.257-rc1.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> perf does not build with:
> 
> libbpf.c: In function 'bpf_object__close':
> libbpf.c:4205:15: error: 'struct bpf_object' has no member named 'btf_vmlinux'
>    btf__free(obj->btf_vmlinux);
>                 ^~
> 
> due to 34d66b750e83d49c7d3d33d59e6a1b49e0d5db15 ("libbpf: Free btf_vmlinux when closing bpf_object")
> 
> the btf_vmlinux member was introduced with a6ed02cac690b635dbb938690e795812ce1e14ca ("libbpf: Load btf_vmlinux only once per object.") which is only in >= 5.6.
> 
> Suggset we drop that commit.


This problem affects 5.4, 5.10, and 5.15.

Guenter

