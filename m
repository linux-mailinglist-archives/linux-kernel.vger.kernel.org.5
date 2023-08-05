Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27B377104E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 17:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjHEPB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 11:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHEPBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 11:01:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4781C83;
        Sat,  5 Aug 2023 08:01:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D958060B58;
        Sat,  5 Aug 2023 15:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAEDC433C7;
        Sat,  5 Aug 2023 15:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691247683;
        bh=iqhG8zGnNgHzhhKVF57pGLW7oa5B2TIRYJfd06foZsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P8fUHnO6NtIYmR+u9iacqVv2PiVwUn9y7CbG1l1BvcoL9uBRBCusmvcTaC5YTtNOn
         oaDLciEJoNTzX0aI+vX16OtUdwTWYq5u0qJF1ACTMogexmJBbQpM1FpOMKMIKwwSe8
         RmY1rf978zigt1XWRX3iZBF3Z1kJlPtCR6yMlmEIblhk98d1AhT4lHE1RocYNy/scZ
         Rl8M9cWh3lwCkNqcXMSF4xsyiyl9IAzKxJJSRHvku28nzItZe//MYZixRrIF/60u7a
         47Vm0Ue4kJjHsr0vVMhL4nYQW2/B3uPC1RL9kbbxJXFZ5wYyd2szPX0kFsolsLIPvx
         NCYY2VQ5AXa5A==
Date:   Sat, 5 Aug 2023 16:01:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     coolrrsh@gmail.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] fixes warning
Message-ID: <ZM5kQPFLx/uTRq5z@finisterre.sirena.org.uk>
References: <20230804200711.65750-1-coolrrsh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EYufw1NlEPPk6xU4"
Content-Disposition: inline
In-Reply-To: <20230804200711.65750-1-coolrrsh@gmail.com>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EYufw1NlEPPk6xU4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 05, 2023 at 01:37:10AM +0530, coolrrsh@gmail.com wrote:

> Typecasting the interrupt number from "unsigned int" to "signed int" to compare with 0(signed int by default).
> Declaring interrupt number as "signed int" would violate kernel standards. So typecasting is the possible approach.

Why would it violate kernel standards?

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--EYufw1NlEPPk6xU4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTOZD8ACgkQJNaLcl1U
h9BmHgf8CEAFiUgsAeNYJEC3VIeduqopElmrsctoybd2GEGTBydlWEPVwpAJSst8
NFEQbJL+/bquNjFbwEz5Tavq9G5XvqRHaPiyg7qUrr4TuSD92poX+yjzjtWvhSp8
0u4/FMa/b0Y+VcXMSduGtbrjuKudXUMbauzAuLcetATRwTldXhhWdSwTW6zJdlcx
T9nJd3v0XyuNjzcQP26U+gJJdj0TDlboPX4YTroxg5mQPM7UX2QoSxVa/6SqZERb
1WfdlHF37IrisajIUOi4RR3TpAb81LsW38MOVAd4a0yNos6luIZA/qHUjibTSDci
lCSl2RnvkZThEyuEnFfvlTsqdOJVCQ==
=kOe8
-----END PGP SIGNATURE-----

--EYufw1NlEPPk6xU4--
