Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DA68077B3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjLFSmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjLFSmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:42:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3586584
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701888140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2YDjLMepeuXQAOfLexw9wJ/G5xIz4DXfzdIVQzgockk=;
        b=SppJsPSelUGkGGnH/ppN4b6QWpUJ6X5/O2ww31zenoIH/JqfKPZWamnyzyfbsVZID2ZA4F
        Y4d2o2elgzKL5QCiSR2XYKuho38kPnAXqTZt6ThHhB2VFNp6rXo3xhpTbkP7OP/YLHoXAo
        /ea6XNVbGfkG1CRzSdkkKc/B5Q4o0Lo=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-sxcv2EVzPxeb0pAhKKZLtA-1; Wed, 06 Dec 2023 13:41:32 -0500
X-MC-Unique: sxcv2EVzPxeb0pAhKKZLtA-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1fb0a385ab8so485587fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 10:41:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701888091; x=1702492891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YDjLMepeuXQAOfLexw9wJ/G5xIz4DXfzdIVQzgockk=;
        b=h/AgAt2kBMF0TIsBl4/Cu9Y9te0Ged264ynEm/TK52MAsNqMVz8FLToXpbzlWJcgYp
         /ShCLFDadjU0ieEMt09rO8H2Uuyzm952Znz6wrl6cJ513J+Eeoj6CTRWceb2u1QLHYfp
         DmklJbzLZtv6VBU76XflAfyU37UTMhb7u0BNV7YAotaFhS0KS41D0YVTv9bO+0oNdkMh
         IExuEM/ErtrCc3m9d2Rb1wSidPkhA4i4rRV3tVRlQoP/cl4mgyRprM9EmJkd2o0eATgL
         rB17tEL9ce/0qoxykTqY/fpxtx6HxcO3oETqwHCyqB2OOhNt7ChK6IEmpk6Nyhmy/dQS
         XmzQ==
X-Gm-Message-State: AOJu0YxZ+8Q4Xlp4HaWf9Mi+BCXTWzFnW9ack3O+MnAveLV69afAmlKl
        cuLrea234gsYOCLO1l1lw8FbMU8w5oo9Fu3gaItbicHWQkNrQSj2hoTFq0mQzUjO6QdisBWi75N
        5g5DFU201WmWHKK2QQ8op9Czz
X-Received: by 2002:a05:6871:3402:b0:1fb:d89:48c3 with SMTP id nh2-20020a056871340200b001fb0d8948c3mr1475751oac.27.1701888091165;
        Wed, 06 Dec 2023 10:41:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEh12IvLMDJGznFqN4fzVBxPyYWXOTCG2Cau5TEzfYtnO6TcRlyHWdIYXkx8j3uxxYSu2oFjg==
X-Received: by 2002:a05:6871:3402:b0:1fb:d89:48c3 with SMTP id nh2-20020a056871340200b001fb0d8948c3mr1475741oac.27.1701888090916;
        Wed, 06 Dec 2023 10:41:30 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id r6-20020a056870e8c600b001fadabf6626sm91503oan.23.2023.12.06.10.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:41:30 -0800 (PST)
Date:   Wed, 6 Dec 2023 12:41:28 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com
Subject: Re: [PATCH 07/13] scsi: ufs: qcom: Fail ufs_qcom_power_up_sequence()
 when core_reset fails
Message-ID: <iecwyzsamuwhatodicsfptf3dgl5nglrdqyennmhagpjz7yrtr@r72gejcvhi6w>
References: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
 <20231201151417.65500-8-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201151417.65500-8-manivannan.sadhasivam@linaro.org>
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

On Fri, Dec 01, 2023 at 08:44:11PM +0530, Manivannan Sadhasivam wrote:
> Even though core_reset is optional, a failure during assert/deassert should
> be considered fatal, if core_reset is available. So fail
> ufs_qcom_power_up_sequence() if an error happens during reset and also get
> rid of the redundant warning as the ufs_qcom_host_reset() function itself
> prints error messages.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>  drivers/ufs/host/ufs-qcom.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 604273a22afd..4948dd732aae 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -359,8 +359,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>  	/* Reset UFS Host Controller and PHY */
>  	ret = ufs_qcom_host_reset(hba);

I noticed that ufs_qcom_host_reset() doesn't return an error if
reset_control_deassert() fails. Can you address this in the next spin of
the series (I don't think its in the following patches that I glanced
through).

Thanks,
Andrew

>  	if (ret)
> -		dev_warn(hba->dev, "%s: host reset returned %d\n",
> -				  __func__, ret);
> +		return ret;
>  
>  	/* phy initialization - calibrate the phy */
>  	ret = phy_init(phy);
> -- 
> 2.25.1
> 
> 

