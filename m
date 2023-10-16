Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA3C7CA7E1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjJPMTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJPMTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:19:15 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92A2E1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:19:13 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50308217223so5138059e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697458752; x=1698063552; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6EhyDqUQjEdCPm8wLm8OFPGsaItsVSXANH1gNBCUPXs=;
        b=iEYNvzXRySHcjCigoGPHuX5QDsIS6e/u5tR+HHgMCBhbvbr8GPOHTeBqwzly043e+Z
         YF7uk+GjTK1W2ifNDBNXGsWxt+3RStf2imj5hmmplh6+pTnfuNi03C9Jwc6K3zdkCQlD
         6S73anQkNMMa476baYQ6gTFNaEvkXpGXDZVupedXFrvzBLx0upGsSitJaC0LavKrxRfi
         uBze5xuXWjA+87LwItV/T/t7e02scAJHw3JHT6H7yrT4MbF3E/WsvlE0q6wYXaLXXMS5
         iJ+pUfe5KOlQsXq/UEuu/kWwBQzMx5PbdwIQxB5srFEy++S/YGKDckCbDRHOM3PK3gsA
         6Gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697458752; x=1698063552;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6EhyDqUQjEdCPm8wLm8OFPGsaItsVSXANH1gNBCUPXs=;
        b=KkkrBGAmK4XuucLxpNHWHSElnxSWl7TvXY1919BkNclDYDU7JoJm8W4j/eI8kmDQSv
         ejPuTX9BEv+0aHrsqGdi+mzcSsqyox0SD1FbqLTykvTeerqDpnvnMTOJutTza9WABtk4
         Oc3JUgRn4BjhzQUFmbJWWBiPADo71AZiQt5doVh2pKE6b4LnZBdwDAF0ZYN3mxWRD5Xy
         ijSCbf5Scc+ZBeKHXnwdad77Xm3L2Hf7m/NhnbeMfg7TAuneqxf/zTobDf+vX4nzCTs8
         EIhUb/mRsUMI5elKzLRgGQj/DrTdEF84srlMAniaC8pYBJS6ys8qoRJUfoGB7pUIzsHA
         TuIA==
X-Gm-Message-State: AOJu0YyoUPXrVYS5GE/YJbbmUT64BWCXINDWASOlepiCc1KeR//lPnEC
        qAaJiIZDwsmLcqYqj7RCaC8=
X-Google-Smtp-Source: AGHT+IFEsLXStxwkdwRXiQB2HK7VTB81PgSSMx0CUVuOSYNVWvv3i/9WVm8Y1nugkxm6d3lmo6GTdA==
X-Received: by 2002:a05:6512:132a:b0:503:2877:67e3 with SMTP id x42-20020a056512132a00b00503287767e3mr32451180lfu.6.1697458751652;
        Mon, 16 Oct 2023 05:19:11 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id x9-20020a056512078900b00507a0098424sm1175692lfr.109.2023.10.16.05.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 05:19:10 -0700 (PDT)
Date:   Mon, 16 Oct 2023 15:18:56 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc:     Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>,
        xaver.hugl@gmail.com, pierre-eric.pelloux-prayer@amd.com,
        Daniel Vetter <daniel@ffwll.ch>,
        'Marek =?UTF-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Stone <daniel@fooishbar.org>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, hwentlan@amd.com,
        Rob Clark <robdclark@gmail.com>, ville.syrjala@linux.intel.com,
        kernel-dev@igalia.com, alexander.deucher@amd.com,
        Dave Airlie <airlied@gmail.com>, christian.koenig@amd.com,
        joshua@froggi.es, wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 6/6] drm/doc: Define KMS atomic state set
Message-ID: <20231016151856.74af9305@eldfell>
In-Reply-To: <b48bd1fc-fcb0-481b-8413-9210d44d709b@igalia.com>
References: <20230815185710.159779-1-andrealmeid@igalia.com>
        <20230815185710.159779-7-andrealmeid@igalia.com>
        <1b23576d-1649-ff5c-6273-b54729ea46d8@mailbox.org>
        <b48bd1fc-fcb0-481b-8413-9210d44d709b@igalia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/69O8rYFAi5QP/ITj8UsboXe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/69O8rYFAi5QP/ITj8UsboXe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Oct 2023 12:52:32 +0200
Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:

> Hi Michel,
>=20
> On 8/17/23 12:37, Michel D=C3=A4nzer wrote:
> > On 8/15/23 20:57, Andr=C3=A9 Almeida wrote: =20
> >> From: Pekka Paalanen <pekka.paalanen@collabora.com>
> >>
> >> Specify how the atomic state is maintained between userspace and
> >> kernel, plus the special case for async flips.
> >>
> >> Signed-off-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> >> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com> =20
> > [...]
> > =20
> >> +An atomic commit with the flag DRM_MODE_PAGE_FLIP_ASYNC is allowed to
> >> +effectively change only the FB_ID property on any planes. No-operatio=
n changes
> >> +are ignored as always. [...] =20
> > During the hackfest in Brno, it was mentioned that a commit which re-se=
ts the same FB_ID could actually have an effect with VRR: It could trigger =
scanout of the next frame before vertical blank has reached its maximum dur=
ation. Some kind of mechanism is required for this in order to allow user s=
pace to perform low frame rate compensation.
> > =20
> Xaver tested this hypothesis in a flipping the same fb in a VRR monitor=20
> and it worked as expected, so this shouldn't be a concern.

Right, so it must have some effect. It cannot be simply ignored like in
the proposed doc wording. Do we special-case re-setting the same FB_ID
as "not a no-op" or "not ignored" or some other way?


Thanks,
pq

--Sig_/69O8rYFAi5QP/ITj8UsboXe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmUtKjAACgkQI1/ltBGq
qqf20RAAnw0oZXemzgfErYkfbspei2AiW5NBarJedqPGc6nsl6TnUV3oNRGogGLL
vJpsyTvfxmYgb79fTvuB5fc0nJJecuwtQ17W6x9VcwJkZOpdRi2Uez2AO9dvNpSW
VKVVuyujVmyCk+UofjyHa+zUJC31YakmhiF6LFPB0IyYdo/+o6svRpn2lmHNXRU/
v4KFGi8S1wsg3iokMemnpJZYvdc+mSH0W9WJ0kaesv3Wn05xnBpmfySR9DZzUq9t
qUoGipgOnfQ/LLfkvLqece8bxP6ENtFNERXfE6YpWz0LTIqsW+TCV/QfmcgrD6iU
2R/+LH8GzZ2pjovxbqXsps5QKTB+wkSydkDQuwt0eR4Rx7k1NAzaKWP2Xg934wDB
BIOzsHzjB8dchzjf3+8/ezSuocAxWtGRV6eaJ8sFLYFh6OB+bi6K00v7eg4J5scK
aSjf5fmeP2JNWbfEqLlK1tWYAsT37g08MUEIewGXBceG3C3vaNgwLjgKFbL/KNff
uLL0zgusaKtDxxKsDCti6bVJb+ntmpnp92PGh2lPp33DplZ32/5/kd7fwe9Sh21K
iPFaqtyBR4u1BadTVhekLmXNY0YIpevjdNl+B+EBRvM6HaxHRdrnakLgg6IWDEsY
8oEZ3kIQ1cJxtNVktLqy6X8T9fZL4U7emXJKvYdJMiubbMq5MFs=
=ZKmt
-----END PGP SIGNATURE-----

--Sig_/69O8rYFAi5QP/ITj8UsboXe--
