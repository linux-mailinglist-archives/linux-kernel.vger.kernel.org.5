Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A132C7D3977
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjJWOhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjJWOhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:37:41 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D0BDD;
        Mon, 23 Oct 2023 07:37:39 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9a58f5f33dso3125365276.1;
        Mon, 23 Oct 2023 07:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698071859; x=1698676659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GD6GktRQA8yNZ+0bir+1mpmuzkKcfcqAuwhKX54GTeM=;
        b=jdwRoCI1G3gxwAxsMoetQmLTwrfK7yg33jfn7E1r/9zKU+TVewGCEJ05LzVpsKYYiX
         PM9d5jDclqQZb6w60fSMpCPQ1WivAKCFplkc9QR4+K5VtR8T6kUzd1zRirfinlZDAEBu
         tqW+KsPXJoA/VKMARIWwDKTixOm3NVMX5HKBKyw9gjqXxty3/HOOCqHveAoutGyf1Etm
         OgsPWsZPi9PbirmNWjtKJz3kg7kyvy9sCy2miYevW03QCenkCdE/rxR4fzu8J31xXNxT
         y9rS4TNQMpmkDP6ZNHeTTDW2QI5LiIUjTmqceBssUAzaJvwC1Zx5UTe7MMvyyTkZJNMl
         T/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698071859; x=1698676659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GD6GktRQA8yNZ+0bir+1mpmuzkKcfcqAuwhKX54GTeM=;
        b=Qmvb7AEtcztpZoeD+3YZbOdRJ9+b/PlOrQfvqaTmmRkTMJLiqkRpGzCHtVDJcorMiy
         OWArT6Z2v53QsMKT2JPlZHeXjUEc2kM+IEanbC5qwzJHo7gPqMrhiARm3YE8/jE9vJWe
         4S++9w6vPlKcXUCav4d4K2wxCsJLWuqJLWM8B6roigOfgqrI+RCR1hjoC6YLyFmRgeDf
         4AQ0HYUm6TcKIVdJqFrNSS1s2TI8MuX7DNi7uZ9ZU6WohzsL0BF6wbhaEroWWS6iKbmm
         VtfqWIyFndqWB8HLGKvatiwfFGcTWEUJafZiLVDOC+GPnxH4ctDG/VlIxL1ixGZefZvf
         BAwQ==
X-Gm-Message-State: AOJu0Yw9/gjZY2lKdXtTjzN9/A/gCiA9N0C+0BiyB4E7KxVSa8hP2IAH
        jOMyJdh3PyZlvNHWohiJV+Q=
X-Google-Smtp-Source: AGHT+IHlNnVJG0aPd0n5jhr07oAGy616t7g1PbVB+dq4ioUiC/w/rkWTiYrDoff9rT4Sc1vxM33F4Q==
X-Received: by 2002:a05:6902:1890:b0:d9a:d196:67c1 with SMTP id cj16-20020a056902189000b00d9ad19667c1mr11112332ybb.10.1698071858942;
        Mon, 23 Oct 2023 07:37:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w10-20020a25ef4a000000b00d815cb9accbsm2727163ybm.32.2023.10.23.07.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 07:37:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f3b2a4ac-042d-4c20-4020-3a09822811ac@roeck-us.net>
Date:   Mon, 23 Oct 2023 07:37:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4.14 00/66] 4.14.328-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20231023104810.781270702@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20231023104810.781270702@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/23 03:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.328 release.
> There are 66 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.
> 

Building s390:allmodconfig ... failed
--------------
Error log:
In file included from include/linux/kernel.h:10,
                  from arch/s390/pci/pci_dma.c:8:
arch/s390/pci/pci_dma.c: In function 'bitmap_vzalloc':
arch/s390/pci/pci_dma.c:536:15: error: implicit declaration of function 'check_mul_overflow'

Guenter

