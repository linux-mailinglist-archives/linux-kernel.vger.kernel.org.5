Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BE877F14A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348524AbjHQHdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348569AbjHQHdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:33:39 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D970E30EE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:33:17 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so1316974a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692257596; x=1692862396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XqVwwc2dDlYlCMTarZ/PjmKE+CsteLytpeFTL+9lo0M=;
        b=F4UrenxJRzj7RIgGu2RAZ2FUbmJEF38qgllIOTjkWb91A+EGbBRBvbhHqKxIO/AeNe
         ff4+SIOxVHNabjcg7l5TwiX0NWBzieVdmlblIxPBlK0tY01TSyLib+9qnr2FnWt66sXZ
         Ir7tJSfIR4U2c6qGCHcDZt7br1mzXyUdZM2BKRwvU3dv2PNOesfmlqTM6uJCvbzmf7DQ
         /BQmQ2DmlmTrOy3n3WQLJj3lRTTEEqdsco+uzM60FV6tRtGpOrx4fUryqA+4w6F4oUt5
         /mhOH7g/8a4pwXNbvv1PpfHTnJH1zcitg5hU892GdkgYp8jALVFToAUGlI5ExSdF6Tzl
         Djkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692257596; x=1692862396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XqVwwc2dDlYlCMTarZ/PjmKE+CsteLytpeFTL+9lo0M=;
        b=Wg147oahLu6hXnXxkcYYnNYFL4CMmqBkt3kYqf7F3PbUOWSNKjaAJw70YQo83hO3tD
         3orO1LpDATmB7iEyCa/NrEXgmf2nbm9lm7264AlpUYNAOijxK+30mWgmAqQBuJ4Mt+NX
         rvhiy3hyhQ6r5zEPb6f8R4UOiTvx5OcnX+z7aunqWCrUSzuRtBBJcIOVxfpMKyOgdls7
         MP+SKOflNLtjitjoAEnzw2lf37VeE9cFD4EjS2roGFu5FYtnUipP+/JgzFKHmGxmEZY1
         vki+gSqeudXYq49cnGV265Pilxc1w4I9z6hO3UZe0EHcIR8eZ2mrPpjA91tpJBSAsHWE
         jFHw==
X-Gm-Message-State: AOJu0YzxQyleTjhA6nMRgpIzXVmMOw3L/Ret9+RZv1858eTTcaiHlz3W
        LUEdTBbFixoi0JTDa5yvw4Q5RA==
X-Google-Smtp-Source: AGHT+IFghrFx0zxJbJiB3SRR94OfeZeGqRzD/iYhIlcu/DnH8WCxmeY5R8S/g/7SDRhGfDDg6uwxBg==
X-Received: by 2002:a05:6402:40c8:b0:522:b9ae:db3c with SMTP id z8-20020a05640240c800b00522b9aedb3cmr2223766edb.6.1692257595980;
        Thu, 17 Aug 2023 00:33:15 -0700 (PDT)
Received: from [192.168.69.115] (mek33-h02-176-184-23-56.dsl.sta.abo.bbox.fr. [176.184.23.56])
        by smtp.gmail.com with ESMTPSA id k15-20020a05640212cf00b00521f4ee396fsm9365410edx.12.2023.08.17.00.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 00:33:15 -0700 (PDT)
Message-ID: <f7230276-decf-2248-52b2-c2de4a13647c@linaro.org>
Date:   Thu, 17 Aug 2023 09:33:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 3/4] arch/mips/configs/*_defconfig cleanup
Content-Language: en-US
To:     Trevor Woerner <twoerner@gmail.com>, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20230817025942.3209-1-twoerner@gmail.com>
 <20230817025942.3209-4-twoerner@gmail.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230817025942.3209-4-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trevor,

On 17/8/23 04:59, Trevor Woerner wrote:
> Drop CONFIG_IP_NF_TARGET_CLUSTERIP from any remaining mips defconfigs as it
> was removed in commit 57f8e00d8a82 ("usb: 71 musb: Drop old unused am35x
> glue layer").

How 57f8e00d8a82 is related? Do you mean commit 9db5d918e2c0
("netfilter: ip_tables: remove clusterip target")?

> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   arch/mips/configs/ip22_defconfig        | 1 -
>   arch/mips/configs/malta_defconfig       | 1 -
>   arch/mips/configs/malta_kvm_defconfig   | 1 -
>   arch/mips/configs/maltaup_xpa_defconfig | 1 -
>   arch/mips/configs/rm200_defconfig       | 1 -
>   5 files changed, 5 deletions(-)
> 
> diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
> index 44821f497261..dc49b09d492b 100644
> --- a/arch/mips/configs/ip22_defconfig
> +++ b/arch/mips/configs/ip22_defconfig
> @@ -127,7 +127,6 @@ CONFIG_IP_NF_MATCH_TTL=m
>   CONFIG_IP_NF_FILTER=m
>   CONFIG_IP_NF_TARGET_REJECT=m
>   CONFIG_IP_NF_MANGLE=m
> -CONFIG_IP_NF_TARGET_CLUSTERIP=m
>   CONFIG_IP_NF_TARGET_ECN=m
>   CONFIG_IP_NF_TARGET_TTL=m
>   CONFIG_IP_NF_RAW=m

