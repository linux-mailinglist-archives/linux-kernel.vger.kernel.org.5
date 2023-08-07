Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A3B7724A2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjHGMq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjHGMqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:46:23 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DEB1FEF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:46:00 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe0fe622c3so6999143e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 05:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691412355; x=1692017155;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BM1kbz2sor4nBFnh9WswI/g45TnNXDre/AlWkm0RfbQ=;
        b=uq30S6T9nAcl4QiN7iOhvdbLiZw77kkr1JRRhfr0W6ShfnXXM5ig2wbNADpcXqk+Rg
         nXxriE8EAa8JIe4QV0j2eEeEAsdNWzWcpn6wQYuAUMFGtJTjoo6Oj/pjkKgkfpeNYe6m
         TMS1LBhiauERgvHsD2+aL7eUCkBXxBqXX+Aikay+eamSCHGHwuC6USN0JNigr56wkM4Z
         f06EgIBfT5XnFEOOpMOjefFzgTXlQWFR9PrN+snpkKL3qTEclHnp7MQogVn9eFbpiFgr
         Co+igq6se4B6h/BM+d0dowORfaa/NxsPl+OLlY4ggKqTVN8r1v1Ln4NvFIrvnqKgux0H
         LaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691412355; x=1692017155;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BM1kbz2sor4nBFnh9WswI/g45TnNXDre/AlWkm0RfbQ=;
        b=bt/sh707I/hxlUsNAk4zcnOMwrmRtsE0gLidrblKCy3KtK3QlZt/BitSr75KdFMCkk
         eLM/Rk/Q6YnlUroxvWfVSlvDUmtg6wWlysAq99ukTupF4me/m6q/WCctQA7/1yuCW1zy
         mwg8bIb/q2EMylDGxDWcmeY51hkGC+RaTAltjRNj9Q78uPVbsMnvvriMow7fZIihiRXv
         NMjBW4X42IzhQJ1wOJ4+M5Ho5P6dgIVHOS6DEVIuudsp78ou57a14sJm/9i3OhAlPDFz
         8LNb/Dydqd0wWvdaCBroDngK+9x76iv/GAcWb5AzFkQHHcz7+81Qy1EX8qpG2yKeUYZ2
         LJTQ==
X-Gm-Message-State: AOJu0YzvHferNyQT6wAqM9g2/sl/PmDlVKN2AykLW7VDr5xGEY6rb5rN
        fAKb7mShdaYQVhfY4e8hALrSmA==
X-Google-Smtp-Source: AGHT+IErCLFJX26zK+vEYznMVLBrXzWNAXrAwI3vp1xDFz3J3Oft8RD/9dMuMHa1JBJ9o58sWbEM8g==
X-Received: by 2002:a19:5007:0:b0:4fe:85c:aeba with SMTP id e7-20020a195007000000b004fe085caebamr5800744lfb.21.1691412355163;
        Mon, 07 Aug 2023 05:45:55 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id l17-20020ac24a91000000b004f85d80ca64sm1490547lfp.221.2023.08.07.05.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 05:45:54 -0700 (PDT)
Message-ID: <c4006b16-2c06-4c96-86a1-d4ba235503f4@linaro.org>
Date:   Mon, 7 Aug 2023 14:45:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] Add pmics supported in Qualcomm's SDX75 platform
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, abel.vesa@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        quic_pkondeti@quicinc.com
References: <1691411333-1556-1-git-send-email-quic_rohiagar@quicinc.com>
 <83dff121-0a0f-4bd5-bf84-0c7c83f98615@linaro.org>
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
In-Reply-To: <83dff121-0a0f-4bd5-bf84-0c7c83f98615@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.08.2023 14:45, Konrad Dybcio wrote:
> On 7.08.2023 14:28, Rohit Agarwal wrote:
>> Hi,
>>
>> Changes in v2:
>>  - Added compatible for pm7550ba for eusb2 repeater and used it in DT.
>>  - Addressed some minor comments from Konrad to add fixes tag, labels
>>    and update the labels
>>
>> This series add support of pmics that are found in SDX75 platform and
>> add the corresponding regulators in the IDP platform as well.
>> It also parallely updates the pmic found in SDX65 to PM7250b and add pinctrl
>> support for the same pmic chip.
>> This series is based on the new header inclusion[1] and movement of the
>> regulators level from rpmpd to rpmhpd[2].
>> This series can be picked after successfully picking [2] and [3] as [1] has
>> already been applied.
>>
>> [1] https://lore.kernel.org/all/1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com/
>> [2] https://lore.kernel.org/all/1690781104-2290-1-git-send-email-quic_rohiagar@quicinc.com/
>> [3] https://lore.kernel.org/all/1690461813-22564-1-git-send-email-quic_rohiagar@quicinc.com/
>>
>> Thanks,
>> Rohit.
> Since you resent this (as mentioned in the first thread with "v2" [1]),
> the subject should be [PATCH RESEND ...]
> 
[1] https://lore.kernel.org/linux-arm-msm/f29eae07-b6c4-e7ea-3790-ee800d83859e@quicinc.com/T/#m863acf47848ba75987fcf144c588da21306dc2fe

Konrad
