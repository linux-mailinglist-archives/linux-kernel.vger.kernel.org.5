Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975C880784F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379134AbjLFTBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378848AbjLFTBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:01:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429B2181
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 11:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701889089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KvnpSQri5arb6xwcBFDZQI0HnLnuARbU/naBERSZQac=;
        b=OEF9akOeb/5YSiB49G4mfFn1lca+v8CobYC1Jkd5jqmzFfgP9bvZztEgw64xoxzlu4YBw9
        eJ67mStN3twKxgZ5A4u/TpvCVXIO+Nw8MiLJrF1Ab2lBeuq+IuWs4nR62Ou8SB28NfKWkK
        +7dPAMhWIU20t44LzrQPEzf7fvkgPdw=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-sdACHOFgMamaSjMq8WdrIA-1; Wed, 06 Dec 2023 13:36:45 -0500
X-MC-Unique: sdACHOFgMamaSjMq8WdrIA-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-58a5860c88fso69945eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 10:36:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701887804; x=1702492604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvnpSQri5arb6xwcBFDZQI0HnLnuARbU/naBERSZQac=;
        b=ugW1cbQpf1O9cuRxikpQlclXdHMVYtoeXdzJiIeki/fCNKlPAtuVmyvlTkHqlZn2dt
         h66P8iHwIfBloc4dJFmPJN1BNE+yL/ps05TBOYBhImC2vAJpjsjWnOIspD9Xn3yXs6V7
         0IcnvpfE5OGmFtFORt39ICA70I5LDBKqrLLm+T95wC7hVjcFBidvmBm+/m0orS7KtdBs
         aUrvHFg36Zjaat73NomNVbwzxoEsF47JAORsYj/MhoeiGHzm23Rr6ri4LJCYOgSP0sF3
         6vhYZYhfSyArf2KD83Khh17yk5jozT3/YOV2IsR0FApXMzv03Za0GmAJOal2ipQPj1o5
         wkPg==
X-Gm-Message-State: AOJu0YyyZqNosKsd+OWpylNYuygeF4nMyKPvAovr9J2iFTbgnsXMwBnZ
        WMtWjkmlN0izANWOUsL/FRuYMddqhQuh17apF4rlSh2mjprOA+3gT5BIWoZEcXvnz+ZNoBcrDtS
        iN0SW0eUyxywGlvv2qG/peTY1
X-Received: by 2002:a05:6358:7206:b0:16d:fe33:4c63 with SMTP id h6-20020a056358720600b0016dfe334c63mr1635760rwa.24.1701887804315;
        Wed, 06 Dec 2023 10:36:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVXVpDI2N4zq6TmLP+46EyCJXTztwSBXqvdJFhrfnSKXRuRptwKjhGCPJ0XHZcWj52RCTA0Q==
X-Received: by 2002:a05:6358:7206:b0:16d:fe33:4c63 with SMTP id h6-20020a056358720600b0016dfe334c63mr1635747rwa.24.1701887803917;
        Wed, 06 Dec 2023 10:36:43 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id g7-20020ac84807000000b004258264d166sm149989qtq.60.2023.12.06.10.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:36:43 -0800 (PST)
Date:   Wed, 6 Dec 2023 12:36:41 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com
Subject: Re: [PATCH 05/13] scsi: ufs: qcom: Remove the warning message when
 core_reset is not available
Message-ID: <ru2zdpls5tx2wjt3oknqndikuc4we7d3haeawzrdyl7cbsycti@clx55b27nzvn>
References: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
 <20231201151417.65500-6-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201151417.65500-6-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 08:44:09PM +0530, Manivannan Sadhasivam wrote:
> core_reset is optional, so there is no need to warn the user if it is not
> available (that too not while doing host reset each time).

What's the bit in the parenthesis mean here? I'm having a hard time
following. Otherwise, this looks good to me.

> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/ufs/host/ufs-qcom.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index dc93b1c5ca74..d474de0739e4 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -296,10 +296,8 @@ static int ufs_qcom_host_reset(struct ufs_hba *hba)
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>  	bool reenable_intr;
>  
> -	if (!host->core_reset) {
> -		dev_warn(hba->dev, "%s: reset control not set\n", __func__);
> +	if (!host->core_reset)
>  		return 0;
> -	}
>  
>  	reenable_intr = hba->is_irq_enabled;
>  	disable_irq(hba->irq);
> -- 
> 2.25.1
> 
> 

