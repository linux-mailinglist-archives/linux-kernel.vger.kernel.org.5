Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0493C776899
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbjHITXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjHITXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:23:16 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA3535A3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:16:21 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9ab1725bbso2847071fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 12:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691608539; x=1692213339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ih33D6tUiZAfLMClGioyRnGVJHXSceBJGFUENGWTcCM=;
        b=Sqvs8vImIOvNM0R/NJECHqrRWJcQXlzLh4iNYEVO6/4xd/JQdBmZVHvRc1yzJx8tj+
         DkQsb5BpJG1ZvhJkXFChG24teQ6ifDk2rs/a7sZMQF+l8Kb/Wsu36Vqqq6GC/BRnER3v
         ttuFeKNY9DHdMvEhu3z9la68E+7PIwFHSRFMQTl/i4fKjLqfKcIKkTU+now5G2zrgCC7
         a9INIUkGuz1hR/3LUKrgOkWcyu+cw2t/L+WCR1lFQt0n3pQn6DA5iIbVyACF9kWih4Nz
         7NuH/xOmuR26Tivw0nUE9k9+xTpXsWTM1v+DcY1ggv3owgEqhy0vbT4pZWaaP4FcSh9q
         +0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691608539; x=1692213339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ih33D6tUiZAfLMClGioyRnGVJHXSceBJGFUENGWTcCM=;
        b=lNfpJjJ57o8IsYQqCGCCOVZ2W1BDRh7OvfDeW71jJJc/aCNVvQTIA1EkcoCehNku1O
         6QOzamInfpLCjcqnhDMrsT+pFLagfye5cGd8QYiT+pJafNw1C37c3hbJQHTOiK03i3Lh
         uRtBLVNDwARPwKd82TW//HuglVluNmVv7EuzaD5rxHy9LMPX3rD1yX/wm/yfg8YeOv2F
         frzjmsGn2tR16bUMObxD5p98QY+uQrn6y5xjkhIWlDahrOuHwuMT2S3foBzWB4ETdmyJ
         UnfirAQ9NZhH8KJg6PFfwZffzQLXXAr+leK6T+l9o24ciGitciFMbX8mVArZ0jtwyy+O
         /Siw==
X-Gm-Message-State: AOJu0YxBrunhy2z1U+stXT/WDuxwx7JkHkOnQ0S7OSE7LYIpRp1/zEUp
        mP8BAFbIqoiIAROy+MKiOvtMAyvwFlqSAYQ75DU=
X-Google-Smtp-Source: AGHT+IFsP5OgaRMoPOM34vrjG64okHGUQOwTqcXiolOB6OqqEE7g0Qk8DFtykBiuzRS3C9+gSbCYObkNPd0iap0jm3A=
X-Received: by 2002:a2e:878d:0:b0:2b6:c8e8:915f with SMTP id
 n13-20020a2e878d000000b002b6c8e8915fmr103212lji.22.1691608539294; Wed, 09 Aug
 2023 12:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230627132323.115440-1-andrealmeid@igalia.com>
 <ZMz3IXIzXS5gNK3G@phenom.ffwll.local> <CA+hFU4wbn=efbS10c14A9sLTf9GYJ_O12kowh76ELLdo2+x5fA@mail.gmail.com>
 <CAAxE2A48uybsU6DY+fLTzQ9K2b0Ln+SW6bt3capbGAGb7L8fvQ@mail.gmail.com> <3ca7a141-1385-351e-9186-00874e254165@mailbox.org>
In-Reply-To: <3ca7a141-1385-351e-9186-00874e254165@mailbox.org>
From:   =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date:   Wed, 9 Aug 2023 15:15:02 -0400
Message-ID: <CAAxE2A5pgwb-xLDzr9XyMp-1k7oFUWR9X812b17LSb98RTFKhA@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] drm/doc: Document DRM device reset expectations
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc:     Sebastian Wick <sebastian.wick@redhat.com>,
        pierre-eric.pelloux-prayer@amd.com,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
        dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        christian.koenig@amd.com
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

On Wed, Aug 9, 2023 at 3:35=E2=80=AFAM Michel D=C3=A4nzer <michel.daenzer@m=
ailbox.org> wrote:
>
> On 8/8/23 19:03, Marek Ol=C5=A1=C3=A1k wrote:
> > It's the same situation as SIGSEGV. A process can catch the signal,
> > but if it doesn't, it gets killed. GL and Vulkan APIs give you a way
> > to catch the GPU error and prevent the process termination. If you
> > don't use the API, you'll get undefined behavior, which means anything
> > can happen, including process termination.
>
> Got a spec reference for that?
>
> I know the spec allows process termination in response to e.g. out of bou=
nds buffer access by the application (which corresponds to SIGSEGV). There =
are other causes for GPU hangs though, e.g. driver bugs. The ARB_robustness=
 spec says:
>
>     If the reset notification behavior is NO_RESET_NOTIFICATION_ARB,
>     then the implementation will never deliver notification of reset
>     events, and GetGraphicsResetStatusARB will always return
>     NO_ERROR[fn1].
>        [fn1: In this case it is recommended that implementations should
>         not allow loss of context state no matter what events occur.
>         However, this is only a recommendation, and cannot be relied
>         upon by applications.]
>
> No mention of process termination, that rather sounds to me like the GL i=
mplementation should do its best to keep the application running.

It basically says that we can do anything.

A frozen window or flipping between 2 random frames can't be described
as "keeping the application running". That's the worst user
experience. I will not accept it.

A window system can force-enable robustness for its non-robust apps
and control that. That's the best possible user experience and it's
achievable everywhere. Everything else doesn't matter.

Marek




Marek
