Return-Path: <linux-kernel+bounces-21951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D23E829707
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7272811EE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1DD3FE23;
	Wed, 10 Jan 2024 10:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yngvason.is header.i=@yngvason.is header.b="b/nLsLCA"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945FE3FB38
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yngvason.is
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5fa52e173f7so4024727b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yngvason.is; s=google; t=1704881528; x=1705486328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96G7DIyssciX4jnAzNrTPlryo3sWO8sgy39soI2lLIM=;
        b=b/nLsLCAxAz4HMcmxX32IaIq+DjkSZlvvcu2fPIHOixPYIXTBOgnFvTg7ng+JnyVvc
         xJJwd+LuDFQYXKEMK+IfLCIxZJuWXc7sCs1sAICVNY6D/+gaTXFHkFax/0bjVS6fVnfB
         jFZm1oZ0lPSMicbx6XtnpmsrdWzTohus5jTvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704881528; x=1705486328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96G7DIyssciX4jnAzNrTPlryo3sWO8sgy39soI2lLIM=;
        b=rpILV5lWapZP/5f1ObyHTVM0m84ug+iHGF/BegVFIVwPgDYeRg+b77OG6ueAJ3Dl/a
         Xx2h9dgMf5hWnb39ispTVHNzzjVKC7SgOiNl1jOMOEXcnKX/4cDPUXDYh7kHHm3S/q6O
         zfn7vbVhNdUaDvkLSRAHpMEWv6JRTJrEtLj3kIiBFl8XpLd8n3Y4rxEnYBiv5W9JGp9e
         dz0dBPeqgkw0wlfQ7AxdGK+ZHpufQ+b7abuKdTr8tjbUFHpS4GYG/ewSgTE/6hksreiW
         p3R1DjvBk0tpfVxthnWQR6o0c6AqheHm9g2MASgGV60KfPBSOTpPQsbMDS60jzQutqz+
         3iCg==
X-Gm-Message-State: AOJu0YwWe9X58itWnw1AA5wCk4qZeGaKObp0zGzbKk3xZEEarjN1g+l6
	jiODhYTVmPN+m9tTrFCyCmWm2XqDgSeiDMKhX5tEoXnTZruKZw==
X-Google-Smtp-Source: AGHT+IGS4RF/sw1vbqlkX/KGSnVK4rjCwYusB936/yIZemFr40lAz/v1ty4wbuIZQF+WlPwAE3a+cK+ILR852Vcqmd4=
X-Received: by 2002:a25:f822:0:b0:dbf:227a:a2c with SMTP id
 u34-20020a25f822000000b00dbf227a0a2cmr504361ybd.126.1704881528497; Wed, 10
 Jan 2024 02:12:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109181104.1670304-1-andri@yngvason.is> <20240109181104.1670304-6-andri@yngvason.is>
 <qdwv7sagqs5nmmsy5lko5hypldanfodafyzamrs3loj3n7jzlr@n5bacxkknkj4>
In-Reply-To: <qdwv7sagqs5nmmsy5lko5hypldanfodafyzamrs3loj3n7jzlr@n5bacxkknkj4>
From: Andri Yngvason <andri@yngvason.is>
Date: Wed, 10 Jan 2024 10:11:32 +0000
Message-ID: <CAFNQBQzijyE4wR34AOLM45m+ryx128igVKO9zPJ5-M3afFQMxQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] drm/uAPI: Add "preferred color format" drm property
 as setting for userspace
To: Maxime Ripard <mripard@kernel.org>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, Simon Ser <contact@emersion.fr>, 
	Werner Sembach <wse@tuxedocomputers.com>, Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

mi=C3=B0., 10. jan. 2024 kl. 09:27 skrifa=C3=B0i Maxime Ripard <mripard@ker=
nel.org>:
> On Tue, Jan 09, 2024 at 06:11:02PM +0000, Andri Yngvason wrote:
> > From: Werner Sembach <wse@tuxedocomputers.com>
> >
> > Add a new general drm property "preferred color format" which can be us=
ed
> > by userspace to tell the graphic drivers to which color format to use.
> >
> > Possible options are:
> >     - auto (default/current behaviour)
> >     - rgb
> >     - ycbcr444
> >     - ycbcr422 (not supported by both amdgpu and i915)
> >     - ycbcr420
> >
> > In theory the auto option should choose the best available option for t=
he
> > current setup, but because of bad internal conversion some monitors loo=
k
> > better with rgb and some with ycbcr444.
>
> I looked at the patch and I couldn't find what is supposed to happen if
> you set it to something else than auto, and the driver can't match that.
> Are we supposed to fallback to the "auto" behaviour, or are we suppose
> to reject the mode entirely?
>
> The combination with the active output format property suggests the
> former, but we should document it explicitly.

It is also my understanding that it should fall back to the "auto"
behaviour. I will add this to the documentation.

Thanks,
Andri

