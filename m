Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3E97BA12B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbjJEOmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjJEOhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:37:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E29F497A3;
        Thu,  5 Oct 2023 07:02:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08F8C3278E;
        Thu,  5 Oct 2023 11:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696505644;
        bh=uQCzM5xbAuZl+/32wrxwrBNmw+5LgwY7U9nc7LghN6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X0ft9yf36AQug4BLX5o8ln8sDmEA79VOqDZe1B3WKxylc0cjhwD8VeW/T9iPtoGN0
         aP0r2Oy/ylZS+cNPV1HR+qwnj/Chq/JeYm33JfbMbvVxVu1cf/4uRTtLegDwib7EvM
         66UeHSDD8BQgPGvA9cIE0qDRNj3Wl9poy06t6FFzv4DKh+4JbaA+ZlHB25E5Ed30y/
         yFlf5KpW/RJJ2PhS0BvyvLR2aD0KsWoSQQiSWqcpkcqhmhGA4LprVP+gkCI1aQa/A/
         kIMezW0l6WM+lk8PiTiLJrQuQvKmPGPKqrER+QXnmROlFg9xMZ6CZI4Xqpa2CO71N7
         vfUF4l1FEcl+A==
Date:   Thu, 5 Oct 2023 13:34:01 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Benedikt Spranger <b.spranger@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH 1/1] clk: socfpga: gate: Fix of by factor 2 for serial
 console
Message-ID: <qpskbgigcaoyjuhzeguz366cjukv3ij7utlbkra5edhwn6uzh4@bdedm6vs62y5>
References: <20231005095927.12398-1-b.spranger@linutronix.de>
 <20231005095927.12398-2-b.spranger@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="prvu7vztqw3jsd37"
Content-Disposition: inline
In-Reply-To: <20231005095927.12398-2-b.spranger@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--prvu7vztqw3jsd37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Oct 05, 2023 at 11:59:27AM +0200, Benedikt Spranger wrote:
> Commit 9607beb917df ("clk: socfpga: gate: Add a determine_rate hook")
> introduce a specific determine_rate hook. As a result the calculated
> clock for the serial IP is off by factor 2 after that i.e. if the system
> configures a baudrate of 115200 it is set physicaly to 57600.

Where is that factor 2 coming from?

> Change the determine_rate hook to the reparent variant
> __clk_mux_determine_rate() to fix the issue.

It's also not clear to me why that would fix anything. This patch should
only make the old behaviour explicit, could you expand a bit on what
happens?

Thanks!
Maxime

--prvu7vztqw3jsd37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZR6fKQAKCRDj7w1vZxhR
xWkXAP944YltL6lQ6PADz9Gi/tzH2kaECDaV1ZlxH1ROb0heXAD9FYCgSiGiA8Ol
Q96Bcx34HvhWVd152+c2DCv2VNyF3gw=
=G/z2
-----END PGP SIGNATURE-----

--prvu7vztqw3jsd37--
