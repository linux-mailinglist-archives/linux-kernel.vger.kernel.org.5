Return-Path: <linux-kernel+bounces-146707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 978DF8A699E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE4A28140E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47127129A68;
	Tue, 16 Apr 2024 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oypMd3+p"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9886A1292D7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267059; cv=none; b=GxVQmUXiKF8KiKweXyXn2Z8YbfvM0Ml9pU9DApt0yAaD7rY/SFOEX8TYXgxJafbOe/8CwdJr6922pXN3Zz04pceUSPK6OAT3UMIRSZFTegTTW7vKQe06tHr68vRq/AypOQ1WBdXyfA7CaJGDLFh8b7A95r7cRJn5SUEecr65rrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267059; c=relaxed/simple;
	bh=BhYQpL5bGevV2GbZmVaHlpnX2k1YiBVKJ9EsE9n0Jyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5qViyW5OlphyPkiAHbhEq5UA58GZfoM+EuIwPFGw4G5h1+iK+wbMe2vYZE/392wdwdKlp1Bekil9emck29BEmaY4teuIGN7NT29Pb6wMhCJEWrCRiTP0Ntn4IeN2lT44jE4ctufzcVgGg2cFHKeMEsNoY/8/uutpRA6mV3GPWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oypMd3+p; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5ac90ad396dso1512952eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 04:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713267057; x=1713871857; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C99IZrp/03ZNQcNBczYUdY5va9+oRjMXPShyuShNODA=;
        b=oypMd3+pV0Vtey9rUb5SwLMcQpTtQgbSt7kM0kyc7JzklKiRsNcIBeo0zGIoAzypEQ
         3Kt/iCiWKQe4XaR2xMxwibJZTA+Z5YjUQhx2OP67Jo7IQ0U7EVH+7IOAhirM7oR5loWb
         zElg4BW7qS3m30r98jwzyo0Er2aN9eekWTqfiOuWoiaMFJeoPvw+nYii4Q2dLVnjemZ5
         zSrZ/YlH+FqJ9A0goXuQSETW2swhR+7YUgrTPL9wgZqhSxLO4f7gwTT5vTvSo0tdBrE+
         hdeatjuLwImvFVZWyf8+js7BBILYofLE1+0z+wH/8XHZtSceE/CvxX1J/BRXDSNyxIfT
         uqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267057; x=1713871857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C99IZrp/03ZNQcNBczYUdY5va9+oRjMXPShyuShNODA=;
        b=H9ssNhS4kX1HB//3AXncBixP8rxUoLiOpvqpZur7tCFYMVnxVNFbuD0u4PqQdeyPhy
         UG+2MZQl52+fGbK4oZ7yQNc41ZsW3KjsyhInprVYSXf+aAhbmNMGrFYlDlFN0oyjzyW0
         OaAZNQygnlBf2tysYwQ3hq9gDjmAfnKINyI2cWvirMLWK/0NIPVp07M43K3gAinZi59v
         K06vrXr9KUvgtRTTbCpHGV4Ty0b0ODEhRo2SdBNo85lUwAiYFuDCPoPlWQzfr88/Eaff
         IoIDu5EUkBeDLBXZi1H7p1URtwvWReyHN6W1Smbb9jRrueDwdfJv8+MWxVPODc0J6sKS
         cC6A==
X-Forwarded-Encrypted: i=1; AJvYcCUWBm7IiObmOqK1tvQrgz61MfglbLcFnfwGEMBKF4gKQK8COsbPdUFjuFsI2uLk6RjkkGQo02a9o1bZsHWDyQ3xf0ZFrGUa60c86Z+X
X-Gm-Message-State: AOJu0YwSDPqd6CLQWj8wLvZeMDl+p7GbXhvSxNb+emq03vYoGGoDH/HY
	eziDN9XteZvt8KxQ1axv/9RSxHiCl/u/gOX8iqZv9FKx8wk9WNsvLzzdd4RicczcuZ4ph70JonS
	UbK4jFIJpuexZMZay8jnSQsl337+W3VG2idE5iw==
