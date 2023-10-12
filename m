Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D887C6B4F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377746AbjJLKj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbjJLKj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:39:58 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72DA90
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:39:56 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5068692b0d9so1108451e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697107195; x=1697711995; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8S0X95eosKBQe6vHh4E9A2FwpV5neLU3p1lN+rp2jw0=;
        b=NIyXipuD3NuCR9dyLHVw07FE1EclHCH6BB7pxSc4SZP7oVpvoBy4UGM+Fd8pn1qE5k
         HIhs2b4th8SSanWFmJNv7qPZ7CljUwK7fT54zyIFBTAxEM39tydwyNU189Uq59Vb6ARs
         LOjNDQgbVtf6J3+9Bmc7fubmseJAsntQuuOUxAJhLIru5i2xqlCFkWIL2QN/JSdLGY7d
         iPBlbyI99dc9V8bo5S1gCVj4Aqaux11+lz1KOU5jcM+VQb0bdtJoKE9WeRucSJkxcLrV
         rXh6UQpg+6+lOJlVpQoRjuWCme2o+7fdXqCHk72Y9Qjl2O4BliSmPLfJS2iJWhrQPHHW
         3ueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697107195; x=1697711995;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8S0X95eosKBQe6vHh4E9A2FwpV5neLU3p1lN+rp2jw0=;
        b=j9Y0vZHitIVufUfyF/KH0WcRdR1cxztVMuVtX3XN6gZXRgXZPsJbb2RPMfUlm7tBt5
         MzHuxB3NDc9KoXSPunjc7FuUIXRp9PyQk9BkuJSHcI3Pgnez9Q1HermqHSmJVm9xSV4d
         LbpaL6hOrGo1VCTQIJoUDkDIR815UHA8DpBEesyHDDDIXtQO1DiLd7XtQoMJtxubJFRp
         25ul+lXgnN7SRVBWXhUwOsauMW8B894i6UpJOC6kiII1jtIxdr08vzD0LsAo6dC6EMD2
         YOlXJ8z4MtB56NEgEoFb9GKdlibmkIht+jWi2y8b7HTngrRn6MCQ8ryD+GfoVGrbuLGK
         0fRQ==
X-Gm-Message-State: AOJu0YyS843mPCxCLddHpcpGK9UE9S6I8fiSTsjbrsIjxioABHhgd1Tw
        Hw92UGtA/+edCRwXdsRLCjs=
X-Google-Smtp-Source: AGHT+IG9j9Sef0jOnx8+q/I355j3Y4eMK2YOk23TwjYRGbGkKvFGZVbSAsV7zfzEP2fETYb2QSEplg==
X-Received: by 2002:a05:6512:3da0:b0:500:7c51:4684 with SMTP id k32-20020a0565123da000b005007c514684mr24744248lfv.56.1697107194617;
        Thu, 12 Oct 2023 03:39:54 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id q9-20020a19a409000000b00501b9fc977csm2709857lfc.37.2023.10.12.03.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 03:39:54 -0700 (PDT)
Date:   Thu, 12 Oct 2023 13:39:44 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     jim.cromie@gmail.com,
        =?UTF-8?B?xYF1a2Fzeg==?= Bartosik <lb@semihalf.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "wayland-devel@lists.freedesktop.org" 
        <wayland-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v1] dynamic_debug: add support for logs destination
Message-ID: <20231012133944.69711822@eldfell>
In-Reply-To: <ZSfCMBXOOi9Luc6F@phenom.ffwll.local>
References: <20231003155810.6df9de16@gandalf.local.home>
        <CAJfuBxyJyFbFEhRxrtxJ_RazaTODV6Gg64b1aiNEzt6_iE4=Og@mail.gmail.com>
        <CAK8ByeLNc9UbTNG4x=40AxYqjjRCsvBNtNFai0PMveM2X4XCow@mail.gmail.com>
        <CAJfuBxyRF4q_T8LmHwR=-PKKDDpiFg2nO03uLnL8aGpRyBByKw@mail.gmail.com>
        <CAK8ByeLpkSV6o6gPw8eJVqq5+ynQrSDjemY7mXkO1ZmA0rYKfQ@mail.gmail.com>
        <CAJfuBxw+ANLwssAGWpkn5PeJb8ZKn4LXQkk2Gfv3aGsSN=S55Q@mail.gmail.com>
        <CAJfuBxy9qn-4i3SteTL1LBbBxPrFM52KkBd=1UhcKV3S_KdQvw@mail.gmail.com>
        <20231011114816.19d79f43@eldfell>
        <ZSZuACLwt5_XAL2n@phenom.ffwll.local>
        <20231012115548.292fa0bb@eldfell>
        <ZSfCMBXOOi9Luc6F@phenom.ffwll.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/V8y/wlfhGWh8m+OH4pSW+7u";
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

