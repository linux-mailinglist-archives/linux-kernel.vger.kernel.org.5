Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735967700BD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjHDNEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjHDNEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:04:14 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC47D49EA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:03:35 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-522a9e0e6e9so563174a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 06:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1691154213; x=1691759013;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UxwSpue8VcAl4rE+L12cx6ELVuEpMdkrFAwiPdnoGX8=;
        b=U/pzLmSSesV857mBeI0TU4dda7CF1a53EmSDTCN5EXDBpHwAhnQdZYYDjRFBK7DHut
         wFpW1JgdQGXS+FiE+B4dM0RiRZIqsz0VOUhMms4n3ikoNUEcNpr6trv6Bkd78d2Is0Gu
         T4NrzbcM10n0APMABvxNnLufUODd7ew9gdA7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691154213; x=1691759013;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxwSpue8VcAl4rE+L12cx6ELVuEpMdkrFAwiPdnoGX8=;
        b=WCc/M2Q0j22sNsD84vpted4EN4o4J2HiKlCZYQjnbr4mE1bIeIEHp0+GATP5KKjnWc
         Hc/v0IKk3a28EqHrZQY8Eno9sPlEAJre0kDIISJmcAFicUL4WL4ExI6pFYwqxV+dRvWp
         W7DQbp7KppxkjbMwBvcDIkz3VA7/wAstWtcuU0YUQ81oGqy/HEDaGpx0HfiSr7cLXbdi
         WLrVWtZh2mPsqq73pJnmui2rsbS4rB4qV6qG+GqOsV5p5QOtoLuoqkJZF9l9u6PwAl8a
         VXxdGC0Q3BHZVSSaEzh3cfNYdJZcDs0FfVVEj3xCWW0GVerM3qmyEpwcH2ecfNZxLkYH
         4WDg==
X-Gm-Message-State: ABy/qLYGJTecLWWB0rOG75Nck3iQnD+5wJpdAMZBbigB32BcXovUSS3P
        vqzZD9tPFAUnUlOppEK9v2x3D4DbsGk8RyZ7DME=
X-Google-Smtp-Source: APBJJlFlOCcJwTgxssVeh0x3dNinWRfduyp0bspmJezvbNPSgW6Gd9/PiTQBd6YeAKu1zIJmVFmQdQ==
X-Received: by 2002:a05:6402:270b:b0:522:582f:9194 with SMTP id y11-20020a056402270b00b00522582f9194mr17071722edd.4.1691154213096;
        Fri, 04 Aug 2023 06:03:33 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d12-20020aa7ce0c000000b005230724b2b1sm1232776edv.45.2023.08.04.06.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 06:03:31 -0700 (PDT)
Date:   Fri, 4 Aug 2023 15:03:29 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Randy Dunlap <rdunlap@infradead.org>,
        Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: Re: [PATCH v5 1/1] drm/doc: Document DRM device reset expectations
Message-ID: <ZMz3IXIzXS5gNK3G@phenom.ffwll.local>
Mail-Followup-To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        pierre-eric.pelloux-prayer@amd.com, Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Stone <daniel@fooishbar.org>,
        'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Randy Dunlap <rdunlap@infradead.org>,
        Pekka Paalanen <pekka.paalanen@collabora.com>
