Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C227F2B04
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbjKUKym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjKUKyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:54:40 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFAF95;
        Tue, 21 Nov 2023 02:54:37 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so65592941fa.0;
        Tue, 21 Nov 2023 02:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700564075; x=1701168875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsj3rIZeOAuNXZ0EvueOE00+LKfnpB0i3HgAHHnhF3E=;
        b=WfJoYSBkhqfFoH3Ae8y3Q+s33oK4sbSmx57fRMHY+7TdDJ0K+7BUpHhaXbs4fcfB/3
         IzfW8h/4Hv7DM81oerdIoU2NdCc5cFacOoizt7R36XP2ChfzsVRcxu3/ELrSy2z3hr3d
         IZBtSURsNIhhlJro6NleTfe15AvazvYvObc/4fFZYZ3+XzNnjU/lCtbyzkjOD6q5VZ8S
         H0yTbP4AKvRGwK5q7qwhTmHbcgt1Nrgrshbo+gW9QnimMzVm8PY/537EhDC+RzVDDb6+
         DeZa/rYPlOzDriIgsc4wR09VnznKeDgvkuVJSH5kFnmPpoEtVpPCt+g7C6F5egt0yh5w
         1gIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700564075; x=1701168875;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qsj3rIZeOAuNXZ0EvueOE00+LKfnpB0i3HgAHHnhF3E=;
        b=q3/sH7fXm8zUuvo63zuse6fSk7XpKd9hyKQB6czkdUZKX5PQJN87CBqRlOZXlpMcA+
         SCC40GEI5qQ9ZuxRxcvSEw0K+LA1AGjrDjftsCkdgQrNguvtFaUUrj62/IlG9rgPnOtD
         htry6X2YAqB3ByjCHUXN5ZAzMRlwMtoMAhRMNoUQUm9ztvn8jGhePq5kqsOirT/pnJd6
         3SDrIsagoeleF2bUkKepPoS9vV3sS3ekKrmfx/V1Xd0tfjiPN4DxddsHewTBWOlOB9lG
         vQk4ZpmDNApV4DXLx2a1cHqMeUZkqjYd1nwiHifbldUByru2KbvCO4W50S+LhdDa8RP0
         ozhQ==
X-Gm-Message-State: AOJu0YwY/sLEm4bKWsAx75MdDvxYEZ0W6gCVZGjliKIwz9TJTB05H2fT
        Q+O54jm3akm0r80A/AKy0jo=
X-Google-Smtp-Source: AGHT+IFioFRkNB+YL4dtT3g8rvv6fq/46Q8hsaR5Rd+/NmmxuVkjFpEc0ZDxM0tjzpAo9MTVz4lr6A==
X-Received: by 2002:a2e:81d6:0:b0:2c6:ec32:5b36 with SMTP id s22-20020a2e81d6000000b002c6ec325b36mr7156219ljg.31.1700564075106;
        Tue, 21 Nov 2023 02:54:35 -0800 (PST)
Received: from ?IPV6:2001:7c0:2517:e:ec01:44e1:a4f0:c8? ([2001:7c0:2517:e:ec01:44e1:a4f0:c8])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c4e9300b00405d9a950a2sm21233908wmq.28.2023.11.21.02.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 02:54:34 -0800 (PST)
Message-ID: <8ee13525-74d1-4308-b7b5-c01daa5352e2@gmail.com>
Date:   Tue, 21 Nov 2023 11:54:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: qcom: qcm: fix unused
 qcom_scm_qseecom_allowlist
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
References: <20231120185623.338608-1-krzysztof.kozlowski@linaro.org>
 <2f14aab8-a5bb-4af4-9475-afe6b678a7fd@gmail.com>
 <e7565064-42a4-43fd-82f7-2e84066bee55@linaro.org>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <e7565064-42a4-43fd-82f7-2e84066bee55@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 11/21/2023 um 8:07 AM schrieb Krzysztof Kozlowski:
> On 20/11/2023 20:56, Maximilian Luz wrote:
>> On 11/20/23 19:56, Krzysztof Kozlowski wrote:
>>> For !OF builds, the qcom_scm_qseecom_allowlist is unused:
>>>
>>>     drivers/firmware/qcom/qcom_scm.c:1652:34: error: ‘qcom_scm_qseecom_allowlist’ defined but not used [-Werror=unused-const-variable=]
>>>
>>> Fixes: 00b1248606ba ("firmware: qcom_scm: Add support for Qualcomm Secure Execution Environment SCM interface")
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202311191654.S4wlVUrz-lkp@intel.com/
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>    drivers/firmware/qcom/qcom_scm.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
>>> index 520de9b5633a..ecdb367dc9b8 100644
>>> --- a/drivers/firmware/qcom/qcom_scm.c
>>> +++ b/drivers/firmware/qcom/qcom_scm.c
>>> @@ -1649,7 +1649,7 @@ EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_send);
>>>     * We do not yet support re-entrant calls via the qseecom interface. To prevent
>>>     + any potential issues with this, only allow validated machines for now.
>>>     */
>>> -static const struct of_device_id qcom_scm_qseecom_allowlist[] = {
>>> +static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
>>>    	{ .compatible = "lenovo,thinkpad-x13s", },
>>>    	{ }
>>>    };
>>
>> Thanks! Given that we're right now only allowing qseecom clients to load
>> on devices within that list, maybe it would be cleaner to make
>> QCOM_QSEECOM depend on OF explicitly instead?
> 
> There is no code dependency here.

Which is why I'm fine with this as well. It would just drop
currently unused code on !OF configs.

> The driver should already depend on
> ARCH_QCOM which select OF. Are you saying it does not depend on
> ARCH_QCOM? Why?

QCOM_QSEECOM depends only on QCOM_SCM. QCOM_SCM does not have
any dependencies. Instead, it is selected by ARCH_QCOM.

Best regards,
Max
