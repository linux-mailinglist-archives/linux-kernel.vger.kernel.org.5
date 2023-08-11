Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75195778C01
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjHKK0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjHKK0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:26:10 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1183FCE;
        Fri, 11 Aug 2023 03:26:10 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bc6535027aso15761795ad.2;
        Fri, 11 Aug 2023 03:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691749569; x=1692354369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=r1wMrImP3oIl7TnYnZRBd/kiTp8CDnvFeGIvme3omLc=;
        b=kw211HDW3C6DGtBp4hm/nrGAufphF+pApN2lnO8vX8y7+DoLwpuDFF6MEBEnLMtfkB
         syhd4BHv/fa+p4/5Js5VgDzhBS7XokW1tbY8fuokKsy+FAwVUkb6Aw2lMhkrDZASsDaH
         dlV60EscI5fqa4wB8UFBWNDkre83WVI6KPF5FjBRbNNaCOezjUI3MIWO6/h7gZqiEK5S
         MZwqNpYN5C2pDTnCXQ2q6483CaNDTxhDA9juKoP1xzE9h+tjINWrHsLtgc3VFqo3SGWr
         Opvi5D485TqztozfCy12Cj8Cuo5OpVRA4RNCydHqnr+5J+HYQx6Jy7XQr/FE39DcOIBp
         cJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691749569; x=1692354369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r1wMrImP3oIl7TnYnZRBd/kiTp8CDnvFeGIvme3omLc=;
        b=VIQPJPIcoDAsGnOK6DRM5ixO0qvS8NkxYR3YLadUNXbA5oOymebBpFEGfM+J0SBDlx
         va9T4xDX9Vf9cwNfXifyNdoUVVeq6DPDcbm7VaPbZkHhA4ieWM6WP+XOC/sTk1TKS5FV
         IL5KrTA6Gd8Ux/pKWabjGnRzytmzKBP/EmtXkJiT/xNwyJ3F6LdLJck2GBLERYeAVmtX
         T227vWlOdfZL0/mc2FqacNmSZvH8otaRIo7PPaWYbyW697FQgu4hk1bdSOpWCY28jXae
         czGlaf4lbjiSUtA/lSR68N1H123dipnrzrx7Klwq/ZDI+8p8nZb2auW9aaz8guEk4Pcg
         yZwA==
X-Gm-Message-State: AOJu0YwFzw3+2PkMgRWMZld3n6iNbJuabN+huVDhLAw1EU9RTXKSeKqt
        mii6rr2246TznvN/IFUzuTQ=
X-Google-Smtp-Source: AGHT+IE5CUl1usNd3PreG56ruelbUfJmNhNrXKeuyHNOtKw0oWzyyyUwU6L8Sle3W+KBTNZFT+/Fqw==
X-Received: by 2002:a17:903:234c:b0:1b7:e355:d1ea with SMTP id c12-20020a170903234c00b001b7e355d1eamr1930635plh.24.1691749569399;
        Fri, 11 Aug 2023 03:26:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902b68100b001b53be3d942sm3484033pls.232.2023.08.11.03.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 03:26:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0b8f1771-bc0e-7b9a-bc45-9972fdc58d44@roeck-us.net>
Date:   Fri, 11 Aug 2023 03:26:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.1 000/127] 6.1.45-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230809103636.615294317@linuxfoundation.org>
 <a800f7e3-5a59-4dba-afc8-d3ae5f39b058@roeck-us.net>
 <2023081144-occultist-cytoplast-d7b5@gregkh>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <2023081144-occultist-cytoplast-d7b5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/23 03:07, Greg Kroah-Hartman wrote:
> On Thu, Aug 10, 2023 at 09:14:43AM -0700, Guenter Roeck wrote:
>> On Wed, Aug 09, 2023 at 12:39:47PM +0200, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 6.1.45 release.
>>> There are 127 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
>>> Anything received after that time might be too late.
>>>
>>
>> Build results:
>> 	total: 157 pass: 153 fail: 4
>> Failed builds:
>> 	loongarch:defconfig
>> 	loongarch:allnoconfig
>> 	loongarch:tinyconfig
>> 	loongarch:allmodconfig
>> Qemu test results:
>> 	total: 521 pass: 513 fail: 8
>> Failed tests:
>> 	arm:fuji-bmc:aspeed_g5_defconfig:notests:mem1G:mtd128,0,8,1:net,nic:aspeed-bmc-facebook-fuji:rootfs
>> 	arm:bletchley-bmc,fmc-model=mt25qu02g,spi-model=mt25qu02g:aspeed_g5_defconfig:notests:mem1G:mtd256:net,nic:aspeed-bmc-facebook-bletchley:rootfs
>> 	<all loongarch>
>>
>> loongarch failures as already reported, introduced with v6.1.44.
>>
>> The failed arm tests crash in f2fs (again - previously reported
>> against the v6.1.43 release candidate).
>>
>> [    6.685458] 8<--- cut here ---
>> [    6.685593] Unable to handle kernel NULL pointer dereference at virtual address 00000034
>> [    6.685725] [00000034] *pgd=00000000
>> [    6.686010] Internal error: Oops: 5 [#1] SMP ARM
>> [    6.686209] CPU: 0 PID: 194 Comm: seedrng Not tainted 6.1.45-rc1-00128-g02a4c6c322d1 #1
>> [    6.686350] Hardware name: Generic DT based system
>> [    6.686467] PC is at f2fs_issue_flush+0x160/0x210
>> [    6.686821] LR is at f2fs_do_sync_file+0x7c8/0xaa8
> 
> Odd that you are the only one seeing this f2fs report, does no one else
> use f2fs on 6.1 systems?
> 

It would appear that none of the CI systems does.

Guenter