References: <20230627132323.115440-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230627132323.115440-1-andrealmeid@igalia.com>
X-Operating-System: Linux phenom 6.3.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 10:23:23AM -0300, André Almeida wrote:
> Create a section that specifies how to deal with DRM device resets for
> kernel and userspace drivers.
> 
> Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
> 
> v4: https://lore.kernel.org/lkml/20230626183347.55118-1-andrealmeid@igalia.com/
> 
> Changes:
>  - Grammar fixes (Randy)
> 
>  Documentation/gpu/drm-uapi.rst | 68 ++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
> index 65fb3036a580..3cbffa25ed93 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -285,6 +285,74 @@ for GPU1 and GPU2 from different vendors, and a third handler for
>  mmapped regular files. Threads cause additional pain with signal
>  handling as well.
>  
> +Device reset
> +============
> +
> +The GPU stack is really complex and is prone to errors, from hardware bugs,
> +faulty applications and everything in between the many layers. Some errors
> +require resetting the device in order to make the device usable again. This
> +sections describes the expectations for DRM and usermode drivers when a
> +device resets and how to propagate the reset status.
> +
> +Kernel Mode Driver
> +------------------
> +
> +The KMD is responsible for checking if the device needs a reset, and to perform
> +it as needed. Usually a hang is detected when a job gets stuck executing. KMD
> +should keep track of resets, because userspace can query any time about the
> +reset stats for an specific context. This is needed to propagate to the rest of
> +the stack that a reset has happened. Currently, this is implemented by each
> +driver separately, with no common DRM interface.
> +
> +User Mode Driver
> +----------------
> +
> +The UMD should check before submitting new commands to the KMD if the device has
> +been reset, and this can be checked more often if the UMD requires it. After
> +detecting a reset, UMD will then proceed to report it to the application using
> +the appropriate API error code, as explained in the section below about
> +robustness.
> +
> +Robustness
> +----------
> +
> +The only way to try to keep an application working after a reset is if it
> +complies with the robustness aspects of the graphical API that it is using.
> +
> +Graphical APIs provide ways to applications to deal with device resets. However,
> +there is no guarantee that the app will use such features correctly, and the
> +UMD can implement policies to close the app if it is a repeating offender,

Not sure whether this one here is due to my input, but s/UMD/KMD. Repeat
offender killing is more a policy where the kernel enforces policy, and no
longer up to userspace to dtrt (because very clearly userspace is not
really doing the right thing anymore when it's just hanging the gpu in an
endless loop). Also maybe tune it down further to something like "the
kernel driver may implemnent ..."

In my opinion the umd shouldn't implement these kind of magic guesses, the
entire point of robustness apis is to delegate responsibility for
correctly recovering to the application. And the kernel is left with
enforcing fair resource usage policies (which eventually might be a
cgroups limit on how much gpu time you're allowed to waste with gpu
resets).

> +likely in a broken loop. This is done to ensure that it does not keep blocking
> +the user interface from being correctly displayed. This should be done even if
> +the app is correct but happens to trigger some bug in the hardware/driver.
> +
> +OpenGL
> +~~~~~~
> +
> +Apps using OpenGL should use the available robust interfaces, like the
> +extension ``GL_ARB_robustness`` (or ``GL_EXT_robustness`` for OpenGL ES). This
> +interface tells if a reset has happened, and if so, all the context state is
> +considered lost and the app proceeds by creating new ones. If it is possible to
> +determine that robustness is not in use, the UMD will terminate the app when a
> +reset is detected, giving that the contexts are lost and the app won't be able
> +to figure this out and recreate the contexts.
> +
> +Vulkan
> +~~~~~~
> +
> +Apps using Vulkan should check for ``VK_ERROR_DEVICE_LOST`` for submissions.
> +This error code means, among other things, that a device reset has happened and
> +it needs to recreate the contexts to keep going.
> +
> +Reporting causes of resets
> +--------------------------
> +
> +Apart from propagating the reset through the stack so apps can recover, it's
> +really useful for driver developers to learn more about what caused the reset in
> +first place. DRM devices should make use of devcoredump to store relevant
> +information about the reset, so this information can be added to user bug
> +reports.

Since we do not seem to have a solid consensus in the community about
non-robust userspace, maybe we could just document that lack of consensus
to unblock this patch? Something like this:

Non-Robust Userspace
--------------------

Userspace that doesn't support robust interfaces (like an non-robust
OpenGL context or API without any robustness support like libva) leave the
robustness handling entirely to the userspace driver. There is no strong
community consensus on what the userspace driver should do in that case,
since all reasonable approaches have some clear downsides.

With the s/UMD/KMD/ further up and maybe something added to record the
non-robustness non-consensus:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Cheers, Daniel



> +
>  .. _drm_driver_ioctl:
>  
>  IOCTL Support on Device Nodes
> -- 
> 2.41.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
