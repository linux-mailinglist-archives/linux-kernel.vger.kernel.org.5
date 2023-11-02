Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1377DF856
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377117AbjKBRH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKBRH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:07:58 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12198123
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:07:56 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9d2d8343dc4so189890266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698944874; x=1699549674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xl4I+HvP3J5ZJKuSb/CouLtm+Hi9ya1nTcmqWDQztKk=;
        b=KBlc8r306vzH5Gd62mo28lCQbPg6JhQ4NnCZJEHgMCzog6KTTiAQnXF3zWc1YYEj5q
         +L+XdwIxNJeKG8QKVOAvpJmjXSdCbONLGp8qeeC1+46ng6Mw2Hc22VkV+0Cx9BWgc8W1
         KK9h3TfB6HG6QIdLMdjnSLQrFSao6kbDcpXVJ6rfuMsGFW5ajzlotfp0RLj6G2ipguPq
         Bu/HwAd9mmgO7c8+q70rgMlOH7SCaExqIOPh6iii5Bf6OuyWjXoKf92N3uftUspFttZO
         WBSBU0QUQjVySGbdYT7JBqBxymdYX9QUnl7g1uNj7LQIKPUtWcOZLgJTFxhZnxZIT/l5
         OpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698944874; x=1699549674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xl4I+HvP3J5ZJKuSb/CouLtm+Hi9ya1nTcmqWDQztKk=;
        b=f9gMrJQ2BQFVyAOxPbt60e/lDbIAiAW07fQ/soAhrNagC2/2O3cPjHi/NRoCtfWdAc
         jwdh7xf7+hSghKVajKonXTwWFgBoVw51cZQhf74xiCk1AlluIBQ4LdFrtZCs0XKsJieV
         1MK7gjl+WtddLPYz1ICVY+zlPUXrazOEIOmIC5Pr8gCX5GUsqfLadzkWw2PRTdc5g/Vs
         h2YLdGEdpST6i6Wnvm5UfSdBKJW5Ns4pSCHtbQZUOVSl9OAqqSug5kk9r5ez5A9w6oQe
         T9RXdnqmGlzKs+wcQqUYBqC9IBabQaQLAwY74tawCBWSN7BehzF5p737Fq1gr1ZuGYTH
         6uKQ==
X-Gm-Message-State: AOJu0YzohmuN6yy1fZFuMf/9MKpBmqt0gcrtp7CWDfcbg6nkeAAIPn+f
        f9mQX8cKd3E9rn6e//aNZNYNBTker/3zO/FfNlU=
X-Google-Smtp-Source: AGHT+IELCuRpMJYiWl0Qrpfp672D7mV32NZ7IqUrU0Waf2iuqATWpRIDQA27z7e6YAK1wp9d4NaPJSOdvn5cL7zLluI=
X-Received: by 2002:a17:906:d552:b0:9be:77cd:4c2c with SMTP id
 cr18-20020a170906d55200b009be77cd4c2cmr3767379ejc.28.1698944874378; Thu, 02
 Nov 2023 10:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <ZUNsmJGbYwgPaUpY@debian> <CADnq5_Minarw2D_TeRdkm6nJOP_4qHM+MxiMeLWMXqHxjq22Xw@mail.gmail.com>
In-Reply-To: <CADnq5_Minarw2D_TeRdkm6nJOP_4qHM+MxiMeLWMXqHxjq22Xw@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 2 Nov 2023 17:07:18 +0000
Message-ID: <CADVatmO9NCs=ryNg72HNzMDpqg862gpGnnFhQ4uwTpEkjOkCLw@mail.gmail.com>
Subject: Re: mainline build failure due to 7966f319c66d ("drm/amd/display:
 Introduce DML2")
To:     Alex Deucher <alexdeucher@gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2023 at 16:52, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Thu, Nov 2, 2023 at 5:32=E2=80=AFAM Sudip Mukherjee (Codethink)
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > Hi All,
> >
> > The latest mainline kernel branch fails to build x86_64 allmodconfig
> > with the error:
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c: In f=
unction 'dml_prefetch_check':
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6707:=
1: error: the frame size of 2056 bytes is larger than 2048 bytes [-Werror=
=3Dframe-larger-than=3D]
> >  6707 | }
> >       | ^
> >
> > git bisect pointed to 7966f319c66d ("drm/amd/display: Introduce DML2")
> >
> > I will be happy to test any patch or provide any extra log if needed.
>
> This was reported earlier and fixed by:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D089dbf6a06f1dcaeed4f8b86d619e8d28b235207
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Db141fa036c901303ca5659cc22e9c08f8b097892
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D5b2c54e0d0ea09f7a3b500510731878326e1117e
> but I guess maybe different compiler versions are still hitting this.

Yes, I should have mentioned. gcc-11 and gcc-12 failed to build. but
gcc-13 was ok.


--=20
Regards
Sudip
