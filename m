Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E0F799CF2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 09:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346412AbjIJHoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 03:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbjIJHoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 03:44:24 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AC01A5;
        Sun, 10 Sep 2023 00:44:20 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1ba5cda3530so2523519fac.3;
        Sun, 10 Sep 2023 00:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694331859; x=1694936659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c50+csNixrAL652I8a2nGfpKGvkeir3Xklb+hUPR40Y=;
        b=hM/5/CX17DTiDmOnNroBUSIfS/zneYadi4XkS6XR6Iqsg3oBrynCWt2PJzXqB6Z1j2
         H1dy25hFbFs9inT+I5U+9xn4bnWolA3cy/LheRpADtPvKjCD2hx+8V+blg6m0k+Pa/43
         mbhwdsQp3Vrtc0Qmbh6/vrjA3t3KXrMf4ZoTkY0mJwjzS+JOcgPrvIF7GKh3ef1dtEOC
         U7IupbTwlgCpIo5ld9H2oEfU4solcbJH97LmZkphcrYOWe2oJNepWX3CeAvty8MoByvQ
         6Susd9NPQjfQ1CDu9LxmgIj4IjkK2uzBGQJDpmH7GM6NejfGtbIOJ5ru8miPNskjMtGa
         2O8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694331859; x=1694936659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c50+csNixrAL652I8a2nGfpKGvkeir3Xklb+hUPR40Y=;
        b=S7rJ26LBICOgiyxrXLu4DsjF7cWm/ZA94us+mFqWOnnF/ZUaqZOvAY/p+X4AxLADJK
         sLcmOTfxwGkIMv09GJTpb9DQp+5G2H0YPy9DufP480cK/ZvDogd4GeIKbkseD7mqw6CQ
         da+0UBc4n9OUzzmRCixFTjim/SbFi4j8DiseR+KAxS+ebFlNKpIdUMAcQOeKoiF5HFhH
         MldZuvB/b/JTZuy2owtys1205VzG1uv6hErqNCp+3rkm74sHYjLaaZhuFR8//JAUiErh
         WgWSXiamCN9jJ+KFKZMeb7dnWMg5oNYjWbZBPPmYxEArvXOWCKLea60cJpqu3QO/7GY1
         Lxmg==
X-Gm-Message-State: AOJu0Yy/iX8YECVTr5xtVpvLsuEeRTKY3dDJ3/FC0YAvLZFt8B6gtVJD
        cPFvSyOIbXUFfkynSnAlPIXK/CxIoA2zIP1y8Hg=
X-Google-Smtp-Source: AGHT+IF85GxCqI1nmf/BUSpIO+3OcIzI4r8N/ZOdJLekOlOO3w6LQAX+Or4XjtalLh5iVsJQpEJiqJ/55ic8kjF6NcY=
X-Received: by 2002:a05:6870:2155:b0:1c8:baa5:a50f with SMTP id
 g21-20020a056870215500b001c8baa5a50fmr8754232oae.27.1694331859157; Sun, 10
 Sep 2023 00:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694202430.git.pstanner@redhat.com> <93001a9f3f101be0f374080090f9c32df73ca773.1694202430.git.pstanner@redhat.com>
In-Reply-To: <93001a9f3f101be0f374080090f9c32df73ca773.1694202430.git.pstanner@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 10 Sep 2023 10:43:42 +0300
Message-ID: <CAHp75VdAXBk2GzNX+b2-t62biuOn9JHMupaVbBuVkDn5PRTg_A@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] string.h: add array-wrappers for (v)memdup_user()
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

On Fri, Sep 8, 2023 at 11:02=E2=80=AFPM Philipp Stanner <pstanner@redhat.co=
m> wrote:
>
> Currently, user array duplications are sometimes done without an
> overflow check. Sometimes the checks are done manually; sometimes the
> array size is calculated with array_size() and sometimes by calculating
> n * size directly in code.
>
> Introduce wrappers for arrays for memdup_user() and vmemdup_user() to
> provide a standardized and safe way for duplicating user arrays.
>
> This is both for new code as well as replacing usage of (v)memdup_user()
> in existing code that uses, e.g., n * size to calculate array sizes.

No objections,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko
