Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2782D753838
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbjGNKcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbjGNKcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:32:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38074113
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689330693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8jXCCHC4y1vsxfQDMi0JiCwzaiAjNotpxpWdfoFM8jU=;
        b=BRpfyQHRh4P3Qk/sc6u1RAFctkt9CXBoCbupfjIQrJbdMNWYzuc2BxRprfucaybaVPmB4Y
        UDSpURVtt0he3TvGCXIUJqb8McHJiu7tj7dE6vQ08em4TGs+lGqkYsaGBeHZyXAfHwqT68
        B5EPe1zSl74yltLxC3f5teZm+zGAWNw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-2kEMNsJyMyicmmxO92TF3w-1; Fri, 14 Jul 2023 06:31:32 -0400
X-MC-Unique: 2kEMNsJyMyicmmxO92TF3w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-313c930ee0eso1042959f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689330691; x=1691922691;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8jXCCHC4y1vsxfQDMi0JiCwzaiAjNotpxpWdfoFM8jU=;
        b=BKj0qc1t0HJB7DzO0+vIVmlLunYrawINHswoLa9OW7Gor+n7lWh/F8grunffapaMJv
         6276ww3TP6j6sL5TR4bw8ruDSMmd/q1u7X7AatXNLp72LpDE3Y0vAPP81SW2PnlJ6g6E
         S/qEuFrISvgqMsl/V051EU08CZk5Sj5PsddO23Yvw7igzGV9DeNj6DdwxKzV6TVvFrW0
         jxm8WdT1kgvgF2FCtk7UV/EcWPR+RoOKrvkwTHVvadPUfDN+/FsvJaleNoa5fKUWLorE
         +sDT2sHV+Pyqt5QxUmMdFx/rFgF8NVasap4a/RfSovTGrZbtU/6JkzpmReBPEcryhCOn
         R1nw==
X-Gm-Message-State: ABy/qLajOFdj3hpeLB10GiWN1N56l8bEkS6MtmOGJHWQNwHqKcxQ3ZsM
        DIinSonNaGnB7vreV+3ARzt6F64DSyEMytWmtT0huqL3dggpEiruTfS8JhamAVq743RWj2AlolY
        WY4mxzuzQj6IBF56mYEbxzRVP
X-Received: by 2002:a5d:6284:0:b0:316:ee7f:f9bb with SMTP id k4-20020a5d6284000000b00316ee7ff9bbmr1403794wru.65.1689330691153;
        Fri, 14 Jul 2023 03:31:31 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG0X90UuOfeNu2I3m1p8qQ1ruGOuu/vwVx5NDCfHvE8kg8Gme+6Wxg4oIzkL+SNe2n/ZO0qTg==
X-Received: by 2002:a5d:6284:0:b0:316:ee7f:f9bb with SMTP id k4-20020a5d6284000000b00316ee7ff9bbmr1403782wru.65.1689330690896;
        Fri, 14 Jul 2023 03:31:30 -0700 (PDT)
Received: from localhost ([91.126.32.244])
        by smtp.gmail.com with ESMTPSA id f10-20020adff98a000000b003159d2dabbasm10414266wrr.94.2023.07.14.03.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 03:31:29 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 7/8] drm/fb-helper: Add support for DRM_FORMAT_R1
In-Reply-To: <ea0d68ef5630fe9748a11e50f6d79f79a768ebdb.1689252746.git.geert@linux-m68k.org>
References: <cover.1689252746.git.geert@linux-m68k.org>
 <ea0d68ef5630fe9748a11e50f6d79f79a768ebdb.1689252746.git.geert@linux-m68k.org>
Date:   Fri, 14 Jul 2023 12:31:27 +0200
Message-ID: <87a5vyu6m8.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Add support for the monochrome light-on-dark buffer format (R1) to the
> fb helper, so this format can be used for fbdev emulation and for the
> text console.  This avoids the overhead of using XR24 and the associated
> conversions on display hardware that supports only a simple monochrome
> format.
>
> R1 is very similar to C1 (monochrome indexed color), and shares the same
> depth and bpp.  As drm_mode_legacy_fb_format() returns a format based on
> only depth and bpp, it cannot distinguish between R1 and C1.  Hence
> drm_fb_helper_find_format() is modified to try to fall back to R1 if C1
> is not supported.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

