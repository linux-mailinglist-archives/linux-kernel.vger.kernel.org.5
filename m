Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B1D7779F2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbjHJN4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjHJN4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:56:04 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F9B212B;
        Thu, 10 Aug 2023 06:56:03 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5650ef42f6dso651964a12.0;
        Thu, 10 Aug 2023 06:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691675763; x=1692280563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/qNf1jUmQ5AJ3ccwof1ni8PVa5vG7hwpnzsTFeeHHG0=;
        b=mQxrpYaxk7oymnkuSRRBt6hvoyB3PlaFaVSzOKMz2cuQ2wRS1xqg6/Ttw9afs2d7qD
         vgpvfEJFQfdNBJc3WXfwUtOY2rED0nAlpSyurnywHPr21PNbjeboPBz6axYAU/gL2Wxv
         /o5wqw8/I98QxnrDy+CdxnuFFq9PDi8A7iRna4BMmp03gCTjdX7JLACmjGseF7gdvpbq
         btONHKzb74515L6Q0uyneuNDekF9JpwzI8b4KdbQyhEh9jcUnh0f3aGt8aSziFJsw+na
         yLZydGT2gkd3Sw5+/NyqLCscM9R1pvIqWh04bNGRm4JGvSkbW1xqjhW0OxyDPQR68tCT
         Ogaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691675763; x=1692280563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/qNf1jUmQ5AJ3ccwof1ni8PVa5vG7hwpnzsTFeeHHG0=;
        b=cIzbWJYRwsGOl0R06W4b2LCsTteNULUvSI+q9fPJETFfYhflvx7PDOW2NwI8Y2RhJG
         WQINNcs9qhvvDPcZj8AXsXdNhqWoL2KUbkEDAVbcJXz/l4JLp8DOMLEf3SyAJ20uVcXB
         yfS3ACAI2Bnu4f0xP8gk8BarG1Zzo2nxdnfmPo7E8AlEhLGQM0TwpMazJvu3X8HdmzL6
         apH8/h2xu0CjtV04GZgAYGrkm0rscZqeIui5FO+86qHTEOOIWqguqE7W2+O0g4AXbpv9
         gAHFJaYuTxZtVMzTw1HaZtXIl+hYG57cx5g5f/jBssI1T2Z6d6NbF6kDwvKDE2Ub0624
         jguw==
X-Gm-Message-State: AOJu0YwHQWzHkdeFP1qsXy9Sm1sffDci7m0M3l4kxTINQSDERWgINdDP
        sGBBIR9qjOnUqSnVDodasvw=
X-Google-Smtp-Source: AGHT+IHpn8ltlBnxjIjjir8pQSNqOUUTXlXgA/HNA4ErfhqunG4YVK+HSA0MsAc1vBuj2xsf0nKG/w==
X-Received: by 2002:a17:90a:4f86:b0:26b:e80:11de with SMTP id q6-20020a17090a4f8600b0026b0e8011demr1110779pjh.25.1691675763346;
        Thu, 10 Aug 2023 06:56:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902821000b001b3fb2f0296sm1774123pln.120.2023.08.10.06.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 06:56:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9d35afea-e1b4-72d0-9559-1eccdfd069a8@roeck-us.net>
Date:   Thu, 10 Aug 2023 06:56:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4.14 000/204] 4.14.322-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230809103642.552405807@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
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

On 8/9/23 03:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.322 release.
> There are 204 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 

Building sparc64:allnoconfig ... failed
--------------
Error log:
sparc64-linux-ld: init/main.o: in function `start_kernel':
main.c:(.init.text+0x77c): undefined reference to `arch_cpu_finalize_init'
make[1]: *** [Makefile:1049: vmlinux] Error 1
make: *** [Makefile:153: sub-make] Error 2
--------------
Building sparc64:tinyconfig ... failed
--------------
Error log:
sparc64-linux-ld: init/main.o: in function `start_kernel':
main.c:(.init.text+0x764): undefined reference to `arch_cpu_finalize_init'
make[1]: *** [Makefile:1049: vmlinux] Error 1
make: *** [Makefile:153: sub-make] Error 2
