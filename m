Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0DD78A21E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 23:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjH0Vx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 17:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjH0VxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 17:53:16 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C6E11A;
        Sun, 27 Aug 2023 14:53:12 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-977e0fbd742so320792266b.2;
        Sun, 27 Aug 2023 14:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693173190; x=1693777990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GocKa5UOi/aiFmRligoG1tT/pviU6d8PTd0vn4Yclz0=;
        b=eRWZervuaUqcigeHgXK3VmyNgcfH/XDshw1CtSgAQOa0sszno3rLn8V+Gf9vCx4NuF
         JdmIq2aqa3fLg+cAJGwdfKSMMF/A7gpugVZSAWVZXdmBihCFAdYjcFxRcw6v02reEDFT
         bkjN+/cZJg1PdDorpEhiR7TIy18dsZWDv36qHy8SbSnaFS0n85Gk7plCcVbCrshWyBmc
         mhucdLYctHWlttv/SArGUQKaLME7dO9JDEMnv3j6l75E5zXX/18YKQdaGeYntClZZdGq
         ca89Jut9NBUVvD9ulclUZz3q/gF3QURCOqwA8nP8SddwFhfvQ7TIAB/jrOo2+bpaF4Sl
         7omQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693173190; x=1693777990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GocKa5UOi/aiFmRligoG1tT/pviU6d8PTd0vn4Yclz0=;
        b=Ci3BEis9Hh4fW825bWipEp/DLS2vzFLVNiKLNa0Ryu/Tvgg2/2A4C1LAQ6MKSXnJVg
         8zz0bI4vG06ihqKc6YTERkFTg1u+Zw/KsqEM3V6jL+SeR5c90rYqIPb1+zIyaHNhzhyG
         ApFj6cSkaPSeQUM1OerDAXd4Q07Lq6tJ2tAWdEQ3TYJiNzS749OURLRb+iA+rvJQr9GJ
         +o5agylZQGQSm/p/LxUQJAZDkslun2Hsox/kEAYEFoOthR8Aamgsi4Mdqxv7H4t8QFwj
         4v6FT+xzlXFQQ3JXwacASGERT1ErIFrci2i0HDYiI9+r+8yjOjDj6VU050vhpDipdtvK
         pWNQ==
X-Gm-Message-State: AOJu0Yyz8M20rmAaaA+p9KFTPkfWPy5YLTZm2mJjkzx9uIa3pLnBcb3x
        sXuhtvjw962SKVBcflEXirk=
X-Google-Smtp-Source: AGHT+IG31K+a/W3LsxcnJSQ9rJiOwWSXhFJfKchBBJ71wvewS6il8CYS9l1oBRgA8hRx1mB/cBbStw==
X-Received: by 2002:a17:906:5394:b0:9a2:96d2:b1e7 with SMTP id g20-20020a170906539400b009a296d2b1e7mr6403563ejo.52.1693173190401;
        Sun, 27 Aug 2023 14:53:10 -0700 (PDT)
Received: from [192.168.2.135] (pd9ea3ad4.dip0.t-ipconnect.de. [217.234.58.212])
        by smtp.gmail.com with ESMTPSA id g19-20020a170906595300b0098733a40bb7sm3877628ejr.155.2023.08.27.14.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 14:53:09 -0700 (PDT)
Message-ID: <072b3df6-09fb-98a8-2b58-41dfcabd98c0@gmail.com>
Date:   Sun, 27 Aug 2023 23:53:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
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
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <0d7697fd-11b3-1d4a-78da-7e5eb293d186@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/23 23:26, Trilok Soni wrote:
> On 8/27/2023 2:14 PM, Maximilian Luz wrote:
>>   
>> +config QCOM_QSEECOM_UEFISECAPP
>> +	bool "Qualcomm SEE UEFI Secure App client driver"
> 
> Why not "tristate"? This driver can be a loadable module, right?

As I understand, modular efivars have still not been fully sorted out in
the kernel. For example, userspace could try and mount efivarfs before
the module has been loaded and by that erroneously determine that the
system doesn't support efivars. So requiring it to be built in for now
is more of a workaround (which has been suggested by Johan Hovold).

There is no technical limitation in this part of the code itself, so
enabling it (and QCOM_QSEECOM for that matter) to be built as module
should be fairly straightforward once that's been sorted out.

>> +	depends on QCOM_QSEECOM
>> +	depends on EFI
>> +	help
> 
> 
