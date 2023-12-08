Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DE680A0E6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573512AbjLHK3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573612AbjLHK3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:29:25 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AAB2706
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:28:42 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5c6f9d1ba9cso94054a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 02:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702031322; x=1702636122; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SUV+KrS/M1PX7b2cWkbcJDPyrMmWw0crWFGMGpiuR+Q=;
        b=RQRHtWg/2ACiwRcoKfXTM57yi+/U22p2yk8gM3UGCdkD2xLP7dMfax23W4FJKCwtnR
         z8BNgRo9O8a+hEV6eKzw6geclLDgyNy9TVDk+K9b6KcXaAzQl2pVl/cO/CV3Ep6ubdYZ
         SNZmPfOOm7REoVGiNmeNPXGTJ1db1r599Z9zZBREhi3W1MSEkZ1mVoDPjSQ391QdSRWW
         6Vq9Mgit7INzHOtLRhAYkK+E6Geml8ZLwDtoaixWc9MYFNadivhyTw3wn6UlOQG+CHL9
         P9+0DfuBFr07y633OJ5rwIB1jD8qVNTm9x0PPJ3WvCew+3SXwI+zjZPK8x9dZwsUoQ5p
         KYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702031322; x=1702636122;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUV+KrS/M1PX7b2cWkbcJDPyrMmWw0crWFGMGpiuR+Q=;
        b=lIIQ6xq71ZjMCR+3lJdjEkK+NgWcKBAqKwELTD+BPKaPe8/EBx+TYBv1ZOO8MC7GV5
         i9KnXVKDRf2fDFLJlTDGdrcG/6E162wKona6rW30R+W6EoQVIeR7gtLTdcRbl7txeyRF
         gePkbEpf1yJVdi77sF+OYDCroyFQxK05SeR74uz6h6r5Zi8ft/zpBEddwlyfwi57ANMS
         CJmVxGEUJDXKzLfAW2RxAZA8K6Q5IeamjNJRqeSNgDDN8zDdzNmDLkE6VcuR3e5Y2N/L
         GNAa4joZGf226f9symGGQjsAoMgfVuORrNkmzfs+X7nbHAIZNAdBYYA28Mb4d6PY3epv
         l/oA==
X-Gm-Message-State: AOJu0Yw4T7ZuhVHZIcL1rIAg2O4//M6D476ixWTsitexmu9lo5HMqYkk
        0ZQnz3ONnjJaH/VplntKaTqEs26ragY1dev4qw==
X-Google-Smtp-Source: AGHT+IF2FRydo8njGp04OKtgX72qcMhY6Q36zNhjSrP9AlmGihq0Ok6RbEQ7vZs61mh+BlsQIlwCcg==
X-Received: by 2002:a05:6a20:9410:b0:18b:c96b:a433 with SMTP id hl16-20020a056a20941000b0018bc96ba433mr3565998pzb.56.1702031321911;
        Fri, 08 Dec 2023 02:28:41 -0800 (PST)
Received: from thinkpad ([117.216.123.142])
        by smtp.gmail.com with ESMTPSA id p25-20020aa78619000000b006ce71af841bsm1241285pfn.4.2023.12.08.02.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 02:28:41 -0800 (PST)
Date:   Fri, 8 Dec 2023 15:58:32 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        ahalaney@redhat.com
Subject: Re: [PATCH v2 05/17] scsi: ufs: qcom: Remove the warning message
 when core_reset is not available
Message-ID: <20231208102832.GA3008@thinkpad>
References: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
 <20231208065902.11006-6-manivannan.sadhasivam@linaro.org>
 <7472fe73-e7a0-5c8c-6e85-655db028a5c3@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7472fe73-e7a0-5c8c-6e85-655db028a5c3@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 02:55:21PM +0530, Nitin Rawat wrote:
> 
> 
> On 12/8/2023 12:28 PM, Manivannan Sadhasivam wrote:
> > core_reset is optional, so there is no need to warn the user if it is not
> > available.
> > 
> > Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/ufs/host/ufs-qcom.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> > index dc93b1c5ca74..d474de0739e4 100644
> > --- a/drivers/ufs/host/ufs-qcom.c
> > +++ b/drivers/ufs/host/ufs-qcom.c
> > @@ -296,10 +296,8 @@ static int ufs_qcom_host_reset(struct ufs_hba *hba)
> >   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> >   	bool reenable_intr;
> > -	if (!host->core_reset) {
> > -		dev_warn(hba->dev, "%s: reset control not set\n", __func__);
> > +	if (!host->core_reset)
> >   		return 0;
> > -	}
> >   	reenable_intr = hba->is_irq_enabled;
> >   	disable_irq(hba->irq);
> 
> 
> Hi Mani,
> 
> I think core reset is not frequent. It happen during only probe ,error
> handler.
> 
> core reset is needed in kernel to cleanup UFS phy and controller
> configuration before UFS HLOS operation starts as per HPG.
> 

This sounds like core reset is not an optional property but a required one. I
just checked the upstream DT files for all SoCs, and looks like pretty much all
of them support core reset.

Only MSM8996 doesn't have the reset property, but the reset is available in GCC.
So we should be able to use it in dtsi.

I also skimmed through the HPG and looks like core reset is not optional. Please
confirm.

- Mani

> Having existing warn print can be used to to debug or atleast know
> core_reset is missed in device tree to give indication complete reset hasn't
> been done and we could still be operating in bootloader configuration.
> 
> 
> Regards,
> Nitin
> 

-- 
மணிவண்ணன் சதாசிவம்
