Return-Path: <linux-kernel+bounces-71203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C499E85A1F0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028511C223BA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F592C1BC;
	Mon, 19 Feb 2024 11:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ep2UP6He"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C842C1A0
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342131; cv=none; b=lMpkYGrVERprdIrXC0y96Xa5bF/SWEhtYrF32G3KjFisaLMtwm/DZFM5UEkZuB5/FZvoOfITf8iAfAiGdkF/jYxwkoWZuU+e6r6AiFGInevyXq6p8jfUTqrAfT50jhu/WQcavcHIsCq0CnPqUr3VfzULS2HFAuSokbsgC/yd3vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342131; c=relaxed/simple;
	bh=P+laAF+cG7fMZpEX/X8L1Tdx42RnClpS0IgBt0RKewY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgW2aVqbA7SMGbasbqks4vUSqArwoiU3ovuWCm6i9BAAGiMFwWI5UCie6Xf31T1Qp9CXRDCQGrISLigY4+g8HP8bK9eIQhCXXgk0J5cQq6ZiXzFRQe7jD9Nt0Isbp3/EmEGl640RFEW43Sx8aRgrqXEcbYl0AW/GVzsxiS8Buu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ep2UP6He; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-561587ce966so8487928a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708342127; x=1708946927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nCyAWccqRzJ02Jr3HnjydtbclYSZbIBmeAFchAjZvoE=;
        b=Ep2UP6He0gDt2MP4OyVLjY4exXSCD1R5PDfNJB23NaCHcZrvM1fNADwJqGe1xOjcCe
         BkOy7N522ckJJT5pSaDNXSUM9CwhOrP8wTALiM7Ne9lfzS2sR8nkw0smzz3T2elMS2oI
         rXFh02/BvEXnJw3fCGQSX6N/Qm+0/rqn+OAxBBlxJ4AFll/ck69hBxMcMSC/yHzCSv1s
         arpVa3fVa6Gu005CynMXiR1ZwTIYb/zX/OjB098FmUYhRX4IV2lSZYuHR9CYnQtGgzt2
         O9+M0bZ6tiWfkIP/ujJHIWLFW0Bvv1UHozIagUKNO4WZtynUqzEaZG2wZss4akXWU7xl
         FT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708342127; x=1708946927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCyAWccqRzJ02Jr3HnjydtbclYSZbIBmeAFchAjZvoE=;
        b=s0T0MNYsxD7jCQUA47qlZSDLAuDCXg2fv0Ftf4eIuANAbJMPIvQamZnt9OF5+bHEkT
         7D1zmnZWlv9nbighcBv1ktR5Yn4Ch/HgdSFHb+gyctFXCrvfuUAp+CfWb5+PvMDnTzrG
         HklQEJmVwrP8HknidfNfrgYg6FoC0z7snSTMUxBnryEBb+lTJH59cnfGAnYec+iKOvDK
         SY4F9RRoTZ1MQbZ4XbjNbHJr6nQruhFpiMVt9TMhkWxDO0IXo/AGSradeIXyUlShoOVa
         NR37+cONQWodUSHMtkbkxCvD/lzG+TrxNguVO5/TFoZbHRAvm0SeVV9K3YOzxQofrwQ8
         blYw==
X-Forwarded-Encrypted: i=1; AJvYcCVOvdGgUcWVHU0v931Dnq3mWoJYYR5GFs4DnpKyTQrjWZcGWT+kXC6JGUd7vUIdgIF8I9ea8Z97a1cjTdtbY9hXj3CzguCurSaYlE2g
X-Gm-Message-State: AOJu0Yw9ZjymwzcCALP4T9oNA5DEeHLzXHji386+vUm28p3/9z4G3NiT
	RP58xpVyKaHo315G69uTCKU4haPOEf86eaNR5EdBFjKQRCbeq79C6GJ0KtIQIzj+IohDOM3NR7U
	L
X-Google-Smtp-Source: AGHT+IE3Zoj5Kw00K+Q1Oq/u8jQF4xulPdA6ZClow24TWEYwMXrNi35dMdqJQqanNvP5Txi3Qumx2Q==
X-Received: by 2002:aa7:d304:0:b0:564:4647:947d with SMTP id p4-20020aa7d304000000b005644647947dmr3745838edq.3.1708342127493;
        Mon, 19 Feb 2024 03:28:47 -0800 (PST)
Received: from linaro.org ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id e26-20020a50d4da000000b00564024b7845sm2797505edj.38.2024.02.19.03.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 03:28:47 -0800 (PST)
Date: Mon, 19 Feb 2024 13:28:45 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Sean Paul <sean@poorly.run>,
	Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
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
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: display/msm: Document MDSS on
 X1E80100
Message-ID: <ZdM7beFZPyHKJnEU@linaro.org>
References: <20240216-x1e80100-display-v3-0-28b1c33ac8c0@linaro.org>
 <20240216-x1e80100-display-v3-2-28b1c33ac8c0@linaro.org>
 <170810832158.3497594.1997532394027797497.robh@kernel.org>
 <ZdCbAjnga8HCMdYf@linaro.org>
 <CAA8EJpqCKWih1OeMsynMHkS6CAoDTsgRXcv5YAPZNvLT3MfA8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpqCKWih1OeMsynMHkS6CAoDTsgRXcv5YAPZNvLT3MfA8g@mail.gmail.com>

On 24-02-18 15:06:45, Dmitry Baryshkov wrote:
> On Sat, 17 Feb 2024 at 13:39, Abel Vesa <abel.vesa@linaro.org> wrote:
> >
> > On 24-02-16 12:32:02, Rob Herring wrote:
> > >
> > > On Fri, 16 Feb 2024 19:01:06 +0200, Abel Vesa wrote:
> > > > Document the MDSS hardware found on the Qualcomm X1E80100 platform.
> > > >
> > > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > > ---
> > > >  .../bindings/display/msm/qcom,x1e80100-mdss.yaml   | 253 +++++++++++++++++++++
> > > >  1 file changed, 253 insertions(+)
> > > >
> > >
> > > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > >
> > > yamllint warnings/errors:
> > >
> > > dtschema/dtc warnings/errors:
> > > Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dts:24:18: fatal error: dt-bindings/clock/qcom,x1e80100-dispcc.h: No such file or directory
> > >    24 |         #include <dt-bindings/clock/qcom,x1e80100-dispcc.h>
> > >       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > compilation terminated.
> > > make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dtb] Error 1
> > > make[2]: *** Waiting for unfinished jobs....
> > > make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
> > > make: *** [Makefile:240: __sub-make] Error 2
> > >
> >
> > These bindings headers are already in -next.
> 
> However they are not a part of the drm/msm branch. We can probably
> merge the rest of the patches from the series (once patch 1, DPU
> bindings, gets reviewed) and merge this one in the next cycle. Does
> that sound suitable?

Fine by me.

> 
> -- 
> With best wishes
> Dmitry

