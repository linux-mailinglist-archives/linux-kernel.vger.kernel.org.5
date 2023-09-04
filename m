Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A8C79170C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352945AbjIDMYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjIDMYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:24:45 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF2ECD0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 05:24:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1169BCE0E24
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 12:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AC0C433C7;
        Mon,  4 Sep 2023 12:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693830276;
        bh=36uQxV6i32YBR1ng/PKsa+GWt+oC3I97h3TnjuBDTDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GV3oMf3/LEaeUc9J5b/8Wc4h3fgAeh1Qv6zZpk4l8nGqWuXA6S7T7kLKoag+2z5aO
         RXnbr7ZVYFrGQHv+i4w/bKaKVWscfT8Vyphf8G6wcDkzKd4iRAA/YNmpvsE+hDGVoy
         lkRdyhiZeof+1Z7ObQz1Vl45wlhzVMYiit82UN6Ww4fxNx9DiQyMIZk9TFmY42naLB
         MeIzufIX46TT91AS0ac29UQkX2T+gbl48aajh3hHCTbJsJUuLA/tEwzVawlw5ZVnBw
         8+ITtr3sH/dYrfvQKBKD8THhzzPl05rkvXiRl4l6zAKBa63pNSXMdUBUA9wbbGTIgI
         MxJu8DC6qXIcg==
Date:   Mon, 4 Sep 2023 13:24:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Documentation: ABI: sysfs-driver-regulator-output
Message-ID: <763bd845-d8d6-489c-bd31-305ed14bc40f@sirena.org.uk>
References: <20230831121412.2359239-1-Naresh.Solanki@9elements.com>
 <20230831121412.2359239-3-Naresh.Solanki@9elements.com>
 <90b1af83-cb03-476f-9147-eb06247bf09c@hatter.bewilderbeest.net>
 <2023090330-bling-mammary-3177@gregkh>
 <6eb78818-7838-4616-bf44-05c215bfa8b3@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VRC3njrjHYwW/9xs"
Content-Disposition: inline
In-Reply-To: <6eb78818-7838-4616-bf44-05c215bfa8b3@hatter.bewilderbeest.net>
X-Cookie: Immanuel doesn't pun, he Kant.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VRC3njrjHYwW/9xs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 03, 2023 at 05:48:14PM -0700, Zev Weiss wrote:
> On Sun, Sep 03, 2023 at 06:04:23AM PDT, Greg Kroah-Hartman wrote:

> > But yes, reading a sysfs should almost never cause a side affect at all.

> > But what do you mean by "clear events?"

> I mean that when the sysfs file is read, the state variable whose value it
> exposes is also cleared as a side-effect (so the read operation "consumes"
> the value it returns) -- see the implementation in patch 2 of this series
> (specifically the 'data->events = 0' assignment in events_show()):

It's a clear on read interrupt.

--VRC3njrjHYwW/9xs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT1zH8ACgkQJNaLcl1U
h9A+qwf/XyC0qxIrcGdWPRnXbZFcNY5jKYyA+JrkGJd+hBuAU54gQxUH9z2BtdMF
pf4brPyNE/Az+EtB74MwgcltY7hz2A6xfQDY2/aw4OgzdFjEL+AUaDGiGtRKeQoj
qb1YJjI/GrhSB/Nancn/tG+C+XqGcVYeCguhaWHpOX4xwFCLE6O9babrr9D4KHHA
kkJVUBn/Z4z87b8QE3McgKtSdBFuPc+B8fJrIFj3aNgxwc/DirJRFh1y0Mv/0sGU
6s8amnJmajSEo8tK9uhMEsrwiZY3izdBIOp7RWkjG4xprG4rPjAVndhkvV2aJ+Dx
YDJrcpuU6vxKxfstOZ4rq1iQ5k1tfQ==
=8HSs
-----END PGP SIGNATURE-----

--VRC3njrjHYwW/9xs--
