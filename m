Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21DF812969
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443357AbjLNHdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbjLNHdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:33:21 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035CC18A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:33:13 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-42594f0ca09so39290371cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702539193; x=1703143993; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pD0FCZ0EPDMJ3nRws8kwPInwEm37ac/pfVSgH1LgqOo=;
        b=HfZql0JFFRIuMDVLQYZYiEk9ZD+uJDiooV8ThOXjd6AkH1CY8ucjYWEZfF1+Thg9Fp
         zt/NnYFJ9AuD8+LCYlYw8h99Tyi6DH7mxiqKgns5gtGkYXHFn5S8MPgd6XnhMc0s8+Rt
         qpNuQYt8p1jeb0lED3Q171p6pU7cV6Kn6QSm6xUpfmVAlc8/a1p/w2X+UT+itrtLtRr3
         RGF1AiNBourVQlC0WHG+ebZuVu0yVxePzn+z2p3dAFvKaBFGdcycFW3pdnsjfdb4qxfd
         Yej6RFNbsUFG2xw/s4KIdXt1ZOchjeBX8QTPRxA6DzEK53+eb55rUuJxQn1p9C/CX83Q
         wE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702539193; x=1703143993;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pD0FCZ0EPDMJ3nRws8kwPInwEm37ac/pfVSgH1LgqOo=;
        b=RZDlJKDrV6/i2id/4+GlN3b/3oP5FXR2UTGf4QMGDf3TCOQZ6PKd9+/tB4tekE/dXu
         /AESIATIQPWdn4cDq7hNG+/zlz0sSKCGB8jJHil6jSj6Z9kN5STq5dcZzMPhZyboHgUZ
         ZKbdeORr+76Ckg+9dptOjgQNqjUTpjFEa2ITofwaAIKUzKUe3AwwWEylvjyo2x/KjUkr
         cu4Iwoof4y+4iP32qUa4P4PldBrKXT3WBRiH4WtnzT2W9gGsuV4hV+qZqHvcbU80Hsct
         +MBbgyDHlEd2MLHomn59f/7Ajsz1p/vANNVCDRfFEu9+7bLBhqnkzp4Oc1xeDpHlb1b2
         yIHw==
X-Gm-Message-State: AOJu0YzdYMfhw4avLGCGSnsZqP/OFKU972813s2LlDbSBqZGC2tGXP0G
        vYAfXwfVp96FULwpKMGkEj5w
X-Google-Smtp-Source: AGHT+IGgp/3lSkFQD6Hrz7dtYYIJdq0NZpJ96MNKXxBvC74rabqBEsD01nmLhWNc+9oyvzOqj8iQbg==
X-Received: by 2002:ac8:7d50:0:b0:425:4043:8d2a with SMTP id h16-20020ac87d50000000b0042540438d2amr9146338qtb.69.1702539193114;
        Wed, 13 Dec 2023 23:33:13 -0800 (PST)
Received: from thinkpad ([117.213.102.12])
        by smtp.gmail.com with ESMTPSA id eh9-20020a05622a578900b00425d18d50e8sm2842852qtb.30.2023.12.13.23.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 23:33:12 -0800 (PST)
Date:   Thu, 14 Dec 2023 13:03:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        ahalaney@redhat.com
Subject: Re: [PATCH v2 05/17] scsi: ufs: qcom: Remove the warning message
 when core_reset is not available
Message-ID: <20231214073303.GH2938@thinkpad>
References: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
 <20231208065902.11006-6-manivannan.sadhasivam@linaro.org>
 <7472fe73-e7a0-5c8c-6e85-655db028a5c3@quicinc.com>
 <20231208102832.GA3008@thinkpad>
 <190651ad-6aeb-69eb-89c5-ed18221b5a7a@quicinc.com>
 <54e882ba-4758-1283-1a52-1f12201e1836@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54e882ba-4758-1283-1a52-1f12201e1836@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 12:43:02PM +0530, Nitin Rawat wrote:
> 
> 
> On 12/8/2023 6:59 PM, Nitin Rawat wrote:
> > 
> > 
> > On 12/8/2023 3:58 PM, Manivannan Sadhasivam wrote:
> > > On Fri, Dec 08, 2023 at 02:55:21PM +0530, Nitin Rawat wrote:
> > > > 
> > > > 
> > > > On 12/8/2023 12:28 PM, Manivannan Sadhasivam wrote:
> > > > > core_reset is optional, so there is no need to warn the user
> > > > > if it is not
> > > > > available.
> > > > > 
> > > > > Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > ---
> > > > >    drivers/ufs/host/ufs-qcom.c | 4 +---
> > > > >    1 file changed, 1 insertion(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> > > > > index dc93b1c5ca74..d474de0739e4 100644
> > > > > --- a/drivers/ufs/host/ufs-qcom.c
> > > > > +++ b/drivers/ufs/host/ufs-qcom.c
> > > > > @@ -296,10 +296,8 @@ static int ufs_qcom_host_reset(struct
> > > > > ufs_hba *hba)
> > > > >        struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> > > > >        bool reenable_intr;
> > > > > -    if (!host->core_reset) {
> > > > > -        dev_warn(hba->dev, "%s: reset control not set\n", __func__);
> > > > > +    if (!host->core_reset)
> > > > >            return 0;
> > > > > -    }
> > > > >        reenable_intr = hba->is_irq_enabled;
> > > > >        disable_irq(hba->irq);
> > > > 
> > > > 
> > > > Hi Mani,
> > > > 
> > > > I think core reset is not frequent. It happen during only probe ,error
> > > > handler.
> > > > 
> > > > core reset is needed in kernel to cleanup UFS phy and controller
> > > > configuration before UFS HLOS operation starts as per HPG.
> > > > 
> > > 
> > > This sounds like core reset is not an optional property but a
> > > required one. I
> > > just checked the upstream DT files for all SoCs, and looks like
> > > pretty much all
> > > of them support core reset.
> > > 
> > > Only MSM8996 doesn't have the reset property, but the reset is
> > > available in GCC.
> > > So we should be able to use it in dtsi.
> > > 
> > > I also skimmed through the HPG and looks like core reset is not
> > > optional. Please
> > > confirm.
> > > 
> > > - Mani
> > 
> > 
> > Hi Mani,
> > 
> > Yes Core_reset is part of HPG sequence and is needed.
> > 
> > Regards,
> > Nitin
> 
> 
> Hi Mani,
> 
> I see this patch series is merged . So planning to keep the warn message
> based on above discussion.
> 

No, you should not add that warning back. As per our discussion, we concluded
that core_reset is not optional, so devm_reset_control_get_exclusive() should be
used to acquire the reset.

If the reset property is not present in DT, then ufs_qcom_init() will fail. This
also means that we should fix the binding and DT of SoCs missing the reset
property.

- Mani

> Regards,
> Nitin
> > 
> > 
> > > 
> > > > Having existing warn print can be used to to debug or atleast know
> > > > core_reset is missed in device tree to give indication complete
> > > > reset hasn't
> > > > been done and we could still be operating in bootloader configuration.
> > > > 
> > > > 
> > > > Regards,
> > > > Nitin
> > > > 
> > > 
> > 

-- 
மணிவண்ணன் சதாசிவம்
