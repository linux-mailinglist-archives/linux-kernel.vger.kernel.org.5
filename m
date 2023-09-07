Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663A4797D97
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 22:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbjIGUwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 16:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237271AbjIGUwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 16:52:08 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B0E1990;
        Thu,  7 Sep 2023 13:52:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401f503b529so15490485e9.0;
        Thu, 07 Sep 2023 13:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694119923; x=1694724723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fae/gCSVi75yE6BXyO3fHmQGcGUFv46AyaLFONrZHGs=;
        b=LIvS49O8d/1hIBo1v5JHOxMx0IPeGGLMARKhF8NYt/gjH74APCIrhMt/dY+FwWfyjD
         uTlaxvQdT5VTAJgYFsnltwVy9fjknzbMjAeV1J7oQWAc3NlB87VeKXRqE7ev+lwzb2kP
         9JyZ785owC8WRuCUfdpKeVTttYUovQVVDzBXh/wYPURvnsSJO46KAt43+KtWG/jEuAKL
         jPgv1FsjNERnCBxPFnCK/c8guJLVuZrBMuYXcLi91l+9Lx17ufrW/Km3jWRmemdD0noa
         PFx2fWTTgMoOJe7eRkcqw+uWB2R6/trPCuDEXyBSpTyOG3NNP8ICHqPpPRaSLnGC3Ka0
         4CvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694119923; x=1694724723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fae/gCSVi75yE6BXyO3fHmQGcGUFv46AyaLFONrZHGs=;
        b=RIloqEQJ852hqz+CoY0CR4ltPTyZFLJtvdusUYCF2TSWnzZgefOFwX9Fp987FzbW6U
         sQvN3a1BmIa1FYfmTXuwP2FeXNIu4PbpGK99Ac8fMf5wbiQY5c16F2odq72MzixGepuz
         MPtkUYQ02w6Zw/h1ydh2jIoVsrQ1yCfm0no7cvLPyMuLkL9mq8G+UlklKZ2VFE90YKMR
         EItfPY/nAtU25GUSI0YV1W3UGHZzMOJmyMh6Td62UOZp3A22BQrwsThO+vnpRxFX/oi6
         P+gZHQsnOJFdpimvEc/y7yeuJ47n0NrZ1e8bl3aAYkAgFIPQAYXGp3et/r3g1ulLFgBy
         gFlg==
X-Gm-Message-State: AOJu0YyJiIcLwS1CfWJ0w9NWr0RLGPUY5/YAPsGeklfe+uC1KIYn1xS4
        dOOxrCUh96zUJ/k2ikb0Sn1o8eteWPo=
X-Google-Smtp-Source: AGHT+IGLBPPp3D3+qgyYnIHrOU7yvISt/AEl4NuYlOhEm585Zb3+yJTzO4nr6HpzIlzPAGBN4bweLw==
X-Received: by 2002:a7b:cb94:0:b0:401:b0f2:88cc with SMTP id m20-20020a7bcb94000000b00401b0f288ccmr641368wmi.41.1694119922569;
        Thu, 07 Sep 2023 13:52:02 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id x6-20020a5d54c6000000b0031c855d52efsm292232wrv.87.2023.09.07.13.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 13:52:02 -0700 (PDT)
Message-ID: <5487e816-f30c-468f-b860-a4cac30fba36@gmail.com>
Date:   Thu, 7 Sep 2023 22:52:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] firmware: Add support for Qualcomm UEFI Secure
 Application
To:     Trilok Soni <quic_tsoni@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
References: <20230827211408.689076-1-luzmaximilian@gmail.com>
 <20230827211408.689076-4-luzmaximilian@gmail.com>
 <0d7697fd-11b3-1d4a-78da-7e5eb293d186@quicinc.com>
 <072b3df6-09fb-98a8-2b58-41dfcabd98c0@gmail.com>
 <89294acf-501f-5c2c-1619-cfc2b3dc893a@quicinc.com>
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <89294acf-501f-5c2c-1619-cfc2b3dc893a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/23 23:59, Trilok Soni wrote:
> On 8/27/2023 2:53 PM, Maximilian Luz wrote:
>> On 8/27/23 23:26, Trilok Soni wrote:
>>> On 8/27/2023 2:14 PM, Maximilian Luz wrote:
>>>>    +config QCOM_QSEECOM_UEFISECAPP
>>>> +    bool "Qualcomm SEE UEFI Secure App client driver"
>>>
>>> Why not "tristate"? This driver can be a loadable module, right?
>>
>> As I understand, modular efivars have still not been fully sorted out in
>> the kernel. For example, userspace could try and mount efivarfs before
>> the module has been loaded and by that erroneously determine that the
>> system doesn't support efivars. So requiring it to be built in for now
>> is more of a workaround (which has been suggested by Johan Hovold).
>>
>> There is no technical limitation in this part of the code itself, so
>> enabling it (and QCOM_QSEECOM for that matter) to be built as module
>> should be fairly straightforward once that's been sorted out.
> 
> If not this application I would atleast like the QSEECOM driver to be a loadable module due to GKI (Generic Kernel Image) needs. Can we mark QSEECOM as "tristate" please? If not then there is a problem which we are not solving right now as you are documenting above and just moving it it for future and downstream vendors will keep having their additional changes to make it fit for loadable module needs.

Could you elaborate a bit on why/how switching to a tristate would help
here? I'm afraid I don't quite follow. Do you mean that this would make
it easier for downstream vendors to patch the module as opposed to
create their own new thing? IMHO if they already need to patch it they
can just as well modify it to be buildable as a module.

Generally I'm not opposed to have both loadable as modules, but I don't
quite see the point as it would not be usable as such in upstream at
the moment (at least not reliably, so to avoid those headaches I think
it's better to just stick to bool for now).

Regards,
Max
