Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A977877959F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbjHKRFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbjHKRFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:05:12 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B62211C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:05:11 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9bb097c1bso34039761fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691773509; x=1692378309;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KmYvyZJ/MZJ7qF+caJh0dxeZFJ+UOhFluzJhEvu+/8A=;
        b=PNSuWfY6HccIFUxWRmD+aYcX9N29vq+/UkLf5Y6n8qHgWdRYYqbfigUuPzOEwas3us
         11KeQh9XXkTE3kC45V3NVehq8a06CQcSK8p/BemAganwznRCG8GofImL3yKWC1APeKmt
         +nfc4fvsXlRhXTN/d4OyfCw4WNkVZ5OwrkxB/fHNXKrXqMAbq0QNXJ9LMYv7pZVETlaS
         Yrls/qzbChAvxVhNkmhBvJk0KLW2n29ci3KS3yLEBOVDwslZJ+Fb2JCZdvRrg3+0r9X2
         JYR7wigTQkbDuyvCtFdM63Duy+EZHdIPyHpMGMMkbdz32fQqJFfH+tznkE0xUT6ly3bQ
         Xmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691773509; x=1692378309;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KmYvyZJ/MZJ7qF+caJh0dxeZFJ+UOhFluzJhEvu+/8A=;
        b=FjAyV0BWrgrKUu3hJRxCl4fGNHxvRUSZnznjSK8shR/A+8GldeKeTpRAHTN2Jk66Ga
         S3C2a58UIO53aIH1Pal/EJsRiHgZUDvQGOGLN/LPNI7wz97W+exEJQoUIQ/RVEIepNxr
         vUDWbzBkHFvvFWO7ZwvVE4ehFF2syBDfLF6Y8k0YqKYamfU1WqrYMRsuFMFkOwgQP/AO
         mhTK/KnZnAL/00X5Gz0SpmUSav4OOudQ1u4c7CgJxx62za0odlCvRI9+dmrra3wTL8F6
         Sqyq5HcZLneBfi/wuz57b+bCMOajRo8fFAdKBzN8pRzfL3M7XzCodpcdNPFHsMIioCgc
         rN6A==
X-Gm-Message-State: AOJu0YyVeGTnAdhQcBO4b2iXreHjDAWwtmnja7YmlHjKHXw5Ku3G3X++
        AaBtTfsIrAivLOKl6cbuTrzpgp8NCjBXMlJELAQ=
X-Google-Smtp-Source: AGHT+IFISNeODcY6NT/CCJDKCZhNtDLcz1zasMXh2CR/m9kSG5BB0vgDr/qYP3QAK2ZPJtWA8Wf2Mg==
X-Received: by 2002:a2e:80c3:0:b0:2b9:bcac:7ba6 with SMTP id r3-20020a2e80c3000000b002b9bcac7ba6mr1961728ljg.46.1691773509299;
        Fri, 11 Aug 2023 10:05:09 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id y15-20020a05651c020f00b002b6ed0067c9sm944492ljn.116.2023.08.11.10.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 10:05:08 -0700 (PDT)
Message-ID: <c8d77d4f-6696-4dc9-8030-daf1d10b114b@linaro.org>
Date:   Fri, 11 Aug 2023 19:05:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/11] usb: dwc3: qcom: Refactor IRQ handling in QCOM
 Glue driver
Content-Language: en-US
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan@kernel.org>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com
References: <20230727223307.8096-1-quic_kriskura@quicinc.com>
 <20230727223307.8096-7-quic_kriskura@quicinc.com>
 <pyxerd3lirbh2p43m74ohwocjjb7uh56xxmaxbrkay3svossik@ksd3yojw5wgr>
 <dc800b15-e35d-207b-73a8-9a3d2261f4f5@quicinc.com>
 <30b1fe67-bab5-4add-8d89-cc8e06cd8c7f@linaro.org>
 <3c8dff80-eec8-1721-8ab0-3cf12d4c1df4@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <3c8dff80-eec8-1721-8ab0-3cf12d4c1df4@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.08.2023 08:06, Krishna Kurapati PSSNV wrote:
