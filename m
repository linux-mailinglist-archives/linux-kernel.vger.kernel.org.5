Return-Path: <linux-kernel+bounces-168206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A378BB510
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B8FAB20E57
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F77D2E85E;
	Fri,  3 May 2024 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9gDRQNg"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C502C69D
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714769594; cv=none; b=oqqtCpGkHSYEuaOOv4HscHJZS4zSRPCgURkjayo4c2fGuQRUE2m2wxxL91c4uSllE7y5iQammBuxlGc7r6xamKwHv8+fsCPM7IDLJqKShVI+aXW11+OzJTO3rsMJya83qwJZE6PUxqKYTVjwjWZsjgC/h1LkmIhrc0pre30JLVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714769594; c=relaxed/simple;
	bh=0QK0WcoOuIvVJillm3/5u0oD+B+bFokHxNXoKPy/mSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mo/X2p+8JUFoDDnxISngqFVm8xU/hUlApa70xYcXyJRpXv2/s42CWmiKCF4ggE6BF1k3S6H6jbickaKE/MUzBFgLvusNZPHeiyObUmRVcIuvNgGvGvy58cP1rA0qwm8XMoM7dcIuz3gzfdym8POtCboLkmS+xmJ/1koeB10VUUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m9gDRQNg; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51fcb7dc722so78008e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 13:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714769591; x=1715374391; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ViSqQc1pJpTWq8m4LEOBpWrjRIPxSIVvto5Qje5dvoE=;
        b=m9gDRQNg34wjl3BiGsweKX3uRpXXALFS+fYjw91zEa4UVBodnw7MAPuZeAUnUEU4MJ
         +i4eW0tYQY1BacOF5VUFKKn9fte32y07byEWSZksENhVnujSwlSjHLoZ+9QQCJC+Sm78
         ZOPZ9dJ4hxW0HNG/FflcMkmH8Qb6ra1QkLE1yzoGmEDsB++8D4S1qa0cQATJCfX2dlR1
         IMqPGTDNOsp9W4/rl4hXEQHgqKox+yXnYZZD14CbXwWf3PuE1AFZYVehTWiiCEZMOSFl
         yJg/VRrZzFPJcZ4qUn5YMLcHyHcLqetocklBAUUj5ZJdaLfNLyx0BUlapmWoqhpGlicL
         1OhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714769591; x=1715374391;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ViSqQc1pJpTWq8m4LEOBpWrjRIPxSIVvto5Qje5dvoE=;
        b=MC+r30vy2O3XonzM1rhDAj4+WL4OI+QBbnsx4hp/Y597YsbjpvyG9sCAvYhe4YDz8A
         ilsPfxHTlzTtQ1UqU/KrGr23q94JYQXEYIfCyX1ekrA8ITeE4u1Kp7WqYxx0enuIR+O9
         slIE0pX+XG5v6NgsaUi/YI6AEIF6bjpnUKHVC968eKRk/Z9JhUJTzqxHBZLmIThoHfan
         II1q/iCYkHYHi4ZNVtva9EqhzFNGVKv8y5wFp1uNo6hrnu57SGQmBmv63eCj3n5oi9dV
         +5dCKqh4Y9LqKVy3F2WbEZmOuU+MaFxfcUknieVOSzqRl40TR/VmMWb2Umz567bfXwpI
         tpng==
X-Forwarded-Encrypted: i=1; AJvYcCUX5+yJoh6loKskZS+37anbqchJWR3KoPb2ZX+qLZbcgDbfp9HoaUAkEOShQj45AAzGJgeoSAmjjF+n6i4zs8+ICPJcWJF/Ez3pK51G
X-Gm-Message-State: AOJu0YzPbHEsaat3QQ+4Y2Igst3ARDygbYU++Gleu+EqTSkIwrzlPw7t
	ykCbxCdMQZ1x346ZKgJTnPb20U8y7W+VtMLG4H1e9JhjdWUnOFYTuSktxYtO+JI=
X-Google-Smtp-Source: AGHT+IFbXxJ5Nlrd7neA19lVKIxQ7CRYnbRhRvTCMNDl9wEEYU9wVAlvQZvZU5PMLmUOyWOiyHgovA==
X-Received: by 2002:ac2:547c:0:b0:51d:8ff3:f835 with SMTP id e28-20020ac2547c000000b0051d8ff3f835mr1221328lfn.26.1714769590915;
        Fri, 03 May 2024 13:53:10 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id d7-20020a193847000000b0051deb442ab2sm660691lfj.294.2024.05.03.13.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 13:53:10 -0700 (PDT)
Date: Fri, 3 May 2024 23:53:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Matthias Kaehlcke <mka@chromium.org>, 
	Harigovindan P <harigovi@codeaurora.org>, Ritesh Kumar <quic_riteshk@quicinc.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] drm/panel: novatek-nt36672a: stop calling
 regulator_set_load manually
Message-ID: <yoaaisqdjjbx2qfnqdjrifzox3p3p7yeeeeduxlyormmjbgy3c@hmlc5ijwfg7n>
References: <20240404-drop-panel-unregister-v1-0-9f56953c5fb9@linaro.org>
 <20240404-drop-panel-unregister-v1-5-9f56953c5fb9@linaro.org>
 <CAD=FV=WVyRGevshhkhzuXht+ePm3BXVyMhDOPOkFs72wZS_s_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WVyRGevshhkhzuXht+ePm3BXVyMhDOPOkFs72wZS_s_A@mail.gmail.com>

On Fri, May 03, 2024 at 10:03:35AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Apr 4, 2024 at 3:08 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > Use .init_load_uA part of the bulk regulator API instead of calling
> > register_set_load() manually.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/gpu/drm/panel/panel-novatek-nt36672a.c | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> > index 33fb3d715e54..3886372415c2 100644
> > --- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> > +++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> > @@ -605,21 +605,16 @@ static int nt36672a_panel_add(struct nt36672a_panel *pinfo)
> >         struct device *dev = &pinfo->link->dev;
> >         int i, ret;
> >
> > -       for (i = 0; i < ARRAY_SIZE(pinfo->supplies); i++)
> > +       for (i = 0; i < ARRAY_SIZE(pinfo->supplies); i++) {
> >                 pinfo->supplies[i].supply = nt36672a_regulator_names[i];
> > +               pinfo->supplies[i].init_load_uA = nt36672a_regulator_enable_loads[i];
> > +       }
> >
> >         ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(pinfo->supplies),
> >                                       pinfo->supplies);
> >         if (ret < 0)
> >                 return dev_err_probe(dev, ret, "failed to get regulators\n");
> >
> > -       for (i = 0; i < ARRAY_SIZE(pinfo->supplies); i++) {
> > -               ret = regulator_set_load(pinfo->supplies[i].consumer,
> > -                                        nt36672a_regulator_enable_loads[i]);
> > -               if (ret)
> > -                       return dev_err_probe(dev, ret, "failed to set regulator enable loads\n");
> > -       }
> 
> Thanks for the cleanup! I happened to notice this commit and I'm
> curious why you didn't take the next step and move to
> devm_regulator_bulk_get_const(). That would have allowed you to avoid
> the "for" loop above that copies the data ;-)

I haven't noticed this function beforehand. Thanks for the pointer!

> 
> -Doug

-- 
With best wishes
Dmitry

