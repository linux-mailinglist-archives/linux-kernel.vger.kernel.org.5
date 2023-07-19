Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33881758CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 06:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjGSE7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 00:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjGSE7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 00:59:05 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E351BF3;
        Tue, 18 Jul 2023 21:59:04 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-99313a34b2dso778675966b.1;
        Tue, 18 Jul 2023 21:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689742743; x=1690347543;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j73OOjIeRuMj/hW5XddSt0G2UN09Sqon0o8YRkFJAmE=;
        b=l/xAU3Tk5Otn7sylrbD0kn4jI/WBp77eixjcwDu9lz+Jumc2k/IiEbRyg37iJxncO8
         Tg7pcuR5zDmcbzqskkojmwtTlQb0b69A1NS1MtdgPDggqhwQThPA1f36hOftwwC34JUn
         ELy7xxcODkYSJkcgu/ghxeLpzunNaHGzRdzXUlCEBuuJD1p6/11Cq/luVbKiUZV2loT8
         +NCjtgDl3xwcLhSy0ubt5IOxlSLpMFsZ1M/QuhgMY84PafkwEL/xK5eUOFUL/COn+vpP
         fj7iMF2SEUqdsw3P8tDzihnvjNEQdbBzVc+pVrNKB6qNCmSPkUyYrxYt2ku3y0E/wVYJ
         rbrw==
X-Gm-Message-State: ABy/qLY92Q9d8oZ63icmQavFIAxcaX1kOPH+kH+QYaQy9PVC13KZwA2w
        hw4dEs3C+MKkaPXF6DmcedE+dApcqTY=
X-Google-Smtp-Source: APBJJlE5FBhwnn+ttSshK5fDq37w5f5hotxC47JdDOGMCuEPnvDrPixrpDDiWdU9TUvzvExhUXBiSQ==
X-Received: by 2002:a17:906:2208:b0:993:f9b2:93c1 with SMTP id s8-20020a170906220800b00993f9b293c1mr1532542ejs.9.1689742742765;
        Tue, 18 Jul 2023 21:59:02 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id x26-20020a1709064a9a00b009893b06e9e3sm1775731eju.225.2023.07.18.21.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 21:59:02 -0700 (PDT)
Message-ID: <29a50d29-67f6-8b18-d0bb-278878f9ddac@kernel.org>
Date:   Wed, 19 Jul 2023 06:59:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.4 000/801] 6.4.4-rc3 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230717201608.814406187@linuxfoundation.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230717201608.814406187@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17. 07. 23, 22:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.4 release.
> There are 801 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Jul 2023 20:14:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.4-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.

openSUSE configs¹⁾ mostly green -- arm is still building (our build 
systems have limited resourced due to move now). x86_64 runs fine in qemu.

Tested-by: Jiri Slaby <jirislaby@kernel.org>

¹⁾ armv6hl armv7hl arm64 i386 ppc64 ppc64le riscv64 s390x x86_64

-- 
js
suse labs

