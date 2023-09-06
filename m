Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDF27942BE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 20:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243644AbjIFSGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 14:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbjIFSGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:06:49 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36FECE9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 11:06:45 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-5712b68dbc0so55716eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 11:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694023605; x=1694628405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnjUXTs6pn0ju4mRyE2WoYS0dp5/lgNA0GigOa0IJOE=;
        b=JJjJp8iN5iYBayQNzOEqsXfYcRs9IGPqp/ea7uoegT2LBTyZDvQZgAZstwQYaRR6mA
         AY/eebxPnK50rFUJmuNAoBEO9AHfMadLs45DfArcgEHYeCJeFhjjiXXegTj25ujXUJvC
         D1r/BqK4o5262aB3SY0TqkzD5f/MkH79Ze2EFFuIFf1CkoAKgJYR2I74nz3owm4YfTdy
         6uHmKpuD4sBBG1vgaUuWP/+zxvP4qQ3iqFVvJa5/7ufKgLEjVsOB5yknBWXlYEFF00vj
         TITC7Av9jbMe1dUYj9cjNWQlbfjIc4Uipvw3vSksuZGLURhzgo1ywXixq2iffUB0c1Ii
         +SmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694023605; x=1694628405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnjUXTs6pn0ju4mRyE2WoYS0dp5/lgNA0GigOa0IJOE=;
        b=Ivf787Fc8qGaWjFFLfi+748UPJMSW6vhV6wH+cgpn77HAXkJB0pF7fFaZNAN3axLhA
         xBzciDs8xZmMuLtQlCvSP30n970/OSNBF4CmP14DYS/9Zs4Car9RM1AFrgdfkMINoQ8F
         scHgPcGyyiQ2N698oKCUrh6BYU3YZ8YflZSrgJOyTwM7ecdeis1MBpUaV9Hzr3DMzj6A
         tyrZFIIIDUpRm9To/rs2XewuuR2Mc1OtAQ9e74jgg5q7lZNfu2XbsiLoTzgBRcV5fvD1
         8yqDuLFHrJ51VTB6f1Xf8TAEUuUOFsj/enmP84AM867rANkicab78kwl9ujsrkhb9e6E
         OmUg==
X-Gm-Message-State: AOJu0Yy5rLE8s15TKQwRGbWJ3qAZ4/YVOs9SBJOMVDd8Z9xWl24QK2I3
        +6lb7ewaENp4xj+Dz5+5AjFXNoL0LgXxUBjil/A=
X-Google-Smtp-Source: AGHT+IHnL4YXufn9orOCAMqeVB24UhQCchcrVK0uam4MUJbJywzc+ivZOogndzFAOBRpb/+5dkxeUeS0OnRV6OQuMLI=
X-Received: by 2002:a05:6808:3089:b0:39c:93ba:cb92 with SMTP id
 bl9-20020a056808308900b0039c93bacb92mr21643536oib.8.1694023605202; Wed, 06
 Sep 2023 11:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230903184607.272198-1-jim.cromie@gmail.com> <20230903184607.272198-4-jim.cromie@gmail.com>
 <ZPV6CMBlDWriMyva@ashyti-mobl2.lan> <ZPir+7VYXcKv117q@intel.com>
In-Reply-To: <ZPir+7VYXcKv117q@intel.com>
From:   jim.cromie@gmail.com
Date:   Wed, 6 Sep 2023 12:06:18 -0600
Message-ID: <CAJfuBxyRn_FQtGmSiJjtOuJDs+40TPWcjW+JA5u8K-FSrDTHUA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] drm_dbg: add trailing newlines to msgs
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Andi Shyti <andi.shyti@linux.intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        daniel@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Imre Deak <imre.deak@intel.com>,
        Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
        Mika Kahola <mika.kahola@intel.com>,
        =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rob Clark <robdclark@chromium.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Fei Yang <fei.yang@intel.com>
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

On Wed, Sep 6, 2023 at 10:42=E2=80=AFAM Rodrigo Vivi <rodrigo.vivi@intel.co=
m> wrote:
>
> On Mon, Sep 04, 2023 at 08:32:40AM +0200, Andi Shyti wrote:
> > Hi Jim,
> >
> > On Sun, Sep 03, 2023 at 12:46:00PM -0600, Jim Cromie wrote:
> > > By at least strong convention, a print-buffer's trailing newline says
> > > "message complete, send it".  The exception (no TNL, followed by a ca=
ll
> > > to pr_cont) proves the general rule.
> > >
> > > Most DRM.debug calls already comport with this: 207 DRM_DEV_DEBUG,
> > > 1288 drm_dbg.  Clean up the remainders, in maintainer sized chunks.
> > >
> > > No functional changes.
> > >
> > > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> >
> > Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
>
> I pushed this i915 one to our drm-intel-next.
> While doing it I have changed the subject to make it clear
> this is 'drm/i915:'.
>
> I believe you should do similar change to all the other patches
> to make it clear in the subject about which domain that commit
> is touching... instead of only 'drm_dbg'.
>

I will do that, and drop the one you've already pushed.
Thank you both.


> i.e.: 183670347b06 ("drm/i915: add trailing newlines to msgs")
> https://cgit.freedesktop.org/drm-intel/commit/?h=3Ddrm-intel-next&id=3D18=
3670347b060521920a81f84ff7f10e227ebe05
>
> Thanks for the patch,
> Rodrigo.
>
> >
> > Andi
