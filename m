Return-Path: <linux-kernel+bounces-122718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1545A88FC02
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A691C2C5B1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6464E6A00E;
	Thu, 28 Mar 2024 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="m+kIphZG"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D9C41C62
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619363; cv=none; b=AjkRu+89jnAKsvH1faW0PpOEoQc0AFvA5ETKvZRwfpFOKPHEAzTsFo52x0wUMpML70wfmgRqz+ICEy0e0hp+oqY+iPPjwZIYGQ8EmQoc7TnZyffuf/zYK1yKy4hYNqtCVAy+krvl0lSeHwMF/YfuVxACtbzkJ1iQhb18eUmwm14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619363; c=relaxed/simple;
	bh=NGAu0Wues6upFNlxfKrI9TDym/OgXLE2E4Jz/pnzxis=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dqps6WEfazrEb+syM0fm07xZ7ingPtRL1vzCRuHKi0mRkQP+hFsgH2XFBjZW14xsq6XS0SR2E/nUszFbQbqFQodMzt7z8eZ7/1lFZM9WyFrL7777o/01ywuJtdrIj7le/vWRk+0mDoeOkJqRYGsP2rVPTXC+flkT5Viy0HaWArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=m+kIphZG; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4e1566610fso78443566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1711619360; x=1712224160; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2FlcFMwv9/mxZZUbTMV8sm8mZF2ziq8g+DEQybJDFU=;
        b=m+kIphZGysprPE69JLfucvUfx8YVagZTGnFKino86wl2sfLIT5cFasJgkSnJAQEl22
         cH4+i7tkd7CxHhpZlwDV8auDxJ+GMg7Gpn7SRoCwjCQ/kzhuA/kR0SYR5xwh3R6Wmv5L
         VCxv+GtERDajDWYLn3VEvBQhMrgXol+qSc4dEiCL9kvPfByWv29tL/nZKVUtR2y0ae79
         jeU4hxazH2wHNbmleWbghqCViIh4JGXQLoZlQLJssfSGe/1jpFsW61RTsCNEcg8OVmdj
         MyZJg6OTbmmT+JUFQynVVf+aQQf7Xjp+thSmjm2aGSzl4hTq2WPY2I89eYWYCuXsB0uM
         Sw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711619360; x=1712224160;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s2FlcFMwv9/mxZZUbTMV8sm8mZF2ziq8g+DEQybJDFU=;
        b=bsmU+BUgAXqt1fkdfNF22SiRB7AbHiOKhgy4AmlzT6S96LU6AZV3QgC9EW9+TiPuSw
         r8kKopQ3KDfvec2rjB3Bh/N2YiXsZLOkbuoNiuOTBCIcjDPp4tMBOu63nNujQtw6S0VA
         bjOQTkhuFKJJOd7QcX8w2rUj9BpIdRouMi8F2ns0P/Hwr9bfjMTm9rrHNoKgCf7V2I9y
         uqNq6BhGvnLSJiKqerPdTVhdPSiS3DR+MPEi0GpTaFBjC8f2jx5OaLi6l/vGM6CMRMCA
         MkFqrsshk+7vRtBZKnnXcWoS7ClBucCTKmVZbUbscUTaFyIqQ203adfvBhq6WLQIu5lR
         df/w==
X-Forwarded-Encrypted: i=1; AJvYcCUlhPJXpb3ncaF/3YIeKmkQ7ggUhQ3VMxArKqr4/cDFrM5YhuVk+UGNyG4/tf8DJQElvvPRNdPvcBvQWJxEehm/uRPLrjvRHohGoYuc
X-Gm-Message-State: AOJu0YxLV4oLlie9t7wMCufvGcTREzGHpuP1RWjG+WV0wYBdFB4rZL88
	zNlBMwDGgc4iJZHdhstPKGqEdb7fzaoSAJF3npJvTgfstHuvGpSja/qNVTnUUyw=
X-Google-Smtp-Source: AGHT+IHQj43uF1oRw2agLwmax83BUP4TUUSTe802FM7CxRtHEbgYpfc/GypNFhLDLarI2m22J/4eHg==
X-Received: by 2002:a17:906:26db:b0:a46:8c40:7a3a with SMTP id u27-20020a17090626db00b00a468c407a3amr1170962ejc.26.1711619360465;
        Thu, 28 Mar 2024 02:49:20 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id cd1-20020a170906b34100b00a4a396ba54asm555999ejb.93.2024.03.28.02.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 02:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Mar 2024 10:49:19 +0100
Message-Id: <D05AFAI1G7CY.3EURGL4VGKHB@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: display: msm: dp-controller: document
 SM8250 compatible
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Rob Clark"
 <robdclark@gmail.com>, "Abhinav Kumar" <quic_abhinavk@quicinc.com>, "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>, "Sean Paul" <sean@poorly.run>,
 "Marijn Suijten" <marijn.suijten@somainline.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Kuogee Hsieh" <quic_khsieh@quicinc.com>, "Krishna Manikandan"
 <quic_mkrishn@quicinc.com>, "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konrad.dybcio@linaro.org>
X-Mailer: aerc 0.15.2
References: <20240328-sm6350-dp-v1-0-215ca2b81c35@fairphone.com>
 <20240328-sm6350-dp-v1-1-215ca2b81c35@fairphone.com>
In-Reply-To: <20240328-sm6350-dp-v1-1-215ca2b81c35@fairphone.com>

Stupid typo in subject, should of course be SM6350, not SM8250.

On Thu Mar 28, 2024 at 10:42 AM CET, Luca Weiss wrote:
> Add the compatible string for the DisplayPort controller on SM6350 which
> is compatible with the one on SM8350.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.=
yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index ae53cbfb2193..97993feda193 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -29,6 +29,7 @@ properties:
>            - qcom,sm8650-dp
>        - items:
>            - enum:
> +              - qcom,sm6350-dp
>                - qcom,sm8150-dp
>                - qcom,sm8250-dp
>                - qcom,sm8450-dp


