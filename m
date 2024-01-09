Return-Path: <linux-kernel+bounces-21134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67859828A79
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CAF01C23861
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F277B3A8C7;
	Tue,  9 Jan 2024 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l1G8A7Db"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C907D38DFE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 16:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cd46e7ae8fso33024331fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 08:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704819150; x=1705423950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHbFSGdNqTkp4QL+EEPj5Pdc3ELkei7bVgDOsu4SrZc=;
        b=l1G8A7Db2iY1HReJ4End0SU67nLu1cDL7BUGjWPXokXHYfHOmE7c9mK5/pOWxzNYK6
         RcYfwXc57B6eXgxUdmpYuYN7sZLn6Wr4rJUhLK4u8rpG6GWNtQcGpd53TR6NerPHuI9Q
         BWQtzdEGugtENxwslX3pGzFKk+R+Ma+9sRYXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704819150; x=1705423950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHbFSGdNqTkp4QL+EEPj5Pdc3ELkei7bVgDOsu4SrZc=;
        b=VfF2fhqWrGyKeVL5/fMipBGWP5zwfZOWx7nZ1EtGoZoWn0JosUxOzDk/bT1/l2+DIp
         RgVRg6Sq1kNzg6haXwvOVyCWhu/6vy3M0horqv61MC6Qvan9MySedOVEvc2tm8Ve1Th2
         4nawV43aZxdlQ22U2Yj6wTxOqApvGfIsHmYBHR2+PInRZxr96Bj3zB3mZnjV29gixG+X
         rZEpYn9suI80KT1k+Jem638+XCcnh7gS4tivL9LI7MFp7I3rNByTIPRfKX2rGmFgoHhJ
         AawG1X00ow2fir1iAaXMjeXY18okHu8mkaxsosrP+OVBAScYSS+x6142kyolywSqgOpW
         cnCQ==
X-Gm-Message-State: AOJu0Yx6RbztIk9vxUVEXazTKYH16c7ZocWx5BUcuSJV+/pJlfRAgh7G
	ovLmgXtC3okf9eNloWr6P/lNTjcQMrXT7MY5ThLOh/I0mba4OhM=
X-Google-Smtp-Source: AGHT+IEChS4pKf+RIW3jHgP599i13sd0QaZGq+MHR+nI6tbch+/C0BTgBFJZQqj3ms8RmhXlIJUENg==
X-Received: by 2002:ac2:520c:0:b0:50e:cf8:b168 with SMTP id a12-20020ac2520c000000b0050e0cf8b168mr1143135lfl.208.1704819149706;
        Tue, 09 Jan 2024 08:52:29 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id a3-20020a17090680c300b00a2a4a6e1bc5sm1200600ejx.204.2024.01.09.08.52.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 08:52:28 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e43e55b87so68555e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 08:52:28 -0800 (PST)
X-Received: by 2002:a05:600c:3b2a:b0:40e:35d0:1fef with SMTP id
 m42-20020a05600c3b2a00b0040e35d01fefmr15464wms.1.1704819148582; Tue, 09 Jan
 2024 08:52:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109120528.1292601-1-treapking@chromium.org>
In-Reply-To: <20240109120528.1292601-1-treapking@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 9 Jan 2024 08:52:12 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WjjH3BCDf-OnX=zdk201uMu+YJvKVBhVmMa4GqNinacw@mail.gmail.com>
Message-ID: <CAD=FV=WjjH3BCDf-OnX=zdk201uMu+YJvKVBhVmMa4GqNinacw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: parade-ps8640: Ensure bridge is suspended
 in .post_disable()
To: Pin-yen Lin <treapking@chromium.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	dri-devel@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 9, 2024 at 4:05=E2=80=AFAM Pin-yen Lin <treapking@chromium.org>=
 wrote:
>
> The ps8640 bridge seems to expect everything to be power cycled at the
> disable process, but sometimes ps8640_aux_transfer() holds the runtime
> PM reference and prevents the bridge from suspend.
>
> Prevent that by introducing a mutex lock between ps8640_aux_transfer()
> and .post_disable() to make sure the bridge is really powered off.
>
> Fixes: 826cff3f7ebb ("drm/bridge: parade-ps8640: Enable runtime power man=
agement")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
>
> Changes in v2:
> - Use mutex instead of the completion and autosuspend hack
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

This looks OK to me now.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'll let it stew on the mailing list for ~1 week and then land it in
drm-misc-fixes unless there are additional comments.

-Doug

