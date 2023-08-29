Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4E478C3C0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjH2L7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbjH2L7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:59:07 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B525F1B4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 04:59:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4018af103bcso26846635e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 04:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693310342; x=1693915142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KLoD04MXzPDvd3uBWHGHq50+QEKQ9VSBhdzvUrQwqIk=;
        b=bahIsMFSy+IQGQ0Yl0YrSZ57gOJ8bEMz6ZI8AoG4t4XfaG69kamMiT+jNABpqL7HTm
         3rcuwHk/v8eOhL+/W7r0l5oIwDi3fk58yXDQ/FUFocq/TL56giUDR3iTQ3ECpxylHM9E
         /wa6esqaafmNhJj4wBK7HROzgbINLz1TZG0l+GC24qKHoAs7CwgjoT51duaHa++auoxx
         9/bQLsY4xJupC/KTiRA96am4306QzKm98OJ2lVpjjyE3rx05jlY48Bxp2QwVrBW67YmQ
         4ydo10TLQSRsPXahBG18IJoHf1fLBcRthB1RNCAXE49kkxt14mKf1vBw0M24ZUf4ZcgF
         sQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693310342; x=1693915142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLoD04MXzPDvd3uBWHGHq50+QEKQ9VSBhdzvUrQwqIk=;
        b=YtZ1tgoMxKBsROr2RAfj2U2817Ca7f24+Q52TuYad1IbaH3O8TTfek+2y2cQbn6fgA
         LHakmMkY+1LkwlOvAxLinOB64Sk2M7xZW81t/jJ+/4UORQjbqT9ja9spi24GmQDvRcNn
         nWLMyJSPSL6vw0941ZTFVpAi/uu3MuvPEStulsB/xerUcinsODD42zobh9FutoKiKLxl
         AWirseBA/3kWVfEJ/3o+bQdXg4vIYItaPkdsatMMzO/1GquXvWyWYaZydLDLb9cOo/em
         YZpilGdWnLLdpAafe/lWvR8xrN8YCIy+S+KO7tm+NreNR4RPLhsGcrSUowpHd7WkLZbt
         4vBQ==
X-Gm-Message-State: AOJu0YzQyDnv5Azs3wtXX0LYgGzSKejAqPA3bWND1cRQeC0j0ONWgg8S
        KaIFgFk75Fq+ir/bUYa79LTqOw==
X-Google-Smtp-Source: AGHT+IG3XTGvzlu63R7crie3+qbFU8gRZTMcntaik1BOhE9xjzNYGyVazt67HXt2bJyE142iGySd5Q==
X-Received: by 2002:a05:600c:3798:b0:3fb:f0b2:20eb with SMTP id o24-20020a05600c379800b003fbf0b220ebmr1872340wmr.1.1693310342111;
        Tue, 29 Aug 2023 04:59:02 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id p33-20020a05600c1da100b003fef5e76f2csm1585778wms.0.2023.08.29.04.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 04:59:01 -0700 (PDT)
Message-ID: <6ecbd88a-150f-d40e-22bf-4fda921fc483@linaro.org>
Date:   Tue, 29 Aug 2023 12:59:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 4/4] venus: hfi_parser: Add check to keep the number of
 codecs within range
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, tfiga@chromium.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <1691634304-2158-1-git-send-email-quic_vgarodia@quicinc.com>
 <1691634304-2158-5-git-send-email-quic_vgarodia@quicinc.com>
 <fec4a8c7-206f-7af8-4ea9-c919a677bf7e@linaro.org>
 <2214c31b-eca2-012e-a100-21252a724e7c@quicinc.com>
 <8b72ce47-c338-2061-f11a-c0a608686d8c@linaro.org>
 <e880da07-ccd4-e427-ed34-20b284dc7838@quicinc.com>
 <8f1a4ca0-dde8-fa5d-bca3-d317886609de@linaro.org>
 <060f4dbe-63d6-1c60-14ca-553bf1536e5a@quicinc.com>
 <c5f912a9-cc08-1645-ad04-c7a58c1e47ce@linaro.org>
 <cd9da205-ccdb-dc71-16a4-83b22ca7fcae@quicinc.com>
 <ea587bb1-8ff2-7a92-f948-fd932f6b2769@linaro.org>
 <9391ae4e-afbd-ef52-12dc-7f8875216c85@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <9391ae4e-afbd-ef52-12dc-7f8875216c85@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 09:00, Vikash Garodia wrote:
> Hi Bryan,
> 
> On 8/14/2023 7:45 PM, Bryan O'Donoghue wrote:
>> On 14/08/2023 07:34, Vikash Garodia wrote:
>>>> We have two loops that check for up to 32 indexes per loop. Why not have a
>>>> capabilities index that can accommodate all 64 bits ?
>>> Max codecs supported can be 32, which is also a very high number. At max the
>>> hardware supports 5-6 codecs, including both decoder and encoder. 64 indices is
>>> would not be needed.
>>>
>>
>> But the bug you are fixing here is an overflow where we have received a full
>> range 32 bit for each decode and encode.
>>
>> How is the right fix not to extend the storage to the maximum possible 2 x 32 ?
>> Or indeed why not constrain the input data to 32/2 for each encode/decode path ?
> At this point, we agree that there is very less or no possibility to have this
> as a real usecase i.e having 64 (or more than 32) codecs supported in video
> hardware. There seem to be no value add if we are extending the cap array from
> 32 to 64, as anything beyond 32 itself indicates rogue firmware. The idea here
> is to gracefully come out of such case when firmware is responding with such
> data payload.
> Again, lets think of constraining the data to 32/2. We have 2 32 bit masks for
> decoder and encoder. Malfunctioning firmware could still send payload with all
> bits enabled in those masks. Then the driver needs to add same check to avoid
> the memcpy in such case.
> 
>> The bug here is that we can copy two arrays of size X into one array of size X.
>>
>> Please consider expanding the size of the storage array to accommodate the full
>> size the protocol supports 2 x 32.
> I see this as an alternate implementation to existing handling. 64 index would
> never exist practically, so accommodating it only implies to store the data for
> invalid response and gracefully close the session.

What's the contractual definition of "this many bits per encoder and 
decoder" between firmware and APSS in that case ?

Where do we get the idea that 32/2 per encoder/decoder is valid but 32 
per encoder decoder is invalid ?

At this moment in time 16 encoder/decoder bits would be equally invalid.

I suggest the right answer is to buffer the protocol data unit - PDU 
maximum as an RX or constrain the maximum number of encoder/decoder bits 
based on HFI version.

ie.

- Either constrain on the PDU or
- Constrain on the known number of maximum bits per f/w version

---
bod

