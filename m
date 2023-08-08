Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466B7773E35
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjHHQ1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjHHQZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:25:14 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B918902
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:50:19 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe2d218eedso50015565e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691509817; x=1692114617;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/zypaBxPLVAPc31qUuCjXrOIoE2MnVMIBlcoWFCbsKI=;
        b=iBFORKJq/rT3xrGAACLA+UTN9xpid/F4BU3QgnMZma5MZeCz6BoAFWY3kuYGOBxDtp
         CUgzksORbEH30hH1VMEg3USA5QLMWkvmcENqxvpsNITtNrm002vqa49vYaNxopZFhauM
         sivXPddJCCfsyO/EHFiy1t2/wYXTNKWqaQw6V78slyqpcomPi9Zz/aBrcCHX5RAx1HLG
         Flfj9q4co0plMAZPSY8uQM23OMxe/OQuhgqfmmHUa34FJK8FBgpMjtciUcV9MH79SkDm
         1nrIjKtdIVd47dwD6knwbTx/xZZZfwBC1zEKngb63BPbXktJ2Nc9FNV7+QA+QRffu2lW
         Wbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509817; x=1692114617;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zypaBxPLVAPc31qUuCjXrOIoE2MnVMIBlcoWFCbsKI=;
        b=jIJn3lx4QaJasjFFzuKOAUmtG+oyl9tU6pUlnwRlowLXk78jLLC2taqtliy0GMzBsF
         mWUS/cPFeKJtlPbVxcGHnzADFPhg3KaADUf/Rl0WOVicXNiZixbLu74YgeMC3ye1buCn
         7jsd4FeB8ta0xEmpSxk8SoH8z3L6diPnOy2VWvJBw+mDdXY8c9u34/2eUEHGVW2FIOAD
         auq/MmNe70h5uIFXwwGuztF6GNas8Q9hOdkg1Y0cqvVtXQMcKVqUY2xo35sb+8kIwvD+
         /6MkcnO9V//0O/NpktJiV6fVNwgqtIRj3c/1fmd+FAIpHNSTQ+rHjeLWNItCIGYxtTph
         awCQ==
X-Gm-Message-State: AOJu0YzKpGmPlhbaqjjmfu9qqgQryGT8QrxkTOcFv9lrekZTikFcvqPO
        khrl4OU3MSx8m0BXUdCQOIXDrOqjBilXNu+xhMI=
X-Google-Smtp-Source: AGHT+IEoGl3vyoVtiywtPvr5AXF6ZdPgkAryg6BVWtqdOXiDMhBXW7AIpBBiui1nIRpUAsdrT42WOQ==
X-Received: by 2002:ac2:4e8b:0:b0:4fe:181f:272c with SMTP id o11-20020ac24e8b000000b004fe181f272cmr6904189lfr.41.1691495409134;
        Tue, 08 Aug 2023 04:50:09 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id v2-20020ac25922000000b004fe4a1f046asm1856888lfi.266.2023.08.08.04.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 04:50:08 -0700 (PDT)
