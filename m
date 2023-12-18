Return-Path: <linux-kernel+bounces-4083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D66A18177C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD1E1F24C0D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431444FF99;
	Mon, 18 Dec 2023 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kX3Vc2Nd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CCB1E4B0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-54c70c70952so4155506a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702917748; x=1703522548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcDMSZdXKbh1oCxHZVjJKFW1eLcVZ1Cx3Nt4LLC2cbU=;
        b=kX3Vc2Nd1q1F4ytdw1i07392IH43BKMQvJuXlaI/tf+/sI55Eb7e2Z7Q+bPt2gm2Ry
         3Tu4WtrxvzEJ18liivA989F1j3uY2TZvYGl5NUD2McGxLZcgF7BFxvKwBKFhyqH+UN5c
         Dtw6YHqrV5nG2Dzobz11+fVlyYXdHw1WP5KuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702917748; x=1703522548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcDMSZdXKbh1oCxHZVjJKFW1eLcVZ1Cx3Nt4LLC2cbU=;
        b=CwpUJNm8wBHOtO0VP/HznvgNr3gcmtpHCjzf7OaCHvWyBjU2Eefuv40CmeEVvAIoaN
         22BH8BsdBg30vqfe0n9wKHP+/wllqCSS+QxWlBKjP+A5psA6hIXG5R+/UipK3BpKq900
         E4dF9/ITmvp34XGY1BUFzpVLPgWROiglUmOqNvPQzc4Oe7qLbyjOR5JPKDNMCuU6eTOt
         rO7V3eW50rS72wMO406urOyU28m8CvItv7ooUPdVXNS2lxky7EU+0A6rdA8d8mEkZb23
         RuM6GyajSnYI5GyzwPNeSB1rpBXDR5jZ9a3EA1nScBPwF9oSn9hRKR38Cz3p8fdFht3w
         gZ9g==
X-Gm-Message-State: AOJu0Ywz/rurBJtq6CXe2J9ULsN7duA1YK6TSRgvzgeRFpEiWfiuukAO
	n0407/kJSHOWuxhMm5Z+2D8yHqPn2uhcEsfH7cIAG75m
X-Google-Smtp-Source: AGHT+IGzBIazAhMcE2+vhjon/rK9kDrNyVmOMTYYzafIr2cuZ34PUlcdHxTelNfWCkHWDEjcMKMg5g==
X-Received: by 2002:a17:906:5618:b0:a23:3a45:8991 with SMTP id f24-20020a170906561800b00a233a458991mr884849ejq.200.1702917748220;
        Mon, 18 Dec 2023 08:42:28 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id s5-20020a1709067b8500b00a23499f1d7dsm2025363ejo.209.2023.12.18.08.42.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 08:42:28 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c3963f9fcso91985e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:42:27 -0800 (PST)
X-Received: by 2002:a05:600c:3513:b0:40d:11cb:e5c8 with SMTP id
 h19-20020a05600c351300b0040d11cbe5c8mr283442wmq.7.1702917747254; Mon, 18 Dec
 2023 08:42:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214152817.2766280-1-treapking@chromium.org> <20231214152817.2766280-3-treapking@chromium.org>
In-Reply-To: <20231214152817.2766280-3-treapking@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 18 Dec 2023 08:42:12 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VdvQHo1Lb7bNwwJNstQdo3Jghe2kBGp68Jd6KgvCnJTA@mail.gmail.com>
Message-ID: <CAD=FV=VdvQHo1Lb7bNwwJNstQdo3Jghe2kBGp68Jd6KgvCnJTA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm/edp-panel: Add panels delay entries
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
> Add panels used by Mediatek MT8173 Chromebooks.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> ---
>
> Changes in v3:
> - Collect review tag.
>
>  drivers/gpu/drm/panel/panel-edp.c | 39 +++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)

Pushed to drm-misc-next:

f4ccd9fea227 drm/edp-panel: Add panels delay entries

