Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D8079978F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 13:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344873AbjIILFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 07:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344843AbjIILFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 07:05:04 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC07CE40
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 04:04:57 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50078e52537so4856841e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 04:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694257496; x=1694862296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1XUxNwo0jgK1hqYvQ/OBgnXp62Vg7lM+YHP+s8+7VI8=;
        b=hcoQ/ZccTWwacp/tp4GaHs9wwFhCNF1y9967vcPDmVAI2H5zMSQcCqhhTKYOS+l949
         2GTZdiH36g7D5F2sGYap/h+5bBrkrRZZuNoSLSDr7NHfwpk3flg883Vwh4OxD/zUwYJk
         W0/y5FUd0sMArVKb34KJs4RN1l+uH9iotOiCFYvcQE9htjjcVRvi1JlT3lFy/AuYS8o3
         P2Nblc7UboBOOmqHcKs64YDu0dbkHQpUmGh/yME3WjYWTfz/OOiDk+rDB0BU91RGU287
         u5S1q5APIx5vALpYwQUYZiFfo4UY0jWL4eA8LXrL/FvDB64K8oTqM3AEnO8g+eNFsMxl
         gWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694257496; x=1694862296;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1XUxNwo0jgK1hqYvQ/OBgnXp62Vg7lM+YHP+s8+7VI8=;
        b=r4jP6gNucRghUMhWxPqk92SMOz3WYXucppaMCUnUTYS+0INBdjzDwIvmiBtc+F0RRy
         bYlBpUTPkYluctxJrkeF1y1oD88mjw174iNkEcdWvADFQyneaKaLKeiL2u73EeTV5QEu
         dvb3Ot5rgCEQn5UTOPkqWmtI75QqiLjv0nqa0SKoIgqF/gH007VCprAWXqjCkGlxzsrA
         rxv9rjIofBoQgjpUfftmG+dc7kDqD+GyM71OxQo3HMhq6duZqYn1QhakXLVJSYWqwiWK
         p9byV5b0/VM2FmLJcTCZ6R4tl+o68vNZ1CO4IyFOY6geDPaKCOCN8R/5ew/83rYlns6Q
         3BKw==
X-Gm-Message-State: AOJu0YxCdPQspsdepTtd3wBoMGDgto9A9cFZMFocH3toW3SXMxZkfGDE
        vi05UfULbTsgwMoPJ5SAfKcClA==
X-Google-Smtp-Source: AGHT+IElvzkHK7O75wRqtSaZ+3vi5iwX2B4KJcq4CGw/JKy94J6nuTMOmN7FG9+8KVOQ9x+pCxFMAw==
X-Received: by 2002:a2e:b015:0:b0:2bc:bf29:18d3 with SMTP id y21-20020a2eb015000000b002bcbf2918d3mr3548096ljk.31.1694257495993;
        Sat, 09 Sep 2023 04:04:55 -0700 (PDT)
Received: from [192.168.37.232] (178235177205.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.205])
        by smtp.gmail.com with ESMTPSA id jj27-20020a170907985b00b009929d998abcsm2177208ejc.209.2023.09.09.04.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 04:04:55 -0700 (PDT)
Message-ID: <5722031e-96ab-48f6-9848-086be17fe5bf@linaro.org>
Date:   Sat, 9 Sep 2023 13:04:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scsi: ufs: ufs-qcom: Update PHY settings only when
 scaling to higher gears
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     bvanassche@acm.org, avri.altman@wdc.com, alim.akhtar@samsung.com,
        andersson@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_nitirawa@quicinc.com,
        stable@vger.kernel.org
References: <20230908145329.154024-1-manivannan.sadhasivam@linaro.org>
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
In-Reply-To: <20230908145329.154024-1-manivannan.sadhasivam@linaro.org>
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

On 8.09.2023 16:53, Manivannan Sadhasivam wrote:
> The "hs_gear" variable is used to program the PHY settings (submode) during
> ufs_qcom_power_up_sequence(). Currently, it is being updated every time the
> agreed gear changes. Due to this, if the gear got downscaled before suspend
> (runtime/system), then while resuming, the PHY settings for the lower gear
> will be applied first and later when scaling to max gear with REINIT, the
> PHY settings for the max gear will be applied.
> 
> This adds a latency while resuming and also really not needed as the PHY
> gear settings are backwards compatible i.e., we can continue using the PHY
> settings for max gear with lower gear speed.
> 
> So let's update the "hs_gear" variable _only_ when the agreed gear is
> greater than the current one. This guarantees that the PHY settings will be
> changed only during probe time and fatal error condition.
> 
> Due to this, UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH can now be skipped
> when the PM operation is in progress.
> 
> Cc: stable@vger.kernel.org
> Fixes: 96a7141da332 ("scsi: ufs: core: Add support for reinitializing the UFS device")
> Reported-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
Would that not increase power consumption?

I'd presume that the PHY needs to work harder at higher gear
settings to preserve signal integrity with more data flow.

And if so, would that power consumption increase be measurable?
Or is it so small that it doesn't matter?

Konrad
