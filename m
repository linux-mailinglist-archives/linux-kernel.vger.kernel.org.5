Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBBE76272D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 01:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjGYXFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 19:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjGYXFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 19:05:30 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A1DE47;
        Tue, 25 Jul 2023 16:05:25 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6689430d803so3759773b3a.0;
        Tue, 25 Jul 2023 16:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690326325; x=1690931125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+Rj5HE+U7eILrOCnywUgryQcn05XBMLVDPwImnu2yQ=;
        b=fdLyJVPOR/Q7tVlvJo9S4VR7dGrlRV+GhT9Tia9yYAq+3mpyNrJ42gC7S34jT8qQIh
         nSEuAvM9051/3Vj1Z7Tl+qFsp41VWqUylatlnrcdsQ8F+n2aoPv7f0bha4ZDy6HeJ18t
         4YFIm5JXkn0nFRbJWowSE1aRhwOcgTQFPDibwfFffEovnBMuKcxIuHYaCt08oUoO9kfn
         ZytoPsiBND2zT05LtikjbUpq+OrEVUqZp4tPwHhBlL4M3fq7H7xVGffFJQfrcy67SXAs
         QzjO5sjRRGj1Y6K91mpcj670616djZ9e5Pq3MzrNaN8HGWJ4JQHM6BUoqauwdGgPWk6m
         I/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690326325; x=1690931125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+Rj5HE+U7eILrOCnywUgryQcn05XBMLVDPwImnu2yQ=;
        b=bV8FYvd2JysDNBuAVYJS+Le5TBtIbzZJrvqInS4KrMBs74ZRO1cPJP3efZhsW8HZVv
         Nv+yJP0D4pA0vCxhocZhsuGWG9QGJ94WyzDHAemHIH9E8M66IKdxGWW0J4R8bYh+yc/4
         sgPy8BwEbFgxIshGWdcUepaeq2KTd54XajcCTfBYn++0jM+THuHqjvo34Wiv/xEecYHg
         Bd7MocAWHyOIbaKbX7o0chmmyWqv4oVk8alxIoCaRXN0jEsAFDj1RXFio7WxeRTwyGDa
         1Yp4a/e4NkoKBlrxem+OKYVfw5fDwrB9tvObQVkXj33XNiuxSOaGtgA+KMYCM+bc7HyN
         NlsQ==
X-Gm-Message-State: ABy/qLZ3+3XIudwubJNyAyH1ArINPgGKBCUSOl5QPmScHdxsfWmaRiei
        vG1NN0BHJa5Iln/5geYw7RE=
X-Google-Smtp-Source: APBJJlHi3dgidEaSE0dFIGHL5Now0nZ4TpUmbeH8G3nq5VuJfWmw5hdmCqVsCKwY6/udTT+GDgUapQ==
X-Received: by 2002:a05:6a20:9697:b0:133:ec83:598 with SMTP id hp23-20020a056a20969700b00133ec830598mr308514pzc.28.1690326325180;
        Tue, 25 Jul 2023 16:05:25 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c16-20020aa78810000000b006828ee9fdaesm10082027pfo.127.2023.07.25.16.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 16:05:24 -0700 (PDT)
Message-ID: <19226f61-7e47-eaab-f463-50b88ae1f2f0@gmail.com>
Date:   Tue, 25 Jul 2023 16:05:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.4 000/227] 6.4.7-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230725104514.821564989@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 03:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.7 release.
> There are 227 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.7-rc1.gz
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