> 
> 
> On 8/8/2023 5:20 PM, Konrad Dybcio wrote:
>> On 8.08.2023 10:32, Krishna Kurapati PSSNV wrote:
>>>   +
>>>>> +enum dwc3_qcom_phy_irq_identifier {
>>>>> +    HS_PHY_IRQ = 0,
>>>>> +    DP_HS_PHY_IRQ,
>>>>> +    DM_HS_PHY_IRQ,
>>>>> +    SS_PHY_IRQ,
>>>>>    };
>>>>
>>>> This enum is unused.
>>>>
>>>
>>> Hi Bjorn,
>>>
>>>   I didn't use the enum directly, but used its members in the get_port_irq call below.
>>>
>>>> [..]
>>>>> +static int dwc3_get_acpi_index(const struct dwc3_acpi_pdata *pdata, int irq_index)
>>>>> +{
>>>>> +    int acpi_index = -1;
>>>>> +
>>>>> +    if (!pdata)
>>>>> +        return -1;
>>>>> +
>>>>> +    if (irq_index == DP_HS_PHY_IRQ)
>>>>> +        acpi_index = pdata->dp_hs_phy_irq_index;
>>>>> +    else if (irq_index == DM_HS_PHY_IRQ)
>>>>> +        acpi_index = pdata->dm_hs_phy_irq_index;
>>>>> +    else if (irq_index == SS_PHY_IRQ)
>>>>> +        acpi_index = pdata->ss_phy_irq_index;
>>>>
>>>> It looks favourable to put these in an array, instead of having to pull
>>>> them out of 4 different variables conditionally.
>>>>
>>>>> +
>>>>> +    return acpi_index;
>>>>> +}
>>>>> +
>>>>> +static int dwc3_get_port_irq(struct platform_device *pdev, u8 port_index)
>>>>> +{
>>>>> +    struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
>>>>> +    bool is_mp_supported = (qcom->data->num_ports > 1) ? true : false;
>>>>> +    const struct dwc3_acpi_pdata *pdata = qcom->acpi_pdata;
>>>>> +    char *disp_name;
>>>>> +    int acpi_index;
>>>>> +    char *dt_name;
>>>>> +    int ret;
>>>>> +    int irq;
>>>>> +    int i;
>>>>> +
>>>>> +    /*
>>>>> +     * We need to read only DP/DM/SS IRQ's here.
>>>>> +     * So loop over from 1->3 and accordingly modify respective phy_irq[].
>>>>> +     */
>>>>> +    for (i = 1; i < MAX_PHY_IRQ; i++) {
>>>>> +
>>>>> +        if (!is_mp_supported && (port_index == 0)) {
>>>>> +            if (i == DP_HS_PHY_IRQ) {
>>>>> +                dt_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>>>>> +                    "dp_hs_phy_irq");
>>>>> +                disp_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>>>>> +                    "qcom_dwc3 DP_HS");
>>>>> +            } else if (i == DM_HS_PHY_IRQ) {
>>>>> +                dt_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>>>>> +                    "dm_hs_phy_irq");
>>>>> +                disp_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>>>>> +                    "qcom_dwc3 DM_HS");
>>>>> +            } else if (i == SS_PHY_IRQ) {
>>>>> +                dt_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>>>>> +                    "ss_phy_irq");
>>>>> +                disp_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>>>>> +                    "qcom_dwc3 SS");
>>> Bjorn, Konrad,
>>>
>>> If we are to remove this repetitive loops, we might need to make a 2D array for all of Dp/Dm/Ss interrutps and make a global array of names to be used for irq lookup and use them to reduce the if-else-if stuff here. If that is fine, I can make those changes, else I would like to stick to this approach for now because if we don't add the global array of names, prepping them seperately for dp/dm/ss would again lead us to making if-else loops like above.
>>>
>>> Please let me know your thoughts on this.
>> Can we not just reuse the associated interrupt-names from the devicetree
>> if present?
>>
> Hi Konrad,
> 
>  Thanks for the comments but one more confirmation.
> We can read the interrupts from DT but I believe the compatible would still need to stay. We need the num_ports information not just for registering interrupts but for modifying the pwr_event_irq registers during suspend/resume. If we rely on the interrupts to find the number of ports, the user is free to remove any IRQ and we might end up in a situation where glue and core are not having same view of how many number of ports present. So I believe its best to keep the compatible and get num_ports info from there and rely on reading interrupt-names to get interrupts cleanly. Can you let me know your view on the same.
So is "is it okay to add SoC-specific compatibles and add the port number in
match data" what you're asking?

If so, that doesn't seem right.

The user should not "feel free to remove any IRQ", modifying the devicetree to
depict a subset of the hardware is not something we want to support. The driver
has to work with the "full" description in accordance with the bindings.

Konrad
