Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7647A96B0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjIURA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjIURAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:00:39 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED632110;
        Thu, 21 Sep 2023 09:59:40 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-414b0bdea1cso7215091cf.1;
        Thu, 21 Sep 2023 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695315571; x=1695920371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6ycq4RYW26n13+qG8PeK+HELns5NdBnVW6wjHVW/9Zg=;
        b=Vm1UcpU1UBQHpLJwRCtjm8rvyylUw+x7fZLFgbKYAn7lTmMFSkFsPBXPwaLNBtZ0L/
         1fhV1b6eU4hwZonxDEciXdIrQdO3zC7yaJNWifdEKw+zrmKs7VFtktgJZteREP2uH4hc
         EQstS+CgxtYilRVHeMfvSENZrn5dudc+WyRnjOFGeQSAoPKtcsGYZT1MT/JtLgJDizuJ
         Bm4CLC71uqkuDRUKQLYMw+7ahIWduaa31qIxdm/riiOcve3D752vIF3N+cwFQbwagbeV
         cpOqN3CTCtNAMTBfHczLY/QI8oORNbvQfkuGPx5D8Uq7SKtDkw3kLimdZrWu4JOMdnvV
         5bOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315571; x=1695920371;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ycq4RYW26n13+qG8PeK+HELns5NdBnVW6wjHVW/9Zg=;
        b=j99AkCrCikODUOyTqEZcgOmmHTxafU24wuruBhJRTNtYoH/vPgmIqOsE5Nsp0G9540
         WNsiXfKvIPw12ZrHiaHYSD1hPM6K+3dCy/lCEhFhbxMJL3zmsYqCm6KQwncuI5+ZLL54
         X0079c6Y2F0NGHfTePevvgAnFis5IAIvvEhkoR28ECrVTIdJWQZKUztBwlrTUqH8SGd8
         ZRFsQfde2k4aYgcORsZSZ8wHTofCO9Oo3P6XE21oBKcN9EnXIXDjE7wYhoFtB6j3Lm8R
         Ec7pFw7esQVPttzx8ObIT2HF5Y1pTSGhGeJwby3b2xmbPA7Czwbvw9W1ajCxVDHGNV89
         9lyQ==
X-Gm-Message-State: AOJu0YweS5ZdTSJ6afmdGLID7Yy/whSYqSXA60R1YVa8CT/qtWMJWhhs
        djSjHFSrBJqF3FSSjF6ApkX9JNcu87o=
X-Google-Smtp-Source: AGHT+IEN+KM57bCdf4eKScy5SarZ26h+zSVsgMksHHBbzP/crbWScGaklsxqFqMvuGvsI/qe78DgaA==
X-Received: by 2002:a05:6a21:3394:b0:13c:988c:e885 with SMTP id yy20-20020a056a21339400b0013c988ce885mr5624763pzb.56.1695298926170;
        Thu, 21 Sep 2023 05:22:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v13-20020a63b64d000000b0057783b0f102sm1069390pgt.40.2023.09.21.05.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 05:22:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f0e0f90f-d24a-6d71-b3eb-3e15e834f7b2@roeck-us.net>
Date:   Thu, 21 Sep 2023 05:22:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4.19 000/273] 4.19.295-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230920112846.440597133@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
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

On 9/20/23 04:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.295 release.
> There are 273 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 

Building arm:allmodconfig ... failed
Building arm:imx_v6_v7_defconfig ... failed

drivers/pci/controller/dwc/pci-imx6.c:645:10: error: 'const struct dw_pcie_host_ops' has no member named 'host_deinit'; did you mean 'host_init'?
   645 |         .host_deinit = imx6_pcie_host_exit,
       |          ^~~~~~~~~~~
       |          host_init
drivers/pci/controller/dwc/pci-imx6.c:645:24: error: 'imx6_pcie_host_exit' undeclared here (not in a function); did you mean 'imx6_pcie_host_init'?
   645 |         .host_deinit = imx6_pcie_host_exit,
       |                        ^~~~~~~~~~~~~~~~~~~
       |                        imx6_pcie_host_init

Guenter

