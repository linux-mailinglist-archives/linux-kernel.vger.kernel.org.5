Return-Path: <linux-kernel+bounces-17651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC56F8250A4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EEDF1F22A00
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA7E22F17;
	Fri,  5 Jan 2024 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YaOciSO2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C843922F06
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a28ee72913aso67455066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 01:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704446189; x=1705050989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bJqK2boMhlBPvYPzwyxlpWb4GxEdD9+xMel7BalA1gY=;
        b=YaOciSO2NiWdm8I50YQ8+Ib9BgiuFUS+xROGjl9/Ez29m+ZKMJX/6RCBHdcgY3MFvv
         u/CwDukv5gPArtX2pJJHvhl2tPvu0//T1zruc+MDw0L0lvtBSzCxTF6LD26d2ZE9S2vp
         Wup/fH8PsYWXCOlPexEqnPt3lNM+plxvFUZ7XV3G6gDAsFhMWphylODDrz6GB1lz5F9v
         0waC1oTiJw/Qvu6Pz96OuH6wD8a3sbOhCV8M/UBx2Rf84Y+3TkSp5cNtE63F3qtyzhM/
         sGk68TPEgLjGjwAVLWfIeFPvI9DPVK+f5IitqyT6LnqcIF1U6wK0+lB4UqWcM+czT5J0
         70/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704446189; x=1705050989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJqK2boMhlBPvYPzwyxlpWb4GxEdD9+xMel7BalA1gY=;
        b=jipnQuTj6evHNOAErzuR+0Cl2NFQY2sTj5A42Fxv9D/w3ylbQJ1tDHfjFyDbvfi30h
         5hyaQFNtS7MLhq+W3FthV0bWDM00/u6SdDrUdOiymisu25pbtgKie/+WPTu7Mtx/4zXX
         4yKjE6Bfd3+/Jm6X/yyBw2P/JhDrF38nEUREuzELsqYEDuRZdBCYceKXqJoGYK6igttz
         1fo/8isP3iInsVu/mDaCNBB5TCqXsxtZ8HsUASTx3P5XjE1LtZqVVUIsHxzXFO4eeHi5
         j2TqP9RPdl8zX5HdUfaNLtHfsye2SDE+24FeEFQCsr3dq6Th1aciewwTOm/tEXqwuo1O
         29hw==
X-Gm-Message-State: AOJu0Yxga7Mca1iQt1t3x9fSBa8pbyahOzu8ijiPm3UMIgSKqKPGzvBg
	er7yGeb0L6eyhn2LDV4nt41ioRqH7xwbTmFTWKsC6By3NUk=
X-Google-Smtp-Source: AGHT+IE7Ems0dPZ1o0LW0EtS1iu6PYF+DxBcwjMzLo1TFWzXXKrSUypTKqAr3qn2Lye0u/OuOf1ekA==
X-Received: by 2002:a17:907:b9cc:b0:a28:bc4f:16ff with SMTP id xa12-20020a170907b9cc00b00a28bc4f16ffmr1788363ejc.28.1704446188930;
        Fri, 05 Jan 2024 01:16:28 -0800 (PST)
Received: from linaro.org ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id t8-20020a056402020800b0055712dec5a6sm747448edv.2.2024.01.05.01.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 01:16:28 -0800 (PST)
Date: Fri, 5 Jan 2024 11:16:27 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] phy: qualcomm: eusb2-repeater: Drop the redundant
 zeroing
Message-ID: <ZZfI66Mj6v/Qjp5X@linaro.org>
References: <20240104-phy-qcom-eusb2-repeater-fixes-v1-0-047b7b6b8333@linaro.org>
 <20240104-phy-qcom-eusb2-repeater-fixes-v1-2-047b7b6b8333@linaro.org>
 <33b32e2b-fa35-448c-8b4c-c5c51a514922@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33b32e2b-fa35-448c-8b4c-c5c51a514922@linaro.org>

On 24-01-04 23:50:48, Konrad Dybcio wrote:
> On 4.01.2024 15:52, Abel Vesa wrote:
> > The local init_tlb is already zero initialized, so the entire zeroing loop
> > is useless in this case, since the initial values are copied over anyway,
> > before being written.
> > 
> > Fixes: 99a517a582fc ("phy: qualcomm: phy-qcom-eusb2-repeater: Zero out untouched tuning regs")
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> 
> That's another good spot.. partial struct initialization of
> pm8550b_init_tbl zeroes out the uninitialized fields.
> 
> 
> >  drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c | 10 ----------
> >  1 file changed, 10 deletions(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> > index 5f5862a68b73..3060c0749797 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> > @@ -156,16 +156,6 @@ static int eusb2_repeater_init(struct phy *phy)
> >  
> >  	regmap_field_update_bits(rptr->regs[F_EN_CTL1], EUSB2_RPTR_EN, EUSB2_RPTR_EN);
> >  
> > -	for (i = 0; i < F_NUM_TUNE_FIELDS; i++) {
> > -		if (init_tbl[i]) {
> > -			regmap_field_update_bits(rptr->regs[i], init_tbl[i], init_tbl[i]);
> > -		} else {
> > -			/* Write 0 if there's no value set */
> > -			u32 mask = GENMASK(regfields[i].msb, regfields[i].lsb);
> > -
> > -			regmap_field_update_bits(rptr->regs[i], mask, 0);
> > -		}
> > -	}
> >  	memcpy(init_tbl, rptr->cfg->init_tbl, sizeof(init_tbl));
> 
> I think this patchset can be made even better, this memcpy is also
> useless and we can simply initialize init_tbl=rptr->cfg->init_tbl.

Actually no. The init_tbl in cfg is a pointer to const. Plus, if you do
that, you will end up with the same situation like in the other patch,
as there are some overrides based on DT values below this.

But now that I've had another look, maybe doing the exact same thing as
the other patch does (kmemdup) will probably look better anyway,
specially if we do that on probe.

> 
> Konrad

