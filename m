Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A292A79D322
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbjILOD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbjILOD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:03:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B9810D1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:03:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F64C433CA;
        Tue, 12 Sep 2023 14:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694527432;
        bh=iv1RRfqUrKL45Fuy4iJuRqIdC+oN6KFnfVcwYKj76AA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sHMuZ7SZZj9b+JuBYgSlTHJ7vYmV920/jlQWuLbyf8ihWpE9Y1EQFiBVOM/FGDO9q
         CDgTuYdLW9/fvlRQN05siCMCX7gyAYWwsjTa+q/8mOZ9yso2jZzSdmxWGfEzCPTIBW
         1eyYWZWITLqbyzu2Tz15NbnqxYdgFU78KyQbbcdvr6Yxd1kTsEYQ4SOXk6fy1J+anJ
         xI2GnBZCh+wGt8UudKlBORVxOlY5Us3QqSEdgGFsqw5zBIN4y0BZu/3VielsgmkILO
         R6MPx9/K2ag0u70sLjHoYbqFq3KJuoWrS4/81q2PRAMrskDYMVXt2n1OYqrt95hVLc
         2jLx4BqCQXBlw==
Date:   Tue, 12 Sep 2023 15:03:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Documentation: ABI: sysfs-driver-regulator-output
Message-ID: <5282acd1-3c7a-4948-83f2-2829910ab841@sirena.org.uk>
References: <20230831121412.2359239-1-Naresh.Solanki@9elements.com>
 <20230831121412.2359239-3-Naresh.Solanki@9elements.com>
 <90b1af83-cb03-476f-9147-eb06247bf09c@hatter.bewilderbeest.net>
 <2023090330-bling-mammary-3177@gregkh>
 <6eb78818-7838-4616-bf44-05c215bfa8b3@hatter.bewilderbeest.net>
 <763bd845-d8d6-489c-bd31-305ed14bc40f@sirena.org.uk>
 <1518370c-e0cd-4d78-af54-3e2cf4dd6e3c@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ck50yuDXkmXpnCQ4"
Content-Disposition: inline
In-Reply-To: <1518370c-e0cd-4d78-af54-3e2cf4dd6e3c@hatter.bewilderbeest.net>
X-Cookie: Mickey Mouse wears a Spiro Agnew watch.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ck50yuDXkmXpnCQ4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 10, 2023 at 01:50:37PM -0700, Zev Weiss wrote:
> On Mon, Sep 04, 2023 at 05:24:31AM PDT, Mark Brown wrote:

> > It's a clear on read interrupt.

> Sure, analogous behavior in hardware is reasonably common, but that doesn't
> strike me as a very compelling reason to design the kernel<->userspace
> interface to mimic it -- providing nicer interfaces than the raw hardware is
> one of the main reasons for having an OS in the first place, after all.

If it were something other than the userspace consumer I'd be a bit more
concerned but that's all sharp edges and direct access in a very
controlled system.  In any case clear on write is the obvious
alternative approach.

--Ck50yuDXkmXpnCQ4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUAb8IACgkQJNaLcl1U
h9A0MQf/WnLw6v7Inm+c/fZmfvSqAkdYFJ4sSwP7K7EObGHYIfYnMR0STz/UPcRO
0U0QTitBjAueSyBtrJvizhk01AsB2NlQ1TtXpP8vWK9vJ8CYhf27KcQReU1WA+kZ
xd+1i3n9MI868Yj5kuReomPK+GKVOejNl/xGZISwtKdhza3Lf3EowllKGyJHDTkC
OC2Yce92VSBTXDgYdT1m6QHoKFc3pvZdwvRzIeRJ55SVYufmh85qENHoeTu//PHf
jtB7e3WBI3KiVN/HFPLL/bQ81CG9QNq6HnXpSqBHZ/eowuK6W2gG85GMAzzbNt6C
DQgRu5AVZK3I6vgc6aGwDuEzeXUrfw==
=pf5T
-----END PGP SIGNATURE-----

--Ck50yuDXkmXpnCQ4--
