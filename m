Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A43575E5C5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 01:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjGWXyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 19:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGWXyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 19:54:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A15E5F;
        Sun, 23 Jul 2023 16:54:48 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-98e011f45ffso562456466b.3;
        Sun, 23 Jul 2023 16:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690156487; x=1690761287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIT+hSMafkg++eE44gK8LEvrBC1icuncW2J+Pf4/L80=;
        b=ZO7wxRHl1bT/4i+iOouXAMTcpShANRl/Kj9440bykG3Dv7tg+xdYCRWXuFLwMyYkPh
         tkzf4xXIjhMh6Aen7KX/SIsgveiIz+vcsvch2N6khrdisapCoEMS/62azvWnmVksGDqb
         I3jJ9XF5tj+2JHikIxAu/ViZddt4EZtFGfFjC3gGwqYYF/BNiN/vZoDSRcjwkPyI7oyJ
         60tde6X9wh30Ivlthv6O2jcjQ4qthJrRiEv8Ft3MQBF9Y8JjPWePl0VbBowBAR1ahvLC
         zNFoMZQfuWAAtoO1j1gujHTpcBQzR3qNPn+6p/35g0Xdv6Zupfdm2Mcd0nGs7rLZ5Rgr
         sq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690156487; x=1690761287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIT+hSMafkg++eE44gK8LEvrBC1icuncW2J+Pf4/L80=;
        b=FWS62mSx3VpGCWLoo1S1EbtBC2gHgIbKXuz00Qu0JlMX7PdvLpeyrSX4kiiHhbptds
         yB6o6iYOI6AuY/Q/J3VRxJuLXEv8Nc6l7Oh6Z4Xw4rNz/IGSwXw1NrW8+UpY7wEneyrD
         +7GdsP4CuZR9Ju+NPqPCb9Zxw9fZT+CgjEncZoViA5NTcWJ8HIvik4A6FSK67zG25Mqw
         T2cGXhR7lSkw0MU26OXvfCWSaQIM3r9T6n7LLnjaNdFpjdtFrguSRGqDVUADDxuAawaW
         216Kw7/D7Ur7hAymW2/dSp6dhvGrIht8Ldl63IDMHh7l9zM3y9lVT4985VZXWf5FU0FJ
         ELbg==
X-Gm-Message-State: ABy/qLbUPorIgu1gsYZ6B37Wd30KqdPhQr4Zb+PjXn+yhavpbE2UysKc
        TZnEkQdeTRK8rLcJGoKgHd35V5jnHW0J/qXT7r0=
X-Google-Smtp-Source: APBJJlGVH6e+Cmznbgs7azX60lZYUZNxmpCjiTEvV0Fem9YUEz3NQ0NgyP51NP4kNMRRzgXDd+APqGYJ5wmdpTo/s5U=
X-Received: by 2002:a17:906:77dd:b0:994:539d:f983 with SMTP id
 m29-20020a17090677dd00b00994539df983mr6921287ejn.23.1690156486697; Sun, 23
 Jul 2023 16:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230720001443.2380-1-dakr@redhat.com> <20230720001443.2380-12-dakr@redhat.com>
 <CAOFGe945tp344=g-++=EAT89t0qJHZ=3yeW-k9OTbGNJodvwAg@mail.gmail.com>
In-Reply-To: <CAOFGe945tp344=g-++=EAT89t0qJHZ=3yeW-k9OTbGNJodvwAg@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 24 Jul 2023 09:54:34 +1000
Message-ID: <CAPM=9tyQQTn=+Af1kWySde75T=MLFeboTErLv3NxqtQ8pvqtzA@mail.gmail.com>
Subject: Re: [PATCH drm-misc-next v8 11/12] drm/nouveau: implement new VM_BIND uAPI
To:     Faith Ekstrand <faith@gfxstrand.net>
Cc:     Danilo Krummrich <dakr@redhat.com>, daniel@ffwll.ch,
        tzimmermann@suse.de, mripard@kernel.org, corbet@lwn.net,
        christian.koenig@amd.com, bskeggs@redhat.com,
        Liam.Howlett@oracle.com, matthew.brost@intel.com,
        boris.brezillon@collabora.com, alexdeucher@gmail.com,
        ogabbay@kernel.org, bagasdotme@gmail.com, willy@infradead.org,
        jason@jlekstrand.net, donald.robson@imgtec.com,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sun, 23 Jul 2023 at 01:12, Faith Ekstrand <faith@gfxstrand.net> wrote:
