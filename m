Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BFB807831
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378653AbjLFSyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378623AbjLFSyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:54:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13419A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701888856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2T2oM8n7ES3F56mk7P89karRriuSouYwO1C14uj3RQs=;
        b=JimC7r6Z9ntYUll1MLERD24H29srfTXhws9y3VUKI4C5gIluvuDExux/eeh1RYxoOMUMes
        ZdVch5k+KA0GGvF8l1DG6eYJjffWV7QjRmUDDOxMkczhKG5UoyvDHNVzSN/SvuIYujIr21
        s8UFSLB0c79YUaiQgGiDeofJrIUzJgs=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-S6fuyit5OTO51ppnRR-u6w-1; Wed, 06 Dec 2023 13:52:43 -0500
X-MC-Unique: S6fuyit5OTO51ppnRR-u6w-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-58e2b7e4f94so194139eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 10:52:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701888758; x=1702493558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2T2oM8n7ES3F56mk7P89karRriuSouYwO1C14uj3RQs=;
        b=jkoRMaYgMDMHyC+W89F8LNtto6+slhSpGXWsOQL8KrZWKzLh8hsCBU6Cs8Tr8Zoh/A
         +OBr6uW+lrVjs7EXpgM83+qE1Og68TWY9p4NYsUsEas5te/HfzrREXTh/WooAFBdL+jO
         wcFAE+QFjcYo7SjHGgovdoh1k+FKMh1YjDz+hs+NG9e4Pvuy8lW0PLtRWveebbM2h8iT
         pWu8c7mpYcDPJ8FpCgwiwvDNeI9ma+nvwnM2k+VuuP+OeaB5sTSw3fYJWNGSLJ7oq/72
         0eQ30bMVKmjOXjxkmThJZEoQn91uYA3PoVgx1SEgNJm78wJwwu4sS3FYD8XXuKxYus7J
         NNtA==
X-Gm-Message-State: AOJu0Yy6o7WX/zJ4kQWUV8li5iG3GY3spCO+dI7IgAf9wLiCktFiluqK
        CPza4lwZaRFMMk+3aOmNE306oOVwNj2VZ+1Zjdgh+bgNZAPs6XhayG40JRyXn3rdHCzDaVudZVP
        KLaOw+Yvp5BRVBVd6F2GO0vFn
X-Received: by 2002:a05:6358:9049:b0:170:982:5611 with SMTP id f9-20020a056358904900b0017009825611mr1734948rwf.32.1701888758714;
        Wed, 06 Dec 2023 10:52:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGWWO9/aICv0W0WM3P+DYCIxzbBCoWdkWyVRrfijwhjBdH3/PviMW3Ncuu5AZPyvNFq7pIKg==
X-Received: by 2002:a05:6358:9049:b0:170:982:5611 with SMTP id f9-20020a056358904900b0017009825611mr1734939rwf.32.1701888758442;
        Wed, 06 Dec 2023 10:52:38 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id s6-20020ad45006000000b0067a3ad49979sm185483qvo.96.2023.12.06.10.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:52:38 -0800 (PST)
Date:   Wed, 6 Dec 2023 12:52:36 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com
Subject: Re: [PATCH 10/13] scsi: ufs: qcom: Use dev_err_probe() to simplify
 error handling of devm_gpiod_get_optional()
Message-ID: <swt7fadd6cpi3tfyphpuhv5omlr3jzc6uipc246f7flritnufs@4hjdjfjnydgr>
References: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
 <20231201151417.65500-11-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201151417.65500-11-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 08:44:14PM +0530, Manivannan Sadhasivam wrote:
> As done in other places, let's use dev_err_probe() to simplify the error
> handling while acquiring the device reset gpio using
> devm_gpiod_get_optional().
> 
> While at it, let's reword the error message to make it clear that the
> failure is due to acquiring "device reset gpio".
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/ufs/host/ufs-qcom.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 218d22e1efce..a86f6620abc8 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1146,9 +1146,8 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>  	host->device_reset = devm_gpiod_get_optional(dev, "reset",
>  						     GPIOD_OUT_HIGH);
>  	if (IS_ERR(host->device_reset)) {
> -		err = PTR_ERR(host->device_reset);
> -		if (err != -EPROBE_DEFER)
> -			dev_err(dev, "failed to acquire reset gpio: %d\n", err);
> +		err = dev_err_probe(dev, PTR_ERR(host->device_reset),
> +				    "Failed to acquire device reset gpio\n");
>  		goto out_variant_clear;
>  	}
>  
> -- 
> 2.25.1
> 
> 

