Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6632B7780A4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbjHJSqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbjHJSqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:46:36 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED48D2723
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:46:35 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe1c285690so1887345e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691693194; x=1692297994;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b4xXKoYz0SscgeohStVGKJKHkeZRwf4W5KkjybW+eAI=;
        b=QsqPYKHZ5NcoGCGetKyz+lsqn9hodhWUhLbQEA1zd982+X8DmKrAz+s3lQx8XLhkQQ
         uZBNdTX3nQpzqwgm0qi4qwz6lv7/+u2zNr/4JWvsXo9dLeS74qTRgJM+j5jcRs1hDsAa
         pw2ql5qcdSkRtlI3HzcCvyz/LwVb4hF8pygVRy9qfeXlXTzIJc8AY931YEapKtPq5tAq
         3X2x3cRri/bCAaNu6nZ0XxIDb6esZ3CYUVRoZSclfAwFkLmjoG0m1p2KxZj+PefTSlKR
         sgS6KYea0op11murxHqWK0B9wbbG7ykmEZoi8gzt5RfTxTNWFBWuWvsfVdDabHLF4f6B
         NL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691693194; x=1692297994;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4xXKoYz0SscgeohStVGKJKHkeZRwf4W5KkjybW+eAI=;
        b=K8uZWuiVkLLOYzkPdD3z/dJAtMGoVJgY2GT96aM2yF1/7XzX+dbLCjT1fYkn0t6/Wa
         Z5q9IRxdBQJcSJgHYG4TLNEAan4dWDoASpe99HfNhXXums9EghmfcSjr8WUyuE/iG6Cn
         eGM/3bln8m3gmLSspxHcRV/UIvyWJJz4SpFGrQd5Bx8av3G3JicUDUUGiIIzZb0kD6oJ
         q7q+tFDX3B6H/IITeRV1B0IiQt1WgNVCk27PRStfV+/vtrAdTPbM9xbqrmzWplwLLPbn
         OAbWYImAC4L2HvxJHGLEjdB4OGR68DyXtICQ3ssfaLr9UEB/KxN1HttWEO2cjXaxklvk
         HtBw==
X-Gm-Message-State: AOJu0YwHR9TfKUQfmLxgrxaT4eDDf5qi98dg2BN9Wc8Uzk6xKPVRgkWM
        mgc6eVIsCJ8a/phDkUfvgKIGdQ==
X-Google-Smtp-Source: AGHT+IFS6A4j2/jc16F+ODWRAHatCveHIxJXid+ZaYzs4Fr+4gretK+KfcljXYw8Aoh1Ve/YMSVo9w==
X-Received: by 2002:a05:6512:31d5:b0:4fe:1b6c:7d37 with SMTP id j21-20020a05651231d500b004fe1b6c7d37mr2920279lfe.65.1691693193855;
        Thu, 10 Aug 2023 11:46:33 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id e21-20020ac25475000000b004f37bd02a89sm386356lfn.287.2023.08.10.11.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 11:46:33 -0700 (PDT)
Message-ID: <868ee2b6-3b48-4d32-9614-fa9b3e057257@linaro.org>
Date:   Thu, 10 Aug 2023 20:46:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] clk: qcom: mmcc-msm8998: Fix the SMMU GDSC
Content-Language: en-US
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Imran Khan <kimran@codeaurora.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Joonwoo Park <joonwoop@codeaurora.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20230531-topic-8998_mmssclk-v3-0-ba1b1fd9ee75@linaro.org>
 <20230531-topic-8998_mmssclk-v3-5-ba1b1fd9ee75@linaro.org>
 <23575f97-332b-0392-fc20-0a52775d03b9@quicinc.com>
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
In-Reply-To: <23575f97-332b-0392-fc20-0a52775d03b9@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.08.2023 20:20, Jeffrey Hugo wrote:
> On 8/9/2023 1:20 PM, Konrad Dybcio wrote:
>> The SMMU GDSC doesn't have to be ALWAYS-ON and shouldn't feature the
>> HW_CTRL flag (it's separate from hw_ctrl_addr).  In addition to that,
>> it should feature a cxc entry for bimc_smmu_axi_clk and be marked as
>> votable.
> 
> I appear to have confused HW_CTRL with hw_ctrl_addr.  Thanks for fixing that.
> 
> I recall I made it always-on for display handoff.  The bootloader on the laptops will enable the display, which means the MDP is active and using the SMMU.  The SMMU is powered by the GDSC as you know.  The MDP is going to be polling a framebuffer in DDR, which EFI services (efifb) is going to be updating.  All of this is active during linux boot, which is how the kernel bootlog gets printed on screen.
This is essentially a missing / mis-configuration from the linux/dt POV and
I think the consensus for using display without describing it properly with
mdss has been to do one of:

- adding a simple-framebuffer node with all the necessary clocks/pds
- adding "clk_ignore_unused pd_ignore_unused" to your cmdline

> 
> If I remember right, the GDSC will be registered.  When it is done probing, there will be no consumers.  So the Linux framework will step in and turn it off before the consumers come up.  This kills power to the SMMU.  If the SMMU doesn't come back on before the MDP polls DDR again, you get a bus hang and a crash.
Yep

> I assumed that any msm8998 device would be using the MDP/GPU and thus the SMMU would pretty much always be powered on.
This flag however bans putting it to sleep when not in use.

> 
> I expected this patch to break the laptop.  It does not in my testing. However, I see that I disabled the MMCC node in DT with a todo about the display.  So the GDSC is never registered, and then never gets turned off.  I believe that todo is pending some updates I need to make to the TI DSI/eDP bridge because the I2C port on the bridge is not wired up.  I should really dust that off and complete it.
Right, so what you have now is a third, untold "solution" to the problem
described above.. not really a supported configuration as it's not "correct"

I'd happily see you wire up the bridge et al though!


> Regardless, even with the todo addressed, I think removing always-on will still break the laptops unless the bootloader handoff of display was solved and I missed it.
> 
> I get that for your usecase, a phone where the bootloader does not init the display, always-on has the potential to burn extra power.  I'm not sure how to make both of us happy through.
> 
> Do you have any suggestions?
Hope my replies above are enough.

Konrad
