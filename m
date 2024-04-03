Return-Path: <linux-kernel+bounces-130470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6E889788F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C3A287F7B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D73B154422;
	Wed,  3 Apr 2024 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qY0j7Zf5"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA39614C5B3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712170141; cv=none; b=lSbXoUH0rBgb9H8E+I1cC+d8C/I71PXHTgIOPUpVyFv1J5pfJoL5QaIRWmF7gC0Osui0pvSbef6+HEzw3qEMTZ6h0jnbx0ErzSH7t78HbUMR+G0JojHbgAUqwwy0+1xnYX5vXgfXalE3RuIlJ99Lu1/00yb3vSh4zQSkefK13p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712170141; c=relaxed/simple;
	bh=jSyWGCN5FPCl2TcLKnjoGU2QBW0WrIMLhGX/DAWbex4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bofKaJvcBZmMeGCESIL41o4kHNDLvXtU2EMnZK+8sU1BqQ6SxAsmOL5TxbXcp/RjX7i8ztYNxP7BMAv/mQhbAYruTeMcSNk3onNOldPe/xLUamz7Rv0xhINYyfskougoG1SIwkoN+ppuoH1SamGUPBvwWYydh59THpvSJZRN4DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qY0j7Zf5; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516c7716c1fso89535e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 11:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712170138; x=1712774938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T4UlKp0+98qrBZkCwolOL0UjNpShY+5uDH6xj75f1ck=;
        b=qY0j7Zf5K95URrKb6w3XmGeRzBf+7cvLsHuNlBAZerS3SsETWxuIxoKJVtvVC6Dqwp
         cnBTPsYRhe6Dch1STplxhKnIpYvz9QLIOoss4usA8XsveWoPV71SfXek5AC5n685EE1C
         5Xkl8h2goey3ee/JitYS3cHCvY1fEx3+qvih49+HOUjD2nzPJfUDEzuucYRvT5lR/EXB
         /OPC8hWr+q1G24DE7YMCM71MQ3AbzYzhdccj9AL0oztvA5F/nHIBF5eGMvrVcXLNU6U6
         +bxW7pe8eLAjXhxmqdAVW3K50qDziPtrsS2nGqC0u5cdhCmCHaZIdQphkcLUSK3FVhCw
         16fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712170138; x=1712774938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4UlKp0+98qrBZkCwolOL0UjNpShY+5uDH6xj75f1ck=;
        b=PQrx2bwSfngfR6DJuYQ/f+/iIZodvYQDhq8g9wU4yNZ9DwGH2du7uG8DbnyadCys/L
         1QuVdiaw72p3xEt9ZfnWyoyHIBS2YAf52dE8gyAWi/cWdF9YSTInG8hDMB2c/XdwDurr
         zJZrHlFpKir9kyfQ5MDq+Wv48PsYrpP1Q4o+6YUnA1ENGTjubmGUnQPCrHlvGrcg+eg+
         T8NN2A5pwGHLzG7M2QTvzL3Es7vUhwvplXUdDso2QH6rNZT4etgiMR56RhY8/8Xoj6hS
         gGuEpLBuoEknqZ5GWBZB7I8pr+FQNpb/X5u/a1U05IK1You8PVdUrb0M8jt0KHfSY/PJ
         bnNg==
X-Forwarded-Encrypted: i=1; AJvYcCUqp4HoDRN1fQxCJjgSPkVK4CdjTGJ+uIXBusI0kzhfIuWAH3/NBJ3F5vl9xDe+/Bme/jqAcu6nPOwhgkjeFy83A7lV6ZECoX+wPth2
X-Gm-Message-State: AOJu0YzBnwVuVkcAZ2V3YNk/djCG4h/FrtGmunKbZpQPP1cXDrt/sLIn
	TpH7V8jimJqawgbPHTv/7na+kq5Dn1YLCpn0w+iPrOhJviih+jfRmU2wcDZlpG0=
X-Google-Smtp-Source: AGHT+IGZxvocFB/k0J1XWTW3eUyufirz8K/RKSIbDf1a05LsDIVRxq4ve4g34j9XhmrysecJIF9Tkg==
X-Received: by 2002:a05:6512:34ce:b0:516:a2fc:9099 with SMTP id w14-20020a05651234ce00b00516a2fc9099mr198845lfr.60.1712170138090;
        Wed, 03 Apr 2024 11:48:58 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzyjmhyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a00e:a300::227])
        by smtp.gmail.com with ESMTPSA id j21-20020a19f515000000b00513cb11cd66sm2069424lfb.219.2024.04.03.11.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 11:48:57 -0700 (PDT)