X-Google-Smtp-Source: AGHT+IHHl5CehcMHiAGofB/MGumUwf+S69MfIMUrqcYu9S1e+tFfuYa+Ox55juYnjaCvhTxe0MHk6mCUuL3AOdxNCzc=
X-Received: by 2002:a05:6820:250b:b0:5ac:5c78:390e with SMTP id
 cr11-20020a056820250b00b005ac5c78390emr10859247oob.2.1713267056734; Tue, 16
 Apr 2024 04:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404122559.898930-1-peter.griffin@linaro.org>
 <20240404122559.898930-4-peter.griffin@linaro.org> <a82e9859-b74e-44e8-a256-317b8c3fe6b7@kernel.org>
In-Reply-To: <a82e9859-b74e-44e8-a256-317b8c3fe6b7@kernel.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 16 Apr 2024 12:30:45 +0100
Message-ID: <CADrjBPouYqYJo8m4_=oCXEi+2208+Gt_Gn13Y3-9V587HOzc8A@mail.gmail.com>
Subject: Re: [PATCH 03/17] dt-bindings: ufs: exynos-ufs: Add gs101 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org, 
	alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org, 
	s.nawrocki@samsung.com, cw00.choi@samsung.com, jejb@linux.ibm.com, 
	martin.petersen@oracle.com, chanho61.park@samsung.com, ebiggers@kernel.org, 
	linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, tudor.ambarus@linaro.org, 
	andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thanks for the review.

On Fri, 5 Apr 2024 at 08:49, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 04/04/2024 14:25, Peter Griffin wrote:
> > Add dedicated google,gs101-ufs compatible for Google Tensor gs101
> > SoC.
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  .../bindings/ufs/samsung,exynos-ufs.yaml      | 51 +++++++++++++++----
> >  1 file changed, 42 insertions(+), 9 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
> > index b2b509b3944d..898da6c0e94f 100644
> > --- a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
> > +++ b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
> > @@ -12,12 +12,10 @@ maintainers:
> >  description: |
> >    Each Samsung UFS host controller instance should have its own node.
> >
> > -allOf:
> > -  - $ref: ufs-common.yaml
> > -
> >  properties:
> >    compatible:
> >      enum:
> > +      - google,gs101-ufs
> >        - samsung,exynos7-ufs
> >        - samsung,exynosautov9-ufs
> >        - samsung,exynosautov9-ufs-vh
> > @@ -38,14 +36,12 @@ properties:
> >        - const: ufsp
> >
> >    clocks:
> > -    items:
> > -      - description: ufs link core clock
> > -      - description: unipro main clock
> > +    minItems: 2
> > +    maxItems: 5
>
> Keep here minItems and:
>
> +            - description: ufs link core clock
> +            - description: unipro main clock
> +            - description: fmp clock
> +            - description: ufs aclk clock
> +            - description: ufs pclk clock
>
> >
> >    clock-names:
> > -    items:
> > -      - const: core_clk
> > -      - const: sclk_unipro_main
> > +    minItems: 2
> > +    maxItems: 5
>
> Similarly here
>
> >
> >    phys:
> >      maxItems: 1
> > @@ -72,6 +68,43 @@ required:
> >    - clocks
> >    - clock-names
> >
> > +allOf:
> > +  - $ref: ufs-common.yaml
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: google,gs101-ufs
> > +
> > +    then:
> > +      properties:
> > +        clocks:
>
> Enough is:
> minItems: 5
>
> > +          items:
>
> and drop the items since they are defined in top-level.
>
> Your original code is correct, but with my approach we keep the list
> synced between variants, at least part of the list. If another variant
> appears, then maybe it will go back to your approach, but maybe we can
> still have the same clocks and their order.

Will update like you suggest in v2.

Thanks,

Peter

