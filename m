Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBC88126B3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 05:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbjLNE44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 23:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjLNE4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 23:56:54 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0977F5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 20:57:00 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-35f56f06142so20914095ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 20:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702529820; x=1703134620; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UmyYjKOw9pwdZPYGxJ9gRt+5SLkPidLRqb9vGm21xYc=;
        b=Saz6U9DY44dJwVooHdYOebOiVpxYS02C0haevBWk6q5lNhLnnVbtEQsxFnJjFGKZrt
         R+Mf/t17xVaW8i21LGDNVaweA+YQbPzRLs9rTyMlfsf3nEoH1glpdtx78PNgPlPbXqDK
         ZFdiHbUugeBYUt9VMy6IRi2Mbri+bowLumifoUomTaDimAsTMZOt0TqWWuaL1xiaHvVh
         95xcOpEBxPyBO12l1MyrnbV+OHRMlZRWPDFQDLnl9XbQCMM4Hn7EbdGdmLgy1IFktm44
         yG4jaRPHWzO6ZQA8b3CSgJt2iaXljUpNDzuh+Ak9Y7n3meUJoVW2qKxm7cZiRl4VqyDB
         uYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702529820; x=1703134620;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmyYjKOw9pwdZPYGxJ9gRt+5SLkPidLRqb9vGm21xYc=;
        b=LTRfz5mXPMd//GryIe1nVQRvr5gD8XK9RD6JxvcYs87LFMzDsqONmOx/QgMYWXMv2v
         5V65HSYrewpka6X5/RIwR+iyoGr06LS5WZJ7hF6WM3TBlheExZmzc7/uzsM7JyETVMlw
         /28cuRHivoPp+zPJowiMuqOqI1UyV66gqhc966cA/dCjJ2TJcwE1R+SU2cpWsaz5C5Zm
         Yr4lhZ3WrtQNE8C6LqL4lkGf7d4qmklN7LOYhBidUsYko8sZNaRjv7QApbjbjrgEMlN8
         gyo67y6sJVNARzzbXs4ztF1OLhMrWPknBTqWELXdjlwOg1sCF3IQE7cxIXF2UDRUjKLV
         Ntvw==
X-Gm-Message-State: AOJu0YzpD34tg/nWtkp9SpEeXbbBwgykTH/eS8cXVavgb7RPGNte9JhP
        n2jGL0ctd7o4hWhphXts7eas
X-Google-Smtp-Source: AGHT+IHJlJAU7IvWFTEdkyv9GQpwB/Wnxb9blzstVRulRB1uQvE1DpDi/qtyrhyMHg9KO+AnxBlDvw==
X-Received: by 2002:a05:6e02:156f:b0:35d:a285:14b4 with SMTP id k15-20020a056e02156f00b0035da28514b4mr14961159ilu.50.1702529819982;
        Wed, 13 Dec 2023 20:56:59 -0800 (PST)
Received: from thinkpad ([117.213.102.12])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090341c100b001d33c85ce1bsm3992546ple.2.2023.12.13.20.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 20:56:59 -0800 (PST)
Date:   Thu, 14 Dec 2023 10:26:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com
Subject: Re: [PATCH v2 16/17] scsi: ufs: qcom: Use ufshcd_rmwl() where
 applicable
Message-ID: <20231214045650.GA2938@thinkpad>
References: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
 <20231208065902.11006-17-manivannan.sadhasivam@linaro.org>
 <wkykvnfc6qmrfy3j4h765gifm2scsrjmxs24nx2lkwakgt6jvv@k5lcdsubrb4o>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <wkykvnfc6qmrfy3j4h765gifm2scsrjmxs24nx2lkwakgt6jvv@k5lcdsubrb4o>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 12:02:03PM -0600, Andrew Halaney wrote:
> On Fri, Dec 08, 2023 at 12:29:01PM +0530, Manivannan Sadhasivam wrote:
> > Instead of using both ufshcd_readl() and ufshcd_writel() to read/modify/
> > write a register, let's make use of the existing helper.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/ufs/host/ufs-qcom.c | 12 ++++--------
> >  drivers/ufs/host/ufs-qcom.h |  3 +++
> >  2 files changed, 7 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> > index 26aa8904c823..549a08645391 100644
> > --- a/drivers/ufs/host/ufs-qcom.c
> > +++ b/drivers/ufs/host/ufs-qcom.c
> > @@ -387,9 +387,8 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
> >   */
> >  static void ufs_qcom_enable_hw_clk_gating(struct ufs_hba *hba)
> >  {
> > -	ufshcd_writel(hba,
> > -		ufshcd_readl(hba, REG_UFS_CFG2) | REG_UFS_CFG2_CGC_EN_ALL,
> > -		REG_UFS_CFG2);
> > +	ufshcd_rmwl(hba, REG_UFS_CFG2_CGC_EN_ALL, REG_UFS_CFG2_CGC_EN_ALL,
> > +		    REG_UFS_CFG2);
> >  
> >  	/* Ensure that HW clock gating is enabled before next operations */
> >  	mb();
> > @@ -1689,11 +1688,8 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
> >  		platform_msi_domain_free_irqs(hba->dev);
> >  	} else {
> >  		if (host->hw_ver.major == 6 && host->hw_ver.minor == 0 &&
> > -		    host->hw_ver.step == 0) {
> > -			ufshcd_writel(hba,
> > -				      ufshcd_readl(hba, REG_UFS_CFG3) | 0x1F000,
> > -				      REG_UFS_CFG3);
> > -		}
> > +		    host->hw_ver.step == 0)
> > +			ufshcd_rmwl(hba, ESI_VEC_MASK, 0x1f00, REG_UFS_CFG3);
> 
> Is this right? I feel like you accidentally just shifted what was written
> prior >> 4 bits.
> 
> Before: 0x1f000
> After:  0x01f00
> 

Doh! you are right, I accidentally missed one 0. Since the series is already
merged, I will send a follow up patch.

> >  		ufshcd_mcq_enable_esi(hba);
> >  	}
> >  
> > diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> > index 385480499e71..2ce63a1c7f2f 100644
> > --- a/drivers/ufs/host/ufs-qcom.h
> > +++ b/drivers/ufs/host/ufs-qcom.h
> > @@ -102,6 +102,9 @@ enum {
> >  #define TMRLUT_HW_CGC_EN	BIT(6)
> >  #define OCSC_HW_CGC_EN		BIT(7)
> >  
> > +/* bit definitions for REG_UFS_CFG3 register */
> > +#define ESI_VEC_MASK		GENMASK(22, 12)
> > +
> 
> I'll leave it to someone with the docs to review this field. It at least
> contains the bits set above, fwiw. It would be neat to see that
> converted to using the field + a FIELD_PREP to set the bits IMO, but I
> honestly don't have a lot of experience using those APIs so feel free to
> reject that.
> 

Fair point. The reason for hardcoding the value in this patch was I didn't get
information on how the value works. But now I got that info, so will address
this in the follow up patch I mentioned above.

- Mani

> >  /* bit definitions for REG_UFS_PARAM0 */
> >  #define MAX_HS_GEAR_MASK	GENMASK(6, 4)
> >  #define UFS_QCOM_MAX_GEAR(x)	FIELD_GET(MAX_HS_GEAR_MASK, (x))
> > -- 
> > 2.25.1
> > 
> 

-- 
மணிவண்ணன் சதாசிவம்
