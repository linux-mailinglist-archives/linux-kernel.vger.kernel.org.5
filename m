Return-Path: <linux-kernel+bounces-73080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3284B85BD47
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4FF2859C4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF686A35C;
	Tue, 20 Feb 2024 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SeIyDTBF"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB1C6A331
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436150; cv=none; b=Vjnsg0Pfa4F5N0IX1dJI2AIoWOiQSUUCMCtUdpSC8+Hl3aTXMfAfrA/l9ksEppsRdVFbAKeJagsu2BvC8GcbE0osyCbi5z8tXx94P3FDKM3YJoN35TxYbzQGvBIget4h1UvGKC3H4OUE+f259tccCH3KFyao/gKsBFVSFTK5RqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436150; c=relaxed/simple;
	bh=uP9yFWGRb+3k9SdvwFsut4JNqwQGECYNGZVyusotfXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXjJXseX6/reVa2wPOG7TigFOVS9Ix9Ojax9qZ8g7o0fofPXQYl+dvYUXbz5m47nZLQjteC09aVO4m5V63GneFuOACnqFwHs35wDie5a7MymZ3ThRgbTj0p0eIAIfGDfUNPcGA1sVgPVONtGOTjLdWeGJLrkQY/Hxl+8zWqP+tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SeIyDTBF; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60821e8d625so23657227b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 05:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708436147; x=1709040947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80bDR9xsJVYz/T1iI+xnPV8UhHBUEFxKf9UJFof0JFA=;
        b=SeIyDTBFpArYr0K/IB/aSKXP/XL8oL/z41ipI4fIwcxu84apF8LgPhF0jYn29ye4z+
         KsEyCPyIE9+pSGSzZ1ybMcS2p1xvoFPS4zPKVyVw8v6WMVFtplPREUgIvPhpDECfMl7Y
         AiZAn2FrMZoBkLgqrqjGfNfKn8RRu7VF7YLpmUIIbwCIZiLHxf7gnIczhPDejV3ZV+KZ
         zpTi2ZUpo4+EsGjlxRg8jiYRY8d8/ypTAvlf8/Iky0EaVPQCs6mG9bd1CSC6yDpXlX38
         dC32vn77lngrpKO+7SpQlEYjrwhYXZjyW7YGYZdLpSY6M4D1i/bdYF9vgbNQmCr+HeTO
         gJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708436147; x=1709040947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80bDR9xsJVYz/T1iI+xnPV8UhHBUEFxKf9UJFof0JFA=;
        b=lsGVFC8iUBFQas1R1lwPFRKIfRo5MfDlsIB2cY5+A0jKKi+MOZx+PJDryyenmww6Gh
         4CbHg8mujnIj8hmpel4+bE/RrNS2yQE8hMBrPJOAO7g5GCJFPKLpOx5oIi906SGVPoew
         UgDv+GSeidIgsusrLdFtQIRWnUvrYGgA43oHlKsDlH0PzBI1lQExcP+Vfwa16hkQkQ9S
         7orcAWXy9HEjv/vAYIlpfE9k1zWQLAUZLjQGxWNQZilxE+y3A0Nm8l1ySkPhMOLPUG00
         5NmBUsy/ocFaL9pPnZU7qASpeEquHXcFJZbemVPwlN8xA59sCDDh86qw9y/ycKTzNXnA
         S7Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVdoMDFT0wGW8r1D7zAC81zKeDrbn/mXkrlGe/3w9Tg7dVGMG7avUP8zHpvPWXnzuelIi+7LIKYKXVnKswuf2BP/7UwiQYHHJ+IqPma
X-Gm-Message-State: AOJu0YyixW1ZXuiXPNlSY033HHADUxFrq7MphrPVRqsTiiVBlhElgFvu
	CnL6xHyrr5yQvHmO6OQx/3ZoqFJeRlulkfsxmJqVoGB7oxf9vinnSkO7az/oJ6HgU6xifB3l3ew
	vFhUwLvEqGfgLFCtPW4gJ3YnwkcifbJv6++kDWw==
