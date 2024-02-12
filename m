Return-Path: <linux-kernel+bounces-61497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F8D8512E9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2FD12828B4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E77339FE9;
	Mon, 12 Feb 2024 11:57:16 +0000 (UTC)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F48A45BE3;
	Mon, 12 Feb 2024 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739036; cv=none; b=Y77IPYXTZOK8p6tyj1JlypcGbWCPAfKPmGLBEGE6EXB+TyaR1x8mTeJqK5Hg3H5FFnXBDmN2O6LN4A37gynk7QAwdXkQRRsYPexPN95rwyypc8ojPgA3YsfOSiYtdhyilJ+kclfUCOcqNQuQ/Ju4F7db2fRKdQcbL5OlYI9FsGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739036; c=relaxed/simple;
	bh=rRXck6YBJ4PFlcL4NbrLP0mA9C1zNeBnLnc19pgDRhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWmaKF1nmTlb6k+A+5hUudqStwheuNCD+7esibwhcxcecSkwRnUOB7VDiNgUh3H3L7UxmjBOIKIn1NL2T6/ztrOZQwijpTXZjJIgoSd5EUHLmKK45qQWvYLCYWCFwds0L9Kq5mgXgGxTUqeTmLRIcUF+88+ROMar0Wza9GYTgmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3be110bbff9so946096b6e.1;
        Mon, 12 Feb 2024 03:57:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707739033; x=1708343833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wMAO06BchNCC530Xu9UhtfefntbOOr1o7C6F7RYDi4=;
        b=WbyaAQEXjQINEeaC83l261NCvAOjtwH9gSlPZy8J7Q6Zc0ZmOXPukgXwgHydUA8dIW
         mjhst8CRIYleaY9e18z1aaG6G+uzeR/gPqE1alLGDJX74Uy7XFZr7NP1mWJltpcBCTp9
         NFqah75/tIKAMAmhXm7MSUabl0sA/VTSS9tr0x6pWnkV3uVUWB0kGboFprYU25PSFxiR
         jaWG1iP2CTZ9CYa+SnqKC5Jc2xMTK7h7xAkQdz8KDQxIWtgacIEuKZy6WqzwtL3G5J8Z
         nGAxoX36iOfi0lHOr2eZte/T3+u/Z/St2pn6Km39Bbl2GE5bzFGsmOrCgz9ZK+nY8tmG
         AbOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB0JQw1dr3lz0YRg/OvVtMST8oQzivAx2Xz6EwX8bzIRp0odHIumNyHEAJWV44S8Lhs6rm2+DfmvrD/txcz3jafN2jP3MM9vCCx12V6Ucl9M7N2N8MlZ+r4o4Ua4jgZUDdtsLg2z+tWb/zK3BdVpbNmFiuB4F4l4g4XyPJEOUjAdbO8d3S3WeCs04JfL7HJixEcd+vzvuQPgsAOxmY+R8XLR49lh2VnRA=
X-Gm-Message-State: AOJu0Yw2HrTzoWK47j4RpZMSXXmQ+3G+o8PSRqFkdSav7Mqfn8/HaIP0
	xywtfyfxwxBjwnxIetIeg9fdHHZdVMZe7DIZi+cN+y/hy7aXcE4ZejzP90YLWP3Sz6YSbYEeVl3
	sXHw6EPUXc2P/vT5/zkRIe1ab/Rc=
X-Google-Smtp-Source: AGHT+IG/3+DaOXUU6rXyszdqbRwQ6IvLimbpuWMEp0FU5HpM8CNYZ/mRaLlL7JC6LNkmQiYfi71otNEgsym8lr177kU=
X-Received: by 2002:a4a:ee91:0:b0:59c:7c63:928f with SMTP id
 dk17-20020a4aee91000000b0059c7c63928fmr4695865oob.0.1707739033372; Mon, 12
 Feb 2024 03:57:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com>
 <20240130111250.185718-3-angelogioacchino.delregno@collabora.com>
 <CAJZ5v0jzaGpK8LnsFDtjuPoURrwrUgM1Z2QfZhK_FUzDeK3wcw@mail.gmail.com>
 <e4359d2c-e686-4a97-9d21-d10908e9df61@moroto.mountain> <CAJZ5v0iYNPB2v7ZCynEOvWy+gz4DQUhuoJ8e7F1MXz13m_d7rw@mail.gmail.com>
 <45422a32-de34-4de1-bcd3-5580386f27f8@collabora.com>
