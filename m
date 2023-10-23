Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E92C7D3553
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbjJWLrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbjJWLrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:47:04 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A03710EC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:46:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32d849cc152so2565292f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698061617; x=1698666417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/aQyZPVzLxsI9C8y7ikgMEjlP5ljwGXoP1pnDJZm8wU=;
        b=HAAkLz4xwioukr6+tgVgn1LsG8F3t4W85R+Y/hFxbOSlDMUqmQQhMuVLTxJpDaqqhA
         sb5A4oI9PZQaSRSrxn4yAKkoJPeRMMozE6wH5U7qFfhv9pLFuHvKwqXoPhWOm7ugrLWS
         tNxS/pI3JMHgRCi1ehtyi1FIPSYGebZ3qthRM5drVXxMUZb/m1yWO1x94XSp5VSQqVdb
         1Fa5On4+oSE87AqISmFRFw9ifRpg+oB53akGZnSTqJOp2X2AIaD6GhD26ATYWtMdv6AL
         X43nV4VpP5nMniFwOLRm5VtV461x7C7YZxWdghunbsBRMlhZda8ZHz9U9iSV0t3FvqEi
         Pvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698061617; x=1698666417;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/aQyZPVzLxsI9C8y7ikgMEjlP5ljwGXoP1pnDJZm8wU=;
        b=TrVaN3e2Z4E8msF5flsPXMZBa5TPtsTF5Ef8OOeKqI4sH1s/S45ljFLNxfoKCBsF8w
         X94xxn3bh1ZiKFCyUq5/IVdcn0p4+qHqfKGt0ZkwvB4oRmeM2REJCNDV10fkysXaTw4A
         gUewAJFXx4oZ23YI/INzpv6vdU874PcFa035XYbfzrNbKmxvZFH+FV0ozKI2EkFrmzQl
         cwR+J813Eg9WpTpjF0UJ2IeIBodom3GS1IpEJjTD7+AidPOovdu2nWy4AtliKCEpdYmq
         hB/n0GaGtRzXy9tRkhIqqv6+ZehptcIp2j8Yc+y61flraMImNqPbe2rwKYULz1yyadiV
         nj9Q==
X-Gm-Message-State: AOJu0YzwGTgBYwPskGBY909fFXqBGdKi8t0hoOYKTDKMEZw+nrSHCwBx
        v4CbTdkckWSrDAR6x92vMiAyQA==
X-Google-Smtp-Source: AGHT+IFIBHuuBtLHDzJzg5LyNP4jp+H9d1fvC/QSxlNc1x81e0w8+9iEpYnaRg771nWBpgxf0Qwhjg==
X-Received: by 2002:a05:6000:1f07:b0:32c:837e:ef0 with SMTP id bv7-20020a0560001f0700b0032c837e0ef0mr8266917wrb.50.1698061617436;
        Mon, 23 Oct 2023 04:46:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id k12-20020a5d518c000000b0031f82743e25sm7579996wrv.67.2023.10.23.04.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 04:46:56 -0700 (PDT)
Message-ID: <454c4267-6bb7-456e-8dc1-cba83ffd1641@linaro.org>
Date:   Mon, 23 Oct 2023 13:46:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] soc: qcom: memory_dump: Add memory dump driver
Content-Language: en-US
To:     Zhenhua Huang <quic_zhenhuah@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        quic_tingweiz@quicinc.com
References: <1698052857-6918-1-git-send-email-quic_zhenhuah@quicinc.com>
 <1698052857-6918-4-git-send-email-quic_zhenhuah@quicinc.com>
 <5bac8188-7d27-4efe-9493-dec4393fbeb0@linaro.org>
 <b455d4f7-0347-ac07-6d41-32b3f06c4f0a@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <b455d4f7-0347-ac07-6d41-32b3f06c4f0a@quicinc.com>
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

On 23/10/2023 13:43, Zhenhua Huang wrote:
>>> +
>>> +			mem_dump_apply_offset(&dump_vaddr, &phys_addr,
>>> +					      size + QCOM_DUMP_DATA_SIZE);
>>> +			if (phys_addr > phys_end_addr) {
>>> +				dev_err_probe(dev, -ENOMEM, "Exceeding allocated region\n");
>>
>> ENOMEM? Does not look right then.
> 
> ENOMEM means the memory allocated not enough? any suggestion? Thanks.

The error code is okay, but we rarely need to print error messages for
memory allocation failures. Core prints it already.

> 
>>
>>> +				return -ENOMEM;
>>> +			}
>>> +		} else {
>>> +			continue;
>>> +		}
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int __init mem_dump_probe(struct platform_device *pdev)
>>> +{
>>> +	struct qcom_memory_dump *memdump;
>>> +	struct device *dev = &pdev->dev;
>>> +	struct page *page;
>>> +	size_t total_size;
>>> +	int ret = 0;
>>> +
>>> +	memdump = devm_kzalloc(dev, sizeof(struct qcom_memory_dump),
>>> +			       GFP_KERNEL);
>>> +	if (!memdump)
>>> +		return -ENOMEM;
>>> +
>>> +	dev_set_drvdata(dev, memdump);
>>> +
>>> +	/* check and initiate CMA region */
>>> +	ret = mem_dump_reserve_mem(dev);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/* allocate and populate */
>>> +	page = mem_dump_alloc_mem(dev, &total_size);
>>> +	if (IS_ERR(page)) {
>>> +		ret = PTR_ERR(page);
>>> +		dev_err_probe(dev, ret, "mem dump alloc failed\n");
>>
>> No, the syntax is:
>> ret = dev_err_probe
>>
>> But why do you print messgaes for memory allocations?
> 
> Do you think it's useless because mm codes should print error as well if 
> failure ?

We fixed this in kernel long, long, long time ago so we have even
coccicheck scripts to find misuses.



Best regards,
Krzysztof

