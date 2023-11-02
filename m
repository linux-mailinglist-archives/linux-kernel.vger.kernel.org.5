Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70657DF7F8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376872AbjKBQwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKBQwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:52:45 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708A4123
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 09:52:42 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6d30d9f4549so673269a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 09:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698943961; x=1699548761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ui4RfJzpp8oZSTAGwUEFNZzYkRDHy/N87GoVOtgxAXQ=;
        b=Y5rEy9I2WNYyfyD7jLOqc6rtJMLSESAUo+zSfum0gizhB3VuxfNOpN8xAm+wxyCAl4
         H+yKsHMdBzIZ+7/mk2JlO+Pa2jCyTzVQizXl6IAlzlL0cKYno7iK48HFt30YpSubCasJ
         AWUgxlYN5+dyzbJFEX/gci7XiDTuhC2LWx/BIiO526RIsOljrDcvTGfJnNrM6BmSsRij
         XQs4iYkGu/Bar+h13MeKU10bCvxQiTAaPNY9J7U28S+YV3ZQVikwBu487BAzJm9X/jQn
         iLNHZEwQfYJmRs3qCr2x7i5ZXwD/WEmPKNEWFaMI9TSFM5doipXUnXEywxNoqMI1e6gt
         2Z+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698943961; x=1699548761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ui4RfJzpp8oZSTAGwUEFNZzYkRDHy/N87GoVOtgxAXQ=;
        b=TgWlpHaNqqlWz36G1uGqwgJaQLmkz8Ymx6Yvl2hVSkct6OmPs8tbEz4Kcj+zYgWCdZ
         p5i+zwmPTb/G6UfCm0x7io8PAJNSkA/AiTcolZ31n50AzGTYFhtysP5HTesKA69gD+JV
         nUAS4KqCwW1wmmmG+dTQiKEPKrkHsKrHebYPr/j8sktMUhOs/C8EGHqQzBuuneZbJtgq
         qlQ/GASA3Z7uzH1VYdWvR+jG+62aYaT+5uT/G4R+m6NsS+TEMWWcYqYBYUDZuj96V6WG
         M0KpS5fTMQk8VM8xJ8NLlbAFgsAuqd4K/CxUehT6thtUQYXA1K43oQJKQf4dm1fRUGp6
         Uc5A==
X-Gm-Message-State: AOJu0YyQ60JeQOgaRxoccz46/7DRyp+pXwcs9ZZRS6MhQ/YhsaJbJ4HC
        TjMaqNCxYyxR0WWPy8QOWo90jjeVKof+BMy1jDI=
X-Google-Smtp-Source: AGHT+IEsdW4B2/8cahRRswQBtqGr+aRM+u2mFgCDk0qJ+y9EqqQ0+4bkkNKQxCWr5LP+k+NDi9OYk6xVSSk0kFnmAhI=
X-Received: by 2002:a05:6870:1281:b0:1f0:36ab:2886 with SMTP id
 1-20020a056870128100b001f036ab2886mr4655407oal.41.1698943961740; Thu, 02 Nov
 2023 09:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <ZUNsmJGbYwgPaUpY@debian>
In-Reply-To: <ZUNsmJGbYwgPaUpY@debian>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 2 Nov 2023 12:52:30 -0400
Message-ID: <CADnq5_Minarw2D_TeRdkm6nJOP_4qHM+MxiMeLWMXqHxjq22Xw@mail.gmail.com>
Subject: Re: mainline build failure due to 7966f319c66d ("drm/amd/display:
 Introduce DML2")
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Roman Li <roman.li@amd.com>,
        Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        regressions@lists.linux.dev, Leo Li <sunpeng.li@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        "linux-kernel@vger.kernel.orgLinus Torvalds" 
        <torvalds@linux-foundation.org>, dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 5:32=E2=80=AFAM Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi All,
>
> The latest mainline kernel branch fails to build x86_64 allmodconfig
> with the error:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c: In fun=
ction 'dml_prefetch_check':
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6707:1:=
 error: the frame size of 2056 bytes is larger than 2048 bytes [-Werror=3Df=
rame-larger-than=3D]
>  6707 | }
>       | ^
>
> git bisect pointed to 7966f319c66d ("drm/amd/display: Introduce DML2")
>
> I will be happy to test any patch or provide any extra log if needed.

This was reported earlier and fixed by:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D089dbf6a06f1dcaeed4f8b86d619e8d28b235207
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Db141fa036c901303ca5659cc22e9c08f8b097892
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D5b2c54e0d0ea09f7a3b500510731878326e1117e
but I guess maybe different compiler versions are still hitting this.

Alex

>
> #regzbot introduced: 7966f319c66d9468623c6a6a017ecbc0dd79be75
>
> --
> Regards
> Sudip
