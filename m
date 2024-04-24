Return-Path: <linux-kernel+bounces-156890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C968B09F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317C2284522
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C6415ADA5;
	Wed, 24 Apr 2024 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LcPtxt4b"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5669515686E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713962812; cv=none; b=W1sstgrkVXjRZ4hKI/1F+Wk/3mb9jA4OHq2PVZUPx5oR+Y/4TcJVBhxhLD2J0iyM3rL/+CHz2yflDUZJxf2wyqqlEb34hxK2G9PXnPGUd9sKxd6m/KzT/WwgSSG87NxoFyRZaNLQzfvLTF8s4TJVm8ACwo2XYnsQevP9A/AEKA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713962812; c=relaxed/simple;
	bh=zM8sR5orAuQQ4cxTB/D5fYnLFqtLGuq1kFg7hhQqLsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxPiErMAmEgXw5nl6XDZwtTRO4SwkRuUd/dN21Fq/01SZQ7sZ2Z+h0+ARTNJ5bapMLlJwsyg1e7Er0kzb7CEG0fQNezqTNvIFHBgAq+6itTynB2uJvplNQ0+NW9vhLU6QbdoyHGVL2SwdaVXen/IiMboYvCXs4GZAROrOyoLSRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LcPtxt4b; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-de45385a1b4so6329771276.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713962810; x=1714567610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KrXYASI9NEzYia3x8Ig4KvMmkyEG5SofFlBDhZ//oC8=;
        b=LcPtxt4b33cYrPdx3CIRXpjdXWUjT78C/PjdeLpiug8UCKPqIcdOglPHsuV2YUjPW8
         Te903LSzQJTSD7uT2dzNn+lg85EWU30gaisyDnj2/VT6X1cYs6vUxS2KsbmkKpomi7gS
         c3i5tc79qyT0leqS+pCkNo1/R5MONVFi2uHKXBCXWWbWrytKXXU14Nz+3cbaZlvfZmNh
         fBtechV7fjRD+923uahXi878ASAjkgjG+MwM/6vJNT1CdCgSwWHY+3mRBqDMTAF03xpp
         eM5Ray9mAHJKT65WMoA1XrMZl0277+JOP1FoIku36mcb6QK1nvwAcAgbRVWIoZWzeiES
         GQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713962810; x=1714567610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KrXYASI9NEzYia3x8Ig4KvMmkyEG5SofFlBDhZ//oC8=;
        b=mX1CRgx3ODFVZkj2K1TwjS/REQ3+utTQhzQaXb4ccMTNvO495UFIWtD4jSHzm5mrtI
         P/3B4JX/qsHlQjkxorIEnv+F/LeZ7vzNFxPWGdDXMI7WyNwxWVDsPD6McSQdHJeHqxBE
         2modwl4qUb9iOwrvhW/rZXyewYbXVeX3Mb8zm2Y7w+hm8sU6ofyzQc8KeFRywUDNsmoh
         nWmwBE/4IX33zAR548Nuv79tfUN7q9wHC42q6tCVroEsLrUZb3nH7UZbMGRWntPkZoeT
         boo44Ihg6/CQf9x6pEbVJvUoSdZbp14xFyCWVZjGEHJAuler5Ufmz5eca0Rbuu67CaWh
         G5Pw==
X-Forwarded-Encrypted: i=1; AJvYcCX+e697NlTg/43bquN+cZpqCtTnsExqsVoQUKajV7yzZP5vo9XH4O5DKW9tm89Qf6DFPt3hRH2pgEXf8IXraFdxKuo/NMUmJptnOa6u
X-Gm-Message-State: AOJu0YzVxAnLcYQn5rhrmv/oiAykfAJTtRoqkKGiTiTohlcnpohEPZMo
	OjQWT5Rqr3+GYx4z9EBr9dxT/5Jh/7JuBkEKfaS9yYPhVA13zoi6C+pBAw3fHBOocyvd8RxRWBo
	UeGzvpyZAm4TqUTDb77K2sqZbOw3HL5VnseBg0op+VMAqafb3
X-Google-Smtp-Source: AGHT+IEx71tun5t5E76UunWIPX06WRdVSlCvojyV6lcnuKs5nx7eNpkieeUAZ+aH8KQvmyHUlsLHPhwiU8grk8etkRM=
X-Received: by 2002:a25:838c:0:b0:dce:1285:e9a5 with SMTP id
 t12-20020a25838c000000b00dce1285e9a5mr2494534ybk.11.1713962810353; Wed, 24
 Apr 2024 05:46:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-typec-fix-sm8250-v3-0-604dce3ad103@linaro.org>
 <20240401-typec-fix-sm8250-v3-8-604dce3ad103@linaro.org> <d57ab72d-2604-4115-9973-1ce0f24b159f@linaro.org>
In-Reply-To: <d57ab72d-2604-4115-9973-1ce0f24b159f@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 24 Apr 2024 15:46:39 +0300
Message-ID: <CAA8EJprdLB3+30wvVZjpC5pWKUzgw+Mg54YkN3SvU-Ovc25Qpg@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] arm64: dts: qcom: x1e80100: describe USB signals properly
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luca Weiss <luca.weiss@fairphone.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 17:41, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 1.04.2024 10:33 PM, Dmitry Baryshkov wrote:
> > Follow example of other platforms. Rename HS graph nodes to contain
> > 'dwc3_hs' and link SS lanes from DWC3 controllers to QMP PHYs.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 149 +++++++++++++++++++++++++++++++--
> >  1 file changed, 141 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > index f5a3b39ae70e..3213eccc3a3a 100644
> > --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > @@ -2543,6 +2543,33 @@ usb_1_ss0_qmpphy: phy@fd5000 {
> >                       #phy-cells = <1>;
> >
> >                       status = "disabled";
> > +
> > +                     ports {
> > +                             #address-cells = <1>;
> > +                             #size-cells = <0>;
> > +
> > +                             port@0 {
> > +                                     reg = <0>;
> > +
> > +                                     usb_1_ss0_qmpphy_out: endpoint {
> > +                                     };
> > +                             };
> > +
> > +                             port@1 {
> > +                                     reg = <1>;
> > +
> > +                                     usb_1_ss0_qmpphy_usb_ss_in: endpoint {
> > +                                             remote-endpoint = <&usb_1_ss0_dwc3_ss>;
> > +                                     };
> > +                             };
> > +
> > +                             port@2 {
> > +                                     reg = <2>;
> > +
> > +                                     usb_1_ss0_qmpphy_dp_in: endpoint {
>
> This is more than just DP AFAIU, please call it SBU

This is not the SBU lane. This is for the SS signals. We are not fully
modelling the SBU signals yet anyway.

-- 
With best wishes
Dmitry

