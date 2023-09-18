Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16AC7A4C70
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjIRPdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjIRPdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:33:08 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED89A13A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:31:15 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3ac97a50ab1so2505381b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695050862; x=1695655662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDANxb9fCSjFavN7Vsm+4RE0GshHc49i7oi8hDRzPvc=;
        b=HBkHKoz8OB4dTyk4KzGN7Ea+fVUaeumhR/S6In7LGJTFDuH1qeA9HlNm6O+ZzRUXUC
         sVVGxkzJV6ZGkON9tj+SJhfwOG4IwibRVJoD0CgiN+GCFXTO9hYGVGgNzTTh4Fuu2vcF
         AgPaFkJ/PuhO1pJah4N9/Di15WyQOBgGzFwOe6ahLsDUN/hwtUe1KHgiVzg2LxO1+xDD
         shE4uzU39S0NVof5dqbriEXbpkdrYgoisJTVIH3pFuT1pocwLpMUZ+3Sbkzt05cJlU2B
         lGD0UpozxSS9eVDx112xQb0/0poo03ySruwTLSjpK2IpQ4Ts59yBbW+mhtWqXqfAJVrt
         ZDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050862; x=1695655662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDANxb9fCSjFavN7Vsm+4RE0GshHc49i7oi8hDRzPvc=;
        b=u1VZpMkeK228CoVTX7eo/ekOX6a7nij5QNGcvdCVlUxryEc2l+oUsLGym4QWW5sbHT
         vrWP7I7e2RB1O7y2ekFCLhkhXdKAb1pNkIF09hm5mD2ToXzrcUD83ayj0sYO4iAv81Ie
         /NSvlSYU0ciSapdjcljl5Lk1XR51nGZh3oFv9YDr9O4E0ff7pSv7C3+YXuXk6oYva709
         RuBfoMmTJG7Gzl/W9D6PLikbm+9mQfEGfgEb8uNScqh4+OMFG/RIyE5vn4Dsxkh6Ytsc
         dfu2JaXnk2oyGDByeK3yHaaI74vyPKgvjH05AvaKKCdCF/CN7ZGmRdA0i7U74SIQuwMO
         5mfw==
X-Gm-Message-State: AOJu0YxeL+Q1hgGh8+fRQ01tvPeyUX1MDfcq7MVQaxC0ZCKZAh+VgHjy
        tiqjwgJReVcAFTLAtvMwROD3ILSCrYDtW9ZaVBM4k5BziT4=
X-Google-Smtp-Source: AGHT+IHAPZ0UXJnm8pd1pbzOaSjwAY/9iYqOwHIJBScO4YQ2xTuL4GcsJWxgWhyVDqI5UbwGDXeu1mCIn5ChIIQsLA4=
X-Received: by 2002:a05:6871:6a1:b0:1d5:a377:f389 with SMTP id
 l33-20020a05687106a100b001d5a377f389mr5268578oao.22.1695046661358; Mon, 18
 Sep 2023 07:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <f7583005-73c8-c720-8595-93f616556915@zwiebeltoralf.de>
In-Reply-To: <f7583005-73c8-c720-8595-93f616556915@zwiebeltoralf.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 18 Sep 2023 10:17:30 -0400
Message-ID: <CADnq5_NATDiCWDJE1RtyMdOedD4SZbsbPmj3wcrS3La9o0ABVw@mail.gmail.com>
Subject: Re: WARNING: CPU: 14 PID: 125 at drivers/gpu/drm/drm_mode_object.c:45
 drm_mode_object_add+0x80/0x90 [drm]
To:     =?UTF-8?Q?Toralf_F=C3=B6rster?= <tinderbox@zwiebeltoralf.de>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
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

On Mon, Sep 18, 2023 at 3:17=E2=80=AFAM Toralf F=C3=B6rster
<tinderbox@zwiebeltoralf.de> wrote:
>
> I do suffer since 1 or 2 weeks from amd gpu problems (6.1.53 and before)
> like
>
> Sep 15 16:51:22 p14s kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR*
> ring sdma0 timeout, signaled seq=3D122011, emitted seq=3D122013
> Sep 15 16:51:22 p14s kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR*
> Process information: process  pid 0 thread  pid 0
> Sep 15 16:51:22 p14s kernel: amdgpu 0000:04:00.0: amdgpu: GPU reset begin=
!
> Sep 15 16:51:23 p14s kernel: amdgpu 0000:04:00.0: amdgpu: free PSP TMR
> buffer
> Sep 15 16:51:23 p14s kernel: amdgpu 0000:04:00.0: amdgpu: MODE2 reset
> Sep 15 16:51:23 p14s kernel: amdgpu 0000:04:00.0: amdgpu: GPU reset
> succeeded, trying to resume
> Sep 15 16:51:23 p14s kernel: [drm] PCIE GART of 1024M enabled (table at
> 0x000000F43FC00000).
> Sep 15 16:51:23 p14s kernel: [drm] PSP is resuming...
> Sep 15 16:51:23 p14s kernel: [drm] reserve 0xa00000 from 0xf43e000000
> for PSP TMR
>
> and tried therefore 6.5.3. But dmesg gives:
>
> WARNING: CPU: 14 PID: 125 at drivers/gpu/drm/drm_mode_object.c:45
> drm_mode_object_add+0x80/0x90 [drm]
> WARNING: CPU: 14 PID: 125 at drivers/gpu/drm/drm_mode_object.c:45
> drm_mode_object_add+0x80/0x90 [drm]
> WARNING: CPU: 14 PID: 125 at drivers/gpu/drm/drm_mode_object.c:45
> drm_mode_object_add+0x80/0x90 [drm]
>
> Are those warning harmless ? Full dmesg and .config are attached.

Yes.  Fixed in this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D69a959610229

Alex

> TIA
>
> --
> toralf
