Return-Path: <linux-kernel+bounces-1153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29014814B2B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B42286DB3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E557D358B3;
	Fri, 15 Dec 2023 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sgd0Hmyg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D81D364C3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702652750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2mTkjp44SgKM5pRsxlf1Sy23GE4iUMqngu3yjNyJYzY=;
	b=Sgd0Hmygg0yZ+nPy7V0Pr3uYaqk33sfct8TQzS/fP5+0orYXlcH1okJiR6B7HaBNFb0yQP
	9GlAQY6xhyxqUNx4BXEhfRemjJcL1m6d/1fpCygb0xjOAxjD6ThZ6DURUmHU9Llhn3Ns7e
	UCaLnwyDBSsnpYCRGahQinVk7jAYXgg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-EZdiysuGOOS2UA6UKSowiQ-1; Fri, 15 Dec 2023 10:05:48 -0500
X-MC-Unique: EZdiysuGOOS2UA6UKSowiQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-421b20c9893so10176241cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 07:05:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702652747; x=1703257547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mTkjp44SgKM5pRsxlf1Sy23GE4iUMqngu3yjNyJYzY=;
        b=Ms3YYVvNzBzTPB2Ah5vY73M2O2SLth8jrYTdmx9YC8OOnWDPrkXzBMkFfaG6wAdp1S
         fVKbtPvvIVV8AA8Inw3QHgK4CKGMg80rerNECjUvy9Y7FPjW4l7NA3afDIY5Knt+s7uG
         /LUF6PeayLTbjtkNOlp90w5cUkp4RbrONr5o+wM4o7rgTt2gCaUgfDq88J/CDD1RD0Qi
         tMKn+CW16uOEt4QlQnVbrNDTvD4Xw1eSysmdrtuUM5YPo+qaKI1oc7VuwOG3kfqW5492
         L7vBy+GfQBQyGyk1O4urhsIzbSW58wKvUGjLNoyHp/IX3cfMNQP1+st0Y7GxGgK5dUUv
         Dh0A==
X-Gm-Message-State: AOJu0Yz2z67fiSvbfKBI/uxUkkT4yQZiNQ16d75byuIBl37YHEyuidpr
	vrky/mn1uTzcOlyJdGCRyCHx0ct9ZIm9zhkdBMingo5vQivTIl6MpciQvJblLCgHsOOvWHZYHWs
	BOi3w22WNsQdZMrsDlO2UQ+1b
X-Received: by 2002:ac8:7d0e:0:b0:425:96be:875d with SMTP id g14-20020ac87d0e000000b0042596be875dmr15818344qtb.40.1702652747683;
        Fri, 15 Dec 2023 07:05:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEss/rhEGN+//vVGcxnfrOT4j/e72cx+AdDE6SKKoQIAeF30xgaW1VvM3oNXrjxCPdeBUXuKw==
X-Received: by 2002:ac8:7d0e:0:b0:425:96be:875d with SMTP id g14-20020ac87d0e000000b0042596be875dmr15818305qtb.40.1702652747221;
        Fri, 15 Dec 2023 07:05:47 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id m18-20020ac86892000000b00419801b1094sm6687403qtq.13.2023.12.15.07.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 07:05:46 -0800 (PST)
Date: Fri, 15 Dec 2023 09:05:44 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Chanwoo Lee <cw9316.lee@samsung.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
	mani@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com, 
	quic_asutoshd@quicinc.com, dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, grant.jung@samsung.com, 
	jt77.jang@samsung.com, dh0421.hwang@samsung.com, sh043.lee@samsung.com, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3] scsi: ufs: qcom: Return ufs_qcom_clk_scale_*() errors
 in ufs_qcom_clk_scale_notify()
Message-ID: <qfmuuw77l5vm76l3anxb2rasjv6xqm5kvx3hooudhcjwqlv55l@faknw3kgchbm>
References: <CGME20231215003817epcas1p21127357982772ebe0e84b86f20115186@epcas1p2.samsung.com>
 <20231215003812.29650-1-cw9316.lee@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215003812.29650-1-cw9316.lee@samsung.com>

On Fri, Dec 15, 2023 at 09:38:12AM +0900, Chanwoo Lee wrote:
> From: ChanWoo Lee <cw9316.lee@samsung.com>
> 
> In commit 031312dbc695 ("scsi: ufs: ufs-qcom: Remove unnecessary goto statements")
> the error handling was accidentally changed, resulting in the error of
> ufs_qcom_clk_scale_*() calls not being returned.
> 
> This is the case I checked.
> * ufs_qcom_clk_scale_notify -> 'ufs_qcom_clk_scale_up_/down_pre_change' error -> return 0;
> 
> Let's make sure those errors are properly returned.
> 
> Fixes: 031312dbc695 ("scsi: ufs: ufs-qcom: Remove unnecessary goto statements")

Thanks for the changes. Looks good to me now:

    Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
> ---
> * v2->v3: Change title and description
>   v2 :
>      https://patchwork.kernel.org/project/linux-scsi/patch/20231214021401.26474-1-cw9316.lee@samsung.com/
> 
> * v1->v2: Remove things already in progress
>   v1 :
>      https://patchwork.kernel.org/project/linux-scsi/patch/20231213022500.9011-1-cw9316.lee@samsung.com/
> ---
> ---
>  drivers/ufs/host/ufs-qcom.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 96cb8b5b4e66..17e24270477d 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1516,9 +1516,11 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
>  			err = ufs_qcom_clk_scale_up_pre_change(hba);
>  		else
>  			err = ufs_qcom_clk_scale_down_pre_change(hba);
> -		if (err)
> -			ufshcd_uic_hibern8_exit(hba);
>  
> +		if (err) {
> +			ufshcd_uic_hibern8_exit(hba);
> +			return err;
> +		}
>  	} else {
>  		if (scale_up)
>  			err = ufs_qcom_clk_scale_up_post_change(hba);
> -- 
> 2.29.0
> 


