Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5CC757671
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjGRIVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjGRIVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:21:33 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016DBE7;
        Tue, 18 Jul 2023 01:21:32 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb41682472so8679265e87.2;
        Tue, 18 Jul 2023 01:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689668490; x=1692260490;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AB8Ngr3V9BcLORBsubp2DU4kuTIKwVIlVrqNkhTMySQ=;
        b=oc5LkwQ/8evKtJlR+v6DUPa3ehhIZ2dupY8OP7E3ADnlttlPRvpkGTibrlG+jEKoud
         +Uega60mANERWtEP/oNuhM7nxOh9b9C/HsqpKcwyHK/DT7omNYHKYjUoSUhdEO+KE9Hw
         ++jnFOVVdWN0zMCZJvZp7Zx46yxlZb2v0lwQ5177vxWDmDnBWAITtpSSXBDTzSTnuyNd
         z0RPPIPCEiqg9amzqA9j+WIS1OHhoZipfeBaewwu5j5d8ggRF1jYsC1jzlIoBbu5Zgej
         JGE/4gk+/zFt8AlkSaYeLU+jVFWFItHsSH7Fkl0vAmh5vM0rDQYR5twWOG6WUIf3L/Nx
         1W2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689668490; x=1692260490;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AB8Ngr3V9BcLORBsubp2DU4kuTIKwVIlVrqNkhTMySQ=;
        b=TvP80zGXo2G8lXnt6HsofrI2/Vb2Ua9DldGkbOM81yyq5rdTPyzINkJQekI1lRa/6i
         s8wyThGK1Sh5pcMxogMYO9GVK76iQbEe6P4DsKjTxmxJIndw+1xInYl4YFTglfVXhSrk
         Nc5udmSCZUpXtpRp/2rf1EK+Id67GRrS3YqbKBjcaeEcuEv3hkV4o1N3H+OLz63Li/hq
         2KAem6PI3M9BPT8AgpUnm4rACxMdw5HaaFaxYW15Y4D09KhlpbzBlDfoFb3tSw/4PFV/
         7Un5Xkd1n8xKCOl9xGKxp9dcaPYIGYwaqFFtTVVbUeyP6DrOXu8ke9caeBWoJW7WNpH6
         FMzw==
X-Gm-Message-State: ABy/qLaHPZelvM8aEBrWtz+a2t7zjfEjirfYl0y9vPGFzhEr6KCjyenb
        2zbaZe6s5V+DQEGxVo1/vJ4=
X-Google-Smtp-Source: APBJJlFy++5ejwjSbREKFEWsNU06Yjs3jdB2H/T0LO4ppEKWYYj2W9w7Ov7kSNY21LgvpUmTZ5yfyw==
X-Received: by 2002:ac2:58c8:0:b0:4f4:c6ab:f119 with SMTP id u8-20020ac258c8000000b004f4c6abf119mr11497429lfo.64.1689668489735;
        Tue, 18 Jul 2023 01:21:29 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id d8-20020ac25448000000b004fbe7b01b15sm328919lfn.62.2023.07.18.01.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 01:21:29 -0700 (PDT)
Date:   Tue, 18 Jul 2023 11:21:14 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     alyssa@rosenzweig.io, Luben Tuikov <luben.tuikov@amd.com>,
        Asahi Lina <lina@asahilina.net>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH 2/3] drm/scheduler: Fix UAF in
 drm_sched_fence_get_timeline_name
Message-ID: <20230718112114.6091b28a@eldfell>
In-Reply-To: <a42bd218-6eb5-6ddb-bbb4-d25118c59f40@amd.com>
References: <9c0cff84-45b1-268f-bdad-38c16316dbc3@amd.com>
        <20230714-drm-sched-fixes-v1-0-c567249709f7@asahilina.net>
        <20230714-drm-sched-fixes-v1-2-c567249709f7@asahilina.net>
        <bef7ef62-3cd9-6ceb-5eb4-5ae0c0236778@amd.com>
        <de502b41-2864-db1e-16a0-8a5d5e0e4ad3@asahilina.net>
        <d9dc2fd5-d054-dbf3-72b7-fe9deaa46350@amd.com>
        <236422117088ca854a6717114de73d99b2b9ba2f@rosenzweig.io>
        <a42bd218-6eb5-6ddb-bbb4-d25118c59f40@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WVHIog19ij4cMfwDIbEBPbx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WVHIog19ij4cMfwDIbEBPbx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Jul 2023 17:55:04 +0200
