Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3950175FCCD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjGXRA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjGXRAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:00:20 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0FE19AD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:00:01 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-4863752ec88so76158e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690217999; x=1690822799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GpPVCGUI1b90lVt/J/Pv7H5HNHNL2Yxzz8z+9HV7W0Q=;
        b=wk5hu72Jiuc9eXzgdq9U9kZjMic0UlwRZmLcw52kAaqHqscqKpv6LmH1Zt0Q9m4qiB
         ihVmOc1c7GkMAYGEzRTlUAnIWsZG+pW8QSrk1ljcOPcchdMMgJB7aMeaBlUHhqPUBx4+
         070RUcTe9y/gvICn2a3nUoL07bRnaEy/taGuNLy8OvMPkR2pTy6151pWRVt6azYCC3fM
         +KvlOnr1OV7pObpEHoIH3gNTW+1AfkXb4WesiBW0lAS6GlvZB7N6pr/5NbHtfZU7lRxs
         2MkP2WDQj9nIh1sANzx8Evp5H3lgEDggSRB8NHy27/d1bwksh7rXrr74TBsHoYQySQuW
         PrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690217999; x=1690822799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpPVCGUI1b90lVt/J/Pv7H5HNHNL2Yxzz8z+9HV7W0Q=;
        b=LFEFE0J8eZ98pDij7xOFp77gVkH3lFFVl7J7+3YfjH+jxKZI6WgioPEcwW/hFM4Upt
         Mc14lmdn04RVbOMnXcLlsGpi2cy4HW36ikdLdvg963q/watBtOVgmLHyR5325vtIXshF
         jui4d3S68fjoX0ile+l5TfgkRBYDoRaL/cz1o5jUz1/hQS0AuLf3Ne/Z3CmBlXGExJCr
         JbnG2wj0Y3JimS5D6WkxkJbuiTD0IXm5WNd1vtGt7BPGHRkeVv8/zGxgUPzEuTigbBGj
         CoZyW2eRKJWG+OiNTJNhsPxzivcWDCrwFvUxZx5Wb6tIisJ/ZVMZDD/2os8bllVsFC4h
         Gg+w==
X-Gm-Message-State: ABy/qLYwoEzszv+7rsREfMguD345G9W+79UGyo07MUdHbddQ6bEB9hka
        Nl68q8pyNSraRpLbuKSpoqK6pw==
X-Google-Smtp-Source: APBJJlGr5YdRbZFwfgpR+uAkVkdDg8Zhuqzwv6fN+rTT3TvIjaBLedt5Ool2PRzhUNzGGti8BXJ9TA==
X-Received: by 2002:a05:6102:1357:b0:430:e0:ac2e with SMTP id j23-20020a056102135700b0043000e0ac2emr2813621vsl.15.1690217999665;
        Mon, 24 Jul 2023 09:59:59 -0700 (PDT)
Received: from fedora (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id x24-20020a67c098000000b0044360ff4275sm1364969vsi.28.2023.07.24.09.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 09:59:58 -0700 (PDT)
Date:   Mon, 24 Jul 2023 12:59:56 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [patch 00/58] x86/apic: Decrapification and static calls
Message-ID: <ZL6uDN4KmYTk8R1J@fedora>
References: <20230717223049.327865981@linutronix.de>
 <CACRpkda2T2gxfjmHYqMNk-De7phRzeMFvenH84XJMK7BXbdv0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xO/vnO/Wn5eDLd10"
Content-Disposition: inline
In-Reply-To: <CACRpkda2T2gxfjmHYqMNk-De7phRzeMFvenH84XJMK7BXbdv0Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xO/vnO/Wn5eDLd10
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 04:29:23PM +0200, Linus Walleij wrote:
> On Tue, Jul 18, 2023 at 1:14=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>=20
> > This builds and boots on 32bit and 64bit, but obviously needs a larger =
test
> > base especially on those old 32bit systems which are just museum pieces.
>=20
> These things are indeed museum pieces if you think servers, desktops
> and laptops. They will at max be glorified terminals.
>=20
> What we noticed on ARM32 is that it used for:
> 1. Running 32-bit kernels as guests in virtual machines (I don't know if
>   x86 has this problem, sorry I'm ignorant there)
> 2. Embedded systems with very long support cycles
>=20
> For x86 there is PC104, I think William Breathitt Gray knows more about
> those, scope and usage etc. The typical usecase is industrial embedded
> (I've seen quite a few e.g biochemical lab equipment set-ups) which are
> running on a "it works don't fix it"-basis but they are network connected
> so they may need new kernels for security reasons, or to fix bugs.
> https://en.wikipedia.org/wiki/PC/104
>=20
> These things have lifecycles that easily outspans any server, desktop or
> laptop. 30+ years easily. They are just sitting there, making whatever
> blood cleaning agent or medical.
>=20
> I think the automation people have mostly switched over to using
> ARM things such as RaspberryXYZ for new plants, but there is some
> poor guy with the job of keeping all the PC104 plants running on recent
> kernels for the next 20 years or so.
>=20
> Yours,
> Linus Walleij

It's true that there a still a good number of PC104 setups still running
out there in the manufacturing sector. However, it should be noted that
these are typically systems that are configured and set once, left to
run indefinitely doing their specific manufacturing task until the
machines invariably break down from wear a decade or so later.

It's rare for the software of these systems to be updated; where a
machine fails, the owner will usually repair or replace the particular
mechanical component and reload that same ancient software they have
been using for years. The cases where software is updated may be out of
necessity to support a replacement device for a component that is no
longer in production. In these situations, you would find newer PC104
devices to fill that gap: where compatibility is needed with the ancient
core machine featuring only an ISA bus, but which the plant owner
doesn't want to throw away because "it still runs just fine with a
little spit shining."

Perhaps some years ago I would have said there was still demand for
PC104 support, but now with the motherboards of these older systems
finally failing due to age, the owners of these machines are forced to
upgrade to something newer. As mentioned, I've also seen a general trend
in this sector to move towards ARM products, perhaps out of a desire for
lower power consumption or maybe their industrial line of features.
Overall I don't see much future for PC104 in newer kernels because as
the systems using it fail, users are switching to platforms without it.

William Breathitt Gray

--xO/vnO/Wn5eDLd10
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZL6uDAAKCRC1SFbKvhIj
K7GCAQDt3t3mXYN4MsY7+iG1Bi5mLtGZsbJ2KZk8hUR+BOPPQQEA1IanGc9NwAvr
F9QorNPnTv1vBT1pXnpllbl9GmpXFAA=
=JlPR
-----END PGP SIGNATURE-----

--xO/vnO/Wn5eDLd10--
