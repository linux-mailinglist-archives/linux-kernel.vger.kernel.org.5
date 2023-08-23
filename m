Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE77E785B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbjHWPLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbjHWPLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:11:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C823FB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:11:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0C9D643B3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 15:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2244C433C7;
        Wed, 23 Aug 2023 15:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692803500;
        bh=reOKEkyFdGIcUzaWuCyzSSl6cFIUdChIMhChv8tbqE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mzb28xFtbffpeZb0crXaBj3ZUuYc/wxMm2QV2BXG2wX1+yFI+U/HIMBfiSw6x1AJR
         xkyG3u+SifrB/wuu8xdIiIcQp01FU2wCrk/W5bsBCYKCPE6hwxb5z8qP7jC9nwFE42
         ssCOKdP+NqGc1Fz0jOSdF2s+4BZ2BIOZL3WTZkiOGK6pjMxT6ol0MURTLcFvO7vPNG
         5J+JCx7jkG74UwmWF23IWmTk+odvSHMDlqmKHAWD4SZxVwmUlfNrlNzagImqfvcEFO
         yQ/8gN0UhLjnV0HCx/8WpdpoxUbEkWsRns7KnsJyus4qSxtJZth1rnwOG74zpJzzje
         gtKpQvVXz7ymw==
Date:   Wed, 23 Aug 2023 16:11:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, zev@bewilderbeest.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: userspace-consumer: Use atomic operation
Message-ID: <61279ff7-c1ad-446c-aa5e-4222a5cbd9fb@sirena.org.uk>
References: <20230823141558.957526-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x9LyeXqenu2rpq1r"
Content-Disposition: inline
In-Reply-To: <20230823141558.957526-1-Naresh.Solanki@9elements.com>
X-Cookie: Some optional equipment shown.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x9LyeXqenu2rpq1r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 23, 2023 at 04:15:57PM +0200, Naresh Solanki wrote:
> Replace mutexes with atomic operations.

Why?  Generally atomics are more complicated and hard to understand and
get right.

--x9LyeXqenu2rpq1r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTmIaYACgkQJNaLcl1U
h9DodggAhC6INvyQIjuR6Q6NB0M0E2nb+xOdSrpeO7vkC07NloJt3MfwXUZ5W0UX
QYsERtBRR45fzOsho5cYV/MOF4eifq3/Swt73geO/TXWk5IK7dMArREoycRVQOO9
SzaqWCIN1Jj83dYroJJIzleZ+qFc+CdLAI8zY6l0gpNmANKBy7EO/4aPSe+rgJtS
80GyBY2kiEyXKCODBuwX/3oBs+/HFTuZYr0FZk33qtTQTuacCenGWBpScqnqH2dC
xlse+TpTBkFUQEgmFkhEROOK2qqviI4IVrsDZRhqIXlVlLm9AUA6wAm/sbr8fG+1
bQvnjTUZuNOJ9FCKXlQtJJUqOthAsQ==
=amRw
-----END PGP SIGNATURE-----

--x9LyeXqenu2rpq1r--
