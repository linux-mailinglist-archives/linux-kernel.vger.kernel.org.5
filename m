Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE1D75492B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 16:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjGOOJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 10:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjGOOJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:09:29 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89632173B
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:09:27 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fbbfaacfc1so4794716e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689430166; x=1692022166;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8c3FhnuVAoIEh1m/v2PXe+Qopk1wo7RCnRNOxCosjiA=;
        b=SRyWifLQM8lGnNcJibPnls0Br53MotLEf9T+ors4EYaCedUkvFowDxfLjrqGoq7rNP
         UR/mqktHZ6YqO7DOTp6M2QQ6ZB3FGGAnJEeQj07kKPDXtvzhjLfvuBbeZjf+/dfINfEr
         skRcMhj+DFAaBV0gmEkUCGmkAh/qoPAZ30tHHiWrE+kAvqWRCnaKwp0hW4SH5P5zLiCH
         +RgnHAHY/yW3SGNbJTBUYU4vxZAuZUzGkpA6Yhn9nDJhnjwKt/sS1DhsZ/BIb0pns8CT
         DeTYmoIJvVjSP3+x0aSHFMlhYYMuZuQ4W4TMm3P0CgbiqeJ8pTcC0FJt0BCDZbozgytg
         oS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689430166; x=1692022166;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8c3FhnuVAoIEh1m/v2PXe+Qopk1wo7RCnRNOxCosjiA=;
        b=HXYfjukVtXzgvWuz7bBDNYvSCwYEXr1YYy7pxzWSe0GXeM6Qk8yGsxiyCbqKJXduV+
         ATHrrw4ch5haTYbNaRcHJSO25B5H+N/T0CXCshclAJUXVbAxOQz4reeoIl2fQSrYPACP
         +nQ2w62CeySscm/vfFZ9BvLrU3H5KWnYHdCEWDcG16JHrnDzcy4uXRfdsbNHpimkEOqJ
         XjmMZPJdCVCS7FtkmNNXJkRUUx+S02N2y80yyiFmhGA7zv/O3tWketxgYdYwnT881oVZ
         WjuX7F5xEZFIY8sZ8pdthBxt1Z2lzJcXtkjOnmUzUtpaseevM1l+1PESSuopJ+fqBdsS
         ygfA==
X-Gm-Message-State: ABy/qLag2KVOKfjoEHaB3DE+joIA06Y0TYSXvP5B/JgadmT2HfUzM3RW
        ZMqn3jg/ePVhytHL59IsmMvtZg==
X-Google-Smtp-Source: APBJJlGcsAZyewJWfNEYRjgpNsHGvO4EKx1LiJHueR7XkU5QBkJwd4Im2k/Wbqo7Co0s03P6JQzVOQ==
X-Received: by 2002:ac2:58ed:0:b0:4f8:7568:e94b with SMTP id v13-20020ac258ed000000b004f87568e94bmr4872550lfo.56.1689430165843;
        Sat, 15 Jul 2023 07:09:25 -0700 (PDT)
Received: from [192.168.1.101] (abxi167.neoplus.adsl.tpnet.pl. [83.9.2.167])
        by smtp.gmail.com with ESMTPSA id g24-20020a19ee18000000b004fba0a9abf1sm1885495lfb.190.2023.07.15.07.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 07:09:25 -0700 (PDT)
Message-ID: <0cf2a0f4-7f5d-78d5-0004-57c446adc883@linaro.org>
Date:   Sat, 15 Jul 2023 16:09:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V1] scsi: ufs: ufs-qcom: Update UFS devfreq Parameters
Content-Language: en-US
To:     Nitin Rawat <quic_nitirawa@quicinc.com>, mani@kernel.org,
        quic_cang@quicinc.com, stanley.chu@mediatek.com,
        bvanassche@acm.org, quic_asutoshd@quicinc.com, avri.altman@wdc.com,
        martin.petersen@oracle.com, beanhuo@micron.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, andersson@kernel.org, jejb@linux.ibm.com,
        linux-arm-msm@vger.kernel.org, quic_ziqichen@quicinc.com
References: <20230711104006.15872-1-quic_nitirawa@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230711104006.15872-1-quic_nitirawa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.07.2023 12:40, Nitin Rawat wrote:
> To support the periodic polling mode without stop
> caused by CPU idle state, enable delayed timer
> as default instead of deferrable timer for
> qualcomm platforms.
> And change UFS devfreq downdifferential threshold to 65
> for less aggresive downscaling.
Please wrap your commit messages at around 70 characters, 50
makes it very hard to read.

Konrad
> 
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
> ---
>  drivers/ufs/host/ufs-qcom.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 82d02e7f3b4f..a15815c951ca 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1388,8 +1388,9 @@ static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
>  					struct devfreq_simple_ondemand_data *d)
>  {
>  	p->polling_ms = 60;
> +	p->timer = DEVFREQ_TIMER_DELAYED;
>  	d->upthreshold = 70;
> -	d->downdifferential = 5;
> +	d->downdifferential = 65;
>  }
>  #else
>  static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
> --
> 2.17.1
> 