--Sig_/V8y/wlfhGWh8m+OH4pSW+7u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Oct 2023 11:53:52 +0200
Daniel Vetter <daniel@ffwll.ch> wrote:

> On Thu, Oct 12, 2023 at 11:55:48AM +0300, Pekka Paalanen wrote:
> > On Wed, 11 Oct 2023 11:42:24 +0200
> > Daniel Vetter <daniel@ffwll.ch> wrote:
> >  =20
> > > On Wed, Oct 11, 2023 at 11:48:16AM +0300, Pekka Paalanen wrote: =20

...

> > > > - all selections tailored separately for each userspace subscriber
> > > > (- per open device file description selection of messages)   =20
> > >=20
> > > Again this feels like a userspace problem. Sessions could register wh=
at
> > > kind of info they need for their session, and something like journald=
 can
> > > figure out how to record it all. =20
> >=20
> > Only if the kernel actually attaches all the required information to
> > the debug messages *in machine readable form* so that userspace
> > actually can do the filtering. And that makes *that* information UABI.
> > Maybe that's fine? I wouldn't know. =20
>=20
> Well if you configure the filters to go into separate ringbuffers for each
> session (or whatever you want to split) it also becomes uapi.

It's a different UAPI: filter configuration vs. message structure. I
don't mind which it is, I just suspect one is easier to maintain and
extend than the other.

> Also I'd say that for the first cut just getting the logs out on demand
> should be good enough, multi-gpu (or multi-compositor) systems are a step
> further. We can figure those out when we get there.

This reminds me of what you recently said in IRC about a very different
topic:

	<sima> swick[m], tell this past me roughly 10 years ago, would
	have been easy to add into the design back when there was no
	driver code yet=20

I just want to mention today everything I can see as useful. It's up to
the people doing the actual work to decide what they include and how.


Thanks,
pq

--Sig_/V8y/wlfhGWh8m+OH4pSW+7u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmUnzPAACgkQI1/ltBGq
qqcgOBAAkNg/qe5usX57owmljxA5OMxQ9zGY9LO58+UbrVSeYOQgr087FZpIf2LJ
0AKOGqgH9aa6jVPTncN8i3DdfB3wKdrYO0VUDLg2jkzXq57FsD2XUL1OdxirtI9r
WPAYEkzQLwaoI6Dc/VfTWgcHpQ9i5Z0pVqJZ5SMn0s6HDKoLxLOWNq75NPNV6eLG
6LBWICQPT0WoocsF1G747/RsdmDxHihv3zs9+YnrZU7AYrok+VxIcw+ze81guWpt
XtqHP7Lfngu8qDmQFuG2U6JG75R4oKc+Nzmvoyr8n0bE66EkUeA/Lw+dEJvr5KB5
wvPQP4kHdPblnATAak5EencXSPm4vsmWpJymr24zy6FYJmM20hR1H6x0TTgv8eux
CWC02+vgweXnIVktJuwQHHoWVe0i+CPdcPQx+etAodicoHMr8JVcrfLgijFkLyME
Qg865bepY2hxJuVIqPkW2OFfzdludfUlPE8QaVM56sakfzB3rXcmwmsIBaPiuJ5P
9Vdxtl03SuoHbPj09jYOXf/ldizPjVG2U8McQ/tQBRnJzUCBGnWETGsZa1SP5mXs
Nzj2XvD+LdjsBOVLVxZyYaSRjnRJ/+WF1J7BfqqPww6g8p5ZxZuGQ8gds0TE9Pyj
7ITB9OLv9f7SN1eN/Pg8qCNlOFwf9cC8h3g/O0Em39+JWZ8HDBw=
=fzw5
-----END PGP SIGNATURE-----

--Sig_/V8y/wlfhGWh8m+OH4pSW+7u--
