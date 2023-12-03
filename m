Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81A580262A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 19:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbjLCSPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 13:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCSPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 13:15:01 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38AFE7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 10:15:07 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-daf4f0e3a0fso1882553276.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 10:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701627307; x=1702232107; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VBw8A5WuhAfyasORYk3sNHDucWPtvrzZdNlLhqgrg1E=;
        b=syukUXJKcpDNSqNjL3gh4qnnPlcUAt+jkf0fGSQAq2iNMp/CH+V+eIvlhMmelmCv+o
         c6V7WTnVHKfXdI+g3t1vYqYKznO1PYb/pESitDITsxV0z18+1cBM/PXZTY6lZ35n/4XP
         UdPuAf10WsAqYaWhTcKFs9hLVKGZmzwJSY8blZKdF+lueEWZ2pak3ZZxqewj/65siX/k
         RpBmfebJMznPakuVURqULZJYlj3h94fL8ZibvrZQ85OD93khokxZf3h0N0PophUiiy0E
         jyaDIC9XebJO/rbUGHpOAuLTKgdVgB0K2guWGZsynoqqxKdq/+bTadjxdnfHejmCI+A6
         mK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701627307; x=1702232107;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VBw8A5WuhAfyasORYk3sNHDucWPtvrzZdNlLhqgrg1E=;
        b=CVKcrekzAB08HbKrUeh4k0HZ11jp0iUxrGV5HL3zaEeZIlGLMD8pc3VkmQMgFn6aak
         k7t7Lifcj58LOX9e2Q5jxRkL5Psp69L6/ScRzXZZ9jsxSws3J6SHVoWYQTL5+RqGH4HJ
         bpijFVP4uSFXo3VM/EUe5JBBKPq6owHJNQXpFXZ01Orei0hxrHu64zaOWUCD1+WUs9mY
         xqZ3IloRRTzgETql92oYDPFxB8pggW2LpRkofcXqfMgq+s4Sb94hVx1DbIYy5UVqOrz7
         bpkF0cDbn5GBoN4kn8RUVxM2GgqDgKmsxGYA0Df/t3EYyhyyLICKtTp8XmXzkRGuL6ds
         C27A==
X-Gm-Message-State: AOJu0YxiKxDnd+VgoUUxw2JjmQqgIT1U4kzNTD39XFU6c/7hd5aa3wYE
        J2f/wSOsHA2PZ+oDRLllbN5XpzmkxsSxENxv67d92Q==
X-Google-Smtp-Source: AGHT+IFUy8B/4S31oVJp9dqmSc+u4tDNY7+u9M9vX7qbZTp0uUteKIcgNDwDYa2dp4XivmCNvukRiq8p2gb2GfW9Zyg=
X-Received: by 2002:a05:690c:3381:b0:5d6:c347:4b11 with SMTP id
 fl1-20020a05690c338100b005d6c3474b11mr1829719ywb.42.1701627307031; Sun, 03
 Dec 2023 10:15:07 -0800 (PST)
MIME-Version: 1.0
References: <20230920201358.27597-1-quic_abhinavk@quicinc.com> <20231203142441.GA26644@pendragon.ideasonboard.com>
In-Reply-To: <20231203142441.GA26644@pendragon.ideasonboard.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 3 Dec 2023 20:14:56 +0200
Message-ID: <CAA8EJpoykwsMWX+msDAB3TZaBmwE4iA4fiDiA-iOELmWd50s-w@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH] drm: improve the documentation of connector
 hpd ops
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        jani.nikula@linux.intel.com,
        Thomas Zimmermann <tzimmermann@suse.de>,
        freedreno@lists.freedesktop.org, andersson@kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        quic_parellan@quicinc.com, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>, quic_jesszhan@quicinc.com,
        David Airlie <airlied@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2023 at 16:24, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Abhinav,
>
> Thank you for the patch (and thank to Dmitry for pinging me on IRC, this
> patch got burried in my inbox).
>
> On Wed, Sep 20, 2023 at 01:13:58PM -0700, Abhinav Kumar wrote:
> > While making the changes in [1], it was noted that the documentation
> > of the enable_hpd() and disable_hpd() does not make it clear that
> > these ops should not try to do hpd state maintenance and should only
> > attempt to enable/disable hpd related hardware for the connector.
>
> s/attempt to //

I can probably fix this while applying the patch.

>
> >
> > The state management of these calls to make sure these calls are
> > balanced is handled by the DRM core and we should keep it that way
> > to minimize the overhead in the drivers which implement these ops.
> >
> > [1]: https://patchwork.freedesktop.org/patch/558387/
> >
>
> You could add a
>
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> > ---
> >  include/drm/drm_modeset_helper_vtables.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
> > index e3c3ac615909..a33cf7488737 100644
> > --- a/include/drm/drm_modeset_helper_vtables.h
> > +++ b/include/drm/drm_modeset_helper_vtables.h
> > @@ -1154,6 +1154,11 @@ struct drm_connector_helper_funcs {
> >        * This operation is optional.
> >        *
> >        * This callback is used by the drm_kms_helper_poll_enable() helpers.
> > +      *
> > +      * This operation does not need to perform any hpd state tracking as
> > +      * the DRM core handles that maintenance and ensures the calls to enable
> > +      * and disable hpd are balanced.
> > +      *
> >        */
> >       void (*enable_hpd)(struct drm_connector *connector);
> >
> > @@ -1165,6 +1170,11 @@ struct drm_connector_helper_funcs {
> >        * This operation is optional.
> >        *
> >        * This callback is used by the drm_kms_helper_poll_disable() helpers.
> > +      *
> > +      * This operation does not need to perform any hpd state tracking as
> > +      * the DRM core handles that maintenance and ensures the calls to enable
> > +      * and disable hpd are balanced.
> > +      *
> >        */
> >       void (*disable_hpd)(struct drm_connector *connector);
> >  };
>
> --
> Regards,
>
> Laurent Pinchart



-- 
With best wishes
Dmitry
