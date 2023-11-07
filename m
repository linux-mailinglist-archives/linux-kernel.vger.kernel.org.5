Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9DD7E4B2B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344144AbjKGVwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbjKGVwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:52:37 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EF010D1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:52:35 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6ce2c5b2154so3946425a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 13:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699393954; x=1699998754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hr6OJPuRPVCp0RXxF4a/PiIEDPuvoDXkbrySHNg/Fqs=;
        b=hNBB6Oh5W8ZmqZz8Sgm6mDA2SFueIXnArQke0wAHRA3cKzPvRGcNE3TtlgAA0iNNpQ
         CdyfZT2vaTJHyMd1HuC2indTXWY2zyVzU7MJJE7g5spfwcPpDYnJmuKGXEajbJeLE1kI
         uGFWzVV2T5vHpD0zessEYcr5CXunKna4JVxG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699393954; x=1699998754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hr6OJPuRPVCp0RXxF4a/PiIEDPuvoDXkbrySHNg/Fqs=;
        b=JZH2giWuRVUGb5SFNykD49I9JtLE5P5RFERKMHfmGPpblARch3vwwLI7eyx3R/gZ8v
         nR7KDXo30G3QIxEAZWVKB+f8bF+3pFqNKOKAwT6Eb5YOgpFu6BnykEU7qwgmbN27Ujq8
         GVrY8uZWw06c+lLUvxZCoFW4pydnj6UW8FQ45mdeQ+k3Ql6z0NXN9umz6rvTWwKkTt+Z
         1mYfY9PBKjRH1LHohXfyZpyC1CuMRfRQ26R7D35ahbfmMKXKXFpB/MNjva044AtS1DCr
         wdApWln05b8pNJIq5h15ANKTMLuhNGm9aN14fN4GZC1DtHvmMAGSLztD/GjEXVU/8qTO
         9mdA==
X-Gm-Message-State: AOJu0Yz7QEP+nDCtdNw8VqQMqj5XARG+yvHdQUnzRRPJ+sMxGs/nv6wq
        VcGDCBa/jS06jfxCaxuH5NNF9TkhTB3ya722BMYqFg==
X-Google-Smtp-Source: AGHT+IHWdfR3bifkBdaoItNqZgulqc9J+gktiX1J+gjiJGeRkyvmNQ2VXl6l87uKMgSgtxr3xR3fX2EtFYyzpaToq3g=
X-Received: by 2002:a9d:7e91:0:b0:6d2:e1fd:9f5e with SMTP id
 m17-20020a9d7e91000000b006d2e1fd9f5emr127321otp.6.1699393954786; Tue, 07 Nov
 2023 13:52:34 -0800 (PST)
MIME-Version: 1.0
References: <20231107204611.3082200-1-hsinyi@chromium.org> <20231107204611.3082200-4-hsinyi@chromium.org>
 <2023110739-parmesan-exposure-8225@gregkh>
In-Reply-To: <2023110739-parmesan-exposure-8225@gregkh>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 7 Nov 2023 13:52:08 -0800
Message-ID: <CAJMQK-g-hSN_dY5EjhuvAU4sAL0dMR7s=3murQm8E_GubS1+pw@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] drm/panel-edp: drm/panel-edp: Add several generic
 edp panels
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
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

On Tue, Nov 7, 2023 at 12:57=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Nov 07, 2023 at 12:41:53PM -0800, Hsin-Yi Wang wrote:
> > Add a few generic edp panels used by mt8186 chromebooks.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > no change.
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 51 +++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
> for how to do this properly.
>
Sorry for confusion, only patch 1 & 2 need to be picked to stable. 3~5 don'=
t.

> </formletter>
