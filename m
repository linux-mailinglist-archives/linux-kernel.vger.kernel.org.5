Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A8D761C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjGYOq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjGYOqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:46:23 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9E0116
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:46:19 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-794c5f5ae8aso1602582241.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690296379; x=1690901179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Cq8IRyozLb3SkglqS2g2LxJsUZMe4IMho3GgyuMdRU=;
        b=hWC2i6Wfc9ExzCeHJuPToUeC55mGwCFWGK1MpnBJ0McMw1PMFbbzgAk3q/LTYB7Fqz
         TLh8pSlwH6t4e0++ulLAh7BDOfDonlpVRKLR+7MIHhhxC3c3tS9COvCevLRtIrGj81r4
         wRu1GZTzAsjQ3ouFIJAiEfq24Kn63pLQn+u+ijdHZmpNu6RQkSeAOlwCsACBpE1TttuH
         xQEdqrD7idd5unTj6Lqd3yvU7L2lv7DxOyzhQKZtMqwlS6mdQALBpxLPYwwhrSb71imA
         WBqa7UlrgHaQLGcaeFiy4FxLkGWEQm2qT+Wh6AwhZs+/nDaP+YV6+Pqnn9oT4ITv+d5t
         BEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690296379; x=1690901179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Cq8IRyozLb3SkglqS2g2LxJsUZMe4IMho3GgyuMdRU=;
        b=j/DoxOwtG5+15Qlr5GqtcCTqVlxCEF68pKhXU76shdEkOPjC/vB9SECJOWKw4UwnqY
         b8Gv2MKObGnF6OHJpeAkX3eT1RgT5MIER7vhDzQc00VHqL6LI+ySUDQ/B3t7fiRnCfyh
         x2TG89JcMOHlR3kYcMqOP/bxLwJkEwxXxuPkKawHri7frjJRZrIDqytJ5cFP7oSkDqyW
         RTmOwOZoo9i+WOrLvbTel4ZKz/g7IfkNwIzR3Cov4jZVoZq2OLXHWGGaujphw7x7pzfI
         4XCvbBR5V427vMtFkOP8AJSDi3ZK5XgerNCM13J3Wlmyh01pmjLxoKaEiO8u2V+ENZtM
         Xc2A==
X-Gm-Message-State: ABy/qLbRM54Eje4QDZfdjKvF79motjHob4wNPdSRhu9YUVf5JBOb8CyW
        BODWhkT7U72lm9OihHrtXw+zhDcXWAZu/MEMQbhpTw==
X-Google-Smtp-Source: APBJJlGD9MLvai2uEROAGRTZfkLteWGpF/+3RQ9alRXLmAndP5qKwJEuzTsMN9Zpyasazxry3jvFwHUkoqyeQarSPUU=
X-Received: by 2002:a67:f999:0:b0:443:5f9e:9864 with SMTP id
 b25-20020a67f999000000b004435f9e9864mr4879919vsq.17.1690296378788; Tue, 25
 Jul 2023 07:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230725104521.167250627@linuxfoundation.org>
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 25 Jul 2023 20:16:06 +0530
Message-ID: <CA+G9fYuH-jyxJwgEgX4J4+eh=nEEk9aqt4YPNUW9j==mwtw=jA@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/313] 5.4.251-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Chao Yu <chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 at 17:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.251 release.
> There are 313 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.251-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Following commit caused build failures on stable-rc 5.4 and 5.10.

ext4: fix to check return value of freeze_bdev() in ext4_shutdown()
commit c4d13222afd8a64bf11bc7ec68645496ee8b54b9 upstream.

fs/ext4/ioctl.c:595:7: error: incompatible pointer to integer
conversion assigning to 'int' from 'struct super_block *'
[-Wint-conversion]
                ret = freeze_bdev(sb->s_bdev);
                    ^ ~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org
