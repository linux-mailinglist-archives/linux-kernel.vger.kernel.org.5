Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C827CC310
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343663AbjJQMY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbjJQMYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:24:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040A2187;
        Tue, 17 Oct 2023 05:22:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4B9C433C7;
        Tue, 17 Oct 2023 12:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697545339;
        bh=M00BvJirBo+mdXAXAKpgHd3oBO/bTMkIYD3+l9Xy8oM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ChBlyKPGb8GCIp6eNUPF1XPPHZDj+fZR2GBHysrDUsb+1Z6bkoZoFbdSbIHUj/Axb
         G9uP/YC/uMpzye2GvXDv4vsM8xsLaep8qtOtxb28+RCtAepaErNujCbQ+axyfH+R99
         TARpH7IDgm+A6+h9oEzmr/bTzz/CUaiWvRvC86vPsbRQIYFV672t3PZGhIIO+aim14
         Uf4JB8j3QNy4VHbriNlbOz8KgHDQAY3rkrnDbQShv6tI7Y+oKIkFGzA88ujq7OmEPA
         1LYH2UhYJg1lIr5iEtbWk/1OwblE8PBhyHIIN8rMlUp0W7ZBmaZjDd6aJ+rrMU2ERa
         6QBdStzt0FfVg==
Date:   Tue, 17 Oct 2023 13:22:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        linux-stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: selftests: ftrace: Internal error: Oops: sve_save_state
Message-ID: <ad5b7442-385d-41db-9202-a36414460610@sirena.org.uk>
References: <CA+G9fYtEGe_DhY2Ms7+L7NKsLYUomGsgqpdBj+QwDLeSg=JhGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="apekHljeOM9+sOYc"
Content-Disposition: inline
In-Reply-To: <CA+G9fYtEGe_DhY2Ms7+L7NKsLYUomGsgqpdBj+QwDLeSg=JhGg@mail.gmail.com>
X-Cookie: Santa Claus is watching!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--apekHljeOM9+sOYc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 17, 2023 at 01:34:18PM +0530, Naresh Kamboju wrote:

> Following kernel crash noticed while running selftests: ftrace:
> ftracetest-ktap on FVP models running stable-rc 6.5.8-rc2.

> This is not an easy to reproduce issue and not seen on mainline and next.
> We are investigating this report.

To confirm have you seen this on other stables as well or is this only
v6.5?  For how long have you been seeing this?

> [  764.987161] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000000

> [  765.074221] Call trace:
> [  765.075045]  sve_save_state+0x4/0xf0
> [  765.076138]  fpsimd_thread_switch+0x2c/0xe8
> [  765.077305]  __switch_to+0x20/0x158
> [  765.078384]  __schedule+0x2cc/0xb38
> [  765.079464]  preempt_schedule_irq+0x44/0xa8
> [  765.080633]  el1_interrupt+0x4c/0x68
> [  765.081691]  el1h_64_irq_handler+0x18/0x28
> [  765.082829]  el1h_64_irq+0x64/0x68
> [  765.083874]  ftrace_return_to_handler+0x98/0x158
> [  765.085090]  return_to_handler+0x20/0x48
> [  765.086205]  do_sve_acc+0x64/0x128
> [  765.087272]  el0_sve_acc+0x3c/0xa0
> [  765.088356]  el0t_64_sync_handler+0x114/0x130
> [  765.089524]  el0t_64_sync+0x190/0x198

So something managed to get flagged as having SVE state without having
the backing storage allocated.  We *were* preempted in the SVE access
handler which does the allocation but I can't see the path that would
trigger that since we allocate the state before setting TIF_SVE.  It's
possible the compiler did something funky, a decode of the backtrace
might help show that?

--apekHljeOM9+sOYc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUufHUACgkQJNaLcl1U
h9Du4gf/RwBqZmgxZTFG61U5ZuvEedd7Ncv9OG5UjPNGuBlLM1KDg+t5xj5Zl+en
LShQ6Hzccz4mxRfADxNIrWt4P+hEkgFvgSlmJvAZBJSc8LJm4OP/hiDD1Bx3Qikq
W3nSjSa+uLW02+wF2zw2hJPK+8qv+09HFyb5bBOWavLRu45N4kzLjE3/NrDLR2vK
j98xD+9RNYw4uUGZEy0CFqBeHTV+YOlOnH8IUOrDIzycKn17npDUIygiL3lMD8RH
J+VyRqniWlGDkglCesuJdXMZSXTRx+YJQTExTJKvFyQiomdXjs5BMcxBtx8Ldec2
GM5ENkf0jVDClVZOWMsGBNV/zV0/rw==
=oZtp
-----END PGP SIGNATURE-----

--apekHljeOM9+sOYc--
