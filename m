Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B687E2EB5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjKFVMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjKFVMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:12:50 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FAFD76
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:12:47 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9dbb3d12aefso714504766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 13:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699305162; x=1699909962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fUcm+yN6XAMjy25ZogKbU2Yy8ZDqJ+sIhPAHGmb2ZM=;
        b=C1QRDL3f+CGiMD3LKE74yCnlqFyDm/nsFS6VQLSJhmPOZ8rwbXuoPJ0eBTfbD4Rcpf
         GHVyMaEwY5Jsyvmbes5Qpzsd7mVMcCF+y+idEZZ9OEsj4h/hbVMLvKtgtQ+jdRTL5Qka
         +zpnen0e8ROOStYomE6hMaoOMQ20Ma+PQpNRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699305162; x=1699909962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fUcm+yN6XAMjy25ZogKbU2Yy8ZDqJ+sIhPAHGmb2ZM=;
        b=mESAiZcOGqzbxt2t9L0JKDyQRYThRps+erzU89BB0N9AkV99i7wA50Nvdfq4LfLGyO
         bdf/lJQVvTFs8JtwrslZv3WthmG4vjGWnTys7y/OSAREzg4JrEq1kV3wM51Lv+JSDxuu
         DHSZrzrvmZPrgn5rv5ZI0dsmHf2kzuSztIQZE844WhanZ6mTZIuxffbK9vMvj50imYqs
         x3R1Qh3IuN5GQFn3BqDef6Qmxxwf4V8Hju3jr3/HGdDzXdS2wOzL0DWcXdyM4B36kcTK
         TfgFCrwR0/25yqaYq0F/anqPzTIVAKXirkyD260Oj4E+bZ/p20na+K4hAjD+Hul4T7CV
         Jpqg==
X-Gm-Message-State: AOJu0YxwfNV3bumeZ3iIsqpVHbmquYCzFYHGM8l6f5wbeIk19VY7wovw
        hFKWEb2JAEg1N+IYTtEshnh8h2ZI4Ym9XNmVOERJiBCP
X-Google-Smtp-Source: AGHT+IEYZwB7kdvOa2R8DqPoBFtpCrprjRFdEq4fcT4tfuXYxbRUxLW+ovhzMAsvacY4CmsmRN8VWQ==
X-Received: by 2002:a17:907:26c9:b0:9e0:dde:cc9f with SMTP id bp9-20020a17090726c900b009e00ddecc9fmr4053633ejc.22.1699305162351;
        Mon, 06 Nov 2023 13:12:42 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id jp27-20020a170906f75b00b009b94c545678sm251117ejb.153.2023.11.06.13.12.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 13:12:41 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40853f2e93eso22915e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 13:12:41 -0800 (PST)
X-Received: by 2002:a05:600c:1f92:b0:407:7f21:878e with SMTP id
 je18-20020a05600c1f9200b004077f21878emr5139wmb.1.1699305160926; Mon, 06 Nov
 2023 13:12:40 -0800 (PST)
MIME-Version: 1.0
References: <20231106210337.2900034-1-hsinyi@chromium.org> <20231106210337.2900034-4-hsinyi@chromium.org>
In-Reply-To: <20231106210337.2900034-4-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Nov 2023 13:12:23 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VYd96GKM9VzmOPbF55-QEVL3EaCHhY8g+7hPSrDBL31Q@mail.gmail.com>
Message-ID: <CAD=FV=VYd96GKM9VzmOPbF55-QEVL3EaCHhY8g+7hPSrDBL31Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] drm/panel-edp: Avoid adding multiple preferred modes
To:     Hsin-Yi Wang <hsinyi@chromium.org>
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

On Mon, Nov 6, 2023 at 1:03=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> w=
rote:
>
> @@ -622,7 +627,7 @@ static int panel_edp_get_modes(struct drm_panel *pane=
l,
>          * and no modes (the generic edp-panel case) because it will clob=
ber
>          * the display_info that was already set by drm_add_edid_modes().
>          */
> -       if (p->desc->num_timings || p->desc->num_modes)
> +       if (has_hard_coded_modes)

nit: the comment above this line is a bit confusing now and probably
needs to be updated or removed.
