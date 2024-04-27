Return-Path: <linux-kernel+bounces-160852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D51968B438D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 03:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C591282E18
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFE63839D;
	Sat, 27 Apr 2024 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p94PWi38"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378F1381AA
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 01:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714181786; cv=none; b=lhSdLyBbpN7Uq/T0Nxco67QKFGT41hOl4KNr14nGp6v1gZ3r1OK5OGSsDu5J/eg0pD03HiDnlx47Kx+i5LAc3VvK8+j+nVaEJ2IIUyZKLJ2MTYLa+V6s7NwwSaDlhwl11VzPHF5tAr0FtcTy4uKixD9mqboDi05OZ9YVd+gf1Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714181786; c=relaxed/simple;
	bh=RdoQEjsfDLaQLxmZJ7q6grWn9U77AJJaiBSCfDtS9V4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YG4x6xFTSpJOejOXMpcsSUoCRGy07Y2F8TM2lNvDnqzgsiX/ThOcUS+vPJau4ceE7WJhaeMSf1qmAb5RZ6hG6AggF1WclRGCU4KQSpeQZSJHvkSGcI8hFVOHqp61XxYetOnwF2tNqECywC5sMU1Ywz354pyxofLrDfb4JCzCzBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p94PWi38; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61b6200fcb5so29818907b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 18:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714181784; x=1714786584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DNCnVj1Y2/lmMmkRb2EKBZBX4wqTajwlwp5m2yeDx44=;
        b=p94PWi38iBSTEVWR/dHuUERmQQewEYrXNycrqB5V2bLkpu4tDtJfDHtZQxTQHKrqmc
         18Y4oSMelvgYr4obxNFpurT4tmg5aOK5w+5SfM944Md3FbFFGIOgKgahabTtgZN6hU4i
         Uu53Qc8gXTX9bG9dl/7YPrAzuZYnfik+v7aFKetbXhXbUQ+wDVqf6MpUphQ/Vf3xXzxV
         zaJ2YDR0xvgY7MWyZVKguI6RR2lTZuXj7vKihi8XsyNBDaUQOZg2pFw8HekV/ZQDU+np
         yr8q7KL1Evt6CgsHcIESGx4vUXzflilZxR4AOY3HJzIsh9FWIzHVVZzLPiCpAXlIwC3o
         bUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714181784; x=1714786584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DNCnVj1Y2/lmMmkRb2EKBZBX4wqTajwlwp5m2yeDx44=;
        b=l3vBOuNGItnXDUybHPR2Pao4Lj2OwMm3rLD0TrBOoiuoft+bY7uyFPE1G/214LAdla
         FbYBD3PHm827mZkvXnC3WpsDyg9b40lrSxxYQZuP/A3IhU0fGV0EdZnvx2gRM+A+b5au
         JOwSRW2Zm5gNpcVmRYLr4Adu1MYWos6CG5U04QpoA/2/r/4VRUmGme0sVjlOVDPIsqzV
         DBf+VVRbJi/CmqbHbLlizTGoeXEDZ3/rkKHhLxopbDqiLrMZ/4zfcJJqDDWBMMf7ixMh
         nr6SO5G/rbFIxeaduVjYkpW9AAZOa/d9RRTt1LAfD3me+TpEKI8HJeNXPEFvis+sGTLE
         xZnA==
X-Forwarded-Encrypted: i=1; AJvYcCUVH0MfLUVqaEq8tgguxybp3bQeLmjJS+1XDY/WD4Vem9iscNxz/t8xofXozB+qmtHk/mWn1Z79aA2ztWgvUUjru0r7s9EB/DasH9oZ
X-Gm-Message-State: AOJu0YxKl4oPZiegQQ7+aeVI1SHOg6mgVMXTVo87M6mbyV0IzVGaAFfk
	jPvA3D4rQTS3HaG2mAjQm6a5qaFwiC4mxCe1Ko+E7wenCWDcRAY+PtF6qRwdNbzvf2bXQN7RkRd
	UpePxdmDLTlt8cI850pUl2jUhgHYU4xqx7+ABzA==
X-Google-Smtp-Source: AGHT+IFisVSHK3bri2d3dp8z+/w4P0d7YMFifFNKBTl5xkxnQFIHLo94xPnn1vjQbgMSAcY7JL1avzEt2+BlPwPhBn4=
X-Received: by 2002:a05:690c:630d:b0:618:9353:1023 with SMTP id
 ho13-20020a05690c630d00b0061893531023mr5892671ywb.17.1714181784203; Fri, 26
 Apr 2024 18:36:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424-qcom-pd-mapper-v7-0-05f7fc646e0f@linaro.org>
 <20240424-qcom-pd-mapper-v7-6-05f7fc646e0f@linaro.org> <f1ee1fc0-64cb-5610-db92-3a06d477e8b8@quicinc.com>
In-Reply-To: <f1ee1fc0-64cb-5610-db92-3a06d477e8b8@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 27 Apr 2024 04:36:13 +0300
Message-ID: <CAA8EJpoDuKyy2_7Lwih6gLW3UO4sduV6Fun6RSzJg6RHSHgMsQ@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] remoteproc: qcom: enable in-kernel PD mapper
To: Chris Lew <quic_clew@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Sibi Sankar <quic_sibis@quicinc.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>, 
	Xilin Wu <wuxilin123@gmail.com>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Apr 2024 at 04:03, Chris Lew <quic_clew@quicinc.com> wrote:
>
>
>
> On 4/24/2024 2:28 AM, Dmitry Baryshkov wrote:
> > diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> > index 1d24c9b656a8..02d0c626b03b 100644
> > --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> > +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> > @@ -23,6 +23,7 @@
> >   #include <linux/remoteproc.h>
> >   #include <linux/reset.h>
> >   #include <linux/soc/qcom/mdt_loader.h>
> > +#include <linux/soc/qcom/pd_mapper.h>
> >   #include <linux/soc/qcom/smem.h>
> >   #include <linux/soc/qcom/smem_state.h>
> >
> > @@ -375,10 +376,14 @@ static int adsp_start(struct rproc *rproc)
> >       int ret;
> >       unsigned int val;
> >
> > -     ret = qcom_q6v5_prepare(&adsp->q6v5);
> > +     ret = qcom_pdm_get();
> >       if (ret)
> >               return ret;
>
> Would it make sense to try and model this as a rproc subdev? This
> section of the remoteproc code seems to be focused on making specific
> calls to setup and enable hardware resources, where as pd mapper is
> software.
>
> sysmon and ssr are also purely software and they are modeled as subdevs
> in qcom_common. I'm not an expert on remoteproc organization but this
> was just a thought.

Well, the issue is that the pd-mapper is a global, not a per-remoteproc instance

>
> Thanks!
> Chris
>
> >
> > +     ret = qcom_q6v5_prepare(&adsp->q6v5);
> > +     if (ret)
> > +             goto put_pdm;
> > +
> >       ret = adsp_map_carveout(rproc);
> >       if (ret) {
> >               dev_err(adsp->dev, "ADSP smmu mapping failed\n");
> > @@ -446,6 +451,8 @@ static int adsp_start(struct rproc *rproc)
> >       adsp_unmap_carveout(rproc);
> >   disable_irqs:
> >       qcom_q6v5_unprepare(&adsp->q6v5);
> > +put_pdm:
> > +     qcom_pdm_release();
> >
> >       return ret;
> >   }
>


-- 
With best wishes
Dmitry

