Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058747A5A0D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjISGjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjISGjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:39:12 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5A4102
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 23:39:05 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a648f9d8e3so698067666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 23:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1695105544; x=1695710344; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hAyqek3p98q16RahkwI0D/FxxTx4UvCSeS2iR1VVOX0=;
        b=JdMwKkuMcF0wsAwsumSj8XzYd1Hl8QnuIpIwf1flTVnpQ7ogHm9yTix6OLJZqvm1KH
         WbyqZW3qHwKdj1DSAGjJdMPvRagttn4vH2MFWeK6ie3gAXVxMlIKhDM+DrhXoUoSXi3j
         5AKgV6aftIMS74vzW8DQF2kMXfRvfBiE5z7vA3VwiPynoVcmLZ/b7jsfB1ImkSRbSqal
         IXj74X3mfy7gonKk1va19IiW3deB3luJwyegm+naN9MxONA8tWZyGDuV6Tu3Qwh+INez
         LEIbz++XUgNdY6T1oQ53W81r4PfB9Ii8n1z/8IIY0k6treKMhYD6qR4Zxjoh7Yt+tzLn
         lK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695105544; x=1695710344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAyqek3p98q16RahkwI0D/FxxTx4UvCSeS2iR1VVOX0=;
        b=B9smzk1Lx21UtEpKAv3FJZ3euFZ5O5QwsHaFFmvIBl4IYeaF12olblO7X0VLSmZpIQ
         /KA0YZfstnSNnRdsjY9rTS9hU/noQ1GifEahSuvkJYSbImpt+Yl0HX0TcXi99S6jg2Ns
         +7ZCZJP4+YpBBKfw3ougiWK2g5GsaZVK2IXLk4pJzYANj2EfrLHyJmIWc8Mfj7XYEqHf
         DAmDHDeTJT9ECYdqBag9TPvHY6rMY3WNAvwfpos3tRxAzV9HbEJlqQ+yMMb4I3rH6Xh1
         iMTXjAlCoTQhb4CS5qFrzsZ/QGgNDaFv/qlbZwFbFmadT7Et4CxDy2SVMSWU1EzMYgIp
         StFA==
X-Gm-Message-State: AOJu0YxgGIhnYlk7VXCrk4EDqcycVVJe95QiM1yKuQT7RwBgymw2G4Kc
        Ut0ERKUumA/5/+9AQnZWcn+fMTgWaZlBQGLHEpPvCg==
X-Google-Smtp-Source: AGHT+IEgjR2/6ErhRUie4lpYjXQHuHiGdo1Vzs8vCUTeHBmj44DBDfG/XBjy/ewQUd4zrbs6TUxZaiDsfRA7ZSY4QbE=
X-Received: by 2002:a17:906:2097:b0:9ae:3dd:e751 with SMTP id
 23-20020a170906209700b009ae03dde751mr4996859ejq.66.1695105544272; Mon, 18 Sep
 2023 23:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230913110709.6684-1-hdanton@sina.com> <99d99007-8385-31df-a659-665bf50193bc@I-love.SAKURA.ne.jp>
 <CAHk-=wgb9ccWN3Nks5STYUDqQUeHZdCLsK4kA37SdDJuGZfukg@mail.gmail.com>
 <87pm2lzsqi.ffs@tglx> <167ee2ad-6a7e-876c-f5c9-f0a227070a78@I-love.SAKURA.ne.jp>
 <ZQLAc/Fwkv/GiVoK@phenom.ffwll.local> <2784f5e8-ebf4-a000-509e-415e14390e23@collabora.com>
In-Reply-To: <2784f5e8-ebf4-a000-509e-415e14390e23@collabora.com>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Tue, 19 Sep 2023 07:38:52 +0100
Message-ID: <CAPj87rNAv_ACFJF_PbWnJjjmSrSOvfVuvOHq9mmza5w=t+BF0w@mail.gmail.com>
Subject: Re: drm/vkms: deadlock between dev->event_lock and timer
To:     Helen Koike <helen.koike@collabora.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Maira Canal <mairacanal@riseup.net>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@gmail.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        syzkaller@googlegroups.com, LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Sanan Hasanov <Sanan.Hasanov@ucf.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Stone <daniels@collabora.com>,
        David Heidelberg <david.heidelberg@collabora.com>,
        Vignesh Raman <vignesh.raman@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sept 2023 at 23:02, Helen Koike <helen.koike@collabora.com> wrote:
> On 14/09/2023 05:12, Daniel Vetter wrote:
> > Also yes how that landed without anyone running lockdep is ... not good. I
> > guess we need a lockdep enabled drm ci target that runs vkms tests asap
> > :-)
>
> btw, I just executed a draft version of vkms targed on the ci, we do get
> the warning:
>
> https://gitlab.freedesktop.org/helen.fornazier/linux/-/jobs/49156305#L623
>
> I'm just not sure if tests would fail (since it is a warning) and it has
> a chance to be ignored if people don't look at the logs (unless if igt
> already handles that).

Hmm, dmesg-warn is already a separate igt test status. I guess it just
needs to be handled explicitly.

> I still need to do some adjustments (it seems the tests is hanging
> somewhere and we got a timeout) but we should have vkms in drm ci soon.

Might be due to the locking explosion? The kernels should probably
have soft-lockup detection enabled as well as lockdep.

Cheers,
Daniel
