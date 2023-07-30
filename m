Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE5C7686FA
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 20:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjG3SEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 14:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjG3SEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 14:04:08 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15888E6;
        Sun, 30 Jul 2023 11:04:07 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31783d02093so3432053f8f.0;
        Sun, 30 Jul 2023 11:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690740245; x=1691345045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J4VnC9JBLnkd1aV4ux2bXmINUF6Lk2/WGzIZSYRircM=;
        b=UXfxA8kJ8VCVYBN7w9R8NPc5VSpcaJp+PSQwHUAlYH/q8GjjSuZ9e8OYJcUcvehVub
         iDXY4w9OqfOYGwgs0hpPPvxNlluYKDmVZbvExXngRtDjtrIsxjyr/GXNL+kTx9l7b82a
         oYutzf/O+hCsQy6+mj4hSNI8WR09iDMrGx/GrmlyNguVZUgpj3/S7bC5EtWhauf0DMvu
         64d52Qp6WnF/M0KD2FZ996O0NXd/6fiuV+pS26QuzOh6FokvgJqaGQjN5E+yaH73xlvU
         EF3N4SMFJIvjQeWGI8sFwrM5IKk0njGEjX1ao319V4qPTjTCqP/Mu6dODMBqNc1i24H8
         LIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690740245; x=1691345045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J4VnC9JBLnkd1aV4ux2bXmINUF6Lk2/WGzIZSYRircM=;
        b=YVlrGrdL0cZNRLsYKiQEhsQkbW80UvjzNDxsrnmfVIFltasXzxuDFE8hYcwcMmc8K5
         GLpEaplsa3r8eMyzmg0CQZV7QsfpEsZEdjpkDfLN2QxqWUbOSWBO68G3wbn9QoxLJCN9
         RcAReaF+eXVfjWt8RzzyEyeEETzJpulM2HCjZCuoIaOAIXeQ7Kb+1Du1RFbqPA+flgLi
         15qZ1fzomN1R/yYXOY1tzb33Y3BJCLWSwmQ3Os8yEXlPGxTgu/wUL5SdAViHOi8xwCD4
         fBi7Y5vwKxX8+ynUq0c32bKOVkpvvBZ91ot83kypPbMndDEFKtB2h5upkZE3LC3PfMCC
         pWzw==
X-Gm-Message-State: ABy/qLaMahtr1ESO/TMvm5xDLBbkS1vMZyoGwhlYklBQK8gq9iVnivMM
        kniTjlZdNTCxbdUSZW8cqJM=
X-Google-Smtp-Source: APBJJlHvku2UGLRqOLv2AxG1MEGEfwg0zMJi9v2CHXstFzHPx2VzLSnQ85LtlWBysCehoOvD+JGqqg==
X-Received: by 2002:a5d:6611:0:b0:317:734e:3614 with SMTP id n17-20020a5d6611000000b00317734e3614mr6519540wru.39.1690740245327;
        Sun, 30 Jul 2023 11:04:05 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id s11-20020adfeb0b000000b003176a4394d7sm10667477wrn.24.2023.07.30.11.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 11:04:04 -0700 (PDT)
Message-ID: <afbb1f4f-b7f9-4b1e-fa0e-0fdf148d1130@gmail.com>
Date:   Sun, 30 Jul 2023 20:04:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] firmware: qcom_scm: Add support for Qualcomm
 Secure Execution Environment SCM interface
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230730161906.606163-1-luzmaximilian@gmail.com>
 <20230730161906.606163-3-luzmaximilian@gmail.com>
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20230730161906.606163-3-luzmaximilian@gmail.com>
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

On 7/30/23 18:19, Maximilian Luz wrote:

[...]

> diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
> index 250ea4efb7cb..dd4236cffbec 100644
> --- a/include/linux/firmware/qcom/qcom_scm.h
> +++ b/include/linux/firmware/qcom/qcom_scm.h
> @@ -122,4 +122,25 @@ extern int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
>   extern int qcom_scm_lmh_profile_change(u32 profile_id);
>   extern bool qcom_scm_lmh_dcvsh_available(void);
>   
> +#ifdef CONFIG_QCOM_QSEECOM
> +
> +int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id);
> +int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
> +			      size_t rsp_size);
> +
> +#else /* CONFIG_QCOM_QSEECOM */
> +
> +int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id)
> +{
> +	return -EINVAL;
> +}
> +
> +int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
> +			      size_t rsp_size)
> +{
> +	return -EINVAL;
> +}

As the kernel test robot rightfully complained: I forgot to static
inline both functions above. Already fixed for v6.

Regards
Max
