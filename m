Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E737E75D9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345470AbjKJASh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbjKJASf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:18:35 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11CD3C01
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 16:18:30 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9c603e235d1so244313666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 16:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699575508; x=1700180308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+QzYnLmP4o/hoHhC9dU8TbOe24+y8dJpH5rWAXxVBA=;
        b=fDstD3sy3ciEFDKCW+d5iiy/9yLJrz2g1frVrWIoPURE2KQwDkOVWzq+PwqNxmpZ4v
         yIiqzo6vhU6SSm+fw95JmQZmrproHnk9v5KF4WDaGnA+PKh6GoS35eCe/bXGzQ5IzwSZ
         t25oQ+BN3d8zUCltbIKsIEwqm+LM9/r/pYkmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699575508; x=1700180308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+QzYnLmP4o/hoHhC9dU8TbOe24+y8dJpH5rWAXxVBA=;
        b=X8ckGvCIrqupSe9+GXowtpNK6RPH6ktBqjUBpjSN874W5Z8olY3amP1wmvwjT8VBd0
         Qn5JVuhtikJ1shPVwDrHgHXQ1BMwR6/tDueoLvXNAHdOvroICBdN1Y7No2hVtbaG6zWs
         TuJxwR466jVgi5ghiVyFYrKk9EevZivPgcpFmK6cfnmHl72Ggz4Ya5q5MOxl7PawABB8
         Zvir0ifXYT8/SZ8ZZb0LyN5ZE12II3lyrLzdj6BwCbzHicANwMUoxLx/WX4mZoxdPQks
         tEKTczjzV80PzRPxIyac/exz3OGMS8oas8Jx7nhT1Z8jfWOsYI/yXy6Hf7oI7V0aYFF7
         nPQQ==
X-Gm-Message-State: AOJu0Ywo7o4SDhNBJSINjHDMixoTsJVf+3OfiN5Yvm3QLAT4PMj9gVUL
        KY1TkDOomGL/C9YvnrFXfi00ts4U8DWSE76pFHgM4Q==
X-Google-Smtp-Source: AGHT+IHw+8lJoibhKqw4IlSNX96HxbvA9fpTsDATPI61UPMzPpMqgyCezn4rvUefV4BvaXO52pe+qg==
X-Received: by 2002:a17:907:60c8:b0:9dc:2215:1593 with SMTP id hv8-20020a17090760c800b009dc22151593mr5609951ejc.25.1699575507935;
        Thu, 09 Nov 2023 16:18:27 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id c7-20020a170906694700b0099293cdbc98sm3225391ejs.145.2023.11.09.16.18.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 16:18:27 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-408c6ec1fd1so124035e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 16:18:27 -0800 (PST)
X-Received: by 2002:a05:600c:34cd:b0:408:2b:5956 with SMTP id
 d13-20020a05600c34cd00b00408002b5956mr277928wmq.6.1699575507115; Thu, 09 Nov
 2023 16:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20231107204611.3082200-1-hsinyi@chromium.org> <20231107204611.3082200-3-hsinyi@chromium.org>
In-Reply-To: <20231107204611.3082200-3-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 9 Nov 2023 16:18:15 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U0GCcNj+9spKsjk0H2O_u5HP-u-E+QcP0UDTvcHrWy3A@mail.gmail.com>
Message-ID: <CAD=FV=U0GCcNj+9spKsjk0H2O_u5HP-u-E+QcP0UDTvcHrWy3A@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] drm/panel-edp: drm/panel-edp: Fix AUO B116XTN02 name
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 7, 2023 at 12:46=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> Rename AUO 0x235c B116XTN02 to B116XTN02.3 according to decoding edid.
>
> Fixes: 3db2420422a5 ("drm/panel-edp: Add AUO B116XTN02, BOE NT116WHM-N21,=
836X2, NV116WHM-N49 V8.0")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> v5->v6: split to 2 patches.
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Even though this is a fix, it's not super urgent and since it'll cause
conflicts with other changes, so pushed to drm-misc-next rather than
drm-misc-fixes.

962845c090c4 drm/panel-edp: drm/panel-edp: Fix AUO B116XTN02 name