Message-ID: <30b1fe67-bab5-4add-8d89-cc8e06cd8c7f@linaro.org>
Date:   Tue, 8 Aug 2023 13:50:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/11] usb: dwc3: qcom: Refactor IRQ handling in QCOM
 Glue driver
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
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
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 xsFNBF9ALYUBEADWAhxdTBWrwAgDQQzc1O/bJ5O7b6cXYxwbBd9xKP7MICh5YA0DcCjJSOum
 BB/OmIWU6X+LZW6P88ZmHe+KeyABLMP5s1tJNK1j4ntT7mECcWZDzafPWF4F6m4WJOG27kTJ
 HGWdmtO+RvadOVi6CoUDqALsmfS3MUG5Pj2Ne9+0jRg4hEnB92AyF9rW2G3qisFcwPgvatt7
 TXD5E38mLyOPOUyXNj9XpDbt1hNwKQfiidmPh5e7VNAWRnW1iCMMoKqzM1Anzq7e5Afyeifz
 zRcQPLaqrPjnKqZGL2BKQSZDh6NkI5ZLRhhHQf61fkWcUpTp1oDC6jWVfT7hwRVIQLrrNj9G
 MpPzrlN4YuAqKeIer1FMt8cq64ifgTzxHzXsMcUdclzq2LTk2RXaPl6Jg/IXWqUClJHbamSk
 t1bfif3SnmhA6TiNvEpDKPiT3IDs42THU6ygslrBxyROQPWLI9IL1y8S6RtEh8H+NZQWZNzm
 UQ3imZirlPjxZtvz1BtnnBWS06e7x/UEAguj7VHCuymVgpl2Za17d1jj81YN5Rp5L9GXxkV1
 aUEwONM3eCI3qcYm5JNc5X+JthZOWsbIPSC1Rhxz3JmWIwP1udr5E3oNRe9u2LIEq+wH/toH
 kpPDhTeMkvt4KfE5m5ercid9+ZXAqoaYLUL4HCEw+HW0DXcKDwARAQABzShLb25yYWQgRHli
 Y2lvIDxrb25yYWQuZHliY2lvQGxpbmFyby5vcmc+wsGOBBMBCAA4FiEEU24if9oCL2zdAAQV
 R4cBcg5dfFgFAmQ5bqwCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQR4cBcg5dfFjO
 BQ//YQV6fkbqQCceYebGg6TiisWCy8LG77zV7DB0VMIWJv7Km7Sz0QQrHQVzhEr3trNenZrf
 yy+o2tQOF2biICzbLM8oyQPY8B///KJTWI2khoB8IJSJq3kNG68NjPg2vkP6CMltC/X3ohAo
 xL2UgwN5vj74QnlNneOjc0vGbtA7zURNhTz5P/YuTudCqcAbxJkbqZM4WymjQhe0XgwHLkiH
 5LHSZ31MRKp/+4Kqs4DTXMctc7vFhtUdmatAExDKw8oEz5NbskKbW+qHjW1XUcUIrxRr667V
 GWH6MkVceT9ZBrtLoSzMLYaQXvi3sSAup0qiJiBYszc/VOu3RbIpNLRcXN3KYuxdQAptacTE
 mA+5+4Y4DfC3rUSun+hWLDeac9z9jjHm5rE998OqZnOU9aztbd6zQG5VL6EKgsVXAZD4D3RP
 x1NaAjdA3MD06eyvbOWiA5NSzIcC8UIQvgx09xm7dThCuQYJR4Yxjd+9JPJHI6apzNZpDGvQ
 BBZzvwxV6L1CojUEpnilmMG1ZOTstktWpNzw3G2Gis0XihDUef0MWVsQYJAl0wfiv/0By+XK
 mm2zRR+l/dnzxnlbgJ5pO0imC2w0TVxLkAp0eo0LHw619finad2u6UPQAkZ4oj++iIGrJkt5
 Lkn2XgB+IW8ESflz6nDY3b5KQRF8Z6XLP0+IEdLOOARkOW7yEgorBgEEAZdVAQUBAQdAwmUx
 xrbSCx2ksDxz7rFFGX1KmTkdRtcgC6F3NfuNYkYDAQgHwsF2BBgBCAAgFiEEU24if9oCL2zd
 AAQVR4cBcg5dfFgFAmQ5bvICGwwACgkQR4cBcg5dfFju1Q//Xta1ShwL0MLSC1KL1lXGXeRM
 8arzfyiB5wJ9tb9U/nZvhhdfilEDLe0jKJY0RJErbdRHsalwQCrtq/1ewQpMpsRxXzAjgfRN
 jc4tgxRWmI+aVTzSRpywNahzZBT695hMz81cVZJoZzaV0KaMTlSnBkrviPz1nIGHYCHJxF9r
 cIu0GSIyUjZ/7xslxdvjpLth16H27JCWDzDqIQMtg61063gNyEyWgt1qRSaK14JIH/DoYRfn
 jfFQSC8bffFjat7BQGFz4ZpRavkMUFuDirn5Tf28oc5ebe2cIHp4/kajTx/7JOxWZ80U70mA
 cBgEeYSrYYnX+UJsSxpzLc/0sT1eRJDEhI4XIQM4ClIzpsCIN5HnVF76UQXh3a9zpwh3dk8i
 bhN/URmCOTH+LHNJYN/MxY8wuukq877DWB7k86pBs5IDLAXmW8v3gIDWyIcgYqb2v8QO2Mqx
 YMqL7UZxVLul4/JbllsQB8F/fNI8AfttmAQL9cwo6C8yDTXKdho920W4WUR9k8NT/OBqWSyk
 bGqMHex48FVZhexNPYOd58EY9/7mL5u0sJmo+jTeb4JBgIbFPJCFyng4HwbniWgQJZ1WqaUC
 nas9J77uICis2WH7N8Bs9jy0wQYezNzqS+FxoNXmDQg2jetX8en4bO2Di7Pmx0jXA4TOb9TM
 izWDgYvmBE8=
