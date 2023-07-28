Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B0D766A02
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbjG1KPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbjG1KPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:15:02 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6683A84;
        Fri, 28 Jul 2023 03:14:55 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68706d67ed9so850314b3a.2;
        Fri, 28 Jul 2023 03:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690539294; x=1691144094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2NyYQRj/+vBZyu8VTY/3GBxijYaE/V2IwyCSD8hzwfA=;
        b=CmQKT+GzqcCMIfh4spUOx7RQWfSLSY6cEzU3BhkHfpaUOiVFK64IGkMUmxmywjyBDZ
         HS4MK1cCNSIwDwugZZHzRv8D7zZtSLiJ+IEaSoeZx6cLUK0EygQoDCcSYU/wGLeia/DC
         blERUU3Jl0NJADiSZfvtLVwZiUqBi4dJgdpHE1ZmOtO+wDPfWc/x5cA4FCUWCeInAz5z
         HLuRDtRc+d8zvA3/KiLOC3hqi8CTtU3lJRBWyFLgExxfBKcFNVH1lFwLbOju1tTmfaNP
         GOq0VPGBE+061WA9pPAmo/23+X0oNcYt0CeoZxYqTm8s0g8kqcrXSlatTKrvO1AF+8MC
         v7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690539294; x=1691144094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2NyYQRj/+vBZyu8VTY/3GBxijYaE/V2IwyCSD8hzwfA=;
        b=SBZf7Xv5ccvZMFXh1GLcdPodV8DNpbwOUG3vHY095OAG/A+PlHoQCHZqS/v1QmqHMp
         E+iMpi970yvxKg/Zp4Lt+BQ8TkUXTrqr17BSKv5tPGJ/hT1qGj4lkZ27mbK9Uoqi6wvr
         HaQlPevQCVW0CnhRJHL2I0l1J49kDq/z7LAWWSvl3FRkX4JW4uhBxts5gCdosK4x1eFK
         b8LlE1HRIU5OBJQNEfyRPZgxFxhZ/V3Ck+YbbFaWWVoSbKNOw44h+iFQ/bU8Wd1EInXU
         6nMVXtvoavikB9y89SfF2HsgdZfHXb+yIzfJNMkG9+Z3QOuPy6uzgVCHnmwWKe1ileAM
         fpHg==
X-Gm-Message-State: ABy/qLbPAtE4jEP5LpgSSAPNS6gUJ5KOuihyqOldHbTs865vfP0rsscP
        I4dOUyaGtCCE6ABgbTfFym0=
X-Google-Smtp-Source: APBJJlF1eNRQjH485cnV+ttZQxFtb+hy27zF8phCq34H1obC+0ChgQlKsLgx0fcpR48M+cPBVkPFjg==
X-Received: by 2002:a05:6a20:659:b0:137:6958:d517 with SMTP id 25-20020a056a20065900b001376958d517mr1123240pzm.24.1690539294552;
        Fri, 28 Jul 2023 03:14:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79111000000b006863240ef3bsm2964365pfh.171.2023.07.28.03.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 03:14:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e4de7d39-978a-0996-1b03-8e7a6712b477@roeck-us.net>
Date:   Fri, 28 Jul 2023 03:14:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 0/2] usb: typec: qcom-pmic-typec: enable DP support
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230728100857.471984-1-dmitry.baryshkov@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230728100857.471984-1-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/23 03:08, Dmitry Baryshkov wrote:
> To enable DisplayPort on the platforms supported by qcom-pmic-typec
> driver, we need to register a corresponding drm_bridge for this device
> to be able to receive the OOB hotplug event sent to the corresponding
> DRM connector.
> 
> Reception of the hotplug event is implemented by [1], but there is no
> direct dependency on that patchset. This series implements the remaining
> parts: registration of the drm_bridge and setting of the proper
> destination for the OOB hotplug event.
> 
> [1] https://patchwork.freedesktop.org/series/120393/
> 
> Changes since v2:
> - Reworded commit message for the first patch to explicitly mention that
>    the "displayport" OF property was rejected (Bjorn)
> - Removed several #ifdefs from the qcom-pmic-typec patch (Bryan, Konrad,
>    Greg K-H)
> 
> Changes since v1:
> - Properly handle CONFIG_DRM dependency. Disallow building DRM as a
>    module if qcom-pmic-typec driver is built-in (Bryan).

  config TYPEC_QCOM_PMIC
  	tristate "Qualcomm PMIC USB Type-C Port Controller Manager driver"
  	depends on ARCH_QCOM || COMPILE_TEST
+	depends on DRM || DRM=n

This disallows building TYPEC_QCOM_PMIC into the kernel if DRM is built
as module, which is pretty much the opposite of what is claimed above.
It does not affect DRM at all.

Not that it matters much, but I find it confusing if the change log
claims to do the opposite of what the code is doing.

Guenter

> 
> Dmitry Baryshkov (2):
>    usb: typec: altmodes/displayport: add support for embedded DP cases
>    usb: typec: qcom-pmic-typec: register drm_bridge
> 
>   drivers/usb/typec/altmodes/displayport.c      |  5 ++-
>   drivers/usb/typec/tcpm/Kconfig                |  1 +
>   drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 35 +++++++++++++++++++
>   3 files changed, 40 insertions(+), 1 deletion(-)
> 

