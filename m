Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CF479F109
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjIMSUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjIMSUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:20:52 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A21F1BC6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:20:48 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52a5c0d949eso68982a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694629245; x=1695234045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wB9rIbKtdC8vvE0Z9iK8mxaspRNseaVhibM5IMYjY18=;
        b=h1NRyJRynTMchvi16Y2qIDINC5tmSgi0Vew7VXt7U7/ZLYRHzahACFf9iM6aIZyJv5
         V8yyZZtFI/vuXxq4g8IfC+Rjpp+OajQjt3uHOvz0jB6Uct2Pnd1xuyS4GGH+2kmsnNp/
         RJ2na2akmEK78sSTez6huS/ujLUD6iHmwxRb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694629245; x=1695234045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wB9rIbKtdC8vvE0Z9iK8mxaspRNseaVhibM5IMYjY18=;
        b=N9QvbUOP9qxw+wXouOxz6VVnsJ0LErPQbtDQXaW4/LTTdHO14SYmMIUB4c1ZtEKw3P
         Ou2eB8g1dPc/CMPuCRBA7GRhqLGLCogQzoSE53DOQbsyokuYKRqEvIyXjT4xiz7VJ8ZA
         TLqPiASF2xoEBqtc73mMqyzC11k4fMbOJYL13dB7xEB7Q5WX8bcMsrVwjEWflkOeNgEs
         mkC+Beazon6iMEZzxApd8Lo96Bnbv3RMxWs4fAZbhTTxmv3do1jdqq6D7KMSe3MKJ0cE
         EoZRexQgkQFGeM8OCfMxHLb+rlRblYfGzxzGKb++oWZXVjC4mZ7L8oowow5VFS2gnXRZ
         RfXg==
X-Gm-Message-State: AOJu0Yy00mSbO/101rhP3XhtwXDONx+bhqOX9qegFMMPmfwsVEkVQFMV
        4qkMAqpUrNXx5Q7yhciPTM1lrWkO5+lOBAhTHGI/LHH1
X-Google-Smtp-Source: AGHT+IHDuXEu9istndsd5KXwxjXxC0FTcHlx//gHVCWvUTbT4DhTnla1x7u3qpXQeDd3WFf7vS4pTA==
X-Received: by 2002:aa7:cd46:0:b0:52c:9ce1:f117 with SMTP id v6-20020aa7cd46000000b0052c9ce1f117mr2369347edw.40.1694629245683;
        Wed, 13 Sep 2023 11:20:45 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id m14-20020aa7d34e000000b0052a1a623267sm7627902edr.62.2023.09.13.11.20.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 11:20:45 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4005f0a6c2bso9345e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:20:45 -0700 (PDT)
X-Received: by 2002:a7b:c3c8:0:b0:400:fffe:edf6 with SMTP id
 t8-20020a7bc3c8000000b00400fffeedf6mr157674wmj.1.1694629244702; Wed, 13 Sep
 2023 11:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230804210644.1862287-1-dianders@chromium.org> <20230804140605.RFC.2.Iabafd062e70f6b6b554cf23eeb75f57a80f7e985@changeid>
In-Reply-To: <20230804140605.RFC.2.Iabafd062e70f6b6b554cf23eeb75f57a80f7e985@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 Sep 2023 11:20:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UCMsgAgdiRiL5_a7BWsj+unGZzuJrxr+OdyNfXtzsWiw@mail.gmail.com>
Message-ID: <CAD=FV=UCMsgAgdiRiL5_a7BWsj+unGZzuJrxr+OdyNfXtzsWiw@mail.gmail.com>
Subject: Re: [RFC PATCH 02/10] drm/panel: s6e63m0: Don't store+check prepared/enabled
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 4, 2023 at 2:07=E2=80=AFPM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> As talked about in commit d2aacaf07395 ("drm/panel: Check for already
> prepared/enabled in drm_panel"), we want to remove needless code from
> panel drivers that was storing and double-checking the
> prepared/enabled state. Even if someone was relying on the
> double-check before, that double-check is now in the core and not
> needed in individual drivers.
>
> For the s6e63m0 panel driver, this actually fixes a subtle/minor error
> handling bug in s6e63m0_prepare(). In one error case s6e63m0_prepare()
> called s6e63m0_unprepare() directly if there was an error. This call
> to s6e63m0_unprepare() would have been a no-op since ctx->prepared
> wasn't set yet.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/panel/panel-samsung-s6e63m0.c | 25 -------------------
>  1 file changed, 25 deletions(-)

In response to the cover letter [1], I proposed landing patches #1-#3
directly from here while we resolve the issues talked about in
response to patch #4 [2]. I didn't hear any complaints, so I took
Linus W's review tag from the cover letter and pushed this to
drm-misc-next.

d43f0fe153dc drm/panel: s6e63m0: Don't store+check prepared/enabled

[1] https://lore.kernel.org/r/CAD=3DFV=3DUFuUsrrZmkL8_RL5WLvkJryDwRSAy_PWTa=
-hX_p0dF+Q@mail.gmail.com
[2] https://lore.kernel.org/r/20230804140605.RFC.4.I930069a32baab6faf46d6b2=
34f89613b5cec0f14@changeid/