In-Reply-To: <dc800b15-e35d-207b-73a8-9a3d2261f4f5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8.08.2023 10:32, Krishna Kurapati PSSNV wrote:
>  +
>>> +enum dwc3_qcom_phy_irq_identifier {
>>> +    HS_PHY_IRQ = 0,
>>> +    DP_HS_PHY_IRQ,
>>> +    DM_HS_PHY_IRQ,
>>> +    SS_PHY_IRQ,
>>>   };
>>
>> This enum is unused.
>>
> 
> Hi Bjorn,
> 
>  I didn't use the enum directly, but used its members in the get_port_irq call below.
> 
>> [..]
>>> +static int dwc3_get_acpi_index(const struct dwc3_acpi_pdata *pdata, int irq_index)
>>> +{
>>> +    int acpi_index = -1;
>>> +
>>> +    if (!pdata)
>>> +        return -1;
>>> +
>>> +    if (irq_index == DP_HS_PHY_IRQ)
>>> +        acpi_index = pdata->dp_hs_phy_irq_index;
>>> +    else if (irq_index == DM_HS_PHY_IRQ)
>>> +        acpi_index = pdata->dm_hs_phy_irq_index;
>>> +    else if (irq_index == SS_PHY_IRQ)
>>> +        acpi_index = pdata->ss_phy_irq_index;
>>
>> It looks favourable to put these in an array, instead of having to pull
>> them out of 4 different variables conditionally.
>>
>>> +
>>> +    return acpi_index;
>>> +}
>>> +
>>> +static int dwc3_get_port_irq(struct platform_device *pdev, u8 port_index)
>>> +{
>>> +    struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
>>> +    bool is_mp_supported = (qcom->data->num_ports > 1) ? true : false;
>>> +    const struct dwc3_acpi_pdata *pdata = qcom->acpi_pdata;
>>> +    char *disp_name;
>>> +    int acpi_index;
>>> +    char *dt_name;
>>> +    int ret;
>>> +    int irq;
>>> +    int i;
>>> +
>>> +    /*
>>> +     * We need to read only DP/DM/SS IRQ's here.
>>> +     * So loop over from 1->3 and accordingly modify respective phy_irq[].
>>> +     */
>>> +    for (i = 1; i < MAX_PHY_IRQ; i++) {
>>> +
>>> +        if (!is_mp_supported && (port_index == 0)) {
>>> +            if (i == DP_HS_PHY_IRQ) {
>>> +                dt_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>>> +                    "dp_hs_phy_irq");
>>> +                disp_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>>> +                    "qcom_dwc3 DP_HS");
>>> +            } else if (i == DM_HS_PHY_IRQ) {
>>> +                dt_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>>> +                    "dm_hs_phy_irq");
>>> +                disp_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>>> +                    "qcom_dwc3 DM_HS");
>>> +            } else if (i == SS_PHY_IRQ) {
>>> +                dt_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>>> +                    "ss_phy_irq");
>>> +                disp_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>>> +                    "qcom_dwc3 SS");
> Bjorn, Konrad,
> 
> If we are to remove this repetitive loops, we might need to make a 2D array for all of Dp/Dm/Ss interrutps and make a global array of names to be used for irq lookup and use them to reduce the if-else-if stuff here. If that is fine, I can make those changes, else I would like to stick to this approach for now because if we don't add the global array of names, prepping them seperately for dp/dm/ss would again lead us to making if-else loops like above.
> 
> Please let me know your thoughts on this.
Can we not just reuse the associated interrupt-names from the devicetree
if present?

Konrad
