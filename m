Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1997C5EA7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376421AbjJKUr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjJKUry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:47:54 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637E590;
        Wed, 11 Oct 2023 13:47:51 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so244059f8f.2;
        Wed, 11 Oct 2023 13:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697057270; x=1697662070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U1SLoYxRNR/CDgTJKsFAri0SaYwm+irDzPMgfmqqQZY=;
        b=Lnbbe03killa8j3BZMWuHM5TnDUK4dIZfozrbhA0SSSmOD5gD+PozOtTYEN8QKI/Av
         007Qosd1Jv3SiHuL/u7yNp3LwurW580C2Af6sLIrEawK/Cz2DDxivlt7MxELl8DH0SyX
         p/gCZ+5rgXOh1jKOFNXbTO6w67JH4XyZ2NnAaWgPMCfMFwkBGFfeCRuk+nVTEprOkqw/
         X3LsngJY2BOBJVRUt5kzu60TxmHAp0DCyAJrF6+IvbnLJdzqhimwiF+FzGxpzC1A/SnW
         By9iR3bxdWdVzlnP28suIcqus1BCifB0UTi3FslBTLlc6vE9OxIDilGfltuiVlPEe5SY
         lPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697057270; x=1697662070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1SLoYxRNR/CDgTJKsFAri0SaYwm+irDzPMgfmqqQZY=;
        b=DyiWqxLrs3fMjqv1w1sKXE+jOTHJBCZjKNijdeQNzxUHDNcIZwPz8TcWf3PWeURwQk
         67467CSP1SHiLjHMPls/PYyqc3bAMvLsmbHTfWsMxNoRFbKSfHE/HAzBouMsayY7uNSA
         LmFMK3lQJtJetLdYXdo7g3tj9BAorjO297KEH3ygQoOro+CZeAnYPjBRVQmFQeDb3/Lz
         7adjssVi4kYpu7tEHMjPE6RVnnNRygBQoB6fFFXI+RFCI1LP/KoaHYMZPGN/ShT0GUtz
         RisCe7Q73e406GbNflF+by/dyTimKXB2uxm1HgVK97H7KEgroBCcho9IfxveUKUzDVZJ
         TQsw==
X-Gm-Message-State: AOJu0Yy+0rQBv8U4WRa6s4CPIBnhj0NkB4Mc9q81+iLgzj+vmywmfJx7
        7BDptGpO8uc9H7/JsBWOGOI=
X-Google-Smtp-Source: AGHT+IGLe2mAAsz55iDIerapn/68+pXnHp3WqiNQwhR1c/ip2wEjIzkS23So9Alef2RMCSpL0Wqreg==
X-Received: by 2002:adf:ec03:0:b0:319:7b66:7803 with SMTP id x3-20020adfec03000000b003197b667803mr19519828wrn.55.1697057269446;
        Wed, 11 Oct 2023 13:47:49 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id q8-20020a05600000c800b0032415213a6fsm16337923wrx.87.2023.10.11.13.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 13:47:49 -0700 (PDT)
Message-ID: <b09b6ee4-717c-44fa-abbe-cf9cef7b7d8b@gmail.com>
Date:   Wed, 11 Oct 2023 22:47:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/15] firmware: qcom: qseecom: convert to using the TZ
 allocator
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andrew Halaney <ahalaney@redhat.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20231009153427.20951-1-brgl@bgdev.pl>
 <20231009153427.20951-12-brgl@bgdev.pl>
 <y5otsuzhc27xeay6js4nkqss2bo5bsmygwdjuhqpdzce4yffxk@gkkh522s5e3b>
 <CAMRc=MdfZzG-C7=OVhR7x_vEmCexS39GEJ3F-CHM7cfya+A-VA@mail.gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <CAMRc=MdfZzG-C7=OVhR7x_vEmCexS39GEJ3F-CHM7cfya+A-VA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/23 09:44, Bartosz Golaszewski wrote:
> On Wed, Oct 11, 2023 at 12:49 AM Andrew Halaney <ahalaney@redhat.com> wrote:
>>
>> On Mon, Oct 09, 2023 at 05:34:23PM +0200, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> Drop the DMA mapping operations from qcom_scm_qseecom_app_send() and
>>> convert all users of it in the qseecom module to using the TZ allocator
>>> for creating SCM call buffers. Together with using the cleanup macros,
>>> it has the added benefit of a significant code shrink. As this is
>>> largely a module separate from the SCM driver, let's use a separate
>>> memory pool.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[...]

>>> @@ -704,12 +635,7 @@ static efi_status_t qsee_uefi_query_variable_info(struct qcuefi_client *qcuefi,
>>>        if (max_variable_size)
>>>                *max_variable_size = rsp_data->max_variable_size;
>>>
>>> -out_free:
>>> -     kfree(rsp_data);
>>> -out_free_req:
>>> -     kfree(req_data);
>>> -out:
>>> -     return efi_status;
>>> +     return EFI_SUCCESS;
>>>   }
>>>
>>>   /* -- Global efivar interface. ---------------------------------------------- */
>>> @@ -838,6 +764,10 @@ static int qcom_uefisecapp_probe(struct auxiliary_device *aux_dev,
>>>        if (status)
>>>                qcuefi_set_reference(NULL);
>>>
>>> +     qcuefi->mempool = devm_qcom_tzmem_pool_new(&aux_dev->dev, SZ_256K);
>>
>> Any particular reason for this size? Just curious, it was (one) of the
>> reasons I had not marked patch 4 yet (it looks good, but I wanted to get
>> through the series to digest the Kconfig as well).
>>
> 
> I cannot test this. Do you know what the minimum correct size would be?

Unfortunately, I don't know a specific size either.

We can try to roughly estimate that though: At most, we have some rather
negligible overhead for the argument struct and GUID, the name buffer,
and the data buffer (get/set variable). The name is limited to 1024
utf-16 characters (although that's a limit that we set in our driver,
not necessarily of the firmware). The thing that's more difficult to
gauge is the maximum data size. Also I think we can reach the alloc code
with multiple threads (unless the EFI subsystem is doing some locking).
Only the actual SCM call is locked on the qseecom side.

The efivar_query_variable_info() call could help with the data size part
(it can return the maximum valid size of a single variable).
Unfortunately it's not directly exposed, but I could code something up
to read it out. The next best thing is `df -h` (which uses the same call
under the hood) to get the total storage space available for EFI
variables. On my Surface Pro X, that's 60K. So I guess overall, 64K
should be enough for a single call. That being said, the biggest variable
stored right now is about 4K in size.

Given that that's a sample-size of one device though and that we might
want to future-proof things, I think 256K is a good choice. But we could
probably go with less if we really want to save some memory.

Regards,
Max
