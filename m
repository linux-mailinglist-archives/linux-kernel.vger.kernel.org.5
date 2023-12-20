Return-Path: <linux-kernel+bounces-6885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22516819EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E27283C24
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9B322309;
	Wed, 20 Dec 2023 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KLJv+nzU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1452322305
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dbdafda6155so274155276.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703074744; x=1703679544; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w/+S3CatHi5Kw//IHLmWeXUyqN2Rn4Tvi8JvkLwf5mk=;
        b=KLJv+nzUbXKz9P0Wpc/l4mAkXtO38DqZ7WyvF7PRdKNzJEhd4ObXZ8ePxIk9Z/k5TX
         UuYIt/7bl21lh9ZMDGfg50AMUX1eDYqs3wGnOAhf8N0TbKj70W5xjCUw1QGBeIbtbpvZ
         hGKmadokndWnLyGYHfmwk2jUC/GPhIbp7siKsUFbhpWeP7c+ld0JFTZN9KIuMkuIWtXL
         o5iOv04CMFZ+mXW+UhamUjboT6tvme2j1+rsp4liwiIrQqHNGF34MDxU5xq7e2D08wJc
         RPxERYMB3evn/WPvmqNKz+Hby/Zz3br5e1L7lHxEz09rfYdvZ8+IFceY7geoQjFoAcHc
         0MkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703074744; x=1703679544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w/+S3CatHi5Kw//IHLmWeXUyqN2Rn4Tvi8JvkLwf5mk=;
        b=EJwkKQ3Trf2EWH7n5pttUUd4uXDH6LunqqJeHHhYZrMxC1Bg7vRKi4NGWLtCEGdv3h
         Eea9iWRFPJdgR3iNnSjQQh2waofTFojSqeZyF8nC9CbELYHRPYdEuellOav5rTf+wXDu
         T2vw4whwqzSGOugUQq3Ck5gr5Je2DoAthccETFzRYPLioyHl7/rI9WZL4seGlexOaKUP
         O7LjLv60r6J25/2lfzErjqGZlIib1bzQrVeVdqDFcO7mODTvEu9fB6Sj+pJTyWQR6elp
         0qX19SoB9yyQRyLesiIRJoOTTRUwU28cfqM/ES7Y5QLtH9O95QmUp2jC/j/ID3pxep2+
         AatA==
X-Gm-Message-State: AOJu0Yx9z5PB0zDUVyVXDEiHImG368iDR+4HKnlXwSsmui/QOhheysSM
	mQ1Qto8Rtn6VorNWd4HydcHcVDqd+GWC1lbyzh7Qug==
X-Google-Smtp-Source: AGHT+IHHtyfQCE9ih/hFgxwfXxwDyxIFjkde786DLH/6grBfY+WT57ZCbK+Y+xcwntcKXPe3H1WQwWALEFuJaXNdxyA=
X-Received: by 2002:a25:d717:0:b0:dbd:7143:62fe with SMTP id
 o23-20020a25d717000000b00dbd714362femr1325476ybg.53.1703074744075; Wed, 20
 Dec 2023 04:19:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220114225.26567-1-quic_kbajaj@quicinc.com>
 <20231220114225.26567-2-quic_kbajaj@quicinc.com> <d7ae374a-7269-4992-ad44-18b2516cad42@linaro.org>
In-Reply-To: <d7ae374a-7269-4992-ad44-18b2516cad42@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 20 Dec 2023 14:18:53 +0200
Message-ID: <CAA8EJppYuXpqKpTcUda1LBFfBmm40-VpC+3heJqoL82kS=+erA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: qcm6490-idp: Enable various remoteprocs
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Komal Bajaj <quic_kbajaj@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Dec 2023 at 13:46, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/12/2023 12:42, Komal Bajaj wrote:
> > Enable the ADSP, CDSP, MPSS and WPSS that are found on the SoC.
> >
> > Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> > index 03e97e27d16d..ad78efa9197d 100644
> > --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> > +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> > @@ -419,6 +419,26 @@ &qupv3_id_0 {
> >       status = "okay";
> >  };
> >
> > +&remoteproc_adsp {
> > +     firmware-name = "qcom/qcm6490/adsp.mdt";
>
> Why MDT not MBN?

I agree here. NAK until this is .mbn. Please follow the example of
other boards when you write patches.

>
> I don't see these files in linux-firmware and your cover letter did not
> explain anything around their submission. What's the status on that part?

This isn't usually required, is it? I mean, the firmware can come from
linux-firmware, from the device partition or in any other way. With
the FW_LOADER_USER_HELPER this becomes just the key string used to
identify firmware to be loaded.

-- 
With best wishes
Dmitry

