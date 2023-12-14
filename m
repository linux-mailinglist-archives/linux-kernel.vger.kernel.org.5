Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E063081346D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573670AbjLNPQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjLNPQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:16:28 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670EB129
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:16:33 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-67ad277a06bso51855536d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702566992; x=1703171792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=54RTUeCStl2XfJOj/oJEJaXZt4rCjNFswpjA28eM300=;
        b=kQljPUl2fXxqRoJNnSgwk99NcsawIjIrXawq3gW32+aGLE7LO6LV/v5TAHvntRTLe1
         RXv3V5b4Kh/jgxhLR/nSv/DgPXKa2re/XWMO/6biDM0i5LZGw5HglLDhUdmz95PhaNZz
         5usbhFifw/LCGV6RtTXdflTz9ozkvxNUFCu60GX2CuEk1k5UlszQy57I0dqIQ3VJnjSm
         gTmrjL/TJ+ScZb7VcPKTyiU9YkR7i2zphePVu7faMPssrvpIMyxEGvgcBEwPZk+Cubuv
         XWHuJmc+A3Olr8hUuZaLbmTkmWCKJP7etBFeXXoIFP93QsIClvkOTAEHuWNfi4gay7LE
         asyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702566992; x=1703171792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54RTUeCStl2XfJOj/oJEJaXZt4rCjNFswpjA28eM300=;
        b=OKEvEOtwcbYw4K+Aa4Wy7EUyjVJoVjszlRGIJpECqtFUv6pAa4jNoTyo1AyYHzD5TL
         VYIL4PKXwnDLKX3KnHMFEPeRSX1RqKgnu4eEy17rGWsop19Mme9hOvOyCANkdK0ov0Xt
         vCHbocnt/j3A4lqWU/mEfwMVc3AX6DKkbm/SeVu8xVnt+sGcC+m+81Dl835FN+scfhsZ
         ++7CeP0U0c1ucSws2gNUK3M8gRR5eCB3c6b4Rd4/vdAKVKkSpg40XHzkFyLL77kEn+BM
         vvhUjZr07TBldlSl7CbrjZrEayx4YDFkWEUCXVdJyCVFOe2HjTOqSWpZBw00gAaH6E+S
         6OCA==
X-Gm-Message-State: AOJu0Yy5WfTnEAOdlkLLo0Kf3tqFcb2QrSBpbH4Uh7layBgPWp8OcLZi
        57FA7jJFQHY6dw+GVn7p+ixdjQ==
X-Google-Smtp-Source: AGHT+IGLJtJAlPhMZDyfvOtG/1tfi4fUaHOYjcssxbj6fRakyinkNMF2tdViRIiqWzEz49/KDj+UZA==
X-Received: by 2002:a05:6214:4119:b0:67f:1007:c707 with SMTP id kc25-20020a056214411900b0067f1007c707mr667253qvb.70.1702566992547;
        Thu, 14 Dec 2023 07:16:32 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id db14-20020a056214170e00b0067eebb03a09sm399868qvb.143.2023.12.14.07.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 07:16:32 -0800 (PST)
Message-ID: <0d3ae184-5ded-42ab-97cf-13bbb296083a@linaro.org>
Date:   Thu, 14 Dec 2023 15:16:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] dt-bindings: clock: google,gs101: fix CMU_TOP gate
 clock names
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     peter.griffin@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
        alim.akhtar@samsung.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        s.nawrocki@samsung.com, tomasz.figa@gmail.com,
        cw00.choi@samsung.com, arnd@arndb.de, andre.draszik@linaro.org,
        saravanak@google.com, willmcvicker@google.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
 <20231214105243.3707730-2-tudor.ambarus@linaro.org>
 <CAPLW+4kr=aVjuqGz3ps5f6EzM+QASTFEoB57g+fR7jKH0s+1Zw@mail.gmail.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4kr=aVjuqGz3ps5f6EzM+QASTFEoB57g+fR7jKH0s+1Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/23 15:07, Sam Protsenko wrote:
> On Thu, Dec 14, 2023 at 4:52 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>> The gs101 clock names are derived from the clock register names under
>> some certain rules. In particular, for the gate clocks the following is
>> documented and expected in the gs101 clock driver:
>>
>>   Replace CLK_CON_GAT_CLKCMU      with CLK_GOUT_CMU and gout_cmu
>>   Replace CLK_CON_GAT_GATE_CLKCMU with CLK_GOUT_CMU and gout_cmu
>>
>>   For gates remove _UID _BLK _IPCLKPORT and _RSTNSYNC
>>
> 
> Doesn't it break existing gs101 device tree?

No, compilation went fine at this point. The TOP gates are not used in
the device tree at this point. And since the bindings patch was just
applied I think we should fix it, so that we avoid name clashes as
described below (I found a clash with a gate from PERIC0).

> 
>> The CMU TOP gate clock names missed to include the required "CMU"
>> differentiator which will cause name collisions with the gate clock names
>> of other clock units. Fix the TOP gate clock names and include "CMU" in
>> their name.
>>
>> Fixes: 0a910f160638 ("dt-bindings: clock: Add Google gs101 clock management unit bindings")
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
> 
> (snip)

Thanks for the review!
ta
