Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318EC78F492
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347578AbjHaV1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347588AbjHaV1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:27:09 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FF61BF;
        Thu, 31 Aug 2023 14:27:00 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76da1331db9so111157885a.0;
        Thu, 31 Aug 2023 14:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693517220; x=1694122020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OKupqeRqjjG5+ZAE8jQOr7HoDwD4mmWqhqzhxE9SrKI=;
        b=QnyiCWdRrbA/RyCaAQg3I6GxFoYYv6uf1NfaAhtRe15/07V/hvd/G4mdmoO7eV/8Tg
         UsOpPIrfm40X0BygGmg17G+5MtK/tvLD+IUBxDzjYQnHKmTKqudCoJ3/RneeCfiqHeG2
         ccNq+fVYyFbIFn2aF+RlkJBvl5jrSlWTo/h1IFPRCDVlaaiawnl4h3UyrAujdNjQlw8a
         3vavVSgJTiizxuife2Dn6o3wf0Vxp8IbeVhGoM4APbw6p9HaMI5aDxkjFCf82duUM+2P
         w/7v3yLm5jYzw4Yp+yaa3Y1PuiwlF7AmaJD5ZekURDGjdde6Il0h4b7Buhir5mkfIIuH
         3ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693517220; x=1694122020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKupqeRqjjG5+ZAE8jQOr7HoDwD4mmWqhqzhxE9SrKI=;
        b=P+GC8+Y4u3KYLexEFk134LddDRBqUCUd7GYm3qmWsT5idc8MtpUQAXMhuP8/zu4QI+
         4ljGeOlpNvFl0YYGjbb6YouHCu8VHmfjOg8AEOe0FkgxqW5hPn4+Cz1t+xj2sSv3PFNJ
         vTYuNNj1gcIA+Av7xNVsMKWh3+uxKXbHTBK3aGIrxFbCPkCwUqhXeLsjIDFx+h7dbUUT
         +mAmWES66WDkFIB0S8mRpXo5bAfl9m9ZJXlrky+pb2HiHMXUF/fjxDyymko4SBel6RMb
         5js6bogOgUcgUrAAOdc4VsMNwzHUh8xE9l4exAXLBzeZUubaUzxZufSMX3sSN845gThx
         mRmg==
X-Gm-Message-State: AOJu0Yy1R9CWz5u3+/RmZOXVLWypi6GdrJx/9xVCZErP5GJPdI7iinzp
        LZ2augQN5F2hNAgH7jtHDaI=
X-Google-Smtp-Source: AGHT+IH8hKJ4Mmc2oI9vlaszFEwDZpJ7dW2OgV1Y3HBF44zcBYMVO9UjJQvmLZcPpZCnvNsz+Ja66w==
X-Received: by 2002:a0c:f4c7:0:b0:647:3346:1289 with SMTP id o7-20020a0cf4c7000000b0064733461289mr1296596qvm.11.1693517219718;
        Thu, 31 Aug 2023 14:26:59 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i29-20020a0cab5d000000b0064713c8fab7sm923855qvb.59.2023.08.31.14.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 14:26:58 -0700 (PDT)
Message-ID: <fc349a26-a56b-f3ed-65a3-4c18f88b650f@gmail.com>
Date:   Thu, 31 Aug 2023 14:26:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.4 0/9] 6.4.14-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230831111127.667900990@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230831111127.667900990@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/23 04:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.14 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:11:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

