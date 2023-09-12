Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F266879D30E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbjILOAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjILOAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:00:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BEC10D0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:00:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC12C433C7;
        Tue, 12 Sep 2023 14:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694527248;
        bh=qcTgHv4vvgwsNN/MB4KHhVuxFetewAGPy7pjXcu6ytQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gRbvXgv4ad7gEXh7UHIrvtRNTUo8SxljSTWsNf0mmU1kZLVtN7yEKgn+m7wC00G6x
         z2hv7ONuBULPMEvYs2Z94+kIbNLZlItjJMynq5rMuphNAe0s2J35KW8y005hm357UQ
         k0uAKYJIvThOjZKbRUAsu0jQJSOH/trGiKV9IPXJIAYbByFOofzQP7I69hr3mowRGO
         PU+u4ET8WA5OCfAjuqBKsR1MwLKKfzxsWx2RKyPE8uOkIGkV++FvKoaf+XOljJzWFX
         fMAHXnsELW2dRo5YdIw6CKv4RLsf8amui6qf6jaWuOdwdMs6h6bpRIGgtWx0nMaUv6
         4LDrtgbloMInA==
Date:   Tue, 12 Sep 2023 15:00:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Documentation: ABI: sysfs-driver-regulator-output
Message-ID: <9630368c-fb8a-4e7e-85a6-e7f946a3b551@sirena.org.uk>
References: <20230831121412.2359239-1-Naresh.Solanki@9elements.com>
 <20230831121412.2359239-3-Naresh.Solanki@9elements.com>
 <90b1af83-cb03-476f-9147-eb06247bf09c@hatter.bewilderbeest.net>
 <2023090330-bling-mammary-3177@gregkh>
 <6eb78818-7838-4616-bf44-05c215bfa8b3@hatter.bewilderbeest.net>
 <763bd845-d8d6-489c-bd31-305ed14bc40f@sirena.org.uk>
 <1518370c-e0cd-4d78-af54-3e2cf4dd6e3c@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s9HYcCZ5CrYV+NYM"
Content-Disposition: inline
In-Reply-To: <1518370c-e0cd-4d78-af54-3e2cf4dd6e3c@hatter.bewilderbeest.net>
X-Cookie: Victory uber allies!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s9HYcCZ5CrYV+NYM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 10, 2023 at 01:50:37PM -0700, Zev Weiss wrote:
> On Mon, Sep 04, 2023 at 05:24:31AM PDT, Mark Brown wrote:

> > It's a clear on read interrupt.

> Sure, analogous behavior in hardware is reasonably common, but that doesn't
> strike me as a very compelling reason to design the kernel<->userspace
> interface to mimic it -- providing nicer interfaces than the raw hardware is
> one of the main reasons for having an OS in the first place, after all.

If it were something other than the userspace consumer I'd be more
worried, with this interface it's all sharp edges on a very embedded
system so it's a bit less concerning.  In any case the obvious fix here
is to use clear on read.

--s9HYcCZ5CrYV+NYM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUAbugACgkQJNaLcl1U
h9AbbAf/f0Jc4Y0IRRwz6Gtrl2qkftwDtrhJy3ff7npvP54qpIC+LwRYT4iiPktx
DltJQfJ9zMgOjmSRJ8QoG1L2Z6LiY7ChR5c1vKPo74GEpKaTI0HzLQ5kIRonNGFf
qS8Qmd+RVNEt0WkOAFRaeBX/B1UlHUF6PIMCBsFwh619j+TuKlEtgw8KsXtc4WEP
ifoS3KLLvCCbf6KIPaqgYkH4fK1w8fgT8QFvWUA4xriIAgE8jVMMzHhOE8yf0QwF
nZApmX+HjKjHwKuCqYJyGJFImhhti0BBf33QpQ4+WPlSiDB7qXDiqt6ls+GhkQmQ
VE2cHUdUOFY0udHnclxWCTn1Lz1RKg==
=IYbW
-----END PGP SIGNATURE-----

--s9HYcCZ5CrYV+NYM--
