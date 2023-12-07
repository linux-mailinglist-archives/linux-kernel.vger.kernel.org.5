Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAE4808037
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 06:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjLGFcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 00:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGFcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 00:32:00 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4827D5C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 21:32:05 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ce93552d51so213559b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 21:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701927125; x=1702531925; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NnvGGl844Mt88/eDFjnKsRhrcFq+x0ulAemxO2S+bfU=;
        b=JqWxNk/8LBdyyfAMc3QDFfDiE6mnBtHIQ1ohAfisVnnZy4nO/iuUF49OJavBGd5887
         oIyYKmVqZTexFEPlsdFRhkiQ70VJnqCDTUKHARv/KbP8S4ecAMQXd8WBTGEhh1Eg0WFL
         ow6/qOFR9PT1TX7pRWjGwY1egeCAH5fPfKJDzMtOJAcjc8RL/SKpUClG6CLrcIZcHeb9
         PEZf3TNONWu1sDy+qLFM98j7aZ1dJ6L+pif+E3+JGSENF8ll2/Etnh6tL8udKEgRc3uL
         QxQDaW3+5olmdHxp3pZZeULzRuCQC5wr49CT+iWMHoiEwHiyIv8nECLw9nnkY7Cnld7c
         MlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701927125; x=1702531925;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NnvGGl844Mt88/eDFjnKsRhrcFq+x0ulAemxO2S+bfU=;
        b=HxZzL0L9ZpTAz2Ei/YO1zV00Gr6esid8VtgTTLrt9v1atKwRWm7FiK7Fep5C/sDR50
         oOqM0iqheEI0WNcS3D/kTdh0WPADu99GG9pjBQVP0GlSXit7UWdtSwXSGLWUxn8Xnr2X
         tcDnjkdMu8mLwBY/LIFjzOZFHNZ4wnTYvve8Z2TSFYaRVGiCH9kaWTYsQj+94Y5+r6Ve
         +sjIkXUB9eETaDg6DfazRNLRNNIsvzzb+ZkPKRzycPFXbIkhj6Xvs0MDHkIHfoTMOwnd
         xo8c+zFydHOr7MQsj8Sfoj5X/cYeZ9KfOlxyhNvaOTOdkQNxjZ9RQ3RoRxnpUzidKsSE
         a1wQ==
X-Gm-Message-State: AOJu0YwzfFbXPf9nExBj5LTjCq1zgWsioBO6uDSvjXhuqzEOVMgR8ict
        yZD9Qv31Xu8wjiEqixw5kvWc
X-Google-Smtp-Source: AGHT+IH6OaEgUEGq8ikcE2Z92TNqQ+21Ktn5NHM/RrKbtopBSOAZZ3yFsq/Flh5tRCPQL4wEiSO+OQ==
X-Received: by 2002:a05:6a20:3d8e:b0:18d:2748:ea22 with SMTP id s14-20020a056a203d8e00b0018d2748ea22mr1917241pzi.17.1701927125136;
        Wed, 06 Dec 2023 21:32:05 -0800 (PST)
Received: from thinkpad ([117.248.6.133])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090322d000b001d1c96a0c63sm378626plg.274.2023.12.06.21.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 21:32:04 -0800 (PST)
Date:   Thu, 7 Dec 2023 11:01:59 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com
Subject: Re: [PATCH 11/13] scsi: ufs: qcom: Remove unused ufs_qcom_hosts
 struct array
Message-ID: <20231207053159.GC2932@thinkpad>
References: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
 <20231201151417.65500-12-manivannan.sadhasivam@linaro.org>
 <sqdgnfedt5j3epypmsvb7lv6gvmjrymtuieji3yhqsfvniiodl@f3aj73mlshxy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sqdgnfedt5j3epypmsvb7lv6gvmjrymtuieji3yhqsfvniiodl@f3aj73mlshxy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 12:54:43PM -0600, Andrew Halaney wrote:
> On Fri, Dec 01, 2023 at 08:44:15PM +0530, Manivannan Sadhasivam wrote:
> > ufs_qcom_hosts array is assigned, but not used anywhere. So let's remove
> > it.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/ufs/host/ufs-qcom.c | 5 -----
> >  1 file changed, 5 deletions(-)
> > 
> > diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> > index a86f6620abc8..824c006be093 100644
> > --- a/drivers/ufs/host/ufs-qcom.c
> > +++ b/drivers/ufs/host/ufs-qcom.c
> > @@ -90,8 +90,6 @@ static const struct __ufs_qcom_bw_table {
> >  	[MODE_MAX][0][0]		    = { 7643136,	307200 },
> >  };
> >  
> > -static struct ufs_qcom_host *ufs_qcom_hosts[MAX_UFS_QCOM_HOSTS];
> > -
> 
> I think we can get rid of MAX_UFS_QCOM_HOSTS as well with this change in
> place?
> 

Yes, thanks for spotting.

- Mani

> >  static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
> >  static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba, bool is_scale_up);
> >  
> > @@ -1192,9 +1190,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
> >  
> >  	ufs_qcom_setup_clocks(hba, true, POST_CHANGE);
> >  
> > -	if (hba->dev->id < MAX_UFS_QCOM_HOSTS)
> > -		ufs_qcom_hosts[hba->dev->id] = host;
> > -
> >  	ufs_qcom_get_default_testbus_cfg(host);
> >  	err = ufs_qcom_testbus_config(host);
> >  	if (err)
> > -- 
> > 2.25.1
> > 
> > 
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
