Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB5B79F10B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjIMSVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjIMSVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:21:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA5A1BC6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:21:03 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bcf2de59cso22237866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694629260; x=1695234060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GTNFmg4KNiHvvcZa1WQZtY848dk0rdfmjYkArIU+oo=;
        b=ImVfGelj9av4SZZo5uNZrhZWyVOPuEQkXDl2hKVSM1hHxAfX4r3izbLNUQ3R206BCC
         1N77yF7THE3YC6iTJOKuHi/FxJSbP/jeUCZhQBxJZitpfaK4Xcpd11RmKthGmI85EIme
         4APef53YhDnvAvp+PjM1nQde1FShew+fokhrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694629260; x=1695234060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GTNFmg4KNiHvvcZa1WQZtY848dk0rdfmjYkArIU+oo=;
        b=WokVdZsG3H3iW72IWqxkOInQdgx1F2wighHuq8ljyHls0I5sP3vSqaFhl31NoaAbWD
         F1jaV4a1qfXCX89pJUZrz9LfoE0OuJid4hcZ+NpqMF7qZIBhrw0/N+wDNgI1cT4zW1vO
         3DKpBkdSMKEeP+YfxNXbSKfhTsVU10IpzgEL3Gjfac0R3Ibi0ERKJSuvjtrU94VI5Irg
         NZSC0uyG4EkfJketGemCCvuiU8VObmkd5mLTz8bY3/QdnO7yTiMWcdMMl4KrdFcGz49m
         3m361/oLk5l+RwW1B7R+xYLog0FTVerys4n47eoMt987XRR6//9I1/Zew6JoZScucwiN
         PvqQ==
X-Gm-Message-State: AOJu0YwaUH37Ljlm9d9InYPDS97lBYKTK3PKY2srPIEKapeHVzT1vPDL
        CCSizDfGXGSYvIbeUCymbdwQOFU+5ZjvUXpIDt4ODzi1
X-Google-Smtp-Source: AGHT+IFnuMcs2hCVlMGp9vLZSKqSPq7w5rdI5eJrp8ZJuksCt+o0NkKRymJ9Rqt582+86JQekvDcHA==
X-Received: by 2002:a17:906:8a5a:b0:9a1:cdf1:ba7 with SMTP id gx26-20020a1709068a5a00b009a1cdf10ba7mr2327167ejc.15.1694629260540;
        Wed, 13 Sep 2023 11:21:00 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id hb19-20020a170906b89300b009a1fd22257fsm8727458ejb.207.2023.09.13.11.20.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 11:21:00 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso10465e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:20:59 -0700 (PDT)
X-Received: by 2002:a05:600c:1c24:b0:401:a494:2bbb with SMTP id
 j36-20020a05600c1c2400b00401a4942bbbmr160314wms.5.1694629259696; Wed, 13 Sep
 2023 11:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230804210644.1862287-1-dianders@chromium.org> <20230804140605.RFC.3.I6a4a3c81c78acf5acdc2e5b5d936e19bf57ec07a@changeid>
In-Reply-To: <20230804140605.RFC.3.I6a4a3c81c78acf5acdc2e5b5d936e19bf57ec07a@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 Sep 2023 11:20:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WtN_Ag5JsmZGb2arPr8RjhkaBPb14j+a2-+FB-aeTeXw@mail.gmail.com>
Message-ID: <CAD=FV=WtN_Ag5JsmZGb2arPr8RjhkaBPb14j+a2-+FB-aeTeXw@mail.gmail.com>
Subject: Re: [RFC PATCH 03/10] drm/panel: otm8009a: Don't double check prepared/enabled
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
> For the "otm8009a" driver we fully remove the storing of the "enabled"
> state and we remove the double-checking, but we still keep the storing
> of the "prepared" state since the backlight code in the driver checks
> it. This backlight code may not be perfectly safe since there doesn't
> appear to be sufficient synchronization between the backlight driver
> (which userspace can call into directly) and the code that's
> unpreparing the panel. However, this lack of safety is not new and can
> be addressed in a future patch.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> From quick inspection, I think the right way to handle the backlight
> properly is:
> 1. Start calling backlight_get_brightness() instead of directly
>    getting "bd->props.brightness" and bd->props.power. This should
>    return 0 for a disabled (or blanked or powered off) backlight.
> 2. Cache the backlight level in "struct otm8009a"
> 3. If the backlight isn't changing compared to the cached value, make
>    otm8009a_backlight_update_status() a no-op.
> 4. Remove the caching of the "prepared" value.
>
> That should work and always be safe because we always enable/disable
> the backlight in the panel's enable() and disable() functions. The
> backlight core has proper locking in this case. A disabled backlight
> will always return a level of 0 which will always make the backlight's
> update_status a no-op when the panel is disabled and keep us from
> trying to talk to the panel when it's off. Userspace can't directly
> cause a backlight to be enabled/disabled, it can only affect the other
> blanking modes.

Note: I'm not planning to take on the cleanup of making the backlight
of this driver work better. Ideally someone who uses / maintains the
affected hardware could give it a shot.


>  .../gpu/drm/panel/panel-orisetech-otm8009a.c    | 17 -----------------
>  1 file changed, 17 deletions(-)


In response to the cover letter [1], I proposed landing patches #1-#3
directly from here while we resolve the issues talked about in
response to patch #4 [2]. I didn't hear any complaints, so I took
Linus W's review tag from the cover letter and pushed this to
drm-misc-next.

1e0465eb16a4 drm/panel: otm8009a: Don't double check prepared/enabled

[1] https://lore.kernel.org/r/CAD=3DFV=3DUFuUsrrZmkL8_RL5WLvkJryDwRSAy_PWTa=
-hX_p0dF+Q@mail.gmail.com
[2] https://lore.kernel.org/r/20230804140605.RFC.4.I930069a32baab6faf46d6b2=
34f89613b5cec0f14@changeid/
