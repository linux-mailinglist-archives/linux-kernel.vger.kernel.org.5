Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FD778AA4B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjH1KVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjH1KUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:20:41 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8229CCEB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:20:14 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe61ae020bso4554148e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693218011; x=1693822811;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cvoOITWtFaNG9POgyW2mF9j8Nw/ZFb+8+V0tdCk2Wrs=;
        b=PDEoA1CgaH3JBNLP4OI69JrUISJzVSa0wszoHtPiKnO+qynjXqmZV7czsVCjfeYOXw
         27VhbVYhXhULpJZZbEbg2GOlEvw9xKqrtweVsPNpb6mIYsWRk5K4oLVxs9iwMvrU1y7/
         Y3W949T+SGPoXXRUAFoBlokNL7hfC/NQLUKv16VZjvbxX997iFBsbxQ/ZLhEC71pQlXB
         gPvhD4ZM9JcPZ03ThSElkjlQm6XwaDdXKSzIq5kGZLDCV1BebHwTJtaVk47wxc6DvPN/
         10v8Ha1APilB49mfe9I21v7tCxBHsYaF+Vyt2inUEUUo4IZD2aY8yyB+fbbO8HgY3lFp
         aaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693218011; x=1693822811;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cvoOITWtFaNG9POgyW2mF9j8Nw/ZFb+8+V0tdCk2Wrs=;
        b=OYiqwSabyJPri8pE88bhM2jr9kWMPMRe7ti2urQ8b5DNJkrVjKjLxMwTrGWZiKMYQq
         tAf7v3tsoRD66WaMLCJGl1NR1rOggURvXfeI3tN8gFXc/6OpiEG+h4w8Siu5xROIoUJU
         DBa9ylzH0qB49bCA/2fhlrC5uPHH8pvFldALrMkYE7uaERDOOyMglGNiox6yA6fFARAV
         coAJ5pz0QdJIvo+TBJxk9sXUknhJCaALKCYLgxi8RBebTwzYqXHvu9lNoxAkno1/giIn
         BwhTMngylK/u4qBrquzOwUm2pFtCPt++tn3N0iO2aSwr2gHozvuXOLAWmlIbbJVJbNo4
         BHww==
X-Gm-Message-State: AOJu0YwIO6ujBDkGOY1QEyjHENz1Gp4TanvRJg0EIS35vd1C7YreMg9n
        XgpzjOpnvR9qQLmAnuDWauaRzw==
X-Google-Smtp-Source: AGHT+IGOmOYMHsHLMpmbGBNUWNAqmHNZVUvHB3LgOdAD1xiIwjirxbzn+XXMQjcAeR4q3Amxi6qTEw==
X-Received: by 2002:ac2:562f:0:b0:4f8:5755:5b22 with SMTP id b15-20020ac2562f000000b004f857555b22mr16670646lff.27.1693218010994;
        Mon, 28 Aug 2023 03:20:10 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id m13-20020ac2424d000000b004fea9cf6a32sm1520604lfl.204.2023.08.28.03.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 03:20:10 -0700 (PDT)
Message-ID: <8876d95c-e7ea-478a-bb88-b97e5cf67f08@linaro.org>
Date:   Mon, 28 Aug 2023 12:20:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] irqchip/qcom-pdc: don't read version register if it
 is not available
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20230825213552.1646321-1-dmitry.baryshkov@linaro.org>
 <09d89b1c-8c78-7671-a385-99c6a8910fde@quicinc.com>
 <CAA8EJppmn5hM5=zdkQoaGAYghw822vP8YoW0wQsNmAZY0v7dtA@mail.gmail.com>
 <865y4zfppf.wl-maz@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <865y4zfppf.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.08.2023 12:04, Marc Zyngier wrote:
> On Mon, 28 Aug 2023 10:46:10 +0100,
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
>>
>> On Mon, 28 Aug 2023 at 12:36, Maulik Shah (mkshah)
>> <quic_mkshah@quicinc.com> wrote:
>>>
>>> Hi Dmitry,
>>>
>>> This patch may be useful if there was a case where some PDCs don't have
>>> version register populated/available,
>>> In all PDC versions, version register is always available but due to reg
>>> size not good enough in device tree for SM8150 it failed to read.
>>>
>>> reg size in device node must be expanded if its too small to access all
>>> registers and i think
>>> additional check in driver to check if size is good enough would not be
>>> of much use.
>>
>> Unfortunately, it doesn't work this way. DT files are ABI. Even if we
>> change the DT, the kernel should continue working with the older
>> version.
>> Thus, we have to add such bandaid code, which will keep the kernel
>> from crashing if old DT was used.
> 
> You're missing the point: all existing PDC HW have version register.
> The fact that the DT is crap doesn't invalidate this simple fact. It
> is thus perfectly possible for the driver to *ignore* the crap and do
> the right thing by expanding the size of the mapping, rather than
> falling back to the non-versioned code.
I wasn't sure if this would cross the "too hacky" boundary, but if
you're fine with it, I'll happily ack this approach.

Konrad
