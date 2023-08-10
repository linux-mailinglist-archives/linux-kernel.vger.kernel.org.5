Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5D27781C1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbjHJTpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjHJTpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:45:18 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBCC26B6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:45:17 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9bb097c1bso19992891fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691696715; x=1692301515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxXYghb+eoRa0mcUhOiyjnEloU2cZwSMtKrX/TWEnDU=;
        b=EuWzQHBlN68vnFla0B99+wIKtthaiFiIWy7nnN5azUxkhuuHX0pSvvLMz7nFnWn0+G
         tAqGxeV3JLl43TuNU6JubP3S6v84ehgHECkZlli09K60+BEUpQyqSxe8aurkJWUgX+B4
         6KTni7hWiV0BovdohWKEMF9pdfqZ7mvd5vTEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691696715; x=1692301515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxXYghb+eoRa0mcUhOiyjnEloU2cZwSMtKrX/TWEnDU=;
        b=fvPvfZQnDs/RdvFpiW78YEeErsGe4xS17VfgMw0TnPKMLnLBK+GhXZbWg00u17uvHz
         NNSjIvqX32vGgIntIOuKFW91PkbKXuhQr3oq3C1EJWU+BCEjjqAGE8EO2w6HPMDZJXM/
         rocnSzNQjTAKjX2almhBmPSTNZlgtn8G+bWyLSi/zoMdpbD5dz2JIBk4I9iKHYloPr4G
         6viHFqn4iyKM8HLEkQlFq4oTHIaNVuCX5wLr5lRVmj6ad/BWuC2Q5wPTORuD1LiIca0B
         difwEzS1EHXm9Py2//ce/m+U7tdU7oDttRQs9tiO0VbIedYf7OiPKsodLo0MlsbV2RJn
         aoug==
X-Gm-Message-State: AOJu0YyqM3bqG78FsFAW7FGsIYOa+RZH4Y8qD3gjJ6DGtFiUWBXfybs3
        6DZiiA346siptOicbnCOpsviLwd5phCVTKs87yw99hMj
X-Google-Smtp-Source: AGHT+IEcYme9WYcyEM3tU6U/FMRlksky5XYWtJdP3vjJYIQ++ZtkextoGQgkPlOV4jNthQQh6+M1RQ==
X-Received: by 2002:a2e:840b:0:b0:2b9:4093:a873 with SMTP id z11-20020a2e840b000000b002b94093a873mr2399358ljg.5.1691696715402;
        Thu, 10 Aug 2023 12:45:15 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id gw4-20020a170906f14400b00993b381f808sm1328550ejb.38.2023.08.10.12.45.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 12:45:15 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so11184705e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:45:15 -0700 (PDT)
X-Received: by 2002:aa7:d0cb:0:b0:523:5012:63d5 with SMTP id
 u11-20020aa7d0cb000000b00523501263d5mr3095069edo.16.1691696217947; Thu, 10
 Aug 2023 12:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230809103658.104386911@linuxfoundation.org> <CAEUSe787p3uDD9Q0wq=Y=PY0-wLxbYY8oY6T24dhm+qgK1MjNw@mail.gmail.com>
In-Reply-To: <CAEUSe787p3uDD9Q0wq=Y=PY0-wLxbYY8oY6T24dhm+qgK1MjNw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Aug 2023 12:36:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTzjgRRPmfkwOr89uMuk5wdoG_6edMAnEdubX9bq8OSw@mail.gmail.com>
Message-ID: <CAHk-=wiTzjgRRPmfkwOr89uMuk5wdoG_6edMAnEdubX9bq8OSw@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/323] 4.19.291-rc1 review
To:     =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        lyude@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 at 12:28, Daniel D=C3=ADaz <daniel.diaz@linaro.org> wro=
te:
>
> Two new warnings are introduced on x86_64 with GCC-8 (defconfig):
>
> -----8<-----
> drivers/gpu/drm/drm_edid.o: warning: objtool:
> drm_mode_std.isra.34()+0xbc: return with modified stack frame
> drivers/gpu/drm/drm_edid.o: warning: objtool:
> drm_mode_std.isra.34()+0x0: stack state mismatch: cfa1=3D7+112 cfa2=3D7+8
> ----->8-----
>
> Bisection points to the quoted commit ("drm/edid: Fix uninitialized
> variable in drm_cvt_modes()"), 991fcb77f490 upstream. Reverting makes
> the warnings disappear.

Bah. Stable should pick up commit d652d5f1eeeb ("drm/edid: fix objtool
warning in drm_cvt_modes()") from mainline too.

Sadly it didn't have a 'Fixes:' tag, so it didn't get picked up
automatically. My bad.

Although it's not like the commits it fixes were actually ever marked
for stable either. I guess commit 3f649ab728cd ("treewide: Remove
uninitialized_var() usage") got picked up as some kind of "make it
easier to apply other patches" thing.

               Linus
