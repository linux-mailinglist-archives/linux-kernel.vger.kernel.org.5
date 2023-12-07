Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF9F808FE2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443724AbjLGSXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443688AbjLGSXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:23:51 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3E91718
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:23:57 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a1eb422b412so211859266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 10:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701973433; x=1702578233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1yF2nbpTBS+jUEhedo6G2ntKnSSa7ydctF2qRUubWQ=;
        b=XypoBWDXvsowrtiroRwPcfe7ICXGJ1wGTt82ECUKckz5QNp2q1ZxY/8mAgKy4npkpJ
         th6FLAI6KGYt77sLqbp1B1AjKlgeYfwZet3NcXJyUtiXxHQ6BaghIBk1oHWdIESmc+vU
         hZS+2yv+1PYhrN15n4YxgztoKFh3BrprrXsJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701973433; x=1702578233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1yF2nbpTBS+jUEhedo6G2ntKnSSa7ydctF2qRUubWQ=;
        b=PKFFuMwaloirXKQKT75l1rZnf7H7sdC2d7Q2QLGhPgOqJws7/1xSjs/Iimj4v/OlZA
         aICUnYou//py1lNiA9Lc86Ub59V6FpzzuipW6JJkOUDBMVFetDGoFC65UjqoW0sXD/E/
         aXdcZRRdDIHQ7UwzgkBGNEvc7UtglMsKNXsmCuoJoFoAb8LCa2gEdUq0zEts8E9qU7qB
         8Dsm8cd03nwkaQXogO1+UCl45MKkkcMY/gLdHHXq/dlnq6yy+VioFzmjiXcM6cYkaeoZ
         dDo80/W8LgS3E5Bys8kKjYlTivsJsxtNJ0l4Sf6anjAnEOIznO8zdV8L4qEfjGQXMZtQ
         GzSw==
X-Gm-Message-State: AOJu0Yx26gTgn4aeBFdUGId7C4NsH7gezGt+kp1A4sc0zgS8qyCrOUN8
        AgSmeZh1gJuXMtVV+LgseSEZune9dZIlsf6EsgM3de4A
X-Google-Smtp-Source: AGHT+IGopSf8q0dTnLjnscAFnDRlNysz9VGL2huvoThLErRLUo358HIIeXjU0lm6Uf1GdMtE1cfdFA==
X-Received: by 2002:a17:906:197:b0:a1c:892e:9e68 with SMTP id 23-20020a170906019700b00a1c892e9e68mr4747590ejb.29.1701973433059;
        Thu, 07 Dec 2023 10:23:53 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id sn24-20020a170906629800b00a1da72b874bsm50848ejc.175.2023.12.07.10.23.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 10:23:52 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so3685e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 10:23:52 -0800 (PST)
X-Received: by 2002:a05:600c:231a:b0:405:320a:44f9 with SMTP id
 26-20020a05600c231a00b00405320a44f9mr220940wmo.5.1701973431985; Thu, 07 Dec
 2023 10:23:51 -0800 (PST)
MIME-Version: 1.0
References: <20231207081801.4049075-1-treapking@chromium.org> <20231207081801.4049075-3-treapking@chromium.org>
In-Reply-To: <20231207081801.4049075-3-treapking@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 7 Dec 2023 10:23:36 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WdUXKmZZMnEDsGeSrAyM831zPUom9QLWbnm0nPieZv_A@mail.gmail.com>
Message-ID: <CAD=FV=WdUXKmZZMnEDsGeSrAyM831zPUom9QLWbnm0nPieZv_A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] drm/panel-edp: Add powered_on_to_enable delay
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

On Thu, Dec 7, 2023 at 12:18=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
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
> (no changes since v1)
>
>  drivers/gpu/drm/panel/panel-edp.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Should have carried my tag from v1 since there were no changes:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

As per my response in v1: This needs to bake a little while on the
lists (1-2 weeks) before I apply it in case others have opinions.
