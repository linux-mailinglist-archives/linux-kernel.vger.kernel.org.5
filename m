Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3822780785D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442767AbjLFTGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379219AbjLFTGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:06:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83360D40
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 11:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701889599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lrcQ95ZMuKjHuke9HbkHyZcFozNRKymXYXIu9pIY1jA=;
        b=Y1ChOv830M6PRDQDIoUKLiYq52nrzrevhlSM0qDnGaobkXT3T8rcL2YSRepnYeH2po/L1l
        RCnL2jGG5FLysMTYDiVNscP0hFK8AC9x0aafuVt7vym4JpvaTV71BWJn3KwK+AKBU7bPkB
        7d89CeXaT3ZNQX3PwNVkgEJ7PKkoB20=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-qp8Z4rEtOcW2QlvBStwwJw-1; Wed, 06 Dec 2023 14:05:48 -0500
X-MC-Unique: qp8Z4rEtOcW2QlvBStwwJw-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4647a8e0e87so1379946137.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 11:05:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701889521; x=1702494321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrcQ95ZMuKjHuke9HbkHyZcFozNRKymXYXIu9pIY1jA=;
        b=Gs3wUjmiqEX9PUHPx9dT/1d0rxgbHWfa/aKQ9oI8oW3167ZvJkpfQk5SbhDbXFWCH4
         oRi98XKSYZhHvq1beuqkmc7tfWhgt7l3/26iUZ15QQV8xH10w5XAfx8uhjkBDlIqXRuW
         rjNGAvQFYrrYOan+E6GNKgRbtdGQp2WtEyV3Gr+7TybbdU0/2oI5TIMd0bPbWZEXQBie
         hDHte09+clqL7XR/m2HSuakXpPaxNWsBIO5kMcO0HM/RuQIHFewHk+/t6gpWzXks8n5r
         +PGk6nSiG+LAhzEC2XvIc8AtsSBu5urIEUrcBMUz2vityweo4sLAOVrrZE3xI47yWVpu
         xfSw==
X-Gm-Message-State: AOJu0YxM3uzBnnpf9odlZOmW+YRM0kQGYRtjrZN36Dr4B3igCdlMT5cB
        RhuxNPemGj39WpsDBiWa+6AeedXVgMoukXRlMiSnW9jGe9v61LQmwlPlWHvVflzSIW/N8Pe7Z35
        HpmBkSIB60pkfFZN3Wu++i5K1
X-Received: by 2002:a0c:c310:0:b0:67a:bde:8898 with SMTP id f16-20020a0cc310000000b0067a0bde8898mr2144614qvi.5.1701888886170;
        Wed, 06 Dec 2023 10:54:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGD8g0owuNThJQurdEIVWL455BacG+Ujo4HaFTS7u/XHSiv+qtGjLbdu2sMVZi4/hyaNg5viw==
X-Received: by 2002:a0c:c310:0:b0:67a:bde:8898 with SMTP id f16-20020a0cc310000000b0067a0bde8898mr2144601qvi.5.1701888885946;
        Wed, 06 Dec 2023 10:54:45 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id qd19-20020a05620a659300b0077d8a162babsm167867qkn.13.2023.12.06.10.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:54:45 -0800 (PST)
Date:   Wed, 6 Dec 2023 12:54:43 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com
Subject: Re: [PATCH 11/13] scsi: ufs: qcom: Remove unused ufs_qcom_hosts
 struct array
Message-ID: <sqdgnfedt5j3epypmsvb7lv6gvmjrymtuieji3yhqsfvniiodl@f3aj73mlshxy>
References: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
 <20231201151417.65500-12-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201151417.65500-12-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 08:44:15PM +0530, Manivannan Sadhasivam wrote:
> ufs_qcom_hosts array is assigned, but not used anywhere. So let's remove
> it.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/ufs/host/ufs-qcom.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index a86f6620abc8..824c006be093 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -90,8 +90,6 @@ static const struct __ufs_qcom_bw_table {
>  	[MODE_MAX][0][0]		    = { 7643136,	307200 },
>  };
>  
> -static struct ufs_qcom_host *ufs_qcom_hosts[MAX_UFS_QCOM_HOSTS];
> -

I think we can get rid of MAX_UFS_QCOM_HOSTS as well with this change in
place?

>  static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
>  static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba, bool is_scale_up);
>  
> @@ -1192,9 +1190,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>  
>  	ufs_qcom_setup_clocks(hba, true, POST_CHANGE);
>  
> -	if (hba->dev->id < MAX_UFS_QCOM_HOSTS)
> -		ufs_qcom_hosts[hba->dev->id] = host;
> -
>  	ufs_qcom_get_default_testbus_cfg(host);
>  	err = ufs_qcom_testbus_config(host);
>  	if (err)
> -- 
> 2.25.1
> 
> 

