Return-Path: <linux-kernel+bounces-4082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7624F8177BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537661C2359A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7B949895;
	Mon, 18 Dec 2023 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IFlZymak"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0DE1E515
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e384cd6ebso1437968e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702917741; x=1703522541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aUBcpvKGT+MVST7gLJpsdhDGoD1QfbphX+istIq1xA=;
        b=IFlZymakFcrE48oGsJzCEslS88/rv+Gbytchs62ywN9XLZd5vg+ugv5Q0KkMZgY9vm
         IKeOjkWqkh1LxY+Ipi1tVahATm+sOb6DK5EeyLAySzuXYx+wtAEQca33nfmcY+uvn6P9
         CM6lOw9IRmENWz30E/2lzuT6ETXe+/wBRXSkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702917741; x=1703522541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aUBcpvKGT+MVST7gLJpsdhDGoD1QfbphX+istIq1xA=;
        b=WwGm2PbroA2m0ZYmnCiInpmhpjoXnn9t9PnXF3MdHI1/QiG5OzqY1hV1Pdi7f7hx1X
         AmCtPpQBgudj1oTIYdQ9juWObzkCNxXLVkCc18bkr+ZBNopEn1MGML37nVtAKcTqBY2p
         rUUOSE7s1unEgNFuKrQm2E1+JZFBMpwh+u5jiktAyqu3RfmJgp0c5Z0yScRIR5GfSQLu
         D7jeg6OlYMnBYpg+OIe7vxf9XeMPM+75SSrS+f5uXcpLJerFAkW5Xp2QoYv/yzKsNz3i
         oaawQEz1UtA6kOo4Y3SkhPW15cjWBEHAl5QG3CMX+jUlU/QmWf7KrVYvSGGeuIEdbuwr
         izPw==
X-Gm-Message-State: AOJu0YxBbo15YCdC/9LI28s8XPfYwpcSjzVcAR08X7+EKnm6j8hvhD+s
	0o+BoG2AfS96ISSyZst2Qim5Hz8REnrfk306jDOtdQ==
X-Google-Smtp-Source: AGHT+IGbv4kWK1Q4T2cHLjWdghzD0ITUT8/tCWyY+vPjTAXhf2UOVmkWT/sj6gVck1C3W92JgvBYgw==
X-Received: by 2002:a05:6512:31c9:b0:50e:22e5:f868 with SMTP id j9-20020a05651231c900b0050e22e5f868mr1941585lfe.157.1702917741312;
        Mon, 18 Dec 2023 08:42:21 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a24-20020a1709064a5800b00a23699a31e8sm400342ejv.89.2023.12.18.08.42.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 08:42:21 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so11655a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:42:20 -0800 (PST)
X-Received: by 2002:a05:6402:22fc:b0:553:7ff4:5885 with SMTP id
 dn28-20020a05640222fc00b005537ff45885mr32312edb.2.1702917740102; Mon, 18 Dec
 2023 08:42:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214152817.2766280-1-treapking@chromium.org> <20231214152817.2766280-2-treapking@chromium.org>
In-Reply-To: <20231214152817.2766280-2-treapking@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 18 Dec 2023 08:42:02 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WshKAWRe44ke-C6XnmBBFoPn1sJovGfVAFrQ55LuB8tw@mail.gmail.com>
Message-ID: <CAD=FV=WshKAWRe44ke-C6XnmBBFoPn1sJovGfVAFrQ55LuB8tw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/panel-edp: Add powered_on_to_enable delay
To: Pin-yen Lin <treapking@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Guenter Roeck <groeck@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 14, 2023 at 7:28=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> Add the support of powered_on_to_enable delay as the minimum time that
> needs to have passed between the panel powered on and enable may begin.
>
> This delay is seen in BOE panels as the minimum delay of T3+T4+T5+T6+T8
> in the eDP timing diagrams.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> ---
>
> Changes in v3:
> - Collect review tag.
>
>  drivers/gpu/drm/panel/panel-edp.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Pushed to drm-misc-next:

4464af92f276 drm/panel-edp: Add powered_on_to_enable delay

