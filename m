Return-Path: <linux-kernel+bounces-88870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE95B86E7CB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6851F26E5D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230441BF2A;
	Fri,  1 Mar 2024 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aBrYJYOL"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE41FC0F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315572; cv=none; b=bxJS/qGMvlieDgoV4g8xkPI9/g3k5/bB+qTQMSdIoNkVDY/sesuzQzwssKKOWAZjhng2h+P4buKdwcxJrnSbljmGIWiivC7RodfIZtkEcPOFG5e01KRjTTaJQ1oh/qK48jnI3liiUzi2bOcKNLc5ifJFPIUFSDYZ38MMiDV0asY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315572; c=relaxed/simple;
	bh=3V5Q+O2FXLZ0kss8N5yxXqgak8c3+ovvwNMUBWbWNj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRAKmXIUnpWeA80bv9m38dFHcCOHdY+OKk3aplW34aA3pajTWwjOnVad/O7TxfIbnt0wJGBNjkWjaAxGpkCBkcKYpinm7FQAdncHjrrLaacEZbrjuagTD//KasVu9w3oXcvuvMphsfSx1GRweYVnSppsQv+8k9GiR2vQ9BOKMjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aBrYJYOL; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso661163566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 09:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709315568; x=1709920368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BgknfKXa1rmDkpK0kJohefljfX90MMnzKKOyQbPtzxM=;
        b=aBrYJYOLzcAV09Va+PoC83XfWGVD+znyejc92mpH9onszjUvCQ8AOinu8rPedFWtNh
         GCPfGvSMK5iJ7IV/hKe+SWLgHB187AOb2mfuATL+e9WmvSD6kj70kjfk5pE2lnqov4Ge
         ivSa4zarPyOnlBX4/J9UXyXk9Gf8o9wXv1Os8MEwI+6r3TWR7RxFjfWjcJtmEJw9pYWm
         mBnYuq23XVZnnDjjtBuAhSLFLH6ZlMl//QHMX03KatzeJ1IB6PS3XEbetyQTpo1A/rVM
         SfspA7U9P05tS5ep3h+aGKIPTR0q+HyGUKjJoTUw4VMo4nfO4AfJe9JlfKt6b1ugEKLT
         u7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709315568; x=1709920368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgknfKXa1rmDkpK0kJohefljfX90MMnzKKOyQbPtzxM=;
        b=fCWd/3gt+fbp5hI7JbJwjD9o7IvyRmHs33Kp00HSyquFBvbhWfb56gNASXN2Da66kr
         gEHiqQl5uS5u3zu4UN0jXHWFaTJ8cvl7w8bcTci+mwIPPypz8kBnO9z4h2a7bhdp0k4I
         X5zOaMQlWyn41JrCUmI5/X8q7O6/q3YnEdh0YbO/Ck9886d8iYWuaeIw6A7q4UDrRBf5
         DFytS8DhRR+sulyjDGrOPaKaON5aju9K3J4hLVo/mhom/abZy649vSvDVSp1HjEG8DSk
         CWUuveH/XeCuBb2LWlpmSRWPKm6+Z9zQUHV1pFrIvyqIvs+7lZFCX31MUDuk4Bt9nE7F
         vxqA==
X-Forwarded-Encrypted: i=1; AJvYcCUZwacu4udS7HpXNTaIyU2Rkkxy4wIvJ/ZXQRzmIQGcKkbxVyAfg5YqLCfZ63jfEU0o61DNhQGtzRhij8pRFnLi100hECEs5gk29gc5
X-Gm-Message-State: AOJu0YyONSNmqD0MCKhwCXAU0AVdN2+K/qQYQwg55ixvASPivou/FZLg
	6g5N1w7qptQMxWsyBAUqF7USNwAl/7UEu1pH90Z/EV8QVRi5xoBq/3BW4BQSPic=
X-Google-Smtp-Source: AGHT+IFWlVuicjYknAdk37iSyCWyl6bDc1xmcdzkVqJy/EqPKHmtbxzit8FJhzeWVCTnKwKbxFK0/A==
X-Received: by 2002:a17:906:b811:b0:a3e:53d9:c7d5 with SMTP id dv17-20020a170906b81100b00a3e53d9c7d5mr1794154ejb.36.1709315567593;
        Fri, 01 Mar 2024 09:52:47 -0800 (PST)
Received: from linaro.org ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id vq2-20020a170907a4c200b00a43a12c6311sm1895924ejc.166.2024.03.01.09.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:52:47 -0800 (PST)
Date: Fri, 1 Mar 2024 19:52:45 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: display: msm: dp-controller:
 document X1E80100 compatible
Message-ID: <ZeIV7cBtDI8e1WT6@linaro.org>
References: <20240222-x1e80100-display-refactor-connector-v2-0-bd4197dfceab@linaro.org>
 <20240222-x1e80100-display-refactor-connector-v2-1-bd4197dfceab@linaro.org>
 <a90dcd83-d158-4ec1-9186-0658c108afef@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a90dcd83-d158-4ec1-9186-0658c108afef@linaro.org>

On 24-02-27 16:45:25, Krzysztof Kozlowski wrote:
> On 22/02/2024 16:55, Abel Vesa wrote:
> > Add the X1E80100 to the list of compatibles and document the is-edp
> > flag. The controllers are expected to operate in DP mode by default,
> > and this flag can be used to select eDP mode.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > index ae53cbfb2193..ed11852e403d 100644
> > --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > @@ -27,6 +27,7 @@ properties:
> >            - qcom,sdm845-dp
> >            - qcom,sm8350-dp
> >            - qcom,sm8650-dp
> > +          - qcom,x1e80100-dp
> >        - items:
> >            - enum:
> >                - qcom,sm8150-dp
> > @@ -73,6 +74,11 @@ properties:
> >        - description: phy 0 parent
> >        - description: phy 1 parent
> >  
> > +  is-edp:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Tells the controller to switch to eDP mode
> 
> 
> DP controller cannot be edp, so property "is-edp" is confusing. Probably
> you want to choose some phy mode, so you should rather use "phy-mode"
> property. I am sure we've been here...

phy-mode in controller node or in the phy node?

> 
> Anyway, if you define completely new property without vendor prefix,
> that's a generic property, so you need to put it in some common schema
> for all Display Controllers, not only Qualcomm.

I can re-spin with qcom,is-edp if that's better.

> 
> 
> Best regards,
> Krzysztof
> 

