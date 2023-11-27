Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A5D7F9DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjK0Khs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjK0Khp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:37:45 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EED18E;
        Mon, 27 Nov 2023 02:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701081471; x=1732617471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+/K/TBwFkECz7aLxzE8hjx15xz33xVUqkjmbFTjpyh0=;
  b=lUJnbHA2VNVyMWTwbNDEUjzbu7mYPKXbUjMUBq8y/mXRYppdTPEGH1nX
   xakVgfPl3H7QmtCqixpWAgRk35GeAF2XlrCrLb1ttHg3+lDFTmxDngfH8
   t1rhsTGAVjobrT+Xl8Uv4d4lfxoS+5yET5MrhJ8Ke11/a0O9OIm8qkEh9
   p6MGLMM7R8uWhYt4TsbkdVW1TF4ssj3DDlFMiBaaG09EmDmGD4zwm+fts
   hK2FZJ8F1arFOLd60bpUCQ0eWdV8z31iAVT0WGjx+RklLIg4BUx6pPzrb
   GkO2vW5bQNN8kBRd3AbGyqhRL2iKFVKc+cEycNb4ri5aYYVSaJHqRxeJQ
   A==;
X-CSE-ConnectionGUID: xOAyVbUwTMO+uJD9UgwqaQ==
X-CSE-MsgGUID: 18YxV9ktRHWC/RgNDyCApQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="asc'?scan'208";a="12327336"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Nov 2023 03:37:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Nov 2023 03:37:17 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 27 Nov 2023 03:37:13 -0700
Date:   Mon, 27 Nov 2023 10:36:44 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Christoph Muellner <christoph.muellner@vrull.eu>
CC:     <linux-riscv@lists.infradead.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Daniel Lustig <dlustig@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 0/5] RISC-V: Add dynamic TSO support
Message-ID: <20231127-process-dinginess-cea6dd652b99@wendy>
References: <20231124072142.2786653-1-christoph.muellner@vrull.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kbT7YkFzL4BHVstF"
Content-Disposition: inline
In-Reply-To: <20231124072142.2786653-1-christoph.muellner@vrull.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--kbT7YkFzL4BHVstF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 24, 2023 at 08:21:37AM +0100, Christoph Muellner wrote:
> From: Christoph M=FCllner <christoph.muellner@vrull.eu>
>=20
> The upcoming RISC-V Ssdtso specification introduces a bit in the senvcfg
> CSR to switch the memory consistency model at run-time from RVWMO to TSO
> (and back). The active consistency model can therefore be switched on a
> per-hart base and managed by the kernel on a per-process/thread base.
>=20
> This patch implements basic Ssdtso support and adds a prctl API on top
> so that user-space processes can switch to a stronger memory consistency
> model (than the kernel was written for) at run-time.
>=20
> I am not sure if other architectures support switching the memory
> consistency model at run-time, but designing the prctl API in an
> arch-independent way allows reusing it in the future.
>=20
> The patchset also comes with a short documentation of the prctl API.
>=20
> This series is based on the second draft of the Ssdtso specification
> which was published recently on an RVI list:
>   https://lists.riscv.org/g/tech-arch-review/message/183
> Note, that the Ssdtso specification is in development state
> (i.e., not frozen or even ratified) which is also the reason
> why I marked the series as RFC.
>=20
> One aspect that is not covered in this patchset is virtualization.
> It is planned to add virtualization support in a later version.
> Hints/suggestions on how to implement this part are very much
> appreciated.
>=20
> Christoph M=FCllner (5):

I know this is an RFC, but it could probably do with a bit more compile
testing, as:

>   RISC-V: Add basic Ssdtso support

This patch doesn't build for rv64 allmodconfig

>   RISC-V: Expose Ssdtso via hwprobe API

This one seems to build fine

>   uapi: prctl: Add new prctl call to set/get the memory consistency
>     model
>   RISC-V: Implement prctl call to set/get the memory consistency model
>   RISC-V: selftests: Add DTSO tests

These don't build for:
rv32 defconfig
rv64 allmodconfig
rv64 nommu

Cheers,
Conor.

--kbT7YkFzL4BHVstF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWRxPAAKCRB4tDGHoIJi
0lTTAP9C2gVptHYxg1wEQyIceVB2NvjKokFBaZX4p4k/YXZz7gD+MoMtrN7h6uWY
3jfYLulJnUx7qvF2seA9F7dMnismKQw=
=roRE
-----END PGP SIGNATURE-----

--kbT7YkFzL4BHVstF--
