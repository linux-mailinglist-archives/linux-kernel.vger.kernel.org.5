Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C2F78C47D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbjH2Ms6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbjH2Msr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:48:47 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7C99D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:48:44 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52a23227567so5785777a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693313323; x=1693918123;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y4ZB9IFtFUuFFcjS/nYEF1e731K9c/eRdMCMzmNHQxA=;
        b=hjdzTYAafao0EoU9yHzSlA4aJo+7SjgVpwJ8lttplu/E3tMngv8lOjcnFjxTkNrymh
         1faJfvUXDzvMNLYYya5ZEvdUUiaUZyIIaJcOrhZWKvfO/hpzC6xQd6/Ei7MsKdGHBBRP
         B4RBZVDLtMKYQlywXvTnmHDOdEG2/DpYk9GQdpT3ka1GGkz3BWP9gq1ExGTdu4wz9Tkj
         Ya+DGsA64yXXMTKJsn0b9X41skaYCJbvlUNhSB08rRItBhEYL1w5m8Nen1N3q6puXzkk
         X8BrQ7jN798Vl4NmfcUWirHdIYiHNJwWxxtGnffzVlWPmytc0ItRgew+rHa8st9nJGHd
         Fp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693313323; x=1693918123;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4ZB9IFtFUuFFcjS/nYEF1e731K9c/eRdMCMzmNHQxA=;
        b=iy3B0WWaaKsTpVnySVw/ZM3PWz6lblV0s6q4LPCkmIOOm2WIwShkvVULwhUHKJu8f6
         KU3BefO+/euxmBqB+zW2hXOui4eFciFPtIY2FcHZMOAvSAkhs6rGgvBhzSIHdi2PGArO
         ceuZWpq+yWGnAqfpwQN0ixGAF6hOinQPlhLlBLv+FNZbb6dBzPxwu70m4BYp2MRxyUtz
         /t95MPTIVWMCaasFoN20SKMsc7Q0VJPPnz0Sb6i1AqlJg78j2o5ep1ys2gVy+EqLBeZW
         URol9996gziDvLAN+2ZTc5ka3PD2G5p292/KS0xv+PXuLhsfvYPnUk5IKrztBQDdDpxW
         p0TA==
X-Gm-Message-State: AOJu0YwiiyLUCY5MRRWJdKQfpuR9woZYSLxVrXg5cPUYDKlHzUz7SMq3
        nLyQi0JdR9bZ1uru855ylQDvTw==
X-Google-Smtp-Source: AGHT+IGHep5I8SAjK//XF2L4Aseknz+NQ8a6ANNVnRmnFOdbQ04cFdNtUjdb1nr1IfAk+P58kADhyQ==
X-Received: by 2002:a05:6402:2025:b0:521:ae63:ee63 with SMTP id ay5-20020a056402202500b00521ae63ee63mr22934346edb.16.1693313323426;
        Tue, 29 Aug 2023 05:48:43 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id s17-20020a056402165100b0052328d4268asm5622564edx.81.2023.08.29.05.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 05:48:42 -0700 (PDT)
Message-ID: <36dc8000-6baf-5af0-1921-8ed509796ed0@linaro.org>
Date:   Tue, 29 Aug 2023 14:48:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 03/11] firmware: qcom-scm: atomically assign and read the
 global __scm pointer
Content-Language: en-US
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230828192507.117334-1-bartosz.golaszewski@linaro.org>
 <20230828192507.117334-4-bartosz.golaszewski@linaro.org>
 <cc35c729-df33-087b-2df4-95e8cc174ec6@linaro.org>
 <CACMJSesDZw6i6jb05kY2iN=Qf3Ln5f6Yz5gdrkoFk86NnNv1Gg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CACMJSesDZw6i6jb05kY2iN=Qf3Ln5f6Yz5gdrkoFk86NnNv1Gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 14:31, Bartosz Golaszewski wrote:
> On Tue, 29 Aug 2023 at 09:59, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 28/08/2023 21:24, Bartosz Golaszewski wrote:
>>> Checking for the availability of SCM bridge can happen from any context.
>>> It's only by chance that we haven't run into concurrency issues but with
>>> the upcoming SHM Bridge driver that will be initiated at the same
>>> initcall level, we need to assure the assignment and readback of the
>>> __scm pointer is atomic.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> ---
>>>  drivers/firmware/qcom_scm.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>>> index 980fcfa20b9f..422de70faff8 100644
>>> --- a/drivers/firmware/qcom_scm.c
>>> +++ b/drivers/firmware/qcom_scm.c
>>> @@ -1331,7 +1331,7 @@ static int qcom_scm_find_dload_address(struct device *dev, u64 *addr)
>>>   */
>>>  bool qcom_scm_is_available(void)
>>>  {
>>> -     return !!__scm;
>>> +     return !!READ_ONCE(__scm);
>>>  }
>>>  EXPORT_SYMBOL(qcom_scm_is_available);
>>>
>>> @@ -1477,8 +1477,8 @@ static int qcom_scm_probe(struct platform_device *pdev)
>>>       if (ret)
>>>               return ret;
>>>
>>> -     __scm = scm;
>>> -     __scm->dev = &pdev->dev;
>>> +     scm->dev = &pdev->dev;
>>> +     WRITE_ONCE(__scm, scm);
>>
>> Your re-ordering is not effective here, I think. I don't understand it's
>> purpose exactly, but scm->dev assignment is not WRITE_ONCE(), thus it
>> can be reordered:
>>
>> "compiler is also forbidden from reordering successive instances of
>> READ_ONCE and WRITE_ONCE" <- so compiler is not forbidden to reorder
>> other stuff.
>>
>> "Ensuring that the compiler does not fold, spindle, or otherwise
>> mutilate accesses that either do not require ordering or that interact"
>> <- which means you do not require ordering here.
>>
> 
> Hmm, I had the list_add() implementation in mind as well as examples
> from https://www.kernel.org/doc/Documentation/memory-barriers.txt and
> was under the impression that WRITE_ONCE() here is enough. I need to
> double check it.

It all depends what do you want to achieve. If strict ordering of both
writes, then all the examples and descriptions from memory-barriers.txt
say that you need WRITE_ONCE in both places.

If you want to achieve something else, like scm->dev visible for other
CPUs before __scm=scm then you would need full barriers, IMHO.


Best regards,
Krzysztof

