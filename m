Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DF278B582
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjH1Qmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjH1QmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:42:18 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB9AF9;
        Mon, 28 Aug 2023 09:42:15 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a81154c570so1979551b6e.1;
        Mon, 28 Aug 2023 09:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693240935; x=1693845735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=07+BqHH2fvjqSJVcNPgMWDKWkC2DZMaqXd0rPYXV11E=;
        b=MzKTMIdKFjKyzdis9lZD2DJaudlaVtLPRBvUUxdtaNKYyaGkyoFdBr88+bo8oiuqDX
         J1sHRygsdtUHdH4Xc554WDcOR4xRNJSJGyE/iLyINu9Rmw02s4cRG3y71mtWx1u0lBGN
         TZmwgosaJQWK4zz4/j2DHgNA7NTzq43QAZF11SFyqpZifHKWauCDdd8xT9zOg/q47iQ1
         qnlfBxkavy3jcWDo88V6UwNrOFZPWEZKohjBClAKSIDHMfcfV7olXDtVVDOF8h07nATT
         3RW2PHgP+1TKJfkuKaA4kpnsCutp9Fj2i7shH0p3GsEiRzu/1XDwDc+smnfuB2gTYdqe
         Ay4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693240935; x=1693845735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07+BqHH2fvjqSJVcNPgMWDKWkC2DZMaqXd0rPYXV11E=;
        b=EgE17wuX+yVdNJkgC0CuuAdupW/rN2VXh0q7YXK/NQWNCTUNKV6rO3a6SkJovjstpG
         UwUShSvUG/upCRNLRUSN8b+9TXSXebrSjswaNHKsoO+i3aGDO+6sHxampQ698uDBf1H6
         mo57wrJE3egk3e3DeC/FdqnypqxyLl6sx7SCdkMrmmbHfFpIVpMYhVkMr52jPp1k+0Ty
         tOVwCPqnyPpVinWfn0Y3B1Gae1nRyc+BBT9+Q5g6Y8XjZG5aMps4wFHcCrsy8+qwmJh6
         R5WbnrBBPFwceWRxJ7GEOtEwAnI3uyhxt/tYITpCbV0t+1M62BofVNqkCzH84+I5sjFa
         UINA==
X-Gm-Message-State: AOJu0YwmksRzCNNvqP68RlY9oBSdTgzOlbPdcQMnqpDQ/fGI2tZmPCxB
        Xe7VbbTNAX2UXW0KXBMj524=
X-Google-Smtp-Source: AGHT+IHeyhhWz7KeiPmmlRz0UTwkUc3V1SpCjjgwkl9iq5cJY9klp2pXz7fWqIjdSmUlVLaT0oWU/g==
X-Received: by 2002:a05:6808:1892:b0:3a7:56a7:6a91 with SMTP id bi18-20020a056808189200b003a756a76a91mr11967872oib.23.1693240934952;
        Mon, 28 Aug 2023 09:42:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z190-20020a6333c7000000b0055386b1415dsm7508224pgz.51.2023.08.28.09.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 09:42:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5b30ff73-46cb-1d1e-3823-f175dbfbd91b@roeck-us.net>
Date:   Mon, 28 Aug 2023 09:42:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.10 00/84] 5.10.193-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <20230828101149.146126827@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230828101149.146126827@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/23 03:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.193 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 

FWIW, commit 619672bf2d04 ("MIPS: Alchemy: fix dbdma2") should be reverted
v5.10.y since it doesn't fix anything but breaks the build for affected boards
completely.

arch/mips/alchemy/common/dbdma.c: In function 'au1xxx_dbdma_put_source':
arch/mips/alchemy/common/dbdma.c:632:14: error: 'dma_default_coherent' undeclared

There is no 'dma_default_coherent' in v5.10.y.

Guenter

