Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A2878DD89
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244927AbjH3Svj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244980AbjH3OPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:15:42 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766B1CC2;
        Wed, 30 Aug 2023 07:15:39 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5733d431209so3436000eaf.0;
        Wed, 30 Aug 2023 07:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693404938; x=1694009738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCpeAPS/CibFq665kaK2mvNCIQFGx1fXEcmTzAPISWc=;
        b=Ebq/sZ8K1DskKXc0Ci050dJg+t6fK1BsIPhrEeX3GpFkrWupeVc1LwE/SPcVM1yk42
         v1aBKw2x+VO8tIr/2KIXqkzeopIOGRY4wra8y6mDe9Yri6AYcaWWAGky9qZPY2FN2AN/
         ZmnWhaUp7A+abU25oIxu+aiXqBTu899GeeIazsFxN/WFogwGNwlYwiUBFP1+Xr9F5QQd
         Q/MarxafLUOddF44LwQYaeu5IIv8pIdZJhx70qTIc8grrxLbBoP07xzdoDkNA8GWnxlq
         IrfBUuCbPT0PcB3Q03iVflgkWXRpID0C+pr5lgiopuC1mRbLai3W+Zw4qISpPp1mZkvQ
         n9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693404938; x=1694009738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yCpeAPS/CibFq665kaK2mvNCIQFGx1fXEcmTzAPISWc=;
        b=jj8OhaAoBQZonOrBOLn0Jm5PREDzCcdxVu9b20cGahFWJ1kb97VLH9+cMfxOfrvTfM
         xwuMJQZ2mffh7Hq91s3WDUcv7FUOx7w7bxbIxpbu7sE7mUgRUc1IB8Gnvlu6x55KtYWA
         jVC3wWDrx3bVMeuoL+ngaVkbx5eU+1EIaH2DGg7BHuQ8ausXkrA+yW04xvh51NCdnGcB
         JApoJh7g35mSfoxTVvWE00gXlsd5ny9WvNduY8gHwlDuWARCEKvpv7btKmfR2WbK0wOW
         3FE7GEfKL55HN6vGJ2bl74xIQLphKiZQFYkwJ87N9db02d8zSFbyME/GLC/B5rWHEULP
         URVQ==
X-Gm-Message-State: AOJu0Yy5WMo9mZYFYOTGAVXPkvPRfr2Unas83dd66UrPFCiPEO4yVAEg
        etFl0j+Sr3pwG+4ntPJEUYfZX3uvW9shrwLmapk=
X-Google-Smtp-Source: AGHT+IFFDnRR2uY0HMprngD3qnR0QCHLsvwLy0H6o8N6F5irKWos3ZRHDcMLDSu3VnmsJJtI9HCVvtNsuy0h6t1SXXo=
X-Received: by 2002:a4a:9196:0:b0:571:28d5:2c77 with SMTP id
 d22-20020a4a9196000000b0057128d52c77mr2188112ooh.5.1693404938283; Wed, 30 Aug
 2023 07:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693386602.git.pstanner@redhat.com> <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
In-Reply-To: <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 30 Aug 2023 17:15:02 +0300
Message-ID: <CAHp75Vc72uuNvFxq4TGO=nXoGhbqVxyqvQ67ioL8ajtZwMUBgA@mail.gmail.com>
Subject: Re: [PATCH 1/5] string.h: add array-wrappers for (v)memdup_user()
To:     Philipp Stanner <pstanner@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Siddh Raman Pant <code@siddh.me>,
        Nick Alcock <nick.alcock@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
        David Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 4:46=E2=80=AFPM Philipp Stanner <pstanner@redhat.co=
m> wrote:

> +       if (unlikely(check_mul_overflow(n, size, &nbytes)))
> +               return ERR_PTR(-EINVAL);

> +       if (unlikely(check_mul_overflow(n, size, &nbytes)))
> +               return ERR_PTR(-EINVAL);

Btw, why not -EOVERFLOW ?

--=20
With Best Regards,
Andy Shevchenko
