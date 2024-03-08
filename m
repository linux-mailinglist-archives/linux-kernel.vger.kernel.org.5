Return-Path: <linux-kernel+bounces-97535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B17F876B98
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178A41F21D95
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E64F5C911;
	Fri,  8 Mar 2024 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sD8g9OJb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6379B5A4C0;
	Fri,  8 Mar 2024 20:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709928650; cv=none; b=uS/5reTb6WUQPlnT94ylxxZX+/VDGfyrT+fdu06pTgBTK7Aik6XdUqKlg9k4erEnlHrBbnHhfNaVy6LC4RVYpD/G9ssDSU+scA5U1YD65wVfdtKdFKF0eCQwQWsG1HlKpihErJ7/ix9wTIL6br+HH44J9YoYR3fwybQbe5XQOk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709928650; c=relaxed/simple;
	bh=PZVgPEVnPibB3udRRQb2fiWedaeAN/jFnvY74waSR2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/Xf/2vsYjfL8P/hrEcH64m8BgYijd4U4WZ461L8a6TBv5ANSRhjdBbxq1m5hYOPbDq4OskjySqn551pbuBE9PgduqIgYTeBmv7Rtv4UsDB/ipvO1JEHqKBDI8l9xYg5By0ffso+0FaU8kPAfVwZgBfcRBej4XUKp/euhyccMJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sD8g9OJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3B0C43390;
	Fri,  8 Mar 2024 20:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709928650;
	bh=PZVgPEVnPibB3udRRQb2fiWedaeAN/jFnvY74waSR2Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sD8g9OJb0uduVzJrCg1WxxYd6iC04lPsfL5u/XzSN/JKjsNkzHo/G+S216e+tPAhW
	 1PLj1CYPyL0vp1ypTEM7CVmbbwSvTd6jgoW1XVHuovXcU4gUdvrQ5qSqtW2Ebavrfu
	 F9YFB4SJIbukMj0nffZbQ3GYwy2y+6h6rem32GEEAdw/n/EzHrda51vTfSHvGjybUT
	 +xHdfMtHBwNd3QZ0LenFd7LaMPyddoEbvcxCaRW7rtM5QHYJJ8Bawn//KVBW57KZ+s
	 MH3j815yziTuQMLdQj3QIDR90LrJ3U744K+aByvJLVD65M2JmOecU20TRoYCEgLh+i
	 pf5yB9J13usEQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5132181d54bso3429002e87.3;
        Fri, 08 Mar 2024 12:10:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUhvUW2kHWpuk/NIWzLI/quvQdbmxtC6fXyPkqVxCi88Jp4sTRY3aSmq/g6ytj1aEJAAl2kLche1FSEAzRySv1PfbOMf4BC+KpIVXSnliRbauay0GRkYCEDFNDtvAq5ZosZwLvOObGaJeByVXXoPFsLjiPH34ey/PzGWA9zYnhhw7dCWKbrziH8gQQYUVBad3fL4MmZjF1exPcP7KceFUnlwR03
X-Gm-Message-State: AOJu0YxlNtqLsOvVzTZi9qWwIrvO3HXmvw1yiMfz9THVzUDZf05YRLKh
	OyVcux/CnrYxaMDEfzsDbeNcVYYxbjDbOlXe94ZTa075k8QsOeyDr5wiPMu4KOYT9Kd+PRMI+a3
	tN5MJo2yWFQK2/SaQOhUvyvYUdw==
X-Google-Smtp-Source: AGHT+IHAlLu/YgXf9fgnCBXu/eXkitN0v2K3z4NJB2t5YlJpkUAop+Nej7MeSM40gzvNH6KIBfT4WJXOaeBNELitY6o=
X-Received: by 2002:a05:6512:ba3:b0:513:2114:b70c with SMTP id
 b35-20020a0565120ba300b005132114b70cmr82452lfv.69.1709928648132; Fri, 08 Mar
 2024 12:10:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129092512.23602-1-quic_tengfan@quicinc.com>
 <20240129092512.23602-2-quic_tengfan@quicinc.com> <CAL_JsqJfsWaj9OPkvc34rBvx7W_3v9+1kZqNu6QKDsA=iWAA4w@mail.gmail.com>
In-Reply-To: <CAL_JsqJfsWaj9OPkvc34rBvx7W_3v9+1kZqNu6QKDsA=iWAA4w@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 8 Mar 2024 14:10:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLbbRFijBXS5CyRm0P4FMY7bR3UUdgXA7xP4Z1oRevnzQ@mail.gmail.com>
Message-ID: <CAL_JsqLbbRFijBXS5CyRm0P4FMY7bR3UUdgXA7xP4Z1oRevnzQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: update compatible name
 for match with driver
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, linus.walleij@linaro.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 7:37=E2=80=AFAM Rob Herring <robh+dt@kernel.org> wr=
ote:
>
> On Mon, Jan 29, 2024 at 3:25=E2=80=AFAM Tengfei Fan <quic_tengfan@quicinc=
com> wrote:
> >
> > Use compatible name "qcom,sm4450-tlmm" instead of "qcom,sm4450-pinctrl"
> > to match the compatible name in sm4450 pinctrl driver.
> >
> > Fixes: 7bf8b78f86db ("dt-bindings: pinctrl: qcom: Add SM4450 pinctrl")
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> > ---
> >  Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm=
yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
> > index bb08ca5a1509..bb675c8ec220 100644
> > --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
> > +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
> > @@ -17,7 +17,7 @@ allOf:
> >
> >  properties:
> >    compatible:
> > -    const: qcom,sm4450-pinctrl
> > +    const: qcom,sm4450-tlmm
>
> I think you forgot to update the example:
>
> Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.example.dtb:
> /example-0/pinctrl@f100000: failed to match any schema with
> compatible: ['qcom,sm4450-tlmm']

Still a warning in linux-next. Please send a fix.

Rob