>
> On Wed, Jul 19, 2023 at 7:15=E2=80=AFPM Danilo Krummrich <dakr@redhat.com=
> wrote:
>>
>> This commit provides the implementation for the new uapi motivated by th=
e
>> Vulkan API. It allows user mode drivers (UMDs) to:
>>
>> 1) Initialize a GPU virtual address (VA) space via the new
>>    DRM_IOCTL_NOUVEAU_VM_INIT ioctl for UMDs to specify the portion of VA
>>    space managed by the kernel and userspace, respectively.
>>
>> 2) Allocate and free a VA space region as well as bind and unbind memory
>>    to the GPUs VA space via the new DRM_IOCTL_NOUVEAU_VM_BIND ioctl.
>>    UMDs can request the named operations to be processed either
>>    synchronously or asynchronously. It supports DRM syncobjs
>>    (incl. timelines) as synchronization mechanism. The management of the
>>    GPU VA mappings is implemented with the DRM GPU VA manager.
>>
>> 3) Execute push buffers with the new DRM_IOCTL_NOUVEAU_EXEC ioctl. The
>>    execution happens asynchronously. It supports DRM syncobj (incl.
>>    timelines) as synchronization mechanism. DRM GEM object locking is
>>    handled with drm_exec.
>>
>> Both, DRM_IOCTL_NOUVEAU_VM_BIND and DRM_IOCTL_NOUVEAU_EXEC, use the DRM
>> GPU scheduler for the asynchronous paths.
>
>
> IDK where the best place to talk about this is but this seems as good as =
any.
>
> I've been looking into why the Vulkan CTS runs about 2x slower for me on =
the new UAPI and I created a little benchmark to facilitate testing:
>
> https://gitlab.freedesktop.org/mesa/crucible/-/merge_requests/141
>
> The test, roughly, does the following:
>  1. Allocates and binds 1000 BOs
>  2. Constructs a pushbuf that executes a no-op compute shader.
>  3. Does a single EXEC/wait combo to warm up the kernel
>  4. Loops 10,000 times, doing SYNCOBJ_RESET (fast), EXEC, and then SYNCOB=
J_WAIT and times the loop
>
> Of course, there's a bit of userspace driver overhead but that's negledga=
ble.
>
> If you drop the top patch which allocates 1k buffers, the submit time on =
the old uAPI is 54 us/exec vs. 66 us/exec on the new UAPI. This includes th=
e time to do a SYNCOBJ_RESET (fast), EXEC, and SYNCOBJ_WAIT. The Intel driv=
er, by comparison, is 33us/exec so it's not syncobj overhead. This is a bit=
 concerning (you'd think the new thing would be faster) but what really has=
 me concerned is the 1k buffer case.
>
> If you include the top patch in the crucible MR, it allocates 1000 BOs an=
d VM_BINDs them. All the binding is done before the warmup EXEC. Suddenly, =
the submit time jumps to 257 us/exec with the new UAPI. The old UAPI is muc=
h worse (1134 us/exec) but that's not the point. Once we've done the first =
EXEC and created our VM bindings, the cost per EXEC shouldn't change at all=
 based on the number of BOs bound.  Part of the point of VM_BIND is to get =
all that binding logic and BO walking off the EXEC path.
>
> Normally, I wouldn't be too worried about a little performance problem li=
ke this. This is the first implementation and we can improve it later. I ge=
t that. However, I suspect the solution to this problem involves more UAPI =
and I want to make sure we have it all before we call this all done and dus=
ted and land it.
>
> The way AMD solves this problem as well as the new Xe driver for Intel is=
 to have a concept of internal vs. external BOs. Basically, there's an INTE=
RNAL bit specified somewhere in BO creation that has a few userspace implic=
ations:
>  1. In the Xe world where VMs are objects, INTERNAL BOs are assigned a VM=
 on creation and can never be bound to any other VM.
>  2. Any attempt to export an INTERNAL BO via prime or a similar mechanism=
 will fail with -EINVAL (I think?).

Okay I've done a first pass at implementing this,

https://gitlab.freedesktop.org/nouvelles/kernel/-/commit/005a0005ff80ec85f3=
e9a314cae0576b7441076c

Danilo we should probably pick that up for the next iteration. with
corresponding mesa work it gets the latency for me from 180us down to
70us.

Dave.
