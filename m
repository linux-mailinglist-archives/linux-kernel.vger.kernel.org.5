Return-Path: <linux-kernel+bounces-123780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C92890DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23151F27A90
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581E12C19D;
	Thu, 28 Mar 2024 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K9BSxo05"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123881D68F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 22:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711665379; cv=none; b=FpoS/pp/RBYi87lFt7yIz7O4ml6OQoWuwXCEtGUU5DFQSVFIzn7Bp59TcYzlK3CMTmc/NX+EZ5unzV32Huu7oeaS/wpTjN5aBwHjnHH+i2oRqWYJrF2porZ2ihu6bIFgbXl4f5sjukPJMgb6YHWAQ+B3t7fyF5pEGi7o4J4lmcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711665379; c=relaxed/simple;
	bh=DyXMPntpHzTM8gI5S4nIpWoHbAT9e7zLas+AdBIkAVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PL28dbwzuvSvRfm+/qvM2znjSlirY3zSR3CmOIImvvDTrFC6NqLAisPM+5c0A+dY7ScvZKJ2ApohNptDybBwg5JdPnnbXmkHhCW7a1jDdgmsw6A5z4h/k/RhLSmLkeWXoHI3WsVkEu4hg2AJsengJEwOzRHOPypGjwMOa0s6Ceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K9BSxo05; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc74435c428so1527987276.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711665377; x=1712270177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LjY+wgOUFRoXu57CnEBA1CkVg+Yjx2wYh83Heq0qxKg=;
        b=K9BSxo05EwMlWixUhBUNSqQmHk5Vojr2loqHQi4pHNw0Ig6ZAz+k22xIbN79g/8bWW
         uRGTROIpkGu0ywMRdUbPJGCzFVQYHyJx3wyezBJG3mFxsF+uBNvekrGN662L56frIUOd
         jyp8qcAjKRDoSZHGzCB4Gb7GKn0CH0hszQGJr01HDZ/D5gFwuJc+DrSybP8xTmpejCZU
         aR+AyMc6SK6NS7vS54cZzokfZGgvGPR9b6Li4GUQHrGzLY0TI+cdG68VLmnhmdWmae8p
         9UeGfiuURjLANYIdS5liHV9em0GnGyb5eUK0QeaLGDfYHmHZHFk3vZHMAuMQbLUpheUh
         3Ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711665377; x=1712270177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LjY+wgOUFRoXu57CnEBA1CkVg+Yjx2wYh83Heq0qxKg=;
        b=QfxbEKdcB7cXml81Bnt2xD1kLe1OI6ISZ5RujpKXhtQHIqcGWulL2Tp469d0ktSijA
         WRP9l3u73zYUFamxVeiSF+ss/kKkd8huE2Ln4+VlIXQQVBH+WhI7jmo7y1ogdPtl5K4E
         w+xPu7UiEDIFajARaeCbgs0rLTTK7IV9+U7Na5o2/TMImvOGSb2Kt0oc/tBWsH+w3DLN
         S4CQMy2X7QyouqQY7muE/QHqDrAfWnyxqwJO0p1baD985QgLL5Xj+IsUrAdmbNIKUH2J
         Hg8oV28TbWH+Sr5uOThIme7fqLwU18KvI4OCek3gyezm0WY8RMhVBpEVJ9kdvfRvCYPR
         HBQA==
X-Forwarded-Encrypted: i=1; AJvYcCVnhat7ObKEpphzYVKiuTIOeiBn7JwcfS5dt/QJexLFhiz63Pb416507rGzcuawqaKHwozS5WTF0rAy4YMpx6ky8FYSsrK1Fy7wsInY
X-Gm-Message-State: AOJu0YzbRVNiOMtxirsIGPy7+BjSgr+6b7VxTEnF5l7Wk7yGBes7CpjP
	7c0VlC9FIcWZs+Wa0IkJYefOFmK4GgYmp3SnDKjlDUDOopnku964mg+cvI12ZRY7meS/xL0L7Sa
	MGBei5Ji59Jj72o410sYZ2y5pU+Cae+Z6micRFg==
X-Google-Smtp-Source: AGHT+IHaI+kjiLOUYNKBR/srDk7VFG1X/iL9Lyrl5XxlS/w0akawROX6LC6YYP28982DF251YeuCQALSFyoyvb3mAX4=
X-Received: by 2002:a5b:183:0:b0:dcd:24b6:1ae7 with SMTP id
 r3-20020a5b0183000000b00dcd24b61ae7mr643047ybl.63.1711665377097; Thu, 28 Mar
 2024 15:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1711660035-9656-1-git-send-email-quic_khsieh@quicinc.com> <6641b5c9-1685-3d90-ac15-0b2e9d546bc5@quicinc.com>
In-Reply-To: <6641b5c9-1685-3d90-ac15-0b2e9d546bc5@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 29 Mar 2024 00:36:06 +0200
Message-ID: <CAA8EJpoXgtodevy_AHGRR8o3yB08dK1oeHdWUrnx13rsYgY=Dg@mail.gmail.com>
Subject: Re: [PATCH v1] phy/qcom-qmp-combo: propagate correct return value at phy_power_on()
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>, dri-devel@lists.freedesktop.org, 
	robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org, 
	dianders@chromium.org, vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com, 
	agross@kernel.org, abel.vesa@linaro.org, andersson@kernel.org, 
	quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com, 
	marijn.suijten@somainline.org, freedreno@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Mar 2024 at 23:36, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 3/28/2024 2:07 PM, Kuogee Hsieh wrote:
> > Currently qmp_combo_dp_power_on() always return 0 in regardless of
> > return value of cfg->configure_dp_phy(). This patch propagate
> > return value of cfg->configure_dp_phy() all the way back to caller.
> >
>
> This is good. But I am also thinking if we should add some prints in
> this driver like it doesnt even tell where it failed like here
>
>
>          ret = qmp_v456_configure_dp_phy(qmp);
>          if (ret < 0)
>                  return ret;
>
> > Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> > ---
> >   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
>
> Also, I think we should have
>
> Fixes: 94a407cc17a4 ("phy: qcom-qmp: create copies of QMP PHY driver")
>
> If there is a better fixes tag for this, please let me know.

Fixes: 52e013d0bffa ("phy: qcom-qmp: Add support for DP in USB3+DP combo phy")

Otherwise LGTM

>
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > index 36632fa..884973a 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > @@ -2754,6 +2754,7 @@ static int qmp_combo_dp_power_on(struct phy *phy)
> >       const struct qmp_phy_cfg *cfg = qmp->cfg;
> >       void __iomem *tx = qmp->dp_tx;
> >       void __iomem *tx2 = qmp->dp_tx2;
> > +     int ret = 0;
> >
> >       mutex_lock(&qmp->phy_mutex);
> >
> > @@ -2766,11 +2767,11 @@ static int qmp_combo_dp_power_on(struct phy *phy)
> >       cfg->configure_dp_tx(qmp);
> >
> >       /* Configure link rate, swing, etc. */
> > -     cfg->configure_dp_phy(qmp);
> > +     ret = cfg->configure_dp_phy(qmp);
> >
> >       mutex_unlock(&qmp->phy_mutex);
> >
> > -     return 0;
> > +     return ret;
> >   }
> >
> >   static int qmp_combo_dp_power_off(struct phy *phy)



-- 
With best wishes
Dmitry

