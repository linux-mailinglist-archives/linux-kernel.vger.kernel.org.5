Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0600878DD46
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243528AbjH3Ssp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245721AbjH3QBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:01:18 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B0E193;
        Wed, 30 Aug 2023 09:01:15 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-79268f36c49so199448139f.2;
        Wed, 30 Aug 2023 09:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693411275; x=1694016075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=a0lynSDcK/MXZGjR4De6oBFmLDHnkmxoSqFwHMUU6wM=;
        b=XLyfPCMjsQqi3dP7vxUMv0g9IhBPQ1zecdWuiDb0WIVMyrmxVKzH+V3X/O+LqP4XAs
         VuoBeqfcaOy+KcT0XfkYF1YizIAy0KxHCJ4aF0dlUzyw/dd5SRFtHgW15HVrBeC1G6Kw
         wasxqAMKQZ+b1Usrai4UM9XHuiUrnBYW4I1Hj0YyO5+uMiSXszdSzW29AjmTIwX+sn3I
         tj07xHmHsx5cyr9QzP1+IpFfXvk1D6IrFjjLlOYu7rbsd+oGrlOVGSpcDtPnusc6SwTv
         o9ZxxaLIjS6/LsRZIWiKp3vBVsZxbeHjq9/A8TLsc+ZCV4ZHwNaNUV7E3f63Z5fjvfWP
         zN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693411275; x=1694016075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0lynSDcK/MXZGjR4De6oBFmLDHnkmxoSqFwHMUU6wM=;
        b=ghtfxh2FATrN3zDmot5nKasdcs+NWRqWkj4r8Yk0UkqcYMwlHt7sz7/g+sitfttULy
         c0E/Vl+DJFmA5SGmJgu8K6T4DYhNp3gZyNfPBiePe/sW1pJYKW1woSIgJ6wL5SNcGtot
         oYa4AM3Gq7/f3gvSPDynQ5arXxKCf56cCn5Y1RE2z9Kv7j67nRbEacN/nhptKVwURH4Z
         tYWPPQRdH1ZU/2rOB0kFKhInQu7H6DBX9pv5+CW8U2oDdWKAMcu+RCS71dKg7dCgaTeA
         3Voesjk0D7D3dSPwjyLfRbG2D99avueFHwrFCeFR39Rs+9D2WAURSVzoI2bhYsdpQk2u
         rN8A==
X-Gm-Message-State: AOJu0Yy6188mAe++YxSwauNbOSbPbPrHI1Ar+9t3HWvqJP7p6RwgFloP
        Ua8fC2zSgFhKhkBWWGEqtKE=
X-Google-Smtp-Source: AGHT+IFzA/jm06wu9XBZD9WV48KxFNNwIokByQmj7lSAa+tgEyR2kaWks0wCGP/f5dB32IdG6oNW0A==
X-Received: by 2002:a6b:e801:0:b0:783:572c:9caa with SMTP id f1-20020a6be801000000b00783572c9caamr3291689ioh.0.1693411274776;
        Wed, 30 Aug 2023 09:01:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n3-20020a6b5903000000b0077e40979b41sm4012584iob.45.2023.08.30.09.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 09:01:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <64374066-4086-3e92-8650-ab1563350f0c@roeck-us.net>
Date:   Wed, 30 Aug 2023 09:01:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.10 00/84] 5.10.193-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <20230828101149.146126827@linuxfoundation.org>
 <5b30ff73-46cb-1d1e-3823-f175dbfbd91b@roeck-us.net>
 <2023083014-barley-upscale-518e@gregkh>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <2023083014-barley-upscale-518e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/23 03:52, Greg Kroah-Hartman wrote:
> On Mon, Aug 28, 2023 at 09:42:11AM -0700, Guenter Roeck wrote:
>> On 8/28/23 03:13, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 5.10.193 release.
>>> There are 84 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
>>> Anything received after that time might be too late.
>>>
>>
>> FWIW, commit 619672bf2d04 ("MIPS: Alchemy: fix dbdma2") should be reverted
>> v5.10.y since it doesn't fix anything but breaks the build for affected boards
>> completely.
>>
>> arch/mips/alchemy/common/dbdma.c: In function 'au1xxx_dbdma_put_source':
>> arch/mips/alchemy/common/dbdma.c:632:14: error: 'dma_default_coherent' undeclared
>>
>> There is no 'dma_default_coherent' in v5.10.y.
> 
> But that was added in 5.10.185, from back in June.  What changed to
> suddenly cause this to fail now?
> 

Nothing. I started to build this configuration and tracked down the
problem after the build failure was reported by others. Sorry, I didn't
initially realize that this is an old problem.

Guenter

