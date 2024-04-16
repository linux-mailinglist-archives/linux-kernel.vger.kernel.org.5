Return-Path: <linux-kernel+bounces-146794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9698A6B08
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A341F22176
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2389912BE89;
	Tue, 16 Apr 2024 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X0yYeRTo"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9B585959
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270862; cv=none; b=ps0rDYaWkTdLCN1uaFXeU2a+4uJjRyxblvZtf5llqw6yhEgiEKX0AS8D2QGgz4umKgWuErTiyaKwRpHbQjL/BrO3bzBlyovtcQxKuiM5Xq/GZrO4BP1+QP3Ty5wivZx4Nsf1OJ4pulbRPpqp2DriL8EBfeUBJWA6iuBTLYiGQys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270862; c=relaxed/simple;
	bh=SIpJZv7wDmO6PJvpxTbMmJd4YFOrv5/ZLEYq9V+CZRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nqwCixE7SDK6dGHu6+qdwBJFBlpYXjlQaTJwz4JgjColwz3VqH+nsE+V5XiobVFzKLr0zcCw/A3rE/a+CE3bgy5aokxoTbjjPvMtXrhpJ5M6+D8K7OyV7At450Kp9ql5EhD1ZDTFq4QnmOGY0iHncukV4gDiyAd/6QZLZuCAo6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X0yYeRTo; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so4097246276.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713270860; x=1713875660; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3zwgoQX0Z9a6MDLjvENqiQyvKVaKgnucR/j0TmrXRI=;
        b=X0yYeRToZBa1OHX93ci0omq7hFoxzRuudyCIshesT/qeJvs91GJmwCiSAK2xryzxlJ
         nJbD7L5XSd4LCWz4ESrDWVFVlAWq7Ihl7z+z/KSKcbc3B7LR2YehyeN2x7dR4FYJ8o2x
         DiNAZUuPKyC4Y/gvylTJXzMZpHsuo0cxqZfLU+A7zmQ0smRXGmi3Snd8yj0q+DalMHIP
         TfuuKRY3zQwOUdb4Ut9bb2GJiK9l76+1F5FyZ39E5h7Rprpt831MhqFmH1An4ORquxxC
         G2C4jnwCNoByQv7qISUttxchfSK3uzbwjeUoIY9vl6YJcJu8Ed3Tt/h5efNwKUIAgqUd
         6oNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713270860; x=1713875660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3zwgoQX0Z9a6MDLjvENqiQyvKVaKgnucR/j0TmrXRI=;
        b=RrSMGSaZfzkbfXj5LYxj9fE3WiXKSIKOI8c3fLgHq8k7lVFV8oVlpwRjmFhx+CCA71
         Nt8CWcAXEDvn0eka7KZLzOmZYSlv6ktZ+IDZy5HuJG98XwgWvc6YwMoUVayeGPz3Vgj1
         0kbbvacqt/SSptZF3YyhhLrHAPwfWJR1AxnE3gAYkBqE8gzYeCMp6evlr0GfyXWl1pd4
         kBmbe4Q58Hvpm4xTu7xCJZVKvRG+jFH4htdrfQ+sFskxnMzlflKKmpyqf0Wb8JAqPV1c
         POx3BohvWKgmfDTWqDdWBgSlgGBnuDB3MavRaVjK/VV6PmBbya21LMVSMu4qBFoPqpQf
         Sfcw==
X-Forwarded-Encrypted: i=1; AJvYcCW6zV3ku642kxDvfXXuXEDJxv4sqevjQdYq41bk35ErF5wbkguUO8EigPMiqBSZTSajzEYGM/afdCDzkBBu6sCDzIaJskKONSd84EW9
X-Gm-Message-State: AOJu0YzRHoXFp4GEUovi/jBqiRqtZZoLgFCCcsY9TofL346IF1j9F8jk
	Z4+jsnqZUuZI7hprx6Pgvv29H1ApW4qyrAQ/0NDNHIyoNtvJvUTp+7tTnHvpSAZFdUeq5zc/xeH
	4Euf0+TLYRSpTqxSzgZRJdYzG0ybPuhqxJprzOg==
X-Google-Smtp-Source: AGHT+IEpxf4rbzlE027P2IcXAeu6If/EETmf2GpXASFLnsjOgY7eMXVxG0DJLlGFGtlWUJmR7N0m2U2uKbzDDFB2J5M=
X-Received: by 2002:a25:bc4c:0:b0:dcb:fe58:a08b with SMTP id
 d12-20020a25bc4c000000b00dcbfe58a08bmr11892925ybk.15.1713270860092; Tue, 16
 Apr 2024 05:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416105059.1167-1-quic_vdadhani@quicinc.com> <CAA8EJprzdhDvmZdVXdHEJHpNA_Pj3=77v=y41EajFVe8LmAOnQ@mail.gmail.com>
In-Reply-To: <CAA8EJprzdhDvmZdVXdHEJHpNA_Pj3=77v=y41EajFVe8LmAOnQ@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 16 Apr 2024 15:34:08 +0300
Message-ID: <CAA8EJpob60Kog7ppTO=LZuJgn5Z91dwqyZ845gX8UXwrOqvZjQ@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: qcom: qcm6490-rb3: Enable gpi-dma and qup node
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Apr 2024 at 15:32, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 16 Apr 2024 at 13:51, Viken Dadhaniya <quic_vdadhani@quicinc.com> wrote:
> >
> > Enable gpi-dma0, gpi-dma1 and qupv3_id_1 nodes for
> > busses usecase on RB3 platform.
> >
> > Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
>
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Well, actually:

Unreviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Please place the gpi_dmaN nodes where they belong rather than sticking
them right before the qup nodes. The file should be sorted.

-- 
With best wishes
Dmitry

