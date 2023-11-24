Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CD67F6F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbjKXJNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjKXJNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:13:04 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A894D5A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:13:10 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9fa2714e828so226661366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700817189; x=1701421989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2jYp9bXT9jDvYNvvs/Oe7OEauC69oXByuyHCREX6JEc=;
        b=fxPrdwoB4dQ8Lj+SlhyZfurQFbP8v6w70lYwwDivq82t0UWpL0eW/4y/J0DWdNFmDR
         uWNxQhdtXPlSe/bL09/FNLdE2eN61XrrL4MnT4kO2KmbC/uH9E+psiPkAD+YWsbFD/Qy
         7ghN3e5HlLqhnRABsEbNaL5mbmeII8vKLIorWjCn/xopoU0jRzRAWj9d9yWfrwrCg9bd
         FMN6+SfvxnLJ1MxwTV+WKzMjedBAXZauKwntAEmnOMXavxV6xoPv4uFfQdPCLsv6KcWi
         GOJnmEYBFgEQtrIyqUOgBuElD4DSdxZjouAfoq96uOI7WlnCdod/hO+aX4xJfSKJi5+6
         mrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700817189; x=1701421989;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2jYp9bXT9jDvYNvvs/Oe7OEauC69oXByuyHCREX6JEc=;
        b=F5i0f8LK3nmVarvmFGwASom1nsvMo2I1/IqMOXDsx+MVRgTKRDcWWhytOEqnNlS7IB
         0rzPR+cskfhWZ4RTMrkduZQyN1bCJ85srttIqfq5byaauy3as+ajmqsH6bkCddJ876Tv
         gtSTw9q9X7mHUuGFC2Jp+UeSnG8W9Tu0IWqx5l1lV26ligo0Kr9ZBzu5pvRrKQlQeLKS
         z1AspMBWkr2uCiSuuOjljuayvh0Ktj4UNsSToV3BGF4cqd7LGLkkL3rlg0E81E7QBbTB
         ncs1nym2iiWp2qA1prp10FTD3Q1Aw7PcoPSxkVSvZCb95qGZiAfz5+RIQilf30EWk3mk
         Nq7w==
X-Gm-Message-State: AOJu0YxvPhnPNc5qRzV9LRKQtaRqFNu/3JbxNuCdIQbWquAaIQy4aPcB
        GPxzwb8ky2qEzFfFpxBHieJkGg==
X-Google-Smtp-Source: AGHT+IF/DUJRunD6cOJ0P7qB5Vmg62L2vUxnhUXmHn7H6nGKmsAouTxsq+7EQY/kFMKl2n2/QvACIg==
X-Received: by 2002:a17:906:3751:b0:9dc:2215:1593 with SMTP id e17-20020a170906375100b009dc22151593mr1421164ejc.25.1700817188666;
        Fri, 24 Nov 2023 01:13:08 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id n17-20020a170906379100b009e5eaf7a9b6sm1805588ejc.139.2023.11.24.01.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 01:13:08 -0800 (PST)
Message-ID: <b3a382e3-2f24-4481-adec-030cc79997b3@linaro.org>
Date:   Fri, 24 Nov 2023 10:13:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 05/10] usb: dwc3: qcom: Refactor IRQ handling in QCOM
 Glue driver
Content-Language: en-US
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Johan Hovold <johan@kernel.org>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com
References: <ZTY7Lwjd3_8NlfEi@hovoldconsulting.com>
 <cabf24d0-8eea-4eb5-8205-bf7fe6017ec2@quicinc.com>
 <ZTZ-EvvbuA6HpycT@hovoldconsulting.com>
 <fb5e5e1d-520c-4cbc-adde-f30e853421a1@quicinc.com>
 <ZTdqnSHq_Jo8AuPW@hovoldconsulting.com>
 <04615205-e380-4719-aff1-f32c26004b14@quicinc.com>
 <ZUz4RD3MjnLlPn6V@hovoldconsulting.com>
 <6d4d959c-b155-471b-b13d-f6fda557cfe0@quicinc.com>
 <ZVYTFi3Jnnljl48L@hovoldconsulting.com>
 <e0789695-43ee-4285-95e9-4cdee24d6ffe@quicinc.com>
 <ZV9XTU-q038BaWn3@hovoldconsulting.com>
 <4fc27dbb-b0aa-437a-a48c-9deea236282d@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <4fc27dbb-b0aa-437a-a48c-9deea236282d@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2023 10:00, Krishna Kurapati PSSNV wrote:
>>
>>> I didn't add missing interrupts on sc8280xp because I see that current
>>> interrupts present are working fine (I see ADB working and wakeup
>>> working as well), but the interrupt vector numbers are off by "1"
>>> between hs specifics and DT (both upstream and downstream). Will sort it
>>> out and clean that target up later.
>>
>> Which interrupt numbers are off by one here?
>>   
> 
> My bad, this might be the confusion. The HW specifics say:
> 
> Controller-2, power_event irq:
> 
> SYS_apcsQgicSPI[812]		Vector-number: 843
> 
> 
> Usually vector number = 32 + GIC number AFAIK.
> By that logic, If vector number is 843, GIC_SPI number is 811 which is 
> same as DT. Probably the GIC_SPI number is printed wrong. The DT matches 
> (vector number - 32).
> 
> Sorry for mentioning that it is wrong. The DT entries are right and it 
> is working on upstream.
> 
> The missing hs_phy_irq's have been put on the mail thread on this list 
> before.
> 
> Regards,
> Krishna,
> 
>>> [1]: https://patchwork.kernel.org/project/linux-arm-msm/list/?series=803412
>>
>> I took a quick look at the series, and it looks like this will
>> eventually clean things up a lot. We should probably define a generic
>> order for the interrupts with the sometimes optional SS interrupts last.
>>
>> Side note: It looks like the threading in that series is broken.
>> Consider using git-send-email for sending series as it takes care of
>> things like that.
>>
> 
> Usually I do git send-email for the whole out folder where the patches 
> are present, but linux-usb list is common to all the patches in that 
> case, even the DT ones. So to avoid that and to send patches to only 
> relavant mailing lists, I did git send email individually on each patch 
> which might have caused this issue.

I don't understand why. This is some weird workflow. If you do not use
b4, then it is simple:
git format-patch -10 -v13
get_maintainers v13*
git send-email v13*
And that's it. Last two steps can be even one command, like I am doing
(shared the macro multiple times).

Best regards,
Krzysztof

