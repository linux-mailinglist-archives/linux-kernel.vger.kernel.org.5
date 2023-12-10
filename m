Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77F280B84D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 02:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjLJBSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 20:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLJBSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 20:18:31 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD86D0;
        Sat,  9 Dec 2023 17:18:37 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3332e351670so3169978f8f.0;
        Sat, 09 Dec 2023 17:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702171116; x=1702775916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OSqJ3Gq1m5O067Yev9/OhXEqr6xxNOyvhwu0WzwCQqM=;
        b=OdBxe7ylAJGaQPnQB2Y92RuHLAXnc+aAeYX4FOmIHvOrNyG8PNVnGqV8R7yNVZQtfB
         uolsb+OQpFJ+BeJk3SCBXSuqvqZ7hpIS6bAKiBfs6Pc8p2cCJ2IluGioYchsIBsVkm5V
         WA+AhaQXjXUQMxNc0GpJKPvLpQ/YfU/O9AGQ59Zjt80Fqjm1gTr9ClonQR56rXrnyJrU
         bgUFEgSXaz3pG5fkeFR4l4l3UHma71zrhpG3eQlHOmu63BR851//bJMddgRsty8klcf5
         /6fneuE3vBAzYPjhdL6z5OOFFFEaNcbh70FgURPS5t0WpYeWhChJng+7ioy1YVHekv2O
         ELNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702171116; x=1702775916;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSqJ3Gq1m5O067Yev9/OhXEqr6xxNOyvhwu0WzwCQqM=;
        b=lot2+BMaZ0Y7zfkM3j0lc300tg4IY7JcmIUoxyon0UeBolJzIv/8BJrM8cW3zPXjq3
         eJRFI9unOA+FQTsWzvebBtbX5mjJOFeb5en2Mq/qVIgg5kr3K+tIFhE+b7YaHqU0io3h
         R3Hnl3VB03AxtnPO4YRhsiimkK53svk7azeR8u08k7dYhGums6zAM9yIYkSfBff7DhkQ
         XJVPCaXUi2PpqnM2cUVISE+NVbJwLfbLerdG6/YIBdF1Q9wn1e1SSPpLOGtAsnWTHV2Q
         HSE2ORby1xotD049LF4hIAaIDIcqrVQgp+kPGPAi/VRubfvrfR3Mc6wbI11gQRqfkWGj
         boMw==
X-Gm-Message-State: AOJu0YyU2zvLxbJfQRKSA7Ji41EOP54uG8MtJbiKew3u1DFTg5nT9ZAl
        NSwjrJSIxMrJk3/JhZVxiJYykn5DoRM=
X-Google-Smtp-Source: AGHT+IEBEg+/hyyuNVUclgs1+x3sTO6RBlnRuYIq+IYOYB62kMo2yWcnmanqfWJcnvBzv4DfWnvXLA==
X-Received: by 2002:adf:f882:0:b0:333:3117:c453 with SMTP id u2-20020adff882000000b003333117c453mr666048wrp.228.1702171115790;
        Sat, 09 Dec 2023 17:18:35 -0800 (PST)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id a9-20020a5d5709000000b003332aa97101sm5322013wrv.38.2023.12.09.17.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 17:18:35 -0800 (PST)
Message-ID: <b9e70eae-dad5-4775-8def-596344cf3c8b@gmail.com>
Date:   Sun, 10 Dec 2023 02:18:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/13] firmware: qcom: qseecom: fix memory leaks in
 error paths
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
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
References: <20231127141600.20929-1-brgl@bgdev.pl>
 <20231127141600.20929-2-brgl@bgdev.pl>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20231127141600.20929-2-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/23 15:15, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Fix instances of returning error codes directly instead of jumping to
> the relevant labels where memory allocated for the SCM calls would be
> freed.
> 
> Fixes: 759e7a2b62eb ("firmware: Add support for Qualcomm UEFI Secure Application")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202311270828.k4HGcjiL-lkp@intel.com/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Thanks!

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   .../firmware/qcom/qcom_qseecom_uefisecapp.c   | 20 ++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
> index a33acdaf7b78..32188f098ef3 100644
> --- a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
> +++ b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
> @@ -325,8 +325,10 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
>   	req_data->length = req_size;
>   
>   	status = ucs2_strscpy(((void *)req_data) + req_data->name_offset, name, name_length);
> -	if (status < 0)
> -		return EFI_INVALID_PARAMETER;
> +	if (status < 0) {
> +		efi_status = EFI_INVALID_PARAMETER;
> +		goto out_free;
> +	}
>   
>   	memcpy(((void *)req_data) + req_data->guid_offset, guid, req_data->guid_size);
>   
> @@ -471,8 +473,10 @@ static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const e
>   	req_data->length = req_size;
>   
>   	status = ucs2_strscpy(((void *)req_data) + req_data->name_offset, name, name_length);
> -	if (status < 0)
> -		return EFI_INVALID_PARAMETER;
> +	if (status < 0) {
> +		efi_status = EFI_INVALID_PARAMETER;
> +		goto out_free;
> +	}
>   
>   	memcpy(((void *)req_data) + req_data->guid_offset, guid, req_data->guid_size);
>   
> @@ -563,8 +567,10 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
>   	memcpy(((void *)req_data) + req_data->guid_offset, guid, req_data->guid_size);
>   	status = ucs2_strscpy(((void *)req_data) + req_data->name_offset, name,
>   			      *name_size / sizeof(*name));
> -	if (status < 0)
> -		return EFI_INVALID_PARAMETER;
> +	if (status < 0) {
> +		efi_status = EFI_INVALID_PARAMETER;
> +		goto out_free;
> +	}
>   
>   	status = qcom_qseecom_app_send(qcuefi->client, req_data, req_size, rsp_data, rsp_size);
>   	if (status) {
> @@ -635,7 +641,7 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
>   		 * have already been validated above, causing this function to
>   		 * bail with EFI_BUFFER_TOO_SMALL.
>   		 */
> -		return EFI_DEVICE_ERROR;
> +		efi_status = EFI_DEVICE_ERROR;
>   	}
>   
>   out_free:
