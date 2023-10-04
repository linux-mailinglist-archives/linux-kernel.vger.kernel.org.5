Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0881D7B761A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 03:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238800AbjJDBGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 21:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjJDBGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 21:06:12 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE584B7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 18:06:04 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-4526a936dcaso817591137.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 18:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696381564; x=1696986364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FD7N4+ki8yTbIdFjxebxQX9Pl+69rX6n0uIJQxEwL/U=;
        b=JqGEHJcwTtp/zESninS3W1haptLQU+5+Hap5MsNpkIIQ7Uz0X+TaV11BE7c1TAcpw9
         yAtjKrChRbrS3oD55MYbFOljdWkGfPlk3/hRWV45SlXpRjMbxTR/rOB0Od0Xs/6A9TNS
         MV/YmjLH8QZCYzlgNHXh5a0XgNvHSc86yAlPdTufbE2yZBurmz4J7ANIPvBsRNROEsz9
         SW+ZOlj+uzYtGm8RQageeG2N1Wd7zYTuv+IwsYC0sM5ls/bKRhGOOArpZj0VWUyw1Xia
         eKFoo0hyDBUBXvSoPMIufvb3Q0YepIMqGOF3QMCP5ETU1wd/EQs7WPzYOngFyX/TJLlF
         C1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696381564; x=1696986364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FD7N4+ki8yTbIdFjxebxQX9Pl+69rX6n0uIJQxEwL/U=;
        b=FY8yXwAXEgGBu8KeqTeJ8p+f0/HGvuSRaM1x8TrrNy8krPq0LhQHUUOrbyTcv2bgk0
         9jW0uOFiu4qi0o/RtQzyFCc0HZfWip1pBD7bd8YgwDoCcmcAvSHnLbUmJWPyysrc8AFt
         ytdFk3dT2T+vgnBJg8gy035GfpPB+iWCX8XWvT8AUPaOvVgsKAYw7StF/oHJEDms9P0G
         FO+6w9Ee8UV60HFXdACsPzri5l2a/ShkdVyuI+AbXNTzDpDaStZ+l+9i/rTWqcepGZAV
         nAsDrN6hBOnj2mvO1bMNfVdK4ZOriWtCyOlmnLycsMZ37kP91pQz9GYTlaYhHRVQoqbs
         VFBA==
X-Gm-Message-State: AOJu0Yxvhirfn40QwdybOfuD/Pl++rtv9IdeGizYboHOYyECP5tcPQiG
        eJOT8cDVus1h6CJ8drRlFzLing==
X-Google-Smtp-Source: AGHT+IGYmIVwKRybktecfaCThlChpL8Li43s8SGPeblCnhS/dSopbmKh5eEzTeCOe+/o6Pgb7hDS5g==
X-Received: by 2002:a67:f65a:0:b0:44d:3f96:6c61 with SMTP id u26-20020a67f65a000000b0044d3f966c61mr895407vso.30.1696381563938;
        Tue, 03 Oct 2023 18:06:03 -0700 (PDT)
Received: from fedora (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id h1-20020ab04701000000b007aba00406a4sm369973uac.7.2023.10.03.18.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 18:06:03 -0700 (PDT)
Date:   Tue, 3 Oct 2023 21:06:00 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     lee@kernel.org, alexandre.torgue@foss.st.com,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] tools/counter: add a flexible watch events tool
Message-ID: <ZRy6eCSE7PhTTyvN@fedora>
References: <20230829134029.2402868-1-fabrice.gasnier@foss.st.com>
 <20230829134029.2402868-4-fabrice.gasnier@foss.st.com>
 <ZQdOcDQR6qONmmnR@fedora>
 <7aa66ac8-eceb-2f6e-960b-2c4dac9f595e@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jZtSijHBWetMsQRX"
Content-Disposition: inline
In-Reply-To: <7aa66ac8-eceb-2f6e-960b-2c4dac9f595e@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jZtSijHBWetMsQRX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 05:37:34PM +0200, Fabrice Gasnier wrote:
> On 9/17/23 21:07, William Breathitt Gray wrote:
> > On Tue, Aug 29, 2023 at 03:40:24PM +0200, Fabrice Gasnier wrote:
> >> This adds a new counter tool to be able to test various watch events.
> >> A flexible watch array can be populated from command line, each field
> >> may be tuned with a dedicated command line argument.
> >> Each argument can be repeated several times: each time it gets repeate=
d,
> >> a corresponding new watch element is allocated.
> >>
> >> It also comes with a simple default watch (to monitor overflows), used
> >> when no watch parameters are provided.
> >>
> >> The print_usage() routine proposes another example, from the command l=
ine,
> >> which generates a 2 elements watch array, to monitor:
> >> - overflow events
> >> - capture events, on channel 3, that reads read captured data by
> >>   specifying the component id (capture3_component_id being 7 here).
> >>
> >> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Fabrice,

Sorry for the delay, I'm currently working through my backlog. I see you
have already submitted a version 2 of this patchset, so I'll continue my
review there but I do want to make some direct replys here below as
well.

> > This is a new tool, so would you add a MAINTAINERS entry for the
> > counter_watch_events.c file?
>=20
> I haven't thought about it.
> I can add a MAINTAINERS entry, yes!
> Who would you suggest ?

Typically the author of the initial patch will also maintain what they
are introducing, but an alternative person is acceptable to serve as
maintainer if that's the plan that's agreed upon. I assume you're
introducing this tool because you're using it internally at ST for
testing, so I suppose the intention is not to get this merged upstream
just to abandon it (i.e. you intend to keep using and improving it). Is
the plan for you to maintain this utility, or is someone else at ST
interested in it?

> >> +	}
> >> +
> >> +	/* fallback to number */
> >=20
> > I'm not sure it makes sense to support numbers. Although it's true that
> > the component type, component scope, and event type are passed as __u8
> > values, users are expected to treat those values are opaque and pass
> > them via the respective enum constants. Since we don't guarantee that
> > the specific enum constant values will remain consistent between kernel
> > versions, I don't think it's a good idea to give to users that sort of
> > implication by allowing them to use raw numbers for configuration
> > selection.
>=20
> Ack, I can remove this.
>=20
> I'm a bit surprised by this statement. I may be wrong... I'd expect a
> userland binary to be compatible when updating to a newer kernel: e.g.
> user API (ABI?) definitions to be stable (including enum constants) ?

I was wrong in my previous reply. You're absolutely correct[^1] that
userspace ABI must be consistent ("Breaking user programs simply isn't
acceptable"[^2]) so the specific values must remain the same between
kernel versions.

Regardless, I don't think raw numbers provide much benefit for the
use-case of this particular utility; users are testing watch
configurations for a particular device, not the specific constant values
in the data structures. So in the end I still think the raw numbers
code path should be removed.

[^1] Well technically Linux kernel ABI README documentation file
     (Documentation/ABI/README) states that backwards compatibility for
     stable interfaces is only guaranteed for at least 2 years, but in
     practice we strive to never change the user-facing ABI.
[^2] https://yarchive.net/comp/linux/gcc_vs_kernel_stability.html

William Breathitt Gray

--jZtSijHBWetMsQRX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZRy6eAAKCRC1SFbKvhIj
K9STAP95tTRE+0GzRVXB8MfYNUgv5OwuwuDTLlkR6iV5UAPp3gEA1+ZCNsosBzzF
Lbr/PCTCJRifx7T+S4h36fLilUjYaAE=
=C8xr
-----END PGP SIGNATURE-----

--jZtSijHBWetMsQRX--
