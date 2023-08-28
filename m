Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E500178A929
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjH1Jqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjH1JqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:46:18 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D9712A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 02:45:58 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b974031aeaso45752271fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 02:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693215956; x=1693820756;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rusxYmLJ/HZcugojPMEWWJ5RDjniz2ycIA7Aqq/Y6+Q=;
        b=m1AjtH+eUzgoS3yBSLT4i27hoMYwwbdW+rmtmXRhhoH6nYci96WlIRzCeuIQ0gzJSx
         SaaBAbNPHE0t0Pt9CSzimCtqe+cUb1r1II7g9iyQnmvP3BN/wnwG3scD2XrTGYdScka4
         0/+X6fDZsD8toUj+VWcYdZEr73SEHtMlaeJLuVxJP1kMrIEk1PnSP0GM18kDXIWYbANr
         7N5STVI4oIgb+GZlqoI5UQOJVA3U5ZUFw7SSpDGiVl1YkiIO2y6u+iLbkSiBWlLwoirN
         VNdmzXo0iD+mGXjrnAJKtWbZgYgwm/7WvbCs0nxtqmLKSkF5aUSw8+hC+1XX0xOhV7lG
         6rkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693215956; x=1693820756;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rusxYmLJ/HZcugojPMEWWJ5RDjniz2ycIA7Aqq/Y6+Q=;
        b=GRnG6mVOD0ffZTB8IOUQadARhYKPLWxuiQaBlTE42OiWGktGtITsqaZsQY/zqe+48I
         m6yJ1TJKf4s0OOHIUvE3Uyx9/WXf8HjbDoj7FU0FET1Fk9lKIowbFUety3q3hjCD+trG
         PspIsmwUL7KHCnub37ol6kWQ2KCcU5L3KKVjxffV+Up2NplS1L7qPGI7uCr6kC/PW7Xq
         UXFVWTiKQnZBaT2xpQfSFUlLuhIqzE8yeFo9Lx/Fl4y8xCVH5hufKqPaDFKpXpWv+9yS
         g9kDTtEuQgzV0cHtVmisyEThgHqA3yXMY7rBBrmlrC10MZlh8xM/ST6H5hC4hMCcBFjs
         EklA==
X-Gm-Message-State: AOJu0YziM69VczsHoTfMveRf2NXwXWivuDs5+sO6AbZpeJj9ap2o7tNx
        NnOl2K0dZIvs8l8mDU3ewVLPVg==
X-Google-Smtp-Source: AGHT+IGFT98V4kV4nCaLPdXsK8MuhMdn2cVe7BDRU7gUksxtPIexqWAh7oIz7PnqVwrP0w9xUidE5A==
X-Received: by 2002:a2e:9d08:0:b0:2b9:b4eb:c39c with SMTP id t8-20020a2e9d08000000b002b9b4ebc39cmr17412442lji.8.1693215956521;
        Mon, 28 Aug 2023 02:45:56 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id h10-20020a2e900a000000b002ba130e9a29sm1682693ljg.76.2023.08.28.02.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 02:45:56 -0700 (PDT)
Message-ID: <76b29f8b-9106-4436-a816-926b016f667f@linaro.org>
Date:   Mon, 28 Aug 2023 11:45:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] irqchip/qcom-pdc: don't read version register if it
 is not available
Content-Language: en-US
To:     "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20230825213552.1646321-1-dmitry.baryshkov@linaro.org>
 <09d89b1c-8c78-7671-a385-99c6a8910fde@quicinc.com>
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
In-Reply-To: <09d89b1c-8c78-7671-a385-99c6a8910fde@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.08.2023 11:36, Maulik Shah (mkshah) wrote:
> Hi Dmitry,
> 
> This patch may be useful if there was a case where some PDCs don't have version register populated/available,
> In all PDC versions, version register is always available but due to reg size not good enough in device tree for SM8150 it failed to read.
> 
> reg size in device node must be expanded if its too small to access all registers and i think
> additional check in driver to check if size is good enough would not be of much use.
The devicetree change has already been commited and not taking care
of this on the driver side would break backwards compatibility with
devicetrees without this change.


Konrad
