Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77AD777996
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbjHJN2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbjHJN2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:28:11 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1C8196
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 06:28:10 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe58faa5cfso1361944e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 06:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691674089; x=1692278889;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0rMBTd9PSe3rwX3ieHX+r33usF1/PKAmF1IGH8YWMF4=;
        b=ClnRBdflS0jBD+We/IvZYyBjXKVRXBmPKmmB8gOzUWsE6IpwMj75cqBM80WxFKXz1R
         rASleyX6u6n2tO2tgufcG2jIblbjjIr6+UAp2f437CO4oDdu65bdmr4oawZhohP+l+5k
         SzvglO4FzJyE6n9WEOMMPdiB135C74MMNcjCG0JqAKj+nbkQdCAsIHhS20ep4P4kl4R5
         hKIQO126Ozf/gj3dyixmTuoJVOs/M/PiW0pBR2qkvkZ9C7erTTa2Q/y/WC2hJvIOSjMx
         4lI2jgutS8dDrgtRw828UKKGNLwsaxByHQeHMOlBl1oh0RK9JDjzLo+6hnDXG/a+0TlM
         E8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691674089; x=1692278889;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0rMBTd9PSe3rwX3ieHX+r33usF1/PKAmF1IGH8YWMF4=;
        b=gBu5vSZPA2CgpMaA4xSyFQ/QhTbKqtuMT/OLeEMamKOBEGs+x4R/XFEIgIr+t/3W/G
         41gf0MavI0TnsDBk4ECk3kOP8pvJ/FhJdKAqwPyU+ucR+YW65R/2b42oBelv2gdCKnS9
         2W1rUPnQ3PMIczAnNr0k9QLTp9tVOamkhcfCnCMgq96XeQfN7fYM1rJFrx+GOqq+szoZ
         /aexUrKxd5UO5BmuM/DmifsVhGIWiDNUV32yiZUl0XCfgAfBdFdUS81ISU6LEvN8MRNG
         vISWFzQtnti1Mewh8x0aqXsNjcYpWf5lrZqnwAhK3TXZBhv1zWbHu/NQN8hFvbrNwKir
         Dq6g==
X-Gm-Message-State: AOJu0YzKk2oeTrEJ8rMZMuoD8ypevGH9SlD8WYNWXOnZpTmuOR1wZK5D
        ks+wAE22/TxanVZc18y8sTfpRQ==
X-Google-Smtp-Source: AGHT+IFo9WjiJajubGXckuI6bb8bjTQRG69K+zL0RmaeF6nfbWukq/YO7RpjAuDtXqeszPzJpICjyg==
X-Received: by 2002:ac2:4a62:0:b0:4fe:c98:789a with SMTP id q2-20020ac24a62000000b004fe0c98789amr1772592lfp.37.1691674088978;
        Thu, 10 Aug 2023 06:28:08 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id c27-20020ac244bb000000b004fb85ffc82csm286637lfm.10.2023.08.10.06.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 06:28:08 -0700 (PDT)
Message-ID: <a4ccb1ec-5444-49bc-a3a3-832e554daeb6@linaro.org>
Date:   Thu, 10 Aug 2023 15:28:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] interconnect: qcom: icc-rpm: Check for
 node-specific rate coefficients
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230726-topic-icc_coeff-v3-0-dee684d6cdd2@linaro.org>
 <20230726-topic-icc_coeff-v3-4-dee684d6cdd2@linaro.org>
 <ZNSRHVC8Ay5YSLQi@gerhold.net>
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
In-Reply-To: <ZNSRHVC8Ay5YSLQi@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.08.2023 09:26, Stephan Gerhold wrote:
> On Tue, Aug 08, 2023 at 01:43:35PM +0200, Konrad Dybcio wrote:
>> Some nodes may have different coefficients than the general values for
>> bus they're attached to. Check for that and use them if present. See
>> [1], [2] for reference.
>>
>> [1] https://github.com/sonyxperiadev/kernel/commit/7456d9779af9ad6bb9c7ee6f33d5c5a8d3648e24
>> [2] https://github.com/artem/android_kernel_sony_msm8996/commit/bf7a8985dcaf0eab5bc2562d2d6775e7e29c0f30
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/interconnect/qcom/icc-rpm.c | 14 ++++++++++----
>>  drivers/interconnect/qcom/icc-rpm.h |  5 +++++
>>  2 files changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>> index 1d3af4e9ead8..9c40314e03b5 100644
>> --- a/drivers/interconnect/qcom/icc-rpm.c
>> +++ b/drivers/interconnect/qcom/icc-rpm.c
>> @@ -300,14 +300,14 @@ static u64 qcom_icc_calc_rate(struct qcom_icc_provider *qp, struct qcom_icc_node
>>  	else
>>  		agg_avg_rate = qn->sum_avg[ctx];
>>  
>> -	if (qp->ab_coeff) {
>> -		agg_avg_rate = agg_avg_rate * qp->ab_coeff;
>> +	if (qn->ab_coeff) {
>> +		agg_avg_rate = agg_avg_rate * qn->ab_coeff;
>>  		agg_avg_rate = div_u64(agg_avg_rate, 100);
>>  	}
>>  
>> -	if (qp->ib_coeff) {
>> +	if (qn->ib_coeff) {
>>  		agg_peak_rate = qn->max_peak[ctx] * 100;
>> -		agg_peak_rate = div_u64(qn->max_peak[ctx], qp->ib_coeff);
>> +		agg_peak_rate = div_u64(qn->max_peak[ctx], qn->ib_coeff);
>>  	} else {
>>  		agg_peak_rate = qn->max_peak[ctx];
>>  	}
>> @@ -563,6 +563,12 @@ int qnoc_probe(struct platform_device *pdev)
>>  	for (i = 0; i < num_nodes; i++) {
>>  		size_t j;
>>  
>> +		if (!qnodes[i]->ab_coeff)
>> +			qnodes[i]->ab_coeff = qp->ab_coeff;
>> +
>> +		if (!qnodes[i]->ib_coeff)
>> +			qnodes[i]->ib_coeff = qp->ib_coeff;
>> +
>>  		node = icc_node_create(qnodes[i]->id);
>>  		if (IS_ERR(node)) {
>>  			ret = PTR_ERR(node);
>> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
>> index f9ef16f570be..4abf99ce2690 100644
>> --- a/drivers/interconnect/qcom/icc-rpm.h
>> +++ b/drivers/interconnect/qcom/icc-rpm.h
>> @@ -103,6 +103,9 @@ struct qcom_icc_qos {
>>   * @mas_rpm_id:	RPM id for devices that are bus masters
>>   * @slv_rpm_id:	RPM id for devices that are bus slaves
>>   * @qos: NoC QoS setting parameters
>> + * @ab_coeff: a percentage-based coefficient for compensating the AB calculations
>> + * @ib_coeff: an inverse-percentage-based coefficient for compensating the IB calculations
>> + * @bus_clk_rate: a pointer to an array containing bus clock rates in Hz
> 
> Nitpick: The doc comment needs to be moved to the earlier patch as well. :)
Gah :P

Konrad