Date: Wed, 3 Apr 2024 21:48:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: dri-devel@lists.freedesktop.org, robdclark@gmail.com, sean@poorly.run, 
	swboyd@chromium.org, dianders@chromium.org, vkoul@kernel.org, daniel@ffwll.ch, 
	airlied@gmail.com, agross@kernel.org, abel.vesa@linaro.org, andersson@kernel.org, 
	quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com, 
	marijn.suijten@somainline.org, freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] phy/qcom-qmp-combo: propagate correct return value at
 phy_power_on()
Message-ID: <oqqpypb7qkcjrztjpqkkqlg6m55fm6hjhts7plytr27hrdmvcp@og7gwdajvsje>
References: <1711741835-10044-1-git-send-email-quic_khsieh@quicinc.com>
 <23f591d7-a5d6-c5d1-9ba1-1584e32e5164@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23f591d7-a5d6-c5d1-9ba1-1584e32e5164@quicinc.com>

On Wed, Apr 03, 2024 at 10:22:37AM -0700, Kuogee Hsieh wrote:
> Dmitry,
> 
> Any more comments?
> 
> On 3/29/2024 12:50 PM, Kuogee Hsieh wrote:
> > Currently qmp_combo_dp_power_on() always return 0 in regardless of
> > return value of cfg->configure_dp_phy(). This patch propagate
> > return value of cfg->configure_dp_phy() all the way back to caller.
> > 
> > Changes in V3:
> > -- add v2 changes log
> > 
> > Changes in V2:
> > -- add Fixes tag
> > -- add dev_err() to qmp_v3_configure_dp_phy()
> > -- add dev_err() to qmp_v4_configure_dp_phy()
> > 
> > Fixes: 52e013d0bffa ("phy: qcom-qmp: Add support for DP in USB3+DP combo phy")
> > Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> > Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > ---
> >   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 13 +++++++++----
> >   1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > index 36632fa..513d99d 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > @@ -2343,8 +2343,10 @@ static int qmp_v3_configure_dp_phy(struct qmp_combo *qmp)
> >   	writel(0x05, qmp->dp_dp_phy + QSERDES_V3_DP_PHY_TX2_TX3_LANE_CTL);
> >   	ret = qmp_combo_configure_dp_clocks(qmp);
> > -	if (ret)
> > +	if (ret) {
> > +		dev_err(qmp->dev, "dp phy configure failed, err=%d\n", ret);
> >   		return ret;
> > +	}

dev_err() calls are not related to the fix itself. Please split them to
a separate patch.

> >   	writel(0x04, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG2);
> >   	writel(0x01, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
> > @@ -2519,8 +2521,10 @@ static int qmp_v4_configure_dp_phy(struct qmp_combo *qmp)
> >   	int ret;
> >   	ret = qmp_v456_configure_dp_phy(qmp);
> > -	if (ret < 0)
> > +	if (ret < 0) {
> > +		dev_err(qmp->dev, "dp phy configure failed, err=%d\n", ret);
> >   		return ret;
> > +	}
> >   	/*
> >   	 * At least for 7nm DP PHY this has to be done after enabling link
> > @@ -2754,6 +2758,7 @@ static int qmp_combo_dp_power_on(struct phy *phy)
> >   	const struct qmp_phy_cfg *cfg = qmp->cfg;
> >   	void __iomem *tx = qmp->dp_tx;
> >   	void __iomem *tx2 = qmp->dp_tx2;
> > +	int ret;
> >   	mutex_lock(&qmp->phy_mutex);
> > @@ -2766,11 +2771,11 @@ static int qmp_combo_dp_power_on(struct phy *phy)
> >   	cfg->configure_dp_tx(qmp);
> >   	/* Configure link rate, swing, etc. */
> > -	cfg->configure_dp_phy(qmp);
> > +	ret = cfg->configure_dp_phy(qmp);
> >   	mutex_unlock(&qmp->phy_mutex);
> > -	return 0;
> > +	return ret;
> >   }
> >   static int qmp_combo_dp_power_off(struct phy *phy)

-- 
With best wishes
Dmitry

