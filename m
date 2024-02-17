Return-Path: <linux-kernel+bounces-69827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5609D858F1F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832841C20E60
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7465969DE8;
	Sat, 17 Feb 2024 11:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vKD+yCmb"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E46069DE1
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708169992; cv=none; b=o1t2lt6JUukibyQRa93NHXSWEKtCHGF+8L6RoLAATMo89vhui3A7xu8znZGAHdEzqaZN7Zx/L7Qut23AbP/PTIT3I/bpV6tcg8ms8mp4ZXjimtvmuloKXM/fWrDPckPpiZVpDBY3tuf3H6ora8bUA58FOSP1cRMXUGO4Cutg6JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708169992; c=relaxed/simple;
	bh=vPvQg6T8DzaSAL66/xyHZth0xHwP9DWPS25PuK6+Z4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGWoV7Z3LffjwmOpWlKQgca8WQRiLiH3YOYuWCJZ8vgTomFqYr1wfvM6HK76W8CNjTUfB5wUzgPp1bcHJN29Vdg2gzzFGNfhlBEBIuAmX7LcO9hdBbhs5OvEYjKCC7iJP6QKJrmtX5ier9X8RMcKmdZU3w886DlX/4urgny1ig8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vKD+yCmb; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso2493707a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 03:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708169989; x=1708774789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1C+Hkp9mF5Xdg3l0hgYcA9Z6irk/GvuEVb1RZfBg7lc=;
        b=vKD+yCmbfxdngJtvVUYRvZxTNKXUoDYUBhmggjcFOcg88P6/fsifJIShS1Mh6qfRBn
         742BIR1Yo2vEojK8rN13RhOnMBdRT8v1bUc76HRizQKFphMrOjn2m5C50BeWFc/qOWRg
         31Eg5sF/uuHNFOG0ORuW7l1tpkkPr7WmIbwPC4ruHZO/5xsS4bu7qR+bRlZK+yxYAJQf
         0nddt/nYoMPwCzOlZM/Xtq77fHnYPNMyl6vMx6Gz0qh1Oc1mYERNjvzN5SRB1MRL6AbX
         t0FXXNBCcf2XYrY5CDJYtBPiLWTYwnYPMD0F2IdNmoffvVUxCXYxInRJ3PtxDTK1PsxD
         fsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708169989; x=1708774789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1C+Hkp9mF5Xdg3l0hgYcA9Z6irk/GvuEVb1RZfBg7lc=;
        b=smP6dyDYDWXL/t678GLcxsTYcisBRmCkGnY+CYMJO8VX/UTqPEAG4wxgKZgq9N7Jiw
         bl52YBhii2Iy03193jzlfbNXLc5lR+rLscHAZtBm75OGP/HqxQBjsGzE/yyFrEG5rQS2
         ME9kZOoljGphmo2KL/u5ZdhDBbnTcxZgBG/cDChAyDuVXqnJCcCYEsOyiAJTZT9ihXjm
         Ilq6Qs+MpYPcy/VAv4qSMhslOqc5+fl582HJ6lu9Z4ljPrPJwoDS6UZj6VCrnNUEZ0Tr
         IYS+VIYitxuKjBF/1az+LcYiWR9h3W4kEzSrpNIpNR94at8JZsA3Dx/vl102gVOz3K3c
         +Htg==
X-Forwarded-Encrypted: i=1; AJvYcCU3mLyn2/4kcMRvYA/iOLizbAeqM7IqOcF5Rv0DkWJJZWI3iJFcQwAsFLO1ce4HSw+6g6oit87xW9UI73RBHzeFFbrgR/kmQs03XaCr
X-Gm-Message-State: AOJu0YzyJrHUktaVujLngRSNuNLIQODCV7CLOh5IYedeeGh/wfeZhhS9
	/59TxMKMdvUdcFDsYqCtsJT7qjVvrsKq0YAip3AcK1eg3+oH0xN6SmcpiCi1sZw=
X-Google-Smtp-Source: AGHT+IHC8q9jk1V+NICBbpC1WNnMyrhtKdpmvofzMtMFylRK1DYfLGy8RvSLVqogHDYFEu79JIpj6g==
X-Received: by 2002:aa7:d313:0:b0:564:2fbb:a869 with SMTP id p19-20020aa7d313000000b005642fbba869mr524179edq.38.1708169989449;
        Sat, 17 Feb 2024 03:39:49 -0800 (PST)
Received: from linaro.org ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id ek23-20020a056402371700b0055edfb81384sm803108edb.60.2024.02.17.03.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 03:39:48 -0800 (PST)
Date: Sat, 17 Feb 2024 13:39:46 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Sean Paul <sean@poorly.run>, Maxime Ripard <mripard@kernel.org>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	freedreno@lists.freedesktop.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	David Airlie <airlied@gmail.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Rob Clark <robdclark@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: display/msm: Document MDSS on
 X1E80100
Message-ID: <ZdCbAjnga8HCMdYf@linaro.org>
References: <20240216-x1e80100-display-v3-0-28b1c33ac8c0@linaro.org>
 <20240216-x1e80100-display-v3-2-28b1c33ac8c0@linaro.org>
 <170810832158.3497594.1997532394027797497.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170810832158.3497594.1997532394027797497.robh@kernel.org>

On 24-02-16 12:32:02, Rob Herring wrote:
> 
> On Fri, 16 Feb 2024 19:01:06 +0200, Abel Vesa wrote:
> > Document the MDSS hardware found on the Qualcomm X1E80100 platform.
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  .../bindings/display/msm/qcom,x1e80100-mdss.yaml   | 253 +++++++++++++++++++++
> >  1 file changed, 253 insertions(+)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dts:24:18: fatal error: dt-bindings/clock/qcom,x1e80100-dispcc.h: No such file or directory
>    24 |         #include <dt-bindings/clock/qcom,x1e80100-dispcc.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dtb] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
> make: *** [Makefile:240: __sub-make] Error 2
> 

These bindings headers are already in -next.

> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240216-x1e80100-display-v3-2-28b1c33ac8c0@linaro.org
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

