Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FDC75F662
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 14:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjGXMb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 08:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjGXMbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:31:20 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F78E74
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 05:31:18 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so11101752a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 05:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690201877; x=1690806677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/UW5QG5EK8EFq9Kf9r3pRK64G0FJddSL3ap9VTpE+yM=;
        b=NjyBNzn2JvnSbPJ4WJpFzGjKjs0qCPoaEzSaS7SB3P++lH4FGNylZcfl1YhnJIfNnz
         +3yFjDcovv38bjI7MDj8g+a4bxnWQTv5KQuIc0MEP8FNPf5yChr5p/E3JSl+EVn02BfV
         CH02cmkaLcWzPGILhn6zYpIuQ3yzVcQwvgX8UTSzgOVhjoEMqf1xrmT5SZG0oNzCcTLW
         jWmD1R6STVN2reTymIbKGAvMSZf10Na+4kS+yrjSnAYECFTT6+NKct15E8ryT9H/wNnc
         Gpn8aO6F/yBQWDpKuBusKwkPhWsED2k0cWj137ehpemOWeTs7I+fUwcwQzNDXXYpoIfe
         0xWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690201877; x=1690806677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UW5QG5EK8EFq9Kf9r3pRK64G0FJddSL3ap9VTpE+yM=;
        b=ZDU80BhZrzJRwF/BQ+iiK9idheKEce3tNngPBszoxLGCE95BZg6NxK7Xm8EIm0Sw4S
         Pd54WhbFgWrQGO6QRX/Q2CWHY6BB38m8O/oLKRjybCUZHwk1PQ6Bnv/FdbKkuoxCSLTl
         zfZQEYt4rSA9jaj5HWtem+Dnr7SzdWxbb6eHCtnmzmxetEjn///wQdAysXOuhb5CmA+T
         on+g9gu44DYI+3J9bLnlSBXkbHY2x3hbDZIw0XlMbJrLeyIF3JUeRKBbYu83pxu9CLpW
         thkWz/c1MBfSVv3yK6PDV5BXbjgHWB1bYCwVz0d16kIfRmqmEcUYvcsinSIIHQt3pOak
         foWg==
X-Gm-Message-State: ABy/qLYbz28S8sZGCax/35Cd+VX0tdltXMQiyeaFKjUFoWCpyLrACcG2
        RZuJWXdpl32/SMMaFfvAsBQLaw==
X-Google-Smtp-Source: APBJJlG5b9k5cgyD+0ffu2Qj73f/dLmguMMYab/SdI8PD/EX62Idamj2Ews2ZFPj3mY1PyoEmm2Q7w==
X-Received: by 2002:a05:6402:3492:b0:521:ab08:46dc with SMTP id v18-20020a056402349200b00521ab0846dcmr17628048edc.0.1690201877137;
        Mon, 24 Jul 2023 05:31:17 -0700 (PDT)
Received: from linaro.org ([82.78.74.213])
        by smtp.gmail.com with ESMTPSA id y19-20020aa7ccd3000000b0051df54c6a27sm6119079edt.56.2023.07.24.05.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 05:31:16 -0700 (PDT)
Date:   Mon, 24 Jul 2023 15:31:15 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ziqi Chen <quic_ziqichen@quicinc.com>,
        Can Guo <quic_cang@quicinc.com>, Arnd Bergmann <arnd@arndb.de>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: qcom: remove unused variable
Message-ID: <ZL5vExzF6vOP2G6E@linaro.org>
References: <20230724122029.1430482-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724122029.1430482-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-24 14:19:58, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A recent change removed the only user of a local variable that needs
> to now also be removed:
> 
> drivers/ufs/host/ufs-qcom.c: In function 'ufs_qcom_mcq_esi_handler':
> drivers/ufs/host/ufs-qcom.c:1652:31: error: unused variable 'host' [-Werror=unused-variable]
> 
> Fixes: 8f2b78652d055 ("scsi: ufs: qcom: Get queue ID from MSI index in ESI handler")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/ufs/host/ufs-qcom.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 3ee5ff905f9a6..5728e94b6527b 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1649,7 +1649,6 @@ static irqreturn_t ufs_qcom_mcq_esi_handler(int irq, void *data)
>  	struct msi_desc *desc = data;
>  	struct device *dev = msi_desc_to_dev(desc);
>  	struct ufs_hba *hba = dev_get_drvdata(dev);
> -	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>  	u32 id = desc->msi_index;
>  	struct ufs_hw_queue *hwq = &hba->uhq[id];
>  
> -- 
> 2.39.2
> 
