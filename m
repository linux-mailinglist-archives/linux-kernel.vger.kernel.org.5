Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33897C5E09
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjJKUJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjJKUJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:09:16 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF4494;
        Wed, 11 Oct 2023 13:09:13 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40651a72807so3208795e9.1;
        Wed, 11 Oct 2023 13:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697054951; x=1697659751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fwMSS1JcFEDXpZyiEnSO8zQlyidEp0jlGR2nVT4Z3G4=;
        b=EOAPy+LmMySnjmRtcRZtBIXcPX6yU7S1nxviLZrIcuR82GL1ZChE0p9ip0mZ3ifHbQ
         U8BSlE4QFQtQEFf6fjFG/vuvhQjD3bhbbFOyEa4V9MRR/G5acq0fCAm3l9giFWCctdO8
         46Ibslf/TQ7Y3cup1I/ElXLeJZIfMvYyLJUwFhyr7Es/c4TTbWmNWVKld5oPA36MuglA
         LyRWXCGJcA0O7hTym9USHX9be3YYqzdNRLmFiD3BS5Z8J5hMAQkS5iD/FCd2RsTWaWzx
         WzdUQKzzcWBiba3ILzpCr7H1dp9g4yHotsVUZFdZtuvvaqkNwlilPpsGiwVErfiSINGx
         sWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697054951; x=1697659751;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fwMSS1JcFEDXpZyiEnSO8zQlyidEp0jlGR2nVT4Z3G4=;
        b=SO5NAnSapBrnQ788BqygoeafeZznOpngHMrMm+C55ZjUlPXQYREhkdOcTFZmn18WeM
         EqZzg4Xiyo0ixT1wJK2CmVXbpmRYZ0dcvvOd6mZoOcWhiELlrb6eQ3BAWRHVI8HSZ4UG
         /MVheSIEQeYhZ0545d8687ZOi20QSxgSNLasMRhPWGrZczYosWCi/8aCup7ZKw5cNa3K
         aPhCIrM2aBp892OJ+Ems5Y2TQugDvStNsYIFy48Z2Nq1ZjSsURQwB1AEmLL36En/mBLS
         a4e9QcGTm3imAxgJ+PivE3ql7k1R4NrHUqytwhvp7FtNaIRqmn3RkiOBVs+oqgH7whLQ
         e2FQ==
X-Gm-Message-State: AOJu0YzBcdcjMbAJVPfXi93Js+wH9y0wavew17vYXZwCWht66ulkR4Rt
        h/KyN0Unz43zhXY8pNW+GHI=
X-Google-Smtp-Source: AGHT+IEva7HvAg6ZLZr8d9XAqhBhRtyp1e9dGG3r81TKlDeAiiMwyzrF9woYU5uAeGS4EgS67jD8bQ==
X-Received: by 2002:a1c:720a:0:b0:401:b6f6:d90c with SMTP id n10-20020a1c720a000000b00401b6f6d90cmr20364429wmc.35.1697054950809;
        Wed, 11 Oct 2023 13:09:10 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id bd5-20020a05600c1f0500b004030e8ff964sm20163058wmb.34.2023.10.11.13.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 13:09:10 -0700 (PDT)
Message-ID: <765d393c-4cfe-4f61-a7b4-7fef8c6bf70f@gmail.com>
Date:   Wed, 11 Oct 2023 22:09:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] firmware: qcom: scm: make
 qcom_scm_qseecom_app_get_id() use the TZ allocator
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20231009153427.20951-1-brgl@bgdev.pl>
 <20231009153427.20951-11-brgl@bgdev.pl>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20231009153427.20951-11-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 17:34, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Let's use the new TZ memory allocator to obtain a buffer for this call
> instead of manually kmalloc()ing it and then mapping to physical space.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Tested-by: Maximilian Luz <luzmaximilian@gmail.com>

I've tested the whole series with both QCOM_TZMEM_MODE_DEFAULT and
QCOM_TZMEM_MODE_SHMBRIDGE. Everything seems to work fine on my Surface
Pro X (sc8180x), but I've only really tested the qseecom-related parts
(hence my TB only for those).

I'll try to do a proper review of the two qseecom patches in the next
couple of days.

> ---
>   drivers/firmware/qcom/qcom_scm.c | 18 ++++--------------
>   1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 11638daa2fe5..3a6cefb4eb2e 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1525,37 +1525,27 @@ int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id)
>   	unsigned long app_name_len = strlen(app_name);
>   	struct qcom_scm_desc desc = {};
>   	struct qcom_scm_qseecom_resp res = {};
> -	dma_addr_t name_buf_phys;
> -	char *name_buf;
>   	int status;
>   
>   	if (app_name_len >= name_buf_size)
>   		return -EINVAL;
>   
> -	name_buf = kzalloc(name_buf_size, GFP_KERNEL);
> +	char *name_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
> +							     name_buf_size,
> +							     GFP_KERNEL);
>   	if (!name_buf)
>   		return -ENOMEM;
>   
>   	memcpy(name_buf, app_name, app_name_len);
>   
> -	name_buf_phys = dma_map_single(__scm->dev, name_buf, name_buf_size, DMA_TO_DEVICE);
> -	status = dma_mapping_error(__scm->dev, name_buf_phys);
> -	if (status) {
> -		kfree(name_buf);
> -		dev_err(__scm->dev, "qseecom: failed to map dma address\n");
> -		return status;
> -	}
> -
>   	desc.owner = QSEECOM_TZ_OWNER_QSEE_OS;
>   	desc.svc = QSEECOM_TZ_SVC_APP_MGR;
>   	desc.cmd = QSEECOM_TZ_CMD_APP_LOOKUP;
>   	desc.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_RW, QCOM_SCM_VAL);
> -	desc.args[0] = name_buf_phys;
> +	desc.args[0] = qcom_tzmem_to_phys(name_buf);
>   	desc.args[1] = app_name_len;
>   
>   	status = qcom_scm_qseecom_call(&desc, &res);
> -	dma_unmap_single(__scm->dev, name_buf_phys, name_buf_size, DMA_TO_DEVICE);
> -	kfree(name_buf);
>   
>   	if (status)
>   		return status;
