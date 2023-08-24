Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D53B7873C3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242126AbjHXPMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242104AbjHXPMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:12:13 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A2EC7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:12:11 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-649a653479bso35792126d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20221208.gappssmtp.com; s=20221208; t=1692889931; x=1693494731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gKObriympOeNKMv/q1LmfMAqJXRFcpvTzk+LBnFI9Do=;
        b=L6Rav7TEl/cmVgeGDFTk/95bD6/oGcwRBoB33dJQQM5ZdUY4TvFciWG32PBby6zop0
         1TykTUgvvvT8gOENRI9wb3DHk+QJOLnqhNlk8VuFlpUdjjF5xmyl78c6tZ+69MRWmBs8
         sNtUaHNvfmqb6CAx2HQcugLxDRLES063/AMyFIdiEFcSwIcF+Sxb7iZE1R8w40iWuDAk
         UkoxFsCYGEzWbUd1wbH/Fi7D4jOLFyuvYSKvWaSTy91DzJxsNanUGcgMmO0QOhMz9UA2
         ruAhVZdCvkLB4jpjzlRianrnPBGQKfVnYf0EZHmqi1f0TIcKxliMAoM9SnmjewS4OdIC
         ITIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692889931; x=1693494731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gKObriympOeNKMv/q1LmfMAqJXRFcpvTzk+LBnFI9Do=;
        b=TsfQSaS7X0Ecx9UgB0/bK97a8kJSTIn7s71BOumPUjRWGGUQ/T+byXsLX6PejcUx/i
         0wf9ZTOMWh/t3qG+5hLBG6CcwJt7y/qE5oAscBc9VoKOI6dj13NmtphBPCXLjiU0KPwG
         U1zEPmuYhHJWl0ziIyUn35qfYr4tWVgtur90c31ApDtMJSDgSNasBSdt2J3mvadQbnAh
         tFwETQJt02gMikZaBJfrj5fUYiqoO5YriszVY5YkOZ2sOqh9JFc6PPSy5Twe/KlKZ/7X
         HLToRRtGzw0igqd3ewMM6DNwzaAbsIxn5qNiT3Wh2yyza1ATaUajQz9bL2rt2F6pbaMx
         1wKQ==
X-Gm-Message-State: AOJu0YyudDmqD+Csac38nNsSVA7lqS6TizNcpVqzb5JTHuxP3JKjZ7ye
        a8IYxvhqTY1+zWAo/CMKcN5VCvX1bjhkheGmKUegYQ==
X-Google-Smtp-Source: AGHT+IGzc1eptkc6jGGfl4yF9wMbyUJ8hqtRlaCPtnoUpteoJ6QvxFp8v8A85gxCC0FxqtNA7YTh3ZzUKQedrXTvQxU=
X-Received: by 2002:a05:6214:5d0c:b0:642:d729:35ec with SMTP id
 me12-20020a0562145d0c00b00642d72935ecmr15520155qvb.51.1692889930894; Thu, 24
 Aug 2023 08:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692888745.git.geert@linux-m68k.org> <50762fd1694d3b5f6df1bdfa482564adb2ee7f36.1692888745.git.geert@linux-m68k.org>
In-Reply-To: <50762fd1694d3b5f6df1bdfa482564adb2ee7f36.1692888745.git.geert@linux-m68k.org>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Thu, 24 Aug 2023 16:11:59 +0100
Message-ID: <CAPj87rNr7PTcquaz+VzwmXh0mSWSSK25_Fa6uxC2VOfj=wMmcQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] drm/client: Convert drm_client_buffer_addfb() to drm_mode_addfb2()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Thu, 24 Aug 2023 at 16:09, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>         struct drm_client_dev *client = buffer->client;
> -       struct drm_mode_fb_cmd fb_req = { };
> -       const struct drm_format_info *info;
> +       struct drm_mode_fb_cmd2 fb_req = { };
>         int ret;
>
> -       info = drm_format_info(format);
> -       fb_req.bpp = drm_format_info_bpp(info, 0);
> -       fb_req.depth = info->depth;
>         fb_req.width = width;
>         fb_req.height = height;
> -       fb_req.handle = handle;
> -       fb_req.pitch = buffer->pitch;
> +       fb_req.pixel_format = format;
> +       fb_req.handles[0] = handle;
> +       fb_req.pitches[0] = buffer->pitch;
>
> -       ret = drm_mode_addfb(client->dev, &fb_req, client->file);
> +       ret = drm_mode_addfb2(client->dev, &fb_req, client->file);
>         if (ret)
>                 return ret;

This should explicitly set the LINEAR modifier (and the modifier flag)
if the driver supports modifiers.

Cheers,
Daniel
