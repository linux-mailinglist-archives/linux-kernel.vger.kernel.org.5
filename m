Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FEF758284
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjGRQu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjGRQux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:50:53 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1E319A;
        Tue, 18 Jul 2023 09:50:51 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fa86b08efcso9885825e9.1;
        Tue, 18 Jul 2023 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689699050; x=1692291050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oB4ZyTPiRMh8uiHtJckpmyXEBsp+YxvtmLWlUvgMk/M=;
        b=Y1+OUm+KfnhNxz2FsnvadTldRBXR977AylELwvjFF8aABcT5TuWYDrR1jsjviIpW83
         OAF/Ux11x6X+51dIzA62iasPzvSM4umD/lUeeUAhk/mh0NBfJu1exB+uSFtZfqNQB5Nl
         eOp8M46GxxHQJ8glNcis3nOErtYTNxsNbh+g0yph0R9gNTj8Y1bQNza+BS2DyBHkJDhg
         DKxfWVmiQMnyQDGcMAR1QSsQTWU+jK70mdkdhS3O0VgmrMuuA26DcNKXFVA3qy7KhzmU
         FdV0sPn04MJctdvZDYGSQQ66j/fLDDKiHsLlMJs+9uehKQxagFCXOeWjTlDhRxBwXmFG
         eT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689699050; x=1692291050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oB4ZyTPiRMh8uiHtJckpmyXEBsp+YxvtmLWlUvgMk/M=;
        b=fTl7lD1skAulnkgDuxESq+p2Zciu/Jt87zh+SFYhYBgaMQ6ZDSDvxzsyFQcokzn7RK
         5ApUKJM7eEOCHyae4iAlRsAWGVytERmrrV9EK5XGCzQFwvqDFdZlbOXx/4niLs0VU2VG
         KL+IoncWM0F0AuPE95nTk7FsIuzeWIjbnDMh+dLOddbQKUuf454VOup4dXA1ZtCHtvV1
         fS/5scNJHtDi6aIrosxOMDQS5OauiQTgdc3sHMklq7bxDCY8J4SzreMX0pYb646J3iWN
         5Cr73pq+64qjVBnM/i06lfhQ2N5kgAbbQqlxv/RjBDWzbwz0/ykGYJRhgqobpinh/wIy
         SL4g==
X-Gm-Message-State: ABy/qLY2VzBhXwunMdTgWGDaQxND4SXsoC7fXE61c2MzP1fGo8d6p/7Q
        bhjB5evBqHeZC8iIpTXHtKKOh9UOhx1k3AylUk8=
X-Google-Smtp-Source: APBJJlHv0cXnhyUAmRhq8/SgUT8OUQAJDxLPpI/PxYmchWVx6/iDfgSesWfaOELdt2qAkI5m3P4LygqZPZvXw2DAxkY=
X-Received: by 2002:a05:600c:3b1d:b0:3f9:bf0e:a312 with SMTP id
 m29-20020a05600c3b1d00b003f9bf0ea312mr22373wms.1.1689699049984; Tue, 18 Jul
 2023 09:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230718-thermal-sun8i-registration-v1-1-c95b1b070340@kernel.org>
In-Reply-To: <20230718-thermal-sun8i-registration-v1-1-c95b1b070340@kernel.org>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Tue, 18 Jul 2023 09:50:23 -0700
Message-ID: <CA+E=qVej1K7x=8-27J-Xw2E5JrJ0hgqf__XRzBdewujFsr2cPw@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/sun8i: Don't fail probe due to zone
 registration failure
To:     Mark Brown <broonie@kernel.org>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hugh Dickins <hughd@google.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 8:05=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> Currently the sun8i thermal driver will fail to probe if any of the
> thermal zones it is registering fails to register with the thermal core.
> Since we currently do not define any trip points for the GPU thermal
> zones on at least A64 or H5 this means that we have no thermal support
> on these platforms:
>
> [    1.698703] thermal_sys: Failed to find 'trips' node
> [    1.698707] thermal_sys: Failed to find trip points for thermal-sensor=
 id=3D1
>
> even though the main CPU thermal zone on both SoCs is fully configured.
> This does not seem ideal, while we may not be able to use all the zones
> it seems better to have those zones which are usable be operational.
> Instead just carry on registering zones if we get any non-deferral
> error, allowing use of those zones which are usable.
>
> This means that we also need to update the interrupt handler to not
> attempt to notify the core for events on zones which we have not
> registered, I didn't see an ability to mask individual interrupts and
> I would expect that interrupts would still be indicated in the ISR even
> if they were masked.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Vasily Khoruzhick <anarsoul@gmail.com>
