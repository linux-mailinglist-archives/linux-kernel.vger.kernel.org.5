Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F097B07D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjI0PNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjI0PM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:12:59 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6692AF5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:12:58 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so13344173a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695827577; x=1696432377; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KPqilKbo3iVCZzaxWPXzKI2JGdBvQ+Njccl8+FkLp0E=;
        b=H0jYtSsBpimfAI2xwWUKfH8Be2fqf/aHM2rHngzspoaYX92IPT2Q6BZXZbrT4Dix9z
         VT1knZoG3BqdjUWHNe18NFjGuuUGpX4fX8rfBA1n/EBAIbIXwpyIxv5ri0/1QJdPRrHV
         cKttv3nK5oBMRUpJEkahQEyl9PlR5x5FWVKOIzo72/RkO2TF44mMNdjESiC5ix6eMwFc
         oOwS2Yy7F8WZ5A7aXqKJE3M5yWjKTVmw1ucl0kJA+R+/PieN2sXNSTYLB2GfJebBqMw9
         lYpFEBcqVBAv/6lnduV6AFMj2hl0F3GL62vIfTpVqGWP55lWYgkQh8RCgh6sveCLin5w
         7yJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695827577; x=1696432377;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KPqilKbo3iVCZzaxWPXzKI2JGdBvQ+Njccl8+FkLp0E=;
        b=hhGYvZIAl/RsG3nqkqB1h/OSndshRugqohY5zDRCzfajbhXLadb0EpXWy/0mVQ0Bzn
         A0MI8oos6CJoGhG2dqrLnWHEEzmcrVhcc0pMwhvr4oAvGVgC6g8zkTNB6DPWDrtwG4Kp
         nRl47XGaR7/vWoNcRJm92TaRAh6P/CYaEhV8/Mpl0BHhvA0q0eLngSQu6zktO6yfvp5D
         HjdgcsxsFFyuKPYIMRDfen0mU/O+RQWeoTVZgSNWL8UnRM12IlTKRaDfB3BObn0cCTw9
         541u/p9tuPiSl1P2f4vdh8egSFBSejFRNNw4XwBhVeugcLtUTGAz+8bGN9qs9GT1DtFC
         Snqg==
X-Gm-Message-State: AOJu0Yx3/Lpyfg1sgboJ59uetdNa6auUSOybQmc/7CZ1ThvVmcIsRLnq
        p0k2IKOGev7ZzN4DJ4PrRXoy
X-Google-Smtp-Source: AGHT+IEHKRtN5scbyD9qCAgNAkTHPtcpUTq3NTqY5Vews8yZUbaQE996en0fYSXTU/OeOh1XmXG0vg==
X-Received: by 2002:a05:6402:150f:b0:531:9c1:8271 with SMTP id f15-20020a056402150f00b0053109c18271mr2402992edw.14.1695827576789;
        Wed, 27 Sep 2023 08:12:56 -0700 (PDT)
Received: from thinkpad ([2a02:2454:9d09:3f00:b024:394e:56d7:d8b4])
        by smtp.gmail.com with ESMTPSA id j7-20020a50ed07000000b00527e7087d5dsm8229484eds.15.2023.09.27.08.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 08:12:56 -0700 (PDT)
Date:   Wed, 27 Sep 2023 17:12:55 +0200
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, andersson@kernel.org,
        bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        abel.vesa@linaro.org
Subject: Re: [PATCH v2] PCI: qcom: Make use of QCOM_PCIE_LINK_SPEED_TO_BW()
 macro for encoding link speed
Message-ID: <20230927151255.GC19623@thinkpad>
References: <20230927145738.115843-1-manivannan.sadhasivam@linaro.org>
 <ea9374d9-34bc-4e9e-aba2-4ca50e5090f2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea9374d9-34bc-4e9e-aba2-4ca50e5090f2@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 05:06:55PM +0200, Konrad Dybcio wrote:
> On 27.09.2023 16:57, Manivannan Sadhasivam wrote:
> > Instead of hardcoding the link speed in MBps, let's make use of the
> > existing QCOM_PCIE_LINK_SPEED_TO_BW() macro that does the encoding of the
> > link speed for us.
> > 
> > This eliminates the need for a switch case in qcom_pcie_icc_update() and
> > also works for future Gen speeds without any code modifications.
> > 
> > Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> > 
> > Changes in v2:
> > 
> > - Switched to QCOM_PCIE_LINK_SPEED_TO_BW() macro as per Bjorn's suggestion
> >   https://lore.kernel.org/linux-pci/20230924160713.217086-1-manivannan.sadhasivam@linaro.org/
> > 
> >  drivers/pci/controller/dwc/pcie-qcom.c | 24 ++++++------------------
> >  1 file changed, 6 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 297442c969b6..dce80d6dc88f 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -148,6 +148,9 @@
> >  
> >  #define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
> >  
> > +#define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
> > +		MBps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]) / BITS_PER_BYTE)
> Mbps_to_icc (lowercase b) is precisely that
> 

lol, yeah. I missed it. Let me fix it and also add a patch for -ep driver as
well.

- Mani

> Konrad

-- 
மணிவண்ணன் சதாசிவம்
