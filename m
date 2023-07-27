Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FED476489F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjG0HcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjG0Hbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:31:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C613C25
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:20:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9922d6f003cso80879366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690442401; x=1691047201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqOQsXekD6sFK6WYy17hOsZp5/7SJav2yrMJmcsMwVY=;
        b=EaA2li8PNRQWUyQ5H36X3vBH5ZCBkXFx20Um28pjq5Ms3WaSpIL2Zy7uh3hv5SLIZI
         Be1Hh5K2t83HLBDO7Z7C8Gi0byzHyNztwgTdYxeEkbKBdq+SERRxfRMUZuYavkrBNIw+
         wfFOCJer9R95EoxrjKjKaqonqyNYj615CJGkGJUUeA++s7vEAwTawo70AVEzEJf50ICy
         ujuqgP+5RNFFTDYvSiYBuL1Xv8EUwRL6BY4ECy0sqZg7baLc3nKs4KxvfxmhHgc79yhQ
         GntRuCEwOKiJr4qbU9TBBhUlvp6bkcpI/SPWAUoaugGIfGhQbnmYkPYDBYKBdcwpHVNa
         AMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690442401; x=1691047201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fqOQsXekD6sFK6WYy17hOsZp5/7SJav2yrMJmcsMwVY=;
        b=F/kFvavhKK9+WLJeYykYGzYyCuCadsIdel9DgzDRUMV0gR0+T/+Brt2Bpwf85d1hDz
         sU8QtMHqMHGwqA2PHOUjy67tRvYF48BCgXZRS6QX2mrf/fGb7c0lPYKpGYQgw44wqxiJ
         xY+p9DAijizKMmVHnjOpnSPwSqoQJqLMe5gJ7JDH83XE5R9EHvdnGSQTsRxHHDWp1wVq
         jGa2eD/P4chnNgYcKEnhRLgX/UUuIr3y29rwga2UBH0WwYbm1RETFZYPl/bNnew0h1zR
         yupseHVcHLpaLaxfduvWu7+DwjZjcJ6rbUFONk/y/SZQ86jLYViCoruonpJ7pMdAiGOP
         i79Q==
X-Gm-Message-State: ABy/qLbhfPb89xW6gXSM2yWfHVv0td6esa+KsyJFPHo4RFto0GsrlE/k
        cgb9NI4Aa/8yS/1DOGIir6CRud0g25zW9+bXVmk=
X-Google-Smtp-Source: APBJJlH0jrNgLEoeZag63NmlA+d74+LDSnMgmUsHAoDTB3LniXqupxvPa61maXNWsNZ+1q5a7JpmTA==
X-Received: by 2002:aa7:c490:0:b0:522:5855:ee78 with SMTP id m16-20020aa7c490000000b005225855ee78mr953040edq.32.1690441670722;
        Thu, 27 Jul 2023 00:07:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id b21-20020a056402139500b005227e53cec2sm296242edv.50.2023.07.27.00.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 00:07:50 -0700 (PDT)
Message-ID: <5bb55bec-6a38-3a88-3fc1-79b12cfe7e02@linaro.org>
Date:   Thu, 27 Jul 2023 09:07:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/3] input: pm8xxx-vib: refactor to easily support new
 SPMI vibrator
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org,
        dmitry.baryshkov@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_kamalw@quicinc.com, jestar@qti.qualcomm.com
References: <20230725054138.129497-2-quic_fenglinw@quicinc.com>
 <202307251741.PMtlVAgD-lkp@intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <202307251741.PMtlVAgD-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 12:01, kernel test robot wrote:
> Hi Fenglin,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on dtor-input/next]
> [also build test WARNING on dtor-input/for-linus linus/master v6.5-rc3 next-20230725]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Fenglin-Wu/input-pm8xxx-vib-refactor-to-easily-support-new-SPMI-vibrator/20230725-134504
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
> patch link:    https://lore.kernel.org/r/20230725054138.129497-2-quic_fenglinw%40quicinc.com
> patch subject: [PATCH v3 1/3] input: pm8xxx-vib: refactor to easily support new SPMI vibrator
> config: x86_64-buildonly-randconfig-r002-20230725 (https://download.01.org/0day-ci/archive/20230725/202307251741.PMtlVAgD-lkp@intel.com/config)
> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
> reproduce: (https://download.01.org/0day-ci/archive/20230725/202307251741.PMtlVAgD-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307251741.PMtlVAgD-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/input/misc/pm8xxx-vibrator.c:190:17: warning: cast to smaller integer type 'enum pm8xxx_vib_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
>            vib->hw_type = (enum pm8xxx_vib_type)of_device_get_match_data(dev);
>                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    1 warning generated.
> 

Remember to fix all the warnings.

Best regards,
Krzysztof