X-Google-Smtp-Source: AGHT+IFblLCJUAfvYsxAzrxnfj6+lmkywotENdKnj1jtMtxOZ6aZ30kx1UQMoBV7aylB0LH/E8+wrC1HtazKHPBbsVw=
X-Received: by 2002:a81:7994:0:b0:607:7e73:fce1 with SMTP id
 u142-20020a817994000000b006077e73fce1mr16601552ywc.26.1708436146800; Tue, 20
 Feb 2024 05:35:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217150228.5788-2-johan+linaro@kernel.org>
 <c95f5ff3-8dad-4302-9384-92a9b83f7bdc@web.de> <ZdRTx2lmHBVlcLub@hovoldconsulting.com>
 <1afc87c-2c1f-df10-a0c8-2a267d44122@inria.fr> <CAA8EJppH9ey97yKFUccNLHhMKs3eUS55+rY0tXm_a6KGp9jtug@mail.gmail.com>
 <4938592e-3f7c-c1ae-dce3-fd1ca363296@inria.fr>
In-Reply-To: <4938592e-3f7c-c1ae-dce3-fd1ca363296@inria.fr>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 20 Feb 2024 15:35:35 +0200
Message-ID: <CAA8EJpq88ZKLFBuAvDuDSMD_DkPpMmBDZG_kQyUrSs-Noqm2SQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm/bridge: aux-hpd: fix OF node leaks
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Johan Hovold <johan@kernel.org>, Markus Elfring <Markus.Elfring@web.de>, 
	Johan Hovold <johan+linaro@kernel.org>, freedreno@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Bjorn Andersson <andersson@kernel.org>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Vinod Koul <vkoul@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Rob Clark <robdclark@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Feb 2024 at 14:56, Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Tue, 20 Feb 2024, Dmitry Baryshkov wrote:
>
> > On Tue, 20 Feb 2024 at 13:52, Julia Lawall <julia.lawall@inria.fr> wrot=
e:
> > >
> > >
> > >
> > > On Tue, 20 Feb 2024, Johan Hovold wrote:
> > >
> > > > On Mon, Feb 19, 2024 at 06:48:30PM +0100, Markus Elfring wrote:
> > > > > > The two device node references taken during allocation need to =
be
> > > > > > dropped when the auxiliary device is freed.
> > > > > =E2=80=A6
> > > > > > +++ b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
> > > > > =E2=80=A6
> > > > > > @@ -74,6 +75,8 @@ struct device *drm_dp_hpd_bridge_register(str=
uct device *parent,
> > > > > >
> > > > > >   ret =3D auxiliary_device_init(adev);
> > > > > >   if (ret) {
> > > > > > +         of_node_put(adev->dev.platform_data);
> > > > > > +         of_node_put(adev->dev.of_node);
> > > > > >           ida_free(&drm_aux_hpd_bridge_ida, adev->id);
> > > > > >           kfree(adev);
> > > > > >           return ERR_PTR(ret);
> > > > >
> > > > > The last two statements are also used in a previous if branch.
> > > > > https://elixir.bootlin.com/linux/v6.8-rc5/source/drivers/gpu/drm/=
bridge/aux-hpd-bridge.c#L63
> > > > >
> > > > > How do you think about to avoid such a bit of duplicate source co=
de
> > > > > by adding a label here?
> > > >
> > > > No, the current code is fine and what you are suggesting is in any =
case
> > > > unrelated to this fix.
> > > >
> > > > If this function ever grows a third error path like that, I too wou=
ld
> > > > consider it however.
> > >
> > > I guess these of_node_puts can all go away shortly with cleanup anywa=
y?
> >
> > I'm not sure about it. Those are long-living variables, so they are
> > not a subject of cleanup.h, are they?
>
> OK, I didn't look at this code in detail, but cleanup would just call
> of_node_put, not actually free the data.

Yes. The nodes should be put either in case of the failure or (if
everything goes fine) at the device unregistration.

--=20
With best wishes
Dmitry

