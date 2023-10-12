Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFAD7C74F9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379603AbjJLRkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344198AbjJLRkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:40:35 -0400
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6486FC9;
        Thu, 12 Oct 2023 10:40:31 -0700 (PDT)
Received: by bues.ch with esmtpsa (Exim 4.96)
        (envelope-from <m@bues.ch>)
        id 1qqzfe-0003qF-1h;
        Thu, 12 Oct 2023 19:40:25 +0200
Date:   Thu, 12 Oct 2023 19:39:38 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [RFC PATCH] ssb: relax SSB_EMBEDDED dependencies
Message-ID: <20231012193938.16fb7db6@barney>
In-Reply-To: <13eeb01a-2f4f-4c8e-b097-6e80d822862b@infradead.org>
References: <20231007182443.32300-1-rdunlap@infradead.org>
        <20231008093520.42ead15f@barney>
        <22bc05d3-86e9-4cf6-aec6-10d11df1acc3@infradead.org>
        <e551fb4c-1e3d-4e1a-a465-5b88842789c6@infradead.org>
        <20231010204346.78961fc4@barney>
        <13eeb01a-2f4f-4c8e-b097-6e80d822862b@infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=77zqe27yUYwq.aWi2HATI+";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=77zqe27yUYwq.aWi2HATI+
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Oct 2023 20:44:49 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> > I thought about something like this:
> >=20
> > depends on (SSB_DRIVER_MIPS && PCI=3Dn) || (SSB_DRIVER_MIPS &&
> > SSB_PCICORE_HOSTMODE)
> >=20
> > Would that solve the warning? =20
>=20
> Yes, that works as well, although I prefer to express it like this:
>=20
>  config SSB_EMBEDDED
>  	bool
> -	depends on SSB_DRIVER_MIPS && SSB_PCICORE_HOSTMODE
> +	depends on SSB_DRIVER_MIPS
> +	depends on PCI=3Dn || SSB_PCICORE_HOSTMODE
>  	default y

Acked-by: Michael B=C3=BCsch <m@bues.ch>


--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/=77zqe27yUYwq.aWi2HATI+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmUoL1oACgkQ9TK+HZCN
iw5r4w/+L3+1CoIsR0Pmu9kFjOYPZuaNPaeTetHQoBEvuHvQNoiwaWUewWn4mzyk
e0zclN55PHMiY0o28q1/Kp47zZbY4yoiVPRLXTLem3ra4bXDqMmGlK1eL4AvaYj/
T045qAeK5ghBpyTjhyeq2hEdVvJLHR1f1vFPsHdMISx7he8c496PwB7M8F/rK0SK
0EygvpakTOCfcrCpvlDmRIoEYbUsmM0iCHCweDno44OMVIvPDgm4s2aQ4nrJP4av
fObGOdbc1uGuObs2oQWRBF/bvCTFzzCHgNhhr+A8mRdBoWxm6t8ng9SEbLh/54rm
66bawXjPbik8XvYvVhmHmLMQ2JtBQtUQmWgchcyXGWfaHm0hujcWcPzWAyJtZVXk
u5F2R2ThjO6eE0U5PnBpNULpQ57iSRW6xBwLehMhTG7cBvSNg9r0fgkedMApNHj2
lk1zGyhh5GfmQUqEpQ/kKIBG3JJs0cqvV1T7KIXkOWw73Ki09TDj169CAeW6GfdG
L3cMmOOs2SxoPY/eAaCge7Nc5RzdITEK6CUQe72YyqOLkda1iGXRCkyg6tGyrGb/
ZvkXZoRPVDzw/ZwbtUd19s1UiPFFRyH65MFnZNokSRih726xiLqSrF789WRvXm9I
GCyUFta57UzHPUo3rjUUVDfxHQBtRW//s1erO5uw66g/KyjSTYI=
=yFxf
-----END PGP SIGNATURE-----

--Sig_/=77zqe27yUYwq.aWi2HATI+--
