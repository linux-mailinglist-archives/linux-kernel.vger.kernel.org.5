Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E5F791DA8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjIDTdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbjIDTcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:32:00 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA9ACCB;
        Mon,  4 Sep 2023 12:31:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4030CCE0FBE;
        Mon,  4 Sep 2023 19:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A86C433C7;
        Mon,  4 Sep 2023 19:31:51 +0000 (UTC)
Date:   Mon, 4 Sep 2023 15:31:49 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     lee@kernel.org, alexandre.torgue@foss.st.com,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] counter: fix, improvements and stm32 timer events
 support
Message-ID: <ZPYwpdQUWp0V43FU@ishi>
References: <20230829134029.2402868-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CVt1obDrKjorrKCm"
Content-Disposition: inline
In-Reply-To: <20230829134029.2402868-1-fabrice.gasnier@foss.st.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CVt1obDrKjorrKCm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 03:40:21PM +0200, Fabrice Gasnier wrote:
> This series combines some fix and improvements to the counter interface,
> found while stm32 timer counter driver developements.
> It also introduces a new tool that can be used for testing.
>=20
> Then, it improves the stm32 timer counter driver by introducing new signa=
ls,
> e.g. counting frequency, and missing channels.
> It also adds support for interrupt based events using the chrdev interfac=
e.
> Two event types are added in this series: overflows and capture.
>=20
> Up to now, stm32 timer counter driver focused mainly on quadrature
> encoder feature. With this series, all timer instances can be enabled
> for simple counting (with overflow and capture events).
>=20
> Fabrice Gasnier (8):
>   counter: chrdev: fix getting array extensions
>   counter: chrdev: remove a typo in header file comment
>   tools/counter: add a flexible watch events tool
>   mfd: stm32-timers: add support for interrupts
>   counter: stm32-timer-cnt: rename quadrature signal
>   counter: stm32-timer-cnt: introduce clock signal
>   counter: stm32-timer-cnt: populate capture channels and check encoder
>   counter: stm32-timer-cnt: add support for events
>=20
>  drivers/counter/counter-chrdev.c     |   4 +-
>  drivers/counter/stm32-timer-cnt.c    | 585 ++++++++++++++++++++++++++-
>  drivers/mfd/stm32-timers.c           |  46 +++
>  include/linux/mfd/stm32-timers.h     |  26 ++
>  include/uapi/linux/counter.h         |   2 +-
>  tools/counter/Build                  |   1 +
>  tools/counter/Makefile               |   8 +-
>  tools/counter/counter_watch_events.c | 348 ++++++++++++++++
>  8 files changed, 998 insertions(+), 22 deletions(-)
>  create mode 100644 tools/counter/counter_watch_events.c
>=20
> --=20
> 2.25.1
>=20

Hi Fabrice,

There are a number of precursor changes in this series that are somewhat
independent, so I'll be taking some patches separately to simplify
things and review this patchset a little at a time.

Thanks,

William Breathitt Gray

--CVt1obDrKjorrKCm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZPYwpQAKCRC1SFbKvhIj
K3XrAQCnJXaTzbk3S1ZQotXMnidjHAeezrMw2IP6V2HkdsTgeQD+IwiZkXrVD0n/
fcBlRITVdLaPEwU4OA/RUVBqbs83ZQw=
=/BPa
-----END PGP SIGNATURE-----

--CVt1obDrKjorrKCm--
