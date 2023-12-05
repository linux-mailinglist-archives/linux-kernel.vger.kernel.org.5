Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F02805DC5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjLESGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbjLESGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:06:04 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B956FD59
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:06:10 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c9f166581dso44487801fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 10:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701799567; x=1702404367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIfHQzLRNk16QqkBZwMJZjQhju2kwUVGG/rCp3aPtx0=;
        b=G+SarQvP6GHYdl44fJGIL2EgnFTvIV3eZCIyBGXIfs7A9o8K9tBho54/E4WTnLQcSX
         SHuDqow3ZoRISYK1zoXtVEKYul9bZtUiRV3pan01avgNhWjQVuOpdx6++PpnTEnZ2y3X
         dE+t77xpIc7o/oTofcnkFHXu/oQVcRYz1Dl2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701799567; x=1702404367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIfHQzLRNk16QqkBZwMJZjQhju2kwUVGG/rCp3aPtx0=;
        b=dnuISg+EQKzj1HBk9HcimOlhTTM7wCRp9XMpPxlwN0UOYlpHktdtG9Z4s5xo05H7Ux
         5RRfZE6JRihe45axq03PNRV7Nhg0i3QbvsU4gjzqbXt3FtvKwQyFtxeXpn7QyumVI0jZ
         wbBbR3i7bGM0mZ1IcCnX3Zpj8oMalqn0pT+BkmnXCvc65O6jAaUGVRV92kqxv+1xjwru
         deW+zVnQlnaLGbAM0IHEuxM+HklFLgwZLMINxYA3OrWjh0UfiZlZ5A04V1MJkab78WrB
         6u78IuPOF3/rUNYhi5bTE0bwlKbobt6th3vki+uYOyjLEkUaC1HRBW4R/3csTMeLaelh
         KI/Q==
X-Gm-Message-State: AOJu0YxH5JnuMElcmNjS9yu2d1FVr1rAXchiHlXgoZgsTZ+x6q84wRqD
        wGB1LcbOH8hbxt9Zsmmkek4ax8G2a75UIEE3OJX9q2E2
X-Google-Smtp-Source: AGHT+IH/C+eDcc6za8EWITj3mr1sc0F2pf5SK4KQyHfS4EG2V5OZO6uHcNRXbZRva63f/BzsvVL5OQ==
X-Received: by 2002:a2e:6819:0:b0:2ca:67:d3f7 with SMTP id c25-20020a2e6819000000b002ca0067d3f7mr1919654lja.63.1701799567351;
        Tue, 05 Dec 2023 10:06:07 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id y10-20020a056402134a00b0054c86f882bcsm1399832edw.22.2023.12.05.10.06.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 10:06:07 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so2045e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 10:06:06 -0800 (PST)
X-Received: by 2002:a7b:cb59:0:b0:40b:4221:4085 with SMTP id
 v25-20020a7bcb59000000b0040b42214085mr551583wmj.1.1701799566754; Tue, 05 Dec
 2023 10:06:06 -0800 (PST)
MIME-Version: 1.0
References: <20231205123630.988663-1-treapking@chromium.org> <20231205123630.988663-2-treapking@chromium.org>
In-Reply-To: <20231205123630.988663-2-treapking@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Dec 2023 10:05:54 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U_PpD=tsyP7QuXU2p-R24U6JXAWQONPT_ioMr1P7E-aw@mail.gmail.com>
Message-ID: <CAD=FV=U_PpD=tsyP7QuXU2p-R24U6JXAWQONPT_ioMr1P7E-aw@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/panel-edp: Add powered_on_to_enable delay
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 5, 2023 at 4:36=E2=80=AFAM Pin-yen Lin <treapking@chromium.org>=
 wrote:
>
> Add the support of powered_on_to_enable delay as the minimum time that
> needs to have passed between the panel powered on and enable may begin.
>
> This delay is seen in BOE panels as the minimum delay of T3+T4+T5+T6+T8
> in the eDP timing diagrams.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
>
>  drivers/gpu/drm/panel/panel-edp.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

This needs to bake a little while on the lists (1-2 weeks) before I
apply it in case others have opinions.
