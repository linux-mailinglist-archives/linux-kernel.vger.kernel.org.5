Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302A479AD34
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjIKXTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 19:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351115AbjIKVmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 17:42:47 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E073AB8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 14:26:47 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5924093a9b2so48379547b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 14:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694467505; x=1695072305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMQal+o8tzu4wFn4IrJDyy1kLd4NdYEV6e+c0EkXb2U=;
        b=hZURGea4xUSxy2ofTpfClitWTDf5cwy+lgWjGuQOg8xhIUrXYdABAScZ1tLv+dNqOd
         HayN5X/HaKgIkJFvjO0AVaYHf/WkAjGTKPbiitmyObUylkmTlb/6p/uOHKOq6mbnXKrW
         kHUayAqlmQtbAtHrtA3+aFeYW+QHgqYjuyMaMtYrDjaSBLpiIIPrqpdOCxGYxwbKazQf
         58tTs8XkxwNdLiB3Kw6E074KV4g5gz/ZjrXB2uIdEeByRl6yeuO1urfFTECMC3vW2i23
         SmaHlr68RV2tDIcXHpu+LLPm0RMgJbH9o4gtFsDBCG9MtPgLfFVGmLoWlxDWpfyJrN36
         mguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694467505; x=1695072305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMQal+o8tzu4wFn4IrJDyy1kLd4NdYEV6e+c0EkXb2U=;
        b=jRBfft9vmIgWThJ7ICjlqKjTvJ6SZi33F1kfBFntiMHOt66r9ilK5Qe1l5h5425x6E
         EdWp6cXzRlU4QYjcT5HNtGgp2+hSjLY71efTnlwFIw99ooYgFlFLx6pKzVnUa+iDcujF
         uM19sGo9KPv9YeDTcbe6DCEPor9neQPaWQhgqiPoYWa8Meuq3I6NjXbuZzu+S8tQivlF
         rrOeKyfqxoudOV2DOq2QMVwEPn/INIS6si5flsGDMtCVn+K33p/rzXb2GwNdge2T0Bnn
         6QfHBb2KU/cKRMvwHYlO571NDXNn2XK0ETFTUJiOXoJXAKnDFMZqcJZI/mrO3B6qydZG
         7RpA==
X-Gm-Message-State: AOJu0YyfG+DiNfT7mXs9CVAXWBV93iDZRFQ4N8PW/QpN/bVIvImOKKwq
        wOB1ojuDVzAzNeCDdV2Zz+RNAr7wuZh5S7LprKT7V/hL
X-Google-Smtp-Source: AGHT+IGipFuT+lIDKb9srjnEvoHGQrqH1ObvhCRR6oL37gQQ6BLrvohv8vCYO/+DWVXIHIV0CjUoWw==
X-Received: by 2002:a05:6871:4181:b0:1d5:e2f2:c7d with SMTP id lc1-20020a056871418100b001d5e2f20c7dmr1494800oab.48.1694465899445;
        Mon, 11 Sep 2023 13:58:19 -0700 (PDT)
Received: from [192.168.17.16] ([138.84.45.186])
        by smtp.gmail.com with ESMTPSA id t34-20020a05687063a200b001d57c93ddbasm3750195oap.35.2023.09.11.13.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 13:58:18 -0700 (PDT)
Message-ID: <1ffe4f64-f238-859a-ab14-7559d03c4671@linaro.org>
Date:   Mon, 11 Sep 2023 14:58:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 6.1 000/600] 6.1.53-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230911134633.619970489@linuxfoundation.org>
Content-Language: en-US
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 11/09/23 7:40 a. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.53 release.
> There are 600 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.53-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

We're seeing this new warning:
-----8<-----
   /builds/linux/fs/udf/inode.c:892:6: warning: variable 'newblock' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     892 |         if (*err < 0)
         |             ^~~~~~~~
   /builds/linux/fs/udf/inode.c:914:9: note: uninitialized use occurs here
     914 |         return newblock;
         |                ^~~~~~~~
   /builds/linux/fs/udf/inode.c:892:2: note: remove the 'if' if its condition is always false
     892 |         if (*err < 0)
         |         ^~~~~~~~~~~~~
     893 |                 goto out_free;
         |                 ~~~~~~~~~~~~~
   /builds/linux/fs/udf/inode.c:699:34: note: initialize the variable 'newblock' to silence this warning
     699 |         udf_pblk_t newblocknum, newblock;
         |                                         ^
         |                                          = 0
   1 warning generated.
----->8-----

That's with Clang 17 (and nightly) on:
* arm
* powerpc
* s390

Greetings!

Daniel Díaz
daniel.diaz@linaro.org

