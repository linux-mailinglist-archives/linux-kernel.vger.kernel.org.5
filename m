Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D737D0077
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344662AbjJSR0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbjJSR0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:26:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C769121;
        Thu, 19 Oct 2023 10:26:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFECC433C7;
        Thu, 19 Oct 2023 17:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697736362;
        bh=/J42OJz/m4JssABU0PHxiY5WHQdR1dNuC3Q+fS5/q/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TTME+U2ktt5ekzBM7omJH7O9PviDypyYxCXachTofiUTcnOiPgOK8jXFjQDN38BWZ
         Y5NGRemjNHfPFZL3VDeajdlsReSsBFbLl+n47ZePh6hmq/A3pu2hgWo+qNhG1eTQA6
         On9KM+iX6raYbthJVmXGBbCLTKHJ9uhUhTC6l932d7DWZedqYGnSHM+3sVYQjToiu3
         fEQdNkM4u216jSwBOtBuws72vuKMPu4yRGKH1vuoD8jNKddsExYiUTZTGUVyM4C8iE
         UzNEQGKKu37VIDD8vnNvm0hsHZHPZ+3/w9uCn190m+OQ1z07TT34q0DkRakjKwtQ70
         hHw966y4oWB/w==
Date:   Thu, 19 Oct 2023 18:25:57 +0100
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
Message-ID: <63e92a6a-9cb7-4272-b524-ccaf997aceb3@sirena.org.uk>
References: <CA+G9fYtEGe_DhY2Ms7+L7NKsLYUomGsgqpdBj+QwDLeSg=JhGg@mail.gmail.com>
 <ad5b7442-385d-41db-9202-a36414460610@sirena.org.uk>
 <CA+G9fYsbwWpDVR9KJXx8UO5MXsYT81uAJbLLNDnLianr8jmXUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XQgGVm+hP+sVy+eK"
Content-Disposition: inline
In-Reply-To: <CA+G9fYsbwWpDVR9KJXx8UO5MXsYT81uAJbLLNDnLianr8jmXUA@mail.gmail.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XQgGVm+hP+sVy+eK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 19, 2023 at 09:07:02PM +0530, Naresh Kamboju wrote:
> On Tue, 17 Oct 2023 at 17:52, Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Oct 17, 2023 at 01:34:18PM +0530, Naresh Kamboju wrote:

> > > Following kernel crash noticed while running selftests: ftrace:
> > > ftracetest-ktap on FVP models running stable-rc 6.5.8-rc2.

> > > This is not an easy to reproduce issue and not seen on mainline and next.
> > > We are investigating this report.

> > To confirm have you seen this on other stables as well or is this only
> > v6.5?  For how long have you been seeing this?

> This is only seen on 6.5.8-rc2 and seen only once.
> I have checked on mainline / next and other stable branches and this crash
> is not seen anywhere else.

> However, I will keep checking them on other branches and next and mainline.

I see.  If the bug has never been reproduced I don't think we can draw
any conclusion about which branches are affected, I would be a bit
surprised by something that affects v6.5 only.

--XQgGVm+hP+sVy+eK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUxZqQACgkQJNaLcl1U
h9B1JQf/eQ3pYEhLsNgoaHLZVS2OZ4MY/xkeyCWThH+8Y0Di9nsZGFgZip2o5UuT
aAebOYkPn8k/vwbN/szOCKN5weclhEB3k8PaMFLygIZMtMmlTdxWGIzQ8E+Lk+hy
V3Kvmoivi76B6n68BmrCxDf1ckOIOrwGBT5XzPaOlnql+hWBPqxdDQcQjcaFijrl
B9nEF3UAppklAIcwAfbJa8yacg+cmQKaNlvubWiCIZZEmypB3NbExcILrzMFu0Oi
HdCR4NmJoBCS42E6EZQokT27sUd8+uTARf7VHDWTNLfzzT+RNazqfdAJdwUkAcjc
Ghx3I344e58DegzJAH+B376JDUUcNw==
=vJwK
-----END PGP SIGNATURE-----

--XQgGVm+hP+sVy+eK--
