Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779267558B8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 02:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjGQACA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 20:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjGQAB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 20:01:59 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660DFD7;
        Sun, 16 Jul 2023 17:01:58 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5440e98616cso3150367a12.0;
        Sun, 16 Jul 2023 17:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689552118; x=1692144118;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WtC2KnzbjEMeP53AMzReH9UVnbjKe1V7hPV3HaDTnAY=;
        b=euxfoTEqInAoBP535sgMKjEOLqTxMjW/cTCfBwj8LnEZHW/8zYHiDQuvOdjiAY98/I
         uw7SZdIY+qM5iON23c8SYMv2e75extvSFZznmc+tZdoysk+bO+PcMyAg4tRZ8ZFiN5kL
         AVKLV7Dm2ec8qx9d5A08J/GjqfIPTK/oEqHX36PT5bgyJtzg8I/lVmWUKP9ipwl0mQFB
         sFqM+nSJJRwNExSi9aGosth4BXOHX3ZWuOS6HHTFn1I0V1AbKuY91JnV2s9o6c5nIvOn
         nqlDuVk8xJyqFWhZ0CyOKQn87+LIBZB9lYaAlzM+AEIWiC4JlCVhoHSGrrmA7PsAVLnS
         fPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689552118; x=1692144118;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WtC2KnzbjEMeP53AMzReH9UVnbjKe1V7hPV3HaDTnAY=;
        b=AfnJjmdprkAcClN/pbwbZLZBi1cQTvgymzDpIPv50JJmLs8GxbyA4XGcKPTXbkh8lN
         YEsuz66YI6FPxK/hdSLXUGEXegNgNeVp1uurShHNf0P7D8BThaFKLkR0QaGvk6IU/t57
         x8ecFhgcKrY9t2HUhz2mqml7DSue0m/l0WDhVTfhTzlMnoM3Gs4LqaPXHNgQ2uvuVYP5
         ylvxkJSkHOdb+MFbhtUoq/nnfxinNlnsQqrtvP4o5pPpRvUFs63FRLUJOZMtopItH3Vt
         fqEXndtg9APVNNuOul5/iZ7VtnfmtkubdHlpF8T15WINx5K/mJ5WvBCAaloZVVqXhxJl
         i5/A==
X-Gm-Message-State: ABy/qLYaaKP6wVgtzAsa90gHHu0RoVuy/YxaqqumQMoQMJb/P3wT91g6
        UTSaBewGBiTJZV4h+fcEuC0=
X-Google-Smtp-Source: APBJJlFCN1a2P1hnECDM9FOC7BFpb1uiaSTOXjt/CyypgrAnB7Yg779sBDpg+qqE1I+K7gmEpU2Jhg==
X-Received: by 2002:a17:902:e750:b0:1b8:6952:5381 with SMTP id p16-20020a170902e75000b001b869525381mr11894630plf.9.1689552117760;
        Sun, 16 Jul 2023 17:01:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902744400b001b9ff5aa2e7sm9118012plt.239.2023.07.16.17.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 17:01:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0b2e2708-b658-1640-1ebd-4c84c3552714@roeck-us.net>
Date:   Sun, 16 Jul 2023 17:01:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.1 000/591] 6.1.39-rc1 review
Content-Language: en-US
To:     =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230716194923.861634455@linuxfoundation.org>
 <CAEUSe7-XjSvLKxFuHbKUrJBWAmgKRg5oZRppnDYn1CuoWCUURw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAEUSe7-XjSvLKxFuHbKUrJBWAmgKRg5oZRppnDYn1CuoWCUURw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/23 16:40, Daniel Díaz wrote:
> Hello!
> 
> On Sun, 16 Jul 2023 at 14:31, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> This is the start of the stable review cycle for the 6.1.39 release.
>> There are 591 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Tue, 18 Jul 2023 19:48:07 +0000.
>> Anything received after that time might be too late.
>>
[ ... ]
> We're seeing build failures on i386 and x86 with Clang:
> -----8<-----
> /builds/linux/block/blk-cgroup.c:1238:6: error: variable 'ret' is used
> uninitialized whenever 'if' condition is true
> [-Werror,-Wsometimes-uninitialized]
>          if (init_blkcg_llists(blkcg))
>              ^~~~~~~~~~~~~~~~~~~~~~~~
> /builds/linux/block/blk-cgroup.c:1288:9: note: uninitialized use occurs here
>          return ret;
>                 ^~~
> /builds/linux/block/blk-cgroup.c:1238:2: note: remove the 'if' if its
> condition is always false
>          if (init_blkcg_llists(blkcg))
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /builds/linux/block/blk-cgroup.c:1223:33: note: initialize the
> variable 'ret' to silence this warning
>          struct cgroup_subsys_state *ret;
>                                         ^
>                                          = NULL
> 1 error generated.
> ----->8-----
> 
> More info to follow soon.
> 

Caused by 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
which is missing its prerequisite b5a9adcbd5dc ("blk-cgroup: Return
-ENOMEM directly in blkcg_css_alloc() error path"). With three Fixup:
patches following, it is one of those patches where I wonder if it
is worth the trouble.

Guenter