Christian K=C3=B6nig <christian.koenig@amd.com> wrote:

> Am 15.07.23 um 16:14 schrieb alyssa@rosenzweig.io:

...

> > Lina has been polite and accommodating while AMD calls her code
> > "outright nonsense" and gets "outright NAK"s, and puts her into an
> > impossible catch-22 where no matter what she does it's NAK'd. =20
>=20
> Well as far as I can see I'm totally polite as well.

Christian,

politeness is in the eye of the beholder. You do not get to decide how
other people feel.

I consider myself a very blunt and difficult reviewer on my own area
(which I consider mostly as a negative trait), and while I have
alienated some people over the years, I try hard to not intentionally
hurt anyone. Sometimes it means that writing one email takes an hour or
two. It can take a tremendous amount of energy. Like this email here.

If people have the courage to repeatedly tell someone that the someone
comes out as off-putting, it cannot be dismissed. It really means
coming out as off-putting. There does not need to be anything malicious
related to it from either side, it could as well be a cultural
difference that one cannot know in advance, or it could be a personal
hurt inside the offending person lashing out.

When told, it is time to reflect.

> Pointing out that approaches doesn't seem to make sense and NAKing=20
> patches is a perfectly normal part of the review process.

Yes. You don't have to change your message.

One only needs to make an effort to try to change their tone. Otherwise
they lose and alienate developers by choosing to hurt them. It was an
accident before one knew about it, but now it is known, so how one
communicates is a decision. It's no longer an accident.

> What you need to to is to take a step back and ask yourself why this=20
> here is facing so much rejection from our side. I have to admit that I=20
> don't seem to be good at explaining that, cause we are obviously talking=
=20
> past each other, but you don't seem to try hard to understand what I'm=20
> pointing out either.

Maybe try using a softer tone for a start? Lina has reiterated the
restrictions imposed by the hardware, the firmware they cannot change,
and Rust design principles. How do *you* fit those with unchanged
drm/sched?

> > That's not ok. =20
>=20
> As far as I can see it is.

Hurting people is not ok.

Not even if the kernel community culture traditionally does so.

> As maintainer of a commonly used component my first duty is to preserve=20
> the status quo and prevent modifications which are not well thought=20
> through.

Of course.

Accidentally hurting someone is eventually unavoidable. Defending the
communication style that hurt someone in order to keep on doing that
just makes one look like a d...


Thanks,
pq

--Sig_/WVHIog19ij4cMfwDIbEBPbx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmS2S3oACgkQI1/ltBGq
qqc3xg//a7Rm8AtF+Hqd/6u+nhmhyNS8DNP4MzOLxfK3igpGO2znlbQEQ/GA4TN9
zULvrzO+vWVGtORnvaCrbhC/1slWrDaYMCeaWa/leH4MsUHAgiWd4i3S548kPLne
75vg/l2F/Jiw09JA1FAAbT3BG1xuLDNa7rHPbwoSdtnvWUUvZOQbn+NL8XrVsHfQ
N6LWRJT2fCoID1juBqE61mcPKvax+EXZEJ6Rrz6DAvmMIbPjLIrEDGAZTTFNjfSM
ggo5WW/1970DYmMoZKtO+T6Omym2Yxjxa3nBjOEl4wF3P7Xv/HYp8kb8+hOiiVBL
pgYt9ITdN8O8/q/p9AWKRfR2Xs/1mVketGF4BbpxSI63tDwBh1gTCfo9HzhoFCp1
RUSL4Xkz+geufSFCrRhDk9ZCsKhFhdqQFurfnQcW9GDxdykBXQzQB6mUAxXKAAA8
2m1EZtDzMVNRtCTeRM//1ecrC+YnMFE/pwEzh3ovh759BdtF5OU69tysfO9hpnkZ
I71aobgxpsLFNR48FWUTevdQIReFQE7UY887+Zb8MYhXujAiBKWPy2XyjLk7lU7a
tdJEo4EtdZf7OgdX/DImDe12b9G1IJRVQRnpoGQ7LAZVsmK9N7VVtPS3B95H0nyu
ypJmYqoDT2rVjAg1+5DIiMgGrHictBhdUrcJuj3nnlu8Qwspah4=
=xd9m
-----END PGP SIGNATURE-----

--Sig_/WVHIog19ij4cMfwDIbEBPbx--