In-Reply-To: <45422a32-de34-4de1-bcd3-5580386f27f8@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Feb 2024 12:57:00 +0100
Message-ID: <CAJZ5v0jyeGMKxks9bYneUbm-zWpW8u9ARXCmqY5c=TMswgFuQA@mail.gmail.com>
Subject: Re: [PATCH v1 02/18] thermal: Add new structures and thermal_zone_device_register()
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	daniel.lezcano@linaro.org, miquel.raynal@bootlin.com, rui.zhang@intel.com, 
	lukasz.luba@arm.com, support.opensource@diasemi.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-imx@nxp.com, andersson@kernel.org, konrad.dybcio@linaro.org, 
	amitk@kernel.org, thara.gopinath@gmail.com, niklas.soderlund@ragnatech.se, 
	srinivas.pandruvada@linux.intel.com, baolin.wang@linux.alibaba.com, 
	u.kleine-koenig@pengutronix.de, hayashi.kunihiko@socionext.com, d-gole@ti.com, 
	linus.walleij@linaro.org, DLG-Adam.Ward.opensource@dm.renesas.com, 
	error27@gmail.com, heiko@sntech.de, hdegoede@redhat.com, 
	jernej.skrabec@gmail.com, f.fainelli@gmail.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 11:41=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 02/02/24 18:13, Rafael J. Wysocki ha scritto:
> > On Fri, Feb 2, 2024 at 9:47=E2=80=AFAM Dan Carpenter <dan.carpenter@lin=
aro.org> wrote:
> >>
> >> On Thu, Feb 01, 2024 at 08:24:15PM +0100, Rafael J. Wysocki wrote:
> >>> On Tue, Jan 30, 2024 at 12:13=E2=80=AFPM AngeloGioacchino Del Regno
> >>>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> >>>> index 65d8f92a9a0d..7a540b746703 100644
> >>>> --- a/include/linux/thermal.h
> >>>> +++ b/include/linux/thermal.h
> >>>> @@ -149,7 +149,8 @@ struct thermal_cooling_device {
> >>>>                          passive trip point.
> >>>>    * @need_update:       if equals 1, thermal_zone_device_update nee=
ds to be invoked.
> >>>>    * @ops:       operations this &thermal_zone_device supports
> >>>> - * @tzp:       thermal zone parameters
> >>>> + * @tzp:               Thermal zone parameters
> >>>> + * @tgp:               Thermal zone governor parameters
> >>>>    * @governor:  pointer to the governor for this thermal zone
> >>>>    * @governor_data:     private pointer for governor data
> >>>>    * @thermal_instances: list of &struct thermal_instance of this th=
ermal zone
> >>>> @@ -184,7 +185,8 @@ struct thermal_zone_device {
> >>>>          int prev_high_trip;
> >>>>          atomic_t need_update;
> >>>>          struct thermal_zone_device_ops *ops;
> >>>> -       struct thermal_zone_params *tzp;
> >>>> +       struct thermal_zone_platform_params *tzp;
> >>>> +       struct thermal_governor_params *tgp;
> >>>
> >>> I agree with doing a split here, but I'm not sure about moving items
> >>> from the arg list to struct thermal_zone_platform_params (as mentione=
d
> >>> above).
> >>>
> >>> Also the naming is quite inconsistent.  IMO it would be better to cal=
l
> >>> the first pointer "tzpp", rename struct thermal_governor_params to
> >>> struct thermal_zone_governor_params and call the second pointer
> >>> "tzgp".
> >>>
> >>
> >> The names "tzgp" and "tzpp" look almost identical at first glance.
> >> Could we increase the hamming distance somehow?
> >
> > Good point.
> >
> > They may as well be gov_params and platform_params AFAIAC.
>
> I'm more for gov_params and zone_params, as the thermal_zone_platform_par=
ams is
> supposed to get renamed to struct thermal_zone_params in part 2.
>
> Anything against that?

Nope, sounds good!

