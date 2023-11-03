Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA85C7E0956
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345723AbjKCTSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 15:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjKCTSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:18:39 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF14D194
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 12:18:33 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6d30d9f4549so1449965a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 12:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699039113; x=1699643913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXnGRlRT6UDgUW63xKhU+4algxK/8pXZcAoscYXgMrU=;
        b=XJcANQAv0XSei+t3NE4WTGZXUEqeEUYKHiQl6JvT/4eHyZJpl2om4sPleo7NQEeYhC
         7H0Ec1xJYe2c/FJ/OgHQMmKcSjmG7v508ofJi0vpG4LAuood7vaslt2oA+sJPwicYPgo
         Qa6f5Lyuh4FjXm3N0HYW/vtLimW6fXG9tXOXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699039113; x=1699643913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXnGRlRT6UDgUW63xKhU+4algxK/8pXZcAoscYXgMrU=;
        b=If1yqGueHtVQuBDbOl6YNEsRNApHcz/1vp9mW/DKG5+KIXdgt5RckJ3vo0czRrZNMi
         mOmwK3/KFk/+IckFt8cKhFDfSQ06HwAAEzo7BItV+FHJnrfKry6aSD9tFpbchrUtFnA+
         MPYMAIBeVa6Eq5wu0fwKIZXE1QqZ4WcBWrZdvLTdCvkm4fucsOXSWquFKZ44N7g+p4Av
         E7olOVSpKwDq04onQA6zJVMFAXIP8vqQIEld+hYMF3fVDMjwZcZx6STgkup0GfEAqofy
         F5nKbG41q7ZhNxf/0gLcj7tPZD1zob2oI81kiS3WXiAx0pj+vFUgc6mWhyXVOA9yciT0
         LAYw==
X-Gm-Message-State: AOJu0YxwRoNlm6XKxlfKSPYwf1Bjty/C90WtbL2smuewntHMTJsrQBhI
        gtraTiThCBTgG+EQtlk2IaG5YaQIyFZo9HCWKLwD/w==
X-Google-Smtp-Source: AGHT+IHBqvIZeW8h2w6MoYxUP6Q+AETTRg33Ap1XVHSWkyuPX/JGNntllDnfUVVTZGZ0cTtuPSVpssYNlfORukcvaZk=
X-Received: by 2002:a05:6830:2b29:b0:6d3:2d45:3b46 with SMTP id
 l41-20020a0568302b2900b006d32d453b46mr5613777otv.31.1699039113156; Fri, 03
 Nov 2023 12:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231102221309.1971910-1-hsinyi@chromium.org> <20231102221309.1971910-5-hsinyi@chromium.org>
 <CAD=FV=XEnk1TuWsJB6W5PGisg3_0A3HZMGpxEUrtcDxXK=Z+Eg@mail.gmail.com>
In-Reply-To: <CAD=FV=XEnk1TuWsJB6W5PGisg3_0A3HZMGpxEUrtcDxXK=Z+Eg@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 3 Nov 2023 12:18:07 -0700
Message-ID: <CAJMQK-iuDrLhpviSOXqhUvjRuzh6q=ENvtmoX_2LXv1=X8g+XA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/panel-edp: Choose correct preferred mode
To:     Doug Anderson <dianders@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 9:03=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Thu, Nov 2, 2023 at 3:13=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org>=
 wrote:
> >
> > If a non generic edp-panel is under aux-bus, the mode read from edid wo=
uld
> > still be selected as preferred and results in multiple preferred modes,
> > which is ambiguous.
> >
> > If a hard-coded mode is present, unset the preferred bit of the modes r=
ead
> > from edid.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> > v1->v2: split patches from drm_modes.
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> Do you think this should have a "Fixes?" As per discussion on V1 [1],
> this has probably been a bit broken from the beginning, though I guess
> it only became a big deal after the AUX bus made it so that the panel
> driver commonly had the EDID...
>
If this patch needs to apply Fixes, then the previous patch might also have=
 to?

Fixes: 280921de7241 ("drm/panel: Add simple panel support")


> [1] https://lore.kernel.org/r/CAD=3DFV=3DWHzCdiYumsxUm_am+ALqq9SOOrjf=3DJ=
YHqJuiKFB+Dnsw@mail.gmail.com
