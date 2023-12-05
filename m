Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4495D805DBE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbjLESFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345563AbjLESF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:05:26 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A40AB2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:05:32 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a00cbb83c80so801529666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 10:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701799530; x=1702404330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/V+PxHL1FW8rgKB1502EvHkVxrAYI9iWPYYV+GrNQZ0=;
        b=FWou38cW4it3dkmJRX/U6Ce2TY1IO4lxfL87KeOyjeogD47gc63JGJ0RkkEhj2/TyE
         RLtBxP/wYNdaSevqbC6TWiuuj5I1zdQymbxIkUZtgkJe4AEGLj7vauc3vK7mO0ZYmXVk
         d12EDW3JRsLq2ADY2kJQuKVxtIrLuIEayQfpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701799530; x=1702404330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/V+PxHL1FW8rgKB1502EvHkVxrAYI9iWPYYV+GrNQZ0=;
        b=JPNcSLlfttp+al8bs5xwELpxSAH5UZBWNCbjkGz5ic6qeFo04pXhuxveudrgxhTp6V
         ZgBI2A7D4BV39ykj8ay9zALRf4Ztbn76RdaEEHz8YH4kqnfme10T8AplobGoJKf5fNaK
         wlemVUrMOamtlQ1SW8ZLyOnsHS4sKz+CsfJ/4rR6tuvEtS5qQ1ka49RIUnZuyjvAZSuw
         x8HtRlNF0MD+YfcVVAvQcNip69iXSuHwM7GwLg2Xt6Y3G52OyOW8opvm54iIARAyw6Da
         1xVjmBOMoClvOnJ04RcpJkGjHm20C3I7hNPsPJOYDUBlkJqIlF/yOzlEz3xYXskucwXZ
         fCHQ==
X-Gm-Message-State: AOJu0Yy/90KgKLX3FgPMXtyp4J2ajd2+ehTWzHrtS3KhwqYBFMjVvZz9
        C+5aGTOlE3t2uDRSYn1lZ4uIgnaZ2401+5OK12uViq60
X-Google-Smtp-Source: AGHT+IG5i585vTMA7Tz4CjS0X7nDmtoX7GqX4q1fUoNGPOdHR144MQaIGTWF4CKQhlU/PsALiZYqJQ==
X-Received: by 2002:a17:906:7385:b0:a19:a19a:eaa4 with SMTP id f5-20020a170906738500b00a19a19aeaa4mr556609ejl.93.1701799530119;
        Tue, 05 Dec 2023 10:05:30 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id e20-20020a1709062c1400b00a1c7b20e9e6sm1151265ejh.32.2023.12.05.10.05.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 10:05:29 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40b35199f94so3145e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 10:05:29 -0800 (PST)
X-Received: by 2002:a1c:7202:0:b0:40b:4355:a04b with SMTP id
 n2-20020a1c7202000000b0040b4355a04bmr588480wmc.6.1701799528753; Tue, 05 Dec
 2023 10:05:28 -0800 (PST)
MIME-Version: 1.0
References: <20231205123630.988663-1-treapking@chromium.org> <20231205123630.988663-3-treapking@chromium.org>
In-Reply-To: <20231205123630.988663-3-treapking@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Dec 2023 10:05:16 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VPLmM8CJY91M0JiboB2efk=td45geo_1oD_eXsRgfSJA@mail.gmail.com>
Message-ID: <CAD=FV=VPLmM8CJY91M0JiboB2efk=td45geo_1oD_eXsRgfSJA@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/edp-panel: Sort the panel entries
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
> Move the order of CMN 0x14e5 to make the list sorted.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
>
>  drivers/gpu/drm/panel/panel-edp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Pushed to drm-misc-next:

4900e0396e59 drm/edp-panel: Sort the panel entries
