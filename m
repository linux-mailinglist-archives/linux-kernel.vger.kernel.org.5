Return-Path: <linux-kernel+bounces-23077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9D482A762
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDBC2280EED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA96F257C;
	Thu, 11 Jan 2024 06:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VlrpjuF9"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D3C2105
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 06:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ebca94cf74so48584827b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 22:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704952964; x=1705557764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySHzwq8dArh41wbtGZhqWN/9T6QDBMF2vzUl/zhZMLY=;
        b=VlrpjuF9C+0pSL5uLMEvF8hdxOsqh2OYykReh1PdTPyvEyI/biagq1lrv+znS0wxrm
         KUv/tTLK+wMXS7OLintc++m+RyKnVZGgqtnzwfEBYV/MgcSStVlWbHdL6TDUc2QvdFW3
         44KcDx1DnAc9uwcc6GNkAc7fu3wXj2hezeRyTI/wpZ8CjnqAj/HCrjtZlESqvAkK0j4B
         HHeIOEQfQYXe82uJWgifrUKpL4MqaRxRexDu53tpdxDLkqUFz+drNqcnzoEEdkiirXep
         qFhxnKk5tDvS5cGz1iUykv767cdX7UfpM2WHJ8mvj8LZjNbkb9uhHPnRP1PoaEjD3jQ2
         8Xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704952964; x=1705557764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySHzwq8dArh41wbtGZhqWN/9T6QDBMF2vzUl/zhZMLY=;
        b=JV9OJqK/AJKMPykvq1YU2fqZbC7wFNRn4wtVu16dGKNTKRGAMJ5ci0ZiELG2UdZmvR
         iLV/XRmckMgkmxrAO/4B1Z95e9exGPCuGih9p90Dkm6msMltEbDSU+h3zMw36c/ts03A
         H8DDY/r7Uqa7JEoJOPdC3Q9TPRsvK0wnPPnSzkeeMLoiYgbhFz09CeTVCIzmsiwVwa1H
         xoJrnFy9L7Qfj2IS4mx+ecLmvdTRehIC24EU+u3pKvrbxTB7SeZd3XJg02U/3p7ers/T
         iDSRJxiK/x7UZPDMvZuVGXeAu1kOXiSnutTlQFkHiD4N/WmqtAh/2kFkh8H/y54uwA3E
         JZ7w==
X-Gm-Message-State: AOJu0YxCY4cv94e5zsizIrOpTPhRyexsCKxsKNy32APu2St+6UT2KCxD
	FIwCWx5Xpbou197uxtEpuzpR8qbFBK/BsG4EuDFrLFXAECLktg==
X-Google-Smtp-Source: AGHT+IGuDiBtMY4/ypDlMkdqA3oJpXB3cTMlLMCSTpowgDMc7JMkgVnsbEwMIUUhX9GileAo0dWmq0OxUBnadUBxYgY=
X-Received: by 2002:a0d:e28c:0:b0:5f8:f213:a4e0 with SMTP id
 l134-20020a0de28c000000b005f8f213a4e0mr121140ywe.41.1704952963981; Wed, 10
 Jan 2024 22:02:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111-qrb2210-rb1-no-cluster-idle-v1-1-cec14ec15b02@linaro.org>
 <20240111044508.GA3761@thinkpad>
In-Reply-To: <20240111044508.GA3761@thinkpad>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 11 Jan 2024 08:02:32 +0200
Message-ID: <CAA8EJpp+i58Z_QN4L1NRXoEcoRJNNu3S3JqeYgFP7LY-GBDP0w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: qrb2210-rb1: disable cluster power domains
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Jan 2024 at 06:45, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Thu, Jan 11, 2024 at 04:01:14AM +0200, Dmitry Baryshkov wrote:
> > If cluster domain idle state is enabled on the RB1, the board becomes
> > significantly less responsive. Under certain circumstances (if some of
> > the devices are disabled in kernel config) the board can even lock up.
> >
> > It seems this is caused by the MPM not being pinged during CPU idle (in
> > the same way the RPMh is pinged when cluster idle is entered).
> >
>
> What does "ping" mean here? Please be more specific.

See rpmh_rsc_pd_callback(), rpmh_flush() and rpmh_rsc_write_next_wakeup().

RPMh driver (among other things) on entering the idle writes the next
wake up time to the RPMh. The MPM driver in the vendor kernel does the
same, see msm_mpm_timer_write() in msm-4.19

>
> - Mani
>
> > Disable cluster domain idle for the RB1 board until MPM driver is fixed
> > to cooperate with the CPU idle states.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot=
/dts/qcom/qrb2210-rb1.dts
> > index aa53b6af6d9c..9a0308ef8b0f 100644
> > --- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> > +++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> > @@ -177,6 +177,24 @@ vph_pwr: regulator-vph-pwr {
> >       };
> >  };
> >
> > +&CPU_PD0 {
> > +     /delete-property/ power-domains;
> > +};
> > +
> > +&CPU_PD1 {
> > +     /delete-property/ power-domains;
> > +};
> > +
> > +&CPU_PD2 {
> > +     /delete-property/ power-domains;
> > +};
> > +
> > +&CPU_PD3 {
> > +     /delete-property/ power-domains;
> > +};
> > +
> > +/delete-node/ &CLUSTER_PD;
> > +
> >  &gpi_dma0 {
> >       status =3D "okay";
> >  };
> >
> > ---
> > base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
> > change-id: 20240111-qrb2210-rb1-no-cluster-idle-7bf43b3a0452
> >
> > Best regards,
> > --
> > Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D



--=20
With best wishes
Dmitry

