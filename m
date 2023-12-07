Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A37808020
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 06:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjLGF03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 00:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjLGF01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 00:26:27 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A6F10C0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 21:26:32 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5bcfc508d14so417930a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 21:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701926791; x=1702531591; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XeEwOVdmoze4GgUERLZCvN1YeRMPDZTEgHk4TFeG0KI=;
        b=GB5BLNw2Hg3PxpzGnosbNxesjIavbkDGPg6Yi6K9IBB0+H3WuHRPwDjO5CZWYLElX0
         hB0Fc4qtYeDdQie4hahYtqt0R1p2f0MoaAOsHqGWRm9mA59yKDyRjoQWw51ncWJE5Eie
         kda8TR8Hg0DEDLFlYvA6W0eMM35vzlqEjMAuKA2LUR1eHiNWk9PqIz904F04stkwf1mu
         AiTidL2Tm9xe6RlZTPjOsnNhirY1oP8ZtXvJttZo8fVJLd8Pt6x5dftJ5AKuL3A1czhA
         UKVt9nSIPsXKy5R1xiaEfkXr0ORBi2WVtdBpVijQy998zbK6NqvVMyWzsbysZODstuNB
         k/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701926791; x=1702531591;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XeEwOVdmoze4GgUERLZCvN1YeRMPDZTEgHk4TFeG0KI=;
        b=nzwf2aRmxdWgAys4pD1s2mAn1NTfkXe5fjDrN+m1X5QWe/zDkHTO/dj6B5sjC6nkv2
         30LVf9G3rH+sntvwsnq7PqXu7DX7mWV9EHjBD5lREas7G1rxsAhAuLtyRbHo2Rp0bNwT
         pWRw7xzO3rhQzg3Fe2H0nvfgLkjtYjupgmjqISlrcur6ymNBr+zVLfSvjZsE1YK7NO0P
         gg05j22K0KbLML3V0m4uBsePG0xtvjX/bsW5aFLPJRJLIL5vWboqupw1ptoOkE82vKqm
         fHzYNoiZ+6RNsFXGee31g22+chKowlMPj6pkvZOH1Gf/J9YsLVGYZaWC5JBAWAKficIG
         eGwA==
X-Gm-Message-State: AOJu0Yz3rQ3su0z2UJU2yb8EBWcbFFV1vjNbfmj80yywP/Jzyd1J5kMi
        VlspSbI4REUDgUiO5I3dN0AV
X-Google-Smtp-Source: AGHT+IEtTZTW+sxUG+Y2qkOFbTaA4dzLqxda31KDpLSQuX7weMGaX0vHN/j3SKmhaPyP+fnGbTc3vw==
X-Received: by 2002:a05:6a21:149a:b0:18c:42ab:fced with SMTP id od26-20020a056a21149a00b0018c42abfcedmr1857397pzb.47.1701926791573;
        Wed, 06 Dec 2023 21:26:31 -0800 (PST)
Received: from thinkpad ([117.248.6.133])
        by smtp.gmail.com with ESMTPSA id x20-20020a170902821400b001cfc50e5afesm385085pln.23.2023.12.06.21.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 21:26:31 -0800 (PST)
Date:   Thu, 7 Dec 2023 10:56:26 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com
Subject: Re: [PATCH 07/13] scsi: ufs: qcom: Fail ufs_qcom_power_up_sequence()
 when core_reset fails
Message-ID: <20231207052626.GB2932@thinkpad>
References: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
 <20231201151417.65500-8-manivannan.sadhasivam@linaro.org>
 <iecwyzsamuwhatodicsfptf3dgl5nglrdqyennmhagpjz7yrtr@r72gejcvhi6w>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <iecwyzsamuwhatodicsfptf3dgl5nglrdqyennmhagpjz7yrtr@r72gejcvhi6w>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 12:41:28PM -0600, Andrew Halaney wrote:
> On Fri, Dec 01, 2023 at 08:44:11PM +0530, Manivannan Sadhasivam wrote:
> > Even though core_reset is optional, a failure during assert/deassert should
> > be considered fatal, if core_reset is available. So fail
> > ufs_qcom_power_up_sequence() if an error happens during reset and also get
> > rid of the redundant warning as the ufs_qcom_host_reset() function itself
> > prints error messages.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> > ---
> >  drivers/ufs/host/ufs-qcom.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> > index 604273a22afd..4948dd732aae 100644
> > --- a/drivers/ufs/host/ufs-qcom.c
> > +++ b/drivers/ufs/host/ufs-qcom.c
> > @@ -359,8 +359,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
> >  	/* Reset UFS Host Controller and PHY */
> >  	ret = ufs_qcom_host_reset(hba);
> 
> I noticed that ufs_qcom_host_reset() doesn't return an error if
> reset_control_deassert() fails. Can you address this in the next spin of
> the series (I don't think its in the following patches that I glanced
> through).
> 

Right. I'll fix it in next version.

- Mani

> Thanks,
> Andrew
> 
> >  	if (ret)
> > -		dev_warn(hba->dev, "%s: host reset returned %d\n",
> > -				  __func__, ret);
> > +		return ret;
> >  
> >  	/* phy initialization - calibrate the phy */
> >  	ret = phy_init(phy);
> > -- 
> > 2.25.1
> > 
> > 
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
