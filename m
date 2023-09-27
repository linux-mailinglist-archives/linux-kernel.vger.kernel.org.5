Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6277B0374
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjI0MDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjI0MDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:03:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91412FC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 05:03:49 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32003aae100so8156374f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 05:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695816228; x=1696421028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jijfer/7eCNz5d5BIo7I4Bl8wL2YGtLqRbhXkOSybRs=;
        b=PNGruEm1Wn5LDKELZWLrKId9OxS7CLwWMBOVfVFJHm9K1DPcUKpFEJNKR2cnDCCd9P
         P1Td0KsL2d68SPbdDy9MGs4sx1qOY2gsD352UwNOlez/MMLNLjDma1jMmEzafUDoEwka
         thAJfZjcA/vPHAbH7sPx7p35FiJEWGnVFygj5wTmMh448ozYMr0ccC/NQTg/ytFbuLN5
         /jFs0/mgbI25s9GZAYSydiaPgRhXFnIGZIVxZWohXm7fmSEmGuBjup9DiRw3C3qO325u
         0nSX502dr7y4gf/hVALsiFSe0MCEHwpp9eXMhrglYZ15OK14oMgiW3Ahi0YcBfzIwNiL
         hPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695816228; x=1696421028;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jijfer/7eCNz5d5BIo7I4Bl8wL2YGtLqRbhXkOSybRs=;
        b=cR67R8D7h0itEjO5rrPU1Jgdxye5p733GrelPnFN9dS2dp7O/rc55pU4NQn86d5sU9
         KPtLLyUWqzXbNqFkenCxc4mXJ/kEkECF282yZXy9Xjdxs7qTK6nKsQz9Cp0aUq0w3hwt
         BxDo4xLAD15qcTEiMFsEDErpIpHmu4uqXuWDXuxPnZNUGxFQVm80lqp98h0RnZnuDa1P
         JhjK3czbZizEeGc463PCWuy2dBjqmDgsuqdE9VZK89pYnqOoQWMfa6eKu7DsqqKioVOx
         c4a1Y0IJhG7kGiEVVMiUyhtOljp3E4o4ZyzdXVL5xX+NBeUVoNiSoPjMcCwQib2i1z00
         Il6g==
X-Gm-Message-State: AOJu0YxaoH1KdqRzBJ13ATyIDTK/NHJPJyYYp7FSGeb5OZoXXJnqFtlk
        Y+b7c3hkaLwnQstRfW3pdQkk6g==
X-Google-Smtp-Source: AGHT+IEaeYWVJFO+6RpCdltvFb+3rxtBgeMmbeAB5ZzYo2qjuWG/T7aZ4nxbTNAS/LEd4l7yBFoA3g==
X-Received: by 2002:a5d:5903:0:b0:31f:afeb:4e7d with SMTP id v3-20020a5d5903000000b0031fafeb4e7dmr1727898wrd.18.1695816227977;
        Wed, 27 Sep 2023 05:03:47 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m16-20020a056000025000b0032330232802sm6149752wrz.4.2023.09.27.05.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 05:03:47 -0700 (PDT)
Message-ID: <d799f653-e00c-43be-9487-381a8ef4c849@linaro.org>
Date:   Wed, 27 Sep 2023 13:03:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v6 17/17] media: qcom: camss: Comment CSID dt_id
 field
Content-Language: en-US
To:     Hans Verkuil <hverkuil@xs4all.nl>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-kernel@vger.kernel.org
References: <20230925154707.837542-1-bryan.odonoghue@linaro.org>
 <20230925154707.837542-18-bryan.odonoghue@linaro.org>
 <cf7cdafb-ccd1-42ee-9c67-5e6600f752f7@xs4all.nl>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <cf7cdafb-ccd1-42ee-9c67-5e6600f752f7@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2023 12:42, Hans Verkuil wrote:
>> +		/*
>> +		 * DT_ID is a two bit bitfield that is concatenated with
>> +		 * the four least significant bits of the six bit VC
>> +		 * bitfield to generate an internal CID value.
>> +		 *
>> +		 * CSID_RDI_CFG0(vc)
>> +		 * DT_ID : 28:27
>> +		 * VC    : 26:22
> This is 5 bits, not 6 bits as the comment above says. Which is right?

Yes you're right I had "DT" which is six bits in my head when I wrote 
this. The VC bitfield is five.

> 
>> +		 * DT    : 21:16
>> +		 *
>> +		 * CID   : VC 3:0 << 2 | DT_ID 1:0
>> +		 */
>>   		u8 dt_id = vc;
> So if dt_id is 2 bits, and vc can be more than 2 bits in the future,
> shouldn't this read "vc & 3"?

Hmm...

val |= dt_id << RDI_CFG0_DT_ID;

yes that would overrun otherwise.

---
bod

